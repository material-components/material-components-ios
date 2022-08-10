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

#import <XCTest/XCTest.h>

#import "../../src/private/MDCBottomNavigationItemView.h"
#import "MDCBottomNavigationBar.h"

/** Returns a generated image of the given size. */
static UIImage *fakeImage() {
  UIGraphicsBeginImageContext(CGSizeMake(24, 24));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

/** Category to expose internals for testing. */
@interface MDCBottomNavigationBar (MDCBottomNavigationBarKVOTests)
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@end

/** Unit tests focusing on Key-Value Observing (KVO) within MDCBottomNavigationBar. */
@interface MDCBottomNavigationBarKVOTests : XCTestCase

/** The Bottom Navigation to use for testing. */
@property(nonatomic, strong) MDCBottomNavigationBar *bottomNavigationBar;
/** The bar item assigned to the Bottom Navigationbar. */
@property(nonatomic, strong) UITabBarItem *barItem;
@end

@implementation MDCBottomNavigationBarKVOTests

- (void)setUp {
  [super setUp];

  self.bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
  self.barItem = [[UITabBarItem alloc] initWithTitle:@"title" image:fakeImage() tag:0];
  self.barItem.selectedImage = fakeImage();
  self.barItem.badgeValue = @"badge";
  self.barItem.titlePositionAdjustment = UIOffsetMake(1, 2);
  self.barItem.accessibilityLabel = @"label";
  self.barItem.accessibilityHint = @"hint";
  self.barItem.accessibilityValue = @"value";
  self.barItem.accessibilityTraits = UIAccessibilityTraitLink;
  self.barItem.accessibilityIdentifier = @"identifier";
  self.barItem.isAccessibilityElement = YES;
  self.barItem.badgeColor = UIColor.darkGrayColor;
  self.bottomNavigationBar.items = @[ self.barItem ];
}

- (void)tearDown {
  self.barItem = nil;
  self.bottomNavigationBar = nil;

  [super tearDown];
}

- (void)testChangeTitleToNonEmptyString {
  // When
  self.barItem.title = @"string";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.title, self.barItem.title);
}

- (void)testChangeTitleToEmptyString {
  // When
  self.barItem.title = @"";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.title, self.barItem.title);
}

- (void)testChangeTitleToNil {
  // When
  self.barItem.title = nil;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertNil(itemView.title);
}

- (void)testChangeImageToNewImageDoesNotRaiseException {
  // Then
  XCTAssertNoThrow(self.barItem.image = fakeImage());
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertNotNil(itemView.image);
}

- (void)testChangeImageToNil {
  // When
  self.barItem.image = nil;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertNil(itemView.image);
}

- (void)testChangeSelectedImageToNewImageDoesNotRaiseException {
  // Then
  XCTAssertNoThrow(self.barItem.selectedImage = fakeImage());
}

- (void)testChangeSelectedImageToNilDoesNotRaiseException {
  // Then
  XCTAssertNoThrow(self.barItem.selectedImage = nil);
}

- (void)testChangeBadgeValueToNonEmptyString {
  // When
  self.barItem.badgeValue = @"string";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.badgeText, self.barItem.badgeValue);
}

- (void)testChangeBadgeValueToEmptyString {
  // When
  self.barItem.badgeValue = @"";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.badgeText, self.barItem.badgeValue);
}

- (void)testChangeBadgeValueToNil {
  // When
  self.barItem.badgeValue = nil;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertNil(itemView.badgeText);
}

- (void)testChangeBadgeColorToNewColor {
  // When
  self.barItem.badgeColor = [UIColor.purpleColor colorWithAlphaComponent:(CGFloat)0.712];

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.badgeColor, self.barItem.badgeColor);
}

- (void)testChangeBadgeColorToNil {
  // When
  self.barItem.badgeColor = nil;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertNil(itemView.badgeColor);
}

- (void)testChangeBadgeColorToClearColor {
  // When
  self.barItem.badgeColor = [UIColor clearColor];

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.badgeColor, [UIColor clearColor]);
}

- (void)testChangeTitlePositionAdjustmentToNonZeroOffsetDoesNotRaiseException {
  // Then
  XCTAssertNoThrow(self.barItem.titlePositionAdjustment = UIOffsetMake(17, 2));
}

- (void)testChangeTitlePositionAdjustmentToOffsetZeroDoesNotRaiseException {
  // Then
  XCTAssertNoThrow(self.barItem.titlePositionAdjustment = UIOffsetZero);
}

- (void)testChangeAccessibilityLabelToNonEmptyString {
  // When
  self.barItem.accessibilityLabel = @"string";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.accessibilityLabel, self.barItem.accessibilityLabel);
}

- (void)testChangeAccessibilityLabelToEmptyString {
  // When
  self.barItem.accessibilityLabel = @"";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.accessibilityLabel, self.barItem.accessibilityLabel);
}

- (void)testChangeAccessibilityLabelToNil {
  // When
  self.barItem.accessibilityLabel = nil;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertNil(itemView.accessibilityLabel);
}

- (void)testChangeAccessibilityHintToNonEmptyString {
  // When
  self.barItem.accessibilityHint = @"string";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  UIButton *itemViewButton = itemView.button;
  XCTAssertEqualObjects(itemViewButton.accessibilityHint, self.barItem.accessibilityHint);
}

- (void)testChangeAccessibilityHintToEmptyString {
  // When
  self.barItem.accessibilityHint = @"";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  UIButton *itemViewButton = itemView.button;
  XCTAssertEqualObjects(itemViewButton.accessibilityHint, self.barItem.accessibilityHint);
}

- (void)testChangeAccessibilityHintToNil {
  // When
  self.barItem.accessibilityHint = nil;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  UIButton *itemViewButton = itemView.button;
  XCTAssertNil(itemViewButton.accessibilityHint);
}

- (void)testChangeAccessibilityValueToNonEmptyString {
  // When
  self.barItem.accessibilityValue = @"string";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.accessibilityValue, self.barItem.accessibilityValue);
}

- (void)testChangeAccessibilityValueToEmptyString {
  // When
  self.barItem.accessibilityValue = @"";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertEqualObjects(itemView.accessibilityValue, self.barItem.accessibilityValue);
}

- (void)testChangeAccessibilityValueToNil {
  // When
  self.barItem.accessibilityValue = nil;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertNil(itemView.accessibilityValue);
}

- (void)testChangeAccessibilityIdentifierToNonEmptyString {
  // When
  self.barItem.accessibilityIdentifier = @"string";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  UIButton *itemViewButton = itemView.button;
  XCTAssertEqualObjects(itemViewButton.accessibilityIdentifier,
                        self.barItem.accessibilityIdentifier);
}

- (void)testChangeAccessibilityIdentifierToEmptyString {
  // When
  self.barItem.accessibilityIdentifier = @"";

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  UIButton *itemViewButton = itemView.button;
  XCTAssertEqualObjects(itemViewButton.accessibilityIdentifier,
                        self.barItem.accessibilityIdentifier);
}

- (void)testChangeAccessibilityIdentifierToNil {
  // When
  self.barItem.accessibilityIdentifier = nil;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  UIButton *itemViewButton = itemView.button;
  XCTAssertNil(itemViewButton.accessibilityIdentifier);
}

- (void)testChangeIsAccessibilityElementNoToYes {
  // Given
  self.barItem.isAccessibilityElement = NO;

  // When
  self.barItem.isAccessibilityElement = YES;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertTrue(itemView.isAccessibilityElement);
}

- (void)testChangeIsAccessibilityElementYesToNo {
  // Given
  self.barItem.isAccessibilityElement = YES;

  // When
  self.barItem.isAccessibilityElement = NO;

  // Then
  MDCBottomNavigationItemView *itemView = self.bottomNavigationBar.itemViews.firstObject;
  XCTAssertFalse(itemView.isAccessibilityElement);
}

@end
