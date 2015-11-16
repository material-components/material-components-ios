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

@interface SpritedAnimationViewTests : XCTestCase

@end

@implementation SpritedAnimationViewTests {
  XCTestExpectation *_expectation;
  MDCSpritedAnimationView *_animationView;
}

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testAnimationCompletion {

  // Sprited animation view.
  UIImage *spriteImage = [UIImage imageNamed:kSpriteChecked];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];

  // Create expectation.
  _expectation = [self expectationWithDescription:@"startAnimatingWithCompletion"];

  // Fulfill expectation after completion of animation.
  [_animationView startAnimatingWithCompletion:^{
    [_expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
    XCTAssertEqual(error, nil);
  }];
}

@end
