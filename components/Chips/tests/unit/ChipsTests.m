// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialChips.h"
#import "../../src/MDCChipField.m"

static inline UIColor *MDCColorFromRGB(uint32_t rgbValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                         green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                          blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                         alpha:1];
}

static inline UIColor *MDCColorDarken(UIColor *color, CGFloat percent) {
  CGFloat hue;
  CGFloat saturation;
  CGFloat brightness;
  CGFloat alpha;
  [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

  brightness = MIN(1, MAX(0, brightness - percent));

  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

static inline UIColor *MDCColorLighten(UIColor *color, CGFloat percent) {
  return MDCColorDarken(color, -percent);
}

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

@interface ChipsTests : XCTestCase

@end

@implementation ChipsTests

- (void)testDefaults {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];

  // Then
  CGSize expectedMinimumSize = CGSizeMake(0, 32);
  UIEdgeInsets expectedContentPadding = UIEdgeInsetsMake(4, 4, 4, 4);
  UIEdgeInsets expectedImagePadding = UIEdgeInsetsZero;
  UIEdgeInsets expectedAccessoryPadding = UIEdgeInsetsZero;
  UIEdgeInsets expectedTitlePadding = UIEdgeInsetsMake(3, 8, 4, 8);
  XCTAssertTrue(CGSizeEqualToSize(chip.minimumSize, expectedMinimumSize),
                @"(%@) is not equal to (%@)", NSStringFromCGSize(chip.minimumSize),
                NSStringFromCGSize(expectedMinimumSize));
  XCTAssertFalse(chip.mdc_adjustsFontForContentSizeCategory);
  XCTAssertNotNil(chip.selectedImageView);
  XCTAssertNotNil(chip.titleLabel);
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(chip.contentPadding, expectedContentPadding),
                @"(%@) is not equal to (%@)", NSStringFromUIEdgeInsets(chip.contentPadding),
                NSStringFromUIEdgeInsets(expectedContentPadding));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(chip.imagePadding, expectedImagePadding),
                @"(%@) is not equal to (%@)", NSStringFromUIEdgeInsets(chip.imagePadding),
                NSStringFromUIEdgeInsets(expectedImagePadding));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(chip.accessoryPadding, expectedAccessoryPadding),
                @"(%@) is not equal to (%@)", NSStringFromUIEdgeInsets(chip.accessoryPadding),
                NSStringFromUIEdgeInsets(expectedAccessoryPadding));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(chip.titlePadding, expectedTitlePadding),
                @"(%@) is not equal to (%@)", NSStringFromUIEdgeInsets(chip.titlePadding),
                NSStringFromUIEdgeInsets(expectedTitlePadding));
  XCTAssertNil(chip.titleFont);
  XCTAssertNil(chip.shapeGenerator);
  // Background color
  XCTAssertEqualObjects([chip backgroundColorForState:UIControlStateDisabled],
                        MDCColorLighten(MDCColorFromRGB(0xEBEBEB), 0.38f));
  XCTAssertEqualObjects([chip backgroundColorForState:UIControlStateSelected],
                        MDCColorDarken(MDCColorFromRGB(0xEBEBEB), 0.16f));

  // Elevation
  XCTAssertEqualWithAccuracy([chip elevationForState:UIControlStateHighlighted], 8, 0.001);

  // Title color
  UIColor *normalTitleColor = [UIColor colorWithWhite:0.13f alpha:1.0f];
  XCTAssertEqualObjects([chip titleColorForState:UIControlStateDisabled],
                        MDCColorLighten(normalTitleColor, 0.38f));

  UIControlState maximumState =
      UIControlStateDisabled | UIControlStateSelected | UIControlStateHighlighted;
  for (NSUInteger state = UIControlStateNormal; state < maximumState; ++state) {
    XCTAssertNil([chip borderColorForState:state]);
    XCTAssertNil([chip inkColorForState:state]);
    XCTAssertEqualWithAccuracy([chip borderWidthForState:state], 0, 0.001);
    XCTAssertEqualObjects([chip shadowColorForState:state],
                          [UIColor colorWithWhite:0 alpha:1]);
    if (state != UIControlStateDisabled) {
      XCTAssertEqualObjects([chip titleColorForState:state], normalTitleColor);
    }
    if (state != UIControlStateHighlighted) {
      XCTAssertEqualWithAccuracy([chip elevationForState:UIControlStateNormal], 0, 0.001);
    }
    if ((state != UIControlStateDisabled) && (state != UIControlStateSelected)) {
      XCTAssertEqualObjects([chip backgroundColorForState:UIControlStateNormal],
                            MDCColorFromRGB(0xEBEBEB));
    }
  }
}

- (void)testMinimumSizeWithSizeToFit {
  // Given
  MDCChipView *chipWithoutMinimum = [[MDCChipView alloc] init];
  MDCChipView *chipWithMinimumWidth = [[MDCChipView alloc] init];
  MDCChipView *chipWithMinimumHeight = [[MDCChipView alloc] init];
  MDCChipView *chipWithMinimumHeightAndWidth = [[MDCChipView alloc] init];
  CGFloat minimumDimension = 1000;

  // When
  chipWithoutMinimum.minimumSize = CGSizeZero;
  [chipWithoutMinimum sizeToFit];

  chipWithMinimumWidth.minimumSize = CGSizeMake(minimumDimension, 0);
  [chipWithMinimumWidth sizeToFit];

  chipWithMinimumHeight.minimumSize = CGSizeMake(0, minimumDimension);
  [chipWithMinimumHeight sizeToFit];

  chipWithMinimumHeightAndWidth.minimumSize = CGSizeMake(minimumDimension, minimumDimension);
  [chipWithMinimumHeightAndWidth sizeToFit];

  // Then
  XCTAssertLessThan(CGRectGetWidth(chipWithoutMinimum.bounds), minimumDimension);
  XCTAssertLessThan(CGRectGetHeight(chipWithoutMinimum.bounds), minimumDimension);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(chipWithMinimumWidth.bounds), minimumDimension, 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(chipWithMinimumWidth.bounds),
                             CGRectGetHeight(chipWithoutMinimum.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(chipWithMinimumHeight.bounds),
                             CGRectGetWidth(chipWithoutMinimum.bounds), 0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(chipWithMinimumHeight.bounds), minimumDimension,
                             0.001);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(chipWithMinimumHeightAndWidth.bounds), minimumDimension,
                             0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(chipWithMinimumHeightAndWidth.bounds), minimumDimension,
                             0.001);
}

- (void)testMinimumSizeWithIntrinsicContentSize {
  // Given
  MDCChipView *chipWithoutMinimum = [[MDCChipView alloc] init];
  MDCChipView *chipWithMinimumWidth = [[MDCChipView alloc] init];
  MDCChipView *chipWithMinimumHeight = [[MDCChipView alloc] init];
  MDCChipView *chipWithMinimumHeightAndWidth = [[MDCChipView alloc] init];
  CGFloat minimumDimension = 1000;

  // When
  chipWithoutMinimum.minimumSize = CGSizeZero;
  chipWithMinimumWidth.minimumSize = CGSizeMake(minimumDimension, 0);
  chipWithMinimumHeight.minimumSize = CGSizeMake(0, minimumDimension);
  chipWithMinimumHeightAndWidth.minimumSize = CGSizeMake(minimumDimension, minimumDimension);

  // Then
  XCTAssertLessThan(chipWithoutMinimum.intrinsicContentSize.width, minimumDimension);
  XCTAssertLessThan(chipWithoutMinimum.intrinsicContentSize.height, minimumDimension);
  XCTAssertEqualWithAccuracy(chipWithMinimumWidth.intrinsicContentSize.width, minimumDimension,
                             0.001);
  XCTAssertEqualWithAccuracy(chipWithMinimumWidth.intrinsicContentSize.height,
                             chipWithoutMinimum.intrinsicContentSize.height, 0.001);
  XCTAssertEqualWithAccuracy(chipWithMinimumHeight.intrinsicContentSize.width,
                             chipWithoutMinimum.intrinsicContentSize.width, 0.001);
  XCTAssertEqualWithAccuracy(chipWithMinimumHeight.intrinsicContentSize.height, minimumDimension,
                             0.001);
  XCTAssertEqualWithAccuracy(chipWithMinimumHeightAndWidth.intrinsicContentSize.width,
                             minimumDimension, 0.001);
  XCTAssertEqualWithAccuracy(chipWithMinimumHeightAndWidth.intrinsicContentSize.height,
                             minimumDimension, 0.001);
}

- (void)testLayoutWithHorizontalContentModeFill {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  chip.titleLabel.text = @"Chip";
  chip.imageView.image = TestImage(CGSizeMake(24, 24));

  // When
  chip.frame = CGRectMake(0, 0, 1000, 500);
  [chip layoutIfNeeded];

  // Then
  XCTAssertLessThan(CGRectGetMinX(chip.titleLabel.frame), CGRectGetMidX(chip.bounds));
  XCTAssertLessThan(CGRectGetMinY(chip.titleLabel.frame), CGRectGetMidY(chip.bounds));
  XCTAssertGreaterThan(CGRectGetMaxX(chip.titleLabel.frame), CGRectGetMidX(chip.bounds));
  XCTAssertGreaterThan(CGRectGetMaxY(chip.titleLabel.frame), CGRectGetMidY(chip.bounds));
  XCTAssertLessThan(CGRectGetMinX(chip.imageView.frame), CGRectGetMidX(chip.bounds));
  XCTAssertLessThan(CGRectGetMinY(chip.imageView.frame), CGRectGetMidY(chip.bounds));
  XCTAssertLessThan(CGRectGetMaxX(chip.imageView.frame), 100);
  XCTAssertGreaterThan(CGRectGetMaxY(chip.imageView.frame), CGRectGetMidY(chip.bounds));
}

- (void)testLayoutWithHorizontalContentModeCenter {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  chip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  chip.titleLabel.text = @"Chip";
  chip.imageView.image = TestImage(CGSizeMake(24, 24));

  // When
  chip.frame = CGRectMake(0, 0, 1000, 1000);
  [chip layoutIfNeeded];

  // Then
  XCTAssertLessThan(CGRectGetMinX(chip.titleLabel.frame), CGRectGetMidX(chip.bounds));
  XCTAssertLessThan(CGRectGetMinY(chip.titleLabel.frame), CGRectGetMidY(chip.bounds));
  XCTAssertGreaterThan(CGRectGetMaxX(chip.titleLabel.frame), CGRectGetMidX(chip.bounds));
  XCTAssertGreaterThan(CGRectGetMaxY(chip.titleLabel.frame), CGRectGetMidY(chip.bounds));
  XCTAssertLessThan(CGRectGetMinX(chip.imageView.frame), CGRectGetMidX(chip.bounds));
  XCTAssertLessThan(CGRectGetMinY(chip.imageView.frame), CGRectGetMidY(chip.bounds));
  XCTAssertGreaterThan(CGRectGetMaxX(chip.imageView.frame), 100);
  XCTAssertGreaterThan(CGRectGetMaxY(chip.imageView.frame), CGRectGetMidY(chip.bounds));
}

#pragma mark - Touch Target

- (void)testPointInsideWithCustomHitAreaInsets {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  chip.titleLabel.text = @"Chip";
  [chip sizeToFit];

  // When
  UIEdgeInsets hitAreaInsets = UIEdgeInsetsMake(-10, -8, -6, -4);

  chip.hitAreaInsets = hitAreaInsets;

  // Then
  CGRect chipBounds = CGRectStandardize(chip.bounds);
  const CGFloat delta = (CGFloat)0.001;
  // Top-left corner
  XCTAssertTrue([chip pointInside:CGPointMake(CGRectGetMinX(chipBounds) + hitAreaInsets.left,
                                              CGRectGetMinY(chipBounds) + hitAreaInsets.top)
                        withEvent:nil]);
  XCTAssertFalse([chip pointInside:CGPointMake(CGRectGetMinX(chipBounds) + hitAreaInsets.left -
                                                  delta,
                                               CGRectGetMinY(chipBounds) + hitAreaInsets.top -
                                                  delta)
                        withEvent:nil]);
  // Top-right corner
  XCTAssertTrue([chip pointInside:CGPointMake(CGRectGetMaxX(chipBounds) - hitAreaInsets.right -
                                                  delta,
                                              CGRectGetMinY(chipBounds) + hitAreaInsets.top)
                        withEvent:nil]);
  XCTAssertFalse([chip pointInside:CGPointMake(CGRectGetMaxX(chipBounds) - hitAreaInsets.right,
                                               CGRectGetMinY(chipBounds) + hitAreaInsets.top -
                                                  delta)
                        withEvent:nil]);
  // Bottom-left corner
  XCTAssertTrue([chip pointInside:CGPointMake(CGRectGetMinX(chipBounds) + hitAreaInsets.left,
                                              CGRectGetMaxY(chipBounds) - hitAreaInsets.bottom -
                                                  delta)
                        withEvent:nil]);
  XCTAssertFalse([chip pointInside:CGPointMake(CGRectGetMinX(chipBounds) + hitAreaInsets.left -
                                                  delta,
                                               CGRectGetMaxY(chipBounds) - hitAreaInsets.bottom)
                        withEvent:nil]);
  // Bottom-right corner
  XCTAssertTrue([chip pointInside:CGPointMake(CGRectGetMaxX(chipBounds) - hitAreaInsets.right -
                                                  delta,
                                              CGRectGetMaxY(chipBounds) - hitAreaInsets.bottom -
                                                  delta)
                        withEvent:nil]);
  XCTAssertFalse([chip pointInside:CGPointMake(CGRectGetMaxX(chipBounds) - hitAreaInsets.right,
                                               CGRectGetMaxY(chipBounds) - hitAreaInsets.bottom)
                        withEvent:nil]);
}

- (void)testChipsWithoutDeleteEnabled {
  // Given
  MDCChipField *field = [[MDCChipField alloc] init];
  field.textField.text = @"Test";

  // When
  [field createNewChipFromInput];
  NSUInteger chipCount = field.chips.count;

  // Then
  XCTAssertEqual(chipCount, 1);


  // When
  NSUInteger controlViewCount = 0;
  MDCChipView *chip = field.chips[0];
  for (UIView *subview in chip.subviews) {
    if ([subview isKindOfClass:[UIControl class]]) {
      controlViewCount += 1;
    }
  }

  // Then
  XCTAssertEqual(controlViewCount, 0);
}

- (void)testChipsWithDeleteEnabled {
  // Given
  MDCChipField *field = [[MDCChipField alloc] init];
  field.enableChipsThatDelete = YES;
  field.textField.text = @"Test";

  // When
  [field createNewChipFromInput];
  NSUInteger chipCount = field.chips.count;

  // Then
  XCTAssertEqual(chipCount, 1);

  // When
  NSUInteger controlViewCount = 0;
  MDCChipView *chip = field.chips[0];
  for (UIView *subview in chip.subviews) {
    if ([subview isKindOfClass:[UIControl class]]) {
      controlViewCount += 1;
    }
  }

  // Then
  XCTAssertEqual(controlViewCount, 1);
}

@end
