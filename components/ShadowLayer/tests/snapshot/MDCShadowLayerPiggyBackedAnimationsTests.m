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

#import "MaterialShadowLayer.h"

@interface MDCShadowLayerPiggyBackedAnimationsTests : XCTestCase
@end

@implementation MDCShadowLayerPiggyBackedAnimationsTests

// A headless layer is a CALayer without a delegate (usually would be a UIView).
// A mounted layer is one that has been flushed to the render server (either via a runloop pump or
// via [CATransaction flush]).
- (void)testMountedHeadlessLayerShadowPathAnimationPiggyBacksImplicitBoundsAnimation {
  // Given
  UIWindow *window = [[UIWindow alloc] init];
  MDCShadowLayer *shadowLayer = [[MDCShadowLayer alloc] init];
  shadowLayer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectZero].CGPath;
  [window.layer addSublayer:shadowLayer];
  [window makeKeyAndVisible];
  [CATransaction flush];  // Mounts the layer

  // When
  // Note: headless layers animate using the CATransaction context rather than the UIKit context.
  [UIView animateWithDuration:0.1
                   animations:^{
                     [CATransaction begin];
                     [CATransaction setAnimationDuration:0.5];
                     shadowLayer.bounds = CGRectMake(0, 0, 100, 50);
                     shadowLayer.shadowPath =
                         [UIBezierPath bezierPathWithRect:shadowLayer.bounds].CGPath;
                     [CATransaction commit];
                   }];

  // Then
  CAAnimation *boundsAnimation = [shadowLayer animationForKey:@"bounds"];
  XCTAssertNotNil(boundsAnimation);
  CFTimeInterval boundsDuration = [shadowLayer animationForKey:@"bounds"].duration;

  for (CALayer *sublayer in shadowLayer.sublayers) {
    CAAnimation *animation = [sublayer animationForKey:@"shadowPath"];
    XCTAssertNotNil(animation);
    XCTAssertEqualWithAccuracy(animation.duration, boundsDuration, 0.001);
  }
}

@end
