// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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
#import <XCTest/XCTest.h>

#import "../../src/private/MDCBottomNavigationItemView.h"

#import "supplemental/MDCBottomNavigationSnapshotTestUtilities.h"
#import "supplemental/MDCFakeBottomNavigationBar.h"
#import "MDCBottomNavigationBar.h"
#import "MDCRippleTouchController.h"
#import "MDCRippleView.h"
#import "MDCSnapshotTestCase.h"
#import "UIImage+MDCSnapshot.h"
#import "UIView+MDCSnapshot.h"

@interface MDCBottomNavigationBarBlurEffectSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCFakeBottomNavigationBar *navigationBar;
@property(nonatomic, strong) UITabBarItem *tabItem1;
@property(nonatomic, strong) UITabBarItem *tabItem2;
@property(nonatomic, strong) UITabBarItem *tabItem3;
@property(nonatomic, strong) UITabBarItem *tabItem4;
@property(nonatomic, strong) UITabBarItem *tabItem5;
@end

@implementation MDCBottomNavigationBarBlurEffectSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.navigationBar = [[MDCFakeBottomNavigationBar alloc] init];

  CGSize imageSize = CGSizeMake(24, 24);
  self.tabItem1 = [[UITabBarItem alloc]
      initWithTitle:@"Item 1"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleEllipses]
                tag:1];
  self.tabItem2 = [[UITabBarItem alloc]
      initWithTitle:@"Item 2"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleCheckerboard]
                tag:2];
  self.tabItem2.badgeValue = MDCBottomNavigationTestBadgeTitleLatin;
  self.tabItem3 = [[UITabBarItem alloc]
      initWithTitle:@"Item 3"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleFramedX]
                tag:3];
  self.tabItem4 = [[UITabBarItem alloc]
      initWithTitle:@"Item 4"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleRectangles]
                tag:4];
  self.tabItem5 = [[UITabBarItem alloc]
      initWithTitle:@"Item 5"
              image:[UIImage mdc_testImageOfSize:imageSize
                                       withStyle:MDCSnapshotTestImageStyleDiagonalLines]
                tag:5];
  self.navigationBar.items =
      @[ self.tabItem1, self.tabItem2, self.tabItem3, self.tabItem4, self.tabItem5 ];
}

#pragma mark - Helpers

- (void)generateAndVerifySnapshot {
  UIView *backgroundView = [self.navigationBar mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)performRippleTouchOnBar:(MDCBottomNavigationBar *)navigationBar item:(UITabBarItem *)item {
  [navigationBar layoutIfNeeded];
  MDCBottomNavigationItemView *itemView =
      (MDCBottomNavigationItemView *)[navigationBar viewForItem:item];
  CGPoint point = CGPointMake(CGRectGetMidX(itemView.bounds), CGRectGetMidY(itemView.bounds));
  [itemView.rippleTouchController.rippleView beginRippleTouchDownAtPoint:point
                                                                animated:NO
                                                              completion:nil];
}

- (void)changeToRTLAndArabicWithTitle:(NSString *)title {
  self.navigationBar.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  for (UITabBarItem *item in self.navigationBar.items) {
    item.title = title;
    UIView *view = [self.navigationBar viewForItem:item];
    view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  }
  self.navigationBar.items[1].badgeValue = MDCBottomNavigationTestBadgeTitleArabic;
}

- (UIView *)superviewForVisualBlurEffectWithNavigationBar:(MDCBottomNavigationBar *)navigationBar {
  UIView *barSuperview =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                               MDCBottomNavigationBarTestHeightTypical * 2)];
  UIColor *patternColor = [UIColor
      colorWithPatternImage:[UIImage
                                mdc_testImageOfSize:CGSizeMake(
                                                        MDCBottomNavigationBarTestWidthTypical,
                                                        MDCBottomNavigationBarTestWidthTypical)]];
  barSuperview.backgroundColor = patternColor;
  [barSuperview addSubview:navigationBar];
  return barSuperview;
}

- (void)configureNavigationBarForVisualBlurEffectTest:(MDCBottomNavigationBar *)navigationBar {
  navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  navigationBar.selectedItem = self.tabItem2;
  navigationBar.frame =
      CGRectMake(0, MDCBottomNavigationBarTestHeightTypical, MDCBottomNavigationBarTestWidthTypical,
                 MDCBottomNavigationBarTestHeightTypical);
}

#pragma mark - Tests

- (void)testTransparentBackgroundColor {
  // Given
  UIView *barSuperview = [self superviewForVisualBlurEffectWithNavigationBar:self.navigationBar];
  [self configureNavigationBarForVisualBlurEffectTest:self.navigationBar];

  // When
  self.navigationBar.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:(CGFloat)0.5];

  // Then
  UIView *backgroundView = [barSuperview mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)testTransparentBackgroundColorWithExtraLightBlur {
  // Given
  UIView *barSuperview = [self superviewForVisualBlurEffectWithNavigationBar:self.navigationBar];
  [self configureNavigationBarForVisualBlurEffectTest:self.navigationBar];

  // When
  self.navigationBar.barTintColor =
      [self.navigationBar.barTintColor colorWithAlphaComponent:(CGFloat).5];
  self.navigationBar.backgroundBlurEnabled = YES;
  self.navigationBar.backgroundBlurEffectStyle = UIBlurEffectStyleExtraLight;

  // Then
  UIView *backgroundView = [barSuperview mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)testTransparentBackgroundColorWithLightBlur {
  // Given
  UIView *barSuperview = [self superviewForVisualBlurEffectWithNavigationBar:self.navigationBar];
  [self configureNavigationBarForVisualBlurEffectTest:self.navigationBar];

  // When
  self.navigationBar.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:(CGFloat)0.5];
  self.navigationBar.backgroundBlurEnabled = YES;
  self.navigationBar.backgroundBlurEffectStyle = UIBlurEffectStyleLight;

  // Then
  UIView *backgroundView = [barSuperview mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)testTransparentBackgroundColorWithDarkBlur {
  // Given
  UIView *barSuperview = [self superviewForVisualBlurEffectWithNavigationBar:self.navigationBar];
  [self configureNavigationBarForVisualBlurEffectTest:self.navigationBar];

  // When
  self.navigationBar.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:(CGFloat)0.5];
  self.navigationBar.backgroundBlurEnabled = YES;
  self.navigationBar.backgroundBlurEffectStyle = UIBlurEffectStyleDark;

  // Then
  UIView *backgroundView = [barSuperview mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)testBarItemsBottomAnchorWithOffset {
  // Given
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;

  UIView *superView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                               MDCBottomNavigationBarTestHeightTypical * 2)];
  [superView addSubview:self.navigationBar];
  self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
  [superView.bottomAnchor constraintEqualToAnchor:self.navigationBar.bottomAnchor].active = YES;
  [superView.leadingAnchor constraintEqualToAnchor:self.navigationBar.leadingAnchor].active = YES;
  [superView.trailingAnchor constraintEqualToAnchor:self.navigationBar.trailingAnchor].active = YES;

  // When
  [self.navigationBar.barItemsBottomAnchor constraintEqualToAnchor:superView.bottomAnchor
                                                          constant:-20]
      .active = YES;
  [self.navigationBar setNeedsLayout];
  [self.navigationBar layoutIfNeeded];
  [self.navigationBar setNeedsUpdateConstraints];
  [self.navigationBar updateConstraintsIfNeeded];
  [superView setNeedsUpdateConstraints];
  [superView updateConstraintsIfNeeded];
  [superView layoutIfNeeded];

  // Then
  UIView *backgroundView = [superView mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

- (void)testBarItemsBottomAnchorWithoutOffset {
  // Given
  self.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  self.navigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.navigationBar.selectedItem = self.tabItem2;

  UIView *superView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, MDCBottomNavigationBarTestWidthTypical,
                                               MDCBottomNavigationBarTestHeightTypical * 2)];
  [superView addSubview:self.navigationBar];
  self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
  [superView.bottomAnchor constraintEqualToAnchor:self.navigationBar.bottomAnchor].active = YES;
  [superView.leadingAnchor constraintEqualToAnchor:self.navigationBar.leadingAnchor].active = YES;
  [superView.trailingAnchor constraintEqualToAnchor:self.navigationBar.trailingAnchor].active = YES;

  // When
  [superView layoutIfNeeded];

  // Then
  UIView *backgroundView = [superView mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

@end
