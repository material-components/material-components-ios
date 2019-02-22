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

#import "MDCFeatureHighlightView+Private.h"
#import "MaterialFeatureHighlight.h"

@interface MDCFeatureHighlightViewController (Testing)
@property(nonatomic, strong) MDCFeatureHighlightView *view;
@end

@interface FeatureHighlightAccessibilityTests : XCTestCase

@end

@implementation FeatureHighlightAccessibilityTests

- (void)testAccessibilityHintDefaultAfterLoadingView {
  // Given
  UIView *view = [[UIView alloc] init];
  UIView *view2 = [[UIView alloc] init];
  MDCFeatureHighlightViewController *controller =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:view
                                                             andShowView:view2
                                                              completion:nil];

  // When (cause the view to load)
  (void)controller.view;

  // Then
  // TODO(https://github.com/material-components/material-components-ios/issues/3644 ):
  // Switch these to XCTAssertNil (or refactor tests) once the default is removed.
  XCTAssertNotNil(controller.accessibilityHint);
  XCTAssertNotNil(controller.view.accessibilityHint);
}

- (void)testSetAccessibilityHint {
  // Given
  NSString *accessibilityHint = @"A great blue ox.";
  UIView *view = [[UIView alloc] init];
  UIView *view2 = [[UIView alloc] init];
  MDCFeatureHighlightViewController *controller =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:view
                                                             andShowView:view2
                                                              completion:nil];
  controller.accessibilityHint = accessibilityHint;

  // Then
  XCTAssertEqualObjects(controller.view.accessibilityHint, accessibilityHint);
}

- (void)testSetAccessibilityHintNil {
  // Given
  UIView *view = [[UIView alloc] init];
  UIView *view2 = [[UIView alloc] init];
  MDCFeatureHighlightViewController *controller =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:view
                                                             andShowView:view2
                                                              completion:nil];
  controller.accessibilityHint = nil;

  // Then
  XCTAssertNil(controller.accessibilityHint);
  XCTAssertNil(controller.view.accessibilityHint);
}

@end
