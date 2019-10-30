// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

@interface ShadowLayerTestsView : UIView
@end

@implementation ShadowLayerTestsView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface ShadowLayerTests : XCTestCase
@end

@implementation ShadowLayerTests

- (void)testDefaultValues {
  // Given
  MDCShadowLayer *shadowLayer = [[MDCShadowLayer alloc] init];

  // Then
  XCTAssertEqualWithAccuracy(shadowLayer.elevation, 0, 0.0001);
  XCTAssertTrue(shadowLayer.isShadowMaskEnabled);
}

- (void)testShadowLayerBackedViewShadowPathAnimationPiggyBacksUIKitFrameAnimation {
  // Given
  UIView *someView = [[ShadowLayerTestsView alloc] init];

  // When
  [UIView animateWithDuration:0.1
                   animations:^{
                     [CATransaction begin];
                     [CATransaction setAnimationDuration:0.5];
                     someView.frame = CGRectMake(0, 0, 100, 50);
                     someView.layer.shadowPath =
                         [UIBezierPath bezierPathWithRect:someView.bounds].CGPath;
                     [CATransaction commit];
                   }];

  // Then
  XCTAssertNotNil([someView.layer animationForKey:@"position"]);
  XCTAssertNotNil([someView.layer animationForKey:@"bounds.origin"]);
  XCTAssertNotNil([someView.layer animationForKey:@"bounds.size"]);
  CFTimeInterval boundsDuration = [someView.layer animationForKey:@"bounds.origin"].duration;
  for (CALayer *sublayer in someView.layer.sublayers) {
    CAAnimation *animation = [sublayer animationForKey:@"shadowPath"];
    XCTAssertNotNil(animation);
    XCTAssertEqualWithAccuracy(animation.duration, boundsDuration, 0.001);
  }
}

- (void)testShadowLayerBackedViewShadowPathAnimationPiggyBacksUIKitBoundsAnimation {
  // Given
  UIView *someView = [[ShadowLayerTestsView alloc] init];

  // When
  [UIView animateWithDuration:0.1
                   animations:^{
                     [CATransaction begin];
                     [CATransaction setAnimationDuration:0.5];
                     someView.bounds = CGRectMake(0, 0, 100, 50);
                     someView.layer.shadowPath =
                         [UIBezierPath bezierPathWithRect:someView.bounds].CGPath;
                     [CATransaction commit];
                   }];

  // Then
  XCTAssertNotNil([someView.layer animationForKey:@"bounds.origin"]);
  XCTAssertNotNil([someView.layer animationForKey:@"bounds.size"]);
  CFTimeInterval boundsDuration = [someView.layer animationForKey:@"bounds.origin"].duration;
  for (CALayer *sublayer in someView.layer.sublayers) {
    CAAnimation *animation = [sublayer animationForKey:@"shadowPath"];
    XCTAssertNotNil(animation);
    XCTAssertEqualWithAccuracy(animation.duration, boundsDuration, 0.001);
  }
}

@end
