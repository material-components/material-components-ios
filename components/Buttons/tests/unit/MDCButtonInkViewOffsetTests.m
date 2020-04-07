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

#import "MaterialButtons.h"

#import <XCTest/XCTest.h>

#import "MaterialInk.h"
#import "MaterialRipple.h"

/** Exposes the private inkView and rippleView properties for testing */
@interface MDCButton (Testing)
@property(nonatomic, strong) MDCInkView *inkView;
@property(nonatomic, strong, readonly, nonnull) MDCStatefulRippleView *rippleView;
@end

/**
 Tests that ensure adjusting MDCButton's inkViewOffset adjusts the frames of its inkView and
 rippleView.
 */
@interface MDCButtonInkViewOffsetTests : XCTestCase
@end

@implementation MDCButtonInkViewOffsetTests

- (void)testDefaultInkViewOffsetIsCGSizeZero {
  MDCButton *button = [[MDCButton alloc] init];
  XCTAssertTrue(CGSizeEqualToSize(CGSizeZero, button.inkViewOffset), @"(%@) is not equal to (%@)",
                NSStringFromCGSize(CGSizeZero), NSStringFromCGSize(button.inkViewOffset));
}

- (void)testInkViewOffsetAdjustsInkViewFrame {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  CGSize inkOffset = CGSizeMake(1, 2);

  // When
  CGPoint initialInkViewOrigin = button.inkView.frame.origin;
  button.inkViewOffset = inkOffset;
  [button layoutIfNeeded];
  CGPoint updatedInkViewOrigin = button.inkView.frame.origin;

  // Then
  XCTAssertEqual(updatedInkViewOrigin.x, initialInkViewOrigin.x + inkOffset.width);
  XCTAssertEqual(updatedInkViewOrigin.y, initialInkViewOrigin.y + inkOffset.height);
}

- (void)testInkViewOffsetAdjustsRippleViewFrame {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  button.enableRippleBehavior = YES;
  CGSize inkOffset = CGSizeMake(-10, 4);

  // When
  CGPoint initialInkViewOrigin = button.rippleView.frame.origin;
  button.inkViewOffset = inkOffset;
  [button layoutIfNeeded];
  CGPoint updatedInkViewOrigin = button.rippleView.frame.origin;

  // Then
  XCTAssertEqual(updatedInkViewOrigin.x, initialInkViewOrigin.x + inkOffset.width);
  XCTAssertEqual(updatedInkViewOrigin.y, initialInkViewOrigin.y + inkOffset.height);
}

@end
