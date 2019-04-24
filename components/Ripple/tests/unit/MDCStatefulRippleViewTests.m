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

#import "MDCRippleLayer.h"
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
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateNormal],
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateHighlighted],
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateSelected],
                        [selectionColor colorWithAlphaComponent:(CGFloat)0.08]);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MaterialStateSelected | MaterialStateHighlighted)],
      [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateDragged],
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MaterialStateDragged | MaterialStateHighlighted)],
      [UIColor colorWithWhite:0 alpha:(CGFloat)0.12]);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MaterialStateDragged | MaterialStateSelected)],
      [selectionColor colorWithAlphaComponent:(CGFloat)0.08]);
}

- (void)testSetRippleColorForStateAndFallbacksForCombinations {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];

  // When
  for (int i = 0; i <= MaterialStateSelected; i++) {
    [rippleView setRippleColor:nil forState:(NSInteger)i];
  }
  [rippleView setRippleColor:UIColor.blueColor forState:MaterialStateDragged];
  [rippleView setRippleColor:UIColor.greenColor forState:MaterialStateSelected];
  [rippleView setRippleColor:UIColor.redColor forState:MaterialStateNormal];

  // Then
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateDragged], UIColor.blueColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateSelected], UIColor.greenColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateNormal], UIColor.redColor);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MaterialStateDragged | MaterialStateHighlighted)],
      UIColor.blueColor);
  XCTAssertEqualObjects(
      [rippleView rippleColorForState:(MaterialStateSelected | MaterialStateHighlighted)],
      UIColor.greenColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateHighlighted],
                        UIColor.redColor);
}

- (void)testSetRippleColorForStateAndFallbacksForSingularStatesAndUIControlState {
  // Given
  MDCStatefulRippleView *rippleView = [[MDCStatefulRippleView alloc] init];
  UIColor *normalColor = UIColor.redColor;
  UIColor *selectedColor = UIColor.blueColor;
  UIColor *highlightedColor = UIColor.blueColor;

  // When
  [rippleView setRippleColor:normalColor forState:MaterialStateNormal];
  [rippleView setRippleColor:selectedColor forState:MaterialStateSelected];
  [rippleView setRippleColor:highlightedColor forState:MaterialStateHighlighted];

  // Then
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateNormal], normalColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateDragged], normalColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateError], normalColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:MaterialStateSelected], selectedColor);

  XCTAssertEqualObjects([rippleView rippleColorForState:(MaterialState)UIControlStateNormal],
                        normalColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:(MaterialState)UIControlStateSelected],
                        selectedColor);
  XCTAssertEqualObjects([rippleView rippleColorForState:(MaterialState)UIControlStateHighlighted],
                        highlightedColor);
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

@end
