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

@interface ProgressViewProgressWithCurrentScreenScaleTests : XCTestCase
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) MDCProgressView *progressView;
@end

@implementation ProgressViewProgressWithCurrentScreenScaleTests

- (void)setUp {
  [super setUp];

  self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  self.progressView = [[MDCProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
  [self.window addSubview:self.progressView];
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
  CGFloat screenScale = self.progressView.window.screen.scale;

  if (MDCCGFloatEqual(screenScale, 1)) {
    // Note the surprising value of 98 here; this is due to the use of MDCCeil to calculate
    // screen-aligned pixel values for the progress view's frame.
    // TODO(https://github.com/material-components/material-components-ios/issues/9482): This should
    // be 97.
    XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.width, 98, 0.001);
  } else if (MDCCGFloatEqual(screenScale, 2)) {
    XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.width, 97.5, 0.001);
  } else if (MDCCGFloatEqual(screenScale, 3)) {
    XCTAssertEqualWithAccuracy(self.progressView.progressView.frame.size.width, 97.333, 0.001);
  } else {
    XCTFail(@"Untested screen size %@", @(self.progressView.window.screen.scale));
  }
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
