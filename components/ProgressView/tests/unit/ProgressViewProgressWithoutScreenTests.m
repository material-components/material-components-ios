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

#import "MaterialMath.h"
#import "MaterialProgressView.h"

@interface MDCProgressView ()
@property(nonatomic, strong) UIView *progressView;
@end

@interface ProgressViewProgressWithoutScreenTests : XCTestCase
@property(nonatomic, strong) MDCProgressView *progressView;
@end

@implementation ProgressViewProgressWithoutScreenTests

- (void)setUp {
  [super setUp];

  self.progressView = [[MDCProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
}

- (void)tearDown {
  self.progressView = nil;

  [super tearDown];
}

- (void)testZero {
  // When
  self.progressView.progress = (float)0.00;
  [self.progressView layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.x, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.y, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.width, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.height, 10, 0.001);
}

- (void)test50 {
  // When
  self.progressView.progress = (float)0.50;
  [self.progressView layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.x, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.y, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.width, 50, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.height, 10, 0.001);
}

- (void)test65 {
  // When
  self.progressView.progress = (float)0.65;
  [self.progressView layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.x, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.y, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.width, 65, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.height, 10, 0.001);
}

- (void)test97 {
  // When
  self.progressView.progress = (float)0.97;
  [self.progressView layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.x, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.y, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.width, 97, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.height, 10, 0.001);
}

- (void)test100 {
  // When
  self.progressView.progress = (float)1;
  [self.progressView layoutIfNeeded];

  // Then
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.x, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.origin.y, 0, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.width, 100, 0.001);
  XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.height, 10, 0.001);
}

@end
