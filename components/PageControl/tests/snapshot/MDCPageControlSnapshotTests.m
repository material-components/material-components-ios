// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSnapshot.h"

#import "MaterialPageControl.h"

/** Snapshot tests for MDCPageControl. */
@interface MDCPageControlSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCPageControl *pageControl;

@end

@implementation MDCPageControlSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.pageControl = [[MDCPageControl alloc] init];
  self.pageControl.numberOfPages = 5;
  self.pageControl.currentPage = 0;
  [self.pageControl sizeToFit];
}

- (void)tearDown {
  self.pageControl = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testPageControlDefault {
  // Then
  [self generateSnapshotAndVerifyForView:self.pageControl];
}

- (void)testPageControlDefaultRTLWithoutRespect {
  // When
  [self changeViewToRTL:self.pageControl];

  // Then
  [self generateSnapshotAndVerifyForView:self.pageControl];
}

- (void)testPageControlDefaultRTLWithRespect {
  // When
  [self changeViewToRTL:self.pageControl];
  self.pageControl.respectsUserInterfaceLayoutDirection = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.pageControl];
}

@end
