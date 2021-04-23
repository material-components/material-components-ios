// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialActionSheet.h"

/**
 Snapshot test for the @c viewForAction: API.
 */
@interface MDCActionSheetControllerViewForActionSnapshotTests : MDCSnapshotTestCase
/** The @c MDCActionSheetController being tested. */
@property(nonatomic, strong, nullable) MDCActionSheetController *actionSheet;

/** An Action Sheet action. */
@property(nonatomic, strong) MDCActionSheetAction *action1;

/** An Action Sheet action. */
@property(nonatomic, strong) MDCActionSheetAction *action2;

@end

@implementation MDCActionSheetControllerViewForActionSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.actionSheet = [[MDCActionSheetController alloc] init];
  self.action1 = [MDCActionSheetAction
      actionWithTitle:@"Foo"
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  self.action2 = [MDCActionSheetAction
      actionWithTitle:@"Bar"
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
}

- (void)tearDown {
  if (self.actionSheet.presentingViewController) {
    XCTestExpectation *expectation =
        [[XCTestExpectation alloc] initWithDescription:@"Action sheet is dismissed"];
    [self.actionSheet dismissViewControllerAnimated:NO
                                         completion:^{
                                           [expectation fulfill];
                                         }];
    [self waitForExpectations:@[ expectation ] timeout:5];
  }
  self.action1 = nil;
  self.action2 = nil;
  self.actionSheet = nil;

  [super tearDown];
}

- (void)testOneActionAddedToActionSheet {
  // Given
  [self.actionSheet addAction:self.action1];

  // When
  UIView *view = [self.actionSheet viewForAction:self.action1];

  // Then
  [self generateSnapshotAndVerifyForView:view];
}

- (void)testMultipleActionsAddedToActionSheetViewForFirstIndex {
  // Given
  [self.actionSheet addAction:self.action1];
  [self.actionSheet addAction:self.action2];

  // When
  UIView *view = [self.actionSheet viewForAction:self.action1];

  // Then
  [self generateSnapshotAndVerifyForView:view];
}

- (void)testMultipleActionsAddedToActionSheetViewForLastIndex {
  // Given
  [self.actionSheet addAction:self.action1];
  [self.actionSheet addAction:self.action2];

  // When
  UIView *view = [self.actionSheet viewForAction:self.action2];

  // Then
  [self generateSnapshotAndVerifyForView:view];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

@end
