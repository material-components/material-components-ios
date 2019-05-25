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
#import "MDCAlertControllerView+Private.h"

#pragma mark - Subclasses for testing

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
  if (@available(iOS 9.0, *)) {
    [self.alert loadViewIfNeeded];
  } else {
    (void)self.alert.view;
  }

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
<<<<<<< HEAD
  UIFont *fakeMessageFont = [UIFont systemFontOfSize:50];
  self.alert.messageFont = fakeMessageFont;
<<<<<<< HEAD

  // When
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;
<<<<<<< HEAD
<<<<<<< HEAD

  // Then
=======
>>>>>>> Add tests
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
=======
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;

  // Then
>>>>>>> Test title font
=======

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
>>>>>>> clang
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@, is not equal to %@",
                view.titleLabel.font, fakeTitleFont);
}

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> Revert setter for adjust...whenUnavailable
- (void)testLegacyDynamicTypeDisabledThenDynamicTypeEnabledDoesNotUpdateFonts {
=======
/**
 Test legacy dynamic type has no impact on a @c MDCButton when @c
 adjustFontForContentSizeCategoryWhenScaledFontIsUnavailable is set to @c NO before setting @c
 mdc_adjustsFontForContentSizeCategory to @c YES that the font stays the same.
 */
- (void)testLegacyDynamicTypeDisabledThenDynamicTypeTurnedOn {
>>>>>>> Test title font
=======
=======
>>>>>>> Revert setter for adjust...whenUnavailable
- (void)testLegacyDynamicTypeDisabledThenDynamicTypeEnabledDoesNotUpdateFonts {
>>>>>>> Update test names and delete comments
  // Given
  UIFont *fakeTitleFont = [UIFont systemFontOfSize:55];
  self.alert.titleFont = fakeTitleFont;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
<<<<<<< HEAD
>>>>>>> Test title font
=======
>>>>>>> Test title font
=======
  //MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
>>>>>>> Fix broken test
=======
>>>>>>> Fix issue and improve test
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> clang'
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is not equal to %@",
                view.titleLabel.font, fakeTitleFont);
  XCTAssertTrue([view.messageLabel.font mdc_isSimplyEqual:fakeMessageFont],
                @"%@ is not equal to %@", view.messageLabel.font, fakeMessageFont);
}

- (void)testDynamicTypeEnabledAndLegacyEnabledUpdatesTheFonts {
  // Given
  UIFont *fakeTitleFont = [UIFont systemFontOfSize:55];
  self.alert.titleFont = fakeTitleFont;
  UIFont *fakeMessageFont = [UIFont systemFontOfSize:50];
  self.alert.messageFont = fakeMessageFont;
<<<<<<< HEAD
=======
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@, is not equal to %@",
=======
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is not equal to %@",
>>>>>>> Add tests
=======
=======
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
>>>>>>> Fix issue and improve test
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is not equal to %@",
>>>>>>> clean up test
=======
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is not equal to %@",
>>>>>>> clean up test
                view.titleLabel.font, fakeTitleFont);
  XCTAssertTrue([view.messageLabel.font mdc_isSimplyEqual:fakeMessageFont], @"%@ is not equal to %@", view.messageLabel.font, fakeMessageFont);
}

- (void)testDynamicTypeEnabledAndLegacyEnabledUpdatesTheFonts {
  // Given
  UIFont *fakeTitleFont = [UIFont systemFontOfSize:55];
  self.alert.titleFont = fakeTitleFont;
<<<<<<< HEAD
  UIFont *fakeMessageFont = [UIFont systemFontOfSize:50];
  self.alert.messageFont = fakeMessageFont;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
<<<<<<< HEAD
>>>>>>> Test title font
=======
>>>>>>> Fix issue and improve test
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
=======
>>>>>>> Add tests
=======
  XCTAssertTrue([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@, is not equal to %@",
                view.titleLabel.font, fakeTitleFont);
}

- (void)testDynamicTypeEnabledAndLegacyEnabledUpdatesTheFonts {
  // Given
  UIFont *fakeTitleFont = [UIFont systemFontOfSize:55];
  self.alert.titleFont = fakeTitleFont;
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  self.alert.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
>>>>>>> Test title font
=======
>>>>>>> Fix broken test

  // When
  self.alert.mdc_adjustsFontForContentSizeCategory = YES;

  // Then
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> Fix broken test
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is equal to %@",
                 view.titleLabel.font, fakeTitleFont);
  XCTAssertFalse([view.messageLabel.font mdc_isSimplyEqual:fakeMessageFont], @"%@ is equal to %@",
                 view.messageLabel.font, fakeMessageFont);
=======
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@, is equal to %@",
<<<<<<< HEAD
                view.titleLabel.font, fakeTitleFont);
>>>>>>> Test title font
=======
                 view.titleLabel.font, fakeTitleFont);
>>>>>>> clang
=======
=======
>>>>>>> clean up test
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is equal to %@",
                 view.titleLabel.font, fakeTitleFont);
    XCTAssertFalse([view.messageLabel.font mdc_isSimplyEqual:fakeMessageFont], @"%@ is equal to %@", view.messageLabel.font, fakeMessageFont);
>>>>>>> Add tests
=======
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@, is equal to %@",
<<<<<<< HEAD
                view.titleLabel.font, fakeTitleFont);
>>>>>>> Test title font
=======
=======
=======
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alert.view;
>>>>>>> Fix issue and improve test
  XCTAssertFalse([view.titleLabel.font mdc_isSimplyEqual:fakeTitleFont], @"%@ is equal to %@",
>>>>>>> clean up test
                 view.titleLabel.font, fakeTitleFont);
>>>>>>> clang
}

@end
