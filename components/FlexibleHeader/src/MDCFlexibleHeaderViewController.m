/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCFlexibleHeaderViewController.h"

#import "MDCFlexibleHeaderContainerViewController.h"
#import "MDCFlexibleHeaderView.h"

static inline CGFloat LuminanceForColor(UIColor *color) {
  // See http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
  CGFloat luminance = 1;
  CGFloat rgba[4];
  if ([color getRed:&rgba[0] green:&rgba[1] blue:&rgba[2] alpha:&rgba[3]]) {
    luminance = rgba[0] * 0.299f + rgba[1] * 0.587f + rgba[2] * 0.114f;
  }
  return luminance;
}

static inline BOOL ShouldUseLightOverlayForColor(UIColor *color) {
  return LuminanceForColor(color) < 0.55f;
}

@interface MDCFlexibleHeaderViewController () <MDCFlexibleHeaderViewDelegate>
@end

@implementation MDCFlexibleHeaderViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    MDCFlexibleHeaderView *headerView =
        [[MDCFlexibleHeaderView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    headerView.delegate = self;
    _headerView = headerView;
  }
  return self;
}

- (void)loadView {
  self.view = self.headerView;
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
  [super willMoveToParentViewController:parent];

  parent.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
  [super didMoveToParentViewController:parent];

  // The header depends on the tracking scroll view to know how tall it should be.
  // If there is no tracking scroll view then we have to poke the header into sizing itself.
  if (!_headerView.trackingScrollView) {
    [_headerView sizeToFit];
  } else {
    [_headerView trackingScrollViewDidScroll];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

#if DEBUG
  NSAssert(![self.parentViewController.parentViewController
               isKindOfClass:[MDCFlexibleHeaderContainerViewController class]],
           @"An instance of %@ has been injected into a view controller (%@) that is already"
           @" wrapped by an instance of %@ - this is not allowed and will cause double headers to"
           @" appear. Choose to either wrap or inject your view controller (preferring injection"
           @" where possible).",
           NSStringFromClass([self class]), NSStringFromClass([self.parentViewController class]),
           NSStringFromClass([MDCFlexibleHeaderContainerViewController class]));
#endif
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return (ShouldUseLightOverlayForColor(_headerView.backgroundColor) ? UIStatusBarStyleLightContent
                                                                     : UIStatusBarStyleDefault);
}

- (BOOL)prefersStatusBarHidden {
  return _headerView.prefersStatusBarHidden;
}

// Only include this logic when supporting pre-iOS 8 devices.
#if !defined(__IPHONE_8_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0)
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
  [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

  // Check if we're on iOS 8 and above and the new method will be called.
  if (![UIViewController instancesRespondToSelector:@selector(viewWillTransitionToSize:
                                                             withTransitionCoordinator:)]) {
    [_headerView interfaceOrientationWillChange];
  }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

  // Check if we're on iOS 8 and above and the new method will be called.
  if (![UIViewController instancesRespondToSelector:@selector(viewWillTransitionToSize:
                                                             withTransitionCoordinator:)]) {
    [_headerView interfaceOrientationIsChanging];
  }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

  // Check if we're on iOS 8 and above and the new method will be called.
  if (![UIViewController instancesRespondToSelector:@selector(viewWillTransitionToSize:
                                                             withTransitionCoordinator:)]) {
    [_headerView interfaceOrientationDidChange];
  }
}
#endif  // #if !defined(__IPHONE_8_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0)

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == _headerView.trackingScrollView) {
    [_headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == _headerView.trackingScrollView) {
    [_headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (scrollView == _headerView.trackingScrollView) {
    [_headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == _headerView.trackingScrollView) {
    [_headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                           targetContentOffset:targetContentOffset];
  }
}

#pragma mark MDCFlexibleHeaderViewDelegate

- (void)flexibleHeaderViewNeedsStatusBarAppearanceUpdate:(MDCFlexibleHeaderView *)headerView {
  [self setNeedsStatusBarAppearanceUpdate];
}

- (void)flexibleHeaderViewFrameDidChange:(MDCFlexibleHeaderView *)headerView {
  [self.layoutDelegate flexibleHeaderViewController:self
                   flexibleHeaderViewFrameDidChange:headerView];
}

@end
