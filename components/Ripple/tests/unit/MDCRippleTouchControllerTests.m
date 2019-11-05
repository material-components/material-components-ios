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

#import <UIKit/UIGestureRecognizerSubclass.h>

#import "MaterialRipple.h"

@interface FakeMDCRippleTouchControllerDelegate : NSObject <MDCRippleTouchControllerDelegate>
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
@property(nonatomic, assign) BOOL insertRippleViewCalled;
@property(nonatomic, assign) BOOL didProcessRippleViewCalled;
@property(nonatomic, assign) BOOL shouldProcessRippleTouchesAtTouchLocation;

@end

@interface FakeGestureRecognizer : UILongPressGestureRecognizer
@end

@implementation FakeGestureRecognizer

- (CGPoint)locationInView:(nullable UIView *)view {
  return view.center;
}

@end

@implementation FakeMDCRippleTouchControllerDelegate

- (void)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
             insertRippleView:(MDCRippleView *)rippleView
                     intoView:(UIView *)view {
  _insertRippleViewCalled = YES;
  [view insertSubview:rippleView atIndex:0];
}

- (void)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
         didProcessRippleView:(MDCRippleView *)rippleView
              atTouchLocation:(CGPoint)location {
  _didProcessRippleViewCalled = YES;
}

- (BOOL)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
    shouldProcessRippleTouchesAtTouchLocation:(CGPoint)location {
  return _shouldProcessRippleTouchesAtTouchLocation;
}

@end

@interface MDCRippleTouchController (UnitTests)
- (void)handleRippleGesture:(UILongPressGestureRecognizer *)recognizer;
@end

/** Unit tests for MDCRippleTouchController. */
@interface MDCRippleTouchControllerTests : XCTestCase

@end

@implementation MDCRippleTouchControllerTests

- (void)testInit {
  // When
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
  XCTAssertTrue(CGRectEqualToRect(touchController.rippleView.frame, parentView.bounds),
                @"(%@) is not equal to (%@)", NSStringFromCGRect(touchController.rippleView.frame),
                NSStringFromCGRect(parentView.bounds));
}

- (void)testInitWithViewDeferred {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController =
      [[MDCRippleTouchController alloc] initWithView:parentView deferred:YES];

  // Then
  XCTAssertEqualObjects(parentView, touchController.view);
  XCTAssertNotNil(touchController.rippleView);
  XCTAssertNil(touchController.rippleView.superview);
  XCTAssertNotNil(touchController.gestureRecognizer);
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
  XCTAssertTrue(CGRectEqualToRect(touchController.rippleView.frame, parentView.bounds),
                @"(%@) is not equal to (%@)", NSStringFromCGRect(touchController.rippleView.frame),
                NSStringFromCGRect(parentView.bounds));
}

- (void)testDeferredAddingOfRippleView {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController =
      [[MDCRippleTouchController alloc] initWithView:parentView deferred:YES];

  // Given
  touchController.gestureRecognizer.state = UIGestureRecognizerStateBegan;
  [touchController handleRippleGesture:touchController.gestureRecognizer];

  // Then
  XCTAssertEqualObjects(touchController.rippleView.superview, parentView);
  XCTAssertTrue(touchController.shouldProcessRippleWithScrollViewGestures);
  XCTAssertNotNil(touchController.gestureRecognizer);
  XCTAssertTrue(CGRectEqualToRect(touchController.rippleView.frame, parentView.bounds),
                @"(%@) is not equal to (%@)", NSStringFromCGRect(touchController.rippleView.frame),
                NSStringFromCGRect(parentView.bounds));
}

- (void)testCallsInsertRippleViewDelegateMethodWhenAddedToView {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController = [[MDCRippleTouchController alloc] init];
  FakeMDCRippleTouchControllerDelegate *delegate =
      [[FakeMDCRippleTouchControllerDelegate alloc] init];
  touchController.delegate = delegate;
  delegate.rippleTouchController = touchController;

  // When
  [parentView addSubview:[[UIView alloc] init]];
  [touchController addRippleToView:parentView];

  // Then
  XCTAssertEqualObjects(parentView.subviews[0], touchController.rippleView);
  XCTAssertTrue(delegate.insertRippleViewCalled);
}

- (void)testCallsDidProcessRippleViewDelegateMethod {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController = [[MDCRippleTouchController alloc] init];
  FakeMDCRippleTouchControllerDelegate *delegate =
      [[FakeMDCRippleTouchControllerDelegate alloc] init];
  touchController.delegate = delegate;
  delegate.rippleTouchController = touchController;
  delegate.shouldProcessRippleTouchesAtTouchLocation = YES;

  // When
  [parentView addSubview:[[UIView alloc] init]];
  [touchController addRippleToView:parentView];
  FakeGestureRecognizer *gestureRecognizer = [[FakeGestureRecognizer alloc] initWithTarget:nil
                                                                                    action:nil];
  gestureRecognizer.state = UIGestureRecognizerStateBegan;
  [touchController handleRippleGesture:gestureRecognizer];

  // Then
  XCTAssertTrue(delegate.didProcessRippleViewCalled);
}

- (void)testCallsShouldProcessRippleViewDelegateMethodWhenProcessRippleIsDisabled {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController = [[MDCRippleTouchController alloc] init];
  FakeMDCRippleTouchControllerDelegate *delegate =
      [[FakeMDCRippleTouchControllerDelegate alloc] init];
  touchController.delegate = delegate;
  delegate.rippleTouchController = touchController;
  delegate.shouldProcessRippleTouchesAtTouchLocation = NO;

  // When
  [parentView addSubview:[[UIView alloc] init]];
  [touchController addRippleToView:parentView];
  FakeGestureRecognizer *gestureRecognizer =
      [[FakeGestureRecognizer alloc] initWithTarget:touchController
                                             action:@selector(handleRippleGesture:)];
  gestureRecognizer.delegate = touchController;
  gestureRecognizer.minimumPressDuration = 0;
  gestureRecognizer.cancelsTouchesInView = NO;
  gestureRecognizer.delaysTouchesEnded = NO;
  [parentView addGestureRecognizer:gestureRecognizer];
  gestureRecognizer.state = UIGestureRecognizerStateBegan;
  [touchController handleRippleGesture:gestureRecognizer];

  // Then
  XCTAssertFalse(delegate.didProcessRippleViewCalled);
}

@end
