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

#import "../../../src/TabBarView/private/MDCTabBarViewIndicatorView.h"

#import <QuartzCore/QuartzCore.h>
#import <XCTest/XCTest.h>

/** Exposes properties necessary for unit testing. */
@interface MDCTabBarViewIndicatorView (Testing)
@property(nonatomic, strong) UIView *shapeView;
@end

@interface MDCTabBarViewIndicatorViewTests : XCTestCase

@end

@implementation MDCTabBarViewIndicatorViewTests

- (void)testDefaultPathAnimationShapeViewActionValues {
  // Given
  CFTimeInterval expectedDuration = 0.3;
  CAMediaTimingFunction *expectedFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

  // When
  MDCTabBarViewIndicatorView *indicatorView = [[MDCTabBarViewIndicatorView alloc] init];

  // Then
  UIView *shapeView = indicatorView.shapeView;
  id<CAAction> actionForPath = [shapeView actionForLayer:shapeView.layer forKey:@"path"];

  @try {
    CAAnimation *animationForPath = (CAAnimation *)actionForPath;
    XCTAssertEqualWithAccuracy(animationForPath.duration, expectedDuration, 0.0001);
    XCTAssertEqualObjects(animationForPath.timingFunction, expectedFunction);
  } @catch (NSException *exception) {
    XCTAssertTrue(NO, @"(%@) is not an animation: %@", actionForPath, exception);
  }
}

- (void)testPathAnimationPropertiesChangesShapeViewActionValues {
  // Given
  MDCTabBarViewIndicatorView *indicatorView = [[MDCTabBarViewIndicatorView alloc] init];
  CFTimeInterval expectedDuration = 1.23;
  CAMediaTimingFunction *expectedFunction =
      [CAMediaTimingFunction functionWithControlPoints:(float) 0.123:(float)0.456:(float)0.789:1];

  // When
  indicatorView.indicatorPathAnimationDuration = expectedDuration;
  indicatorView.indicatorPathTimingFunction = expectedFunction;

  // Then
  UIView *shapeView = indicatorView.shapeView;
  id<CAAction> actionForPath = [shapeView actionForLayer:shapeView.layer forKey:@"path"];

  @try {
    CAAnimation *animationForPath = (CAAnimation *)actionForPath;
    XCTAssertEqualWithAccuracy(animationForPath.duration, expectedDuration, 0.0001);
    XCTAssertEqualObjects(animationForPath.timingFunction, expectedFunction);
  } @catch (NSException *exception) {
    XCTAssertTrue(NO, @"(%@) is not an animation: %@", actionForPath, exception);
  }
}

@end
