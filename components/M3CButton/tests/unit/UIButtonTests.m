// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "M3CButton.h"

NS_ASSUME_NONNULL_BEGIN

static const UIControlState kNumUIControlStates = 2 * UIControlStateSelected - 1;
static const UIControlState kUIControlStateDisabledHighlighted =
    UIControlStateHighlighted | UIControlStateDisabled;

static NSString *controlStateDescription(UIControlState controlState) {
  if (controlState == UIControlStateNormal) {
    return @"Normal";
  }
  NSMutableString *string = [NSMutableString string];
  if ((UIControlStateHighlighted & controlState) == UIControlStateHighlighted) {
    [string appendString:@"Highlighted "];
  }
  if ((UIControlStateDisabled & controlState) == UIControlStateDisabled) {
    [string appendString:@"Disabled "];
  }
  if ((UIControlStateSelected & controlState) == UIControlStateSelected) {
    [string appendString:@"Selected "];
  }
  return [string copy];
}

@interface M3CButtonUIButtonTests : XCTestCase
@property(nonatomic, strong, nullable) M3CButton *button;
@end

@implementation M3CButtonUIButtonTests

- (void)setUp {
  [super setUp];

  self.button = [[M3CButton alloc] init];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

#pragma mark - UIButton strangeness

- (void)testTitleColorForState {
  for (NSUInteger controlState = 0; controlState < kNumUIControlStates; ++controlState) {
    if (controlState & kUIControlStateDisabledHighlighted) {
      // We skip the Disabled Highlighted state because UIButton titleColorForState ignores it.
      continue;
    }
    // Given
    UIColor *color = [UIColor blueColor];

    // When
    [self.button setTitleColor:color forState:controlState];

    // Then
    XCTAssertEqualObjects([self.button titleColorForState:controlState], color,
                          @"for control state:%@ ", controlStateDescription(controlState));
  }
}
- (void)testTitleColorForStateDisabledHighlight {
  // This is strange that setting the color for a state does not return the value of that state.
  // It turns out that it returns the value set to the normal state.

  // Given
  UIControlState controlState = kUIControlStateDisabledHighlighted;
  UIColor *color = [UIColor blueColor];
  UIColor *normalColor = [UIColor greenColor];
  [self.button setTitleColor:normalColor forState:UIControlStateNormal];

  // When
  [self.button setTitleColor:color forState:controlState];

  // Then
  XCTAssertEqualObjects([self.button titleColorForState:controlState], normalColor,
                        @"for control state:%@ ", controlStateDescription(controlState));
  XCTAssertNotEqualObjects([self.button titleColorForState:controlState], color,
                           @"for control state:%@ ", controlStateDescription(controlState));
}

#pragma mark - UIButton state changes

- (void)testEnabled {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = (BOOL)arc4random_uniform(2);
  button.selected = (BOOL)arc4random_uniform(2);
  button.enabled = (BOOL)arc4random_uniform(2);

  // When
  button.enabled = YES;

  // Then
  XCTAssertTrue(button.enabled);
  XCTAssertFalse(button.state & UIControlStateDisabled);
}

- (void)testDisabled {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = (BOOL)arc4random_uniform(2);
  button.selected = (BOOL)arc4random_uniform(2);
  button.enabled = (BOOL)arc4random_uniform(2);

  // When
  button.enabled = NO;

  // Then
  XCTAssertFalse(button.enabled);
  XCTAssertTrue(button.state & UIControlStateDisabled);
}

- (void)testHighlighted {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = NO;
  button.selected = (BOOL)arc4random_uniform(2);

  // For some reason we can only set the highlighted state to YES if its enabled is also YES.
  button.enabled = YES;

  UIControlState oldState = button.state;
  XCTAssertFalse(button.highlighted);

  // When
  button.highlighted = YES;

  // Then
  XCTAssertTrue(button.highlighted);
  XCTAssertTrue(button.state & UIControlStateHighlighted);
  XCTAssertEqual(button.state, (oldState | UIControlStateHighlighted));
}

- (void)testUnhighlighted {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = YES;
  button.selected = (BOOL)arc4random_uniform(2);
  button.enabled = (BOOL)arc4random_uniform(2);
  UIControlState oldState = button.state;
  XCTAssertTrue(button.highlighted);

  // When
  button.highlighted = NO;

  // Then
  XCTAssertFalse(button.highlighted);
  XCTAssertFalse(button.state & UIControlStateHighlighted);
  XCTAssertEqual(button.state, (oldState & ~UIControlStateHighlighted));
}

- (void)testSelected {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = (BOOL)arc4random_uniform(2);
  button.selected = NO;
  button.enabled = (BOOL)arc4random_uniform(2);
  UIControlState oldState = button.state;

  // When
  button.selected = YES;

  // Then
  XCTAssertTrue(button.selected);
  XCTAssertTrue(button.state & UIControlStateSelected);
  XCTAssertEqual(button.state, (oldState | UIControlStateSelected));
}

- (void)testUnselected {
  // Given
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.highlighted = (BOOL)arc4random_uniform(2);
  button.selected = YES;
  button.enabled = (BOOL)arc4random_uniform(2);

  // When
  button.selected = NO;

  // Then
  XCTAssertFalse(button.selected);
  XCTAssertFalse(button.state & UIControlStateSelected);
}

@end

NS_ASSUME_NONNULL_END
