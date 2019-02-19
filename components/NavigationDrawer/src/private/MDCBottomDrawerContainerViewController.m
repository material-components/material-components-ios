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
#import "MDCBottomDrawerHeaderMask.h"
#import "MaterialMath.h"
#import "MaterialShadowLayer.h"
#import "MaterialUIMetrics.h"

static const CGFloat kVerticalShadowAnimationDistance = 10;
static const CGFloat kVerticalDistanceThresholdForDismissal = 40;
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
static NSString *const kContentOffsetKeyPath = @"contentOffset";
NSString *const kMDCBottomDrawerScrollViewAccessibilityIdentifier =
    @"kMDCBottomDrawerScrollViewAccessibilityIdentifier";

static UIColor *DrawerShadowColor(void) {
  return [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.2];
}

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

// Whether the content height exceeds the visible height when it's first displayed.
@property(nonatomic, readonly) BOOL contentScrollsToReveal;

// The top header height when the drawer is displayed in fullscreen.
@property(nonatomic, readonly) CGFloat topHeaderHeight;

// The content header height when the drawer is first displayed.
@property(nonatomic, readonly) CGFloat contentHeaderHeight;

// The vertical content offset where the transition animation completes.
@property(nonatomic, readonly) CGFloat transitionCompleteContentOffset;

// The headers animation distance.
@property(nonatomic, readonly) CGFloat headerAnimationDistance;

// The distance to top threshold for adding extra content height.
@property(nonatomic, readonly) CGFloat addedContentHeightThreshold;

@end

@interface MDCBottomDrawerContainerViewController () <UIScrollViewDelegate>

// Whether the scroll view is observed via KVO.
@property(nonatomic) BOOL scrollViewObserved;

// The scroll view is currently being dragged towards bottom.
@property(nonatomic) BOOL scrollViewIsDraggedToBottom;

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

// Updates both the header and content based off content offset of the scroll view.
- (void)updateViewWithContentOffset:(CGPoint)contentOffset;

/**
 The height of the drawer at initial layout. This value is a percentage between 0-100% (0-1).
 - 1 or 100% indicates the drawer is full screen.
 - 0 or 0% indicates that drawer if hidden.

 @note In voiceover and landscape this value will be 1.
 */
@property(nonatomic) CGFloat initialDrawerFactor;

// Calculates the initial drawer factor.
- (CGFloat)calculateInitialDrawerFactor;

@end

@implementation MDCBottomDrawerContainerViewController {
  UIScrollView *_scrollView;
  CGFloat _contentHeaderTopInset;
  CGFloat _contentHeightSurplus;
  CGFloat _addedContentHeight;
  CGFloat _contentVCPreferredContentSizeHeightCached;
  CGFloat _scrollToContentOffsetY;
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
    _initialDrawerFactor = (CGFloat)0.5;
    _shouldPresentAtFullscreen = NO;
  }
  return self;
}

- (void)dealloc {
  [self removeScrollViewObserver];
  [self.headerShadowLayer removeFromSuperlayer];
  self.headerShadowLayer = nil;
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hideDrawer {
  [self.originalPresentingViewController dismissViewControllerAnimated:YES completion:nil];
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
  CGFloat topAreaInsetForHeader = (self.headerViewController ? MDCDeviceTopSafeAreaInset() : 0);
  // The top area inset for header should be a positive non zero value for the algorithm to
  // correctly work when the drawer is presented in full screen and there is no top inset.
  // The reason being is that otherwise there would be a conflict between if the drawer is currently
  // in full screen and we should move the header view outside the scrollview to remain sticky, or
  // if we aren't in full screen and need the header view to be scrolled as part of the scrolling.
  if (self.contentHeaderTopInset <= topAreaInsetForHeader + kEpsilon) {
    topAreaInsetForHeader = kEpsilon;
  }
  CGFloat drawerOffset =
      self.contentHeaderTopInset - topAreaInsetForHeader + kScrollViewBufferForPerformance;
  CGFloat headerHeightWithoutInset = self.contentHeaderHeight - topAreaInsetForHeader;
  CGFloat contentDiff = contentYOffset - drawerOffset;
  CGFloat maxScrollOrigin = self.trackingScrollView.contentSize.height -
                            CGRectGetHeight(self.presentingViewBounds) + headerHeightWithoutInset -
                            kScrollViewBufferForPerformance;
  BOOL scrollingUpInFull = contentDiff < 0 && CGRectGetMinY(self.trackingScrollView.bounds) > 0;

  if (CGRectGetMinY(self.scrollView.bounds) >= drawerOffset || scrollingUpInFull) {
    // If we reach full screen or if we are scrolling up after being in full screen.
    if (CGRectGetMinY(self.trackingScrollView.bounds) < maxScrollOrigin || scrollingUpInFull) {
      // If we still didn't reach the end of the content, or if we are scrolling up after reaching
      // the end of the content.

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

/**
 The drawer height factor defines how much percentage of the screen space the drawer will take up
 when displayed. The expected range is 0 - 1 (0% - 100%).

 Default value is 0.5. If VoiceOver is enabled, or the mobile device is in landscape,
 the default value becomes 1.0.
 */
- (CGFloat)initialDrawerFactor {
  if ([self shouldPresentFullScreen]) {
    return 1;
  }
  return _initialDrawerFactor;
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
    self.drawerState = self.contentReachesFullscreen ? MDCBottomDrawerStateFullScreen
                                                     : MDCBottomDrawerStateExpanded;
  } else {
    self.drawerState = MDCBottomDrawerStateCollapsed;
  }
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated {
  _scrollToContentOffsetY = contentOffsetY;
  CGFloat topAreaInsetForHeader = (self.headerViewController ? MDCDeviceTopSafeAreaInset() : 0);
  CGFloat drawerOffset = self.contentHeaderTopInset - topAreaInsetForHeader;
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

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  CGFloat topAreaInsetForHeader = (self.headerViewController ? MDCDeviceTopSafeAreaInset() : 0);
  CGFloat drawerOffset = self.contentHeaderTopInset - topAreaInsetForHeader;
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
      completion:^(BOOL completed) {
        completion(completed);
      }];
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
  }

  self.scrollView.accessibilityIdentifier = kMDCBottomDrawerScrollViewAccessibilityIdentifier;
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
  // Layout the clipping view and the scroll view.
  if (self.currentlyFullscreen) {
    CGRect scrollViewFrame = self.presentingViewBounds;
    self.scrollView.frame = scrollViewFrame;
  } else {
    CGRect scrollViewFrame = self.presentingViewBounds;
    if (self.animatingPresentation) {
      CGFloat heightSurplusForSpringAnimationOvershooting =
          self.presentingViewBounds.size.height / 2;
      scrollViewFrame.size.height += heightSurplusForSpringAnimationOvershooting;
    }
    self.scrollView.frame = scrollViewFrame;
  }

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
    CGFloat topAreaInsetForHeader = (self.headerViewController ? MDCDeviceTopSafeAreaInset() : 0);
    contentViewFrame.size.height -= self.contentHeaderHeight - kScrollViewBufferForPerformance;
    // We add the topAreaInsetForHeader to the height of the content view frame when a tracking
    // scroll view is set, to normalize the algorithm after the removal of this value from the
    // topAreaInsetForHeader inside the updateContentOffsetForPerformantScrolling method.
    if (self.contentHeaderTopInset > topAreaInsetForHeader + kEpsilon) {
      contentViewFrame.size.height += topAreaInsetForHeader;
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

  [self setupLayout];
  [self.headerViewController.view.superview bringSubviewToFront:self.headerViewController.view];
  [self updateViewWithContentOffset:self.scrollView.contentOffset];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self removeScrollViewObserver];
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];
  if ([container isKindOfClass:[UIViewController class]]) {
    UIViewController *containerViewController = (UIViewController *)container;
    if (containerViewController == self.contentViewController) {
      self.initialDrawerFactor = [self calculateInitialDrawerFactor];
    }
  }
  _shouldPresentAtFullscreen = NO;
  _contentHeaderTopInset = NSNotFound;
  _contentHeightSurplus = NSNotFound;
  _addedContentHeight = NSNotFound;
  [self.view setNeedsLayout];
}

- (CGFloat)calculateInitialDrawerFactor {
  if (MDCCGFloatEqual(_contentVCPreferredContentSizeHeightCached, 0)) {
    [self cacheLayoutCalculations];
  }
  CGFloat totalHeight = self.headerViewController.preferredContentSize.height +
                        _contentVCPreferredContentSizeHeightCached;
  CGFloat precentageOfFullScreen = totalHeight / self.presentingViewBounds.size.height;
  if (precentageOfFullScreen > 0.5) {
    precentageOfFullScreen = 0.5;
  }
  return precentageOfFullScreen;
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
    return;
  }

  self.headerShadowLayer = [[MDCShadowLayer alloc] init];
  self.headerShadowLayer.elevation = MDCShadowElevationNavDrawer;
  self.headerShadowLayer.shadowColor = DrawerShadowColor().CGColor;
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
  [self.delegate bottomDrawerContainerViewControllerTopTransitionRatio:self
                                                       transitionRatio:transitionPercentage];
  [self updateDrawerState:transitionPercentage];
  self.currentlyFullscreen = self.contentReachesFullscreen && headerTransitionToTop >= 1;
  CGFloat fullscreenHeaderHeight =
      self.contentReachesFullscreen ? self.topHeaderHeight : [self contentHeaderHeight];

  [self updateContentHeaderWithTransitionToTop:headerTransitionToTop
                        fullscreenHeaderHeight:fullscreenHeaderHeight];
  [self updateTopHeaderBottomShadowWithContentOffset:contentOffset];
  [self updateContentWithHeight:contentOffset.y];
}

- (void)updateContentHeaderWithTransitionToTop:(CGFloat)headerTransitionToTop
                        fullscreenHeaderHeight:(CGFloat)fullscreenHeaderHeight {
  if (!self.headerViewController) {
    return;
  }

  UIView *contentHeaderView = self.headerViewController.view;
  BOOL contentReachesFullscreen = self.contentReachesFullscreen;

  if ([self.headerViewController
          respondsToSelector:@selector(updateDrawerHeaderTransitionRatio:)]) {
    [self.headerViewController
        updateDrawerHeaderTransitionRatio:contentReachesFullscreen ? headerTransitionToTop : 0];
  }
  CGFloat contentHeaderHeight = self.contentHeaderHeight;
  CGFloat headersDiff = fullscreenHeaderHeight - contentHeaderHeight;
  CGFloat contentHeaderViewHeight = contentHeaderHeight + headerTransitionToTop * headersDiff;

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
  CGFloat contentHeaderViewWidth = self.presentingViewBounds.size.width;
  CGFloat contentHeaderViewTop =
      self.currentlyFullscreen ? 0
                               : self.contentHeaderTopInset - headerTransitionToTop * headersDiff;
  contentHeaderView.frame =
      CGRectMake(0, contentHeaderViewTop, contentHeaderViewWidth, contentHeaderViewHeight);
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
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
  }
  return _scrollView;
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
    if (self.scrollView.contentOffset.y < -kVerticalDistanceThresholdForDismissal) {
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
  CGFloat containerHeight = self.presentingViewBounds.size.height;
  CGFloat contentHeight = self.contentViewController.preferredContentSize.height;
  if ([self shouldPresentFullScreen]) {
    contentHeight = MAX(contentHeight, containerHeight - self.topHeaderHeight);
  }
  _contentVCPreferredContentSizeHeightCached = contentHeight;

  contentHeight += addedContentHeight;
  _addedContentHeight = addedContentHeight;

  CGFloat totalHeight = contentHeight + contentHeaderHeight;
  BOOL contentScrollsToReveal = totalHeight >= (containerHeight * [self initialDrawerFactor]);

  if (_contentHeaderTopInset == NSNotFound) {
    // The content header top inset is only set once.
    if (contentScrollsToReveal || _shouldPresentAtFullscreen) {
      _contentHeaderTopInset = containerHeight * (1 - [self initialDrawerFactor]);
      // The minimum inset value should be the size of the safe area inset, as
      // kInitialDrawerHeightFactor discounts the safe area when receiving the height factor.
      if (_contentHeaderTopInset <= self.topHeaderHeight - self.contentHeaderHeight) {
        _contentHeaderTopInset = self.topHeaderHeight - self.contentHeaderHeight + kEpsilon;
      }
    } else {
      _contentHeaderTopInset = containerHeight - totalHeight;
    }
  }

  CGFloat scrollingDistance = _contentHeaderTopInset + contentHeaderHeight + contentHeight;
  _contentHeightSurplus = scrollingDistance - containerHeight;
  if ([self shouldPresentFullScreen]) {
    self.drawerState = MDCBottomDrawerStateFullScreen;
  } else if (_contentHeightSurplus <= 0) {
    self.drawerState = MDCBottomDrawerStateExpanded;
  } else {
    self.drawerState = MDCBottomDrawerStateCollapsed;
  }
  if (addedContentHeight < kEpsilon && (_contentHeaderTopInset > _contentHeightSurplus) &&
      (_contentHeaderTopInset - _contentHeightSurplus < self.addedContentHeightThreshold)) {
    CGFloat addedContentheight = _contentHeaderTopInset - _contentHeightSurplus;
    [self cacheLayoutCalculationsWithAddedContentHeight:addedContentheight];
  }
}

- (CGFloat)transitionPercentageForContentOffset:(CGPoint)contentOffset
                                         offset:(CGFloat)offset
                                       distance:(CGFloat)distance {
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
  return CGRectStandardize(self.originalPresentingViewController.view.bounds);
}

- (BOOL)contentScrollsToReveal {
  return self.contentHeightSurplus > kEpsilon;
}

- (CGFloat)topHeaderHeight {
  if (!self.headerViewController) {
    return 0;
  }
  CGFloat headerHeight = self.headerViewController.preferredContentSize.height;
  return headerHeight + MDCDeviceTopSafeAreaInset();
}

- (CGFloat)contentHeaderHeight {
  if (!self.headerViewController) {
    return 0;
  }
  return self.headerViewController.preferredContentSize.height;
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
  CGFloat headerAnimationDistance =
      MIN(kHeaderAnimationDistanceAddedDistanceFromTopSafeAreaInset, self.contentHeightSurplus);
  if (self.contentReachesFullscreen) {
    headerAnimationDistance += MDCDeviceTopSafeAreaInset();
  }
  return headerAnimationDistance;
}

- (CGFloat)addedContentHeightThreshold {
  // TODO: (#4900) change this to use safeAreaInsets as this is a soon to be deprecated API.
  return MDCDeviceTopSafeAreaInset();
}

@end
