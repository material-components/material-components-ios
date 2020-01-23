// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCActionSheetController.h"
#import "MDCBottomSheetPresentationController.h"

@interface ActionSheetControllerDelegate : NSObject <MDCActionSheetControllerDelegate>
@property(nonatomic, readonly) MDCActionSheetController *dismissedActionSheetController;
@end

@implementation ActionSheetControllerDelegate
- (void)actionSheetControllerDidDismiss:(MDCActionSheetController *)actionSheetController {
  _dismissedActionSheetController = actionSheetController;
}
@end

@interface MDCActionSheetControllerDelegateTests : XCTestCase
/** The @c MDCActionSheetController being tested. */
@property(nonatomic, strong) MDCActionSheetController *actionSheet;

/** An @c MDCActionSheetControllerDelegate to verify delegate functions are called. */
@property(nonatomic, nullable) ActionSheetControllerDelegate *actionSheetControllerDelegate;
@end

@implementation MDCActionSheetControllerDelegateTests

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
  self.actionSheetControllerDelegate = [[ActionSheetControllerDelegate alloc] init];
  self.actionSheet.delegate = self.actionSheetControllerDelegate;
}

- (void)tearDown {
  self.actionSheet = nil;
  self.actionSheetControllerDelegate = nil;

  [super tearDown];
}

- (void)testDidDismissIsCalledWithActionSheetController {
  // Given
  MDCBottomSheetPresentationController *presentationController =
      self.actionSheet.mdc_bottomSheetPresentationController;

  // When
  [self.actionSheet loadView];
  [presentationController.delegate
      bottomSheetPresentationControllerDidDismissBottomSheet:presentationController];

  // Then
  XCTAssertNotNil(self.actionSheetControllerDelegate.dismissedActionSheetController);
  XCTAssertEqualObjects(self.actionSheetControllerDelegate.dismissedActionSheetController,
                        self.actionSheet);
}

@end
