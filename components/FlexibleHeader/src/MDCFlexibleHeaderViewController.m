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

#import "MDCFlexibleHeaderViewController.h"

#import "MaterialApplication.h"
#import "MDCFlexibleHeaderContainerViewController.h"
#import "MDCFlexibleHeaderView.h"
#import <MDFTextAccessibility/MDFTextAccessibility.h>

static inline BOOL ShouldUseLightStatusBarOnBackgroundColor(UIColor *color) {
  if (CGColorGetAlpha(color.CGColor) < 1) {
    return NO;
  }

  // We assume that the light iOS status text is white and not big enough to be considered "large"
  // text according to the W3CAG 2.0 spec.
  return [MDFTextAccessibility textColor:[UIColor whiteColor]
                 passesOnBackgroundColor:color
                                 options:MDFTextAccessibilityOptionsNone];
}

static NSString *const MDCFlexibleHeaderViewControllerHeaderViewKey =
    @"MDCFlexibleHeaderViewControllerHeaderViewKey";
static NSString *const MDCFlexibleHeaderViewControllerLayoutDelegateKey =
    @"MDCFlexibleHeaderViewControllerLayoutDelegateKey";

@interface MDCFlexibleHeaderViewController () <MDCFlexibleHeaderViewDelegate>

/**
 The current height offset of the flexible header controller with the addition of the current status
 bar state at any given time.

 This property is used to determine the bottom point of the |flexibleHeaderView| within the window.
 */
@property(nonatomic) CGFloat flexibleHeaderViewControllerHeightOffset;

/**
 The NSLayoutConstraint attached to the flexible header view controller's parentViewController's
 topLayoutGuide.
*/
@property(nonatomic, weak) id topLayoutGuideTopConstraint;

@end

@implementation MDCFlexibleHeaderViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    if ([aDecoder containsValueForKey:MDCFlexibleHeaderViewControllerHeaderViewKey]) {
      _headerView = [aDecoder decodeObjectOfClass:[MDCFlexibleHeaderView class]
                                           forKey:MDCFlexibleHeaderViewControllerHeaderViewKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderViewControllerLayoutDelegateKey]) {
      _layoutDelegate =
          [aDecoder decodeObjectForKey:MDCFlexibleHeaderViewControllerLayoutDelegateKey];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:self.headerView forKey:MDCFlexibleHeaderViewControllerHeaderViewKey];
  if (_layoutDelegate) {
    [aCoder encodeConditionalObject:self.layoutDelegate
                             forKey:MDCFlexibleHeaderViewControllerLayoutDelegateKey];
  }
}

- (void)commonMDCFlexibleHeaderViewControllerInit {
  MDCFlexibleHeaderView *headerView =
      [[MDCFlexibleHeaderView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  headerView.delegate = self;
  _headerView = headerView;
}

- (void)loadView {
  self.view = self.headerView;
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
  [super willMoveToParentViewController:parent];

  BOOL shouldDisableAutomaticInsetting = YES;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  // Prior to iOS 11 there was no way to know whether UIKit had injected insets into our
  // UIScrollView, so we disable automatic insetting on these devices. iOS 11 provides
  // the adjustedContentInset API which allows us to respond to changes in the safe area
  // insets, so on iOS 11 we actually expect iOS to manage the safe area insets.
  if (@available(iOS 11.0, *)) {
    shouldDisableAutomaticInsetting = NO;
  }
#endif
  if (shouldDisableAutomaticInsetting) {
    parent.automaticallyAdjustsScrollViewInsets = NO;
  }
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

  for (NSLayoutConstraint *constraint in self.parentViewController.view.constraints) {
    // Because topLayoutGuide is a readonly property on a viewController we must manipulate
    // the present one via the NSLayoutConstraint attached to it. Thus we keep reference to it.
    if (constraint.firstItem == self.parentViewController.topLayoutGuide &&
        constraint.secondItem == nil) {
      self.topLayoutGuideTopConstraint = constraint;
    }
  }

  // On moving to parentViewController, we calculate the height
  self.flexibleHeaderViewControllerHeightOffset = [self headerViewControllerHeight];

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
  UIColor *backgroundColor =
      [MDCFlexibleHeaderView appearance].backgroundColor ?: _headerView.backgroundColor;
  return (ShouldUseLightStatusBarOnBackgroundColor(backgroundColor)
              ? UIStatusBarStyleLightContent
              : UIStatusBarStyleDefault);
}

- (BOOL)prefersStatusBarHidden {
  return _headerView.prefersStatusBarHidden;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [_headerView viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

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

- (void)updateTopLayoutGuide {
  [self.topLayoutGuideTopConstraint setConstant:self.flexibleHeaderViewControllerHeightOffset];
}

- (CGFloat)headerViewControllerHeight {
  BOOL shiftEnabledForStatusBar =
      _headerView.shiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;
  CGFloat statusBarHeight =
      [UIApplication mdc_safeSharedApplication].statusBarFrame.size.height;
  CGFloat height =
      MAX(_headerView.frame.origin.y + _headerView.frame.size.height,
          shiftEnabledForStatusBar ? 0 : statusBarHeight);
  return height;
}

#pragma mark MDCFlexibleHeaderViewDelegate

- (void)flexibleHeaderViewNeedsStatusBarAppearanceUpdate:
    (__unused MDCFlexibleHeaderView *)headerView {
  [self setNeedsStatusBarAppearanceUpdate];
}

- (void)flexibleHeaderViewFrameDidChange:(MDCFlexibleHeaderView *)headerView {
  // Whenever the flexibleHeaderView's frame changes, we update the value of the height offset
  self.flexibleHeaderViewControllerHeightOffset = [self headerViewControllerHeight];

  // We must change the constant of the constraint attached to our parentViewController's
  // topLayoutGuide to trigger the re-layout of its subviews
  [self.topLayoutGuideTopConstraint setConstant:self.flexibleHeaderViewControllerHeightOffset];

  [self.layoutDelegate flexibleHeaderViewController:self
                   flexibleHeaderViewFrameDidChange:headerView];
}

@end
