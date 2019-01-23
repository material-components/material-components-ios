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

#import <UIKit/UIKit.h>

#import "MaterialApplication.h"
#import "MaterialBottomSheet.h"
#import "supplemental/BottomSheetSupplemental.h"

static const CGFloat kSafeContentHeight = 150;
static const CGFloat kSafeContentWidth = 300;

@interface SafeAreaReportingViewController : UIViewController

@property(nonatomic, nullable) UIView *withinSafeAreaView;
@property(nonatomic, nullable) UILabel *safeAreaLabel;

@end

@implementation SafeAreaReportingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;

  self.withinSafeAreaView = [[UIView alloc] init];
  self.withinSafeAreaView.backgroundColor = UIColor.lightGrayColor;
  self.withinSafeAreaView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.withinSafeAreaView];

  self.safeAreaLabel = [[UILabel alloc] init];
  self.safeAreaLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.withinSafeAreaView addSubview:self.safeAreaLabel];

  // Center the label in the safe area view.
  [NSLayoutConstraint constraintWithItem:self.safeAreaLabel
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.withinSafeAreaView
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.safeAreaLabel
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.withinSafeAreaView
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1
                                constant:0]
      .active = YES;

  // Lay out the withinSafeAreaView to fill the sheet, but only take up as much space as requested
  // (not accounting for what the bottom sheet presentation adds for the safe area).
  [NSLayoutConstraint constraintWithItem:self.withinSafeAreaView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.withinSafeAreaView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.withinSafeAreaView
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:0]
      .active = YES;
  // Don't expand into the safe area.
  [NSLayoutConstraint constraintWithItem:self.withinSafeAreaView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:0]
      .active = YES;

  // Set size of the withinSafeArea view.
  [NSLayoutConstraint constraintWithItem:self.withinSafeAreaView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:0
                                constant:kSafeContentHeight]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.withinSafeAreaView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:0
                                constant:kSafeContentHeight]
      .active = YES;

  self.preferredContentSize = CGSizeMake(kSafeContentWidth, kSafeContentHeight);
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  CGPoint origin = CGRectStandardize(self.withinSafeAreaView.frame).origin;
  UIWindow *keyWindow = [UIApplication mdc_safeSharedApplication].keyWindow;
  CGPoint safeAreaViewAbsoluteOrigin = [keyWindow convertPoint:origin fromView:self.view];
  CGFloat safeAreaBottomAbsoluteY =
      safeAreaViewAbsoluteOrigin.y + CGRectStandardize(self.withinSafeAreaView.bounds).size.height;
  CGFloat safeAreaBottomInset =
      CGRectStandardize(keyWindow.bounds).size.height - safeAreaBottomAbsoluteY;
  self.safeAreaLabel.text =
      [NSString stringWithFormat:@"Safe Area Bottom Inset: %0.0f", safeAreaBottomInset];
}

@end

@interface BottomSheetAutolayoutSafeAreaExample ()

@property(nonatomic, nullable) MDCBottomSheetTransitionController *transitionController;

@end

@implementation BottomSheetAutolayoutSafeAreaExample

- (void)presentBottomSheet {
  SafeAreaReportingViewController *viewController = [[SafeAreaReportingViewController alloc] init];
  self.transitionController = [[MDCBottomSheetTransitionController alloc] init];
  viewController.transitioningDelegate = self.transitionController;
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.mdc_bottomSheetPresentationController.dismissOnBackgroundTap = YES;
  [self presentViewController:viewController animated:YES completion:nil];
}

@end
