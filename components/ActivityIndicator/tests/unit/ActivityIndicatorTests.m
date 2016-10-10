/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MaterialActivityIndicator.h"

static CGFloat randomNumber() {
  return arc4random_uniform(64) + 8;
}

@interface ActivityIndicatorTests : XCTestCase

@end

@implementation ActivityIndicatorTests

- (void)testSetRadiusMin {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  // When
  indicator.radius = 2.0f;

  // Then
  XCTAssertGreaterThanOrEqual(indicator.radius, 8.0f);
  XCTAssertLessThanOrEqual(indicator.radius, 72.0f);
}

- (void)testSetRadiusMax {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  // When
  indicator.radius = 80.0f;

  // Then
  XCTAssertGreaterThanOrEqual(indicator.radius, 8.0f);
  XCTAssertLessThanOrEqual(indicator.radius, 72.0f);
}

- (void)testSetRadius {
  // Given
  MDCActivityIndicator *indicator = [[MDCActivityIndicator alloc] init];

  // When
  CGFloat random = randomNumber();
  indicator.radius = random;

  // Then
  XCTAssertGreaterThanOrEqual(indicator.radius, 8.0f);
  XCTAssertLessThanOrEqual(indicator.radius, 72.0f);
  XCTAssertEqual(indicator.radius, random);
}

@end
