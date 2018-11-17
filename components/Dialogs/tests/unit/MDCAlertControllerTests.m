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

#import "../../src/private/MDCDialogShadowedView.h"
#import "MDCAlertControllerView+Private.h"

#pragma mark - Subclasses for testing

static NSString *const MDCAlertControllerSubclassValueKey = @"MDCAlertControllerSubclassValueKey";

@interface MDCAlertController (Testing)
@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;
@end

@interface MDCAlertControllerSubclass : MDCAlertController
@property(nonatomic, assign) NSInteger value;
@end

@interface MDCDialogPresentationController (Testing)
@property(nonatomic) MDCDialogShadowedView *trackingView;
@end

@implementation MDCAlertControllerSubclass

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _value = [aDecoder decodeIntegerForKey:MDCAlertControllerSubclassValueKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:self.value forKey:MDCAlertControllerSubclassValueKey];
}

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
}

- (void)testAlertControllerWithTitleMessage {
  // Then
  XCTAssertNotNil(self.alert.actions);
  XCTAssertEqualObjects(self.alert.title, @"title");
  XCTAssertEqualObjects(self.alert.message, @"message");
}

- (void)testSubclassEncodingFails {
  // Given
  MDCAlertControllerSubclass *subclass = [[MDCAlertControllerSubclass alloc] init];
  subclass.value = 7;
  subclass.title = @"title";
  subclass.message = @"message";
  subclass.modalInPopover = YES;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:subclass];
  MDCAlertControllerSubclass *unarchivedSubclass =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];

  // Then
  XCTAssertEqual(unarchivedSubclass.value, subclass.value);
  XCTAssertNil(unarchivedSubclass.title);
  XCTAssertNil(unarchivedSubclass.message);
  XCTAssertEqual(unarchivedSubclass.isModalInPopover, NO);
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
  XCTAssertEqual(view.titleLabel.font, testFont);
  XCTAssertEqual(view.messageLabel.font, testFont);
  for (UIButton *button in view.actionManager.buttonsInActionOrder) {
    XCTAssertEqual(button.titleLabel.font, testFont);
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

@end
