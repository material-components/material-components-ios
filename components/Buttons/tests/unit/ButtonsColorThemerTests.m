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

#import "MaterialButtons+ColorThemer.h"
#import "MaterialButtons.h"

static const CGFloat kEpsilonAccuracy = (CGFloat)0.001;

@interface ButtonsColorThemerTests : XCTestCase

@end

@implementation ButtonsColorThemerTests

- (void)testTextButtonColorThemer {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // When
  [MDCTextButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];

  // Then
  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1, kEpsilonAccuracy);
  XCTAssertEqualObjects([button backgroundColorForState:UIControlStateNormal], UIColor.clearColor);
  XCTAssertEqualObjects([button backgroundColorForState:UIControlStateDisabled],
                        [button backgroundColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateNormal], colorScheme.primaryColor);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateDisabled],
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    if (state == UIControlStateDisabled) {
      continue;  // This state is manually checked above.
    }
    XCTAssertEqualObjects([button backgroundColorForState:state],
                          [button backgroundColorForState:UIControlStateNormal]);
    XCTAssertEqualObjects([button titleColorForState:state], colorScheme.primaryColor, @"state:%lu",
                          (unsigned long)state);
  }
}

- (void)testContainedButtonColorThemer {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // When
  [MDCContainedButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];

  // Then
  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1, kEpsilonAccuracy);
  XCTAssertEqualObjects([button backgroundColorForState:UIControlStateNormal],
                        colorScheme.primaryColor);
  XCTAssertEqualObjects([button backgroundColorForState:UIControlStateDisabled],
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12]);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateNormal],
                        colorScheme.onPrimaryColor);
  XCTAssertEqualObjects([button titleColorForState:UIControlStateDisabled],
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    if (state == UIControlStateDisabled) {
      continue;  // This state is manually checked above.
    }
    XCTAssertEqualObjects([button backgroundColorForState:state],
                          [button backgroundColorForState:UIControlStateNormal]);
    XCTAssertEqualObjects([button titleColorForState:state], colorScheme.onPrimaryColor,
                          @"state:%lu", (unsigned long)state);
  }
}

- (void)testMDCButtonColorThemer {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
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

  // When
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
      XCTAssert(CGColorEqualToColor(
          [button titleColorForState:state].CGColor,
          [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38].CGColor));
      XCTAssert(CGColorEqualToColor(
          [button backgroundColorForState:state].CGColor,
          [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12].CGColor));
    }
  }
  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1, (CGFloat)0.001);
}

- (void)testMDCFlatButtonColorThemer {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
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
      XCTAssert(CGColorEqualToColor(
                    [button titleColorForState:state].CGColor,
                    [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38].CGColor),
                @"state:%lu", (unsigned long)state);
      XCTAssertEqual([button backgroundColorForState:state], UIColor.clearColor, @"state:%lu",
                     (unsigned long)state);
    }
  }
  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1, (CGFloat)0.001);
}

- (void)testMDCRaisedButtonColorThemer {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
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

  // When
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
      XCTAssert(CGColorEqualToColor(
          [button titleColorForState:state].CGColor,
          [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38].CGColor));
      XCTAssert(CGColorEqualToColor(
          [button backgroundColorForState:state].CGColor,
          [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12].CGColor));
    }
  }
  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1, (CGFloat)0.001);
}

- (void)testMDCFloatingButtonColorThemer {
  // Given
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
  colorScheme.secondaryColor = UIColor.redColor;
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateNormal];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateHighlighted];
  [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateSelected];
  [button setBackgroundColor:UIColor.darkGrayColor forState:UIControlStateDisabled];

  // Where
  [MDCFloatingButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];

  // Then
  NSUInteger maximumStateValue =
      UIControlStateSelected | UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    XCTAssertEqualObjects([button backgroundColorForState:state], colorScheme.secondaryColor,
                          @"Background color (%@) is not equal to (%@) for state (%lu).",
                          [button backgroundColorForState:state], colorScheme.secondaryColor,
                          (unsigned long)state);
    XCTAssertEqualObjects([button imageTintColorForState:state], colorScheme.onSecondaryColor,
                          @"Image tint color (%@) is not equal to (%@) for state (%lu).",
                          [button imageTintColorForState:state], colorScheme.onSecondaryColor,
                          (unsigned long)state);

    // TODO(https://github.com/material-components/material-components-ios/issues/3062 ):
    //   Title color for state is forced to UIColor.black in disabled state unless a disabled color
    //   is set explicitly.
    if (state == UIControlStateDisabled) {
      XCTAssertEqualObjects([button titleColorForState:state], UIColor.blackColor,
                            @"Title color for the disabled state should be black.");
    } else {
      XCTAssertEqualObjects([button titleColorForState:state], colorScheme.onSecondaryColor,
                            @"Title color (%@) is not equal to (%@) for state (%lu).)",
                            [button titleColorForState:state], colorScheme.onSecondaryColor,
                            (unsigned long)state);
    }
  }

  XCTAssertEqualWithAccuracy(button.disabledAlpha, 1, (CGFloat)0.001);
}

@end
