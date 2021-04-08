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

#import <CoreGraphics/CoreGraphics.h>
#import "../../src/TabBarView/MDCTabBarView.h"
#import "../../src/TabBarView/private/MDCTabBarViewItemView.h"
#import "../../src/TabBarView/private/MDCTabBarViewItemViewDelegate.h"

// Minimum width of an item view.
static const CGFloat kMinWidth = 90;
// Maximum width of an item view.
static const CGFloat kLargeWidthSize = 360;
// Minimum (expected) height of an item view with only a title or image (not both).
static const CGFloat kMinHeightOfTitleOrImageOnlyView = 48;

// Minimum (expected) height of an item view with both a title and image.
static const CGFloat kMinHeightOfTitleAndImageView = 72;

static NSString *const kLongTitle = @"12345678901234567890123456789012345678901 "
                                     "2345678901234567890123456789012345678901234567890 "
                                     "3456789012345678901234567890123456789012345678901 "
                                     "4567890123456789012345678901234567890123456789012";

static UIImage *fakeImage(CGFloat width, CGFloat height) {
  CGSize imageSize = CGSizeMake(width, height);
  UIGraphicsBeginImageContext(imageSize);
  [UIColor.whiteColor setFill];
  UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface MDCTabBarViewItemViewTests : XCTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCTabBarViewItemView *itemView;
@end

@implementation MDCTabBarViewItemViewTests

- (void)setUp {
  [super setUp];

  self.itemView = [[MDCTabBarViewItemView alloc] init];
  MDCTabBarView *tabBarView = [[MDCTabBarView alloc] init];
  self.itemView.itemViewDelegate = (id<MDCTabBarViewItemViewDelegate>)tabBarView;
}

- (void)tearDown {
  self.itemView.itemViewDelegate = nil;
  self.itemView = nil;

  [super tearDown];
}

#pragma mark - -intrinsicContentSize

- (void)testIntrinsicContentSizeForNoTitleNoImageIsMinimumSize {
  // When
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;

  // Then
  XCTAssertEqualWithAccuracy(intrinsicContentSize.width, kMinWidth, 0.001);
  XCTAssertEqualWithAccuracy(intrinsicContentSize.height, kMinHeightOfTitleOrImageOnlyView, 0.001);
}

- (void)testIntrinsicContentSizeForShortTitleExpectedImageLimitsHeight {
  // When
  self.itemView.iconImageView.image = fakeImage(24, 24);
  self.itemView.titleLabel.text = @"Favorites";
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;

  // Then
  XCTAssertGreaterThanOrEqual(intrinsicContentSize.width, kMinWidth);
  XCTAssertEqualWithAccuracy(intrinsicContentSize.height, kMinHeightOfTitleAndImageView, 0.001);
}

- (void)testIntrinsicContentSizeWhenMinItemWidthIsSetOnDelegate {
  // Given
  self.itemView.itemViewDelegate.minItemWidth = 150;

  // When
  self.itemView.iconImageView.image = fakeImage(24, 24);
  self.itemView.titleLabel.text = @"Favorites";
  CGSize intrinsicContentSize = self.itemView.intrinsicContentSize;

  // Then
  XCTAssertGreaterThanOrEqual(intrinsicContentSize.width, 150);
  XCTAssertEqualWithAccuracy(intrinsicContentSize.height, kMinHeightOfTitleAndImageView, 0.001);
}

#pragma mark - -sizeThatFits:

- (void)testSizeThatFitsForNoContentWithSmallDimensionsIsMinimumSize {
  // When
  CGSize fitSize = [self.itemView sizeThatFits:CGSizeZero];

  // Then
  XCTAssertEqualWithAccuracy(fitSize.width, kMinWidth, 0.001);
  XCTAssertEqualWithAccuracy(fitSize.height, kMinHeightOfTitleOrImageOnlyView, 0.001);
}

- (void)testSizeThatFitsForNoContentWithReasonableDimensionsIsMinimumSize {
  // Given
  CGSize requestedSize = CGSizeMake(kMinWidth * 3, kMinHeightOfTitleOrImageOnlyView + 10);

  // When
  CGSize fitSize = [self.itemView sizeThatFits:requestedSize];

  // Then
  XCTAssertEqualWithAccuracy(fitSize.width, kMinWidth, 0.001);
  XCTAssertEqualWithAccuracy(fitSize.height, kMinHeightOfTitleOrImageOnlyView, 0.001);
}

- (void)testSizeThatFitsForNoContentWithLargeDimensionsIsMinimumSize {
  // Given
  CGSize requestedSize = CGSizeMake(kLargeWidthSize + 10, kMinHeightOfTitleOrImageOnlyView + 10);

  // When
  CGSize fitSize = [self.itemView sizeThatFits:requestedSize];

  // Then
  XCTAssertEqualWithAccuracy(fitSize.width, kMinWidth, 0.001);
  XCTAssertEqualWithAccuracy(fitSize.height, kMinHeightOfTitleOrImageOnlyView, 0.001);
}

// The fit size should first make the item view wide (up to the max) and then increase the height as
// necessary.  The exception would be a font that is very large.
- (void)testSizeThatFitsForShortTitleExpectedImageLargerDimensionsLimitsHeight {
  // When
  self.itemView.iconImageView.image = fakeImage(24, 24);
  self.itemView.titleLabel.text = @"Favorites";
  CGSize fitSize = [self.itemView sizeThatFits:CGSizeMake(1000, 1000)];

  // Then
  XCTAssertGreaterThanOrEqual(fitSize.width, kMinWidth);
  XCTAssertEqualWithAccuracy(fitSize.height, kMinHeightOfTitleAndImageView, 0.001);
}

#pragma mark - -contentFrame

- (void)testContentFrameForTextOnlyViewReturnsTitleLabelFittingFrame {
  // When
  self.itemView.titleLabel.text = @"Favorites";
  [self.itemView sizeToFit];

  // Then
  // Grab the `contentFrame` before layout to be sure it's calculated correctly at any time.
  CGRect contentFrame = self.itemView.contentFrame;
  [self.itemView layoutIfNeeded];
  XCTAssertFalse(CGRectEqualToRect(contentFrame, CGRectZero), @"(%@) is equal to (%@))",
                 NSStringFromCGRect(contentFrame), NSStringFromCGRect(CGRectZero));
  XCTAssertEqualWithAccuracy(CGRectGetHeight(contentFrame),
                             CGRectGetHeight(self.itemView.titleLabel.bounds), 0.001);
  XCTAssertLessThanOrEqual(CGRectGetWidth(contentFrame),
                           CGRectGetWidth(self.itemView.titleLabel.bounds));
  CGPoint itemViewTopCenter =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMinY(self.itemView.bounds));
  XCTAssertFalse(CGRectContainsPoint(contentFrame, itemViewTopCenter),
                 @"(%@) does not contain (%@)", NSStringFromCGRect(contentFrame),
                 NSStringFromCGPoint(itemViewTopCenter));
  CGPoint itemViewMidBounds =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMidY(self.itemView.bounds));
  XCTAssertTrue(CGRectContainsPoint(contentFrame, itemViewMidBounds), @"(%@) does not contain (%@)",
                NSStringFromCGRect(contentFrame), NSStringFromCGPoint(itemViewMidBounds));

  CGPoint itemViewBottomCenter =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMaxY(self.itemView.bounds));
  XCTAssertFalse(CGRectContainsPoint(contentFrame, itemViewBottomCenter),
                 @"(%@) does not contain (%@)", NSStringFromCGRect(contentFrame),
                 NSStringFromCGPoint(itemViewBottomCenter));
}

- (void)testContentFrameForIconOnlyViewReturnsIconImageViewFittingFrame {
  // When
  self.itemView.iconImageView.image = fakeImage(24, 24);
  [self.itemView sizeToFit];

  // Then
  // Grab the `contentFrame` before layout to be sure it's calculated correctly at any time.
  CGRect contentFrame = self.itemView.contentFrame;
  [self.itemView layoutIfNeeded];
  XCTAssertFalse(CGRectEqualToRect(contentFrame, CGRectZero), @"(%@) is equal to (%@)",
                 NSStringFromCGRect(contentFrame), NSStringFromCGRect(CGRectZero));
  XCTAssertEqualWithAccuracy(CGRectGetHeight(contentFrame),
                             CGRectGetHeight(self.itemView.iconImageView.bounds), 0.001);
  XCTAssertLessThanOrEqual(CGRectGetWidth(contentFrame),
                           CGRectGetWidth(self.itemView.iconImageView.bounds));
  CGPoint itemViewTopCenter =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMinY(self.itemView.bounds));
  XCTAssertFalse(CGRectContainsPoint(contentFrame, itemViewTopCenter),
                 @"(%@) does not contain (%@)", NSStringFromCGRect(contentFrame),
                 NSStringFromCGPoint(itemViewTopCenter));
  CGPoint itemViewMidBounds =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMidY(self.itemView.bounds));
  XCTAssertTrue(CGRectContainsPoint(contentFrame, itemViewMidBounds), @"(%@) does not contain (%@)",
                NSStringFromCGRect(contentFrame), NSStringFromCGPoint(itemViewMidBounds));

  CGPoint itemViewBottomCenter =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMaxY(self.itemView.bounds));
  XCTAssertFalse(CGRectContainsPoint(contentFrame, itemViewBottomCenter),
                 @"(%@) does not contain (%@)", NSStringFromCGRect(contentFrame),
                 NSStringFromCGPoint(itemViewBottomCenter));
}

- (void)testContentFrameForTextAndIconViewReturnsFrameWithTitleLabelWidthAndTitleImageHeight {
  // When
  self.itemView.iconImageView.image = fakeImage(24, 24);
  self.itemView.titleLabel.text = @"Favorites";
  [self.itemView sizeToFit];

  // Then
  // Grab the `contentFrame` before layout to be sure it's calculated correctly at any time.
  CGRect contentFrame = self.itemView.contentFrame;
  [self.itemView layoutIfNeeded];
  XCTAssertFalse(CGRectEqualToRect(contentFrame, CGRectZero), @"(%@) is equal to (%@)",
                 NSStringFromCGRect(contentFrame), NSStringFromCGRect(CGRectZero));
  XCTAssertGreaterThan(CGRectGetHeight(contentFrame),
                       CGRectGetHeight(self.itemView.titleLabel.bounds));
  XCTAssertLessThanOrEqual(CGRectGetWidth(contentFrame),
                           CGRectGetWidth(self.itemView.titleLabel.bounds));
  CGPoint itemViewTopCenter =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMinY(self.itemView.bounds));
  XCTAssertFalse(CGRectContainsPoint(contentFrame, itemViewTopCenter),
                 @"(%@) does not contain (%@)", NSStringFromCGRect(contentFrame),
                 NSStringFromCGPoint(itemViewTopCenter));
  CGPoint itemViewMidBounds =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMidY(self.itemView.bounds));
  XCTAssertTrue(CGRectContainsPoint(contentFrame, itemViewMidBounds), @"(%@) does not contain (%@)",
                NSStringFromCGRect(contentFrame), NSStringFromCGPoint(itemViewMidBounds));
  CGPoint itemViewBottomCenter =
      CGPointMake(CGRectGetMidX(self.itemView.bounds), CGRectGetMaxY(self.itemView.bounds));
  XCTAssertFalse(CGRectContainsPoint(contentFrame, itemViewBottomCenter),
                 @"(%@) does not contain (%@)", NSStringFromCGRect(contentFrame),
                 NSStringFromCGPoint(itemViewBottomCenter));
}

@end
