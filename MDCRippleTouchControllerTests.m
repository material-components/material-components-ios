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

//@interface FakeMDCRippleViewAnimationDelegate : NSObject <MDCRippleViewDelegate>
//@property(nonatomic, strong) MDCRippleView *rippleView;
//@property(nonatomic, assign) BOOL rippleTouchDownDidBegin;
//@property(nonatomic, assign) BOOL rippleTouchDownDidEnd;
//@property(nonatomic, assign) BOOL rippleTouchUpDidBegin;
//@property(nonatomic, assign) BOOL rippleTouchUpDidEnd;
//
//@end

#pragma mark - Tests

@interface MDCRippleTouchControllerTests : XCTestCase

@end

@implementation MDCRippleTouchControllerTests

- (void)testInit {
  // Given
  MDCRippleTouchController *touchController = [[MDCRippleTouchController alloc] init];

  // Then
  XCTAssertNil(touchController.view);
  XCTAssertNotNil(touchController.rippleView);
  XCTAssertTrue(touchController.shouldProcessRippleWithScrollViewGestures);
  XCTAssertNotNil(touchController.gestureRecognizer);
}

- (void)testInitWithView {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController =
      [[MDCRippleTouchController alloc] initWithView:parentView];

  // Then
  XCTAssertEqualObjects(parentView, touchController.view);
  XCTAssertNotNil(touchController.rippleView);
  XCTAssertEqualObjects(touchController.rippleView.superview, parentView);
  XCTAssertTrue(touchController.shouldProcessRippleWithScrollViewGestures);
  XCTAssertNotNil(touchController.gestureRecognizer);
  XCTAssertTrue(CGRectEqualToRect(touchController.rippleView.frame, parentView.bounds));
}

- (void)testAddRippleToView {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController = [[MDCRippleTouchController alloc] init];

  // When
  [touchController addRippleToView:parentView];

  // Then
  XCTAssertEqualObjects(parentView, touchController.view);
  XCTAssertNotNil(touchController.rippleView);
  XCTAssertEqualObjects(touchController.rippleView.superview, parentView);
  XCTAssertTrue(touchController.shouldProcessRippleWithScrollViewGestures);
  XCTAssertNotNil(touchController.gestureRecognizer);
  XCTAssertTrue(CGRectEqualToRect(touchController.rippleView.frame, parentView.bounds));
}

@end
