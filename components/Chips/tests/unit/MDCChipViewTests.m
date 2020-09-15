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

#import "MDCChipView.h"

static inline UIImage *TestImage(CGSize size) {
  CGFloat scale = [UIScreen mainScreen].scale;
  UIGraphicsBeginImageContextWithOptions(size, false, scale);
  [UIColor.redColor setFill];
  CGRect fillRect = CGRectZero;
  fillRect.size = size;
  UIRectFill(fillRect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface MDCChipViewTests : XCTestCase

@end

@implementation MDCChipViewTests

- (void)testPositiveAccessoryPaddingTopIncreasesChipHeight {
  // Given
  MDCChipView *chipView = [[MDCChipView alloc] init];
  UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
  chipView.accessoryView = accessoryView;
  CGSize originalSize = [chipView sizeThatFits:CGRectInfinite.size];

  // When
  chipView.accessoryPadding = UIEdgeInsetsMake(10, 0, 0, 0);
  CGSize fitSize = [chipView sizeThatFits:CGRectInfinite.size];
  CGSize expectedSize =
      CGSizeMake(originalSize.width, originalSize.height + chipView.accessoryPadding.top);

  // Then
  XCTAssertEqualWithAccuracy(fitSize.height, expectedSize.height, 0.001);
}

- (void)testPositiveAccessoryPaddingLeftIncreasesChipWidth {
  // Given
  MDCChipView *chipView = [[MDCChipView alloc] init];
  UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
  chipView.accessoryView = accessoryView;
  CGSize originalSize = [chipView sizeThatFits:CGRectInfinite.size];

  // When
  chipView.accessoryPadding = UIEdgeInsetsMake(0, 10, 0, 0);
  CGSize fitSize = [chipView sizeThatFits:CGRectInfinite.size];
  CGSize expectedSize =
      CGSizeMake(originalSize.width + chipView.accessoryPadding.left, originalSize.height);

  // Then
  XCTAssertEqualWithAccuracy(fitSize.width, expectedSize.width, 0.001);
}

- (void)testPositiveAccessoryPaddingBottomIncreasesChipHeight {
  // Given
  MDCChipView *chipView = [[MDCChipView alloc] init];
  UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
  chipView.accessoryView = accessoryView;
  CGSize originalSize = [chipView sizeThatFits:CGRectInfinite.size];

  // When
  chipView.accessoryPadding = UIEdgeInsetsMake(0, 0, 10, 0);
  CGSize fitSize = [chipView sizeThatFits:CGRectInfinite.size];
  CGSize expectedSize =
      CGSizeMake(originalSize.width, originalSize.height + chipView.accessoryPadding.bottom);

  // Then
  XCTAssertEqualWithAccuracy(fitSize.height, expectedSize.height, 0.001);
}

- (void)testPositiveAccessoryPaddingRightIncreasesChipWidth {
  // Given
  MDCChipView *chipView = [[MDCChipView alloc] init];
  UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
  chipView.accessoryView = accessoryView;
  CGSize originalSize = [chipView sizeThatFits:CGRectInfinite.size];

  // When
  chipView.accessoryPadding = UIEdgeInsetsMake(0, 0, 0, 10);
  CGSize fitSize = [chipView sizeThatFits:CGRectInfinite.size];
  CGSize expectedSize =
      CGSizeMake(originalSize.width + chipView.accessoryPadding.right, originalSize.height);

  // Then
  XCTAssertEqualWithAccuracy(fitSize.width, expectedSize.width, 0.001);
}

#pragma mark - MaterialElevation

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];

  // Then
  XCTAssertLessThan(chip.mdc_overrideBaseElevation, 0);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  CGFloat expectedBaseElevation = 99;

  // When
  chip.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(chip.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

- (void)testCurrentElevationMatchesElevationForState {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];

  // When
  UIControlState allStatesCombined = UIControlStateNormal | UIControlStateDisabled |
                                     UIControlStateSelected | UIControlStateHighlighted;
  MDCShadowElevation startingElevation = 100;

  for (NSUInteger state = 0; state <= allStatesCombined; ++state) {
    [chip setElevation:startingElevation + state forState:state];
  }

  // Then
  for (NSUInteger state = 0; state <= allStatesCombined; ++state) {
    if (state & (UIControlStateDisabled | UIControlStateHighlighted)) {
      continue;
    }
    chip.enabled = (state & UIControlStateDisabled) == UIControlStateDisabled ? NO : YES;
    chip.selected = (state & UIControlStateSelected) == UIControlStateSelected ? YES : NO;
    chip.highlighted = (state & UIControlStateHighlighted) == UIControlStateHighlighted ? YES : NO;
    XCTAssertEqualWithAccuracy(chip.mdc_currentElevation, [chip elevationForState:state], 0.001);
  }
}

- (void)testElevationDidChangeBlockCalledWhenStateChangeCausesElevationChange {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  [chip setElevation:1 forState:UIControlStateNormal];
  [chip setElevation:9 forState:UIControlStateSelected];
  __block CGFloat newElevation = 0;
  chip.mdc_elevationDidChangeBlock = ^(MDCChipView *object, CGFloat elevation) {
    newElevation = elevation;
  };

  // When
  chip.selected = YES;

  // Then
  XCTAssertEqualWithAccuracy(newElevation, [chip elevationForState:UIControlStateSelected], 0.001);
}

- (void)testElevationDidChangeBlockNotCalledWhenStateChangeDoesNotCauseElevationChange {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  [chip setElevation:1 forState:UIControlStateNormal];
  [chip setElevation:1 forState:UIControlStateHighlighted];
  __block BOOL blockCalled = NO;
  chip.mdc_elevationDidChangeBlock = ^(MDCChipView *object, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  chip.highlighted = YES;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testChipUpdatesSizeWhenTitleChanges {
  // Given
  UIView *view = [[UIView alloc] init];
  view.bounds = CGRectMake(0, 0, 500, 500);
  MDCChipView *chip = [[MDCChipView alloc] init];
  chip.titleLabel.text = @"Chip";
  [view addSubview:chip];
  chip.translatesAutoresizingMaskIntoConstraints = NO;
  chip.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self centerChip:chip inView:view];
  [view layoutIfNeeded];
  CGFloat chipWidth = CGRectGetWidth(chip.bounds);

  // When
  chip.titleLabel.text = @"Material Chips";
  [self forceAutoLayoutUpdateForView:view];

  // Then
  XCTAssertGreaterThan(CGRectGetWidth(chip.bounds), chipWidth);
}

- (void)testChipUpdatesSizeWhenTitleFontChanges {
  // Given
  UIView *view = [[UIView alloc] init];
  view.bounds = CGRectMake(0, 0, 500, 500);
  MDCChipView *chip = [[MDCChipView alloc] init];
  chip.titleLabel.text = @"Chip";
  chip.titleLabel.font = [UIFont systemFontOfSize:12];
  [view addSubview:chip];
  chip.translatesAutoresizingMaskIntoConstraints = NO;
  chip.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self centerChip:chip inView:view];
  [view layoutIfNeeded];
  CGSize chipSize = CGRectStandardize(chip.bounds).size;

  // When
  chip.titleLabel.font = [UIFont systemFontOfSize:20];
  [self forceAutoLayoutUpdateForView:view];

  // Then
  XCTAssertGreaterThan(CGRectGetWidth(chip.bounds), chipSize.width);
  XCTAssertGreaterThan(CGRectGetHeight(chip.bounds), chipSize.height);
}

- (void)testChipUpdatesSizeWhenImageChanges {
  // Given
  UIView *view = [[UIView alloc] init];
  view.bounds = CGRectMake(0, 0, 500, 500);
  MDCChipView *chip = [[MDCChipView alloc] init];
  chip.titleLabel.text = @"Chip";
  [view addSubview:chip];
  chip.translatesAutoresizingMaskIntoConstraints = NO;
  chip.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self centerChip:chip inView:view];
  [view layoutIfNeeded];
  CGSize chipSize = CGRectStandardize(chip.bounds).size;

  // When
  chip.imageView.image = TestImage(CGSizeMake(24, 24));
  [self forceAutoLayoutUpdateForView:view];

  // Then
  XCTAssertGreaterThan(CGRectGetWidth(chip.bounds), chipSize.width);
}

- (void)testVisibleAreaInsetsIsZeroWhenCenterVisibleAreaIsNO {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
  chip.titleLabel.text = @"Chip";

  // When
  chip.centerVisibleArea = NO;

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(chip.visibleAreaInsets, UIEdgeInsetsZero));
}

- (void)testVisibleAreaInsetsIsCorrectWhenCenterVisibleAreaIsYES {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
  chip.titleLabel.text = @"Chip";

  // When
  chip.centerVisibleArea = YES;

  // Then
  CGSize visibleAreaSize = [chip sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  CGFloat verticalInsets = 50 - visibleAreaSize.height;
  CGFloat horizontalInsets = 300 - visibleAreaSize.width;
  CGFloat topInsets = ceil(verticalInsets * 0.5f);
  CGFloat bottomInsets = verticalInsets - topInsets;
  CGFloat leftInsets = ceil(horizontalInsets * 0.5f);
  CGFloat rightInsets = horizontalInsets - leftInsets;
  UIEdgeInsets expectedVisibleAreaInsets =
      UIEdgeInsetsMake(topInsets, leftInsets, bottomInsets, rightInsets);
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(chip.visibleAreaInsets, expectedVisibleAreaInsets));
}

- (void)forceAutoLayoutUpdateForView:(UIView *)view {
  [view setNeedsLayout];
  [view layoutIfNeeded];
}

- (void)centerChip:(MDCChipView *)chip inView:(UIView *)view {
  [NSLayoutConstraint constraintWithItem:chip
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:view
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:chip
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:view
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1
                                constant:0]
      .active = YES;
}

@end
