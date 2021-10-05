// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MDCFlexibleHeaderView+ShiftBehavior.h"
#import "MDCFlexibleHeaderView.h"
#import "MDCFlexibleHeaderViewController.h"
#import "MDCFlexibleHeaderViewLayoutDelegate.h"
#import "MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar.h"
#import "MDCPalettes.h"

@interface FlexibleHeaderSafeAreaLayoutGuideExample
    : UIViewController <MDCFlexibleHeaderViewLayoutDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) MDCFlexibleHeaderViewController *fhvc;
@property(nonatomic, strong) UIView *constrainedView;

@end

@implementation FlexibleHeaderSafeAreaLayoutGuideExample

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

  // Behavioral flags.
  _fhvc.topLayoutGuideViewController = self;
  _fhvc.inferTopSafeAreaInsetFromViewController = YES;
  _fhvc.headerView.minMaxHeightIncludesSafeArea = NO;

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

  self.fhvc.headerView.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:1];
  self.fhvc.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;

  [self setupScrollViewContent];
  [self.scrollView setScrollEnabled:YES];
  self.fhvc.layoutDelegate = self;

  // Create UIView Object
  UIView *constrainedView = [[UIView alloc] init];
  constrainedView.backgroundColor = [UIColor colorWithRed:11 / (CGFloat)255
                                                    green:232 / (CGFloat)255
                                                     blue:94 / (CGFloat)255
                                                    alpha:1];
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
  NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.constrainedView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0
                                                            constant:100];
  width.active = YES;
  // TODO(b/138666796): This does not pin the content as expected.
  NSLayoutConstraint *top = [self.view.safeAreaLayoutGuide.topAnchor
      constraintEqualToAnchor:self.constrainedView.topAnchor
                     constant:0];
  top.active = YES;
  NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.constrainedView
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

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

// This method must be implemented for MDCFlexibleHeaderViewController's
// MDCFlexibleHeaderView to properly support MDCFlexibleHeaderShiftBehavior should you choose
// to customize it.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

#pragma mark - MDCFlexibleHeaderViewLayoutDelegate

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

#pragma mark - Supplemental

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)setupScrollViewContent {
  UIColor *color = MDCPalette.greyPalette.tint700;
  UIView *scrollViewContent =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width,
                                               self.scrollView.frame.size.height * 2)];
  scrollViewContent.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  UILabel *pullDownLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(20, 150, self.scrollView.frame.size.width - 40, 50)];
  pullDownLabel.textColor = color;
  pullDownLabel.text = @"Pull Down";
  pullDownLabel.textAlignment = NSTextAlignmentCenter;
  pullDownLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                   UIViewAutoresizingFlexibleLeftMargin |
                                   UIViewAutoresizingFlexibleRightMargin;
  [scrollViewContent addSubview:pullDownLabel];

  UILabel *pushUpLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(20, 225, self.scrollView.frame.size.width - 40, 50)];
  pushUpLabel.textColor = color;
  pushUpLabel.text = @"Push Up";
  pushUpLabel.textAlignment = NSTextAlignmentCenter;
  pushUpLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                 UIViewAutoresizingFlexibleLeftMargin |
                                 UIViewAutoresizingFlexibleRightMargin;
  [scrollViewContent addSubview:pushUpLabel];

  UILabel *downResultsLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(20, 325, self.scrollView.frame.size.width - 40, 50)];
  downResultsLabel.textColor = color;
  downResultsLabel.text = @"UIView Stays Constrained to TopLayoutGuide of Parent View Controller.";
  downResultsLabel.numberOfLines = 0;
  downResultsLabel.textAlignment = NSTextAlignmentCenter;
  downResultsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                      UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin;
  [scrollViewContent addSubview:downResultsLabel];

  [self.scrollView addSubview:scrollViewContent];
  self.scrollView.contentSize = scrollViewContent.frame.size;
}

@end

@implementation FlexibleHeaderSafeAreaLayoutGuideExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Flexible Header", @"Safe Area Layout Guide" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
