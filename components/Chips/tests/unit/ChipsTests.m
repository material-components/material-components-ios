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

#import "MaterialChips.h"

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

@interface ChipsNoopTest : XCTestCase

@end

@implementation ChipsNoopTest

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

@end
