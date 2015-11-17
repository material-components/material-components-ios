/*
 Copyright 2015-present Google Inc. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>

#import "MaterialSpritedAnimationView.h"

static NSString *const kSpriteChecked = @"mdc_sprite_check__hide";
static NSString *const kExpectationDescription = @"animatingWithCompletion";

@interface SpritedAnimationViewTests : XCTestCase

@end

@implementation SpritedAnimationViewTests

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testAnimationCompletion {

  // Sprited animation view.
  UIImage *spriteImage = [UIImage imageNamed:kSpriteChecked];
  MDCSpritedAnimationView *animationView =
      [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];

  // Create expectation.
  XCTestExpectation *expectation = [self expectationWithDescription:kExpectationDescription];

  // Fulfill expectation after completion of animation.
  [animationView startAnimatingWithCompletion:^{
    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
    XCTAssertEqual(error, nil);
  }];
}

- (void)testAnimationPerformance {
  NSArray *metrics = [[self class] defaultPerformanceMetrics];
  [self measureMetrics:metrics automaticallyStartMeasuring:NO forBlock:^{
    [self startMeasuring];

    // Sprited animation view.
    UIImage *spriteImage = [UIImage imageNamed:kSpriteChecked];
    MDCSpritedAnimationView *animationView =
        [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];

    // Create expectation.
    XCTestExpectation *expectation = [self expectationWithDescription:kExpectationDescription];

    // Fulfill expectation after completion of animation.
    [animationView startAnimatingWithCompletion:^{
      [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
      [self stopMeasuring];
    }];
  }];
}

- (void)testImageViewAnimationPerformance {
  NSArray *metrics = [[self class] defaultPerformanceMetrics];
  [self measureMetrics:metrics automaticallyStartMeasuring:NO forBlock:^{

    // Array of images.
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= 21; i++) {
      [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
    }

    [self startMeasuring];

    // Create UIImageView with array of images.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    imageView.animationDuration = images.count / 30;
    imageView.animationRepeatCount = 1;

    imageView.animationImages = images;

    // Create expectation.
    XCTestExpectation *expectation = [self expectationWithDescription:kExpectationDescription];

    // Fulfill expectation after completion of animation transaction.
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
      [expectation fulfill];
    }];
    [imageView startAnimating];
    [CATransaction commit];

    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
      [self stopMeasuring];
    }];
  }];
}

@end
