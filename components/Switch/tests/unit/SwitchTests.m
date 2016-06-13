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

#import "MaterialSwitch.h"

@interface SwitchTests : XCTestCase

@end

@implementation SwitchTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in
  // the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in
  // the class.
  [super tearDown];
}

- (void)testSetOn {
  MDCSwitch *testSwitch = [[MDCSwitch alloc] initWithFrame:CGRectZero];
  testSwitch.on = YES;

  XCTAssertEqual(testSwitch.on, YES, @"MDCSwitch.on should be YES");
}

- (void)testSetOff {
  MDCSwitch *testSwitch = [[MDCSwitch alloc] initWithFrame:CGRectZero];
  testSwitch.on = NO;

  XCTAssertEqual(testSwitch.on, NO, @"MDCSwitch.on should be NO");
}

- (void)testConstantSize {
  MDCSwitch *testZeroSwitch = [[MDCSwitch alloc] initWithFrame:CGRectZero];
  MDCSwitch *testSmallSwitch = [[MDCSwitch alloc] initWithFrame:CGRectMake(0.0, 0.0, 4.0, 4.0)];
  MDCSwitch *testLargeSwitch = [[MDCSwitch alloc] initWithFrame:CGRectMake(0.0, 0.0, 900.0, 900.0)];

  XCTAssertEqual(testZeroSwitch.bounds.size.height, testSmallSwitch.bounds.size.height,
                 @"MDCSwitch height must be constant");
  XCTAssertEqual(testZeroSwitch.bounds.size.width, testSmallSwitch.bounds.size.width,
                 @"MDCSwitch width must be constant");

  XCTAssertEqual(testZeroSwitch.bounds.size.height, testLargeSwitch.bounds.size.height,
                 @"MDCSwitch height must be constant");
  XCTAssertEqual(testZeroSwitch.bounds.size.width, testLargeSwitch.bounds.size.width,
                 @"MDCSwitch width must be constant");
}

- (void)testRectZeroSize {
  MDCSwitch *testSwitch = [[MDCSwitch alloc] initWithFrame:CGRectZero];

  CGSize zeroSize = [testSwitch sizeThatFits:CGSizeZero];
  CGSize hugeSize = [testSwitch sizeThatFits:CGSizeMake(800.0, 800.0)];

  XCTAssertEqual(zeroSize.height, hugeSize.height, @"MDCSwitch height must be constant");
  XCTAssertEqual(zeroSize.width, hugeSize.width, @"MDCSwitch width must be constant");
}

- (void)testConstantFrameSize {
  MDCSwitch *testSwitch = [[MDCSwitch alloc] initWithFrame:CGRectZero];

  CGSize baseSize = [testSwitch sizeThatFits:CGSizeZero];

  CGRect currentFrame = testSwitch.frame;
  XCTAssertEqual(baseSize.height, currentFrame.size.height, @"MDCSwitch height must be constant");
  XCTAssertEqual(baseSize.width, currentFrame.size.width, @"MDCSwitch width must be constant");

  testSwitch.frame = CGRectMake(0.0, 0.0, 500.0, 500.0);
  currentFrame = testSwitch.frame;
  XCTAssertEqual(baseSize.height, currentFrame.size.height, @"MDCSwitch height must be constant");
  XCTAssertEqual(baseSize.width, currentFrame.size.width, @"MDCSwitch width must be constant");
}

- (void)testConstantBoundsSize {
  MDCSwitch *testSwitch = [[MDCSwitch alloc] initWithFrame:CGRectZero];

  CGSize baseSize = [testSwitch sizeThatFits:CGSizeZero];

  CGRect currentFrame = testSwitch.frame;
  XCTAssertEqual(baseSize.height, currentFrame.size.height, @"MDCSwitch height must be constant");
  XCTAssertEqual(baseSize.width, currentFrame.size.width, @"MDCSwitch width must be constant");

  testSwitch.bounds = CGRectMake(0.0, 0.0, 400.0, 400.0);
  currentFrame = testSwitch.frame;
  XCTAssertEqual(baseSize.height, currentFrame.size.height, @"MDCSwitch height must be constant");
  XCTAssertEqual(baseSize.width, currentFrame.size.width, @"MDCSwitch width must be constant");
}

@end
