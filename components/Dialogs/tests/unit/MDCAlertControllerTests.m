// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCButton.h"
#import "MDCAlertController.h"
#import "MDCAlertControllerView.h"
#import "MDCDialogPresentationController.h"
#import "MDCDialogTransitionController.h"
#import "UIViewController+MaterialDialogs.h"
#import "MDCShadowElevations.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCAlertActionManager.h"
#import "MDCAlertControllerView+Private.h"
#import "MDCDialogShadowedView.h"
#pragma clang diagnostic pop
#import "MDCAlertController+ButtonForAction.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Subclasses for testing

/** A test fake for setting the @c traitCollection on the alert's view. */
@interface MDCAlertControllerTestsFakeWindow : UIWindow

/** Set to override the @c traitCollection property of the receiver. */
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCAlertControllerTestsFakeWindow

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

/** A test fake to override the @c traitCollection of an @c MDCAlertController. */
@interface MDCAlertControllerTestsControllerFake : MDCAlertController

/** Set to override the value of @c traitCollection of the receiver. */
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCAlertControllerTestsControllerFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

/** Expose private properties for testing. */
@interface MDCAlertController (Testing)
@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;
@end

/** Expose private properties for testing. */
@interface MDCDialogPresentationController (Testing)
@property(nonatomic) MDCDialogShadowedView *trackingView;
@end

#pragma mark - Tests

/** Unit tests for @c MDCAlertController. */
@interface MDCAlertControllerTests : XCTestCase

/** The @c MDCAlertControllers being tested. */
@property(nonatomic, nullable) MDCAlertController *alert;
@property(nonatomic, nullable) MDCAlertController *attributedAlert;
@end

@implementation MDCAlertControllerTests

- (void)setUp {
  [super setUp];

  self.alert = [MDCAlertController alertControllerWithTitle:@"title" message:@"message"];

  NSAttributedString *attributedStr =
      [[NSAttributedString alloc] initWithString:@"attributed message" attributes:@{}];
  self.attributedAlert = [MDCAlertController alertControllerWithTitle:@"title"
                                                    attributedMessage:attributedStr];
}

- (void)tearDown {
  self.alert = nil;

  [super tearDown];
}

- (void)testAlertInitialization {
  // Then
  XCTAssertEqual(self.alert.titleAlignment, NSTextAlignmentNatural);
  XCTAssertEqual(self.alert.messageAlignment, NSTextAlignmentNatural);
  XCTAssertEqual(self.alert.titleIconAlignment, NSTextAlignmentNatural);
  XCTAssertEqual(self.alert.orderVerticalActionsByEmphasis, NO);
  XCTAssertEqual(self.alert.actionsHorizontalAlignment, MDCContentHorizontalAlignmentTrailing);
  XCTAssertEqual(self.alert.actionsHorizontalAlignmentInVerticalLayout,
                 MDCContentHorizontalAlignmentCenter);
  XCTAssertEqual(self.alert.titlePinsToTop, YES);
}

- (void)testAlertControllerWithTitleAttributedMessage {
  // Then
  XCTAssertNotNil(self.attributedAlert.actions);
  XCTAssertEqualObjects(self.attributedAlert.title, @"title");
  XCTAssertEqualObjects(self.attributedAlert.attributedMessage.string, @"attributed message");
}

- (void)testAttributedMessageLinkColorIsApplied {
  // Given
  UIColor *testColor = [UIColor orangeColor];
  UIColor *messageColor = [UIColor redColor];
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.attributedAlert.view;

  // When
  self.attributedAlert.messageColor = messageColor;  // Setting the message's textColor.
  self.attributedAlert.attributedLinkColor = testColor;

  // Then
  XCTAssertEqual(view.messageTextView.tintColor, testColor);
  XCTAssertEqual(view.messageTextView.textColor, messageColor);
}

- (void)testAlertControllerColorSetting {
  // Given
  UIColor *testColor = [UIColor redColor];

  // When
  self.alert.titleColor = testColor;
  self.alert.messageColor = testColor;
  self.alert.buttonTitleColor = testColor;
  self.alert.buttonInkColor = testColor;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqual(view.titleLabel.textColor, testColor);
  XCTAssertEqual(view.messageTextView.textColor, testColor);
  for (MDCButton *button in view.actionManager.buttonsInActionOrder) {
    XCTAssertEqual([button titleColorForState:UIControlStateNormal], testColor);
    XCTAssertTrue([button isKindOfClass:[MDCButton class]]);
    XCTAssertEqual([button inkColor], testColor);
  }
}

- (void)testAlertControllerColorSettingAfterActions {
  // Given
  UIColor *testColor = [UIColor redColor];

  // When
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];

  self.alert.titleColor = testColor;
  self.alert.messageColor = testColor;
  self.alert.buttonTitleColor = testColor;
  self.alert.buttonInkColor = testColor;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqual(view.titleLabel.textColor, testColor);
  XCTAssertEqual(view.messageTextView.textColor, testColor);
  NSArray<MDCButton *> *buttons = (NSArray<MDCButton *> *)view.actionManager.buttonsInActionOrder;
  XCTAssertEqual((int)buttons.count, 2);
  for (MDCButton *button in buttons) {
    XCTAssertEqual([button titleColorForState:UIControlStateNormal], testColor);
    XCTAssertTrue([button isKindOfClass:[MDCButton class]]);
    XCTAssertEqual([button inkColor], testColor);
  }
}

- (void)testAlertControllerSettingTitleAndAttributedMessage {
  // Given
  NSString *title = @"title";
  NSString *message = @"attributed message";

  // When
  self.attributedAlert.titleFont = [UIFont systemFontOfSize:25];

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.attributedAlert.view;
  XCTAssertEqual(view.titleLabel.text, title);
  XCTAssertEqualObjects(view.messageTextView.text, message);
}

- (void)testAlertControllerMessageAccessibilityLabelWhenOnlyMessageIsSet {
  // Given
  NSString *message = @"Foo";

  // When
  self.alert.message = message;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  self.alert.messageAccessibilityLabel = nil;

  // Then
  XCTAssertEqualObjects(view.messageTextView.accessibilityLabel, message);
}

- (void)testAccessibilityIdentifiersAppliesToAlertControllerViewButtons {
  // Given
  MDCAlertAction *action1 = [MDCAlertAction actionWithTitle:@"button1" handler:nil];
  action1.accessibilityIdentifier = @"1";
  MDCAlertAction *action2 = [MDCAlertAction actionWithTitle:@"buttonA" handler:nil];
  action2.accessibilityIdentifier = @"A";

  // When
  [self.alert addAction:action1];
  [self.alert addAction:action2];

  // Force the view to load
  [self.alert loadViewIfNeeded];

  // Then
  NSArray<UIButton *> *buttons = self.alert.alertView.actionManager.buttonsInActionOrder;
  XCTAssertEqual(buttons.count, 2U);
  UIButton *button1 = buttons.firstObject;
  UIButton *button2 = buttons.lastObject;

  if (![[button1.titleLabel.text lowercaseString] isEqualToString:action1.title]) {
    button1 = buttons.lastObject;
    button2 = buttons.firstObject;
  }
  XCTAssertEqualObjects(button1.accessibilityIdentifier, @"1");
  XCTAssertEqualObjects(button2.accessibilityIdentifier, @"A");
}

- (void)testCustomDialogPresentationElevation {
  // Given
  CGFloat elevation = (CGFloat)2.0;

  // When
  self.alert.mdc_dialogPresentationController.dialogElevation = elevation;

  // Then
  MDCDialogShadowedView *shadowView = self.alert.mdc_dialogPresentationController.trackingView;
  XCTAssertEqual(shadowView.elevation, elevation);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCAlertController *alertController = [[MDCAlertController alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCAlertController *passedAlertController;
  alertController.traitCollectionDidChangeBlock =
      ^(MDCAlertController *_Nonnull blockAlertController,
        UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
        passedTraitCollection = previousTraitCollection;
        passedAlertController = blockAlertController;
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [alertController traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedAlertController, alertController);
}

#pragma mark - MaterialElevation

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat expectedBaseElevation = 99;
  MDCAlertController *alertController = [[MDCAlertController alloc] init];

  // When
  alertController.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(alertController.mdc_overrideBaseElevation, expectedBaseElevation,
                             0.001);
}

- (void)testCurrentElevationMatchesElevationWhenElevationChanges {
  // When
  MDCAlertController *alertController = [[MDCAlertController alloc] init];
  alertController.elevation = 77;

  // Then
  XCTAssertEqualWithAccuracy(alertController.mdc_currentElevation, alertController.elevation,
                             0.001);
}

@end

NS_ASSUME_NONNULL_END
