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

@interface MDCAlertControllerTestsControllerFake : MDCAlertController
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCAlertControllerTestsControllerFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCAlertController (Testing)
@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;
@end

@interface MDCDialogPresentationController (Testing)
@property(nonatomic) MDCDialogShadowedView *trackingView;
@end

#pragma mark - Tests

@interface MDCAlertControllerTests : XCTestCase
@property(nonatomic, nullable) MDCAlertController *alert;
@end

@implementation MDCAlertControllerTests

- (void)setUp {
  [super setUp];

  self.alert = [MDCAlertController alertControllerWithTitle:@"title" message:@"message"];
}

- (void)tearDown {
  self.alert = nil;

  [super tearDown];
}

- (void)testInit {
  // Then
  XCTAssertNotNil(self.alert.actions);
  XCTAssertNotNil(self.alert.title);
  XCTAssertNotNil(self.alert.message);
  XCTAssertTrue(self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable);
  XCTAssertEqualObjects(self.alert.shadowColor, UIColor.blackColor);
}

- (void)testAlertControllerWithTitleMessage {
  // Then
  XCTAssertNotNil(self.alert.actions);
  XCTAssertEqualObjects(self.alert.title, @"title");
  XCTAssertEqualObjects(self.alert.message, @"message");
}

- (void)testAlertControllerTyphography {
  // Given
  UIFont *testFont = [UIFont boldSystemFontOfSize:30];

  // When
  self.alert.titleFont = testFont;
  self.alert.messageFont = testFont;
  self.alert.buttonFont = testFont;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertEqualObjects(view.titleLabel.font, testFont);
  XCTAssertEqualObjects(view.messageLabel.font, testFont);
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
  XCTAssertEqual(view.messageLabel.textColor, testColor);
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
  XCTAssertEqual(view.messageLabel.textColor, testColor);
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
  XCTAssertEqual(view.messageLabel.textColor, testColor);
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
  XCTAssertEqual(view.messageLabel.textColor, testColor);
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
  XCTAssertEqual(view.messageLabel.text, message);
}

- (void)testTheViewIsNotLoadedWhenPropertiesAreSet {
  UIColor *testColor = [UIColor redColor];
  self.alert.titleColor = testColor;
  self.alert.messageColor = testColor;
  self.alert.buttonTitleColor = testColor;
  self.alert.buttonInkColor = testColor;
  self.alert.titleFont = [UIFont systemFontOfSize:12];
  self.alert.messageFont = [UIFont systemFontOfSize:14];
  self.alert.buttonFont = [UIFont systemFontOfSize:10];
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
  self.alert.buttonFont = fakeButtonFont;
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is not equal to %@",
                view.titleLabel.font, fakeTitleFont);
  XCTAssertTrue([view.messageLabel.font mdc_isSimplyEqual:fakeMessageFont],
                @"%@ is not equal to %@", view.messageLabel.font, fakeMessageFont);
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
  self.alert.buttonFont = fakeButtonFont;
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;

  // When
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is equal to %@",
                 view.titleLabel.font, fakeTitleFont);
  XCTAssertFalse([view.messageLabel.font mdc_isSimplyEqual:fakeMessageFont], @"%@ is equal to %@",
                 view.messageLabel.font, fakeMessageFont);
  MDCButton *button = [self.alert buttonForAction:fakeAction];
  XCTAssertFalse([[button titleFontForState:UIControlStateNormal] mdc_isSimplyEqual:fakeButtonFont],
                 @"%@ is equal to %@", [button titleFontForState:UIControlStateNormal],
                 fakeButtonFont);
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
  XCTAssertEqualObjects(self.alert.alertView.messageLabel.font.fontName, baseFont.fontName);
  XCTAssertGreaterThan(self.alert.alertView.messageLabel.font.pointSize, baseFont.pointSize);
  XCTAssertEqualObjects(self.alert.alertView.titleLabel.font.fontName, baseFont.fontName);
  XCTAssertGreaterThan(self.alert.alertView.titleLabel.font.pointSize, baseFont.pointSize);
  // TODO(https://github.com/material-components/material-components-ios/issues/8673): Assert that
  // these are equal
  if (actionButton.enableTitleFontForState) {
    XCTAssertNotEqualObjects([actionButton titleFontForState:UIControlStateNormal].fontName,
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
  XCTAssertEqualObjects(self.alert.alertView.messageLabel.font.fontName, scaledFont.fontName);
  XCTAssertEqualObjects(self.alert.alertView.titleLabel.font.fontName, scaledFont.fontName);
  // TODO(https://github.com/material-components/material-components-ios/issues/8673): Assert that
  // these are equal
  if (actionButton.enableTitleFontForState) {
    XCTAssertNotEqualObjects([actionButton titleFontForState:UIControlStateNormal].fontName,
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
  if (@available(iOS 10.0, *)) {
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
    XCTAssertNotEqualWithAccuracy(alert.alertView.messageLabel.font.pointSize, expectedPointSize,
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
}

/**
Verifies that MDCFontScaler fonts get scaled to lesser point sizes for size categories greater
than @c UIContentSizeCategoryLarge.
*/
- (void)testMDCAdjustsFontForContentSizeCategoryDownscalesFontScalerFontsWithLocalTraitCollection {
  if (@available(iOS 10.0, *)) {
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
    XCTAssertNotEqualWithAccuracy(alert.alertView.messageLabel.font.pointSize, expectedPointSize,
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
      XCTAssertNotEqualWithAccuracy(actionButton.titleLabel.font.pointSize, expectedPointSize,
                                    0.001);
    }
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
  alertController.mdc_elevationDidChangeBlock =
      ^(MDCAlertController *controller, CGFloat elevation) {
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
  alertController.mdc_elevationDidChangeBlock =
      ^(MDCAlertController *controller, CGFloat elevation) {
        blockCalled = YES;
      };

  // When
  alertController.elevation = alertController.elevation;

  // Then
  XCTAssertFalse(blockCalled);
}

@end
