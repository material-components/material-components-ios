// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCFlexibleHeaderView.h"

#import "MDCFlexibleHeaderView+ShiftBehavior.h"
#import "MaterialApplication.h"
#import "MaterialUIMetrics.h"
#import "private/MDCFlexibleHeaderMinMaxHeight.h"
#import "private/MDCFlexibleHeaderTopSafeArea.h"
#import "private/MDCFlexibleHeaderView+Private.h"
#import "private/MDCStatusBarShifter.h"

#if TARGET_IPHONE_SIMULATOR
float UIAnimationDragCoefficient(void);  // Private API for simulator animation speed
#endif

// The maximum default opacity of the shadow.
static const float kDefaultVisibleShadowOpacity = (float)0.4;

// The percentage shifted threshold at which point the _viewsToHideWhenShifted should be fully
// hidden.
static const float kContentHidingThreshold = (float)0.5;

// This length defines the moment at which the shadow will be fully visible as the header shifts
// on-screen.
static const CGFloat kShadowScaleLength = 8;

// Duration of the UIKit animation that occurs when changing the tracking scroll view.
static const NSTimeInterval kTrackingScrollViewDidChangeAnimationDuration = 0.2;

// The epsilon used to determine when we've arrived at the destination while shifting the header
// on/off-screen with the display link.
static const float kShiftEpsilon = (float)0.1;

// The epsilon used when comparing height values.
static const CGFloat kHeightEpsilon = (CGFloat)0.001;

// The epsilon used when comparing content offset values.
static const CGFloat kContentOffsetEpsilon = (CGFloat)0.001;

// The minimum delta y before we change the scroll direction.
static const CGFloat kDeltaYSlop = 5;

// Affects how fast the header shifts on/off-screen while animating. Bigger value = faster.
static const CGFloat kAttachmentCoefficient = 12;

// The amount the user needs to scroll back before the header starts shifting back on-screen.
static const CGFloat kMaxAnchorLengthFullSwipe = 175;
static const CGFloat kMaxAnchorLengthQuickSwipe = 25;

// The minimum proportion of the header that will cause it to slide back on screen when the scroll
// view finishes decelerating with the header partially shifted.
static const CGFloat kMinimumVisibleProportion = 0.25;

// KVO contexts
static char *const kKVOContextMDCFlexibleHeaderView = "kKVOContextMDCFlexibleHeaderView";

static inline MDCFlexibleHeaderShiftBehavior ShiftBehaviorForCurrentAppContext(
    MDCFlexibleHeaderShiftBehavior intendedShiftBehavior) {
  if ([[[NSBundle mainBundle] bundlePath] hasSuffix:@".appex"] &&
      intendedShiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar) {
    return MDCFlexibleHeaderShiftBehaviorEnabled;
  }
  return intendedShiftBehavior;
}

@interface MDCFlexibleHeaderView () <MDCStatusBarShifterDelegate,
                                     MDCFlexibleHeaderTopSafeAreaDelegate,
                                     MDCFlexibleHeaderMinMaxHeightDelegate>

// The intensity strength of the shadow being displayed under the flexible header. Use this property
// to check what the intensity of a custom shadow should be depending on a scroll position. Valid
// values range from 0 to 1. Where 0 is no shadow is visible and 1 is the shadow is fully visible.
@property(nonatomic, readonly) CGFloat shadowIntensity;

// Exposed via the FlexibleHeader+CanAlwaysExpandToMaximumHeight target.
@property(nonatomic) BOOL canAlwaysExpandToMaximumHeight;

// Extracted logic units
@property(nonatomic, strong) MDCFlexibleHeaderTopSafeArea *topSafeArea;
@property(nonatomic, strong) MDCFlexibleHeaderMinMaxHeight *minMaxHeight;

@end

// All injections into the content and scroll indicator insets are tracked here. It's super
// important that we track what we added, rather than trying to cache the original values, because
// we can't know if the insets have changed out from under us by another party.
//
// A separate info object is tracked for each scroll view tracked by the flexible header view.
@interface MDCFlexibleHeaderScrollViewInfo : NSObject

// UITableView, when added to a UIWindow for the first time, may automatically adjust
// its content offset to take into account the top safe area insets. While typically
// desirable, this behavior clashes with our own top safe area insets management resulting
// in the table view "jumping" when it first appears. To counter this behavior, we
// intentionally ignore the next content offset change if it looks like a safe area adjustment.
// See https://github.com/material-components/material-components-ios/issues/5412 for additional
// details.
@property(nonatomic) BOOL shouldIgnoreNextSafeAreaAdjustment;

// The amount injected into contentInsets.top
@property(nonatomic) CGFloat injectedTopContentInset;

// Whether or not we've injected the top content inset
@property(nonatomic) BOOL hasInjectedTopContentInset;

// The amount injected into scrollIndicatorInsets.top
@property(nonatomic) CGFloat injectedTopScrollIndicatorInset;

// When working with multiple tracking scroll views, this property keeps track of what the last
// header height for a given tracking scroll view was. When we return to a tracking scroll view,
// we're able to use this property to calculate any additional content offset shift that may be
// required in order to maintain a consistent physical placement within the content.
@property(nonatomic) CGFloat stashedHeight;
@property(nonatomic) BOOL stashedHeightIsValid;

@end

@implementation MDCFlexibleHeaderView {
  // We keep a weak reference to all forwarding views in case the client forgets to stop forwarding
  // events for a view that's been removed from the header view. If we held a strong reference here
  // then the removed view would never be deallocated.
  NSHashTable *_forwardingViews;  // [UIView]

  // Views that should be hidden during shifting. These views are kept as weak references.
  NSHashTable *_viewsToHideWhenShifted;  // [UIView]

  // A weak reference map of scroll views to info that have been tracked by this header view.
  NSMapTable *_trackedScrollViews;  // {UIScrollView:MDCFlexibleHeaderScrollViewInfo}
  MDCFlexibleHeaderScrollViewInfo *_trackingInfo;

  // The ideal visibility state of the header. This may not match the present visibility if the user
  // is interacting with the header or if we're presently animating it.
  BOOL _wantsToBeHidden;

  // Shift behavior state

  // Prevents delta calculations on first update pass.
  BOOL _shiftAccumulatorLastContentOffsetIsValid;
  // When the header can slide off-screen, a positive value indicates how off-screen the header is.
  // Essentially: view's top edge = -_shiftAccumulator
  // When canAlwaysExpandToMaximumHeight is enabled, a negative value indicates how expanded the
  // header is.
  // Essentially: view's height += -_shiftAccumulator
  CGFloat _shiftAccumulator;
  CGPoint _shiftAccumulatorLastContentOffset;  // Stores our last delta'd content offset.
  CGFloat _shiftAccumulatorDeltaY;
  CADisplayLink *_shiftAccumulatorDisplayLink;

  BOOL _interfaceOrientationIsChanging;
  BOOL _contentInsetsAreChanging;

  // When the user tosses the scroll view we enter a deceleration phase. This is always eventually
  // followed up by a call to trackingScrollViewDidEndDecelerating. See the
  // trackingScrollViewDidEndDecelerating for more details on this behavior.
  BOOL _didDecelerate;

  // _isChangingStatusBarVisibility documents whether we know that we're adjusting the status bar
  // visibility, while _wasStatusBarHidden allows us to detect whether someone else has adjusted
  // the status bar visibility. In either case, we need to counteract any content offsets
  // adjustments made by UIKit so that our header doesn't shrink/expand in reaction to the status
  // bar visibility changing.
  BOOL _isChangingStatusBarVisibility;
  BOOL _wasStatusBarHiddenIsValid;
  BOOL _wasStatusBarHidden;

  // UILayoutGuide was introduced in iOS 9, so in order to support iOS 8, we use a UIView as a
  // layout guide. Once we drop iOS 8 support this can be changed to a UILayoutGuide instead.
  UIView *_topSafeAreaGuide;

  MDCStatusBarShifter *_statusBarShifter;

  // Layers for header shadows.
  CALayer *_defaultShadowLayer;
  CALayer *_customShadowLayer;

  // The block executed when shadow intensity changes.
  MDCFlexibleHeaderShadowIntensityChangeBlock _shadowIntensityChangeBlock;

  Class _wkWebViewClass;

#if DEBUG
  // Keeps track of whether the client called ...WillEndDraggingWithVelocity:...
  BOOL _didAdjustTargetContentOffset;
#endif
}

// Owned by _topSafeArea
@dynamic topSafeAreaSourceViewController;
@dynamic inferTopSafeAreaInsetFromViewController;

// Owned by self.minMaxHeight
@dynamic minimumHeight;
@dynamic maximumHeight;
@dynamic minMaxHeightIncludesSafeArea;

// MDCFlexibleHeader properties
@synthesize trackingScrollViewIsBeingScrubbed = _trackingScrollViewIsBeingScrubbed;
@synthesize scrollPhase = _scrollPhase;
@synthesize scrollPhaseValue = _scrollPhaseValue;
@synthesize scrollPhasePercentage = _scrollPhasePercentage;

// MDCFlexibleHeaderConfiguration properties
@synthesize trackingScrollView = _trackingScrollView;

@synthesize canOverExtend = _canOverExtend;
@synthesize inFrontOfInfiniteContent = _inFrontOfInfiniteContent;
@synthesize sharedWithManyScrollViews = _sharedWithManyScrollViews;
@synthesize visibleShadowOpacity = _visibleShadowOpacity;

- (void)dealloc {
#if DEBUG
  [_trackingScrollView.panGestureRecognizer removeTarget:self
                                                  action:@selector(fhv_scrollViewDidPan:)];
#endif
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  if (self.observesTrackingScrollViewScrollEvents) {
    [self fhv_stopObservingContentOffset];
  }
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCFlexibleHeaderViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCFlexibleHeaderViewInit];
  }
  return self;
}

- (void)commonMDCFlexibleHeaderViewInit {
  _topSafeArea = [[MDCFlexibleHeaderTopSafeArea alloc] init];
  _topSafeArea.topSafeAreaDelegate = self;

  _minMaxHeight = [[MDCFlexibleHeaderMinMaxHeight alloc] initWithTopSafeArea:_topSafeArea];
  _minMaxHeight.delegate = self;

  _wkWebViewClass = NSClassFromString(@"WKWebView");

  _statusBarShifter = [[MDCStatusBarShifter alloc] init];
  _statusBarShifter.delegate = self;
  _statusBarShifter.enabled = [self fhv_shouldAllowShifting];

  NSPointerFunctionsOptions options =
      (NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality);
  _forwardingViews = [NSHashTable hashTableWithOptions:options];
  _viewsToHideWhenShifted = [NSHashTable hashTableWithOptions:options];

  NSPointerFunctionsOptions keyOptions =
      (NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality);
  NSPointerFunctionsOptions valueOptions =
      (NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPointerPersonality);
  _trackedScrollViews = [NSMapTable mapTableWithKeyOptions:keyOptions valueOptions:valueOptions];

  _headerContentImportance = MDCFlexibleHeaderContentImportanceDefault;
  _statusBarHintCanOverlapHeader = YES;

  _visibleShadowOpacity = kDefaultVisibleShadowOpacity;
  _canOverExtend = YES;

  _defaultShadowLayer = [CALayer layer];
  _defaultShadowLayer.shadowColor = [[UIColor blackColor] CGColor];
  _defaultShadowLayer.shadowOffset = CGSizeMake(0, 1);
  _defaultShadowLayer.shadowRadius = 4;
  _defaultShadowLayer.shadowOpacity = 0;
  _defaultShadowLayer.hidden = YES;
  [self.layer addSublayer:_defaultShadowLayer];

  // Allow for custom shadows to be used.
  _customShadowLayer = [CALayer layer];
  _customShadowLayer.hidden = YES;
  [self.layer addSublayer:_customShadowLayer];

  _topSafeAreaGuide = [[UIView alloc] init];
  _topSafeAreaGuide.frame = CGRectMake(0, 0, 0, [_topSafeArea topSafeAreaInset]);
  [self addSubview:_topSafeAreaGuide];

  _contentView = [[UIView alloc] initWithFrame:self.bounds];
  _contentView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [super addSubview:_contentView];

  if (![MDCFlexibleHeaderView appearance].backgroundColor) {
    self.backgroundColor = [UIColor lightGrayColor];
  }

  _defaultShadowLayer.backgroundColor = self.backgroundColor.CGColor;

  self.layer.shadowColor = [[UIColor blackColor] CGColor];
  self.layer.shadowOffset = CGSizeMake(0, 1);
  self.layer.shadowRadius = 4;
  self.layer.shadowOpacity = 0;

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(fhv_updateLayout)
                                               name:UIAccessibilityVoiceOverStatusChanged
                                             object:nil];
}

- (void)setVisibleShadowOpacity:(float)visibleShadowOpacity {
  _visibleShadowOpacity = visibleShadowOpacity;
  [self fhv_accumulatorDidChange];
}

- (void)fhv_setShadowLayer:(CALayer *)shadowLayer
    intensityDidChangeBlock:(MDCFlexibleHeaderShadowIntensityChangeBlock)block {
  _shadowIntensityChangeBlock = block;

  // If there is a custom shadow make sure the shadow on self.layer is not visible.
  self.layer.shadowOpacity = 0;
  CALayer *oldShadowLayer = _shadowLayer;
  if (shadowLayer == _shadowLayer) {
    return;
  }
  _shadowLayer = shadowLayer;
  [oldShadowLayer removeFromSuperlayer];
  if (shadowLayer) {
    // When a custom shadow is being used hide the default shadow.
    _defaultShadowLayer.hidden = YES;
    _customShadowLayer.hidden = NO;
    [_customShadowLayer addSublayer:_shadowLayer];
  } else {
    _defaultShadowLayer.hidden = NO;
    _customShadowLayer.hidden = YES;
    _shadowLayer = nil;
  }
}

- (void)setShadowLayer:(CALayer *)shadowLayer {
  [self fhv_setShadowLayer:shadowLayer intensityDidChangeBlock:nil];
}

- (void)setShadowLayer:(CALayer *)shadowLayer
    intensityDidChangeBlock:(MDCFlexibleHeaderShadowIntensityChangeBlock)block {
  [self fhv_setShadowLayer:shadowLayer intensityDidChangeBlock:block];
}

#pragma mark - UIView

- (CGSize)sizeThatFits:(CGSize)size {
  return CGSizeMake(size.width, self.minMaxHeight.minimumHeightWithTopSafeArea);
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self fhv_updateShadowPath];
  [CATransaction begin];
  BOOL disableActions = [CATransaction disableActions];
  [CATransaction setDisableActions:YES];
  _defaultShadowLayer.frame = self.bounds;
  _customShadowLayer.frame = self.bounds;
  _shadowLayer.frame = self.bounds;
  [CATransaction setDisableActions:disableActions];
  [CATransaction commit];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];

  if (newSuperview == self.trackingScrollView) {
    self.transform = CGAffineTransformMakeTranslation(0, self.trackingScrollView.contentOffset.y);
  }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
  [super willMoveToWindow:newWindow];

  _wasStatusBarHiddenIsValid = NO;
}

- (void)didMoveToWindow {
  [super didMoveToWindow];

  [_statusBarShifter didMoveToWindow];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *hitView = [super hitTest:point withEvent:event];

  // Forwards taps to the scroll view.
  if (hitView == self || (_contentView != nil && hitView == _contentView) ||
      [_forwardingViews containsObject:hitView]) {
    hitView = _trackingScrollView;
  }

  return hitView;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];

  if (!_interfaceOrientationIsChanging) {
    [self fhv_updateLayout];
  }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  [super setBackgroundColor:backgroundColor];

  // Update default shadow to match
  _defaultShadowLayer.backgroundColor = self.backgroundColor.CGColor;
}

- (void)safeAreaInsetsDidChange {
  if (@available(iOS 11.0, *)) {
    [super safeAreaInsetsDidChange];

    [_topSafeArea safeAreaInsetsDidChange];
  }
}

#pragma mark - Top Safe Area Inset

- (id)topSafeAreaGuide {
  return _topSafeAreaGuide;
}

- (CGFloat)topSafeAreaGuideHeight {
  return _topSafeAreaGuide.frame.size.height;
}

- (BOOL)trackingScrollViewIsWebKit {
  return [self.trackingScrollView.superview.class isSubclassOfClass:_wkWebViewClass];
}

#pragma mark - MDCFlexibleHeaderSafeAreas

- (void)setInferTopSafeAreaInsetFromViewController:(BOOL)inferTopSafeAreaInsetFromViewController {
  _topSafeArea.inferTopSafeAreaInsetFromViewController = inferTopSafeAreaInsetFromViewController;
}

- (BOOL)inferTopSafeAreaInsetFromViewController {
  return _topSafeArea.inferTopSafeAreaInsetFromViewController;
}

- (void)setTopSafeAreaSourceViewController:(UIViewController *)topSafeAreaSourceViewController {
  _topSafeArea.topSafeAreaSourceViewController = topSafeAreaSourceViewController;
}

- (UIViewController *)topSafeAreaSourceViewController {
  return _topSafeArea.topSafeAreaSourceViewController;
}

- (void)topSafeAreaInsetDidChange {
  [_topSafeArea safeAreaInsetsDidChange];
}

#pragma mark MDCFlexibleHeaderTopSafeAreaDelegate

- (void)flexibleHeaderSafeAreaTopSafeAreaInsetDidChange:(MDCFlexibleHeaderTopSafeArea *)safeAreas {
  [self.minMaxHeight recalculateMinMaxHeight];

  const CGFloat topSafeAreaInset = [_topSafeArea topSafeAreaInset];
  _topSafeAreaGuide.frame = CGRectMake(0, 0, self.bounds.size.width, topSafeAreaInset);

  // Adjust the scroll view insets to account for the new Safe Area inset.
  [self fhv_enforceInsetsForScrollView:_trackingScrollView];

  // Ignore any content offset delta that occured as a result of any safe area insets change.
  _shiftAccumulatorLastContentOffset = [self fhv_boundedContentOffset];

  // The changes might require us to re-calculate the frame, or update the entire layout.
  if (!_trackingScrollView) {
    CGRect bounds = self.bounds;
    bounds.size.height = self.minMaxHeight.minimumHeightWithTopSafeArea;
    self.bounds = bounds;
    CGPoint position = self.center;
    position.y = -MIN([self fhv_accumulatorMax], _shiftAccumulator);
    position.y += self.bounds.size.height / 2;
    self.center = position;
    [self.delegate flexibleHeaderViewFrameDidChange:self];
  } else {
    [self fhv_updateLayout];
  }
}

- (BOOL)flexibleHeaderSafeAreaIsStatusBarShifted:(MDCFlexibleHeaderTopSafeArea *)safeAreas {
  return ([self fhv_canShiftOffscreen] &&
          _shiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar &&
          _statusBarShifter.prefersStatusBarHidden);
}

- (CGFloat)flexibleHeaderSafeAreaDeviceTopSafeAreaInset:(MDCFlexibleHeaderTopSafeArea *)safeAreas {
  return MDCDeviceTopSafeAreaInset();
}

#pragma mark - MDCFlexibleHeaderMinMaxHeightDelegate

- (void)flexibleHeaderMaximumHeightDidChange:(MDCFlexibleHeaderMinMaxHeight *)safeAreas {
  [self fhv_adjustTrackingScrollViewInsetsForTrackingScrollView:_trackingScrollView];
}

- (void)flexibleHeaderMinMaxHeightDidChange:(MDCFlexibleHeaderMinMaxHeight *)safeAreas {
  [self fhv_updateLayout];
}

#pragma mark - Private (fhv_ prefix)

- (void)fhv_setContentOffset:(CGPoint)contentOffset
       forTrackingScrollView:(UIScrollView *)trackingScrollView {
  // Avoid excessive writes. This can also cause infinite recursion if we're observing the content
  // offset because of observesTrackingScrollViewScrollEvents.
  if (!CGPointEqualToPoint(contentOffset, trackingScrollView.contentOffset)) {
    trackingScrollView.contentOffset = contentOffset;
  }

  // When we manually set our content offset it's because we're trying to avoid any sort of content
  // jumping behavior, so we ignore immediate content offset delta by resetting the shift
  // accumulator last content offset to the new content offset:
  _shiftAccumulatorLastContentOffset = [self fhv_boundedContentOffset];
}

- (void)fhv_adjustTrackingScrollViewInsetsForTrackingScrollView:(UIScrollView *)trackingScrollView {
  CGPoint offsetPriorToInsetAdjustment = trackingScrollView.contentOffset;
  [self fhv_enforceInsetsForScrollView:trackingScrollView];

  // Only restore the content offset if UIScrollView didn't decide to update the content offset for
  // us. Notably, it seems to automatically adjust the content offset in the first runloop in which
  // the scroll view's been created, but not in any further runloops.
  if (CGPointEqualToPoint(offsetPriorToInsetAdjustment, trackingScrollView.contentOffset)) {
    CGFloat scrollViewAdjustedContentInsetTop = trackingScrollView.contentInset.top;
    if (@available(iOS 11.0, *)) {
      scrollViewAdjustedContentInsetTop = trackingScrollView.adjustedContentInset.top;
    }
    offsetPriorToInsetAdjustment.y =
        MAX(offsetPriorToInsetAdjustment.y, -scrollViewAdjustedContentInsetTop);
    [self fhv_setContentOffset:offsetPriorToInsetAdjustment
         forTrackingScrollView:trackingScrollView];
  }
}

- (void)fhv_removeInsetsFromScrollView:(UIScrollView *)scrollView {
  NSAssert(scrollView != _trackingScrollView,
           @"Invalid attempt to remove insets from the tracking scroll view.");
  if (!scrollView || scrollView == _trackingScrollView) {
    return;
  }

  MDCFlexibleHeaderScrollViewInfo *info = [_trackedScrollViews objectForKey:scrollView];
  if (!info) {
    return;
  }

  UIEdgeInsets insets = scrollView.contentInset;
  insets.top -= info.injectedTopContentInset;
  info.injectedTopContentInset = 0;
  info.hasInjectedTopContentInset = NO;
  scrollView.contentInset = insets;

  UIEdgeInsets scrollIndicatorInsets = scrollView.scrollIndicatorInsets;
  scrollIndicatorInsets.top -= info.injectedTopScrollIndicatorInset;
  info.injectedTopScrollIndicatorInset = 0;
  scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (CGFloat)fhv_existingContentInsetAdjustmentForScrollView:(UIScrollView *)scrollView {
  CGFloat existingContentInsetAdjustment = 0;

  if (@available(iOS 11.0, *)) {
    existingContentInsetAdjustment =
        (scrollView.adjustedContentInset.top - scrollView.contentInset.top);
  }

  return existingContentInsetAdjustment;
}

// Ensures that our tracking scroll view's top content inset matches our desired content inset.
//
// Our desired top content inset is always at least:
//
//     _maximumHeight (with safe area insets removed) + [_safeAreas topSafeAreaInset]
//
// This ensures that when our scroll view is scrolled to its top that our header is able to be fully
// expanded.
- (CGFloat)fhv_enforceInsetsForScrollView:(UIScrollView *)scrollView {
  if (!scrollView ||
      (self.useAdditionalSafeAreaInsetsForWebKitScrollViews && [self trackingScrollViewIsWebKit])) {
    return 0;
  }
  if (@available(iOS 11.0, *)) {
    // Don't adjust the contentInset if scrollView's behavior doesn't want it.
    // Compatible to iOS 11 and above
    if (self.disableContentInsetAdjustmentWhenContentInsetAdjustmentBehaviorIsNever &&
        scrollView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentNever) {
      return 0;
    }
  }

  MDCFlexibleHeaderScrollViewInfo *info = [_trackedScrollViews objectForKey:scrollView];
  if (!info) {
    info = [[MDCFlexibleHeaderScrollViewInfo alloc] init];
    [_trackedScrollViews setObject:info forKey:scrollView];
    if (_trackingScrollView == scrollView) {
      _trackingInfo = info;
    }
  }

  CGFloat existingContentInsetAdjustment =
      [self fhv_existingContentInsetAdjustmentForScrollView:scrollView];
  CGFloat desiredTopInset =
      self.minMaxHeight.maximumHeightWithTopSafeArea - existingContentInsetAdjustment;

  // During modal presentation on non-X devices our top safe area inset can be much larger than it
  // actually will be, causing desiredTopInset to be small or even negative. To guard against this,
  // we ensure that our desired top inset is always at least the header height.
  CGFloat minimumTopInset = self.minMaxHeight.maximumHeightWithoutTopSafeArea;
  desiredTopInset = MAX(minimumTopInset, desiredTopInset);

  UIEdgeInsets insets = scrollView.contentInset;
  CGFloat topInsetAdjustment = 0;
  if (!info.hasInjectedTopContentInset) {
    topInsetAdjustment = desiredTopInset;
  } else {
    topInsetAdjustment = desiredTopInset - info.injectedTopContentInset;
  }
  insets.top += topInsetAdjustment;
  info.injectedTopContentInset = desiredTopInset;
  info.hasInjectedTopContentInset = YES;
  if (!UIEdgeInsetsEqualToEdgeInsets(scrollView.contentInset, insets)) {
    scrollView.contentInset = insets;
  }

  BOOL statusBarIsHidden = [UIApplication mdc_safeSharedApplication].statusBarHidden ? YES : NO;
  if (_wasStatusBarHiddenIsValid && _wasStatusBarHidden != statusBarIsHidden &&
      !_isChangingStatusBarVisibility && !self.inferTopSafeAreaInsetFromViewController) {
    // Our status bar state has changed without our knowledge. UIKit will have already adjusted our
    // content offset by now, so we want to counteract this. This logic is similar to that found in
    // statusBarShifterNeedsStatusBarAppearanceUpdate:
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y -= topInsetAdjustment;
    [self fhv_setContentOffset:contentOffset forTrackingScrollView:_trackingScrollView];
  }

  _wasStatusBarHidden = statusBarIsHidden;
  _wasStatusBarHiddenIsValid = YES;

  return topInsetAdjustment;
}

- (void)fhv_updateShadowPath {
  UIBezierPath *path =
      [UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, -self.layer.shadowRadius, 0)];
  self.layer.shadowPath = [path CGPath];
}

#pragma mark Typically-used values

// Returns the contentOffset of the tracking scroll view bounded to the range of content offsets
// that will affect the header.
- (CGPoint)fhv_boundedContentOffset {
  // We don't care about rubber banding beyond the bottom of the content.
  return CGPointMake(_trackingScrollView.contentOffset.x,
                     MIN(_trackingScrollView.contentOffset.y, [self fhv_contentOffsetMaxY]));
}

- (CGFloat)fhv_rawTopContentInset {
  return _trackingScrollView.contentInset.top - _trackingInfo.injectedTopContentInset;
}

- (CGFloat)fhv_contentOffsetWithoutInjectedTopInset {
  return _trackingScrollView.contentOffset.y + [self fhv_rawTopContentInset];
}

- (CGFloat)fhv_contentOffsetMaxY {
  return _trackingScrollView.contentSize.height - _trackingScrollView.bounds.size.height;
}

// Returns a value indicating how much the header is overlapping the tracking scroll view's content.
// > 0 overlapping the content
// = 0 attached to top of content
// < 0 the content is below the header
- (CGFloat)fhv_projectedHeaderBottomEdge {
  CGFloat offsetWithoutInset = [self fhv_contentOffsetWithoutInjectedTopInset];
  CGRect projectedFrame = [self convertRect:self.bounds toView:self.trackingScrollView.superview];
  CGFloat frameBottomEdge = CGRectGetMaxY(projectedFrame);
  return frameBottomEdge + offsetWithoutInset;
}

- (CGFloat)fhv_accumulatorMax {
  BOOL shouldCollapseToStatusBar = [self fhv_shouldCollapseToStatusBar];
  CGFloat statusBarHeight = [UIApplication mdc_safeSharedApplication].statusBarFrame.size.height;
  return (shouldCollapseToStatusBar
              ? MAX(0, self.minMaxHeight.minimumHeightWithTopSafeArea - statusBarHeight)
              : self.minMaxHeight.minimumHeightWithTopSafeArea);
}

#pragma mark Logical short forms

- (BOOL)fhv_shouldAllowShifting {
  return self.hidesStatusBarWhenCollapsed && self.statusBarHintCanOverlapHeader;
}

- (BOOL)fhv_shouldCollapseToStatusBar {
  return !self.hidesStatusBarWhenCollapsed && self.statusBarHintCanOverlapHeader;
}

- (BOOL)fhv_canShiftOffscreen {
  return ((_shiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabled ||
           _shiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar) &&
          !_trackingScrollView.pagingEnabled);
}

- (BOOL)fhv_isPartiallyShifted {
  return ([self fhv_isDetachedFromTopOfContent] && _shiftAccumulator > 0 &&
          _shiftAccumulator < [self fhv_accumulatorMax]);
}

- (BOOL)fhv_isPartiallyExpanded {
  return ([self fhv_isDetachedFromTopOfContent] && _shiftAccumulator < 0 &&
          _shiftAccumulator > -(self.maximumHeight - self.minimumHeight));
}

// The flexible header is "in front of" the content.
- (BOOL)fhv_isDetachedFromTopOfContent {
  // Epsilon here is somewhat large in order to be visually-forgiving for sub-point situations.
  return [self fhv_projectedHeaderBottomEdge] > (CGFloat)0.5;
}

- (BOOL)fhv_isOverExtendingBottom {
  CGFloat bottomEdgeOfScrollView =
      (_trackingScrollView.contentOffset.y + _trackingScrollView.bounds.size.height);
  CGFloat bottomEdgeOfContent =
      (_trackingScrollView.contentSize.height + _trackingScrollView.contentInset.bottom);
  BOOL canOverExtendBottom =
      (_trackingScrollView.contentSize.height > _trackingScrollView.bounds.size.height);
  return (canOverExtendBottom && (bottomEdgeOfScrollView >= bottomEdgeOfContent));
}

#pragma mark Phase Calculation

// Given the current frame, calculates the scroll phase, value, and percentage.
- (void)fhv_recalculatePhase {
  CGRect frame = self.frame;

  CGFloat topEdge = self.center.y - self.bounds.size.height / 2;

  if (topEdge < 0) {
    _scrollPhase = MDCFlexibleHeaderScrollPhaseShifting;
    _scrollPhaseValue = topEdge + self.minMaxHeight.minimumHeightWithTopSafeArea;
    CGFloat adjustedHeight = self.minMaxHeight.minimumHeightWithTopSafeArea;
    if ([self fhv_shouldCollapseToStatusBar]) {
      CGFloat statusBarHeight =
          [UIApplication mdc_safeSharedApplication].statusBarFrame.size.height;
      adjustedHeight -= statusBarHeight;
    }
    if (adjustedHeight > 0) {
      _scrollPhasePercentage = -topEdge / adjustedHeight;
    } else {
      _scrollPhasePercentage = 0;
    }

    return;
  }

  _scrollPhaseValue = frame.size.height;

  if (frame.size.height < self.minMaxHeight.maximumHeightWithTopSafeArea) {
    _scrollPhase = MDCFlexibleHeaderScrollPhaseCollapsing;

    CGFloat heightLength = self.minMaxHeight.maximumHeightWithTopSafeArea -
                           self.minMaxHeight.minimumHeightWithTopSafeArea;
    if (heightLength > 0) {
      _scrollPhasePercentage =
          (frame.size.height - self.minMaxHeight.minimumHeightWithTopSafeArea) / heightLength;
    } else {
      _scrollPhasePercentage = 0;
    }

    return;
  }

  _scrollPhase = MDCFlexibleHeaderScrollPhaseOverExtending;
  if (self.minMaxHeight.maximumHeightWithTopSafeArea > 0) {
    _scrollPhasePercentage =
        1 + (frame.size.height - self.minMaxHeight.maximumHeightWithTopSafeArea) /
                self.minMaxHeight.maximumHeightWithTopSafeArea;
  } else {
    _scrollPhasePercentage = 0;
  }
}

#pragma mark Display Link

// The display link is only active when the user is no longer interacting with the scroll view and
// we'd like to shift the header either on- or off-screen.

#if TARGET_IPHONE_SIMULATOR
- (float)fhv_dragCoefficient {
  if (&UIAnimationDragCoefficient) {
    float coeff = UIAnimationDragCoefficient();
    if (coeff > 1) {
      return coeff;
    }
  }
  return 1;
}
#endif

- (void)fhv_startDisplayLink {
  [self fhv_stopDisplayLink];

  // NOTE: This may cause a retain cycle.
  // cl/129917749
  _shiftAccumulatorDisplayLink =
      [CADisplayLink displayLinkWithTarget:self
                                  selector:@selector(fhv_shiftAccumulatorDisplayLinkDidFire:)];
  [_shiftAccumulatorDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)fhv_stopDisplayLink {
  [_shiftAccumulatorDisplayLink invalidate];
  _shiftAccumulatorDisplayLink = nil;
}

- (void)fhv_shiftAccumulatorDisplayLinkDidFire:(CADisplayLink *)displayLink {
  // Erase any scrollback that was injected into the accumulator by capping it back down.
  _shiftAccumulator = MIN([self fhv_accumulatorMax], _shiftAccumulator);

  CGFloat destination;
  if (self.canAlwaysExpandToMaximumHeight) {
    if (_shiftAccumulator > 0) {  // Shifted
      destination = _wantsToBeHidden ? [self fhv_accumulatorMax] : 0;

    } else if (_shiftAccumulator < 0) {  // Expanded
      destination = _wantsToBeHidden ? 0 : [self fhv_accumulatorMin];

    } else {
      destination = 0;
    }

  } else {
    destination = _wantsToBeHidden ? [self fhv_accumulatorMax] : 0;
  }

  CGFloat distanceToDestination = destination - _shiftAccumulator;

  NSTimeInterval duration = displayLink.duration;

#if TARGET_IPHONE_SIMULATOR
  duration /= [self fhv_dragCoefficient];
#endif

  // This is a simple "force" that's stronger the further we are from the destination.
  _shiftAccumulator += kAttachmentCoefficient * distanceToDestination * duration;

  if (self.canAlwaysExpandToMaximumHeight) {
    _shiftAccumulator =
        MAX([self fhv_accumulatorMin], MIN([self fhv_accumulatorMax], _shiftAccumulator));
    [_statusBarShifter setOffset:MAX(0, _shiftAccumulator)];
  } else {
    _shiftAccumulator = MAX(0, MIN([self fhv_accumulatorMax], _shiftAccumulator));
    [_statusBarShifter setOffset:_shiftAccumulator];
  }

  // Have we reached our destination?
  if (fabs(destination - _shiftAccumulator) <= kShiftEpsilon) {
    _shiftAccumulator = destination;

    [self fhv_stopDisplayLink];
  }

  [self fhv_commitAccumulatorToFrame];
}

#pragma mark Shift Accumulator

- (void)fhv_accumulatorDidChange {
  if (!_trackingScrollView) {
    // Set the shadow opacity directly.
    self.layer.shadowOpacity =
        self.resetShadowAfterTrackingScrollViewIsReset && !self.isInFrontOfInfiniteContent
            ? 0
            : _visibleShadowOpacity;
    return;
  }

  CGRect frame = self.frame;

  CGFloat frameBottomEdge = [self fhv_projectedHeaderBottomEdge];
  frameBottomEdge = MAX(0, MIN(kShadowScaleLength, frameBottomEdge));
  CGFloat boundedAccumulator;
  if (self.canAlwaysExpandToMaximumHeight) {
    boundedAccumulator = MAX(0, MIN([self fhv_accumulatorMax], _shiftAccumulator));
  } else {
    boundedAccumulator = MIN([self fhv_accumulatorMax], _shiftAccumulator);
  }

  CGFloat shadowIntensity;
  if (self.hidesStatusBarWhenCollapsed) {
    // Calculate the desired shadow strength for the offset & accumulator and then take the
    // weakest strength.
    CGFloat accumulator =
        MAX(0, MIN(kShadowScaleLength,
                   self.minMaxHeight.minimumHeightWithTopSafeArea - boundedAccumulator));
    if (self.isInFrontOfInfiniteContent) {
      // When in front of infinite content we only care to hide the shadow when our header is
      // off-screen.
      shadowIntensity = MAX(0, MIN(1, accumulator / kShadowScaleLength));

    } else {
      // When over non-infinite content we also want to hide the shadow when we're anchored to the
      // top of our content.
      shadowIntensity = MAX(0, MIN(1, MIN(accumulator, frameBottomEdge) / kShadowScaleLength));
    }
  } else if (self.isInFrontOfInfiniteContent) {
    shadowIntensity = 1;
  } else {
    // Adjust the opacity as the bottom edge of the header increasingly overlaps the contents
    shadowIntensity = frameBottomEdge / kShadowScaleLength;
  }

  if (_defaultShadowLayer.hidden && _customShadowLayer.hidden) {
    self.layer.shadowOpacity = (float)(_visibleShadowOpacity * shadowIntensity);
  } else {
    _defaultShadowLayer.shadowOpacity = (float)(_visibleShadowOpacity * shadowIntensity);
  }
  _shadowIntensity = shadowIntensity;
  if (_shadowIntensityChangeBlock) {
    _shadowIntensityChangeBlock(_shadowLayer, _shadowIntensity);
  }

  [_statusBarShifter setOffset:boundedAccumulator];

  // Small performance improvement to not set the hidden property on every scroll tick.
  BOOL isShiftedOffscreen = boundedAccumulator >= self.minMaxHeight.minimumHeightWithTopSafeArea;
  BOOL isFullyCollapsed =
      frame.size.height <= self.minMaxHeight.minimumHeightWithTopSafeArea + DBL_EPSILON;
  BOOL isHidden = isShiftedOffscreen && isFullyCollapsed;
  if (isHidden != self.hidden) {
    self.hidden = isHidden;
  }

  UIEdgeInsets scrollIndicatorInsets = _trackingScrollView.scrollIndicatorInsets;
  scrollIndicatorInsets.top -= _trackingInfo.injectedTopScrollIndicatorInset;

  CGFloat existingContentInsetAdjustment =
      [self fhv_existingContentInsetAdjustmentForScrollView:_trackingScrollView];

  _trackingInfo.injectedTopScrollIndicatorInset =
      (frame.size.height - boundedAccumulator - existingContentInsetAdjustment);

  scrollIndicatorInsets.top += _trackingInfo.injectedTopScrollIndicatorInset;
  _trackingScrollView.scrollIndicatorInsets = scrollIndicatorInsets;
}

#pragma mark Layout

- (CGFloat)fhv_accumulatorMin {
  CGFloat headerHeight = -[self fhv_contentOffsetWithoutInjectedTopInset];

  CGFloat lowerBound;

  if (self.canAlwaysExpandToMaximumHeight) {
    CGFloat maxExpansion;
    if (headerHeight < self.minMaxHeight.minimumHeightWithTopSafeArea) {
      // The header is detached from the content and able to fully expand.
      maxExpansion = self.maximumHeight - self.minimumHeight;
    } else {
      // We're now attached to the content and need to constrain our possible expansion.
      maxExpansion = self.minMaxHeight.maximumHeightWithTopSafeArea - headerHeight;
    }
    // Expansion is tracked via negative accumulation.
    lowerBound = MIN(0, -maxExpansion);
  } else {
    lowerBound = 0;
  }

  return lowerBound;
}

- (void)fhv_updateLayout {
  if (!_trackingScrollView) {
    return;
  }

  // Update the min and max height if we're still using the defaults.
  // Safe area insets is often called as part of the UIWindow makeKeyAndVisible callstack, meaning
  // MDCDeviceTopSafeAreaInset returns an incorrect "best guess" value and we end up storing an
  // incorrect min/max height. In order to update min/max to the correct heights we need to update
  // our dimensions sometime after the window has been been made key, so the next best place is
  // here.
  [self.minMaxHeight recalculateMinMaxHeight];

  // If the status bar changes without us knowing then this ensures that our content insets
  // are up-to-date before we process the content offset.
  [self fhv_enforceInsetsForScrollView:_trackingScrollView];

  // We use the content offset to calculate the unclamped height of the frame.
  CGFloat offsetWithoutInset = [self fhv_contentOffsetWithoutInjectedTopInset];
  CGFloat headerHeight = -offsetWithoutInset;

  if (_trackingScrollView.isTracking) {
    [self fhv_stopDisplayLink];
  }

  if (_shiftAccumulatorLastContentOffsetIsValid) {
    // We track the last direction for our target offset behavior.
    CGFloat deltaY = [self fhv_boundedContentOffset].y - _shiftAccumulatorLastContentOffset.y;

    if (_shiftAccumulatorDeltaY * deltaY < 0) {
      // Direction has changed.
      _shiftAccumulatorDeltaY = 0;
    }
    _shiftAccumulatorDeltaY += deltaY;

    // Keeps track of the last direction the user moved their finger in.
    if (_trackingScrollView.isTracking) {
      if (_shiftAccumulatorDeltaY > kDeltaYSlop) {
        _wantsToBeHidden = YES;
      } else if (_shiftAccumulatorDeltaY < -kDeltaYSlop) {
        _wantsToBeHidden = NO;
      }
    }

    if (![self fhv_isOverExtendingBottom] && !_shiftAccumulatorDisplayLink) {
      if (!self.canAlwaysExpandToMaximumHeight) {
        // When we're not allowed to shift offscreen, only allow the header to shift further
        // on-screen in case it was previously off-screen due to a behavior change.
        if (![self fhv_canShiftOffscreen]) {
          deltaY = MIN(0, deltaY);
        }
      }

      // When scrubbing we only allow the header to shrink and shift off-screen.
      if (self.trackingScrollViewIsBeingScrubbed) {
        deltaY = MAX(0, deltaY);
      }

      if (self.canAlwaysExpandToMaximumHeight) {
        // When still attached to the top content, don't accumulate negatively.
        if (headerHeight >= self.minMaxHeight.minimumHeightWithTopSafeArea) {
          deltaY = MAX(0, deltaY);
        }
      }

      // Check if our delta y will cause us to cross the boundary from shrinking to shifting and,
      // if so, cap the deltaY to only the overshoot, otherwise the header will overshift.

      // headerHeight and deltaY are in inverted coordinate spaces, so when we do
      // headerHeight + deltaY we're calculating where the headerHeight was _before_ this update.

      CGFloat previousHeaderHeight = headerHeight + deltaY;

      // Overshoot coming in
      if (headerHeight < self.minMaxHeight.minimumHeightWithTopSafeArea &&
          previousHeaderHeight > self.minMaxHeight.minimumHeightWithTopSafeArea) {
        deltaY = self.minMaxHeight.minimumHeightWithTopSafeArea - headerHeight;

        // Overshoot going out
      } else if (headerHeight > self.minMaxHeight.minimumHeightWithTopSafeArea &&
                 previousHeaderHeight < self.minMaxHeight.minimumHeightWithTopSafeArea) {
        deltaY = (headerHeight + deltaY) - self.minMaxHeight.minimumHeightWithTopSafeArea;
      }

      // Calculate the upper bound of the accumulator based on what phase we're in.

      CGFloat upperBound;

      if (self.canAlwaysExpandToMaximumHeight && ![self fhv_canShiftOffscreen]) {
        // Don't allow any shifting.
        upperBound = 0;
      } else if (headerHeight < 0) {
        // Header is shifting while detached from content.
        upperBound = [self fhv_accumulatorMax] + [self fhv_anchorLength];
      } else if (headerHeight < self.minMaxHeight.minimumHeightWithTopSafeArea) {
        // Header is shifting while attached to content.
        upperBound = [self fhv_accumulatorMax];
      } else {
        // Header is not shifting.
        upperBound = 0;
      }

      // Ensure that we don't lose any deltaY by first capping the accumulator within its valid
      // range.
      _shiftAccumulator = MIN(upperBound, _shiftAccumulator);

      // Accumulate the deltaY.
      if (self.canAlwaysExpandToMaximumHeight) {
        CGFloat lowerBound = [self fhv_accumulatorMin];
        _shiftAccumulator = MAX(lowerBound, MIN(upperBound, _shiftAccumulator + deltaY));
      } else {
        _shiftAccumulator = MAX(0, MIN(upperBound, _shiftAccumulator + deltaY));
      }
    }
  }

  if (!self.canAlwaysExpandToMaximumHeight) {
    CGRect bounds = self.bounds;
    if (_canOverExtend && !UIAccessibilityIsVoiceOverRunning()) {
      bounds.size.height = MAX(self.minMaxHeight.minimumHeightWithTopSafeArea, headerHeight);
    } else {
      bounds.size.height = MAX(self.minMaxHeight.minimumHeightWithTopSafeArea,
                               MIN(self.minMaxHeight.maximumHeightWithTopSafeArea, headerHeight));
    }
    self.bounds = bounds;
  }

  [self fhv_commitAccumulatorToFrame];

  _shiftAccumulatorLastContentOffset = [self fhv_boundedContentOffset];
  _shiftAccumulatorLastContentOffsetIsValid = YES;
}

- (CGFloat)fhv_anchorLength {
  switch (_headerContentImportance) {
    case MDCFlexibleHeaderContentImportanceDefault:
      return kMaxAnchorLengthFullSwipe;

    case MDCFlexibleHeaderContentImportanceHigh:
      return kMaxAnchorLengthQuickSwipe;
  }
}

// Commit the current shiftOffscreenAccumulator value to the view's position.
- (void)fhv_commitAccumulatorToFrame {
  if (self.canAlwaysExpandToMaximumHeight) {
    CGFloat offsetWithoutInset = [self fhv_contentOffsetWithoutInjectedTopInset];
    CGFloat headerHeight = -offsetWithoutInset;
    CGRect bounds = self.bounds;

    CGFloat additionalHeightInjection = MAX(0, -_shiftAccumulator);

    if (_canOverExtend && !UIAccessibilityIsVoiceOverRunning()) {
      bounds.size.height = MAX(self.minMaxHeight.minimumHeightWithTopSafeArea, headerHeight) +
                           additionalHeightInjection;
    } else {
      bounds.size.height = (MAX(self.minMaxHeight.minimumHeightWithTopSafeArea,
                                MIN(self.minMaxHeight.maximumHeightWithTopSafeArea, headerHeight)) +
                            additionalHeightInjection);
    }

    // Avoid excessive writes - the default behavior of the flexible header has minimal height
    // adjustment behavior (basically only when over-extending).
    if (!CGRectEqualToRect(self.bounds, bounds)) {
      self.bounds = bounds;
    }
  }

  CGPoint position = self.center;
  CGFloat shiftOffset;
  if (self.canAlwaysExpandToMaximumHeight) {
    shiftOffset = MAX(0, MIN([self fhv_accumulatorMax], _shiftAccumulator));
  } else {
    shiftOffset = MIN([self fhv_accumulatorMax], _shiftAccumulator);
  }
  // Offset the frame.
  position.y = -shiftOffset;
  position.y += self.bounds.size.height / 2;

  self.center = position;

  [self fhv_accumulatorDidChange];
  [self fhv_recalculatePhase];

  CGFloat opacityShiftThreshold = [self fhv_accumulatorMax] * kContentHidingThreshold;
  // 0% means not shifted at all, 100% means shifted up to our threshold amount.
  CGFloat percentShiftedAlongThreshold = MIN(1, MAX(0, shiftOffset / opacityShiftThreshold));
  for (UIView *view in _viewsToHideWhenShifted) {
    // When not shifted at all, we want to be fully visible. We invert the percentage to get our
    // desired alpha.
    view.alpha = 1 - percentShiftedAlongThreshold;
  }

  [_statusBarShifter setOffset:_shiftAccumulator];

  [self.delegate flexibleHeaderViewFrameDidChange:self];
}

- (void)fhv_contentOffsetDidChange {
#if DEBUG
  _didAdjustTargetContentOffset = NO;
#endif

  if (_trackingInfo.shouldIgnoreNextSafeAreaAdjustment) {
    _trackingInfo.shouldIgnoreNextSafeAreaAdjustment = NO;

    if (_shiftAccumulatorLastContentOffsetIsValid) {
      CGFloat delta = (CGFloat)fabs(_shiftAccumulatorLastContentOffset.y -
                                    self.trackingScrollView.contentOffset.y);
      if (fabs(delta - [_topSafeArea topSafeAreaInset]) < kContentOffsetEpsilon) {
        // Looks like a top safe area inset adjustment. Let's ignore it.
        self.trackingScrollView.contentOffset = _shiftAccumulatorLastContentOffset;
        return;
      }
    }
    _shiftAccumulatorLastContentOffsetIsValid = NO;
  }

  if (self.trackingScrollView.isTracking) {
    _didDecelerate = NO;  // Invalidate the flag - we're not actually decelerating right now.
  }

  // We generally expect the tracking scroll view to be a sibling to the flexible header, but there
  // are cases where this assumption is always incorrect.
  //
  // Notably, UITableViewController's .view _is_ the tableView, so there is no way to add a flexible
  // header other than as a subview to the scroll view. This is the most common case to which the
  // following logic has been written.
  if (self.superview && self.superview == self.trackingScrollView) {
    if (self.superview.subviews.lastObject != self) {
      [self.superview bringSubviewToFront:self];
    }

    if (UIAccessibilityIsVoiceOverRunning()) {
      // Clamp the offset to at least -self.maximumHeight. Accessibility may attempt to scroll to
      // a lesser offset than this to pull the flexible header into the center of the scrollview on
      // focusing.
      CGPoint offset = self.trackingScrollView.contentOffset;
      offset.y = MAX(offset.y, -self.maximumHeight);
      [self fhv_setContentOffset:offset forTrackingScrollView:self.trackingScrollView];
      // Setting the transform on the same run loop as the accessibility scroll can cause additional
      // incorrect scrolling as the scrollview attempts to resolve to a position that will place
      // the header in the center of the scroll. Punting to the next loop prevents this.
      dispatch_async(dispatch_get_main_queue(), ^{
        self.transform =
            CGAffineTransformMakeTranslation(0, self.trackingScrollView.contentOffset.y);
        [self fhv_updateLayout];
      });
    } else {
      self.transform = CGAffineTransformMakeTranslation(0, self.trackingScrollView.contentOffset.y);
    }
  }

  // While the interface orientation is rotating we don't respond to any adjustments to the content
  // offset.
  if (_interfaceOrientationIsChanging || _contentInsetsAreChanging ||
      _isChangingStatusBarVisibility) {
    return;
  }

  [self fhv_updateLayout];
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (context == kKVOContextMDCFlexibleHeaderView) {
    void (^mainThreadWork)(void) = ^{
      if (object == self.trackingScrollView) {
        [self fhv_contentOffsetDidChange];
      }
    };

    // Ensure that UIKit modifications occur on the main thread.
    if ([NSThread isMainThread]) {
      mainThreadWork();
    } else {
      [[NSOperationQueue mainQueue] addOperationWithBlock:mainThreadWork];
    }

  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark Content offset observation

- (void)fhv_startObservingContentOffset {
  [self.trackingScrollView addObserver:self
                            forKeyPath:NSStringFromSelector(@selector(contentOffset))
                               options:NSKeyValueObservingOptionNew
                               context:kKVOContextMDCFlexibleHeaderView];
}

- (void)fhv_stopObservingContentOffset {
  [self.trackingScrollView removeObserver:self
                               forKeyPath:NSStringFromSelector(@selector(contentOffset))
                                  context:kKVOContextMDCFlexibleHeaderView];
}

- (void)setObservesTrackingScrollViewScrollEvents:(BOOL)observesTrackingScrollViewScrollEvents {
  NSAssert(self.shiftBehavior == MDCFlexibleHeaderShiftBehaviorDisabled ||
               !observesTrackingScrollViewScrollEvents,
           @"Please set shiftBehavior to disabled prior to enabling this property.");

  if (_observesTrackingScrollViewScrollEvents == observesTrackingScrollViewScrollEvents) {
    return;
  }
  _observesTrackingScrollViewScrollEvents = observesTrackingScrollViewScrollEvents;

  if (observesTrackingScrollViewScrollEvents) {
    [self fhv_startObservingContentOffset];
  } else {
    [self fhv_stopObservingContentOffset];
  }
}

#pragma mark Gestures

// TODO(#1254): Re-enable sanity check assert on viewDidPan
// This function is a temporary inclusion to stop an assert from triggering on iOS 10.3b until
// we determine the cause. Remove once #1254 is closed.
#if DEBUG
static BOOL isRunningiOS10_3OrAbove() {
  static dispatch_once_t onceToken;
  static BOOL isRunningiOS10_3OrAbove;
  dispatch_once(&onceToken, ^{
    NSProcessInfo *info = [NSProcessInfo processInfo];
    isRunningiOS10_3OrAbove = [info isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){
                                                                        .majorVersion = 10,
                                                                        .minorVersion = 3,
                                                                        .patchVersion = 0,
                                                                    }];
  });
  return isRunningiOS10_3OrAbove;
}
#endif

#if DEBUG
- (void)fhv_scrollViewDidPan:(UIPanGestureRecognizer *)pan {
  if (pan.state == UIGestureRecognizerStateEnded && [self fhv_canShiftOffscreen]) {
    // You _must_ implement the target content offset method in your UIScrollViewDelegate.
    // Not implementing the target content offset method can allow the status bar to get into an
    // indeterminate state and may cause your app to be rejected.

    // TODO(#1254): Re-enable sanity check assert on viewDidPan
    // To re-enable, remove isRunningiOS10_3OrAbove() function and always assert.
    if (!isRunningiOS10_3OrAbove()) {
      NSAssert(_didAdjustTargetContentOffset, @"%@ isn't invoking %@'s %@.",
               NSStringFromClass([_trackingScrollView class]), NSStringFromClass([self class]),
               NSStringFromSelector(@selector(trackingScrollViewWillEndDraggingWithVelocity:
                                                                        targetContentOffset:)));
    }
  }
}
#endif

#pragma mark Multiple tracking scroll views

// Given a tracking scroll view and a potential new tracking scroll view, updates the state of the
// header and scroll view such that header's height will not change once the scroll view becomes the
// new tracking scroll view.
- (void)fhv_matchHeightWithScrollView:(UIScrollView *)scrollView {
  if (self.trackingScrollView == nil) {
    return;
  }

  MDCFlexibleHeaderScrollViewInfo *info = [_trackedScrollViews objectForKey:scrollView];

  if (_shiftAccumulator >= [self fhv_accumulatorMax]) {
    // We're shifted off-screen, make sure that this scroll view isn't expecting to show the header.

    CGPoint offset = scrollView.contentOffset;
    CGFloat rawTopInset = scrollView.contentInset.top - info.injectedTopContentInset;
    if (offset.y < -rawTopInset) {
      offset.y = -rawTopInset;
      scrollView.contentOffset = offset;
    }
  }

  if (info.stashedHeightIsValid) {
    // Did our height change since the last time we saw this content?
    const CGFloat heightDelta = self.bounds.size.height - info.stashedHeight;
    if (fabs(heightDelta) > kHeightEpsilon) {
      // Offset our content accordingly so that we're still viewing what we were viewing last time.
      CGPoint offset = scrollView.contentOffset;
      offset.y -= heightDelta;
      scrollView.contentOffset = offset;
    }
  }
}

#pragma mark - MDCStatusBarShifterDelegate

- (void)statusBarShifterNeedsStatusBarAppearanceUpdate:
    (__unused MDCStatusBarShifter *)statusBarShifter {
  // UINavigationController reacts to status bar visibility changes by adjusting the content offset.
  // To counteract this sort of behavior, we forcefully stash the content offset and restore it
  // after updating the status bar appearance.
  _isChangingStatusBarVisibility = YES;
  CGPoint stashedContentOffset = _trackingScrollView.contentOffset;
  [self.delegate flexibleHeaderViewNeedsStatusBarAppearanceUpdate:self];
  [self fhv_enforceInsetsForScrollView:self.trackingScrollView];
  [UIView performWithoutAnimation:^{
    [self fhv_setContentOffset:stashedContentOffset forTrackingScrollView:self.trackingScrollView];
  }];
  _isChangingStatusBarVisibility = NO;
}

- (void)statusBarShifter:(__unused MDCStatusBarShifter *)statusBarShifter
    wantsSnapshotViewAdded:(UIView *)view {
  [self addSubview:view];
}

#pragma mark - Public

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  if (_trackingScrollView == trackingScrollView) {
    return;
  }

#if DEBUG
  [_trackingScrollView.panGestureRecognizer removeTarget:self
                                                  action:@selector(fhv_scrollViewDidPan:)];
  [trackingScrollView.panGestureRecognizer addTarget:self action:@selector(fhv_scrollViewDidPan:)];

#if 0   // TODO(featherless):
        // https://github.com/material-components/material-components-ios/issues/214
  // Verify existence of a delegate.
  NSAssert(!trackingScrollView || trackingScrollView.delegate,
           @"The provided tracking scroll view %@ has no delegate. Without a delegate, %@ will not"
           @" be able to react to scroll events and may perform incorrectly."
           @" This assertion will only fire in debug builds.",
           NSStringFromClass([trackingScrollView class]),
           NSStringFromClass([self class]));
#endif  // #if 0
#endif  // #if DEBUG

  if (self.observesTrackingScrollViewScrollEvents) {
    [self fhv_stopObservingContentOffset];
  }

  UIScrollView *oldTrackingScrollView = _trackingScrollView;

  CGFloat stashedHeight = CGRectGetHeight(self.bounds);
  if (_trackingInfo != nil) {
    _trackingInfo.stashedHeight = stashedHeight;
    _trackingInfo.stashedHeightIsValid = YES;
  }

  BOOL wasTrackingScrollView = _trackingScrollView != nil;
  _trackingScrollView = trackingScrollView;

  // If this header is shared by many scroll views then we leave the insets when switching the
  // tracking scroll view.
  if (!_sharedWithManyScrollViews && wasTrackingScrollView) {
    [self fhv_removeInsetsFromScrollView:oldTrackingScrollView];
  }

  _shiftAccumulatorLastContentOffsetIsValid = NO;
  _shiftAccumulatorLastContentOffset = _trackingScrollView.contentOffset;
  _shiftAccumulatorDeltaY = 0;

  _trackingInfo = [_trackedScrollViews objectForKey:_trackingScrollView];
  _trackingInfo.stashedHeightIsValid = NO;
  _trackingInfo.stashedHeight = 0;

  [self fhv_enforceInsetsForScrollView:_trackingScrollView];

  if (self.observesTrackingScrollViewScrollEvents) {
    [self fhv_startObservingContentOffset];
  }

  BOOL shouldAnimate = NO;

  if (self.sharedWithManyScrollViews && wasTrackingScrollView) {
    // What's our expected height now that we've changed the tracking scroll view?
    CGFloat headerHeight = -[self fhv_contentOffsetWithoutInjectedTopInset];
    headerHeight = MAX(self.minMaxHeight.minimumHeightWithTopSafeArea,
                       MIN(self.minMaxHeight.maximumHeightWithTopSafeArea, headerHeight));

    // How much will our height change if we do nothing right now?
    const CGFloat heightDelta = stashedHeight - headerHeight;

    // When canAlwaysExpandToMaximumHeight is enabled our header's height no longer directly
    // correlates to the content offset - it's also augmented by the shift accumulator. In order to
    // keep the header's height constant when changing the tracking scroll view, we need to adjust
    // the shift accumulator accordingly.
    if (self.canAlwaysExpandToMaximumHeight) {
      // Cap the accumulator to ensure it's valid.
      CGFloat accumulatorMin;
      if (headerHeight > self.minMaxHeight.minimumHeightWithTopSafeArea + kHeightEpsilon) {
        // We're attached to the content, so don't allow any height accumulation.
        accumulatorMin = 0;
      } else {
        accumulatorMin = [self fhv_accumulatorMin];
      }
      // Adjust the accumulator so that our height won't change and cap it to the possible range.
      CGFloat desiredShiftAccumulatorValue =
          MAX(accumulatorMin, MIN([self fhv_accumulatorMax], _shiftAccumulator - heightDelta));
      if (_shiftAccumulator != desiredShiftAccumulatorValue) {
        _shiftAccumulator = desiredShiftAccumulatorValue;
      }
    }

    CGPoint offset = self.trackingScrollView.contentOffset;
    BOOL trackingScrollViewIsUITableView =
        [self.trackingScrollView isKindOfClass:[UITableView class]];

    // Are we moving to content that requires the header to be expanded?
    if (headerHeight > stashedHeight) {
      // If so, shift the content up so that the header matches our current height.
      offset.y -= heightDelta;
    } else if (headerHeight < stashedHeight) {
      // We're about to shrink the header - this is the only case where we want to animate the
      // header's height change.
      shouldAnimate = YES;
    }

    if (!CGPointEqualToPoint(self.trackingScrollView.contentOffset, offset)) {
      self.trackingScrollView.contentOffset = offset;
    }

    if (trackingScrollViewIsUITableView) {
      _trackingInfo.shouldIgnoreNextSafeAreaAdjustment = YES;
    }
  }

  void (^animate)(void) = ^{
    [self fhv_updateLayout];
  };
  void (^completion)(BOOL) = ^(BOOL finished) {
    if (!finished) {
      return;
    }

    // When the tracking scroll view is cleared we need a shadow update.
    if (!self.trackingScrollView) {
      [self fhv_accumulatorDidChange];
    }
  };
  if (wasTrackingScrollView && shouldAnimate) {
    [UIView animateWithDuration:kTrackingScrollViewDidChangeAnimationDuration
                     animations:animate
                     completion:completion];
  } else {
    animate();
    completion(YES);
  }
}

- (void)trackingScrollViewDidScroll {
  NSAssert(!self.observesTrackingScrollViewScrollEvents,
           @"Do not manually forward tracking scroll view events when"
           @" observesTrackingScrollViewScrollEvents is enabled.");

  [self fhv_contentOffsetDidChange];
}

- (void)trackingScrollViewDidChangeAdjustedContentInset:(UIScrollView *)trackingScrollView {
  [self fhv_adjustTrackingScrollViewInsetsForTrackingScrollView:trackingScrollView];
}

- (void)trackingScrollViewDidEndDraggingWillDecelerate:(BOOL)willDecelerate {
  NSAssert(!self.observesTrackingScrollViewScrollEvents,
           @"Do not manually forward tracking scroll view events when"
           @" observesTrackingScrollViewScrollEvents is enabled.");

  if (self.canAlwaysExpandToMaximumHeight) {
    if (![self fhv_canShiftOffscreen] && [self fhv_isPartiallyShifted]) {
      _wantsToBeHidden = NO;
    }
    if (!willDecelerate && ([self fhv_isPartiallyShifted] || [self fhv_isPartiallyExpanded])) {
      [self fhv_startDisplayLink];
    }
  } else {
    if (![self fhv_canShiftOffscreen]) {
      _wantsToBeHidden = NO;
    }
    if (!willDecelerate && [self fhv_isPartiallyShifted]) {
      [self fhv_startDisplayLink];
    }
  }
  _didDecelerate = willDecelerate;
}

- (void)trackingScrollViewDidEndDecelerating {
  NSAssert(!self.observesTrackingScrollViewScrollEvents,
           @"Do not manually forward tracking scroll view events when"
           @" observesTrackingScrollViewScrollEvents is enabled.");

  // This event can be invoked after two different forms of user interaction:
  //
  // 1. When the tracking scroll view was tossed and then came to rest.
  // 2. When the tracking scroll view was tossed, then grabbed and released (without another toss).
  //
  // We only want to react to the first type of interaction. _didDecelerate will only be true in the
  // first case.
  if (!_didDecelerate) {
    return;
  }
  if ([self fhv_isPartiallyShifted]) {
    _wantsToBeHidden =
        (_shiftAccumulator >= (1 - kMinimumVisibleProportion) * [self fhv_accumulatorMax]);
    [self fhv_startDisplayLink];
  } else if ([self fhv_isPartiallyExpanded]) {
    _wantsToBeHidden =
        (_shiftAccumulator >= (1 - kMinimumVisibleProportion) * [self fhv_accumulatorMin]);
    [self fhv_startDisplayLink];
  }
}

- (BOOL)prefersStatusBarHidden {
  return _statusBarShifter.prefersStatusBarHidden;
}

- (BOOL)hidesStatusBarWhenCollapsed {
  return (_shiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar &&
          !_trackingScrollView.pagingEnabled);
}

- (void)setStatusBarHintCanOverlapHeader:(BOOL)statusBarHintCanOverlapHeader {
  if (_statusBarHintCanOverlapHeader == statusBarHintCanOverlapHeader) {
    return;
  }
  _statusBarHintCanOverlapHeader = statusBarHintCanOverlapHeader;

  _statusBarShifter.enabled = [self fhv_shouldAllowShifting];

  [self fhv_startDisplayLink];
}

- (void)setShiftBehavior:(MDCFlexibleHeaderShiftBehavior)shiftBehavior {
  NSAssert((self.observesTrackingScrollViewScrollEvents &&
            shiftBehavior == MDCFlexibleHeaderShiftBehaviorDisabled) ||
               !self.observesTrackingScrollViewScrollEvents,
           @"Flexible Header shift behavior must be disabled before content offset observation is"
           @" enabled.");

  shiftBehavior = ShiftBehaviorForCurrentAppContext(shiftBehavior);
  if (_shiftBehavior == shiftBehavior) {
    return;
  }
  BOOL needsShiftOnScreen = (_shiftBehavior != MDCFlexibleHeaderShiftBehaviorDisabled &&
                             shiftBehavior == MDCFlexibleHeaderShiftBehaviorDisabled);
  _shiftBehavior = shiftBehavior;

  _statusBarShifter.enabled = [self fhv_shouldAllowShifting];

  if (needsShiftOnScreen) {
    _wantsToBeHidden = NO;
    [self fhv_startDisplayLink];
  }
}

- (void)setBehavior:(MDCFlexibleHeaderShiftBehavior)behavior {
  self.shiftBehavior = behavior;
}

- (MDCFlexibleHeaderShiftBehavior)behavior {
  return self.shiftBehavior;
}

- (void)changeContentInsets:(MDCFlexibleHeaderChangeContentInsetsBlock)block {
  if (!block) {
    return;
  }
  _contentInsetsAreChanging = YES;
  UIEdgeInsets previousInsets = _trackingScrollView.contentInset;
  block();
  CGFloat delta = _trackingScrollView.contentInset.top - previousInsets.top;
  CGPoint contentOffset = _trackingScrollView.contentOffset;
  contentOffset.y -= delta;  // Keeps the scroll view offset from jumping.
  [self fhv_setContentOffset:contentOffset forTrackingScrollView:_trackingScrollView];
  _contentInsetsAreChanging = NO;
}

- (void)interfaceOrientationWillChange {
  NSAssert(!_interfaceOrientationIsChanging, @"Call to %@::%@ not matched by a call to %@.",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd),
           NSStringFromSelector(@selector(interfaceOrientationDidChange)));

  _interfaceOrientationIsChanging = YES;

  [_statusBarShifter interfaceOrientationWillChange];
}

- (void)interfaceOrientationIsChanging {
  NSAssert(_interfaceOrientationIsChanging, @"Call to %@::%@ not matched by a call to %@.",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd),
           NSStringFromSelector(@selector(interfaceOrientationWillChange)));
  [_topSafeArea safeAreaInsetsDidChange];
  [self fhv_updateLayout];
}

- (void)interfaceOrientationDidChange {
  NSAssert(_interfaceOrientationIsChanging, @"Call to %@::%@ not matched by a call to %@.",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd),
           NSStringFromSelector(@selector(interfaceOrientationWillChange)));

  _interfaceOrientationIsChanging = NO;

  // Ignore any content offset delta that occured as a result of any orientation change.
  _shiftAccumulatorLastContentOffset = [self fhv_boundedContentOffset];

  [self fhv_updateLayout];

  [_statusBarShifter interfaceOrientationDidChange];
}

- (void)viewWillTransitionToSize:(__unused CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [self interfaceOrientationWillChange];
  [coordinator
      animateAlongsideTransition:^(
          __unused id<UIViewControllerTransitionCoordinatorContext> context) {
        [self interfaceOrientationIsChanging];
      }
      completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        [self interfaceOrientationDidChange];
      }];
}

- (void)hideViewWhenShifted:(UIView *)view {
  [_viewsToHideWhenShifted addObject:view];
}

- (void)stopHidingViewWhenShifted:(UIView *)view {
  [_viewsToHideWhenShifted removeObject:view];
}

- (void)forwardTouchEventsForView:(UIView *)view {
  [_forwardingViews addObject:view];
}

- (void)stopForwardingTouchEventsForView:(UIView *)view {
  [_forwardingViews removeObject:view];
}

- (CGFloat)minimumHeight {
  return self.minMaxHeight.minimumHeight;
}

- (void)setMinimumHeight:(CGFloat)minimumHeight {
  self.minMaxHeight.minimumHeight = minimumHeight;
}

- (CGFloat)maximumHeight {
  return self.minMaxHeight.maximumHeight;
}

- (void)setMaximumHeight:(CGFloat)maximumHeight {
  self.minMaxHeight.maximumHeight = maximumHeight;
}

- (BOOL)minMaxHeightIncludesSafeArea {
  return self.minMaxHeight.minMaxHeightIncludesSafeArea;
}

- (void)setMinMaxHeightIncludesSafeArea:(BOOL)minMaxHeightIncludesSafeArea {
  self.minMaxHeight.minMaxHeightIncludesSafeArea = minMaxHeightIncludesSafeArea;
}

- (void)setInFrontOfInfiniteContent:(BOOL)inFrontOfInfiniteContent {
  if (_inFrontOfInfiniteContent == inFrontOfInfiniteContent) {
    return;
  }
  _inFrontOfInfiniteContent = inFrontOfInfiniteContent;

  if (!_trackingScrollView) {
    // Change the opacity directly as fhv_updateLayout is a no-op when _trackingScrollView is nil.
    self.layer.shadowOpacity = _inFrontOfInfiniteContent ? _visibleShadowOpacity : 0;
  } else {
    [self fhv_updateLayout];
  }
}

- (BOOL)trackingScrollViewWillEndDraggingWithVelocity:(__unused CGPoint)velocity
                                  targetContentOffset:(inout CGPoint *)targetContentOffset {
  NSAssert(!self.observesTrackingScrollViewScrollEvents,
           @"Do not manually forward tracking scroll view events when"
           @" observesTrackingScrollViewScrollEvents is enabled.");

#if DEBUG
  _didAdjustTargetContentOffset = YES;
#endif

  if ([self fhv_canShiftOffscreen]) {
    CGPoint target = *targetContentOffset;

    CGFloat offsetTargetY = target.y + [self fhv_rawTopContentInset];
    CGFloat flexHeight = -offsetTargetY;

    if ([self fhv_canShiftOffscreen] &&
        (0 < flexHeight && flexHeight < self.minMaxHeight.minimumHeightWithTopSafeArea)) {
      // Don't allow the header to be partially visible.
      if (_wantsToBeHidden) {
        target.y = -[self fhv_rawTopContentInset];
      } else {
        target.y = -self.minMaxHeight.minimumHeightWithTopSafeArea - [self fhv_rawTopContentInset];
      }
      *targetContentOffset = target;
      return YES;
    }
  }
  if (self.canAlwaysExpandToMaximumHeight && [self fhv_isPartiallyExpanded]) {
    CGPoint target = *targetContentOffset;

    // Don't allow the header to be partially expanded.
    if (_wantsToBeHidden) {
      target.y -= _shiftAccumulator;
    } else {
      target.y += ([self fhv_accumulatorMin] - _shiftAccumulator);
    }
    *targetContentOffset = target;
    return YES;
  }

  return NO;
}

- (void)trackingScrollWillChangeToScrollView:(UIScrollView *)scrollView {
  MDCFlexibleHeaderScrollViewInfo *info = [_trackedScrollViews objectForKey:scrollView];
  if (!info) {
    CGFloat topInsetDelta = [self fhv_enforceInsetsForScrollView:scrollView];
    info = [_trackedScrollViews objectForKey:scrollView];

    CGPoint offset = scrollView.contentOffset;
    offset.y -= topInsetDelta;
    scrollView.contentOffset = offset;
  }

  [self fhv_matchHeightWithScrollView:scrollView];
}

- (void)shiftHeaderOnScreenAnimated:(BOOL)animated {
  _wantsToBeHidden = NO;

  if (animated) {
    [self fhv_startDisplayLink];
  } else {
    // Remove any offscreen accumulation.
    _shiftAccumulator = 0;
    [self fhv_commitAccumulatorToFrame];
  }
}

- (void)shiftHeaderOffScreenAnimated:(BOOL)animated {
  _wantsToBeHidden = YES;

  if (animated) {
    [self fhv_startDisplayLink];
  } else {
    // Add offscreen accumulation equal to this header view's size.
    _shiftAccumulator = self.fhv_accumulatorMax;
    [self fhv_commitAccumulatorToFrame];
  }
}

- (void)setContentIsTranslucent:(BOOL)contentIsTranslucent {
  _contentIsTranslucent = contentIsTranslucent;

  // Translucent content means that the status bar shifter should not use snapshotting. Otherwise,
  // stale visual content under the status bar region may be snapshotted.
  _statusBarShifter.snapshottingEnabled = !contentIsTranslucent;
}

@end

@implementation MDCFlexibleHeaderScrollViewInfo
@end
