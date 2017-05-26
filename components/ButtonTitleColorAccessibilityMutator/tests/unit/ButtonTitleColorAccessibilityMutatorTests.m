/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialButtonTitleColorAccessibilityMutator.h"
#import "MaterialButtons.h"

// A value greater than the largest value created by combining normal values of UIControlState.
// This is a complete hack, but UIControlState doesn't expose anything useful here.
// This assumes that UIControlState is actually a set of bitfields and ignores application-specific
// values.
static const UIControlState kNumUIControlStates = 2 * UIControlStateSelected - 1;
static const UIControlState kUIControlStateDisabledHighlighted =
    UIControlStateHighlighted | UIControlStateDisabled;

static NSArray<UIColor *> *testColors(){
  return @[[UIColor whiteColor], [UIColor blackColor], [UIColor redColor], [UIColor orangeColor],
           [UIColor greenColor], [UIColor blueColor], [UIColor grayColor]];
}

@interface ButtonTitleColorAccessibilityMutatorTests : XCTestCase
@end

@implementation ButtonTitleColorAccessibilityMutatorTests

- (void)testMutateChangesTextColor {
  for (UIColor *color in testColors()) {
    for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
      // Given
      MDCButtonTitleColorAccessibilityMutator *mutator =
      [[MDCButtonTitleColorAccessibilityMutator alloc] init];
      MDCButton *button = [[MDCButton alloc] init];
      // Making the background color the same as the title color.
      [button setBackgroundColor:color forState:(UIControlState)controlState];
      [button setTitleColor:color forState:(UIControlState)controlState];
      
      // When
      [mutator mutate:button];
      
      // Then
      XCTAssertNotEqualObjects([button titleColorForState:controlState], color,
                               @"for control state:%@ ", [self controlState:controlState]);
    }
  }
}

- (void)testMutateKeepsAccessibleTextColor {
  NSDictionary* colors = @{ [UIColor redColor]: [UIColor blackColor]};
  for (UIColor *color in colors) {
    for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
      if (controlState & kUIControlStateDisabledHighlighted) {
        // We skip the Disabled Highlighted state because UIButton setter ignores it.
        // see: testTitleColorForStateDisabledHighlight
        continue;
      }
      // Given
      MDCButtonTitleColorAccessibilityMutator *mutator =
      [[MDCButtonTitleColorAccessibilityMutator alloc] init];
      MDCButton *button = [[MDCButton alloc] init];
      UIColor *backgroundColor = colors[color];
      UIColor *titleColor = color;
      // Making the background color the same as the title color.
      [button setBackgroundColor:backgroundColor forState:(UIControlState)controlState];
      [button setTitleColor:titleColor forState:(UIControlState)controlState];
      
      // When
      [mutator mutate:button];
      
      // Then
      XCTAssertEqualObjects([button titleColorForState:controlState], titleColor,
                            @"for control state:%@ ", [self controlState:controlState]);
    }
  }
}

- (void)testMutateUsesUnderlyingColorIfButtonBackgroundColorIsTransparent {
  for (UIColor *color in testColors()) {
    for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
      // Given
      NSUInteger controlState = 0;
      MDCButtonTitleColorAccessibilityMutator *mutator =
      [[MDCButtonTitleColorAccessibilityMutator alloc] init];
      MDCButton *button = [[MDCButton alloc] init];
      button.underlyingColorHint = color;
      [button setBackgroundColor:[UIColor clearColor] forState:controlState];
      [button setTitleColor:color forState:(UIControlState)controlState];
      
      // When
      [mutator mutate:button];
      
      // Then
      XCTAssertNotEqualObjects([button titleColorForState:controlState], color,
                               @"for control state:%@ ", [self controlState:controlState]);
    }
  }
}

- (NSString*)controlState:(UIControlState)controlState {
  NSMutableString *string = [NSMutableString string];
  if (UIControlStateNormal) {
    return @".Normal";
  }
  if (controlState & UIControlStateHighlighted) {
    [string appendString:@"Highlighted "];
  }
  if (controlState & UIControlStateDisabled) {
    [string appendString:@"Disabled "];
  }
  if (controlState & UIControlStateSelected) {
    [string appendString:@"Selected "];
  }
  return [string copy];
}

@end
