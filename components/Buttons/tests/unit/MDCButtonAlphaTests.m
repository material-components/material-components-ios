// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"

@interface MDCButtonAlphaTests : XCTestCase
@property(nonatomic, strong, nullable) MDCButton *button;
@end

@implementation MDCButtonAlphaTests

- (void)setUp {
  [super setUp];

  self.button = [[MDCButton alloc] init];
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)testAlphaRestoredWhenReenabled {
  // Given
  CGFloat alpha = (CGFloat)0.5;

  // When
  self.button.alpha = alpha;
  self.button.enabled = NO;
  self.button.enabled = YES;

  // Then
  XCTAssertEqualWithAccuracy(alpha, self.button.alpha, 0.0001);
}

- (void)testAlphaValueSetWhenDisabledDoesNotChangeWhenButtonReenabled {
  // Given
  CGFloat expectedAlpha = (CGFloat)0.8;
  self.button.alpha = (CGFloat)0.2;
  self.button.enabled = NO;
  self.button.alpha = expectedAlpha;

  // When
  self.button.enabled = YES;

  // Then
  XCTAssertEqualWithAccuracy(expectedAlpha, self.button.alpha, (CGFloat)0.0001);
}

- (void)testDisabledAlpha {
  // Given
  CGFloat alpha = (CGFloat)0.5;

  // When
  [self.button setDisabledAlpha:alpha];
  self.button.enabled = NO;

  // Then
  XCTAssertEqualWithAccuracy(alpha, self.button.alpha, (CGFloat)0.0001);
}

- (void)testSettingAlphaWhileDisabledDoesNotAlterDisabledAlpha {
  // Given
  CGFloat startAlpha = (CGFloat)0.1;
  CGFloat endAlpha = (CGFloat)0.2;
  CGFloat disabledAlpha = (CGFloat)0.3;
  self.button.alpha = startAlpha;
  self.button.disabledAlpha = disabledAlpha;

  // When
  self.button.enabled = NO;
  self.button.alpha = endAlpha;

  // Then
  XCTAssertEqualWithAccuracy(disabledAlpha, self.button.disabledAlpha, (CGFloat)0.0001);
}

@end
