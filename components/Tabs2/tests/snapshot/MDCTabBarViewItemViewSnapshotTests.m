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

#import <XCTest/XCTest.h>

#import <CoreGraphics/CoreGraphics.h>
#import "../../src/private/MDCTabBarViewItemView.h"
#import "MaterialSnapshot.h"

@interface MDCTabBarViewItemViewSnapshotTests : MDCSnapshotTestCase

@end

@implementation MDCTabBarViewItemViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testItemViewNoTitleNoImageIntrinsicContentSize {
  // Given
  MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];
  itemView.backgroundColor = UIColor.brownColor;
  CGSize intrinsicContentSize = itemView.intrinsicContentSize;

  // When
  itemView.bounds = CGRectMake(0, 0, intrinsicContentSize.width, intrinsicContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:itemView];
}

@end
