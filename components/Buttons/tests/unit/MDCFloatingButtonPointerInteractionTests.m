// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 Tests that validate collapsing and expanding MDCFloatingButton does not change
 pointerInteractionEnabled. This behavior is being tested because MDCFloatingButton temporarily sets
 pointerInteractionEnabled to NO when changing between collapsed and expanded states to address an
 issue where the iPad pointer would remain floating-button-shaped after the button it was hovering
 over collapsed.
 */
@interface MDCFloatingButtonPointerInteractionTests : XCTestCase
@end

@implementation MDCFloatingButtonPointerInteractionTests

- (void)testPointerInteractionIsDisabledByDefault {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    // Given
    MDCFloatingButton *button = [[MDCFloatingButton alloc] init];

    // Then
    XCTAssertFalse(button.pointerInteractionEnabled);
  }
#endif
}

- (void)testPointerInteractionRemainsEnabledAfterCollapse {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    // Given
    MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
    button.pointerInteractionEnabled = YES;

    // When
    [button collapse:NO completion:nil];

    // Then
    XCTAssertTrue(button.pointerInteractionEnabled);
  }
#endif
}

- (void)testPointerInteractionRemainsDisabledAfterCollapse {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    // Given
    MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
    button.pointerInteractionEnabled = NO;

    // When
    [button collapse:NO completion:nil];

    // Then
    XCTAssertFalse(button.pointerInteractionEnabled);
  }
#endif
}

- (void)testPointerInteractionRemainsEnabledAfterExpand {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    // Given
    MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
    [button collapse:NO completion:nil];
    button.pointerInteractionEnabled = YES;

    // When
    [button expand:NO completion:nil];

    // Then
    XCTAssertTrue(button.pointerInteractionEnabled);
  }
#endif
}

- (void)testPointerInteractionRemainsDisabledAfterExpand {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    // Given
    MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
    [button collapse:NO completion:nil];
    button.pointerInteractionEnabled = NO;

    // When
    [button expand:NO completion:nil];

    // Then
    XCTAssertFalse(button.isPointerInteractionEnabled);
  }
#endif
}

@end
