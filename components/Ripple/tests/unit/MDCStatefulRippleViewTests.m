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

#import "../../src/private/MDCRippleLayer.h"
#import "MaterialRipple.h"

@interface MDCStatefulRippleView (UnitTests)
@property(nonatomic, strong) MDCRippleLayer *activeRippleLayer;
@property(nonatomic, strong) CAShapeLayer *maskLayer;
@end

/** Unit tests for MDCStatefulRippleView. */
@interface MDCStatefulRippleViewTests : XCTestCase

@end

@implementation MDCStatefulRippleViewTests

- (void)testInit {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];

  // Then
  XCTAssertNil(rippleView.rippleViewDelegate);
  XCTAssertEqualObjects(rippleView.rippleColor, [[UIColor alloc] initWithWhite:0
                                                                         alpha:(CGFloat)0.16]);
  XCTAssertEqual(rippleView.rippleStyle, MDCRippleStyleBounded);
}

- (void)testDefaultRippleColorForState {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];

  // Then
  UIColor *selectionColor = [UIColor colorWithRed:(CGFloat)0.384
                                            green:0
                                             blue:(CGFloat)0.933
                                            alpha:1];
  XCTAssertEqualObjects([rippleView rippleColorForState:MDCRippleStateNormal],
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqualObjects([rippleView rippleColorForState:MDCRippleStateHighlighted],
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqualObjects([rippleView rippleColorForState:MDCRippleStateSelected],
                        [selectionColor colorWithAlphaComponent:(CGFloat)0.08]);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MDCRippleStateSelected | MDCRippleStateHighlighted)],
      [selectionColor colorWithAlphaComponent:(CGFloat)0.12]);
  XCTAssertEqualObjects([rippleView rippleColorForState:MDCRippleStateDragged],
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.08]);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MDCRippleStateDragged | MDCRippleStateHighlighted)],
      [UIColor colorWithWhite:0 alpha:(CGFloat)0.08]);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MDCRippleStateDragged | MDCRippleStateSelected)],
      [selectionColor colorWithAlphaComponent:(CGFloat)0.08]);
}

- (void)testSetRippleColorForStateAndFallbacks {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];

  // When
  for (int i = 0; i < 8; i++) {
    [rippleView setRippleColor:nil forState:(NSInteger)i];
  }
  [rippleView setRippleColor:UIColor.blueColor forState:MDCRippleStateDragged];
  [rippleView setRippleColor:UIColor.greenColor forState:MDCRippleStateSelected];
  [rippleView setRippleColor:UIColor.redColor forState:MDCRippleStateNormal];

  // Then
  XCTAssertEqualObjects([rippleView rippleColorForState:MDCRippleStateDragged], UIColor.blueColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MDCRippleStateSelected],
                        UIColor.greenColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MDCRippleStateNormal], UIColor.redColor);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MDCRippleStateDragged | MDCRippleStateHighlighted)],
      UIColor.blueColor);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MDCRippleStateSelected | MDCRippleStateHighlighted)],
      UIColor.greenColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MDCRippleStateHighlighted],
                        UIColor.redColor);
}

- (void)testAllowsSelection {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];

  // When
  rippleView.allowsSelection = NO;
  rippleView.selected = YES;

  // Then
  XCTAssertFalse(rippleView.selected);
  XCTAssertFalse(rippleView.dragged);
  XCTAssertFalse(rippleView.rippleHighlighted);
}

- (void)testRippleSelected {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];

  // When
  rippleView.allowsSelection = YES;
  rippleView.selected = YES;

  // Then
  XCTAssertTrue(rippleView.selected);
  XCTAssertFalse(rippleView.dragged);
  XCTAssertFalse(rippleView.rippleHighlighted);
}

- (void)testRippleDragged {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];

  // When
  rippleView.dragged = YES;

  // Then
  XCTAssertFalse(rippleView.selected);
  XCTAssertTrue(rippleView.dragged);
  XCTAssertFalse(rippleView.rippleHighlighted);
}

- (void)testRippleHighlighted {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];

  // When
  rippleView.rippleHighlighted = YES;

  // Then
  XCTAssertFalse(rippleView.selected);
  XCTAssertFalse(rippleView.dragged);
  XCTAssertTrue(rippleView.rippleHighlighted);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCStatefulRippleView *testRippleView = [[MDCStatefulRippleView alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCRippleView *passedRippleView = nil;
  testRippleView.traitCollectionDidChangeBlock =
      ^(MDCRippleView *_Nonnull ripple, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedRippleView = ripple;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [testRippleView traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedRippleView, testRippleView);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

@end
