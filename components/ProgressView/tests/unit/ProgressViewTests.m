/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "MaterialProgressView.h"

@interface ProgressViewTests : XCTestCase

@end

@implementation ProgressViewTests {
  MDCProgressView *_progressView;
}

- (void)setUp {
  [super setUp];
  _progressView = [[MDCProgressView alloc] initWithFrame:CGRectZero];
}

- (void)tearDown {
  _progressView = nil;
  [super tearDown];
}

#pragma mark - Tests

- (void)testInitialProgress {
  XCTAssertEqual(_progressView.progress, 0);
}

- (void)testSetProgress {
  _progressView.progress = 0.1234f;
  XCTAssertEqual(_progressView.progress, 0.1234f);
}

- (void)testSetProgressAnimated {
  [_progressView setProgress:0.777f animated:YES completion:nil];
  XCTAssertEqual(_progressView.progress, 0.777f);
}

- (void)testProgressClampedAt0 {
  _progressView.progress = -1.f;
  XCTAssertEqual(_progressView.progress, 0.f);
}

- (void)testProgressClampedAt1 {
  _progressView.progress = 2.f;
  XCTAssertEqual(_progressView.progress, 1.f);
}

@end
