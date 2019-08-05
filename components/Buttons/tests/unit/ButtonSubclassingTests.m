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

#import "../../src/private/MDCButton+Subclassing.h"
#import "MaterialButtons.h"
#import "MaterialShadowElevations.h"
#import "MaterialTypography.h"

static const UIEdgeInsets ButtonTestContentEdgeInsets = {1, 2, 3, 4};
static const CGFloat ButtonTestCornerRadius = (CGFloat)1.234;

@interface ButtonSubclass : MDCButton
@end

@implementation ButtonSubclass

- (UIEdgeInsets)defaultContentEdgeInsets {
  return ButtonTestContentEdgeInsets;
}

@end

@interface ButtonSubclassingTests : XCTestCase
@end

@implementation ButtonSubclassingTests

- (void)testSubclassContentEdgeInsets {
  // Given
  MDCButton *button = [[ButtonSubclass alloc] init];

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(ButtonTestContentEdgeInsets, button.contentEdgeInsets));
}

- (void)testAssignedContentEdgeInsets {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  button.contentEdgeInsets = ButtonTestContentEdgeInsets;

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(ButtonTestContentEdgeInsets, button.contentEdgeInsets));
}

- (void)testAssignedCornerRadius {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  button.layer.cornerRadius = ButtonTestCornerRadius;
  [button sizeToFit];
  [button layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(ButtonTestCornerRadius, button.layer.cornerRadius, 0.0001);
}

@end
