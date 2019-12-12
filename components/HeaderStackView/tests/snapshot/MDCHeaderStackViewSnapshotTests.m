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

#import <CoreGraphics/CoreGraphics.h>

#import "MaterialHeaderStackView.h"

/** A testing support class that allows assignment of @c sizeThatFits: return value. */
@interface MDCHeaderStackViewSnaphotTestDummyView : UIView

/** The custom value to return for @c sizeThatFits:. */
@property(nonatomic, assign) CGSize sizeThatFitsSize;

@end

@implementation MDCHeaderStackViewSnaphotTestDummyView {
  BOOL _sizeThatFitAssigned;
}

- (void)setSizeThatFitsSize:(CGSize)size {
  _sizeThatFitsSize = size;
  _sizeThatFitAssigned = YES;
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (_sizeThatFitAssigned) {
    return self.sizeThatFitsSize;
  }
  return [super sizeThatFits:size];
}

@end

/** Snapshot tests for MDCHeaderStackView. */
@interface MDCHeaderStackViewSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCHeaderStackView *headerStackView;

/** The view for @c topBar in @c headerStackView. */
@property(nonatomic, strong) MDCHeaderStackViewSnaphotTestDummyView *topView;

/** The view for @c bottomBar in @c headerStackView. */
@property(nonatomic, strong) MDCHeaderStackViewSnaphotTestDummyView *bottomView;

@end

@implementation MDCHeaderStackViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.topView = [[MDCHeaderStackViewSnaphotTestDummyView alloc] init];
  self.topView.backgroundColor = UIColor.cyanColor;
  self.bottomView = [[MDCHeaderStackViewSnaphotTestDummyView alloc] init];
  self.bottomView.backgroundColor = UIColor.magentaColor;

  self.headerStackView = [[MDCHeaderStackView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  self.headerStackView.topBar = self.topView;
  self.headerStackView.bottomBar = self.bottomView;
}

- (void)tearDown {
  self.headerStackView = nil;
  self.topView = nil;
  self.bottomView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyView {
  UIView *snapshotView = [self.headerStackView mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testTopViewSizeThatFitsOneThirdSetSize {
  // Given
  self.topView.sizeThatFitsSize = CGSizeMake(CGRectGetWidth(self.headerStackView.bounds),
                                             CGRectGetHeight(self.headerStackView.bounds) / 3);

  // When
  [self.headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testBottomViewSizeThatFitsOneThirdSetSize {
  // Given
  self.bottomView.sizeThatFitsSize = CGSizeMake(CGRectGetWidth(self.headerStackView.bounds),
                                                CGRectGetHeight(self.headerStackView.bounds) / 3);

  // When
  [self.headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testTopAndBottomViewSizeThatFitsOneThirdSetSize {
  // Given
  self.topView.sizeThatFitsSize = CGSizeMake(CGRectGetWidth(self.headerStackView.bounds),
                                             CGRectGetHeight(self.headerStackView.bounds) / 3);
  self.bottomView.sizeThatFitsSize = CGSizeMake(CGRectGetWidth(self.headerStackView.bounds),
                                                CGRectGetHeight(self.headerStackView.bounds) / 3);

  // When
  [self.headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testTopViewSizeThatFitsOneThirdSizeToFit {
  // Given
  self.topView.sizeThatFitsSize = CGSizeMake(CGRectGetWidth(self.headerStackView.bounds),
                                             CGRectGetHeight(self.headerStackView.bounds) / 3);

  // When
  [self.headerStackView sizeToFit];
  [self.headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testBottomViewSizeThatFitsOneThirdSizeToFit {
  // Given
  self.bottomView.sizeThatFitsSize = CGSizeMake(CGRectGetWidth(self.headerStackView.bounds),
                                                CGRectGetHeight(self.headerStackView.bounds) / 3);

  // When
  [self.headerStackView sizeToFit];
  [self.headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testTopAndBottomViewSizeThatFitsOneThirdSizeToFit {
  // Given
  self.topView.sizeThatFitsSize = CGSizeMake(CGRectGetWidth(self.headerStackView.bounds),
                                             CGRectGetHeight(self.headerStackView.bounds) / 3);
  self.bottomView.sizeThatFitsSize = CGSizeMake(CGRectGetWidth(self.headerStackView.bounds),
                                                CGRectGetHeight(self.headerStackView.bounds) / 3);

  // When
  [self.headerStackView sizeToFit];
  [self.headerStackView layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyView];
}

@end
