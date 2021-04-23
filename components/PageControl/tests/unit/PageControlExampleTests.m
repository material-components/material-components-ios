// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialPageControl.h"

@interface PageControlExampleTests : XCTestCase

@end

@implementation PageControlExampleTests {
  MDCPageControl *_pageControl;
}

- (void)setUp {
  [super setUp];
  _pageControl = [[MDCPageControl alloc] initWithFrame:CGRectZero];
}

- (void)tearDown {
  _pageControl = nil;
  [super tearDown];
}

#pragma mark - Tests

- (void)testInitialNumberOfPages {
  XCTAssertEqual(_pageControl.numberOfPages, 0);
}

- (void)testInitialCurrentPage {
  XCTAssertEqual(_pageControl.currentPage, 0);
}

- (void)testSetCurrentPage {
  _pageControl.numberOfPages = 3;
  [_pageControl setCurrentPage:1 animated:YES];
  XCTAssertEqual(_pageControl.currentPage, 1);

  [_pageControl setCurrentPage:2 animated:NO];
  XCTAssertEqual(_pageControl.currentPage, 2);
}

- (void)testHidesForSinglePage {
  _pageControl.hidesForSinglePage = YES;
  _pageControl.numberOfPages = 3;
  [_pageControl layoutIfNeeded];
  XCTAssertEqual(_pageControl.hidden, NO);

  _pageControl.numberOfPages = 1;
  [_pageControl layoutIfNeeded];
  XCTAssertEqual(_pageControl.hidden, YES);

  _pageControl.hidesForSinglePage = NO;
  _pageControl.numberOfPages = 1;
  [_pageControl layoutIfNeeded];
  XCTAssertEqual(_pageControl.hidden, NO);
}

- (void)testSizeThatFits {
  // Tests that MDCPageControl and UIPageControl frames are equivalent when calling -sizeToFit.
  MDCPageControl *pageControl = [[MDCPageControl alloc] init];
  UIPageControl *nativePageControl = [[UIPageControl alloc] init];

  // Test both controls with 1 page.
  pageControl.numberOfPages = 1;
  [pageControl sizeToFit];
  nativePageControl.numberOfPages = 1;
  [nativePageControl sizeToFit];
  CGRect frame = CGRectIntegral(pageControl.frame);
  XCTAssertEqual(frame.size.height, 48.0);
  if (@available(iOS 14, *)) {
    XCTAssertEqual(frame.size.width, 7);
    XCTAssertEqual(nativePageControl.frame.size.width, 85);
  } else {
    XCTAssertEqual(frame.size.width, nativePageControl.frame.size.width);
  }

  // Test both controls with 4 pages.
  pageControl.numberOfPages = 4;
  [pageControl sizeToFit];
  nativePageControl.numberOfPages = 4;
  [nativePageControl sizeToFit];
  frame = CGRectIntegral(pageControl.frame);
  XCTAssertEqual(frame.size.height, 48.0);
  if (@available(iOS 14, *)) {
    XCTAssertEqual(frame.size.width, 55);
    XCTAssertEqual(nativePageControl.frame.size.width, 141);
  } else {
    XCTAssertEqual(frame.size.width, nativePageControl.frame.size.width);
  }

  // Test with different number of pages for each control.
  pageControl.numberOfPages = 4;
  [pageControl sizeToFit];
  nativePageControl.numberOfPages = 2;
  [nativePageControl sizeToFit];
  frame = CGRectIntegral(pageControl.frame);
  XCTAssertEqual(frame.size.height, 48.0);
  XCTAssertNotEqual(frame.size.width, nativePageControl.frame.size.width);
}

- (void)testIntrinsicContentSize {
  // Tests that MDCPageControl's intrinsicContentSize matches its size after `sizeToFit`.
  MDCPageControl *pageControl = [[MDCPageControl alloc] init];

  CGSize intrinsicSize = CGSizeZero;
  CGSize frameSize = CGSizeZero;

  // Test with one page.
  pageControl.numberOfPages = 1;
  [pageControl sizeToFit];

  intrinsicSize = pageControl.intrinsicContentSize;
  frameSize = pageControl.frame.size;
  XCTAssertEqual(frameSize.height, intrinsicSize.height);
  XCTAssertEqual(frameSize.width, intrinsicSize.width);

  // Test with multiple pages.
  pageControl.numberOfPages = 4;
  [pageControl sizeToFit];

  intrinsicSize = pageControl.intrinsicContentSize;
  frameSize = pageControl.frame.size;
  XCTAssertEqual(frameSize.height, intrinsicSize.height);
  XCTAssertEqual(frameSize.width, intrinsicSize.width);

  // Test it isn't dependent on sizeToFit being called. Call ordering matters here, relying on the
  // old frame still being set.
  pageControl.numberOfPages = 3;

  intrinsicSize = pageControl.intrinsicContentSize;
  frameSize = pageControl.frame.size;
  XCTAssertEqual(frameSize.height, intrinsicSize.height);  // Height shouldn't change.
  XCTAssertNotEqual(frameSize.width, intrinsicSize.width);

  [pageControl sizeToFit];
  frameSize = pageControl.frame.size;
  XCTAssertEqual(frameSize.height, intrinsicSize.height);
  XCTAssertEqual(frameSize.width, intrinsicSize.width);
}

- (void)testScrollOffsetOutOfBoundsOfNumberOfPages {
  // Given
  CGRect frame = CGRectMake(0, 0, 100, 100);
  MDCPageControl *pageControl = [[MDCPageControl alloc] init];
  pageControl.numberOfPages = 3;
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
  scrollView.delegate = pageControl;

  // When
  [scrollView setContentOffset:CGPointMake(frame.size.width * pageControl.numberOfPages, 0)
                      animated:YES];

  // Then
  XCTAssertEqual(pageControl.currentPage, pageControl.numberOfPages - 1);
}

- (void)testCurrentPageGetsUpdatedWhenOffsetIsChanged {
  // Given
  CGRect frame = CGRectMake(0, 0, 100, 100);
  MDCPageControl *pageControl = [[MDCPageControl alloc] init];
  pageControl.numberOfPages = 3;
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
  scrollView.delegate = pageControl;
  NSInteger page = 2;

  // When
  [scrollView setContentOffset:CGPointMake(frame.size.width * page, 0) animated:YES];

  // Then
  XCTAssertEqual(pageControl.currentPage, page);
}

- (void)testResetNumberOfPagesToZero {
  // Given
  MDCPageControl *pageControl = [[MDCPageControl alloc] init];
  pageControl.numberOfPages = 3;
  NSException *exception;

  // When
  @try {
    pageControl.numberOfPages = 0;
    pageControl.currentPage = 0;
  } @catch (NSException *e) {
    exception = e;
  }

  // Then
  XCTAssertNil(exception, @"PageControl crashed with exception: %@", exception);
}

- (void)testScrollViewDidScrollWithZeroPages {
  // Given
  MDCPageControl *pageControl = [[MDCPageControl alloc] init];
  pageControl.numberOfPages = 0;
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  NSException *exception;

  // When
  @try {
    [pageControl scrollViewDidScroll:scrollView];
  } @catch (NSException *e) {
    exception = e;
  }

  // Then
  XCTAssertNil(exception, @"PageControl crashed with exception: %@", exception);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCPageControl *passedPageControl = nil;
  _pageControl.traitCollectionDidChangeBlock = ^(
      MDCPageControl *_Nonnull pageControl, UITraitCollection *_Nullable previousTraitCollection) {
    passedTraitCollection = previousTraitCollection;
    passedPageControl = pageControl;
    [expectation fulfill];
  };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [_pageControl traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedPageControl, _pageControl);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

@end
