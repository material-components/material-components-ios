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

#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCTest.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCBottomNavigationLargeItemDialogView.h"
#import "MDCSnapshotTestCase.h"
#import "UIImage+MDCSnapshot.h"
#import "UIView+MDCSnapshot.h"
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

static const CGFloat kImageHeight = 75;
static const CGFloat kImageWidth = 75;

@interface MDCBottomNavigationSystemDialogViewSnapshotTests : MDCSnapshotTestCase

/** The dialog view undergoing testing. */
@property(nonatomic, nullable) MDCBottomNavigationLargeItemDialogView *dialogView;

@end

@implementation MDCBottomNavigationSystemDialogViewSnapshotTests

- (void)setUp {
  [super setUp];

  self.dialogView = [[MDCBottomNavigationLargeItemDialogView alloc] initWithFrame:CGRectZero];

  // Uncomment to rerecord golden images.
  //    self.recordMode = YES;
}

- (void)tearDown {
  self.dialogView = nil;

  [super tearDown];
}

- (void)testBlackBackgroundColor {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithTitleAndImage];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.blackColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

#pragma mark - Helper Methods
/**
 * Verify's the dialog view matches the test method's golden image.
 * @param item UITabBarItem the bar item to update the dialog with.
 * @param size CGSize the size of the dialog view when testing occurs.
 * @param backgroundColor UIColor the background color the dialog will be displayed in front of.
 */
- (void)verifyDialogWithItem:(nonnull UITabBarItem *)item
                        size:(CGSize)size
             backgroundColor:(nonnull UIColor *)backgroundColor {
  [self.dialogView updateWithTabBarItem:item];
  self.dialogView.bounds = CGRectMake(0, 0, size.width, size.height);

  UIView *backgroundView = [self.dialogView mdc_addToBackgroundView];
  backgroundView.backgroundColor = backgroundColor;
  [self snapshotVerifyView:backgroundView];
}

/** Returns a tab bar with a reasonable title. */
+ (UITabBarItem *)tabBarItemWithOnlyTitle {
  return [[UITabBarItem alloc] initWithTitle:@"Title" image:nil tag:0];
}

/** Returns a tab bar with only an image property set. */
+ (UITabBarItem *)tabBarItemWithOnlyImage {
  return [[UITabBarItem alloc] initWithTitle:nil image:[self testImage] tag:0];
}

/** Returns a tab bar with a reasonable title and an image set. */
+ (UITabBarItem *)tabBarItemWithTitleAndImage {
  return [[UITabBarItem alloc] initWithTitle:@"Title" image:[self testImage] tag:0];
}

/** Returns an image to use for test @c UITabBarItem's. */
+ (UIImage *)testImage {
  return [UIImage mdc_testImageOfSize:CGSizeMake(kImageWidth, kImageHeight)
                            withStyle:MDCSnapshotTestImageStyleFramedX];
}

/** Returns the smallest dialog size. */
+ (CGSize)smallDialogSize {
  return CGSizeMake(120, 120);
}

/** Returns the target dialog size. */
+ (CGSize)mediumDialogSize {
  return CGSizeMake(240, 240);
}

/** Returns the largest dialog size. */
+ (CGSize)largeDialogSize {
  return CGSizeMake(480, 480);
}

#pragma mark - Test methods
- (void)testWhiteBackgroundColor {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithTitleAndImage];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.whiteColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testRedBackgroundColor {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithTitleAndImage];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.redColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testGreenBackgroundColor {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithTitleAndImage];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.greenColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testBlueBackgroundColor {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithTitleAndImage];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.blueColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testSmallSize {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithTitleAndImage];
  CGSize size = [[self class] smallDialogSize];
  UIColor *backgroundColor = UIColor.whiteColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testLargeSize {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithTitleAndImage];
  CGSize size = [[self class] largeDialogSize];
  UIColor *backgroundColor = UIColor.whiteColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testOnlyTitle {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithOnlyTitle];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.whiteColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testOnlyImage {
  // Given
  UITabBarItem *item = [[self class] tabBarItemWithOnlyImage];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.whiteColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testImageAndLongTitle {
  // Given
  NSString *title = @"This is a really long tab bar item title";
  UIImage *image = [UIImage mdc_testImageOfSize:CGSizeMake(kImageWidth, kImageWidth)
                                      withStyle:MDCSnapshotTestImageStyleFramedX];
  UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.whiteColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

- (void)testLongTitleOnly {
  // Given
  NSString *title = @"This is a really long tab bar item title";
  UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:nil tag:0];
  CGSize size = [[self class] mediumDialogSize];
  UIColor *backgroundColor = UIColor.whiteColor;

  // When/Then
  [self verifyDialogWithItem:item size:size backgroundColor:backgroundColor];
}

@end

NS_ASSUME_NONNULL_END
