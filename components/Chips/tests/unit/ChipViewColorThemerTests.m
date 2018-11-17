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

#import <XCTest/XCTest.h>

#import "MaterialChips.h"
#import "MaterialChips+ColorThemer.h"

@interface ChipViewColorThemerTests : XCTestCase

@property (nonatomic, strong) MDCChipView *chip;
@property (nonatomic, strong) MDCSemanticColorScheme *colorScheme;

@end

@implementation ChipViewColorThemerTests

- (void)setUp {
  self.chip = [[MDCChipView alloc] init];
  self.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
}

- (void)tearDown {
  self.chip = nil;
  self.colorScheme = nil;
}

- (void)testInputChipViewColorThemer {
  [MDCChipViewColorThemer applySemanticColorScheme:self.colorScheme toChipView:self.chip];
  UIColor *onSurface12Opacity =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12];
  UIColor *onSurface87Opacity =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface16Opacity =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.16];

  UIColor *backgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:self.colorScheme.surfaceColor];
  UIColor *selectedBackgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:backgroundColor];
  UIColor *textColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:backgroundColor];
  UIColor *selectedTextColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:selectedBackgroundColor];

  XCTAssertEqualObjects([self.chip inkColorForState:UIControlStateNormal], onSurface16Opacity);
  XCTAssertEqualObjects([self.chip titleColorForState:UIControlStateNormal], textColor);
  XCTAssertEqualObjects([self.chip backgroundColorForState:UIControlStateNormal], backgroundColor);
  XCTAssertEqualObjects([self.chip backgroundColorForState:UIControlStateSelected],
                        selectedBackgroundColor);
  XCTAssertEqualObjects([self.chip titleColorForState:UIControlStateSelected], selectedTextColor);
  XCTAssertEqualObjects([self.chip backgroundColorForState:UIControlStateDisabled],
                        [backgroundColor colorWithAlphaComponent:(CGFloat)0.38]);
  XCTAssertEqualObjects([self.chip titleColorForState:UIControlStateDisabled],
                        [textColor colorWithAlphaComponent:(CGFloat)0.38]);
}

- (void)testStrokedChipViewColorThemer {
  [MDCChipViewColorThemer applyOutlinedVariantWithColorScheme:self.colorScheme
                                                   toChipView:self.chip];
  UIColor *onSurface12Opacity =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12];
  UIColor *onSurface87Opacity =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface16Opacity =
      [self.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.16];
  UIColor *selectedBackgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:self.colorScheme.surfaceColor];
  UIColor *borderColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:self.colorScheme.surfaceColor];
  UIColor *textColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:self.colorScheme.surfaceColor];
  UIColor *selectedTextColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:selectedBackgroundColor];

  XCTAssertEqualObjects([self.chip borderColorForState:UIControlStateNormal], borderColor);
  XCTAssertEqualObjects([self.chip borderColorForState:UIControlStateSelected],
                        [UIColor clearColor]);
  XCTAssertEqualObjects([self.chip inkColorForState:UIControlStateNormal], onSurface16Opacity);
  XCTAssertEqualObjects([self.chip titleColorForState:UIControlStateNormal], textColor);
  XCTAssertEqualObjects([self.chip backgroundColorForState:UIControlStateNormal],
                        self.colorScheme.surfaceColor);
  XCTAssertEqualObjects([self.chip backgroundColorForState:UIControlStateSelected],
                        selectedBackgroundColor);
  XCTAssertEqualObjects([self.chip titleColorForState:UIControlStateSelected], selectedTextColor);
  XCTAssertEqualObjects([self.chip backgroundColorForState:UIControlStateDisabled],
                        [self.colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
  XCTAssertEqualObjects([self.chip titleColorForState:UIControlStateDisabled],
                        [textColor colorWithAlphaComponent:(CGFloat)0.38]);
}

- (void)testBackgroundColorAfterColorTheming {
  self.colorScheme.surfaceColor = [UIColor blueColor];
  [MDCChipViewColorThemer applyOutlinedVariantWithColorScheme:self.colorScheme
                                                   toChipView:self.chip];
  XCTAssertEqualObjects(self.colorScheme.surfaceColor, self.chip.backgroundColor);
}

@end
