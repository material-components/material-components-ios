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

#import "MaterialCards.h"
#import "MaterialCards+Theming.h"
#import "MaterialSnapshot.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

@interface MDCCardSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@property(nonatomic, strong) MDCCard *card;
@property(nonatomic, strong) MDCCardCollectionCell *cardCell;

@end

@implementation MDCCardSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.card = [[MDCCard alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
  self.cardCell = [[MDCCardCollectionCell alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
}

- (void)tearDown {
  self.card = nil;
  self.cardCell = nil;
  self.containerScheme = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testDefaultCard {
  // Then
  [self generateSnapshotAndVerifyForView:self.card];
}

- (void)testBaselineThemedCard {
  // When
  [self.card applyThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.card];
}

- (void)testOutlinedThemedCard {
  // When
  [self.card applyOutlinedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.card];
}

- (void)testDefaultCardCell {
  // Then
  [self generateSnapshotAndVerifyForView:self.cardCell];
}

- (void)testBaselineThemedCardCell {
  // When
  [self.cardCell applyThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardCell];
}

- (void)testOutlinedThemedCardCell {
  // When
  [self.cardCell applyOutlinedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.cardCell];
}

@end
