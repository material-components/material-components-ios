// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBottomDrawerContainerViewController.h"

#import "MDCBottomDrawerHeader.h"
#import "MDCBottomDrawerContainerViewControllerDelegate.h"
#import "MDCBottomDrawerHeaderMask.h"
#import "MDCBottomDrawerShadowedView.h"
#import "MaterialApplication.h"
#import "MaterialMath.h"
#import "MaterialUIMetrics.h"

static const CGFloat kVerticalShadowAnimationDistance = 10;
// This value is the vertical offset that the drawer must be scrolled downward to cause it to be
// dismissed.
static const CGFloat kVerticalDistanceDismissalThreshold = 40;
// This multipier is used in circumstances where the contents of the drawer are sufficiently small
// (those having a height of less than 4 times the dismissal threshold of 40pt, i.e. 160pt). This
// multiplier was selected as it allows for the behavior to be more sensitive for drawers with
// smaller contents contents, and due to empirical testing where the largest reasonable scroll
// offset that could be achieved for a drawer with contents of height 100pt was roughly 28pt.
static const CGFloat kVerticalDistanceDismissalThresholdMultiplier = 4;
static const CGFloat kHeaderAnimationDistanceAddedDistanceFromTopSafeAreaInset = 20;
// This epsilon is defined in units of screen points, and is supposed to be as small as possible
// yet meaningful for comparison calculations.
static const CGFloat kEpsilon = (CGFloat)0.001;
// The buffer for the drawer's scroll view is neeeded to ensure that the KVO receiving the new
// content offset, which is then changing the content offset of the tracking scroll view, will
// be able to provide a value as if the scroll view is scrolling at natural speed. This is needed
// as in cases where the drawer shows in full screen, the scroll offset is 0, and then the scrolling
// has the behavior as if we are scrolling at the end of the content, and the scrolling isn't
// smooth.
static const CGFloat kScrollViewBufferForPerformance = 20;
static const CGFloat kDragVelocityThresholdForHidingDrawer = -2;
static const CGFloat kInitialDrawerHeightFactor = (CGFloat)0.5;
static NSString *const kContentOffsetKeyPath = @"contentOffset";
NSString *const kMDCBottomDrawerScrollViewAccessibilityIdentifier =
    @"kMDCBottomDrawerScrollViewAccessibilityIdentifier";

@implementation MDCBottomDrawerShadowedView
+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (MDCShadowLayer *)shadowLayer {
  if ([self.layer isKindOfClass:[MDCShadowLayer class]]) {
    return (MDCShadowLayer *)self.layer;
  }
  return nil;
}
@end

/** View that allows touches that aren't handled from within the view to be propagated up the
 responder chain. This is used to allow forwarding of tap events from the scroll view through to
 the delegate if that has been enabled on the VC. */

@interface MDCBottomDrawerScrollView : UIScrollView
@end

@implementation MDCBottomDrawerScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  // Cause the responder chain to keep bubbling up and propagate touches from the scroll view thru
  // to the presenting VC to possibly be handled by the drawer delegate.
  UIView *view = [super hitTest:point withEvent:event];
  return view == self ? nil : view;
}

@end

@interface MDCBottomDrawerContainerViewController (LayoutCalculations)

/**
 The vertical distance of the content header from the top of the window
 when the drawer is first displayed.
 When no content header is displayed, equal to the top inset of the content.
 */
@property(nonatomic, readonly) CGFloat contentHeaderTopInset;

// The content height surplus at the moment the drawer is first displayed.
@property(nonatomic, readonly) CGFloat contentHeightSurplus;

// An added height for the scroll view bottom inset.
@property(nonatomic, readonly) CGFloat addedContentHeight;

// Updates and caches the layout calculations.
- (void)cacheLayoutCalculations;

/**
 Returns the percentage of the transition animation for a given content offset.
 The transition animation, as defined here, occurs either when the content reaches fullscreen or
 when the entire content is displayed, whichever comes first.

 @param contentOffset The content offset.
 @param offset A value by which the triggering point of the animation should be shifted.
 A positive value will cause the animation to start earlier, while a negative value will cause
 the animation to start later.
 @param distance The distance the scroll view scrolls from the moment the animation starts
 and until it completes.
 */
- (CGFloat)transitionPercentageForContentOffset:(CGPoint)contentOffset
                                         offset:(CGFloat)offset
                                       distance:(CGFloat)distance;

/**
 Checks the given target content offset to ensure the target offset will not cause the drawer to
 end up in the middle of the header animation when the dragging ends. When needed, returns an
 updated vertical target content offset that ensures the header animation is in a defined state.
 Otherwise, returns NSNotFound.
 */
- (CGFloat)midAnimationScrollToPositionForOffset:(CGPoint)targetContentOffset;

@end

@interface MDCBottomDrawerContainerViewController (LayoutValues)

// The presenting view's bounds after it has been standardized.
@property(nonatomic, readonly) CGRect presentingViewBounds;

// The y-offset for the view if the presenting view controller has been presented modally.
@property(nonatomic, readonly) CGFloat presentingViewYOffset;

// Whether the content height exceeds the visible height when it's first displayed.
@property(nonatomic, readonly) BOOL contentScrollsToReveal;

// The top header height when the drawer is displayed in fullscreen.
@property(nonatomic, readonly) CGFloat topHeaderHeight;

// The top safe area inset if there is a header, 0 otherwise.
@property(nonatomic, readonly) CGFloat topAreaInsetForHeader;

// The content header height when the drawer is first displayed.
@property(nonatomic, readonly) CGFloat contentHeaderHeight;

// The vertical content offset where the transition animation completes.
@property(nonatomic, readonly) CGFloat transitionCompleteContentOffset;

// The headers animation distance.
@property(nonatomic, readonly) CGFloat headerAnimationDistance;

@end

@interface MDCBottomDrawerContainerViewController () <UIScrollViewDelegate>

// Whether the scroll view is observed via KVO.
@property(nonatomic) BOOL scrollViewObserved;

// The scroll view is currently being dragged towards bottom.
@property(nonatomic) BOOL scrollViewIsDraggedToBottom;

// Dictates whether the scrim should adopt the color of the trackingScrollView.
@property(nonatomic) BOOL scrimShouldAdoptTrackingScrollViewBackgroundColor;

// The scroll view has started its current drag from fullscreen.
@property(nonatomic) BOOL scrollViewBeganDraggingFromFullscreen;

// Whether the drawer is currently shown in fullscreen.
@property(nonatomic) BOOL currentlyFullscreen;

// Views:

// The main scroll view.
@property(nonatomic, readonly) UIScrollView *scrollView;

// The top header bottom shadow layer.
@property(nonatomic) MDCShadowLayer *headerShadowLayer;

// The current bottom drawer state.
@property(nonatomic) MDCBottomDrawerState drawerState;

// The view with the shadow.
@property(nonatomic) MDCBottomDrawerShadowedView *shadowedView;

// Updates both the header and content based off content offset of the scroll view.
- (void)updateViewWithContentOffset:(CGPoint)contentOffset;

@end

@implementation MDCBottomDrawerContainerViewController {
  UIScrollView *_scrollView;
  UIView *_topSafeAreaView;
  CGFloat _contentHeaderTopInset;
  CGFloat _contentHeightSurplus;
  CGFloat _addedContentHeight;
  CGFloat _contentVCPreferredContentSizeHeightCached;
  CGFloat _headerVCPerferredContentSizeHeightCached;
  CGFloat _scrollToContentOffsetY;
  CGFloat _maximumInitialDrawerHeight;
  BOOL _shouldPresentAtFullscreen;
}

- (instancetype)initWithOriginalPresentingViewController:
                    (UIViewController *)originalPresentingViewController
                                      trackingScrollView:(UIScrollView *)trackingScrollView {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _originalPresentingViewController = originalPresentingViewController;
    _contentHeaderTopInset = NSNotFound;
    _contentHeightSurplus = NSNotFound;
    _addedContentHeight = NSNotFound;
    _trackingScrollView = trackingScrollView;
    _drawerState = MDCBottomDrawerStateCollapsed;
    _scrollToContentOffsetY = 0;
    _maximumInitialDrawerHeight =
        self.presentingViewBounds.size.height * kInitialDrawerHeightFactor;
    _shouldPresentAtFullscreen = NO;
    UIColor *shadowColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.2];
    _headerShadowColor = shadowColor;
    _drawerShadowColor = shadowColor;
    _elevation = MDCShadowElevationNavDrawer;
    _shadowedView = [[MDCBottomDrawerShadowedView alloc] init];
    _shouldAdjustOnContentSizeChange = NO;
  }
  return self;
}

- (void)dealloc {
  [self removeScrollViewObserver];
  [self.headerShadowLayer removeFromSuperlayer];
  self.headerShadowLayer = nil;
}

- (void)hideDrawer {
  // Inset the scroll view by the current offset before dismissing in order to prevent a jump to a
  // zero offset during interactive dismissal.
  UIEdgeInsets previousInset = self.scrollView.contentInset;
  UIEdgeInsets adjustedInset = previousInset;
  adjustedInset.top += -self.scrollView.contentOffset.y;
  self.scrollView.contentInset = adjustedInset;

  [self.originalPresentingViewController dismissViewControllerAnimated:YES
                                                            completion:^{
                                                              self.scrollView.contentInset =
                                                                  previousInset;
                                                            }];
}

- (CGFloat)topSafeAreaInset {
  if (@available(iOS 11.0, *)) {
    return [UIApplication mdc_safeSharedApplication].keyWindow.safeAreaInsets.top;
  }
  return MDCFixedStatusBarHeightOnPreiPhoneXDevices;
}

#pragma mark UIGestureRecognizerDelegate (Public)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  CGFloat locationInView = [touch locationInView:nil].y;
  CGFloat contentOriginY = self.headerViewController.view != nil
                               ? self.headerViewController.view.frame.origin.y
                               : self.contentViewController.view.frame.origin.y;
  CGFloat contentOriginYConverted =
      [(self.headerViewController.view.superview ?: self.contentViewController.view.superview)
          convertPoint:CGPointMake(0, contentOriginY)
                toView:nil]
          .y;
  return locationInView < contentOriginYConverted;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if ([object isKindOfClass:[UIScrollView class]]) {
    CGPoint contentOffset = [(NSValue *)[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
    CGPoint oldContentOffset =
        [(NSValue *)[change objectForKey:NSKeyValueChangeOldKey] CGPointValue];
    self.scrollViewIsDraggedToBottom = contentOffset.y == oldContentOffset.y
                                           ? self.scrollViewIsDraggedToBottom
                                           : contentOffset.y < oldContentOffset.y;

    // The normalized content offset takes the content offset and updates it if using the
    // performance logic that comes with setting the tracking scroll view. The reason we update
    // the content offset is because the performance logic stops the scrolling internally of the
    // main scroll view using the bounds origin, and we don't want the view update with content
    // offset to use the outdated content offset of the main scroll view, so we update it
    // accordingly.
    CGPoint normalizedContentOffset = contentOffset;
    if (self.trackingScrollView != nil) {
      normalizedContentOffset.y = [self updateContentOffsetForPerformantScrolling:contentOffset.y];
    }

    [self updateViewWithContentOffset:normalizedContentOffset];
  }
}

- (CGFloat)updateContentOffsetForPerformantScrolling:(CGFloat)contentYOffset {
  CGFloat normalizedYContentOffset = contentYOffset;
  CGFloat topAreaInsetForHeader = self.topAreaInsetForHeader;
  // The top area inset for header should be a positive non zero value for the algorithm to
  // correctly work when the drawer is presented in full screen and there is no top inset.
  // The reason being is that otherwise there would be a conflict between if the drawer is currently
  // in full screen and we should move the header view outside the scrollview to remain sticky, or
  // if we aren't in full screen and need the header view to be scrolled as part of the scrolling.
  if (self.contentHeaderTopInset <= topAreaInsetForHeader + kEpsilon) {
    topAreaInsetForHeader = kEpsilon;
  }
  // We reset this to 0 if the `maximumDrawerHeight` should be 0 since we assume that the
  // `maximumDrawerHeight` will be less than the screen height minus the top safe area. Typically we
  // add height to the header but if we are using the `maximumDrawerHeight` no height is added to
  // the header.
  if ([self shouldUseMaximumDrawerHeight]) {
    topAreaInsetForHeader = 0;
  }
  CGFloat bottomSafeAreaInset = [self bottomSafeAreaInsetsToAdjustContainerHeight];
  CGFloat drawerOffset =
      self.contentHeaderTopInset - topAreaInsetForHeader + kScrollViewBufferForPerformance;
  CGFloat headerHeightWithoutInset = self.contentHeaderHeight - topAreaInsetForHeader;
  CGFloat contentDiff = contentYOffset - drawerOffset;
  CGFloat maxScrollOrigin = self.trackingScrollView.contentSize.height -
                            CGRectGetHeight(self.presentingViewBounds) + headerHeightWithoutInset +
                            bottomSafeAreaInset - kScrollViewBufferForPerformance;
  // Since we are not adding any height, typically the safe area, to the header. We need allow for
  // additional scrolling of the content.
  if ([self shouldUseMaximumDrawerHeight]) {
    maxScrollOrigin += [self topSafeAreaInset];
  }
  BOOL scrollingUpInFull = contentDiff < 0 && CGRectGetMinY(self.trackingScrollView.bounds) > 0;

  if (CGRectGetMinY(self.scrollView.bounds) >= drawerOffset || scrollingUpInFull) {
    // If we reach full screen or if we are scrolling up after being in full screen.
    if (CGRectGetMinY(self.trackingScrollView.bounds) < maxScrollOrigin || scrollingUpInFull) {
      // If we still didn't reach the end of the content, or if we are scrolling up after reaching
      // the end of the content.
      self.scrimShouldAdoptTrackingScrollViewBackgroundColor = NO;

      // Update the drawer's scrollView's offset to be static so the content will scroll instead.
      CGRect scrollViewBounds = self.scrollView.bounds;
      scrollViewBounds.origin.y = drawerOffset;
      normalizedYContentOffset = drawerOffset;
      self.scrollView.bounds = scrollViewBounds;

      // Make sure the drawer's scrollView's content size is the full size of the content
      CGSize scrollViewContentSize = self.presentingViewBounds.size;
      scrollViewContentSize.height += self.contentHeightSurplus;
      self.scrollView.contentSize = scrollViewContentSize;

      // Update the main content view's scrollView offset
      CGRect contentViewBounds = self.trackingScrollView.bounds;
      contentViewBounds.origin.y += contentDiff;
      contentViewBounds.origin.y = MIN(maxScrollOrigin, MAX(CGRectGetMinY(contentViewBounds), 0));
      self.trackingScrollView.bounds = contentViewBounds;
    } else {
      if (![self shouldUseMaximumDrawerHeight]) {
        self.scrimShouldAdoptTrackingScrollViewBackgroundColor = YES;
      }

      if (self.trackingScrollView.contentSize.height >=
          CGRectGetHeight(self.trackingScrollView.frame)) {
        // Have the drawer's scrollView's content size be static so it will bounce when reaching the
        // end of the content.
        CGSize scrollViewContentSize = self.scrollView.contentSize;
        scrollViewContentSize.height =
            drawerOffset + CGRectGetHeight(self.scrollView.frame) + 2 * topAreaInsetForHeader;
        self.scrollView.contentSize = scrollViewContentSize;
      }
    }
  } else {
    self.scrimShouldAdoptTrackingScrollViewBackgroundColor = NO;
  }
  return normalizedYContentOffset;
}

- (BOOL)isAccessibilityMode {
  return UIAccessibilityIsVoiceOverRunning() || UIAccessibilityIsSwitchControlRunning();
}

- (BOOL)isMobileLandscape {
  return self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact;
}

- (BOOL)shouldPresentFullScreen {
  return [self isAccessibilityMode] || [self isMobileLandscape] || _shouldPresentAtFullscreen;
}

- (BOOL)contentReachesFullscreen {
  return [self shouldPresentFullScreen] ? YES
                                        : self.contentHeightSurplus >= self.contentHeaderTopInset;
}

- (BOOL)shouldUseMaximumDrawerHeight {
  return self.maximumDrawerHeight > 0 && ![self shouldPresentFullScreen];
}

- (CGFloat)maximumInitialDrawerHeight {
  if ([self shouldPresentFullScreen]) {
    return self.presentingViewBounds.size.height + self.presentingViewYOffset;
  }
  return _maximumInitialDrawerHeight + [self bottomSafeAreaInsetsToAdjustInitialDrawerHeight];
}

- (void)setMaximumInitialDrawerHeight:(CGFloat)maximumInitialDrawerHeight {
  _maximumInitialDrawerHeight = maximumInitialDrawerHeight;

  if (_contentHeaderTopInset != NSNotFound) {
    _contentHeaderTopInset = NSNotFound;
    _contentHeightSurplus = NSNotFound;
    _addedContentHeight = NSNotFound;
    [self cacheLayoutCalculations];
    [self setupLayout];
  }
}

- (void)addScrollViewObserver {
  if (self.scrollViewObserved) {
    return;
  }
  self.scrollViewObserved = YES;
  [self.scrollView addObserver:self
                    forKeyPath:kContentOffsetKeyPath
                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                       context:nil];
}

- (void)removeScrollViewObserver {
  if (!self.scrollViewObserved) {
    return;
  }
  self.scrollViewObserved = NO;
  [self.scrollView removeObserver:self forKeyPath:kContentOffsetKeyPath];
}

- (void)setDrawerState:(MDCBottomDrawerState)drawerState {
  if (drawerState != _drawerState) {
    _drawerState = drawerState;
    [self.delegate bottomDrawerContainerViewControllerWillChangeState:self drawerState:drawerState];
  }
}

- (void)updateDrawerState:(CGFloat)transitionPercentage {
  if (transitionPercentage >= 1 - kEpsilon) {
    BOOL fullScreen = (self.contentReachesFullscreen && ![self shouldUseMaximumDrawerHeight]);
    self.drawerState = fullScreen ? MDCBottomDrawerStateFullScreen : MDCBottomDrawerStateExpanded;
  } else {
    self.drawerState = MDCBottomDrawerStateCollapsed;
  }
}

- (BOOL)hasHeaderViewController {
  return self.headerViewController != nil;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated {
  _scrollToContentOffsetY = contentOffsetY;
  CGFloat drawerOffset = self.contentHeaderTopInset - self.topAreaInsetForHeader;
  CGFloat calculatedYContentOffset =
      contentOffsetY - self.trackingScrollView.contentOffset.y + drawerOffset;
  [self.scrollView
      setContentOffset:CGPointMake(self.scrollView.contentOffset.x, calculatedYContentOffset)
              animated:animated];
  if (!animated) {
    // There is an issue that is deriving from us setting a kScrollViewBufferForPerformance in our
    // scrolling logic that is influencing the drawer from sometimes getting to the exact offset
    // specifically when scrolling to the top (contentOffsetY = 0). For us to mitigate this issue
    // we will need to set the content offset twice for non animated calls and set it the second
    // time in scrollViewDidEndScrollingAnimation for animated calls. As far as our research went
    // to get rid of kScrollViewBufferForPerformance, we will need to do some refactoring work
    // that we have opened a tracking bug for: GitHub issue #5785.
    calculatedYContentOffset =
        contentOffsetY - self.trackingScrollView.contentOffset.y + drawerOffset;
    [self.scrollView
        setContentOffset:CGPointMake(self.scrollView.contentOffset.x, calculatedYContentOffset)
                animated:animated];
  }
}

- (void)setElevation:(MDCShadowElevation)elevation {
  _elevation = elevation;
  self.shadowedView.shadowLayer.elevation = elevation;
}

- (void)setDrawerShadowColor:(UIColor *)drawerShadowColor {
  _drawerShadowColor = drawerShadowColor;
  self.shadowedView.shadowLayer.shadowColor = drawerShadowColor.CGColor;
}

// This property and the logic associated with it were added to mitigate b/119714330
- (void)setScrimShouldAdoptTrackingScrollViewBackgroundColor:
    (BOOL)scrimShouldAdoptTrackingScrollViewBackgroundColor {
  if (_scrimShouldAdoptTrackingScrollViewBackgroundColor !=
      scrimShouldAdoptTrackingScrollViewBackgroundColor) {
    _scrimShouldAdoptTrackingScrollViewBackgroundColor =
        scrimShouldAdoptTrackingScrollViewBackgroundColor;
    [self updateScrimViewColor];
  }
  self.shadowedView.layer.shadowColor = _scrimShouldAdoptTrackingScrollViewBackgroundColor
                                            ? UIColor.clearColor.CGColor
                                            : self.drawerShadowColor.CGColor;
}

- (void)updateScrimViewColor {
  if ([self.delegate respondsToSelector:@selector
                     (bottomDrawerContainerViewControllerNeedsScrimAppearanceUpdate:
                                  scrimShouldAdoptTrackingScrollViewBackgroundColor:)]) {
    [self.delegate bottomDrawerContainerViewControllerNeedsScrimAppearanceUpdate:self
                               scrimShouldAdoptTrackingScrollViewBackgroundColor:
                                   _scrimShouldAdoptTrackingScrollViewBackgroundColor];
  }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    if ([self.traitCollection
            hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
      [self updateScrimViewColor];
    }
  }
#endif
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  CGFloat drawerOffset = self.contentHeaderTopInset - self.topAreaInsetForHeader;
  CGFloat calculatedYContentOffset =
      _scrollToContentOffsetY - self.trackingScrollView.contentOffset.y + drawerOffset;
  self.scrollView.contentOffset =
      CGPointMake(self.scrollView.contentOffset.x, calculatedYContentOffset);
  _scrollToContentOffsetY = 0;
}

- (void)expandToFullscreenWithDuration:(CGFloat)duration
                            completion:(void (^__nullable)(BOOL finished))completion {
  _contentHeaderTopInset = NSNotFound;
  _contentHeightSurplus = NSNotFound;
  _addedContentHeight = NSNotFound;
  _shouldPresentAtFullscreen = YES;
  [self cacheLayoutCalculations];
  [UIView animateWithDuration:duration
                   animations:^{
                     [self setupLayout];
                   }
                   completion:completion];
}

#pragma mark UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setUpContentHeader];

  self.view.backgroundColor = [UIColor clearColor];

  [self.view addSubview:self.scrollView];

  // Top header shadow layer starts as hidden.
  self.headerShadowLayer.hidden = YES;

  // Set up the content.
  if (self.contentViewController) {
    [self addChildViewController:self.contentViewController];
    [self.scrollView addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    [self.scrollView insertSubview:self.shadowedView atIndex:0];

    // Set up accessibility support.
    UIView *contentAccessibilityElement =
        self.trackingScrollView ?: self.contentViewController.view;
    self.scrollView.accessibilityElements =
        self.hasHeaderViewController
            ? @[ self.headerViewController.view, contentAccessibilityElement ]
            : @[ contentAccessibilityElement ];
    self.view.accessibilityElements = @[ self.scrollView ];
  }

  self.scrollView.accessibilityIdentifier = kMDCBottomDrawerScrollViewAccessibilityIdentifier;

  self.shadowedView.layer.shadowColor = self.drawerShadowColor.CGColor;
  self.shadowedView.backgroundColor = UIColor.clearColor;
  self.shadowedView.shadowLayer.elevation = self.elevation;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self addScrollViewObserver];

  // Scroll view should not update its content insets implicitly.
  if (@available(iOS 11.0, *)) {
    self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.scrollView.insetsLayoutMarginsFromSafeArea = NO;
  }
}

- (void)setupLayout {
  // Layout the scroll view.
  CGRect scrollViewFrame = self.presentingViewBounds;
  if (!self.currentlyFullscreen && self.animatingPresentation) {
    CGFloat heightSurplusForSpringAnimationOvershooting = self.presentingViewBounds.size.height / 2;
    scrollViewFrame.size.height += heightSurplusForSpringAnimationOvershooting;
  }
  // Adjust height of scroll view to account for non-fullscreen presentation styles.
  scrollViewFrame.size.height += self.presentingViewYOffset;
  self.scrollView.frame = scrollViewFrame;

  // Layout the top header's bottom shadow.
  [self setUpHeaderBottomShadowIfNeeded];
  self.headerShadowLayer.frame = self.headerViewController.view.bounds;

  // Set the scroll view's content size.
  CGSize scrollViewContentSize = self.presentingViewBounds.size;
  scrollViewContentSize.height += self.contentHeightSurplus;
  self.scrollView.contentSize = scrollViewContentSize;

  // Layout the main content view.
  CGRect contentViewFrame = self.scrollView.bounds;
  contentViewFrame.origin.y = self.contentHeaderTopInset + self.contentHeaderHeight;
  if (self.trackingScrollView != nil) {
    contentViewFrame.size.height -= self.contentHeaderHeight - kScrollViewBufferForPerformance;
    // We add the topAreaInsetForHeader to the height of the content view frame when a tracking
    // scroll view is set, to normalize the algorithm after the removal of this value from the
    // topAreaInsetForHeader inside the updateContentOffsetForPerformantScrolling method.
    if (self.contentHeaderTopInset > self.topAreaInsetForHeader + kEpsilon) {
      contentViewFrame.size.height += self.topAreaInsetForHeader;
    }
  } else {
    contentViewFrame.size.height = _contentVCPreferredContentSizeHeightCached;
    if ([self shouldPresentFullScreen]) {
      contentViewFrame.size.height =
          MAX(contentViewFrame.size.height,
              self.presentingViewBounds.size.height - self.topHeaderHeight);
    }
  }
  self.contentViewController.view.frame = contentViewFrame;
  if (self.trackingScrollView != nil) {
    contentViewFrame.origin.y = self.trackingScrollView.frame.origin.y;
    self.trackingScrollView.frame = contentViewFrame;
  }
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  if (self.adjustLayoutForIPadSlideOver) {
    // Have _contentHeaderTopInset recalculated the next time self.contentHeaderTopInset is called
    // so it has the correct value when the app is in iPad Slide Over.
    _contentHeaderTopInset = NSNotFound;
  }

  [self setupLayout];
  UIView *topView;
  if (self.headerViewController) {
    topView = self.headerViewController.view;
  } else {
    topView = self.contentViewController.view;
  }
  self.shadowedView.frame = topView.frame;
  if (topView.layer.mask) {
    CAShapeLayer *shapeLayer = topView.layer.mask;
    self.shadowedView.layer.shadowPath = shapeLayer.path;
  }

  [self.headerViewController.view.superview bringSubviewToFront:self.headerViewController.view];
  [self updateViewWithContentOffset:self.scrollView.contentOffset];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self removeScrollViewObserver];
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];

  if (!_shouldAdjustOnContentSizeChange) {
    if ([container isKindOfClass:[UIViewController class]]) {
      UIViewController *containerViewController = (UIViewController *)container;
      if (containerViewController == self.contentViewController) {
        self.maximumInitialDrawerHeight = [self calculateMaximumInitialDrawerHeight];
      }
    }
  }
  _shouldPresentAtFullscreen = NO;
  _contentHeaderTopInset = NSNotFound;
  _contentHeightSurplus = NSNotFound;
  _addedContentHeight = NSNotFound;
  [self.view setNeedsLayout];
}

- (CGFloat)calculateMaximumInitialDrawerHeight {
  if (MDCCGFloatEqual(_contentVCPreferredContentSizeHeightCached, 0)) {
    [self cacheLayoutCalculations];
  }
  CGFloat totalHeight = self.headerViewController.preferredContentSize.height +
                        _contentVCPreferredContentSizeHeightCached;
  const CGFloat maximumInitialHeight = _maximumInitialDrawerHeight;
  if (totalHeight > maximumInitialHeight ||
      MDCCGFloatEqual(_contentVCPreferredContentSizeHeightCached,
                      [self bottomSafeAreaInsetsToAdjustContainerHeight])) {
    // Have the drawer height stay its current size in cases where the content preferred content
    // size is still not updated, or when the content height and header height are bigger than the
    // initial height.
    totalHeight = maximumInitialHeight;
  }
  return totalHeight;
}

- (CGFloat)bottomSafeAreaInsetsToAdjustContainerHeight {
  if (@available(iOS 11.0, *)) {
    if (self.shouldIncludeSafeAreaInContentHeight) {
      return self.view.safeAreaInsets.bottom;
    }
  }
  return 0;
}

- (CGFloat)bottomSafeAreaInsetsToAdjustInitialDrawerHeight {
  if (@available(iOS 11.0, *)) {
    if (self.shouldIncludeSafeAreaInInitialDrawerHeight) {
      return self.view.safeAreaInsets.bottom;
    }
  }
  return 0;
}

#pragma mark Set ups (Private)

- (void)setUpContentHeader {
  if (!self.headerViewController) {
    return;
  }

  [self addChildViewController:self.headerViewController];
  if ([self.headerViewController
          respondsToSelector:@selector(updateDrawerHeaderTransitionRatio:)]) {
    [self.headerViewController updateDrawerHeaderTransitionRatio:0];
  }

  // Ensures the content header view has a sensible size so its subview layout correctly
  // before the drawer presentation animation.
  CGRect headerViewFrame = self.presentingViewBounds;
  headerViewFrame.size.height = self.contentHeaderHeight;
  self.headerViewController.view.frame = headerViewFrame;

  [self.scrollView addSubview:self.headerViewController.view];
  [self.headerViewController didMoveToParentViewController:self];
}

- (void)setUpHeaderBottomShadowIfNeeded {
  if (self.headerShadowLayer) {
    // Duplicated from below to support dynamic color updates
    self.headerShadowLayer.shadowColor = self.headerShadowColor.CGColor;
    return;
  }

  self.headerShadowLayer = [[MDCShadowLayer alloc] init];
  // The header acts as an AppBar, so it keeps the same elevation value.
  self.headerShadowLayer.elevation = MDCShadowElevationAppBar;
  self.headerShadowLayer.shadowColor = self.headerShadowColor.CGColor;
  [self.headerViewController.view.layer addSublayer:self.headerShadowLayer];
  self.headerShadowLayer.hidden = YES;
}

#pragma mark Content Offset Adaptions (Private)

- (void)updateViewWithContentOffset:(CGPoint)contentOffset {
  CGFloat transitionPercentage =
      [self transitionPercentageForContentOffset:contentOffset
                                          offset:0
                                        distance:self.headerAnimationDistance];
  CGFloat headerTransitionToTop =
      contentOffset.y >= self.transitionCompleteContentOffset ? 1 : transitionPercentage;
  CGFloat adjustedTransitionRatio = transitionPercentage;
  // The transition ratio is adjusted if the sticky status bar view is being used in place of a
  // headerViewController to prevent presentation issues with corner radius not being kept in sync
  // with the animation of the sticky view's expansion.
  if (!self.hasHeaderViewController && self.shouldUseStickyStatusBar) {
    adjustedTransitionRatio = (adjustedTransitionRatio > 0) ? 1 : 0;
  }
  [self.delegate bottomDrawerContainerViewControllerTopTransitionRatio:self
                                                       transitionRatio:adjustedTransitionRatio];
  [self updateDrawerState:adjustedTransitionRatio];

  self.currentlyFullscreen =
      self.contentReachesFullscreen && headerTransitionToTop >= 1 && contentOffset.y > 0;
  // If we are using maximumDrawerHeight then the drawer is not in full screen until it has scrolled
  // the `contentHeaderTopInset` distance, as typically it assumes it needs to scroll the
  // `contentHeaderTopInset` minus the safeAreaInsets.top.
  if ([self shouldUseMaximumDrawerHeight]) {
    self.currentlyFullscreen = contentOffset.y > self.contentHeaderTopInset ? YES : NO;
  }
  CGFloat fullscreenHeaderHeight =
      self.contentReachesFullscreen ? self.topHeaderHeight : [self contentHeaderHeight];

  CGFloat contentHeight =
      _contentVCPreferredContentSizeHeightCached + _headerVCPerferredContentSizeHeightCached;
  if (self.shouldAlwaysExpandHeader && (contentHeight < self.presentingViewBounds.size.height)) {
    // Make sure the content offset is greater than the content height surplus or we will divide
    // by 0.
    if (contentOffset.y > self.contentHeightSurplus) {
      CGFloat additionalScrollPassedMaxHeight =
          self.contentHeaderTopInset - (self.contentHeightSurplus + self.topSafeAreaInset);
      fullscreenHeaderHeight = self.topHeaderHeight;
      headerTransitionToTop =
          MIN(1, (contentOffset.y - self.contentHeightSurplus) / additionalScrollPassedMaxHeight);
    }
  }

  [self updateContentHeaderWithTransitionToTop:headerTransitionToTop
                        fullscreenHeaderHeight:fullscreenHeaderHeight];
  [self updateTopHeaderBottomShadowWithContentOffset:contentOffset];
  [self updateContentWithHeight:contentOffset.y];

  // Calculate the current yOffset of the header and content.
  CGFloat yOffset = self.contentViewController.view.frame.origin.y -
                    self.headerViewController.view.frame.size.height - contentOffset.y;

  // While animating open or closed, always send back the final target Y offset.
  if (self.animatingPresentation) {
    yOffset = self.contentHeaderTopInset;
  }
  if (self.animatingDismissal) {
    yOffset = self.view.frame.size.height;
  }

  [self.delegate bottomDrawerContainerViewControllerDidChangeYOffset:self
                                                             yOffset:MAX(0.0f, yOffset)];
}

- (void)updateContentHeaderWithTransitionToTop:(CGFloat)headerTransitionToTop
                        fullscreenHeaderHeight:(CGFloat)fullscreenHeaderHeight {
  if (!self.shouldUseStickyStatusBar && !self.hasHeaderViewController) {
    return;
  }

  if (self.hasHeaderViewController &&
      [self.headerViewController
          respondsToSelector:@selector(updateDrawerHeaderTransitionRatio:)]) {
    if (self.shouldAlwaysExpandHeader) {
      [self.headerViewController updateDrawerHeaderTransitionRatio:headerTransitionToTop];
    } else {
      [self.headerViewController updateDrawerHeaderTransitionRatio:self.contentReachesFullscreen
                                                                       ? headerTransitionToTop
                                                                       : 0];
    }
  }

  UIView *contentHeaderView =
      self.hasHeaderViewController ? self.headerViewController.view : self.topSafeAreaView;
  if (self.currentlyFullscreen && contentHeaderView.superview != self.view) {
    // The content header should be located statically at the top of the drawer when the drawer
    // is shown in fullscreen.
    [contentHeaderView removeFromSuperview];
    [self.view addSubview:contentHeaderView];
    [self.view setNeedsLayout];
  } else if (!self.currentlyFullscreen && contentHeaderView.superview != self.scrollView) {
    // The content header should be scrolled together with the rest of the content when the drawer
    // is not in fullscreen.
    [contentHeaderView removeFromSuperview];
    [self.scrollView addSubview:contentHeaderView];
    [self.view setNeedsLayout];
  }

  CGFloat contentHeaderHeight = self.contentHeaderHeight;
  CGFloat headersDiff = fullscreenHeaderHeight - contentHeaderHeight;
  if ([self shouldUseMaximumDrawerHeight]) {
    headersDiff = 0;
  }
  CGFloat contentHeaderViewHeight = contentHeaderHeight + headerTransitionToTop * headersDiff;
  CGFloat contentHeaderViewWidth = self.presentingViewBounds.size.width;
  CGFloat contentHeaderViewTop =
      self.currentlyFullscreen ? 0
                               : self.contentHeaderTopInset - headerTransitionToTop * headersDiff;
  // If we should be using the `maximumDrawerHeight` property then we reset the header height to be
  // its original height and its origin to be the views height minus the drawer height.
  if (self.currentlyFullscreen && [self shouldUseMaximumDrawerHeight]) {
    contentHeaderViewTop = CGRectGetHeight(self.view.frame) - self.maximumDrawerHeight;
    contentHeaderViewHeight = self.contentHeaderHeight;
  }
  contentHeaderView.frame =
      CGRectMake(0, contentHeaderViewTop, contentHeaderViewWidth, contentHeaderViewHeight);
  self.shadowedView.frame = contentHeaderView.frame;
  if (self.headerViewController.view.layer.mask) {
    CAShapeLayer *shapeLayer = self.headerViewController.view.layer.mask;
    self.shadowedView.layer.shadowPath = shapeLayer.path;
  }
}

- (void)updateTopHeaderBottomShadowWithContentOffset:(CGPoint)contentOffset {
  self.headerShadowLayer.hidden = !self.currentlyFullscreen;
  if (!self.headerShadowLayer.hidden) {
    self.headerShadowLayer.opacity =
        (float)[self transitionPercentageForContentOffset:contentOffset
                                                   offset:-kVerticalShadowAnimationDistance
                                                 distance:kVerticalShadowAnimationDistance];
  }
}

- (void)updateContentWithHeight:(CGFloat)height {
  if (self.trackingScrollView != nil) {
    return;
  }
  if (height < 0) {
    height = 0;
  }
  // This is added so we don't recursively add height
  CGFloat previousAddedHeight = self.addedHeight;
  self.addedHeight = height;
  CGFloat heightToAdd = self.addedHeight - previousAddedHeight;
  if (self.contentViewController) {
    CGRect contentViewFrame = CGRectStandardize(self.contentViewController.view.frame);
    contentViewFrame.size =
        CGSizeMake(contentViewFrame.size.width, contentViewFrame.size.height + heightToAdd);
    self.contentViewController.view.frame = contentViewFrame;
  }
}

#pragma mark Getters (Private)

- (UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[MDCBottomDrawerScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
  }
  return _scrollView;
}

- (UIView *)topSafeAreaView {
  if (!_topSafeAreaView) {
    _topSafeAreaView = [[UIView alloc] init];
    _topSafeAreaView.backgroundColor = self.trackingScrollView
                                           ? self.trackingScrollView.backgroundColor
                                           : self.contentViewController.view.backgroundColor;
  }
  return _topSafeAreaView;
}

- (CGFloat)contentHeaderTopInset {
  if (_contentHeaderTopInset == NSNotFound) {
    [self cacheLayoutCalculations];
  }
  return _contentHeaderTopInset;
}

- (CGFloat)contentHeightSurplus {
  if (_contentHeightSurplus == NSNotFound) {
    [self cacheLayoutCalculations];
  }
  return _contentHeightSurplus;
}

- (CGFloat)addedContentHeight {
  if (_addedContentHeight == NSNotFound) {
    [self cacheLayoutCalculations];
  }
  return _addedContentHeight;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  _contentHeaderTopInset = NSNotFound;
  _contentHeightSurplus = NSNotFound;
  _addedContentHeight = NSNotFound;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _trackingScrollView = trackingScrollView;
  _contentHeaderTopInset = NSNotFound;
  _contentHeightSurplus = NSNotFound;
  _addedContentHeight = NSNotFound;
  [self cacheLayoutCalculations];
}

#pragma mark UIScrollViewDelegate (Private)

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  self.scrollViewBeganDraggingFromFullscreen = self.currentlyFullscreen;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  BOOL scrollViewBeganDraggingFromFullscreen = self.scrollViewBeganDraggingFromFullscreen;
  self.scrollViewBeganDraggingFromFullscreen = NO;

  if (!scrollViewBeganDraggingFromFullscreen &&
      velocity.y < kDragVelocityThresholdForHidingDrawer) {
    [self hideDrawer];
    return;
  }

  if (self.scrollView.contentOffset.y < 0) {
    // This adjustment ensures that for drawer contents that are quite small (ex. 100pt) the drawer
    // contents to not become undismissable. Without this adjustment it is nearly impossible to
    // achieve a scroll offset of (40pt), the current `kVerticalDistanceDismissalThreshold`, making
    // the drawer effectively undismissable.
    CGFloat drawerContentHeight = self.contentViewController.preferredContentSize.height +
                                  self.headerViewController.preferredContentSize.height;
    BOOL adjustDismissalThreshold =
        drawerContentHeight <
        (kVerticalDistanceDismissalThreshold * kVerticalDistanceDismissalThresholdMultiplier);
    CGFloat verticalDistanceDismissalThreshold =
        adjustDismissalThreshold
            ? (drawerContentHeight / kVerticalDistanceDismissalThresholdMultiplier)
            : kVerticalDistanceDismissalThreshold;

    if (self.scrollView.contentOffset.y < -verticalDistanceDismissalThreshold) {
      [self hideDrawer];
    } else {
      targetContentOffset->y = 0;
    }
    return;
  }

  CGFloat scrollToContentOffsetY =
      [self midAnimationScrollToPositionForOffset:*targetContentOffset];
  if (scrollToContentOffsetY != NSNotFound) {
    targetContentOffset->y = scrollToContentOffsetY;
  }
}

@end

#pragma mark - MDCBottomDrawerContainerViewController + Layout Calculations

@implementation MDCBottomDrawerContainerViewController (LayoutCalculations)

- (void)cacheLayoutCalculations {
  [self cacheLayoutCalculationsWithAddedContentHeight:0];
}

- (void)cacheLayoutCalculationsWithAddedContentHeight:(CGFloat)addedContentHeight {
  CGFloat contentHeaderHeight = self.contentHeaderHeight;
  // Adjust height of container to account for non-fullscreen presentation styles.
  CGFloat containerHeight = self.presentingViewBounds.size.height + self.presentingViewYOffset;
  CGFloat contentHeight = self.contentViewController.preferredContentSize.height +
                          [self bottomSafeAreaInsetsToAdjustContainerHeight];
  if ([self shouldPresentFullScreen]) {
    contentHeight = MAX(contentHeight, containerHeight - self.topHeaderHeight);
  }
  _contentVCPreferredContentSizeHeightCached = contentHeight;
  _headerVCPerferredContentSizeHeightCached = contentHeaderHeight;

  contentHeight += addedContentHeight;
  _addedContentHeight = addedContentHeight;

  CGFloat totalHeight = contentHeight + contentHeaderHeight;
  BOOL contentScrollsToReveal = totalHeight >= self.maximumInitialDrawerHeight;

  if (_contentHeaderTopInset == NSNotFound) {
    // The content header top inset is only set once.
    if (contentScrollsToReveal || _shouldPresentAtFullscreen) {
      _contentHeaderTopInset =
          MIN(containerHeight, containerHeight - self.maximumInitialDrawerHeight);
      // In some cases, the contentHeaderTopInset calculation above which decides the
      // drawer's initial offset will not align with the content offset UIKit provides
      // for the scrollView, and there may be a slight delta between both numbers.
      // This will cause unexpected behaviors in the
      // `updateContentOffsetForPerformantScrolling` method because the contentDiff
      // will not necessarily be 0 when there is no scrolling delta.
      // Therefore by rounding we are able to align to a reasonable content offset.
      _contentHeaderTopInset = MDCRound(_contentHeaderTopInset);
      // The minimum inset value should be the size of the safe area inset, as
      // kInitialDrawerHeightFactor discounts the safe area when receiving the height factor.
      // If we are using `maximumDrawerHeight` then we assume that the drawer does not go into the
      // safe area so we allow a value less than the size of the safe area inset.
      if (_contentHeaderTopInset <= self.topHeaderHeight - self.contentHeaderHeight &&
          ![self shouldUseMaximumDrawerHeight]) {
        _contentHeaderTopInset = self.topHeaderHeight - self.contentHeaderHeight + kEpsilon;
      }
    } else {
      _contentHeaderTopInset = containerHeight - totalHeight;
    }
  }

  CGFloat scrollingDistance = _contentHeaderTopInset + totalHeight;
  _contentHeightSurplus = scrollingDistance - containerHeight;
  if ([self shouldPresentFullScreen]) {
    self.drawerState = MDCBottomDrawerStateFullScreen;
  } else if (_contentHeightSurplus <= 0) {
    self.drawerState = MDCBottomDrawerStateExpanded;
  } else {
    self.drawerState = MDCBottomDrawerStateCollapsed;
  }
  if (addedContentHeight < kEpsilon && containerHeight > totalHeight &&
      (_contentHeaderTopInset - _contentHeightSurplus < self.topSafeAreaInset)) {
    CGFloat addedContentheight = _contentHeaderTopInset - _contentHeightSurplus;
    [self cacheLayoutCalculationsWithAddedContentHeight:addedContentheight];
  }
}

- (CGFloat)transitionPercentageForContentOffset:(CGPoint)contentOffset
                                         offset:(CGFloat)offset
                                       distance:(CGFloat)distance {
  // If the distance is zero or negative there is no distance for a transition to occur and
  // therefore it is set to one (100%). Rather than comparing precisely against `0`, comparison is
  // done against the almost-zero value that is used throughout the calculations performed in this
  // class.
  if (distance <= kEpsilon) {
    return 1;
  }
  return 1 - MAX(0, MIN(1, (self.transitionCompleteContentOffset - contentOffset.y - offset) /
                               distance));
}

- (CGFloat)midAnimationScrollToPositionForOffset:(CGPoint)targetContentOffset {
  if (!self.contentScrollsToReveal || !self.contentReachesFullscreen) {
    return NSNotFound;
  }

  CGFloat headerAnimationDistance = self.headerAnimationDistance;
  CGFloat headerTransitionToTop =
      [self transitionPercentageForContentOffset:targetContentOffset
                                          offset:0
                                        distance:headerAnimationDistance];
  if (headerTransitionToTop >= kEpsilon && headerTransitionToTop < 1) {
    CGFloat contentHeaderFullyCoversTopHeaderContentOffset = self.transitionCompleteContentOffset;
    CGFloat contentHeaderReachesTopHeaderContentOffset =
        contentHeaderFullyCoversTopHeaderContentOffset - headerAnimationDistance;
    return self.scrollViewIsDraggedToBottom ? contentHeaderReachesTopHeaderContentOffset
                                            : contentHeaderFullyCoversTopHeaderContentOffset;
  }

  return NSNotFound;
}

@end

#pragma mark - MDCBottomDrawerContainerViewController + Layout Values

@implementation MDCBottomDrawerContainerViewController (LayoutValues)

- (CGRect)presentingViewBounds {
  if ([self shouldUseMaximumDrawerHeight]) {
    CGRect originalBounds = CGRectStandardize(self.originalPresentingViewController.view.bounds);
    return CGRectMake(originalBounds.origin.x,
                      originalBounds.size.height - self.maximumDrawerHeight,
                      originalBounds.size.width, self.maximumDrawerHeight);
  }
  return CGRectStandardize(self.originalPresentingViewController.view.bounds);
}

- (CGFloat)presentingViewYOffset {
  CGFloat yOffset = CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.presentingViewBounds);
  if (yOffset > 0 && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular &&
      ![self shouldUseMaximumDrawerHeight]) {
    return yOffset;
  }
  return 0;
}

- (BOOL)contentScrollsToReveal {
  return self.contentHeightSurplus > kEpsilon;
}

- (CGFloat)topHeaderHeight {
  if (self.hasHeaderViewController) {
    CGFloat headerHeight = self.headerViewController.preferredContentSize.height;
    return headerHeight + self.topSafeAreaInset;
  }
  return self.topSafeAreaInset;
}

- (CGFloat)topAreaInsetForHeader {
  if (self.hasHeaderViewController) {
    return self.topSafeAreaInset;
  }
  return 0;
}

- (CGFloat)contentHeaderHeight {
  if (self.hasHeaderViewController) {
    return self.headerViewController.preferredContentSize.height;
  }
  return 0;
}

- (CGFloat)transitionCompleteContentOffset {
  if (self.contentReachesFullscreen) {
    CGFloat transitionCompleteContentOffset = self.contentHeaderTopInset;
    transitionCompleteContentOffset -= self.topHeaderHeight - self.contentHeaderHeight;
    return transitionCompleteContentOffset;
  } else {
    return self.contentHeightSurplus;
  }
}

- (CGFloat)headerAnimationDistance {
  // `contentHeightSurplus` already accounts for the `presentingViewYOffset` but the constant
  // `kHeaderAnimationDistanceAddedDistanceFromTopSafeAreaInset` does not, so it is adjusted here.
  CGFloat headerAnimationDistance =
      MIN(kHeaderAnimationDistanceAddedDistanceFromTopSafeAreaInset + self.presentingViewYOffset,
          self.contentHeightSurplus);
  if (self.contentReachesFullscreen) {
    headerAnimationDistance += self.topSafeAreaInset;
  }
  return headerAnimationDistance;
}

@end
