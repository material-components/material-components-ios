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

#import "MaterialButtons.h"
#import "MaterialDialogs.h"
#import "MaterialTypography.h"

#import "../../src/private/MDCDialogShadowedView.h"
#import "MDCAlertController+ButtonForAction.h"
#import "MDCAlertControllerView+Private.h"

static NSDictionary<UIContentSizeCategory, NSNumber *> *CustomScalingCurve() {
  static NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    scalingCurve = @{
      UIContentSizeCategoryExtraSmall : @99,
      UIContentSizeCategorySmall : @98,
      UIContentSizeCategoryMedium : @97,
      UIContentSizeCategoryLarge : @96,
      UIContentSizeCategoryExtraLarge : @95,
      UIContentSizeCategoryExtraExtraLarge : @94,
      UIContentSizeCategoryExtraExtraExtraLarge : @93,
      UIContentSizeCategoryAccessibilityMedium : @92,
      UIContentSizeCategoryAccessibilityLarge : @91,
      UIContentSizeCategoryAccessibilityExtraLarge : @90,
      UIContentSizeCategoryAccessibilityExtraExtraLarge : @89,
      UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @88
    };
  });
  return scalingCurve;
}

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
}

- (void)testAlertViewCanBecomeFirstResponder {
  // Then
  XCTAssertTrue(self.alert.view.canBecomeFirstResponder);
}

- (void)testAlertValuesDontRevertToDefaultValuesAfterViewIsLoaded {
  // Given
  self.alert.titleAlignment = NSTextAlignmentLeft;
  self.alert.messageAlignment = NSTextAlignmentLeft;
  self.alert.titleIconAlignment = NSTextAlignmentRight;
  self.alert.orderVerticalActionsByEmphasis = YES;
  self.alert.actionsHorizontalAlignment = MDCContentHorizontalAlignmentLeading;
  self.alert.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentJustified;

  // When (invoking viewDidLoad)
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alert.view;

  // Then
  XCTAssertEqual(self.alert.titleAlignment, NSTextAlignmentLeft);
  XCTAssertEqual(alertView.titleAlignment, NSTextAlignmentLeft);
  XCTAssertEqual(self.alert.messageAlignment, NSTextAlignmentLeft);
  XCTAssertEqual(alertView.messageAlignment, NSTextAlignmentLeft);
  XCTAssertEqual(self.alert.titleIconAlignment, NSTextAlignmentRight);
  XCTAssertEqual(alertView.titleIconAlignment, NSTextAlignmentRight);
  XCTAssertEqual(self.alert.orderVerticalActionsByEmphasis, YES);
  XCTAssertEqual(alertView.orderVerticalActionsByEmphasis, YES);
  XCTAssertEqual(self.alert.actionsHorizontalAlignment, MDCContentHorizontalAlignmentLeading);
  XCTAssertEqual(alertView.actionsHorizontalAlignment, MDCContentHorizontalAlignmentLeading);
  XCTAssertEqual(self.alert.actionsHorizontalAlignmentInVerticalLayout,
                 MDCContentHorizontalAlignmentJustified);
  XCTAssertEqual(alertView.actionsHorizontalAlignmentInVerticalLayout,
                 MDCContentHorizontalAlignmentJustified);
}

/**
 Verifies that the message init does call initialize other variables correctly and configures, as
 per the common init, and the message property
 */
- (void)testMessageInit {
  // Then
  XCTAssertNotNil(self.alert.actions);
  XCTAssertNotNil(self.alert.title);
  XCTAssertTrue(self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable);
  XCTAssertEqualObjects(self.alert.shadowColor, UIColor.blackColor);

  XCTAssertNotNil(self.alert.message);
  XCTAssertNil(self.alert.attributedMessage);
}

/**
 Verifies that the attributedMessage init does call initialize other variables correctly and
 configures, as per the common init, and the attributedMessage property
 */
- (void)testAttributedMessageInit {
  // Then
  XCTAssertNotNil(self.attributedAlert.actions);
  XCTAssertNotNil(self.attributedAlert.title);
  XCTAssertNil(self.attributedAlert.attributedLinkColor);
  XCTAssertNil(self.attributedAlert.attributedMessageAction);
  XCTAssertTrue(self.attributedAlert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable);
  XCTAssertEqualObjects(self.attributedAlert.shadowColor, UIColor.blackColor);

  XCTAssertNotNil(self.attributedAlert.attributedMessage);
  XCTAssertNil(self.attributedAlert.message);
}

- (void)testAlertControllerWithTitleMessage {
  // Then
  XCTAssertNotNil(self.alert.actions);
  XCTAssertEqualObjects(self.alert.title, @"title");
  XCTAssertEqualObjects(self.alert.message, @"message");
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

- (void)testAttributedMessageForegroundColorIsPreserved {
  // Given
  UIColor *attributeColor = [UIColor blueColor];
  UIColor *messageColor = [UIColor redColor];
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.attributedAlert.view;
  NSAttributedString *attributedStr = [[NSAttributedString alloc]
      initWithString:@"attributed message"
          attributes:@{NSForegroundColorAttributeName : attributeColor}];

  // When
  self.attributedAlert.attributedMessage = attributedStr;

  // Then
  NSDictionary<NSAttributedStringKey, id> *attributes =
      [view.messageTextView.attributedText attributesAtIndex:0 effectiveRange:nil];
  // Before the text color is assigned, the attribute color is retained.
  XCTAssertEqual(attributes[NSForegroundColorAttributeName], attributeColor);

  // When
  self.attributedAlert.messageColor = messageColor;  // Setting the message's textColor.

  // Then
  attributes = [view.messageTextView.attributedText attributesAtIndex:0 effectiveRange:nil];
  // The foreground color attribute is overriden by the textColor. This is UIKit's default behavior.
  XCTAssertEqual(attributes[NSForegroundColorAttributeName], messageColor);
}

- (void)testAlertControllerTyphography {
  // Given
  UIFont *testFont = [UIFont boldSystemFontOfSize:30];

  // When
  self.alert.titleFont = testFont;
  self.alert.messageFont = testFont;
  for (MDCAlertAction *action in self.alert.actions) {
    [[self.alert buttonForAction:action] setTitleFont:testFont forState:UIControlStateNormal];
  }

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqualObjects(view.titleLabel.font, testFont);
  XCTAssertEqualObjects(view.messageTextView.font, testFont);
  for (UIButton *button in view.actionManager.buttonsInActionOrder) {
    XCTAssertEqualObjects(button.titleLabel.font, testFont);
  }
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
  for (UIButton *button in view.actionManager.buttonsInActionOrder) {
    XCTAssertEqual([button titleColorForState:UIControlStateNormal], testColor);
    XCTAssertTrue([button isKindOfClass:[MDCButton class]]);
    XCTAssertEqual([(MDCButton *)button inkColor], testColor);
  }
}

- (void)testAlertControllerColorSettingBeforeActions {
  // Given
  UIColor *testColor = [UIColor redColor];

  // When
  self.alert.titleColor = testColor;
  self.alert.messageColor = testColor;
  self.alert.buttonTitleColor = testColor;
  self.alert.buttonInkColor = testColor;

  [self.alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqual(view.titleLabel.textColor, testColor);
  XCTAssertEqual(view.messageTextView.textColor, testColor);
  NSArray<MDCButton *> *buttons = view.actionManager.buttonsInActionOrder;
  XCTAssertEqual((int)buttons.count, 2);
  for (UIButton *button in buttons) {
    XCTAssertEqual([button titleColorForState:UIControlStateNormal], testColor);
    XCTAssertTrue([button isKindOfClass:[MDCButton class]]);
    XCTAssertEqual([(MDCButton *)button inkColor], testColor);
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
  NSArray<MDCButton *> *buttons = view.actionManager.buttonsInActionOrder;
  XCTAssertEqual((int)buttons.count, 2);
  for (UIButton *button in buttons) {
    XCTAssertEqual([button titleColorForState:UIControlStateNormal], testColor);
    XCTAssertTrue([button isKindOfClass:[MDCButton class]]);
    XCTAssertEqual([(MDCButton *)button inkColor], testColor);
  }
}

- (void)testAlertControllerColorSettingBetweenActions {
  // Given
  UIColor *testColor = [UIColor redColor];

  // When
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];

  self.alert.titleColor = testColor;
  self.alert.messageColor = testColor;
  self.alert.buttonTitleColor = testColor;
  self.alert.buttonInkColor = testColor;

  [self.alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqual(view.titleLabel.textColor, testColor);
  XCTAssertEqual(view.messageTextView.textColor, testColor);
  NSArray<MDCButton *> *buttons = view.actionManager.buttonsInActionOrder;
  XCTAssertEqual((int)buttons.count, 2);
  for (UIButton *button in buttons) {
    XCTAssertEqual([button titleColorForState:UIControlStateNormal], testColor);
    XCTAssertTrue([button isKindOfClass:[MDCButton class]]);
    XCTAssertEqual([(MDCButton *)button inkColor], testColor);
  }
}

- (void)testAlertControllerSettingTitleAndMessage {
  // Given
  NSString *title = @"title";
  NSString *message = @"message";

  // When
  self.alert.titleFont = [UIFont systemFontOfSize:25];

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqual(view.titleLabel.text, title);
  XCTAssertEqualObjects(view.messageTextView.text, message);
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

- (void)testAlertControllerSetMessageAccessibilityLabelWhenMessageIsSetWhenViewIsNotLoaded {
  // Given
  NSString *message = @"Foo";
  NSString *messageAccessibilityLabel = @"Bar";

  // When
  self.alert.message = message;
  self.alert.messageAccessibilityLabel = messageAccessibilityLabel;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;

  // Then
  XCTAssertEqualObjects(view.messageTextView.accessibilityLabel, messageAccessibilityLabel);
}

- (void)testAlertControllerSetMessageAccessibilityLabelWhenMessageIsSetAndViewIsLoaded {
  // Given
  NSString *message = @"Foo";
  NSString *messageAccessibilityLabel = @"Bar";

  // When
  self.alert.message = message;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  self.alert.messageAccessibilityLabel = messageAccessibilityLabel;

  // Then
  XCTAssertEqualObjects(view.messageTextView.accessibilityLabel, messageAccessibilityLabel);
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

- (void)testAlertControllerMessageAccessibilityLabelWhenOnlyMessageIsSetWhenViewIsNotLoaded {
  // Given
  NSString *message = @"Foo";

  // When
  self.alert.message = message;
  self.alert.messageAccessibilityLabel = nil;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;

  // Then
  XCTAssertEqualObjects(view.messageTextView.accessibilityLabel, message);
}

- (void)testAlertControllerMessageAccessibilityLabelWhenOnlyAttributedMessageIsSet {
  // Given
  NSAttributedString *message = [[NSAttributedString alloc] initWithString:@"Foo"];

  // When
  self.attributedAlert.attributedMessage = message;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.attributedAlert.view;
  self.attributedAlert.messageAccessibilityLabel = nil;

  // Then
  XCTAssertEqualObjects(view.messageTextView.accessibilityLabel, message.string);
}

- (void)testAlertControllerSetTitleAccessibilityLabelWhenTitleIsSetWhenViewIsNotLoaded {
  // Given
  NSString *title = @"Foo";
  NSString *titleAccessibilityLabel = @"Bar";

  // When
  self.alert.title = title;
  self.alert.titleAccessibilityLabel = titleAccessibilityLabel;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;

  // Then
  XCTAssertEqualObjects(view.titleLabel.accessibilityLabel, titleAccessibilityLabel);
}

- (void)testAlertControllerSetTitleAccessibilityLabelWhenTitleIsSetAndViewIsLoaded {
  // Given
  NSString *title = @"Foo";
  NSString *titleAccessibilityLabel = @"Bar";

  // When
  self.alert.title = title;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  self.alert.titleAccessibilityLabel = titleAccessibilityLabel;

  // Then
  XCTAssertEqualObjects(view.titleLabel.accessibilityLabel, titleAccessibilityLabel);
}

- (void)testAlertControllerTitleAccessibilityLabelWhenOnlyTitleIsSet {
  // Given
  NSString *title = @"Foo";

  // When
  self.alert.title = title;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  self.alert.titleAccessibilityLabel = nil;

  // Then
  XCTAssertEqualObjects(view.titleLabel.accessibilityLabel, title);
}

- (void)testAlertControllerTitleAccessibilityLabelWhenOnlyTitleIsSetWhenViewIsNotLoaded {
  // Given
  NSString *title = @"Foo";

  // When
  self.alert.title = title;
  self.alert.titleAccessibilityLabel = nil;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;

  // Then
  XCTAssertEqualObjects(view.titleLabel.accessibilityLabel, title);
}

- (void)testTheViewIsNotLoadedWhenPropertiesAreSet {
  UIColor *testColor = [UIColor redColor];
  self.alert.titleColor = testColor;
  self.alert.messageColor = testColor;
  self.alert.attributedLinkColor = testColor;
  self.alert.buttonTitleColor = testColor;
  self.alert.buttonInkColor = testColor;
  self.alert.titleFont = [UIFont systemFontOfSize:12];
  self.alert.messageFont = [UIFont systemFontOfSize:14];
  for (MDCAlertAction *action in self.alert.actions) {
    [[self.alert buttonForAction:action] setTitleFont:[UIFont systemFontOfSize:10]
                                             forState:UIControlStateNormal];
  }
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"test"
                                                handler:^(MDCAlertAction *_Nonnull action){
                                                }]];
  XCTAssertFalse(self.alert.isViewLoaded);
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

- (void)testDefaultCornerRadius {
  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqualWithAccuracy(view.layer.cornerRadius, 0.0, 0.001);
  XCTAssertEqualWithAccuracy(self.alert.mdc_dialogPresentationController.dialogCornerRadius, 0.0,
                             0.001);
}

- (void)testCustomCornerRadius {
  // Given
  CGFloat cornerRadius = (CGFloat)36.0;

  // When
  self.alert.cornerRadius = cornerRadius;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqualWithAccuracy(view.layer.cornerRadius, cornerRadius, 0.001);
  XCTAssertEqualWithAccuracy(self.alert.mdc_dialogPresentationController.dialogCornerRadius,
                             cornerRadius, 0.001);
}

- (void)testDefaultElevation {
  // Given
  CGFloat elevation = (CGFloat)MDCShadowElevationDialog;

  // Then
  MDCDialogShadowedView *shadowView = self.alert.mdc_dialogPresentationController.trackingView;
  XCTAssertEqual(shadowView.elevation, elevation);
}

- (void)testCustomElevation {
  // Given
  CGFloat elevation = (CGFloat)2.0;

  // When
  self.alert.elevation = elevation;

  // Then
  MDCDialogShadowedView *shadowView = self.alert.mdc_dialogPresentationController.trackingView;
  XCTAssertEqual(shadowView.elevation, elevation);
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

- (void)testCustomShadowColor {
  // Given
  UIColor *fakeColor = UIColor.orangeColor;

  // When
  self.alert.shadowColor = fakeColor;

  // Then
  XCTAssertEqualObjects(self.alert.mdc_dialogPresentationController.trackingView.shadowColor,
                        fakeColor);
}

- (void)testCustomShadowColorOnPresenationController {
  // Given
  UIColor *fakeColor = UIColor.orangeColor;
  MDCDialogPresentationController *presentationController = [[MDCDialogPresentationController alloc]
      initWithPresentedViewController:[[UIViewController alloc] init]
             presentingViewController:nil];

  // When
  presentationController.dialogShadowColor = fakeColor;

  // Then
  XCTAssertEqualObjects(presentationController.trackingView.shadowColor, fakeColor);
}

- (void)testDialogBackgroundColorIsNotClearWhenNoThemingIsApllied {
  // Then
  XCTAssertNotNil(self.alert.view.backgroundColor);
}

- (void)testDialogCustomBackgroundColorAfterPresentation {
  // Given
  UIColor *testColor = UIColor.redColor;

  // When
  [self.alert setBackgroundColor:testColor];

  // Then
  XCTAssertEqualObjects(self.alert.view.backgroundColor, testColor);
}

/**
 Test the setting @c adjustFontForContentSizeCategoryWhenScaledFontsIsUnavailable also sets the
 property on the @c alertView.
 */
- (void)testAdjustFontForContentSizeCategoryWhenScaledFontIsUnavailableSetsTheAlertViewProperty {
  // When
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // Then
  XCTAssertFalse(self.alert.alertView.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable);
}

- (void)testLegacyDynamicTypeDisabledThenDynamicTypeEnabledDoesNotUpdateFonts {
  // Given
  UIFont *fakeTitleFont = [UIFont systemFontOfSize:55];
  self.alert.titleFont = fakeTitleFont;
  UIFont *fakeMessageFont = [UIFont systemFontOfSize:50];
  self.alert.messageFont = fakeMessageFont;
  MDCAlertAction *fakeAction = [MDCAlertAction actionWithTitle:@"Foo"
                                                       handler:^(MDCAlertAction *action){
                                                       }];
  [self.alert addAction:fakeAction];
  UIFont *fakeButtonFont = [UIFont systemFontOfSize:45];
  [[self.alert buttonForAction:fakeAction] setTitleFont:fakeButtonFont
                                               forState:UIControlStateNormal];
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is not equal to %@",
                view.titleLabel.font, fakeTitleFont);
  XCTAssertTrue([view.messageTextView.font mdc_isSimplyEqual:fakeMessageFont],
                @"%@ is not equal to %@", view.messageTextView.font, fakeMessageFont);
  MDCButton *button = [self.alert buttonForAction:fakeAction];
  XCTAssertTrue([[button titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:fakeButtonFont],
                @"%@ is not equal to %@", [button titleFontForState:UIControlStateNormal],
                fakeButtonFont);
}

- (void)testDynamicTypeEnabledAndLegacyEnabledUpdatesTheFonts {
  // Given
  UIFont *fakeTitleFont = [UIFont systemFontOfSize:55];
  self.alert.titleFont = fakeTitleFont;
  UIFont *fakeMessageFont = [UIFont systemFontOfSize:50];
  self.alert.messageFont = fakeMessageFont;
  MDCAlertAction *fakeAction = [MDCAlertAction actionWithTitle:@"Foo"
                                                       handler:^(MDCAlertAction *action){
                                                       }];
  [self.alert addAction:fakeAction];
  UIFont *fakeButtonFont = [UIFont systemFontOfSize:45];
  [[self.alert buttonForAction:fakeAction] setTitleFont:fakeButtonFont
                                               forState:UIControlStateNormal];
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;

  // When
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is equal to %@",
                 view.titleLabel.font, fakeTitleFont);
  XCTAssertFalse([view.messageTextView.font mdc_isSimplyEqual:fakeMessageFont],
                 @"%@ is equal to %@", view.messageTextView.font, fakeMessageFont);
  MDCButton *button = [self.alert buttonForAction:fakeAction];
  XCTAssertFalse([[button titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:fakeButtonFont],
                 @"%@ is equal to %@", [button titleFontForState:UIControlStateNormal],
                 fakeButtonFont);
}

/** Verifies that buttons respond to dynamic type if they were added before or after dynamic type
 * properties where turned on */
- (void)testDynamicTypeEnabledUpdatesButtonFonts {
  // Given
  UIFont *fakeTitleFont = [UIFont systemFontOfSize:55];
  self.alert.titleFont = fakeTitleFont;
  MDCAlertAction *fakeAction = [MDCAlertAction actionWithTitle:@"Foo"
                                                       handler:^(MDCAlertAction *action){
                                                       }];
  MDCAlertAction *fakeAction2 = [MDCAlertAction actionWithTitle:@"Bar"
                                                        handler:^(MDCAlertAction *action){
                                                        }];
  UIFont *fakeButtonFont = [UIFont systemFontOfSize:45];

  // When
  [self.alert addAction:fakeAction];
  [[self.alert buttonForAction:fakeAction] setTitleFont:fakeButtonFont
                                               forState:UIControlStateNormal];
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;
  [self.alert addAction:fakeAction2];
  [[self.alert buttonForAction:fakeAction2] setTitleFont:fakeButtonFont
                                                forState:UIControlStateNormal];

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is equal to %@",
                 view.titleLabel.font, fakeTitleFont);
  MDCButton *button = [self.alert buttonForAction:fakeAction];
  XCTAssertFalse([[button titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:fakeButtonFont],
                 @"%@ is equal to %@", [button titleFontForState:UIControlStateNormal],
                 fakeButtonFont);
  MDCButton *button2 = [self.alert buttonForAction:fakeAction2];
  XCTAssertFalse(
      [[button2 titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:fakeButtonFont],
      @"%@ is equal to %@", [button2 titleFontForState:UIControlStateNormal], fakeButtonFont);
}

/** Verifies that buttons respond to dynamic type if it uses both the to be deprecated setTitleFont
 * forState when enableTitleFontForState is YES and titlelabel.font to set the button font when
 * enableTitleFontForState is NO */
- (void)testDynamicTypeEnabledUpdatesButtonFontsLegacyAndNewButtonFontSettings {
  // Given
  UIFont *fakeTitleFont = [UIFont systemFontOfSize:55];
  self.alert.titleFont = fakeTitleFont;
  MDCAlertAction *fakeAction = [MDCAlertAction actionWithTitle:@"Foo"
                                                       handler:^(MDCAlertAction *action){
                                                       }];
  MDCAlertAction *fakeAction2 = [MDCAlertAction actionWithTitle:@"Bar"
                                                        handler:^(MDCAlertAction *action){
                                                        }];

  // When
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;
  UIFont *fakeButtonFont = [UIFont systemFontOfSize:45];
  [self.alert addAction:fakeAction];
  [self.alert addAction:fakeAction2];

  MDCButton *fakeActionButton = [self.alert buttonForAction:fakeAction];
  fakeActionButton.enableTitleFontForState = YES;
  [fakeActionButton setTitleFont:fakeButtonFont forState:UIControlStateNormal];
  MDCButton *fakeActionButton2 = [self.alert buttonForAction:fakeAction2];
  fakeActionButton2.enableTitleFontForState = NO;
  fakeActionButton2.titleLabel.font = fakeButtonFont;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is equal to %@",
                 view.titleLabel.font, fakeTitleFont);
  MDCButton *button = [self.alert buttonForAction:fakeAction];
  XCTAssertFalse([[button titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:fakeButtonFont],
                 @"%@ is equal to %@", [button titleFontForState:UIControlStateNormal],
                 fakeButtonFont);
  MDCButton *button2 = [self.alert buttonForAction:fakeAction2];
  XCTAssertFalse(
      [[button2 titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:fakeButtonFont],
      @"%@ is equal to %@", [button2 titleFontForState:UIControlStateNormal], fakeButtonFont);
}

/**
 Verifies that assigning non-MDCFontScaler fonts results in their being replaced for Material
 scaling.
 */
// TODO(https://github.com/material-components/material-components-ios/issues/8673): Re-enable
- (void)testMDCAdjustsFontForContentSizeCategoryScalesCustomNonFontScalerFont {
  // Given
  UIFont *baseFont = [UIFont fontWithName:@"Zapfino" size:1];

  MDCAlertAction *action = [MDCAlertAction actionWithTitle:@"Foo" handler:nil];
  [self.alert addAction:action];

  self.alert.titleFont = baseFont;
  self.alert.messageFont = baseFont;
  MDCButton *actionButton = [self.alert buttonForAction:action];
  if (actionButton.enableTitleFontForState) {
    [actionButton setTitleFont:baseFont forState:UIControlStateNormal];
  } else {
    actionButton.titleLabel.font = baseFont;
  }

  // When
  [self.alert loadViewIfNeeded];
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  XCTAssertEqualObjects(self.alert.alertView.messageTextView.font.fontName, baseFont.fontName);
  XCTAssertGreaterThan(self.alert.alertView.messageTextView.font.pointSize, baseFont.pointSize);
  XCTAssertEqualObjects(self.alert.alertView.titleLabel.font.fontName, baseFont.fontName);
  XCTAssertGreaterThan(self.alert.alertView.titleLabel.font.pointSize, baseFont.pointSize);
  if (actionButton.enableTitleFontForState) {
    XCTAssertEqualObjects([actionButton titleFontForState:UIControlStateNormal].fontName,
                          baseFont.fontName);
    XCTAssertGreaterThan([actionButton titleFontForState:UIControlStateNormal].pointSize,
                         baseFont.pointSize);
  } else {
    XCTAssertNotEqualObjects(actionButton.titleLabel.font.fontName, baseFont.fontName);
    XCTAssertGreaterThan(actionButton.titleLabel.font.pointSize, baseFont.pointSize);
  }
}

/** Verifies that assigning MDCFontScaler fonts results in their being used for Material scaling. */
// TODO(https://github.com/material-components/material-components-ios/issues/8673): Re-enable
- (void)testMDCAdjustsFontForContentSizeCategoryUsesFontScalerFonts {
  // Given
  UIFont *scaledFont = [UIFont fontWithName:@"Zapfino" size:16];
  scaledFont.mdc_scalingCurve = CustomScalingCurve();

  MDCAlertAction *action = [MDCAlertAction actionWithTitle:@"Foo" handler:nil];
  [self.alert addAction:action];

  self.alert.titleFont = scaledFont;
  self.alert.messageFont = scaledFont;
  MDCButton *actionButton = [self.alert buttonForAction:action];
  if (actionButton.enableTitleFontForState) {
    [actionButton setTitleFont:scaledFont forState:UIControlStateNormal];
  } else {
    actionButton.titleLabel.font = scaledFont;
  }

  // When
  [self.alert loadViewIfNeeded];
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  XCTAssertEqualObjects(self.alert.alertView.messageTextView.font.fontName, scaledFont.fontName);
  XCTAssertEqualObjects(self.alert.alertView.titleLabel.font.fontName, scaledFont.fontName);
  if (actionButton.enableTitleFontForState) {
    XCTAssertEqualObjects([actionButton titleFontForState:UIControlStateNormal].fontName,
                          scaledFont.fontName);
  } else {
    XCTAssertNotEqualObjects(actionButton.titleLabel.font.fontName, scaledFont.fontName);
  }
}

/**
 Verifies that MDCFontScaler fonts get scaled to greater point sizes for size categories greater
 than @c UIContentSizeCategoryLarge.
 */
- (void)testMDCAdjustsFontForContentSizeCategoryUpscalesFontScalerFontsWithLocalTraitCollection {
  // Given
  MDCAlertControllerTestsControllerFake *alert =
      [[MDCAlertControllerTestsControllerFake alloc] init];
  alert.title = @"Title";
  alert.message = @"A message.";
  alert.traitCollectionOverride =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                             UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];

  UIFont *scaledFont = [UIFont fontWithName:@"Zapfino" size:16];
  scaledFont.mdc_scalingCurve = CustomScalingCurve();
  scaledFont = [scaledFont mdc_scaledFontAtDefaultSize];

  MDCAlertAction *action = [MDCAlertAction actionWithTitle:@"Foo" handler:nil];
  [alert addAction:action];

  alert.titleFont = scaledFont;
  alert.messageFont = scaledFont;
  MDCButton *actionButton = [alert buttonForAction:action];
  if (actionButton.enableTitleFontForState) {
    [actionButton setTitleFont:scaledFont forState:UIControlStateNormal];
  } else {
    actionButton.titleLabel.font = scaledFont;
  }

  // When
  [alert loadViewIfNeeded];
  alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
  alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  CGFloat expectedPointSize =
      (CGFloat)CustomScalingCurve()[UIContentSizeCategoryAccessibilityExtraExtraExtraLarge]
          .doubleValue;
  // TODO(https://github.com/material-components/material-components-ios/issues/8671): Assert that
  // these are equal.
  XCTAssertNotEqualWithAccuracy(alert.alertView.messageTextView.font.pointSize, expectedPointSize,
                                0.001);
  // TODO(https://github.com/material-components/material-components-ios/issues/8672): Assert that
  // these are equal
  XCTAssertNotEqualWithAccuracy(alert.alertView.titleLabel.font.pointSize, expectedPointSize,
                                0.001);
  // TODO(https://github.com/material-components/material-components-ios/issues/8673): Assert that
  // these are equal
  if (actionButton.enableTitleFontForState) {
    XCTAssertNotEqualWithAccuracy([actionButton titleFontForState:UIControlStateNormal].pointSize,
                                  expectedPointSize, 0.001);
  } else {
    XCTAssertNotEqualWithAccuracy(actionButton.titleLabel.font.pointSize, scaledFont.pointSize,
                                  0.001);
  }
}

/**
Verifies that MDCFontScaler fonts get scaled to lesser point sizes for size categories greater
than @c UIContentSizeCategoryLarge.
*/
- (void)testMDCAdjustsFontForContentSizeCategoryDownscalesFontScalerFontsWithLocalTraitCollection {
  // Given
  MDCAlertControllerTestsControllerFake *alert =
      [[MDCAlertControllerTestsControllerFake alloc] init];
  alert.title = @"Title";
  alert.message = @"A message.";
  alert.traitCollectionOverride = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];

  UIFont *scaledFont = [UIFont fontWithName:@"Zapfino" size:16];
  scaledFont.mdc_scalingCurve = CustomScalingCurve();
  scaledFont = [scaledFont mdc_scaledFontAtDefaultSize];

  MDCAlertAction *action = [MDCAlertAction actionWithTitle:@"Foo" handler:nil];
  [alert addAction:action];

  alert.titleFont = scaledFont;
  alert.messageFont = scaledFont;
  MDCButton *actionButton = [alert buttonForAction:action];
  if (actionButton.enableTitleFontForState) {
    [actionButton setTitleFont:scaledFont forState:UIControlStateNormal];
  } else {
    actionButton.titleLabel.font = scaledFont;
  }

  // When
  [alert loadViewIfNeeded];
  alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
  alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  CGFloat expectedPointSize =
      (CGFloat)CustomScalingCurve()[UIContentSizeCategoryExtraSmall].doubleValue;
  // TODO(https://github.com/material-components/material-components-ios/issues/8671): Assert that
  // these are equal.
  XCTAssertNotEqualWithAccuracy(alert.alertView.messageTextView.font.pointSize, expectedPointSize,
                                0.001);
  // TODO(https://github.com/material-components/material-components-ios/issues/8672): Assert that
  // these are equal
  XCTAssertNotEqualWithAccuracy(alert.alertView.titleLabel.font.pointSize, expectedPointSize,
                                0.001);
  // TODO(https://github.com/material-components/material-components-ios/issues/8673): Assert that
  // these are equal
  if (actionButton.enableTitleFontForState) {
    XCTAssertNotEqualWithAccuracy([actionButton titleFontForState:UIControlStateNormal].pointSize,
                                  expectedPointSize, 0.001);
  } else {
    XCTAssertNotEqualWithAccuracy(actionButton.titleLabel.font.pointSize, expectedPointSize, 0.001);
  }
}

/**
 Tests that setting a UIFontMetrics-based font will be updated based on changes to the
 @c prefrredContentSizeCategory of the view's @c traitCollection.
 */
- (void)testAdjustsFontForContentSizeCategoryUpdatesFontWhenTraitCollectionChanges {
  if (@available(iOS 11.0, *)) {
    // Given
    MDCAlertControllerTestsControllerFake *alert =
        [[MDCAlertControllerTestsControllerFake alloc] init];
    alert.title = @"Title";
    alert.message = @"Message";
    [alert addAction:[MDCAlertAction actionWithTitle:@"Action 1" handler:nil]];

    // Prepare the Dynamic Type environment
    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    UITraitCollection *extraSmallTraits = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
    UIFont *originalFont = [UIFont fontWithName:@"Zapfino" size:20];
    originalFont = [bodyMetrics scaledFontForFont:originalFont
                    compatibleWithTraitCollection:extraSmallTraits];
    alert.adjustsFontForContentSizeCategory = YES;
    alert.titleFont = originalFont;
    [alert loadViewIfNeeded];
    MDCAlertControllerTestsFakeWindow *window = [[MDCAlertControllerTestsFakeWindow alloc] init];
    window.traitCollectionOverride =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                               UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    [window addSubview:alert.view];

    // When
    // Triggers UIFontMetrics-based fonts to resize within UILabel.
    [alert.view layoutIfNeeded];

    // Then
    XCTAssertEqualObjects(alert.alertView.titleLabel.font.fontName, originalFont.fontName);
    XCTAssertGreaterThan(alert.alertView.titleLabel.font.pointSize, originalFont.pointSize);
  }
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

- (void)testForwardsAnimationPropertiesToTransitionDelegate {
  // Given
  MDCAlertController *alertController = [[MDCAlertController alloc] init];
  MDCDialogTransitionController *transitionController =
      (MDCDialogTransitionController *)alertController.transitioningDelegate;

  // When
  alertController.presentationInitialScaleFactor = 7.0;
  alertController.presentationScaleAnimationDuration = 8.0;
  alertController.presentationOpacityAnimationDuration = 9.0;

  // Then
  XCTAssertEqualWithAccuracy(7.0, transitionController.dialogInitialScaleFactor, 0.0001);
  XCTAssertEqualWithAccuracy(8.0, transitionController.scaleAnimationDuration, 0.0001);
  XCTAssertEqualWithAccuracy(9.0, transitionController.opacityAnimationDuration, 0.0001);
}

#pragma mark - MaterialElevation

- (void)testDefaultBaseElevationOverrideIsNegative {
  // Given
  MDCAlertController *controller = [[MDCAlertController alloc] init];
  (void)controller;

  // Then
  XCTAssertLessThan(controller.mdc_overrideBaseElevation, 0);
}

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

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValue {
  // Given
  MDCAlertController *alertController = [[MDCAlertController alloc] init];
  alertController.elevation = 5;
  __block BOOL blockCalled = NO;
  alertController.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  alertController.elevation = alertController.elevation + 1;

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValue {
  // Given
  MDCAlertController *alertController = [[MDCAlertController alloc] init];
  alertController.elevation = 5;
  __block BOOL blockCalled = NO;
  alertController.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  alertController.elevation = alertController.elevation;

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testPointerInteractionsOnAlertControllerWithActionIsAdded {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    // When
    [self.alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];

    // Then
    MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
    for (UIButton *button in view.actionManager.buttonsInActionOrder) {
      XCTAssertTrue(button.isPointerInteractionEnabled);
      XCTAssertEqual(button.interactions.count, 1);
    }
  }
#endif
}

/** Verifies that actions with the same title and emphasis are considered equal. */
- (void)testAlertActionsShouldBeEqualWithDifferentIdentities {
  NSString *actionTitle = @"same action";
  MDCActionEmphasis emphasis = MDCActionEmphasisLow;
  MDCAlertAction *action1 = [MDCAlertAction actionWithTitle:actionTitle
                                                   emphasis:emphasis
                                                    handler:nil];
  MDCAlertAction *action2 = [MDCAlertAction actionWithTitle:actionTitle
                                                   emphasis:emphasis
                                                    handler:nil];

  // Ensuring the two are equal in value.
  XCTAssertEqualObjects(action1, action2);

  // Ensuring the two do indeed have different identities.
  XCTAssertNotEqual(action1, action2);
}

/** Verifies that actions with different titles are considered different. */
- (void)testAlertActionsShouldBeNotEqualWithDifferentTitles {
  MDCAlertAction *action1 = [MDCAlertAction actionWithTitle:@"action1" handler:nil];
  MDCAlertAction *action2 = [MDCAlertAction actionWithTitle:@"action2" handler:nil];

  // Ensuring the two are not considered as equal.
  XCTAssertNotEqualObjects(action1, action2);
}

/** Verifies that actions with the same title but different emphases are considered different. */
- (void)testAlertActionsShouldBeNotEqualWithDifferentEmphases {
  NSString *actionTitle = @"same action";
  MDCAlertAction *action1 = [MDCAlertAction actionWithTitle:actionTitle
                                                   emphasis:MDCActionEmphasisLow
                                                    handler:nil];
  MDCAlertAction *action2 = [MDCAlertAction actionWithTitle:actionTitle
                                                   emphasis:MDCActionEmphasisHigh
                                                    handler:nil];

  // Ensuring the two are not considered as equal.
  XCTAssertNotEqualObjects(action1, action2);
}

/** Verifies that an action can be correctly copied. */
- (void)testAlertActionCopiesShouldBeDifferentInIdentity {
  NSString *actionTitle = @"action";
  MDCAlertAction *action = [MDCAlertAction actionWithTitle:actionTitle handler:nil];
  MDCAlertAction *clonedAction = [action copy];

  // Ensuring the two are equal in value.
  XCTAssertEqualObjects(clonedAction, action);

  // Ensuring the two do indeed have different identities.
  XCTAssertNotEqual(clonedAction, action);
}

@end
