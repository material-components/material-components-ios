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

#import "MaterialProgressView.h"

@interface MDCProgressView (ProgressViewTests)

- (NSString *)defaultAccessibilityLabel;

@end

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

- (void)testCornerRadius {
  XCTAssertEqual(_progressView.cornerRadius, 0);
}

- (void)testDefaultMode {
  XCTAssertEqual(_progressView.mode, MDCProgressViewModeDeterminate);
}

- (void)testSetMode {
  _progressView.mode = MDCProgressViewModeIndeterminate;
  XCTAssertEqual(_progressView.mode, MDCProgressViewModeIndeterminate);
}

- (void)testDefaultProgressTintColors {
  XCTAssertEqual(_progressView.progressTintColors, nil);
}

- (void)testSetProgressTintColors {
  NSArray<UIColor *> *colors = @[ UIColor.blueColor, UIColor.greenColor ];
  _progressView.progressTintColors = colors;
  XCTAssertEqualObjects(_progressView.progressTintColors, colors);
}

- (void)testInitialProgress {
  XCTAssertEqual(_progressView.progress, 0);
}

- (void)testSetProgress {
  _progressView.progress = (float)0.1234;
  XCTAssertEqual(_progressView.progress, (float)0.1234);
}

- (void)testSetProgressAnimated {
  [_progressView setProgress:(float)0.777 animated:YES completion:nil];
  XCTAssertEqual(_progressView.progress, (float)0.777);

  [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
}

- (void)testIndeterminateProgressView {
  _progressView.mode = MDCProgressViewModeIndeterminate;
  [_progressView startAnimating];
  XCTAssertTrue(_progressView.isAnimating);
  [_progressView stopAnimating];
  XCTAssertFalse(_progressView.isAnimating);
}

- (void)testProgressClampedAt0 {
  _progressView.progress = -1;
  XCTAssertEqual(_progressView.progress, 0);
}

- (void)testProgressClampedAt1 {
  _progressView.progress = 2;
  XCTAssertEqual(_progressView.progress, 1);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCProgressView *passedProgressView = nil;
  _progressView.traitCollectionDidChangeBlock =
      ^(MDCProgressView *_Nonnull progressView,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedProgressView = progressView;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [_progressView traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedProgressView, _progressView);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

- (void)testAccessibilityLabelHasCorrectValueSet {
  // Given
  UIProgressView *uiProgressView = [[UIProgressView alloc] init];
  MDCProgressView *mdcProgressView = [[MDCProgressView alloc] init];
  NSString *expectedAccessibilityLabel =
      uiProgressView.accessibilityLabel ?: [mdcProgressView defaultAccessibilityLabel];

  // Then
  XCTAssertEqual(mdcProgressView.accessibilityLabel, expectedAccessibilityLabel);
}

- (void)testProgressTintColorIsNullable {
  // Given
  MDCProgressView *mdcProgressView = [[MDCProgressView alloc] init];

  // When
  mdcProgressView.progressTintColor = nil;

  // Then
  XCTAssertNil(mdcProgressView.progressTintColor);
}

- (void)testTrackTintColorIsNullable {
  // Given
  MDCProgressView *mdcProgressView = [[MDCProgressView alloc] init];

  // When
  mdcProgressView.trackTintColor = nil;

  // Then
  XCTAssertNil(mdcProgressView.trackTintColor);
}

@end
