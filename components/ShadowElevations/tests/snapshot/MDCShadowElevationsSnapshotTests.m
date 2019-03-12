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

#import "MaterialCards.h"
#import "MaterialShadowElevations.h"

/** Snapshot tests for ShadowElevations values. */
@interface MDCShadowElevationsSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCCard *cardView;

@end

@implementation MDCShadowElevationsSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.cardView = [[MDCCard alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
}

- (void)tearDown {
  self.cardView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(40, 40, 80, 40)];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testElevationAppBar {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationAppBar forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationBottomNavigationBar {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationBottomNavigationBar
                           forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationCardPickedUp {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationCardPickedUp forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationCardResting {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationCardResting forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationDialog {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationDialog forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationFABPressed {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationFABPressed forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationFABResting {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationFABResting forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationMenu {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationMenu forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationModalBottomSheet {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationModalBottomSheet
                           forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationNavDrawer {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationNavDrawer forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationNone {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationNone forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationPicker {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationPicker forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationQuickEntry {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationQuickEntry forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationQuickEntryResting {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationQuickEntryResting
                           forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationRaisedButtonPressed {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationRaisedButtonPressed
                           forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationRaisedButtonResting {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationRaisedButtonResting
                           forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationRefresh {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationRefresh forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationRightDrawer {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationRightDrawer forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationSearchBarResting {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationSearchBarResting
                           forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationSearchBarScrolled {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationSearchBarScrolled
                           forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationSnackbar {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationSnackbar forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationSubMenu {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationSubMenu forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

- (void)testElevationSwitch {
  // When
  [self.cardView setShadowElevation:MDCShadowElevationSwitch forState:UIControlStateNormal];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardView];
}

@end
