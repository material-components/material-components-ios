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

#import "MaterialBottomSheet.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MaterialSnapshot.h"

/** Snapshot test for @c MDCBottomSheetController. */
@interface MDCBottomSheetControllerSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) MDCBottomSheetController *bottomSheet;
@end

@implementation MDCBottomSheetControllerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  UIViewController *fakeViewController = [[UIViewController alloc] init];
  fakeViewController.view.backgroundColor = UIColor.yellowColor;
  self.bottomSheet =
      [[MDCBottomSheetController alloc] initWithContentViewController:fakeViewController];
}

- (void)tearDown {
  if (self.bottomSheet.presentingViewController) {
    XCTestExpectation *expectation =
        [[XCTestExpectation alloc] initWithDescription:@"Bottom sheet is dismissed"];
    [self.bottomSheet dismissViewControllerAnimated:NO
                                         completion:^{
                                           [expectation fulfill];
                                         }];
    [self waitForExpectations:@[ expectation ] timeout:5];
  }
  self.bottomSheet = nil;

  [super tearDown];
}

- (void)generateAndVerifySnapshot {
  UIView *backgroundView =
      [self.bottomSheet.view mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
  [self snapshotVerifyView:backgroundView];
}

- (void)testBottomSheetTallAndNarrow {
  // Given
  self.bottomSheet.view.bounds = CGRectMake(0, 0, 100, 500);
  [self.bottomSheet.view layoutIfNeeded];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testBottomSheetWideAndShort {
  // Given
  self.bottomSheet.view.bounds = CGRectMake(0, 0, 500, 100);
  [self.bottomSheet.view layoutIfNeeded];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testBottomSheetWithCustomElevation {
  // Given
  self.bottomSheet.view.bounds = CGRectMake(0, 0, 375, 500);
  self.bottomSheet.elevation = 4;
  [self.bottomSheet.view layoutIfNeeded];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testBottomSheetWithDefaultPresentationStyleOniOS13 {
  // When
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  UIViewController *currentViewController = window.rootViewController;
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"Bottom sheet is presented"];
  [currentViewController presentViewController:self.bottomSheet
                                      animated:NO
                                    completion:^{
                                      [expectation fulfill];
                                    }];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:5];
  [self snapshotVerifyViewForIOS13:window];
}

@end
