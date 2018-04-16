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
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
  [button setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateHighlighted];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateSelected];
  [button setBackgroundColor:UIColor.darkGrayColor forState:UIControlStateDisabled];

  // Where
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
      UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    if (state != UIControlStateDisabled) {
      if ([button titleColorForState:state] != nil) {
        XCTAssertEqual([button titleColorForState:state], colorScheme.onPrimaryColor);
      }
      if ([button backgroundColorForState:state] != nil) {
        XCTAssertEqual([button backgroundColorForState:state], colorScheme.primaryColor);
      }
    } else {
      XCTAssert(
          CGColorEqualToColor([button titleColorForState:state].CGColor,
                              [colorScheme.onSurfaceColor colorWithAlphaComponent:0.26f].CGColor));
      XCTAssert(
          CGColorEqualToColor([button backgroundColorForState:state].CGColor,
                              [colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f].CGColor));
    }
  }
  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1.f, 0.001f);
}

- (void)testMDCFlatButtonColorThemer {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  MDCFlatButton *button = [[MDCFlatButton alloc] init];
  [button setTitle:@"Hello World" forState:UIControlStateNormal];
  colorScheme.primaryColor = UIColor.redColor;
  colorScheme.onSurfaceColor = UIColor.blueColor;
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
  [button setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateHighlighted];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateSelected];
  [button setBackgroundColor:UIColor.darkGrayColor forState:UIControlStateDisabled];

  // Where
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toFlatButton:button];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
      UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    if (state != UIControlStateDisabled) {
      if ([button titleColorForState:state] != nil) {
        XCTAssertEqual([button titleColorForState:state], colorScheme.primaryColor);
      }
      if ([button backgroundColorForState:state] != nil) {
        XCTAssertEqual([button backgroundColorForState:state], UIColor.clearColor);
      }
    } else {
      XCTAssert(
          CGColorEqualToColor([button titleColorForState:state].CGColor,
                              [colorScheme.onSurfaceColor colorWithAlphaComponent:0.26f].CGColor));
      XCTAssertEqual([button backgroundColorForState:state], UIColor.clearColor);
    }
  }
  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1.f, 0.001f);
}

- (void)testMDCRaisedButtonColorThemer {
  // Given
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  MDCRaisedButton *button = [[MDCRaisedButton alloc] init];
  [button setTitle:@"Hello World" forState:UIControlStateNormal];
  colorScheme.primaryColor = UIColor.redColor;
  colorScheme.onPrimaryColor = UIColor.greenColor;
  colorScheme.onSurfaceColor = UIColor.blueColor;
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
  [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
  [button setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateHighlighted];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateSelected];
  [button setBackgroundColor:UIColor.darkGrayColor forState:UIControlStateDisabled];

  // Where
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];

  // Then
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
      UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    if (state != UIControlStateDisabled) {
      if ([button titleColorForState:state] != nil) {
        XCTAssertEqual([button titleColorForState:state], colorScheme.onPrimaryColor);
      }
      if ([button backgroundColorForState:state] != nil) {
        XCTAssertEqual([button backgroundColorForState:state], colorScheme.primaryColor);
      }
    } else {
      XCTAssert(
          CGColorEqualToColor([button titleColorForState:state].CGColor,
                              [colorScheme.onSurfaceColor colorWithAlphaComponent:0.26f].CGColor));
      XCTAssert(
          CGColorEqualToColor([button backgroundColorForState:state].CGColor,
                              [colorScheme.onSurfaceColor colorWithAlphaComponent:0.12f].CGColor));
    }
  }
  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1.f, 0.001f);
}

@end
