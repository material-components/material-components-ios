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

#import "MDCBottomSheetController.h"

#import <XCTest/XCTest.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "UIViewController+MaterialBottomSheet.h"
#import "MDCSheetContainerView.h"
#pragma clang diagnostic pop
#import "MDCBottomSheetPresentationController.h"

NS_ASSUME_NONNULL_BEGIN

/** Used to test the elevation @c MDCBottomSheetPresentationController and it's @c sheetView. */
@interface MDCBottomSheetPresentationController (MDCElevationTesting)
@property(nonatomic, strong) MDCSheetContainerView *sheetView;
@end

@interface MDCBottomSheetCustomizationTests : XCTestCase

/** A dummy content view controller for presenting within the bottom sheet controller. */
@property(nonatomic, nullable) UIViewController *dummyContentViewController;

/** A bottom sheet for testing. */
@property(nonatomic, nullable) MDCBottomSheetController *bottomSheet;

/** The presentation controller of the bottom sheet being tested. */
@property(nonatomic, nullable, weak) MDCBottomSheetPresentationController *presentationController;

@end

@implementation MDCBottomSheetCustomizationTests

- (void)setUp {
  [super setUp];

  self.dummyContentViewController = [[UIViewController alloc] init];
  self.bottomSheet = [[MDCBottomSheetController alloc]
      initWithContentViewController:self.dummyContentViewController];
}

- (void)tearDown {
  self.bottomSheet = nil;
  self.presentationController = nil;
  self.dummyContentViewController = nil;

  [super tearDown];
}

// Test that the presentation controller for a bottom sheet can have its scrim color set.
- (void)testApplyingScrimColorToPresentationController {
  // Make a scrim color.
  UIColor *scrimColor = [UIColor.orangeColor colorWithAlphaComponent:(CGFloat)0.5];
  self.presentationController = self.bottomSheet.mdc_bottomSheetPresentationController;

  // Ensure that the bottom sheet has created all of the necessary internal storage for
  // presentation by pretending to start the presentation.
  [self.presentationController presentationTransitionWillBegin];

  // Set the scrim color on the presentation controller.
  self.presentationController.scrimColor = scrimColor;

  // Check that it had any effect.
  XCTAssertEqualObjects(self.presentationController.scrimColor, scrimColor);
}

// Test that the presentation controller's scrim color is set when setting it on the sheet.
- (void)testApplyingScrimColorToSheet {
  // Make a scrim color and set it on the controller.
  UIColor *scrimColor = [UIColor.blueColor colorWithAlphaComponent:(CGFloat)0.3];
  self.bottomSheet.scrimColor = scrimColor;

  // Ensure that the presentation controller is allocated after the bottom sheet because the color
  // is set on the presentation controller via the transition controller which keeps references to
  // the properties it sets on the presentaiton controller but not the presentation conrollter
  // itself. This means that once it is created by the transition controller, the scrim color cannot
  // be changed via the bottom sheet controller API, like the scrim a11y properties.
  self.presentationController = self.bottomSheet.mdc_bottomSheetPresentationController;

  // Ensure that the bottom sheet has created all of the necessary internal storage for
  // presentation by pretending to start the presentation.
  [self.presentationController presentationTransitionWillBegin];

  // Check that setting it on the controller sets it on the presentation controller.
  XCTAssertEqualObjects(self.presentationController.scrimColor, scrimColor);
}

// Test that the presentation controller's and sheet view's adjustHeightForSafeAreaInsets is set to
// YES as the default.
- (void)testDefaultadjustHeightForSafeAreaInsetsSheet {
  // When
  // Ensure that the presentation controller is allocated after the bottom sheet because the
  // property is set on the presentation controller via the transition controller which keeps
  // references to the properties it sets on the presentaiton controller but not the presentation
  // conrollter itself.
  self.presentationController = self.bottomSheet.mdc_bottomSheetPresentationController;

  // Ensure that the bottom sheet has created all of the necessary internal storage for
  // presentation by pretending to start the presentation.
  [self.presentationController presentationTransitionWillBegin];

  // Then
  XCTAssertTrue(self.bottomSheet.adjustHeightForSafeAreaInsets);
  XCTAssertTrue(self.presentationController.adjustHeightForSafeAreaInsets);
  XCTAssertTrue(self.presentationController.sheetView.adjustHeightForSafeAreaInsets);
}

// Test that the presentation controller's and sheet view's adjustHeightForSafeAreaInsets is set to
// NO when it is set on the sheet.
- (void)testSettingadjustHeightForSafeAreaInsetsSheetNo {
  // When
  self.bottomSheet.adjustHeightForSafeAreaInsets = NO;

  // Ensure that the presentation controller is allocated after the bottom sheet because the
  // property is set on the presentation controller via the transition controller which keeps
  // references to the properties it sets on the presentaiton controller but not the presentation
  // conrollter itself.
  self.presentationController = self.bottomSheet.mdc_bottomSheetPresentationController;

  // Ensure that the bottom sheet has created all of the necessary internal storage for
  // presentation by pretending to start the presentation.
  [self.presentationController presentationTransitionWillBegin];

  // Then
  XCTAssertFalse(self.presentationController.adjustHeightForSafeAreaInsets);
  XCTAssertFalse(self.presentationController.sheetView.adjustHeightForSafeAreaInsets);
}

// Test that the presentation controller's and sheet view's adjustHeightForSafeAreaInsets is set to
// YES when it is set on the sheet.
- (void)testSettingadjustHeightForSafeAreaInsetsSheetYes {
  // When
  self.bottomSheet.adjustHeightForSafeAreaInsets = YES;

  // Ensure that the presentation controller is allocated after the bottom sheet because the
  // property is set on the presentation controller via the transition controller which keeps
  // references to the properties it sets on the presentaiton controller but not the presentation
  // conrollter itself.
  self.presentationController = self.bottomSheet.mdc_bottomSheetPresentationController;

  // Ensure that the bottom sheet has created all of the necessary internal storage for
  // presentation by pretending to start the presentation.
  [self.presentationController presentationTransitionWillBegin];

  // Then
  XCTAssertTrue(self.presentationController.adjustHeightForSafeAreaInsets);
  XCTAssertTrue(self.presentationController.sheetView.adjustHeightForSafeAreaInsets);
}

@end

NS_ASSUME_NONNULL_END
