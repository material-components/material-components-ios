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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

#import "MDCRippleTouchController.h"
#import "MDCRippleTouchControllerDelegate.h"
#import "MDCRippleView.h"

@interface FakeMDCRippleViewAtTouchLocationDelegate : NSObject <MDCRippleTouchControllerDelegate>
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
@property(nonatomic, assign) BOOL rippleViewAtTouchLocationCalled;

@end

@interface FakeMDCRippleViewAtTouchLocationGestureRecognizer : UILongPressGestureRecognizer
@end

@implementation FakeMDCRippleViewAtTouchLocationGestureRecognizer

- (CGPoint)locationInView:(nullable UIView *)view {
  return view.center;
}

@end

@implementation FakeMDCRippleViewAtTouchLocationDelegate

- (MDCRippleView *)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
               rippleViewAtTouchLocation:(CGPoint)location {
  _rippleViewAtTouchLocationCalled = YES;
  MDCRippleView *rippleView = [[MDCRippleView alloc] init];
  rippleView.tag = 777;
  return rippleView;
}

@end

@interface MDCRippleTouchController (UnitTests)
- (void)handleRippleGesture:(UILongPressGestureRecognizer *)recognizer;
@end

/** Unit tests for MDCRippleTouchController. */
@interface MDCRippleViewAtTouchLocationDelegateTests : XCTestCase

@end

@implementation MDCRippleViewAtTouchLocationDelegateTests

- (void)testWhenRippleViewAtTouchLocationExistsThenRippleIsntAdded {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController = [[MDCRippleTouchController alloc] init];
  FakeMDCRippleViewAtTouchLocationDelegate *delegate =
      [[FakeMDCRippleViewAtTouchLocationDelegate alloc] init];
  touchController.delegate = delegate;
  delegate.rippleTouchController = touchController;

  // When
  [touchController addRippleToView:parentView];

  // Then
  XCTAssertEqual(parentView.subviews.count, 0);
}

- (void)testCallsRippleViewAtTouchLocationDelegateMethodWhenGestureBegins {
  // Given
  UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  MDCRippleTouchController *touchController = [[MDCRippleTouchController alloc] init];
  FakeMDCRippleViewAtTouchLocationDelegate *delegate =
      [[FakeMDCRippleViewAtTouchLocationDelegate alloc] init];
  touchController.delegate = delegate;
  delegate.rippleTouchController = touchController;

  // When
  [parentView addSubview:[[UIView alloc] init]];
  [touchController addRippleToView:parentView];
  FakeMDCRippleViewAtTouchLocationGestureRecognizer *gestureRecognizer =
      [[FakeMDCRippleViewAtTouchLocationGestureRecognizer alloc]
          initWithTarget:touchController
                  action:@selector(handleRippleGesture:)];
  gestureRecognizer.delegate = touchController;
  gestureRecognizer.minimumPressDuration = 0;
  gestureRecognizer.cancelsTouchesInView = NO;
  gestureRecognizer.delaysTouchesEnded = NO;
  [parentView addGestureRecognizer:gestureRecognizer];
  gestureRecognizer.state = UIGestureRecognizerStateBegan;
  [touchController handleRippleGesture:gestureRecognizer];

  // Then
  XCTAssertTrue(delegate.rippleViewAtTouchLocationCalled);
  XCTAssertEqual(touchController.rippleView.tag, 777);
}

@end
