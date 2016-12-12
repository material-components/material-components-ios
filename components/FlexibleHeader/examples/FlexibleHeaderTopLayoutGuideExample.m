/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "FlexibleHeaderTopLayoutGuideSupplemental.h"

#import "MaterialFlexibleHeader.h"

@interface FlexibleHeaderTopLayoutGuideExample () <MDCFlexibleHeaderViewLayoutDelegate,
    UIScrollViewDelegate>

@property(nonatomic) MDCFlexibleHeaderViewController *fhvc;
@property(nonatomic, strong) UIView *constrainedView;

@end

@implementation FlexibleHeaderTopLayoutGuideExample

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

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
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (void)commonMDCFlexibleHeaderViewControllerInit {
  _fhvc = [[MDCFlexibleHeaderViewController alloc] initWithNibName:nil bundle:nil];
  [self addChildViewController:_fhvc];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Scroll view configuration
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.backgroundColor = [UIColor whiteColor];
  self.scrollView.autoresizingMask =
  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.scrollView.delegate = self;
  [self.view addSubview:self.scrollView];
  self.fhvc.headerView.trackingScrollView = self.scrollView;

  // Add Flexible Header View Controller to Parent View
  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];

  // Light blue 500
  self.fhvc.headerView.backgroundColor =
  [UIColor colorWithRed:0.333 green:0.769 blue:0.961 alpha:1];
  self.fhvc.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;

  [self setupScrollViewContent];
  [self.scrollView setScrollEnabled:YES];
  self.fhvc.layoutDelegate = self;

  // Create UIView Object
  UIView *constrainedView = [[UIView alloc] init];
  constrainedView.backgroundColor = [UIColor redColor];
  constrainedView.translatesAutoresizingMaskIntoConstraints = NO;
  self.constrainedView = constrainedView;
  [self.view addSubview:self.constrainedView];

  // Setup NSLayoutConstraints on View to topLayoutGuide of parent view
  NSLayoutConstraint *height =
      [NSLayoutConstraint constraintWithItem:self.constrainedView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0
                                    constant:100];
  height.active = YES;
  NSLayoutConstraint *width =
      [NSLayoutConstraint constraintWithItem:self.constrainedView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0
                                    constant:100];
  width.active = YES;
  NSLayoutConstraint *top =
      [NSLayoutConstraint constraintWithItem:self.constrainedView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.topLayoutGuide
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                    constant:0];
  top.active = YES;
  NSLayoutConstraint *leading =
      [NSLayoutConstraint constraintWithItem:self.constrainedView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1.0
                                    constant:0];
  leading.active = YES;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // If the MDCFlexibleHeaderViewController's view is not going to replace a navigation bar,
  // comment this line:
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  // Call updateTopLayoutGuide on Flexible Header View Controller in viewWillLayoutSubviews
  [self.fhvc updateTopLayoutGuide];

}

// This method must be implemented for MDCFlexibleHeaderViewController's
// MDCFlexibleHeaderView to properly support MDCFlexibleHeaderShiftBehavior should you choose
// to customize it.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

}

#pragma - MDCFlexibleHeaderViewLayoutDelegate

- (void)flexibleHeaderViewController:(MDCFlexibleHeaderViewController *)flexibleHeaderViewController
    flexibleHeaderViewFrameDidChange:(MDCFlexibleHeaderView *)flexibleHeaderView {
  // Called whenever the frame changes.

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                                    targetContentOffset:targetContentOffset];
  }
}

@end
