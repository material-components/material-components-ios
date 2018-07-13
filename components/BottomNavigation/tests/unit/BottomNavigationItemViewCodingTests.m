/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <XCTest/XCTest.h>

#import "../../src/private/MDCBottomNavigationItemView.h"

#import "MaterialInk.h"

static UIImage *fakeImage(void) {
  CGSize imageSize = CGSizeMake(24, 24);
  UIGraphicsBeginImageContext(imageSize);
  [UIColor.whiteColor setFill];
  UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface MDCBottomNavigationItemView (Testing)
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;
@end

@interface BottomNavigationItemViewCodingTests : XCTestCase

@end

@implementation BottomNavigationItemViewCodingTests

- (void)testBasicCoding {
  // Given
  MDCBottomNavigationItemView *view = [[MDCBottomNavigationItemView alloc] init];
  view.titleBelowIcon = NO;
  view.selected = YES;
  view.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  view.inkView.usesLegacyInkRipple = YES;
  view.badgeValue = @"123";
  view.title = @"a title";
  view.itemTitleFont = [UIFont systemFontOfSize:23];
  [view.button setTitle:@"button" forState:UIControlStateNormal];
  view.image = fakeImage();
  view.badgeColor = UIColor.purpleColor;
  view.selectedItemTintColor = UIColor.redColor;
  view.unselectedItemTintColor = UIColor.orangeColor;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:view];
  MDCBottomNavigationItemView *unarchivedView = [NSKeyedUnarchiver unarchiveObjectWithData:archive];

  // Then
  XCTAssertEqual(view.titleBelowIcon, unarchivedView.titleBelowIcon);
  XCTAssertEqual(view.selected, unarchivedView.selected);
  XCTAssertEqual(view.titleVisibility, unarchivedView.titleVisibility);
  XCTAssertEqual(view.inkView.usesLegacyInkRipple, unarchivedView.inkView.usesLegacyInkRipple);
  XCTAssertEqualObjects(view.badgeValue, unarchivedView.badgeValue);
  XCTAssertEqualObjects(view.title, unarchivedView.title);
  XCTAssertEqualObjects(view.itemTitleFont, unarchivedView.itemTitleFont);
  XCTAssertEqualObjects([view.button titleForState:UIControlStateNormal],
                        [unarchivedView.button titleForState:UIControlStateNormal]);
  XCTAssertNotNil(unarchivedView.image);
  XCTAssertEqualObjects(view.badgeColor, unarchivedView.badgeColor);
  XCTAssertEqualObjects(view.selectedItemTintColor, unarchivedView.selectedItemTintColor);
  XCTAssertEqualObjects(view.unselectedItemTintColor, unarchivedView.unselectedItemTintColor);
}

- (void)testMultipleCodingsKeepSubviewsEqual {
  // Given
  MDCBottomNavigationItemView *view = [[MDCBottomNavigationItemView alloc] init];

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:view];
  MDCBottomNavigationItemView *unarchivedView =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];
  for (int i = 0; i < 3; ++i) {
    archive = [NSKeyedArchiver archivedDataWithRootObject:unarchivedView];
    unarchivedView = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
  }

  // Then
  XCTAssertEqual(view.subviews.count, unarchivedView.subviews.count);
}

- (void)testVerticalMarginLayout {
  // Given
  MDCBottomNavigationItemView *view = [[MDCBottomNavigationItemView alloc] init];
  view.title = @"Test Content";
  view.image = fakeImage();
  view.bounds = CGRectMake(0, 0, 100, 100);
  view.contentVerticalMargin = 20;
  view.contentHorizontalMargin = 20;
  view.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;

  // When
  view.titleBelowIcon = YES;
  [view layoutSubviews];

  // Then
  CGFloat contentHeight =
      CGRectGetHeight(view.label.bounds) + CGRectGetHeight(view.iconImageView.bounds);
  CGFloat expectedDistance = contentHeight / 2 + view.contentVerticalMargin;
  XCTAssertEqualWithAccuracy(view.label.center.y - view.iconImageView.center.y,
                             expectedDistance,
                             0.001f);
}

- (void)testHorizontalMarginLayout {
  // Given
  MDCBottomNavigationItemView *view = [[MDCBottomNavigationItemView alloc] init];
  view.title = @"Test Content";
  view.image = fakeImage();
  view.bounds = CGRectMake(0, 0, 100, 100);
  view.contentVerticalMargin = 20;
  view.contentHorizontalMargin = 20;
  view.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;

  // When
  view.titleBelowIcon = NO;
  [view layoutSubviews];

  // Then
  CGFloat contentWidth =
      CGRectGetWidth(view.label.bounds) + CGRectGetWidth(view.iconImageView.bounds);
  CGFloat expectedDistance = contentWidth / 2 + view.contentHorizontalMargin;
  XCTAssertEqualWithAccuracy(view.label.center.x - view.iconImageView.center.x,
                             expectedDistance,
                             0.001f);
}

- (void)testContentInsetLayout {
  // Given
  MDCBottomNavigationItemView *view = [[MDCBottomNavigationItemView alloc] init];
  view.title = @"Test Content";
  view.image = fakeImage();
  view.bounds = CGRectMake(0, 0, 100, 100);
  view.contentVerticalMargin = 20;
  view.contentHorizontalMargin = 20;
  view.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;

  // When
  view.titleBelowIcon = YES;
  view.contentInsets = UIEdgeInsetsMake(10, 10, 5, 5);
  [view layoutSubviews];

  // Then
  CGRect contentRect = UIEdgeInsetsInsetRect(view.bounds, view.contentInsets);
  XCTAssert(view.label.center.x == CGRectGetMidX(contentRect));
  XCTAssert(view.iconImageView.center.x == CGRectGetMidX(contentRect));
  CGFloat contentSpan = CGRectGetMaxY(view.label.frame) - CGRectGetMinY(view.iconImageView.frame);
  XCTAssertEqualWithAccuracy(CGRectGetMinY(view.iconImageView.frame) + contentSpan / 2,
                             CGRectGetMidY(contentRect),
                             0.001f);
}

@end
