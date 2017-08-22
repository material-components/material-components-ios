/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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
  XCTAssertTrue(CGRectEqualToRect(CGRectIntegral(pageControl.frame), nativePageControl.frame));

  // Test both controls with 4 pages.
  pageControl.numberOfPages = 4;
  [pageControl sizeToFit];
  nativePageControl.numberOfPages = 4;
  [nativePageControl sizeToFit];
  XCTAssertTrue(CGRectEqualToRect(CGRectIntegral(pageControl.frame), nativePageControl.frame));

  // Test with different number of pages for each control.
  pageControl.numberOfPages = 4;
  [pageControl sizeToFit];
  nativePageControl.numberOfPages = 2;
  [nativePageControl sizeToFit];
  XCTAssertFalse(CGRectEqualToRect(CGRectIntegral(pageControl.frame), nativePageControl.frame));
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

@end
