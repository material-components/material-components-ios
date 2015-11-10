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

#import "MaterialPageControl.h"

@interface PageControlExampleTests : XCTestCase <UIScrollViewDelegate>

@end

@implementation PageControlExampleTests {
  MDCPageControl *_pageControl;
//  UIScrollView *_scrollView;
//  XCTestExpectation *_expectation;
//  XCTestExpectation *_observerExpectation;
}

- (void)setUp {
  [super setUp];
//  _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
//  _scrollView.contentSize = CGSizeMake(200, 10);
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

@end
