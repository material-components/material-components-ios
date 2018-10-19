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

@end

@implementation MDCAlertControllerTests

- (void)testInit {
  // Given
  MDCAlertController *alert = [[MDCAlertController alloc] init];

  // Then
  XCTAssertNotNil(alert.actions);
  XCTAssertNil(alert.title);
  XCTAssertNil(alert.message);
}

- (void)testAlertControllerWithTitleMessage {
  // Given
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];

  // Then
  XCTAssertNotNil(alert.actions);
  XCTAssertEqualObjects(alert.title, @"title");
  XCTAssertEqualObjects(alert.message, @"message");
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
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  UIFont *testFont = [UIFont boldSystemFontOfSize:30];
  alert.titleFont = testFont;
  alert.messageFont = testFont;
  alert.buttonFont = testFont;

  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
  XCTAssertEqual(view.titleLabel.font, testFont);
  XCTAssertEqual(view.messageLabel.font, testFont);
  for (UIButton *button in view.actionManager.buttonsInActionOrder) {
    XCTAssertEqual(button.titleLabel.font, testFont);
  }
}

- (void)testAlertControllerColorSetting {
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  UIColor *testColor = [UIColor redColor];
  alert.titleColor = testColor;
  alert.messageColor = testColor;
  alert.buttonTitleColor = testColor;
  alert.buttonInkColor = testColor;

  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
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
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  // When
  alert.titleColor = testColor;
  alert.messageColor = testColor;
  alert.buttonTitleColor = testColor;
  alert.buttonInkColor = testColor;

  [alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
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
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  // When
  [alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];

  alert.titleColor = testColor;
  alert.messageColor = testColor;
  alert.buttonTitleColor = testColor;
  alert.buttonInkColor = testColor;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
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
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  // When
  [alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];

  alert.titleColor = testColor;
  alert.messageColor = testColor;
  alert.buttonTitleColor = testColor;
  alert.buttonInkColor = testColor;

  [alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
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
  NSString *title = @"title";
  NSString *message = @"message";
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:title
                                                                   message:message];
  alert.titleFont = [UIFont systemFontOfSize:25];

  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
  XCTAssertEqual(view.titleLabel.text, title);
  XCTAssertEqual(view.messageLabel.text, message);
}

- (void)testTheViewIsNotLoadedWhenPropertiesAreSet {
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  UIColor *testColor = [UIColor redColor];
  alert.titleColor = testColor;
  alert.messageColor = testColor;
  alert.buttonTitleColor = testColor;
  alert.buttonInkColor = testColor;
  alert.titleFont = [UIFont systemFontOfSize:12];
  alert.messageFont = [UIFont systemFontOfSize:14];
  alert.buttonFont = [UIFont systemFontOfSize:10];
  [alert addAction:[MDCAlertAction actionWithTitle:@"test"
                                           handler:^(MDCAlertAction * _Nonnull action) {
                                           }]];
  XCTAssertFalse(alert.isViewLoaded);
}

- (void)testAccessibilityIdentifiersAppliesToAlertControllerViewButtons {
  // Given
  MDCAlertController *alertController = [MDCAlertController alertControllerWithTitle:@"Title"
                                                                             message:@"message"];
  MDCAlertAction *action1 = [MDCAlertAction actionWithTitle:@"button1" handler:nil];
  action1.accessibilityIdentifier = @"1";
  MDCAlertAction *action2 = [MDCAlertAction actionWithTitle:@"buttonA" handler:nil];
  action2.accessibilityIdentifier = @"A";

  // When
  [alertController addAction:action1];
  [alertController addAction:action2];
  
  // Force the view to load
  if (@available(iOS 9.0, *)) {
    [alertController loadViewIfNeeded];
  } else {
    (void)alertController.view;
  }

  // Then
  NSArray<UIButton *> *buttons = alertController.alertView.actionManager.buttonsInActionOrder;
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
  // Given
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
  XCTAssertEqualWithAccuracy(view.layer.cornerRadius, 0.0, 0.0);
  XCTAssertEqualWithAccuracy(alert.mdc_dialogPresentationController.dialogCornerRadius, 0.0, 0.0);
}

- (void)testCustomCornerRadius {
  // Given
  CGFloat cornerRadius = (CGFloat)36.0;
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action2" handler:nil]];

  // When
  alert.cornerRadius = cornerRadius;

  // Then
  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
  XCTAssertEqualWithAccuracy(view.layer.cornerRadius, cornerRadius, 0.0);
  XCTAssertEqualWithAccuracy(alert.mdc_dialogPresentationController.dialogCornerRadius,
                             cornerRadius, 0.0);
}

- (void)testDefaultElevation {
  // Given
  CGFloat elevation = (CGFloat)MDCShadowElevationDialog;
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];

  // Then
  MDCDialogShadowedView *shadowView = alert.mdc_dialogPresentationController.trackingView;
  XCTAssertEqual(shadowView.elevation, elevation);
}

- (void)testCustomElevation {
  // Given
  CGFloat elevation = (CGFloat)2.0;
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];

  // When
  alert.elevation = elevation;

  // Then
  MDCDialogShadowedView *shadowView = alert.mdc_dialogPresentationController.trackingView;
  XCTAssertEqual(shadowView.elevation, elevation);
}

- (void)testCustomDialogPresentationElevation {
  // Given
  CGFloat elevation = (CGFloat)2.0;
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  [alert addAction:[MDCAlertAction actionWithTitle:@"action1" handler:nil]];

  // When
  alert.mdc_dialogPresentationController.dialogElevation = elevation;

  // Then
  MDCDialogShadowedView *shadowView = alert.mdc_dialogPresentationController.trackingView;
  XCTAssertEqual(shadowView.elevation, elevation);
}

@end
