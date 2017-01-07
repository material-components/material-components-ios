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

#import "private/MDCStatusBarShifter.h"

#if TARGET_IPHONE_SIMULATOR
float UIAnimationDragCoefficient(void);  // Private API for simulator animation speed
#endif

static const CGFloat kExpectedStatusBarHeight = 20;

// The default maximum height for the header. Includes the status bar height.
static const CGFloat kFlexibleHeaderDefaultHeight = 76;

// The maximum default opacity of the shadow.
static const float kDefaultVisibleShadowOpacity = 0.4f;

// This length defines the moment at which the shadow will be fully visible as the header shifts
// on-screen.
static const CGFloat kShadowScaleLength = 8;

// Duration of the UIKit animation that occurs when changing the tracking scroll view.
static const NSTimeInterval kTrackingScrollViewDidChangeAnimationDuration = 0.2;

// The epsilon used to determine when we've arrived at the destination while shifting the header
// on/off-screen with the display link.
static const float kShiftEpsilon = 0.1f;

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

static inline MDCFlexibleHeaderShiftBehavior ShiftBehaviorForCurrentAppContext(
    MDCFlexibleHeaderShiftBehavior intendedShiftBehavior) {
  if ([[[NSBundle mainBundle] bundlePath] hasSuffix:@".appex"] &&
      intendedShiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar) {
    return MDCFlexibleHeaderShiftBehaviorEnabled;
  }
  return intendedShiftBehavior;
}

static NSString *const MDCFlexibleHeaderMinimumHeightKey = @"MDCFlexibleHeaderMinimumHeightKey";
static NSString *const MDCFlexibleHeaderMaximumHeightKey = @"MDCFlexibleHeaderMaximumHeightKey";
static NSString *const MDCFlexibleHeaderShiftBehaviorKey = @"MDCFlexibleHeaderShiftBehaviorKey";
static NSString *const MDCFlexibleHeaderContentImportanceKey =
    @"MDCFlexibleHeaderContentImportanceKey";
static NSString *const MDCFlexibleHeaderCanOverExtendKey = @"MDCFlexibleHeaderCanOverExtendKey";
static NSString *const MDCFlexibleHeaderStatusBarCanOverlapKey =
    @"MDCFlexibleHeaderStatusBarCanOverlapKey";
static NSString *const MDCFlexibleHeaderVisibleShadowOpacityKey =
    @"MDCFlexibleHeaderVisibleShadowOpacityKey";
static NSString *const MDCFlexibleHeaderTrackingScrollViewKey =
    @"MDCFlexibleHeaderTrackingScrollViewKey";
static NSString *const MDCFlexibleHeaderInFrontOfInfiniteContentKey =
    @"MDCFlexibleHeaderInFrontOfInfiniteContentKey";
static NSString *const MDCFlexibleHeaderSharedWithManyScrollViewsKey =
    @"MDCFlexibleHeaderSharedWithManyScrollViewsKey";
static NSString *const MDCFlexibleHeaderContentIsTranslucentKey =
    @"MDCFlexibleHeaderContentIsTranslucentKey";
static NSString *const MDCFlexibleHeaderDelegateKey = @"MDCFlexibleHeaderDelegateKey";

@interface MDCFlexibleHeaderView () <MDCStatusBarShifterDelegate>

// The intensity strength of the shadow being displayed under the flexible header. Use this property
// to check what the intensity of a custom shadow should be depending on a scroll position. Valid
// values range from 0 to 1. Where 0 is no shadow is visible and 1 is the shadow is fully visible.
@property(nonatomic, readonly) CGFloat shadowIntensity;

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

  // The ideal visibility state of the header. This may not match the present visibility if the user
  // is interacting with the header or if we're presently animating it.
  BOOL _wantsToBeHidden;

  // Shift behavior state

  // Prevents delta calculations on first update pass.
  BOOL _shiftAccumulatorLastContentOffsetIsValid;
  // When the header can slide off-screen, this tracks how off-screen the header is.
  // Essentially: view's top edge = -_shiftAccumulator
  CGFloat _shiftAccumulator;
  CGPoint _shiftAccumulatorLastContentOffset;  // Stores our last delta'd content offset.
  CGFloat _shiftAccumulatorDeltaY;
  CADisplayLink *_shiftAccumulatorDisplayLink;

  BOOL _interfaceOrientationIsChanging;
  BOOL _contentInsetsAreChanging;
  BOOL _isChangingStatusBarVisibility;

  MDCStatusBarShifter *_statusBarShifter;

  // Layers for header shadows.
  CALayer *_defaultShadowLayer;
  CALayer *_customShadowLayer;

  // The block executed when shadow intensity changes.
  MDCFlexibleHeaderShadowIntensityChangeBlock _shadowIntensityChangeBlock;

#if DEBUG
  // Keeps track of whether the client called ...WillEndDraggingWithVelocity:...
  BOOL _didAdjustTargetContentOffset;
#endif
}

// MDCFlexibleHeader properties
@synthesize trackingScrollViewIsBeingScrubbed = _trackingScrollViewIsBeingScrubbed;
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

#if DEBUG
- (void)dealloc {
  [_trackingScrollView.panGestureRecognizer removeTarget:self
                                                  action:@selector(fhv_scrollViewDidPan:)];
}
#endif

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
    if ([aDecoder containsValueForKey:MDCFlexibleHeaderMinimumHeightKey]) {
      _minimumHeight = (CGFloat)[aDecoder decodeDoubleForKey:MDCFlexibleHeaderMinimumHeightKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderMaximumHeightKey]) {
      _maximumHeight = (CGFloat)[aDecoder decodeDoubleForKey:MDCFlexibleHeaderMaximumHeightKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderShiftBehaviorKey]) {
      _shiftBehavior = [aDecoder decodeIntegerForKey:MDCFlexibleHeaderShiftBehaviorKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderContentImportanceKey]) {
      _headerContentImportance =
          [aDecoder decodeIntegerForKey:MDCFlexibleHeaderContentImportanceKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderCanOverExtendKey]) {
      _canOverExtend = [aDecoder decodeBoolForKey:MDCFlexibleHeaderCanOverExtendKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderStatusBarCanOverlapKey]) {
      _statusBarHintCanOverlapHeader =
          [aDecoder decodeBoolForKey:MDCFlexibleHeaderStatusBarCanOverlapKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderVisibleShadowOpacityKey]) {
      _visibleShadowOpacity = [aDecoder decodeFloatForKey:MDCFlexibleHeaderVisibleShadowOpacityKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderTrackingScrollViewKey]) {
      _trackingScrollView = [aDecoder decodeObjectForKey:MDCFlexibleHeaderTrackingScrollViewKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderInFrontOfInfiniteContentKey]) {
      _inFrontOfInfiniteContent =
          [aDecoder decodeBoolForKey:MDCFlexibleHeaderInFrontOfInfiniteContentKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderSharedWithManyScrollViewsKey]) {
      _sharedWithManyScrollViews =
          [aDecoder decodeBoolForKey:MDCFlexibleHeaderSharedWithManyScrollViewsKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderContentIsTranslucentKey]) {
      _contentIsTranslucent = [aDecoder decodeBoolForKey:MDCFlexibleHeaderContentIsTranslucentKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderDelegateKey]) {
      _delegate = [aDecoder decodeObjectForKey:MDCFlexibleHeaderDelegateKey];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];

  [aCoder encodeDouble:self.minimumHeight forKey:MDCFlexibleHeaderMinimumHeightKey];
  [aCoder encodeDouble:self.maximumHeight forKey:MDCFlexibleHeaderMaximumHeightKey];
  [aCoder encodeInteger:self.shiftBehavior forKey:MDCFlexibleHeaderShiftBehaviorKey];
  [aCoder encodeInteger:self.headerContentImportance forKey:MDCFlexibleHeaderContentImportanceKey];
  [aCoder encodeBool:self.canOverExtend forKey:MDCFlexibleHeaderCanOverExtendKey];
  [aCoder encodeBool:self.statusBarHintCanOverlapHeader
              forKey:MDCFlexibleHeaderStatusBarCanOverlapKey];
  [aCoder encodeFloat:self.visibleShadowOpacity forKey:MDCFlexibleHeaderVisibleShadowOpacityKey];
  [aCoder encodeBool:self.inFrontOfInfiniteContent
              forKey:MDCFlexibleHeaderInFrontOfInfiniteContentKey];
  [aCoder encodeBool:self.sharedWithManyScrollViews
              forKey:MDCFlexibleHeaderSharedWithManyScrollViewsKey];
  [aCoder encodeBool:self.contentIsTranslucent forKey:MDCFlexibleHeaderContentIsTranslucentKey];
  if (self.trackingScrollView) {
    [aCoder encodeConditionalObject:self.trackingScrollView
                             forKey:MDCFlexibleHeaderTrackingScrollViewKey];
  }
  if (self.delegate) {
    [aCoder encodeConditionalObject:self.delegate forKey:MDCFlexibleHeaderDelegateKey];
  }
}

- (void)commonMDCFlexibleHeaderViewInit {
  _statusBarShifter = [[MDCStatusBarShifter alloc] init];
  _statusBarShifter.delegate = self;
  _statusBarShifter.enabled = [self fhv_shouldAllowShifting];

  NSPointerFunctionsOptions options =
      (NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality);
  _forwardingViews = [NSHashTable hashTableWithOptions:options];

  NSPointerFunctionsOptions keyOptions =
      (NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality);
  NSPointerFunctionsOptions valueOptions =
      (NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPointerPersonality);
  _trackedScrollViews = [NSMapTable mapTableWithKeyOptions:keyOptions valueOptions:valueOptions];

  _headerContentImportance = MDCFlexibleHeaderContentImportanceDefault;
  _statusBarHintCanOverlapHeader = YES;

  _minimumHeight = kFlexibleHeaderDefaultHeight;
  _maximumHeight = kFlexibleHeaderDefaultHeight;
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

  _contentView = [[UIView alloc] initWithFrame:self.bounds];
  _contentView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [super addSubview:_contentView];

  self.backgroundColor = [UIColor lightGrayColor];
  _defaultShadowLayer.backgroundColor = self.backgroundColor.CGColor;

  self.layer.shadowColor = [[UIColor blackColor] CGColor];
  self.layer.shadowOffset = CGSizeMake(0, 1);
  self.layer.shadowRadius = 4.f;
  self.layer.shadowOpacity = 0;
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
  return CGSizeMake(size.width, _minimumHeight);
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self fhv_updateShadowPath];
  BOOL disableActions = [CATransaction disableActions];
  [CATransaction setDisableActions:YES];
  _defaultShadowLayer.frame = self.bounds;
  _customShadowLayer.frame = self.bounds;
  _shadowLayer.frame = self.bounds;
  [_defaultShadowLayer layoutIfNeeded];
  [_customShadowLayer layoutIfNeeded];
  [_shadowLayer layoutIfNeeded];
  [CATransaction setDisableActions:disableActions];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];

  if (newSuperview == self.trackingScrollView) {
    self.transform = CGAffineTransformMakeTranslation(0, self.trackingScrollView.contentOffset.y);
  }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *hitView = [super hitTest:point withEvent:event];

  // Forwards taps to the scroll view.
  if (hitView == self || [_forwardingViews containsObject:hitView]) {
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

#pragma mark - Private (fhv_ prefix)

- (void)fhv_removeInsetsFromScrollView:(UIScrollView *)scrollView {
  if (!scrollView) {
    return;
  }
  if (_sharedWithManyScrollViews) {
    return;  // Never remove our insets from scroll views while the header is being shared.
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

- (MDCFlexibleHeaderScrollViewInfo *)fhv_addInsetsToScrollView:(UIScrollView *)scrollView {
  if (!scrollView) {
    return nil;
  }

  MDCFlexibleHeaderScrollViewInfo *info = [_trackedScrollViews objectForKey:scrollView];
  if (!info) {
    info = [[MDCFlexibleHeaderScrollViewInfo alloc] init];
    [_trackedScrollViews setObject:info forKey:scrollView];
    if (_trackingScrollView == scrollView) {
      _trackingInfo = info;
    }
  }

  if (!info.hasInjectedTopContentInset) {
    UIEdgeInsets insets = scrollView.contentInset;
    insets.top += _maximumHeight;
    info.injectedTopContentInset = _maximumHeight;
    info.hasInjectedTopContentInset = YES;
    scrollView.contentInset = insets;
  }

  // The scroll indicator insets are updated by fhv_accumulatorDidChange and change dynamically with
  // the header.
  return info;
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
  return (shouldCollapseToStatusBar ? _minimumHeight - kExpectedStatusBarHeight : _minimumHeight);
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

  if (frame.origin.y < 0) {
    _scrollPhase = MDCFlexibleHeaderScrollPhaseShifting;
    _scrollPhaseValue = frame.origin.y + _minimumHeight;
    CGFloat adjustedHeight = _minimumHeight;
    if ([self fhv_shouldCollapseToStatusBar]) {
      adjustedHeight -= kExpectedStatusBarHeight;
    }
    if (adjustedHeight > 0) {
      _scrollPhasePercentage = -frame.origin.y / adjustedHeight;
    } else {
      _scrollPhasePercentage = 0;
    }

    return;
  }

  _scrollPhaseValue = frame.size.height;

  if (frame.size.height < _maximumHeight) {
    _scrollPhase = MDCFlexibleHeaderScrollPhaseCollapsing;

    CGFloat heightLength = _maximumHeight - _minimumHeight;
    if (heightLength > 0) {
      _scrollPhasePercentage = (frame.size.height - _minimumHeight) / heightLength;
    } else {
      _scrollPhasePercentage = 0;
    }

    return;
  }

  _scrollPhase = MDCFlexibleHeaderScrollPhaseOverExtending;
  if (_maximumHeight > 0) {
    _scrollPhasePercentage = 1 + (frame.size.height - _maximumHeight) / _maximumHeight;
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

  CGFloat destination = _wantsToBeHidden ? [self fhv_accumulatorMax] : 0;
  CGFloat distanceToDestination = destination - _shiftAccumulator;

  NSTimeInterval duration = displayLink.duration;

#if TARGET_IPHONE_SIMULATOR
  duration /= [self fhv_dragCoefficient];
#endif

  // This is a simple "force" that's stronger the further we are from the destination.
  _shiftAccumulator += kAttachmentCoefficient * distanceToDestination * duration;
  _shiftAccumulator = MAX(0, MIN([self fhv_accumulatorMax], _shiftAccumulator));

  [_statusBarShifter setOffset:_shiftAccumulator];

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
    self.layer.shadowOpacity = _visibleShadowOpacity;

    return;
  }

  CGRect frame = self.frame;

  CGFloat frameBottomEdge = [self fhv_projectedHeaderBottomEdge];
  frameBottomEdge = MAX(0, MIN(kShadowScaleLength, frameBottomEdge));

  CGFloat boundedAccumulator = MIN([self fhv_accumulatorMax], _shiftAccumulator);

  CGFloat shadowIntensity;
  if (self.hidesStatusBarWhenCollapsed) {
    // Calculate the desired shadow strength for the offset & accumulator and then take the
    // weakest strength.
    CGFloat accumulator = MAX(0, MIN(kShadowScaleLength, _minimumHeight - boundedAccumulator));
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
  BOOL isHidden = boundedAccumulator >= _minimumHeight;
  if (isHidden != self.hidden) {
    self.hidden = isHidden;
  }

  UIEdgeInsets scrollIndicatorInsets = _trackingScrollView.scrollIndicatorInsets;
  scrollIndicatorInsets.top -= _trackingInfo.injectedTopScrollIndicatorInset;

  _trackingInfo.injectedTopScrollIndicatorInset = frame.size.height - boundedAccumulator;
  scrollIndicatorInsets.top += _trackingInfo.injectedTopScrollIndicatorInset;

  _trackingScrollView.scrollIndicatorInsets = scrollIndicatorInsets;
}

#pragma mark Layout

- (void)fhv_updateLayout {
  if (!_trackingScrollView) {
    return;
  }

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
      // When we're not allowed to shift offscreen, only allow the header to shift further
      // on-screen in case it was previously off-screen due to a behavior change.
      if (![self fhv_canShiftOffscreen]) {
        deltaY = MIN(0, deltaY);
      }

      // When scrubbing we only allow the header to shrink and shift off-screen.
      if (self.trackingScrollViewIsBeingScrubbed) {
        deltaY = MAX(0, deltaY);
      }

      // Check if our delta y will cause us to cross the boundary from shrinking to shifting and,
      // if so, cap the deltaY to only the overshoot, otherwise the header will overshift.

      // headerHeight and deltaY are in inverted coordinate spaces, so when we do
      // headerHeight + deltaY we're calculating where the headerHeight was _before_ this update.

      CGFloat previousHeaderHeight = headerHeight + deltaY;

      // Overshoot coming in
      if (headerHeight < _minimumHeight && previousHeaderHeight > _minimumHeight) {
        deltaY = _minimumHeight - headerHeight;

        // Overshoot going out
      } else if (headerHeight > _minimumHeight && previousHeaderHeight < _minimumHeight) {
        deltaY = (headerHeight + deltaY) - _minimumHeight;
      }

      // Calculate the upper bound of the accumulator based on what phase we're in.

      CGFloat upperBound;

      if (headerHeight < 0) {  // Header is shifting while detached from content.
        upperBound = [self fhv_accumulatorMax] + [self fhv_anchorLength];

      } else if (headerHeight < _minimumHeight) {  // Header is shifting while attached to content.
        upperBound = [self fhv_accumulatorMax];

      } else {  // Header is not shifting.
        upperBound = 0;
      }

      // Ensure that we don't lose any deltaY by first capping the accumulator within its valid
      // range.
      _shiftAccumulator = MIN(upperBound, _shiftAccumulator);

      // Accumulate the deltaY.
      _shiftAccumulator = MAX(0, MIN(upperBound, _shiftAccumulator + deltaY));
    }
  }

  CGRect bounds = self.bounds;

  if (_canOverExtend) {
    bounds.size.height = MAX(_minimumHeight, headerHeight);

  } else {
    bounds.size.height = MAX(_minimumHeight, MIN(_maximumHeight, headerHeight));
  }

  self.bounds = bounds;

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
  CGPoint position = self.center;
  // Offset the frame.
  position.y = -MIN([self fhv_accumulatorMax], _shiftAccumulator);
  position.y += self.bounds.size.height / 2;

  self.center = position;

  [self fhv_accumulatorDidChange];
  [self fhv_recalculatePhase];

  [_statusBarShifter setOffset:_shiftAccumulator];

  [self.delegate flexibleHeaderViewFrameDidChange:self];
}

- (void)fhv_contentOffsetDidChange {
#if DEBUG
  _didAdjustTargetContentOffset = NO;
#endif

  // We generally expect the tracking scroll view to be a sibling to the flexible header, but there
  // are cases where this assumption is always incorrect.
  //
  // Notably, UITableViewController's .view _is_ the tableView, so there is no way to add a flexible
  // header other than as a subview to the scroll view. This is the most common case to which the
  // following logic has been written.
  if (self.superview == self.trackingScrollView) {
    self.transform = CGAffineTransformMakeTranslation(0, self.trackingScrollView.contentOffset.y);

    if (self.superview.subviews.lastObject != self) {
      [self.superview bringSubviewToFront:self];
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

#pragma mark Gestures

#if DEBUG
- (void)fhv_scrollViewDidPan:(UIPanGestureRecognizer *)pan {
  if (pan.state == UIGestureRecognizerStateEnded && [self fhv_canShiftOffscreen]) {
    // You _must_ implement the target content offset method in your UIScrollViewDelegate.
    // Not implementing the target content offset method can allow the status bar to get into an
    // indeterminate state and may cause your app to be rejected.
    NSAssert(_didAdjustTargetContentOffset, @"%@ isn't invoking %@'s %@.",
             NSStringFromClass([_trackingScrollView class]), NSStringFromClass([self class]),
             NSStringFromSelector(
                 @selector(trackingScrollViewWillEndDraggingWithVelocity:targetContentOffset:)));
  }
}
#endif

#pragma mark - MDCStatusBarShifterDelegate

- (void)statusBarShifterNeedsStatusBarAppearanceUpdate:(MDCStatusBarShifter *)statusBarShifter {
  // UINavigationController reacts to status bar visibility changes by adjusting the content offset.
  // To counteract this sort of behavior, we forcefully stash the content offset and restore it
  // after updating the status bar appearance.
  _isChangingStatusBarVisibility = YES;
  CGPoint stashedContentOffset = _trackingScrollView.contentOffset;
  [self.delegate flexibleHeaderViewNeedsStatusBarAppearanceUpdate:self];
  [UIView performWithoutAnimation:^{
    _trackingScrollView.contentOffset = stashedContentOffset;
  }];
  _isChangingStatusBarVisibility = NO;
}

- (void)statusBarShifter:(MDCStatusBarShifter *)statusBarShifter
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

  // If this header is shared by many scroll views then we leave the insets when switching the
  // tracking scroll view.
  [self fhv_removeInsetsFromScrollView:_trackingScrollView];

  BOOL wasTrackingScrollView = _trackingScrollView != nil;

  _trackingScrollView = trackingScrollView;

  _shiftAccumulatorLastContentOffsetIsValid = NO;
  _shiftAccumulatorLastContentOffset = _trackingScrollView.contentOffset;
  _shiftAccumulatorDeltaY = 0;

  _trackingInfo = [_trackedScrollViews objectForKey:_trackingScrollView];
  if (!_sharedWithManyScrollViews || !_trackingInfo) {
    [self fhv_addInsetsToScrollView:_trackingScrollView];
  }
  void (^animate)() = ^{
    [self fhv_updateLayout];
  };
  void (^completion)(BOOL) = ^(BOOL finished) {
    if (!finished) {
      return;
    }

    // When the tracking scroll view is cleared we need a shadow update.
    if (!_trackingScrollView) {
      [self fhv_accumulatorDidChange];
    }
  };
  if (wasTrackingScrollView) {
    [UIView animateWithDuration:kTrackingScrollViewDidChangeAnimationDuration
                     animations:animate
                     completion:completion];
  } else {
    animate();
    completion(YES);
  }
}

- (void)trackingScrollViewDidScroll {
  [self fhv_contentOffsetDidChange];
}

- (void)trackingScrollViewDidEndDraggingWillDecelerate:(BOOL)willDecelerate {
  if (![self fhv_canShiftOffscreen]) {
    _wantsToBeHidden = NO;
  }
  if (!willDecelerate && [self fhv_isPartiallyShifted]) {
    [self fhv_startDisplayLink];
  }
}

- (void)trackingScrollViewDidEndDecelerating {
  if ([self fhv_isPartiallyShifted]) {
    _wantsToBeHidden =
        (_shiftAccumulator >= (1 - kMinimumVisibleProportion) * [self fhv_accumulatorMax]);
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

- (void)setstatusBarHintCanOverlapHeader:(BOOL)statusBarHintCanOverlapHeader {
  if (_statusBarHintCanOverlapHeader == statusBarHintCanOverlapHeader) {
    return;
  }
  _statusBarHintCanOverlapHeader = statusBarHintCanOverlapHeader;

  _statusBarShifter.enabled = [self fhv_shouldAllowShifting];

  [self fhv_startDisplayLink];
}

- (void)setShiftBehavior:(MDCFlexibleHeaderShiftBehavior)shiftBehavior {
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
  _trackingScrollView.contentOffset = contentOffset;
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

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [self interfaceOrientationWillChange];
  [coordinator
      animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self interfaceOrientationIsChanging];
      }
      completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
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
  if (_maximumHeight == maximumHeight) {
    return;
  }

  CGPoint originalOffset = _trackingScrollView.contentOffset;

  [self fhv_removeInsetsFromScrollView:_trackingScrollView];

  _maximumHeight = maximumHeight;

  CGPoint stashedOffset = _trackingScrollView.contentOffset;
  [self fhv_addInsetsToScrollView:_trackingScrollView];

  // Only restore the content offset if UIScrollView didn't decide to update the content offset for
  // us. Notably, it seems to automatically adjust the content offset in the first runloop in which
  // the scroll view's been created, but not in any further runloops.
  if (CGPointEqualToPoint(stashedOffset, _trackingScrollView.contentOffset)) {
    originalOffset.y = MAX(originalOffset.y, -_trackingScrollView.contentInset.top);
    _trackingScrollView.contentOffset = originalOffset;
  }

  if (_maximumHeight < _minimumHeight) {
    [self setMinimumHeight:_maximumHeight];
  } else {
    [self fhv_updateLayout];
  }
}

- (void)setInFrontOfInfiniteContent:(BOOL)inFrontOfInfiniteContent {
  if (_inFrontOfInfiniteContent == inFrontOfInfiniteContent) {
    return;
  }
  _inFrontOfInfiniteContent = inFrontOfInfiniteContent;

  [self fhv_updateLayout];
}

- (BOOL)trackingScrollViewWillEndDraggingWithVelocity:(CGPoint)velocity
                                  targetContentOffset:(inout CGPoint *)targetContentOffset {
#if DEBUG
  _didAdjustTargetContentOffset = YES;
#endif

  if ([self fhv_canShiftOffscreen]) {
    CGPoint target = *targetContentOffset;

    CGFloat offsetTargetY = target.y + [self fhv_rawTopContentInset];
    CGFloat flexHeight = -offsetTargetY;

    if ([self fhv_canShiftOffscreen] && (0 < flexHeight && flexHeight < _minimumHeight)) {
      // Don't allow the header to be partially visible.
      if (_wantsToBeHidden) {
        target.y = -[self fhv_rawTopContentInset];
      } else {
        target.y = -_minimumHeight - [self fhv_rawTopContentInset];
      }
      *targetContentOffset = target;
      return YES;
    }
  }

  return NO;
}

- (void)trackingScrollWillChangeToScrollView:(UIScrollView *)scrollView {
  MDCFlexibleHeaderScrollViewInfo *info = [_trackedScrollViews objectForKey:scrollView];
  if (!info) {
    info = [self fhv_addInsetsToScrollView:scrollView];

    CGPoint offset = scrollView.contentOffset;
    offset.y -= info.injectedTopContentInset;
    scrollView.contentOffset = offset;
  }

  if (_shiftAccumulator >= [self fhv_accumulatorMax]) {
    // We're shifted off-screen, make sure that this scroll view isn't expecting to show the header.

    CGPoint offset = scrollView.contentOffset;
    CGFloat rawTopInset = scrollView.contentInset.top - info.injectedTopContentInset;
    if (offset.y < -rawTopInset) {
      offset.y = -rawTopInset;
      scrollView.contentOffset = offset;
    }

  } else if (self.trackingScrollView.contentOffset.y != scrollView.contentOffset.y &&
             self.trackingScrollView.contentOffset.y <= 0 && scrollView.contentOffset.y <= 0) {
    // Our content is expanding the header in both columns, let's match up the content offsets so
    // that the header's height won't change.
    CGPoint offset = scrollView.contentOffset;
    offset.y = self.trackingScrollView.contentOffset.y;
    scrollView.contentOffset = offset;
  }
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
