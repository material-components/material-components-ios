/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCFlexibleHeaderView.h"

#import "MaterialApplication.h"
#import "MaterialUIMetrics.h"
#import "private/MDCFlexibleHeaderView+Private.h"

#if TARGET_IPHONE_SIMULATOR
float UIAnimationDragCoefficient(void);  // Private API for simulator animation speed
#endif

// The default maximum height for the header. Does not include the status bar height.
static const CGFloat kFlexibleHeaderDefaultHeight = 56;

// The maximum default opacity of the shadow.
static const float kDefaultVisibleShadowOpacity = 0.4f;

// Duration of the UIKit animation that occurs when changing the tracking scroll view.
static const NSTimeInterval kTrackingScrollViewDidChangeAnimationDuration = 0.2;

// This length defines the moment at which the shadow will be fully visible as the header shifts
// on-screen.
static const CGFloat kShadowScaleLength = 8;

// KVO contexts
static char *const kKVOContextMDCFlexibleHeaderView =
    "kKVOContextMDCFlexibleHeaderView";

@interface MDCFlexibleHeaderView ()

// The intensity strength of the shadow being displayed under the flexible header. Use this property
// to check what the intensity of a custom shadow should be depending on a scroll position. Valid
// values range from 0 to 1. Where 0 is no shadow is visible and 1 is the shadow is fully visible.
@property(nonatomic, readonly) CGFloat shadowIntensity;

// The top safe area inset to consider when calculating the true minimum and maximum height of the
// flexible header view.
//
// This property is typically assigned the value of view.safeAreaInsets.top (iOS 11 and up) or
// viewController.topLayoutGuide.length (below iOS 11) from the header view controller's parent view
// controller.
//
// This property is ignored if inferTopSafeAreaInsetFromViewController is NO.
@property(nonatomic) CGFloat topSafeAreaInset;

@end

// All injections into the content and scroll indicator insets are tracked here. It's super
// important that we track what we added, rather than trying to cache the original values, because
// we can't know if the insets have changed out from under us by another party.
//
// A separate info object is tracked for each scroll view tracked by the flexible header view.
@interface MDCFlexibleHeaderScrollViewInfo : NSObject

// The amount injected into contentInsets.top
@property(nonatomic) CGFloat injectedTopContentInset;

// Whether or not we've injected the top content inset
@property(nonatomic) BOOL hasInjectedTopContentInset;

// The amount injected into scrollIndicatorInsets.top
@property(nonatomic) CGFloat injectedTopScrollIndicatorInset;

@end

@implementation MDCFlexibleHeaderView {
  // We keep a weak reference to all forwarding views in case the client forgets to stop forwarding
  // events for a view that's been removed from the header view. If we held a strong reference here
  // then the removed view would never be deallocated.
  NSHashTable *_forwardingViews;  // [UIView]

  // A weak reference map of scroll views to info that have been tracked by this header view.
  NSMapTable *_trackedScrollViews;  // {UIScrollView:MDCFlexibleHeaderScrollViewInfo}
  MDCFlexibleHeaderScrollViewInfo *_trackingInfo;

  // This will help us track if the size has been explicitly set or if we're using the defaults.
  BOOL _hasExplicitlySetMinHeight;
  BOOL _hasExplicitlySetMaxHeight;

  BOOL _interfaceOrientationIsChanging;
  BOOL _contentInsetsAreChanging;

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

  // Layers for header shadows.
  CALayer *_defaultShadowLayer;
  CALayer *_customShadowLayer;

  // The block executed when shadow intensity changes.
  MDCFlexibleHeaderShadowIntensityChangeBlock _shadowIntensityChangeBlock;
}

// MDCFlexibleHeader properties
@synthesize scrollPhase = _scrollPhase;
@synthesize scrollPhaseValue = _scrollPhaseValue;
@synthesize scrollPhasePercentage = _scrollPhasePercentage;

// MDCFlexibleHeaderConfiguration properties
@synthesize trackingScrollView = _trackingScrollView;
@synthesize minimumHeight = _minimumHeight;
@synthesize maximumHeight = _maximumHeight;
@synthesize canOverExtend = _canOverExtend;
@synthesize inFrontOfInfiniteContent = _inFrontOfInfiniteContent;
@synthesize sharedWithManyScrollViews = _sharedWithManyScrollViews;
@synthesize visibleShadowOpacity = _visibleShadowOpacity;

// Private
@synthesize topSafeAreaInset = _topSafeAreaInset;

- (void)dealloc {
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
  NSPointerFunctionsOptions options =
      (NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality);
  _forwardingViews = [NSHashTable hashTableWithOptions:options];

  NSPointerFunctionsOptions keyOptions =
      (NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality);
  NSPointerFunctionsOptions valueOptions =
      (NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPointerPersonality);
  _trackedScrollViews = [NSMapTable mapTableWithKeyOptions:keyOptions valueOptions:valueOptions];

  _minMaxHeightIncludesSafeArea = YES;
  _minimumHeight = kFlexibleHeaderDefaultHeight + self.topSafeAreaInset;
  _maximumHeight = _minimumHeight;

  _visibleShadowOpacity = kDefaultVisibleShadowOpacity;
  _canOverExtend = YES;

  _defaultShadowLayer = [CALayer layer];
  _defaultShadowLayer.shadowColor = [[UIColor blackColor] CGColor];
  _defaultShadowLayer.shadowOffset = CGSizeMake(0, 1.f);
  _defaultShadowLayer.shadowRadius = 4.f;
  _defaultShadowLayer.shadowOpacity = 0;
  _defaultShadowLayer.hidden = YES;
  [self.layer addSublayer:_defaultShadowLayer];

  // Allow for custom shadows to be used.
  _customShadowLayer = [CALayer layer];
  _customShadowLayer.hidden = YES;
  [self.layer addSublayer:_customShadowLayer];

  _topSafeAreaGuide = [[UIView alloc] init];
  _topSafeAreaGuide.frame = CGRectMake(0, 0, 0, self.topSafeAreaInset);
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
  self.layer.shadowRadius = 4.f;
  self.layer.shadowOpacity = 0;

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(fhv_updateLayout)
                                               name:UIAccessibilityVoiceOverStatusChanged
                                             object:nil];
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
  return CGSizeMake(size.width, self.computedMinimumHeight);
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

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *hitView = [super hitTest:point withEvent:event];

  // Forwards taps to the scroll view.
  if (hitView == self || (_contentView != nil && hitView == _contentView)
      || [_forwardingViews containsObject:hitView]) {
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
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    [super safeAreaInsetsDidChange];

    [self fhv_topSafeAreaInsetDidChange];
  }
#endif
}

#pragma mark - Top Safe Area Inset

- (void)fhv_topSafeAreaInsetDidChange {
  self.topSafeAreaInset = self.safeAreaInsets.top;

  // If the min or max height have been explicitly set, don't adjust anything if the values
  // already include a Safe Area inset.
  BOOL hasSetMinOrMaxHeight = _hasExplicitlySetMinHeight || _hasExplicitlySetMaxHeight;
  if (!hasSetMinOrMaxHeight && _minMaxHeightIncludesSafeArea) {
    // If we're using the defaults we need to update them to account for the new Safe Area inset.
    _minimumHeight = kFlexibleHeaderDefaultHeight + self.topSafeAreaInset;
    _maximumHeight = _minimumHeight;
  }

  _topSafeAreaGuide.frame = CGRectMake(0, 0, self.bounds.size.width, self.topSafeAreaInset);

  // Adjust the scroll view insets to account for the new Safe Area inset.
  [self fhv_enforceInsetsForScrollView:_trackingScrollView];

  // The changes might require us to re-calculate the frame, or update the entire layout.
  if (!_trackingScrollView) {
    CGRect bounds = self.bounds;
    bounds.size.height = self.computedMinimumHeight;
    self.bounds = bounds;
    self.center = CGPointMake(self.center.x, CGRectGetHeight(self.bounds) / 2);

    [self.delegate flexibleHeaderViewFrameDidChange:self];
  } else {
    [self fhv_updateLayout];
  }
}

- (id)topSafeAreaGuide {
  return _topSafeAreaGuide;
}

- (CGFloat)topSafeAreaGuideHeight {
  return _topSafeAreaGuide.frame.size.height;
}

#pragma mark - Private (fhv_ prefix)

- (void)fhv_setContentOffset:(CGPoint)contentOffset {
  // Avoid excessive writes. This can also cause infinite recursion if we're observing the content
  // offset because of observesTrackingScrollViewScrollEvents.
  if (!CGPointEqualToPoint(contentOffset, _trackingScrollView.contentOffset)) {
    _trackingScrollView.contentOffset = contentOffset;
  }
}

- (void)fhv_adjustTrackingScrollViewInsets {
  CGPoint offsetPriorToInsetAdjustment = _trackingScrollView.contentOffset;
  [self fhv_enforceInsetsForScrollView:_trackingScrollView];

  // Only restore the content offset if UIScrollView didn't decide to update the content offset for
  // us. Notably, it seems to automatically adjust the content offset in the first runloop in which
  // the scroll view's been created, but not in any further runloops.
  if (CGPointEqualToPoint(offsetPriorToInsetAdjustment, _trackingScrollView.contentOffset)) {
    CGFloat scrollViewAdjustedContentInsetTop = _trackingScrollView.contentInset.top;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
    if (@available(iOS 11.0, *)) {
      scrollViewAdjustedContentInsetTop = _trackingScrollView.adjustedContentInset.top;
    }
#endif
    offsetPriorToInsetAdjustment.y = MAX(offsetPriorToInsetAdjustment.y,
                                         -scrollViewAdjustedContentInsetTop);
    [self fhv_setContentOffset:offsetPriorToInsetAdjustment];
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

  UIEdgeInsets scrollIndicatorInsets = _trackingScrollView.scrollIndicatorInsets;
  scrollIndicatorInsets.top -= info.injectedTopScrollIndicatorInset;
  info.injectedTopScrollIndicatorInset = 0;
  _trackingScrollView.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (CGFloat)fhv_existingContentInsetAdjustmentForScrollView:(UIScrollView *)scrollView {
  CGFloat existingContentInsetAdjustment = 0;

#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    existingContentInsetAdjustment = (scrollView.adjustedContentInset.top
                                      - scrollView.contentInset.top);
  }
#else
  (void)scrollView; // To silence unused variable warnings.
#endif

  return existingContentInsetAdjustment;
}

// Ensures that our tracking scroll view's top content inset matches our desired content inset.
//
// Our desired top content inset is always at least:
//
//     _maximumHeight (with safe area insets removed) + self.topSafeAreaInset
//
// This ensures that when our scroll view is scrolled to its top that our header is able to be fully
// expanded.
- (CGFloat)fhv_enforceInsetsForScrollView:(UIScrollView *)scrollView {
  if (!scrollView) {
    return 0;
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
  CGFloat desiredTopInset = self.computedMaximumHeight - existingContentInsetAdjustment;

  // During modal presentation on non-X devices our top safe area inset can be much larger than it
  // actually will be, causing desiredTopInset to be small or even negative. To guard against this,
  // we ensure that our desired top inset is always at least the header height.
  CGFloat minimumTopInset;
  if (_minMaxHeightIncludesSafeArea) {
    minimumTopInset = _maximumHeight - self.topSafeAreaInset;
  } else {
    minimumTopInset = _maximumHeight;
  }
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

  BOOL statusBarIsHidden = [UIApplication mdc_safeSharedApplication].statusBarHidden;
  if (_wasStatusBarHiddenIsValid && _wasStatusBarHidden != statusBarIsHidden
      && !_isChangingStatusBarVisibility) {
    // Our status bar state has changed without our knowledge. UIKit will have already adjusted our
    // content offset by now, so we want to counteract this. This logic is similar to that found in
    // statusBarShifterNeedsStatusBarAppearanceUpdate:
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y -= topInsetAdjustment;
    [self fhv_setContentOffset:contentOffset];
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

#pragma mark Logical short forms

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
  CGFloat frameBottomEdge = [self fhv_projectedHeaderBottomEdge];
  frameBottomEdge = MAX(0, MIN(kShadowScaleLength, frameBottomEdge));

  CGFloat shadowIntensity;
  if (self.isInFrontOfInfiniteContent) {
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

  CGRect frame = self.frame;

  _scrollPhaseValue = frame.size.height;

  if (frame.size.height < self.computedMaximumHeight) {
    _scrollPhase = MDCFlexibleHeaderScrollPhaseCollapsing;

    CGFloat heightLength = self.computedMaximumHeight - self.computedMinimumHeight;
    if (heightLength > 0) {
      _scrollPhasePercentage = (frame.size.height - self.computedMinimumHeight) / heightLength;
    } else {
      _scrollPhasePercentage = 0;
    }

    return;
  }

  _scrollPhase = MDCFlexibleHeaderScrollPhaseOverExtending;
  if (self.computedMaximumHeight > 0) {
    _scrollPhasePercentage = 1 +
        (frame.size.height - self.computedMaximumHeight) / self.computedMaximumHeight;
  } else {
    _scrollPhasePercentage = 0;
  }
}

#pragma mark Layout

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
  BOOL hasSetMinOrMaxHeight = _hasExplicitlySetMinHeight || _hasExplicitlySetMaxHeight;
  if (!hasSetMinOrMaxHeight && _minMaxHeightIncludesSafeArea) {
    _minimumHeight = kFlexibleHeaderDefaultHeight + self.topSafeAreaInset;
    _maximumHeight = _minimumHeight;
  }

  // If the status bar changes without us knowing then this ensures that our content insets
  // are up-to-date before we process the content offset.
  [self fhv_enforceInsetsForScrollView:_trackingScrollView];

  // We use the content offset to calculate the unclamped height of the frame.
  CGFloat offsetWithoutInset = [self fhv_contentOffsetWithoutInjectedTopInset];
  CGFloat headerHeight = -offsetWithoutInset;

  CGRect bounds = self.bounds;

  if (_canOverExtend && !UIAccessibilityIsVoiceOverRunning()) {
    bounds.size.height = MAX(self.computedMinimumHeight, headerHeight);

  } else {
    bounds.size.height = MAX(self.computedMinimumHeight,
                             MIN(self.computedMaximumHeight, headerHeight));
  }

  self.bounds = bounds;
  self.center = CGPointMake(self.center.x, CGRectGetHeight(self.bounds) / 2);

  [self fhv_recalculatePhase];
  [self.delegate flexibleHeaderViewFrameDidChange:self];
}

- (void)fhv_contentOffsetDidChange {
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
      [self fhv_setContentOffset:offset];
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

#pragma mark - Public

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  if (_trackingScrollView == trackingScrollView) {
    return;
  }

  if (self.observesTrackingScrollViewScrollEvents) {
    [self fhv_stopObservingContentOffset];
  }

  UIScrollView *oldTrackingScrollView = _trackingScrollView;

  BOOL wasTrackingScrollView = _trackingScrollView != nil;
  _trackingScrollView = trackingScrollView;

  // If this header is shared by many scroll views then we leave the insets when switching the
  // tracking scroll view.
  if (!_sharedWithManyScrollViews && wasTrackingScrollView) {
    [self fhv_removeInsetsFromScrollView:oldTrackingScrollView];
  }

  _trackingInfo = [_trackedScrollViews objectForKey:_trackingScrollView];

  [self fhv_enforceInsetsForScrollView:_trackingScrollView];

  if (self.observesTrackingScrollViewScrollEvents) {
    [self fhv_startObservingContentOffset];
  }

  void (^animate)(void) = ^{
    [self fhv_updateLayout];
  };
  if (wasTrackingScrollView) {
    [UIView animateWithDuration:kTrackingScrollViewDidChangeAnimationDuration
                     animations:animate
                     completion:nil];
  } else {
    animate();
  }
}

- (void)trackingScrollViewDidScroll {
  NSAssert(!self.observesTrackingScrollViewScrollEvents,
           @"Do not manually forward tracking scroll view events when"
           @" observesTrackingScrollViewScrollEvents is enabled.");

  [self fhv_contentOffsetDidChange];
}

- (void)trackingScrollViewDidEndDraggingWillDecelerate:(BOOL)willDecelerate {
}

- (void)trackingScrollViewDidEndDecelerating {
}

- (BOOL)trackingScrollViewWillEndDraggingWithVelocity:(__unused CGPoint)velocity
                                  targetContentOffset:(inout CGPoint *)targetContentOffset {
  return NO;
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
  [self fhv_setContentOffset:contentOffset];
  _contentInsetsAreChanging = NO;
}

- (void)interfaceOrientationWillChange {
  NSAssert(!_interfaceOrientationIsChanging, @"Call to %@::%@ not matched by a call to %@.",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd),
           NSStringFromSelector(@selector(interfaceOrientationDidChange)));

  _interfaceOrientationIsChanging = YES;
}

- (void)interfaceOrientationIsChanging {
  NSAssert(_interfaceOrientationIsChanging, @"Call to %@::%@ not matched by a call to %@.",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd),
           NSStringFromSelector(@selector(interfaceOrientationWillChange)));
  [self fhv_updateLayout];
}

- (void)interfaceOrientationDidChange {
  NSAssert(_interfaceOrientationIsChanging, @"Call to %@::%@ not matched by a call to %@.",
           NSStringFromClass([self class]), NSStringFromSelector(_cmd),
           NSStringFromSelector(@selector(interfaceOrientationWillChange)));

  _interfaceOrientationIsChanging = NO;

  [self fhv_updateLayout];
}

- (void)viewWillTransitionToSize:(__unused CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [self interfaceOrientationWillChange];
  [coordinator animateAlongsideTransition:
      ^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        [self interfaceOrientationIsChanging];
      }
      completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        [self interfaceOrientationDidChange];
      }];
}

- (void)forwardTouchEventsForView:(UIView *)view {
  [_forwardingViews addObject:view];
}

- (void)stopForwardingTouchEventsForView:(UIView *)view {
  [_forwardingViews removeObject:view];
}

- (void)setMinimumHeight:(CGFloat)minimumHeight {
  _hasExplicitlySetMinHeight = YES;
  if (_minimumHeight == minimumHeight) {
    return;
  }

  _minimumHeight = minimumHeight;

  if (_minimumHeight > _maximumHeight) {
    [self setMaximumHeight:_minimumHeight];
  } else {
    [self fhv_updateLayout];
  }
}

- (void)setMaximumHeight:(CGFloat)maximumHeight {
  _hasExplicitlySetMaxHeight = YES;
  if (_maximumHeight == maximumHeight) {
    return;
  }

  _maximumHeight = maximumHeight;

  [self fhv_adjustTrackingScrollViewInsets];

  if (_maximumHeight < _minimumHeight) {
    [self setMinimumHeight:_maximumHeight];
  } else {
    [self fhv_updateLayout];
  }
}

- (CGFloat)computedMinimumHeight {
  if (_minMaxHeightIncludesSafeArea) {
    return _minimumHeight;
  } else {
    return _minimumHeight + self.topSafeAreaInset;
  }
}

- (CGFloat)computedMaximumHeight {
  if (_minMaxHeightIncludesSafeArea) {
    return _maximumHeight;
  } else {
    return _maximumHeight + self.topSafeAreaInset;
  }
}

- (void)setMinMaxHeightIncludesSafeArea:(BOOL)minMaxHeightIncludesSafeArea {
  if (_minMaxHeightIncludesSafeArea == minMaxHeightIncludesSafeArea) {
    return;
  }
  _minMaxHeightIncludesSafeArea = minMaxHeightIncludesSafeArea;

  // Update default values accordingly.
  if (!_hasExplicitlySetMinHeight) {
    if (_minMaxHeightIncludesSafeArea) {
      _minimumHeight = kFlexibleHeaderDefaultHeight + self.topSafeAreaInset;
    } else {
      _minimumHeight = kFlexibleHeaderDefaultHeight;
    }
  }
  if (!_hasExplicitlySetMaxHeight) {
    if (_minMaxHeightIncludesSafeArea) {
      _maximumHeight = kFlexibleHeaderDefaultHeight + self.topSafeAreaInset;
    } else {
      _maximumHeight = kFlexibleHeaderDefaultHeight;
    }
  }
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

- (void)trackingScrollWillChangeToScrollView:(UIScrollView *)scrollView {
  MDCFlexibleHeaderScrollViewInfo *info = [_trackedScrollViews objectForKey:scrollView];
  if (!info) {
    CGFloat topInsetDelta = [self fhv_enforceInsetsForScrollView:scrollView];
    info = [_trackedScrollViews objectForKey:scrollView];

    CGPoint offset = scrollView.contentOffset;
    offset.y -= topInsetDelta;
    scrollView.contentOffset = offset;
  }

  if (self.trackingScrollView.contentOffset.y != scrollView.contentOffset.y &&
             self.trackingScrollView.contentOffset.y <= 0 && scrollView.contentOffset.y <= 0) {
    // Our content is expanding the header in both columns, let's match up the content offsets so
    // that the header's height won't change.
    CGPoint offset = scrollView.contentOffset;
    offset.y = self.trackingScrollView.contentOffset.y;
    scrollView.contentOffset = offset;

  } else if (self.trackingScrollView.contentOffset.y > scrollView.contentOffset.y
             && scrollView.contentOffset.y < 0) { // Destination is showing an expanded header.
    // Our header is possibly smaller now than it will be when we move to the new content.
    // Scroll the new content such that we collapse the header to the current height.
    CGPoint offset = scrollView.contentOffset;
    offset.y = MIN(self.trackingScrollView.contentOffset.y, 0);
    scrollView.contentOffset = offset;
  }
}

@end

@implementation MDCFlexibleHeaderScrollViewInfo
@end
