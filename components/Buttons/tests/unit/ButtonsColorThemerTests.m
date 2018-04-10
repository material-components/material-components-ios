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

#import "MaterialButtons.h"
#import "MDCButtonColorThemer.h"

@interface ButtonsColorThemerTests : XCTestCase

@end

@implementation ButtonsColorThemerTests

- (void)testMDCButtonColorThemer {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Hello World" forState:UIControlStateNormal];
  colorScheme.primaryColor = UIColor.redColor;
  colorScheme.onPrimaryColor = UIColor.greenColor;
  colorScheme.onSurfaceColor = UIColor.blueColor;
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  [button setTitleColor:UIColor.greenColor forState:UIControlStateHighlighted];
  [button setTitleColor:UIColor.blueColor forState:UIControlStateSelected];
  [button setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.redColor forState:UIControlStateHighlighted];
  [button setBackgroundColor:UIColor.blueColor forState:UIControlStateSelected];
  [button setBackgroundColor:UIColor.darkGrayColor forState:UIControlStateDisabled];

  // Where
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];

  // Then
  XCTAssertEqual([button titleColorForState:UIControlStateNormal], colorScheme.onPrimaryColor);
  XCTAssertEqual([button titleColorForState:UIControlStateHighlighted], colorScheme.onPrimaryColor);
  XCTAssertEqual([button titleColorForState:UIControlStateSelected], colorScheme.onPrimaryColor);
  XCTAssert(
      CGColorEqualToColor([button titleColorForState:UIControlStateDisabled].CGColor,
                          [colorScheme.onSurfaceColor colorWithAlphaComponent:0.26f].CGColor));
  XCTAssertEqual([button backgroundColorForState:UIControlStateNormal], colorScheme.primaryColor);
  XCTAssertEqual([button backgroundColorForState:UIControlStateHighlighted],
                 colorScheme.primaryColor);
  XCTAssertEqual([button backgroundColorForState:UIControlStateSelected], colorScheme.primaryColor);
  XCTAssert(
      CGColorEqualToColor([button backgroundColorForState:UIControlStateDisabled].CGColor,
                          [colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f].CGColor));
  XCTAssertEqual(button.disabledAlpha, 1.f);
}

@end
