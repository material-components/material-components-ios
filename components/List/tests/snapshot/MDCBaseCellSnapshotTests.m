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

#import "MaterialShadowElevations.h"
#import "MaterialSnapshot.h"

#import "MaterialList.h"

/** Snapshot tests for MDCBaseCell. */
@interface MDCBaseCellSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCBaseCell *baseCell;

@end

@implementation MDCBaseCellSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.baseCell = [[MDCBaseCell alloc] initWithFrame:CGRectMake(0, 0, 240, 60)];
}

- (void)tearDown {
  self.baseCell = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)speedAllLayersOfView:(UIView *)view {
  view.layer.speed = 100;
  for (UIView *subview in view.subviews) {
    [self speedAllLayersOfView:subview];
  }
}

#pragma mark - Tests

- (void)testDefaultCell {
  // Then
  [self generateSnapshotAndVerifyForView:self.baseCell];
}

- (void)testCellWithElevation24 {
  // When
  self.baseCell.elevation = (MDCShadowElevation)24;

  // Then
  [self generateSnapshotAndVerifyForView:self.baseCell];
}

- (void)testCellHighlighted {
  // Given
  [self speedAllLayersOfView:self.baseCell];

  // When
  self.baseCell.highlighted = YES;

  XCTestExpectation *expect = [self expectationWithDescription:@""];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   [expect fulfill];
                 });
  [self waitForExpectations:@[ expect ] timeout:3];

  // Then
  [self generateSnapshotAndVerifyForView:self.baseCell];
}

@end
