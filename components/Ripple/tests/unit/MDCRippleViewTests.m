// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialRipple.h"

#pragma mark - Tests

@interface MDCRippleViewTests : XCTestCase

@end

@implementation MDCRippleViewTests

- (void)testInit {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];

  // Then
//  XCTAssertTrue(rippleView.usesLegacyRippleRipple);
//  XCTAssertFalse(rippleView.usesCustomRippleCenter);
//  XCTAssertTrue(CGPointEqualToPoint(rippleView.customRippleCenter, CGPointZero),
//                @"%@ is not equal to %@",
//                NSStringFromCGPoint(rippleView.customRippleCenter),
//                NSStringFromCGPoint(CGPointZero));
  XCTAssertNil(rippleView.rippleViewDelegate);
  XCTAssertEqualObjects(rippleView.rippleColor, [[UIColor alloc] initWithWhite:0 alpha:0.16]);
  XCTAssertEqual(rippleView.rippleStyle, MDCRippleStyleBounded);
//  XCTAssertEqualWithAccuracy(rippleView.maxRippleRadius, 0.0, 0.0001);
}

- (void)testNewRippleUsesMaxRippleRadiusWhenUnbounded {
  // Given
  MDCRippleView *rippleViewStyleThenRadius = [[MDCRippleView alloc] init];
  MDCRippleView *rippleViewRadiusThenStyle = [[MDCRippleView alloc] init];
//  rippleViewStyleThenRadius.usesLegacyRippleRipple = NO;
//  rippleViewRadiusThenStyle.usesLegacyRippleRipple = NO;

  // When
  rippleViewStyleThenRadius.rippleStyle = MDCRippleStyleUnbounded;
//  rippleViewStyleThenRadius.maxRippleRadius = 12;
//  rippleViewRadiusThenStyle.maxRippleRadius = 12;
  rippleViewRadiusThenStyle.rippleStyle = MDCRippleStyleUnbounded;


  // Then
//  XCTAssertEqualWithAccuracy(rippleViewStyleThenRadius.maxRippleRadius, 12, 0.0001);
//  XCTAssertEqualWithAccuracy(rippleViewRadiusThenStyle.maxRippleRadius, 12, 0.0001);
}

- (void)testLegacyRippleUsesMaxRippleRadiusWhenUnbounded {
  // Given
  MDCRippleView *rippleViewStyleThenRadius = [[MDCRippleView alloc] init];
  MDCRippleView *rippleViewRadiusThenStyle = [[MDCRippleView alloc] init];
//  rippleViewStyleThenRadius.usesLegacyRippleRipple = YES;
//  rippleViewRadiusThenStyle.usesLegacyRippleRipple = YES;

  // When
  rippleViewStyleThenRadius.rippleStyle = MDCRippleStyleUnbounded;
//  rippleViewStyleThenRadius.maxRippleRadius = 12;
//  rippleViewRadiusThenStyle.maxRippleRadius = 12;
  rippleViewRadiusThenStyle.rippleStyle = MDCRippleStyleUnbounded;


  // Then
//  XCTAssertEqualWithAccuracy(rippleViewStyleThenRadius.maxRippleRadius, 12, 0.0001);
//  XCTAssertEqualWithAccuracy(rippleViewRadiusThenStyle.maxRippleRadius, 12, 0.0001);
}

//- (void)testNewRippleIgnoresMaxRippleRadiusWhenBounded {
//  // Given
//  MDCRippleView *rippleViewStyleThenRadius = [[MDCRippleView alloc] init];
//  MDCRippleView *rippleViewRadiusThenStyle = [[MDCRippleView alloc] init];
//  rippleViewStyleThenRadius.usesLegacyRippleRipple = NO;
//  rippleViewRadiusThenStyle.usesLegacyRippleRipple = NO;
//
//  // When
//  rippleViewStyleThenRadius.rippleStyle = MDCRippleStyleBounded;
//  rippleViewStyleThenRadius.maxRippleRadius = 12;
//  rippleViewRadiusThenStyle.maxRippleRadius = 12;
//  rippleViewRadiusThenStyle.rippleStyle = MDCRippleStyleBounded;
//
//
//  // Then
//  XCTAssertEqualWithAccuracy(rippleViewStyleThenRadius.maxRippleRadius, 0, 0.0001);
//  XCTAssertEqualWithAccuracy(rippleViewRadiusThenStyle.maxRippleRadius, 0, 0.0001);
//}

//- (void)testLegacyRippleUsesMaxRippleRadiusWhenBounded {
//  // Given
//  MDCRippleView *rippleViewStyleThenRadius = [[MDCRippleView alloc] init];
//  MDCRippleView *rippleViewRadiusThenStyle = [[MDCRippleView alloc] init];
//  rippleViewStyleThenRadius.usesLegacyRippleRipple = YES;
//  rippleViewRadiusThenStyle.usesLegacyRippleRipple = YES;
//
//  // When
//  rippleViewStyleThenRadius.rippleStyle = MDCRippleStyleBounded;
//  rippleViewStyleThenRadius.maxRippleRadius = 12;
//  rippleViewRadiusThenStyle.maxRippleRadius = 12;
//  rippleViewRadiusThenStyle.rippleStyle = MDCRippleStyleBounded;
//
//
//  // Then
//  XCTAssertEqualWithAccuracy(rippleViewStyleThenRadius.maxRippleRadius, 12, 0.0001);
//  XCTAssertEqualWithAccuracy(rippleViewRadiusThenStyle.maxRippleRadius, 12, 0.0001);
//}

@end
