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

#import "MaterialDialogs+ColorThemer.h"
#import "MaterialDialogs.h"

#import "MDCAlertControllerView+Private.h"

#import <XCTest/XCTest.h>

#ifndef CGFLOAT_EPSILON
#if CGFLOAT_IS_DOUBLE
#define CGFLOAT_EPSILON DBL_EPSILON
#else
#define CGFLOAT_EPSILON FLT_EPSILON
#endif
#endif

@interface MDCAlertControllerColorThemerTests : XCTestCase

@end

@implementation MDCAlertControllerColorThemerTests

- (BOOL)color1:(UIColor *)color1 equalsColor2:(UIColor *)color2 {
  CGFloat red1 = 0;
  CGFloat green1 = 0;
  CGFloat blue1 = 0;
  CGFloat alpha1 = 0;
  [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
  CGFloat red2 = 0;
  CGFloat green2 = 0;
  CGFloat blue2 = 0;
  CGFloat alpha2 = 0;
  [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
  return (fabs(red1 - red2) < CGFLOAT_EPSILON && fabs(green1 - green2) < CGFLOAT_EPSILON &&
          fabs(blue1 - blue2) < CGFLOAT_EPSILON && fabs(alpha1 - alpha2) < CGFLOAT_EPSILON);
}

- (void)testApplyingColorScheme {
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [MDCAlertColorThemer applySemanticColorScheme:colorScheme toAlertController:alert];
#pragma clang diagnostic pop

  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
  XCTAssertTrue([self color1:view.titleLabel.textColor
                equalsColor2:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87]]);
  XCTAssertTrue([self color1:view.messageLabel.textColor
                equalsColor2:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60]]);
  XCTAssertEqualObjects(view.backgroundColor, colorScheme.surfaceColor);
  for (UIButton *button in view.actionManager.buttonsInActionOrder) {
    XCTAssertTrue([self color1:button.titleLabel.textColor equalsColor2:colorScheme.primaryColor]);
  }
}

@end
