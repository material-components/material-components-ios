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

#import "MaterialSnapshot.h"

#import <UIKit/UIKit.h>

#import "MaterialTextFields+ContainedInputView.h"

@interface MDCBaseTextFieldTestsSnapshotTests : MDCSnapshotTestCase
@end

static const NSTimeInterval kTextFieldValidationAnimationDuration = 1.0;
static const NSTimeInterval kTextFieldValidationAnimationTimeout = 1.5;

@implementation MDCBaseTextFieldTestsSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //    self.recordMode = YES;
}

- (void)tearDown {
  [super tearDown];
}

- (UIView *)createBlueSideView {
  return [self createSideViewWithColor:[UIColor blueColor]];
}

- (UIView *)createRedSideView {
  return [self createSideViewWithColor:[UIColor redColor]];
}

- (UIView *)createSideViewWithColor:(UIColor *)color {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  view.backgroundColor = color;
  return view;
}

- (MDCBaseTextField *)createBaseTextFieldInKeyWindow {
  MDCBaseTextField *textField = [self createBaseTextField];
  UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
  [keyWindow addSubview:textField];
  return textField;
}

- (MDCBaseTextField *)createBaseTextField {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
  textField.borderStyle = UITextBorderStyleRoundedRect;
  return textField;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)validateTextField:(MDCBaseTextField *)textField {
  XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"death"];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                               (int64_t)(kTextFieldValidationAnimationDuration * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   // We take a snapshot of the textfield so we don't have to remove it from the app
                   // host's key window. Removing the textfield from the app host's key window
                   // before validation can affect the textfield's editing behavior, which has a
                   // large effect on the appearance of the textfield.
                   UIView *textFieldSnapshot = [textField snapshotViewAfterScreenUpdates:YES];
                   [self generateSnapshotAndVerifyForView:textFieldSnapshot];
                   [expectation fulfill];
                 });
  [self waitForExpectations:@[ expectation ] timeout:kTextFieldValidationAnimationTimeout];
}

#pragma mark - Tests

- (void)testTextFieldWithText {
  // Given
  MDCBaseTextField *textField = [self createBaseTextField];

  // When
  textField.text = @"Text";

  // Then
  [self generateSnapshotAndVerifyForView:textField];
}

- (void)testTextFieldWithLeadingView {
  // Given
  MDCBaseTextField *textField = [self createBaseTextField];

  // When
  textField.text = @"Text";
  textField.leadingView = [self createRedSideView];
  textField.leadingViewMode = UITextFieldViewModeAlways;

  // Then
  [self generateSnapshotAndVerifyForView:textField];
}

- (void)testTextFieldWithTrailingView {
  // Given
  MDCBaseTextField *textField = [self createBaseTextField];

  // When
  textField.text = @"Text";
  textField.trailingView = [self createBlueSideView];
  textField.trailingViewMode = UITextFieldViewModeAlways;

  // Then
  [self generateSnapshotAndVerifyForView:textField];
}

- (void)testTextFieldWithLeadingViewAndTrailingView {
  // Given
  MDCBaseTextField *textField = [self createBaseTextField];

  // When
  textField.text = @"Text";
  textField.leadingView = [self createBlueSideView];
  textField.trailingView = [self createRedSideView];
  textField.trailingViewMode = UITextFieldViewModeAlways;
  textField.leadingViewMode = UITextFieldViewModeAlways;

  // Then
  [self generateSnapshotAndVerifyForView:textField];
}

- (void)testEditingTextFieldWithLeadingViewWhileEditing {
  // Given
  MDCBaseTextField *textField = [self createBaseTextFieldInKeyWindow];

  // When
  textField.leadingView = [self createBlueSideView];
  textField.leadingViewMode = UITextFieldViewModeWhileEditing;
  textField.text = @"Text2";
  [textField becomeFirstResponder];

  [self validateTextField:textField];
}

- (void)testNonEditingTextFieldWithLeadingViewWhileEditing {
  // Given
  MDCBaseTextField *textField = [self createBaseTextFieldInKeyWindow];

  // When
  textField.text = @"Text";
  textField.leadingView = [self createBlueSideView];
  textField.leadingViewMode = UITextFieldViewModeWhileEditing;

  // Then
  [self validateTextField:textField];
}

@end
