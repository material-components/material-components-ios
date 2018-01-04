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
#import "MDCPillShapeGenerator.h"

static UIImage *FakeImage(void) {
  CGSize imageSize = CGSizeMake(24, 24);
  UIGraphicsBeginImageContext(imageSize);
  [UIColor.whiteColor setFill];
  UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface ChipsEncodingTests : XCTestCase

@end

@implementation ChipsEncodingTests

- (void)testEncoding {
  // Given
  MDCChipView *chip = [[MDCChipView alloc] init];
  chip.inkColor = UIColor.cyanColor;
  chip.titleLabel.text = @"Title";
  chip.imageView.image = FakeImage();
  chip.selectedImageView.image =
      [FakeImage() imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  chip.imagePadding = UIEdgeInsetsMake(1, 2, 3, 4);
  chip.titlePadding = UIEdgeInsetsMake(2, 3, 4, 5);
  chip.contentPadding = UIEdgeInsetsMake(3, 4, 5, 6);
  chip.accessoryPadding = UIEdgeInsetsMake(4, 5, 6, 7);
  chip.shapeGenerator = [[MDCPillShapeGenerator alloc] init];
  chip.mdc_adjustsFontForContentSizeCategory = YES;
  [chip setBackgroundColor:UIColor.orangeColor forState:UIControlStateNormal];
  [chip setTitleColor:UIColor.magentaColor forState:UIControlStateNormal];
  [chip setBorderColor:UIColor.greenColor forState:UIControlStateNormal];
  [chip setBorderWidth:1.5 forState:UIControlStateNormal];
  [chip setElevation:MDCShadowElevationMenu forState:UIControlStateNormal];
  [chip setShadowColor:UIColor.purpleColor forState:UIControlStateNormal];

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:chip];
  MDCChipView *unarchivedChip = [NSKeyedUnarchiver unarchiveObjectWithData:archive];

  // Then
  XCTAssertEqualObjects(unarchivedChip.inkColor, chip.inkColor);
  XCTAssertEqualObjects(unarchivedChip.titleLabel.text, chip.titleLabel.text);
  XCTAssertNotNil(unarchivedChip.imageView.image);
  XCTAssertNotNil(unarchivedChip.selectedImageView.image);
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(unarchivedChip.imagePadding, chip.imagePadding),
                @"%@ is not equal to %@.",
                NSStringFromUIEdgeInsets(unarchivedChip.imagePadding),
                NSStringFromUIEdgeInsets(chip.imagePadding));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(unarchivedChip.titlePadding, chip.titlePadding),
                @"%@ is not equal to %@.",
                NSStringFromUIEdgeInsets(unarchivedChip.titlePadding),
                NSStringFromUIEdgeInsets(chip.titlePadding));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(unarchivedChip.contentPadding, chip.contentPadding),
                @"%@ is not equal to %@.",
                NSStringFromUIEdgeInsets(unarchivedChip.contentPadding),
                NSStringFromUIEdgeInsets(chip.contentPadding));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(unarchivedChip.accessoryPadding,
                                              chip.accessoryPadding),
                @"%@ is not equal to %@.",
                NSStringFromUIEdgeInsets(unarchivedChip.accessoryPadding),
                NSStringFromUIEdgeInsets(chip.accessoryPadding));
  // TODO(#2771): Support encoding shapeGenerator
  XCTAssertNil(unarchivedChip.shapeGenerator);
  XCTAssertTrue(unarchivedChip.mdc_adjustsFontForContentSizeCategory);
  XCTAssertEqualObjects([unarchivedChip backgroundColorForState:UIControlStateNormal],
                        [chip backgroundColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects([unarchivedChip titleColorForState:UIControlStateNormal],
                        [chip titleColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects([unarchivedChip borderColorForState:UIControlStateNormal],
                        [chip borderColorForState:UIControlStateNormal]);
  XCTAssertEqualWithAccuracy([unarchivedChip borderWidthForState:UIControlStateNormal],
                             [chip borderWidthForState:UIControlStateNormal],
                             0.0001);
  XCTAssertEqual([unarchivedChip elevationForState:UIControlStateNormal],
                 [chip elevationForState:UIControlStateNormal]);
  XCTAssertEqualObjects([unarchivedChip shadowColorForState:UIControlStateNormal],
                        [chip shadowColorForState:UIControlStateNormal]);
}

@end
