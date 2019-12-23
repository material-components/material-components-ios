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

#import <XCTest/XCTest.h>

#import "MaterialSnackbar.h"
#import "MaterialTypography.h"
#import "supplemental/MDCFakeMDCSnackbarManagerDelegate.h"

#import "../../src/private/MDCSnackbarManagerInternal.h"
#import "../../src/private/MDCSnackbarOverlayView.h"

@interface MDCSnackbarManagerInternal (Testing)
@property(nonatomic) MDCSnackbarMessageView *currentSnackbar;
@property(nonatomic) MDCSnackbarOverlayView *overlayView;
@property(nonatomic) BOOL isVoiceOverRunningOverride;
@end
@interface MDCSnackbarManager (Testing)
@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;
@end
@interface MDCSnackbarMessageView (Testing)
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) NSMutableArray<MDCButton *> *actionButtons;
@end

/** Fake MDCChipView for unit testing. */
@interface MDCSnackbarMessageViewTestsFakeView : MDCSnackbarMessageView

/** Used to set the value of @c traitCollection. */
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;

@end

@implementation MDCSnackbarMessageViewTestsFakeView

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCSnackbarMessageViewTests : XCTestCase
@property(nonatomic, strong) MDCSnackbarManager *manager;
@property(nonatomic, strong) FakeMDCSnackbarManagerDelegate *delegate;
@property(nonatomic, strong) MDCSnackbarMessage *message;
@end

@implementation MDCSnackbarMessageViewTests

- (void)setUp {
  [super setUp];

  self.manager = [[MDCSnackbarManager alloc] init];
  self.delegate = [[FakeMDCSnackbarManagerDelegate alloc] init];
  self.manager.delegate = self.delegate;
  self.message = [MDCSnackbarMessage messageWithText:@"message text"];
}

- (void)tearDown {
  [self.manager dismissAndCallCompletionBlocksWithCategory:nil];
  self.message = nil;
  self.manager.delegate = nil;
  self.delegate = nil;
  self.manager = nil;

  [super tearDown];
}

- (void)testDefaultColors {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];

  // Then
  XCTAssertEqualObjects(messageView.snackbarMessageViewBackgroundColor,
                        [UIColor colorWithRed:(CGFloat)(0x32 / 255.0)
                                        green:(CGFloat)(0x32 / 255.0)
                                         blue:(CGFloat)(0x32 / 255.0)
                                        alpha:1]);
  XCTAssertEqualObjects(messageView.snackbarMessageViewShadowColor, UIColor.blackColor);
  XCTAssertEqualObjects(messageView.messageTextColor, UIColor.whiteColor);
}

- (void)testDefaultElevation {
  // Then
  XCTAssertEqual([[MDCSnackbarMessageView alloc] init].elevation, MDCShadowElevationSnackbar);
}

- (void)testCustomElevation {
  // Given
  CGFloat fakeElevation = 10;
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];

  // When
  messageView.elevation = fakeElevation;

  // Then
  XCTAssertEqual(messageView.elevation, fakeElevation);
}

- (void)testAccessibilityLabelDefaultIsNil {
  // When
  [self.manager showMessage:self.message];

  // Then
  XCTAssertNil(self.delegate.presentedView.label.accessibilityLabel);
}

- (void)testAccessibilityLabelSetFromSnackbarMessageProperty {
  // When
  self.message.accessibilityLabel = @"not message text";
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertEqualObjects(self.delegate.presentedView.label.accessibilityLabel,
                        self.message.accessibilityLabel);
}

- (void)testAccessibilityHintDefaultIsNotNil {
  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertNotNil(self.delegate.presentedView.label.accessibilityHint);
}

- (void)testAccessibilityHintSetFromSnackbarMessageProperty {
  // When
  self.message.accessibilityHint = @"a hint";
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertEqualObjects(self.delegate.presentedView.label.accessibilityHint,
                        self.message.accessibilityHint);
}

- (void)testSnackbarAccessibiltyViewIsModalDefaultsToNoWithActions {
  // Given
  self.manager.internalManager.isVoiceOverRunningOverride = YES;
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertFalse(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testSnackbarAccessibiltyViewIsModalDefaultsToNoWithNoActions {
  // Given
  self.manager.internalManager.isVoiceOverRunningOverride = YES;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertFalse(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testWhenSnackbarAccessibiltyViewIsModalIsYesWithActions {
  // Given
  self.manager.internalManager.isVoiceOverRunningOverride = YES;
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;
  self.manager.shouldEnableAccessibilityViewIsModal = YES;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testWhenSnackbarAccessibiltyViewIsModalIsYesWithActionsAndWithoutVoiceOver {
  // Given
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;
  self.manager.shouldEnableAccessibilityViewIsModal = YES;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertFalse(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testWhenSnackbarAccessibiltyViewIsModalIsYesWhenWithNoActions {
  // Given
  self.manager.internalManager.isVoiceOverRunningOverride = YES;
  self.manager.shouldEnableAccessibilityViewIsModal = YES;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertFalse(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testSnackbarAccessibiltyViewIsModalWithSnackbarViewOverwriteWithActions {
  // Given
  self.delegate.shouldSetSnackbarViewAccessibilityViewIsModal = YES;
  self.manager.internalManager.isVoiceOverRunningOverride = YES;
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testSnackbarAccessibiltyViewIsModalWithSnackbarViewOverwriteWithNoActions {
  // Given
  self.delegate.shouldSetSnackbarViewAccessibilityViewIsModal = YES;
  self.manager.internalManager.isVoiceOverRunningOverride = YES;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(self.manager.internalManager.overlayView.accessibilityViewIsModal);
}

- (void)testManagerForwardsButtonProperties {
  // Given
  self.manager.disabledButtonAlpha = (CGFloat)0.5;
  self.manager.uppercaseButtonTitle = NO;
  self.manager.buttonInkColor = UIColor.redColor;
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap Me";
  self.message.action = action;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  MDCButton *actionButton = self.manager.internalManager.currentSnackbar.actionButtons.firstObject;
  XCTAssertFalse(actionButton.uppercaseTitle);
  XCTAssertEqual(actionButton.disabledAlpha, 0.5);
  XCTAssertEqualObjects(UIColor.redColor, actionButton.inkColor);
}

- (void)testTraitCollectionDidChangeCalledWhenTraitCollectionChanges {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCSnackbarMessageView *passedMessageView;
  messageView.traitCollectionDidChangeBlock =
      ^(MDCSnackbarMessageView *_Nonnull inMessageView,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedMessageView = inMessageView;
        passedTraitCollection = previousTraitCollection;
        [expectation fulfill];
      };

  // When
  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  [messageView traitCollectionDidChange:testCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
  XCTAssertEqual(passedMessageView, messageView);
}

- (void)testCurrentElevationMatchesElevationWhenElevationChanges {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];

  // When
  messageView.elevation = 4;

  // Then
  XCTAssertEqualWithAccuracy(messageView.mdc_currentElevation, messageView.elevation, 0.001);
}

- (void)testSettingOverrideBaseElevationReturnsSetValue {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];
  CGFloat expectedBaseElevation = 99;

  // When
  messageView.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(messageView.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];
  messageView.elevation = 5;
  __block BOOL blockCalled = NO;
  messageView.mdc_elevationDidChangeBlock = ^(MDCSnackbarMessageView *object, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  messageView.elevation = messageView.elevation + 1;

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];
  messageView.elevation = 5;
  __block BOOL blockCalled = NO;
  messageView.mdc_elevationDidChangeBlock = ^(MDCSnackbarMessageView *object, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  messageView.elevation = messageView.elevation;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testDefaultValueForOverrideBaseElevationIsNegative {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];

  // Then
  XCTAssertLessThan(messageView.mdc_overrideBaseElevation, 0);
}

- (void)testMessageViewMessageDynamicTypeBehavior {
  if (@available(iOS 10.0, *)) {
    // Given
    MDCSnackbarMessageViewTestsFakeView *messageView =
        [[MDCSnackbarMessageViewTestsFakeView alloc] init];
    messageView.mdc_adjustsFontForContentSizeCategory = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    messageView.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;
#pragma clang diagnostic pop
    UIFont *messageFont = [UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium];
    MDCFontScaler *fontScaler = [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleBody1];
    messageFont = [fontScaler scaledFontWithFont:messageFont];
    messageFont = [messageFont mdc_scaledFontAtDefaultSize];
    messageView.messageFont = messageFont;
    CGFloat originalMessageFontSize = messageView.label.font.pointSize;

    // When
    UIContentSizeCategory size = UIContentSizeCategoryExtraExtraExtraLarge;
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:size];
    messageView.traitCollectionOverride = traitCollection;
    [NSNotificationCenter.defaultCenter
        postNotificationName:UIContentSizeCategoryDidChangeNotification
                      object:nil];

    // Then
    CGFloat actualMessageFontSize = messageView.label.font.pointSize;
    XCTAssertGreaterThan(actualMessageFontSize, originalMessageFontSize);
  }
}

- (void)testMessageViewButtonDynamicTypeBehavior {
  if (@available(iOS 10.0, *)) {
    // Given
    MDCSnackbarMessageViewTestsFakeView *messageView =
        [[MDCSnackbarMessageViewTestsFakeView alloc] init];
    messageView.mdc_adjustsFontForContentSizeCategory = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    messageView.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;
#pragma clang diagnostic pop
    MDCButton *button = [[MDCButton alloc] init];
    [messageView.actionButtons addObject:button];
    UIFont *buttonFont = [UIFont systemFontOfSize:10.0 weight:UIFontWeightMedium];
    MDCFontScaler *fontScaler = [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleButton];
    buttonFont = [fontScaler scaledFontWithFont:buttonFont];
    buttonFont = [buttonFont mdc_scaledFontAtDefaultSize];
    messageView.buttonFont = buttonFont;
    CGFloat originalButtonFontSize = [button titleFontForState:UIControlStateNormal].pointSize;

    // When
    UIContentSizeCategory size = UIContentSizeCategoryExtraExtraExtraLarge;
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:size];
    messageView.traitCollectionOverride = traitCollection;
    [NSNotificationCenter.defaultCenter
        postNotificationName:UIContentSizeCategoryDidChangeNotification
                      object:nil];

    // Then
    CGFloat actualButtonFontSize = [button titleFontForState:UIControlStateNormal].pointSize;
    XCTAssertGreaterThan(actualButtonFontSize, originalButtonFontSize);
  }
}

- (void)testMessageViewAdjustsFontForContentSizeCategoryWhenScaledFontIsUnavailableDefaultValue {
  // Given
  MDCSnackbarMessageView *messageView = [[MDCSnackbarMessageView alloc] init];

  // Then
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  XCTAssertTrue(messageView.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable);
#pragma clang diagnostic pop
}

- (void)testMessageStaysWhenFocusOnShowIsEnabled {
  // Given
  self.manager.internalManager.isVoiceOverRunningOverride = YES;
  self.message.focusOnShow = YES;
  self.message.duration = 0.1;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_time_t popTime =
      dispatch_time(DISPATCH_TIME_NOW, (int64_t)((CGFloat)0.2 * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertFalse(self.manager.internalManager.currentSnackbar.accessibilityElementsHidden);
}

- (void)testMessageCustomizationUsingWillPresentBlock {
  // Given
  __block BOOL blockCalled = NO;
  self.message.snackbarMessageWillPresentBlock =
      ^(MDCSnackbarMessage *snackbarMessage, MDCSnackbarMessageView *messageView) {
        blockCalled = YES;
      };

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testMessageStaysWhenDurationIsZero {
  // Given
  self.message.duration = 0.1;
  self.message.automaticallyDismisses = NO;

  // When
  [self.manager showMessage:self.message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_time_t popTime =
      dispatch_time(DISPATCH_TIME_NOW, (int64_t)((CGFloat)0.2 * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  XCTAssertNotNil(self.manager.internalManager.currentSnackbar);
}

@end
