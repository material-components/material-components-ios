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
  [controller loadViewIfNeeded];

  // Then
  XCTAssertNil(controller.accessibilityHint);
  XCTAssertNil(controller.view.accessibilityHint);
}

- (void)testAccessibilityDismissElementAfterLoadingView {
  // Given
  UIView *view = [[UIView alloc] init];
  UIView *view2 = [[UIView alloc] init];
  MDCFeatureHighlightViewController *controller =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:view
                                                             andShowView:view2
                                                              completion:nil];

  // When (cause the view to load)
  [controller loadViewIfNeeded];

  // Then
  id dismissElement = controller.view.accessibilityElements.lastObject;
  if (![dismissElement isKindOfClass:[UIView class]]) {
    XCTFail(@"There must be at least one accessibility element and the last must be a UIView.");
    return;
  }
  UIView *dismissView = (UIView *)dismissElement;
  XCTAssertTrue(dismissView.isAccessibilityElement);
  XCTAssertEqualObjects(dismissView.accessibilityLabel, @"Dismiss");
  XCTAssertNil(dismissView.accessibilityHint);
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
  id dismissElement = controller.view.accessibilityElements.lastObject;
  if (![dismissElement isKindOfClass:[UIView class]]) {
    XCTFail(@"There must be at least one accessibility element and the last must be a UIView.");
    return;
  }
  UIView *dismissView = (UIView *)dismissElement;
  XCTAssertEqualObjects(dismissView.accessibilityHint, accessibilityHint);
}

@end
