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

#import "MaterialProgressView.h"

/** Snapshot tests for MDCProgressView. */
@interface MDCProgressViewSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCProgressView *progressView;

@end

@implementation MDCProgressViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.progressView = [[MDCProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
}

- (void)tearDown {
  self.progressView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testProgress000LTR {
  // When
  self.progressView.progress = 0;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress000RTL {
  // When
  [self changeViewToRTL:self.progressView];
  self.progressView.progress = 0;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress025LTR {
  // When
  self.progressView.progress = (float).25;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress025RTL {
  // When
  [self changeViewToRTL:self.progressView];
  self.progressView.progress = (float).25;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress065LTR {
  // When
  self.progressView.progress = (float).65;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress065RTL {
  // When
  [self changeViewToRTL:self.progressView];
  self.progressView.progress = (float).65;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress097LTR {
  // When
  self.progressView.progress = (float).97;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress097RTL {
  // When
  [self changeViewToRTL:self.progressView];
  self.progressView.progress = (float).97;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress100LTR {
  // When
  self.progressView.progress = 1;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

- (void)testProgress100RTL {
  // When
  [self changeViewToRTL:self.progressView];
  self.progressView.progress = 1;

  // Then
  [self generateSnapshotAndVerifyForView:self.progressView];
}

@end
