// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "../../src/private/MDCBottomDrawerContainerViewController.h"

@interface MDCBottomDrawerContainerViewController (ScrollViewTests)

@property(nonatomic) BOOL scrollViewObserved;
@property(nonatomic, readonly) UIScrollView *scrollView;
@property(nonatomic, readwrite) CGFloat contentHeightSurplus;
@property(nonatomic) BOOL contentScrollsToReveal;

@end

@interface MDCNavigationDrawerScrollViewTests : XCTestCase
@property(nonatomic, strong, nullable) UIScrollView *fakeScrollView;
@property(nonatomic, strong, nullable) MDCBottomDrawerContainerViewController *fakeBottomDrawer;
@end

@implementation MDCNavigationDrawerScrollViewTests

- (void)setUp {
  [super setUp];

  UIViewController *fakeViewController = [[UIViewController alloc] init];
  fakeViewController.view.frame = CGRectMake(0, 0, 200, 500);

  _fakeScrollView = [[UIScrollView alloc] init];
  _fakeBottomDrawer = [[MDCBottomDrawerContainerViewController alloc]
      initWithOriginalPresentingViewController:fakeViewController
                            trackingScrollView:_fakeScrollView];
}

- (void)tearDown {
  self.fakeScrollView = nil;
  self.fakeBottomDrawer = nil;

  [super tearDown];
}

- (void)testScrollViewNotNil {
  // Then
  XCTAssertNotNil(self.fakeBottomDrawer.scrollView);
}

- (void)testScrollViewBeingObserved {
  // When
  [self.fakeBottomDrawer viewWillAppear:YES];

  // Then
  XCTAssertTrue(self.fakeBottomDrawer.scrollViewObserved);
}

- (void)testScrollViewNotBeingObserved {
  // When
  [self.fakeBottomDrawer viewWillAppear:YES];
  [self.fakeBottomDrawer viewDidDisappear:YES];

  // Then
  XCTAssertFalse(self.fakeBottomDrawer.scrollViewObserved);
}

- (void)testContentDoesScrollToReveal {
  // When
  self.fakeBottomDrawer.contentHeightSurplus = CGFLOAT_MAX;

  // Then
  XCTAssertTrue(self.fakeBottomDrawer.contentScrollsToReveal);
}

- (void)testContentDoesNotScrollToReveal {
  // When
  self.fakeBottomDrawer.contentHeightSurplus = CGFLOAT_MIN;

  // Then
  XCTAssertFalse(self.fakeBottomDrawer.contentScrollsToReveal);
}

@end
