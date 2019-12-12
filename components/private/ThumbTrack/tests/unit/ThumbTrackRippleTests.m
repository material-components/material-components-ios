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

#import "MaterialInk.h"
#import "MaterialRipple.h"
#import "MaterialThumbTrack.h"

@class MDCRippleLayer;

@interface MDCRippleView (Testing)
@property(nonatomic, strong) MDCRippleLayer *activeRippleLayer;
@end

@interface MDCThumbTrack (Testing)
@property(nonatomic, strong) MDCRippleView *rippleView;
@property(nonatomic, strong) MDCInkTouchController *touchController;
@end

/**
 This class confirms behavior of @c MDCThumbTrack when used with @c MDCRippleView.
 */
@interface ThumbTrackRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCThumbTrack *thumbTrack;

@end

@implementation ThumbTrackRippleTests

- (void)setUp {
  [super setUp];

  self.thumbTrack = [[MDCThumbTrack alloc] init];
}

- (void)tearDown {
  self.thumbTrack = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCThumbTrack without any customization.
 */
- (void)testRippleIsDisabledByDefaultAndItsColorAndStyleAreCorrect {
  // Then
  XCTAssertNotNil(self.thumbTrack.rippleView);
  XCTAssertEqualObjects(self.thumbTrack.rippleView.rippleColor,
                        [UIColor.blueColor colorWithAlphaComponent:(CGFloat)0.5]);
  XCTAssertEqual(self.thumbTrack.rippleView.rippleStyle, MDCRippleStyleUnbounded);
  XCTAssertFalse(self.thumbTrack.enableRippleBehavior);
  XCTAssertTrue(self.thumbTrack.shouldDisplayRipple);
  XCTAssertNil(self.thumbTrack.rippleView.superview);
}

/**
 Test to confirm that setting @c enableRippleBehavior adds the @c rippleView as a subview.
 */
- (void)testRippleIsEnabledAndItsColorAndStyleAndBoundsAreCorrectWhenRippleBehaviorIsEnabled {
  // When
  self.thumbTrack.enableRippleBehavior = YES;

  // Then
  XCTAssertNil(self.thumbTrack.touchController.defaultInkView.superview);
  XCTAssertEqualObjects(self.thumbTrack.rippleView.superview, self.thumbTrack.thumbView);
  CGRect thumbViewBounds = CGRectStandardize(self.thumbTrack.thumbView.bounds);
  CGRect rippleBounds = CGRectStandardize(self.thumbTrack.rippleView.bounds);
  XCTAssertTrue(CGRectEqualToRect(thumbViewBounds, rippleBounds), @"%@ is not equal to %@",
                NSStringFromCGRect(thumbViewBounds), NSStringFromCGRect(rippleBounds));
}

/**
 Test to confirm toggling @c enableRippleBehavior removes the @c rippleView as a subview.
 */
- (void)testSetEnableRippleBehaviorToYesThenNoRemovesRippleViewAsSubviewOfThumbView {
  // When
  self.thumbTrack.enableRippleBehavior = YES;
  self.thumbTrack.enableRippleBehavior = NO;

  // Then
  XCTAssertEqualObjects(self.thumbTrack.touchController.defaultInkView.superview,
                        self.thumbTrack.thumbView);
  XCTAssertNil(self.thumbTrack.rippleView.superview);
}

/**
 Test setting @c inkColor correctly sets the @c rippleColor on @c rippleView of the thumbtrack.
 */
- (void)testSetCustomInkColorUpdatesRippleView {
  // Given
  UIColor *color = UIColor.redColor;

  // When
  [self.thumbTrack setRippleColor:color];

  // Then
  XCTAssertEqualObjects(self.thumbTrack.rippleView.rippleColor, color);
}

- (void)testSettingShouldDisplayRippleToFalseDoesntCreateARippleOnTouch {
  // When
  self.thumbTrack.enableRippleBehavior = YES;
  self.thumbTrack.shouldDisplayRipple = NO;
  NSSet<UITouch *> *touches = [NSSet setWithArray:@[ [[UITouch alloc] init] ]];
  [self.thumbTrack touchesBegan:touches withEvent:nil];

  // Then
  XCTAssertNil(self.thumbTrack.rippleView.activeRippleLayer);
}

@end
