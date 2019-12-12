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

#import "MaterialRipple.h"

/**
 These tests demonstrate how a ripple view added as a subview can end up with an incorrect layer
 mask if the ripple view's frame does not match the bounds of the parent view and the parent view's
 layer has a shadowPath. All of the tests intentionally pass, with the final test demonstrating the
 incorrect behavior.
 */
@interface MDCRippleViewUsesSuperviewShadowLayerAsMaskTests : XCTestCase
@end

@implementation MDCRippleViewUsesSuperviewShadowLayerAsMaskTests

- (void)testDefaultInitializationHasNoLayerMask {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];

  // Then
  XCTAssertEqual(rippleView.rippleStyle, MDCRippleStyleBounded);
  XCTAssertNil(rippleView.layer.mask);
}

- (void)testHasNoLayerMaskWhenParentlessAndRippleStyleSetToBounded {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];

  // When
  rippleView.rippleStyle = MDCRippleStyleBounded;

  // Then
  XCTAssertNil(rippleView.layer.mask);
}

- (void)testInheritsParentShadowPathWhenRippleStyleSetToBounded {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  UIView *parentView = [[UIView alloc] init];
  [parentView addSubview:rippleView];

  // When
  parentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:parentView.bounds].CGPath;
  rippleView.rippleStyle = MDCRippleStyleBounded;

  // Then
  XCTAssertNotNil(rippleView.layer.mask);
  if (![rippleView.layer.mask isKindOfClass:[CAShapeLayer class]]) {
    XCTFail(@"Layer mask was expected to be a CAShapeLayer, but it was a %@ instead.",
            NSStringFromClass([rippleView.layer.mask class]));
  }
  CAShapeLayer *maskShapeLayer = (CAShapeLayer *)rippleView.layer.mask;
  XCTAssertTrue(CGPathEqualToPath(maskShapeLayer.path, parentView.layer.shadowPath));
}

- (void)testDoesNotInheritParentShadowPathWhenRippleStyleSetToUnbounded {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  UIView *parentView = [[UIView alloc] init];
  [parentView addSubview:rippleView];

  // When
  parentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:parentView.bounds].CGPath;
  rippleView.rippleStyle = MDCRippleStyleUnbounded;

  // Then
  XCTAssertNil(rippleView.layer.mask);
}

- (void)
    testIncorrectlyInheritsParentShadowPathWhenRippleStyleSetToBoundedEvenWhenFrameDoesNotEqualBounds {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  UIView *parentView = [[UIView alloc] init];
  [parentView addSubview:rippleView];
  parentView.frame = CGRectMake(0, 0, 100, 50);
  rippleView.frame = CGRectMake(10, 10, 30, 30);

  // When
  parentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:parentView.bounds].CGPath;
  rippleView.rippleStyle = MDCRippleStyleBounded;

  // Then
  XCTAssertNotNil(rippleView.layer.mask);
  if (![rippleView.layer.mask isKindOfClass:[CAShapeLayer class]]) {
    XCTFail(@"Layer mask was expected to be a CAShapeLayer, but it was a %@ instead.",
            NSStringFromClass([rippleView.layer.mask class]));
  }
  CAShapeLayer *maskShapeLayer = (CAShapeLayer *)rippleView.layer.mask;

  // Note that we would not expect these two paths to be equivalent at this point because the
  // ripple view's frame is smaller than the parent's bounds. The fact that this test passes
  // demonstrates that the ripple's mask is now incorrectly too large for its contents.
  XCTAssertTrue(CGPathEqualToPath(maskShapeLayer.path, parentView.layer.shadowPath));
}

- (void)
    testDoesNotInheritParentShadowPathWhenRippleStyleSetToBoundedWhenUsesSuperviewShadowLayerAsMaskDisabled {
  // Given
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  UIView *parentView = [[UIView alloc] init];
  [parentView addSubview:rippleView];
  parentView.frame = CGRectMake(0, 0, 100, 50);
  rippleView.frame = CGRectMake(10, 10, 30, 30);

  // When
  rippleView.usesSuperviewShadowLayerAsMask = NO;  // Disable the incorrect behavior.
  parentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:parentView.bounds].CGPath;
  rippleView.rippleStyle = MDCRippleStyleBounded;

  // Then
  XCTAssertNil(rippleView.layer.mask);
}

@end
