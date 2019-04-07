// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialRipple.h"

static UIColor *GetDefaultInkColor(void) {
  return [UIColor colorWithWhite:1 alpha:(CGFloat)0.2];
}

@interface MDCButton (Testing)
@property(nonatomic, strong, readonly) MDCStatefulRippleView *rippleView;
@property(nonatomic, strong) MDCInkView *inkView;
@end

@interface ButtonRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCButton *button;

@end

@implementation ButtonRippleTests

- (void)setUp {
  [super setUp];

  self.button = [[MDCButton alloc] init];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)testDefaults {
  // Then
  XCTAssertNotNil(self.button.rippleView);
  XCTAssertEqualObjects(self.button.rippleView.rippleColor, GetDefaultInkColor());
  XCTAssertEqualObjects(self.button.rippleView.rippleColor, self.button.inkView.inkColor);
  XCTAssertEqual(self.button.rippleView.rippleStyle, MDCRippleStyleBounded);
  XCTAssertFalse(self.button.enableRippleBehavior);
  XCTAssertNil(self.button.rippleView.superview);
}

- (void)testEnableRippleBehavior {
  // When
  self.button.enableRippleBehavior = YES;

  // Then
  XCTAssertNil(self.button.inkView.superview);
  XCTAssertEqualObjects(self.button.rippleView.superview, self.button);
}

- (void)testSetEnableRippleBehaviorToYesThenNo {
  // When
  self.button.enableRippleBehavior = YES;
  self.button.enableRippleBehavior = NO;

  // Then
  XCTAssertEqualObjects(self.button.inkView.superview, self.button);
  XCTAssertNil(self.button.rippleView.superview);
}

- (void)testSetCustomInkColor {
  // When
  UIColor *fakeColor = UIColor.redColor;
  self.button.inkColor = fakeColor;

  // Then
  XCTAssertEqualObjects(self.button.rippleView.rippleColor, fakeColor);
}

- (void)testSetInkStyleUnbounded {
  // When
  self.button.inkStyle = MDCInkStyleUnbounded;

  // Then
  XCTAssertEqual(self.button.rippleView.rippleStyle, MDCRippleStyleUnbounded);
}

- (void)testSetInkStyleBounded {
  // When
  self.button.inkStyle = MDCInkStyleBounded;

  // Then
  XCTAssertEqual(self.button.rippleView.rippleStyle, MDCRippleStyleBounded);
}

@end
