/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MDCChipViewColorThemer.h"

@interface ChipViewColorThemerTests : XCTestCase

@property (nonatomic, strong) MDCChipView *chip;
@property (nonatomic, strong) MDCSemanticColorScheme *colorScheme;

@end

@implementation ChipViewColorThemerTests

- (void)setUp {
  self.chip = [[MDCChipView alloc] init];
  self.colorScheme = [[MDCSemanticColorScheme alloc] init];
}

- (void)tearDown {
  self.chip = nil;
  self.colorScheme = nil;
}

- (void)testInputChipViewColorThemer {
  [MDCChipViewColorThemer applySemanticColorScheme:self.colorScheme toChipView:self.chip];
  [self verifyColorsWithColorScheme:self.colorScheme ChipView:self.chip stroked:NO];
}

- (void)testStrokedChipViewColorThemer {
  [MDCChipViewColorThemer applySemanticColorScheme:self.colorScheme toStrokedChipView:self.chip];
  [self verifyColorsWithColorScheme:self.colorScheme ChipView:self.chip stroked:YES];
}

- (void)verifyColorsWithColorScheme:(MDCSemanticColorScheme *)colorScheme
                           ChipView:(MDCChipView *)chipView
                            stroked:(BOOL)isStroked {
  UIColor *onSurface12Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f];
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f];

  UIColor *backgroundColor =
      [MDCSemanticColorScheme blendColor:onSurface12Opacity
                     withBackgroundColor:colorScheme.surfaceColor];
  UIColor *textColor =
      [MDCSemanticColorScheme blendColor:onSurface87Opacity
                     withBackgroundColor:colorScheme.surfaceColor];

  XCTAssertEqualObjects([chipView titleColorForState:UIControlStateNormal], textColor);
  if (!isStroked) {
    XCTAssertEqualObjects([chipView backgroundColorForState:UIControlStateNormal], backgroundColor);
  } else {
    XCTAssertEqualObjects([chipView backgroundColorForState:UIControlStateNormal],
                          colorScheme.surfaceColor);
    XCTAssertEqualObjects([chipView borderColorForState:UIControlStateNormal],
                          backgroundColor);
  }
}

@end
