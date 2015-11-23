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

#import "MaterialScrollViewDelegateMultiplexer.h"

static NSString *const kScrollViewDidScroll = @"scrollViewDidScroll";

#pragma mark - Simple observer object

/** Simple object that conforms to UIScrollViewDelegate protocol. */
@interface ScrollObservingObject : UIView <UIScrollViewDelegate>
- (instancetype)initWithExpectation:(XCTestExpectation *)expectation;
@end

@implementation ScrollObservingObject {
  XCTestExpectation *_observerExpectation;
}

- (instancetype)initWithExpectation:(XCTestExpectation *)expectation {
  self = [self initWithFrame:CGRectZero];
  if (self) {
    _observerExpectation = expectation;
  }
  return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [_observerExpectation fulfill];
}

@end

@interface ScrollViewDelegateMultiplexerExampleTests : XCTestCase <UIScrollViewDelegate>
@end

@implementation ScrollViewDelegateMultiplexerExampleTests {
  UIScrollView *_scrollView;
  ScrollObservingObject *_observingObject;
  MDCScrollViewDelegateMultiplexer *_multiplexer;
  XCTestExpectation *_expectation;
  XCTestExpectation *_observerExpectation;
}

- (void)setUp {
  [super setUp];
  _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
  _scrollView.contentSize = CGSizeMake(200, 10);
}

- (void)tearDown {
  [super tearDown];
}

#pragma mark - Tests

- (void)testWithoutMultiplexer {
  _expectation = [self expectationWithDescription:kScrollViewDidScroll];

  _scrollView.delegate = self;

  // Instigate event.
  [_scrollView setContentOffset:CGPointMake(50, 0) animated:YES];

  [self waitForExpectationsWithTimeout:0 handler:^(NSError *error) {
    XCTAssertEqual(error, nil);
  }];
}

- (void)testMuliplexerSingleDelegate {
  _expectation = [self expectationWithDescription:kScrollViewDidScroll];

  // Create scrollView delegate multiplexer.
  _multiplexer = [[MDCScrollViewDelegateMultiplexer alloc] init];
  [_multiplexer addObservingDelegate:self];
  _scrollView.delegate = _multiplexer;

  // Instigate event.
  [_scrollView setContentOffset:CGPointMake(50, 0) animated:YES];

  [self waitForExpectationsWithTimeout:0 handler:^(NSError *error) {
    XCTAssertEqual(error, nil);
  }];
}

- (void)testMuliplexerMultipleDelegate {
  _expectation = [self expectationWithDescription:kScrollViewDidScroll];
  _observerExpectation = [self expectationWithDescription:kScrollViewDidScroll];

  // Create simple object
  _observingObject = [[ScrollObservingObject alloc] initWithExpectation:_observerExpectation];

  // Create scrollView delegate multiplexer.
  _multiplexer = [[MDCScrollViewDelegateMultiplexer alloc] init];
  [_multiplexer addObservingDelegate:self];
  [_multiplexer addObservingDelegate:_observingObject];
  _scrollView.delegate = _multiplexer;

  // Instigate event.
  [_scrollView setContentOffset:CGPointMake(50, 0) animated:YES];

  [self waitForExpectationsWithTimeout:0 handler:^(NSError *error) {
    XCTAssertEqual(error, nil);

    [self waitForExpectationsWithTimeout:0 handler:^(NSError *error2) {
      XCTAssertEqual(error2, nil);
    }];

  }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [_expectation fulfill];
}

@end
