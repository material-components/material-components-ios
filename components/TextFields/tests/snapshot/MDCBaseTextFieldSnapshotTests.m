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

@implementation MDCBaseTextFieldTestsSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
      self.recordMode = YES;
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

- (MDCBaseTextField *)createBaseTextField {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
  textField.borderStyle = UITextBorderStyleRoundedRect;
  return textField;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
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
  MDCBaseTextField *textField = [self createBaseTextField];
  
  // When
  textField.leadingView = [self createBlueSideView];
  textField.leadingViewMode = UITextFieldViewModeWhileEditing;

  [self forceLayoutOfView:textField];
  BOOL didBecome = [textField becomeFirstResponder];

  textField.text = @"Text2";
  NSLog(@"didBecome: %@",@(didBecome));
  NSLog(@"isEditing: %@",@(textField.isEditing));
  NSLog(@"leftView.frame: %@",NSStringFromCGRect(textField.leadingView.frame));
  NSLog(@"leftView.hidden: %@",@(textField.leadingView.hidden));

  [self validateTextField:textField withSel:_cmd];
}

- (void)validateTextField:(UIView *)view withSel:(SEL)sel {
  XCTestExpectation *e = [[XCTestExpectation alloc] initWithDescription:@"death"];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   //                   NSLog(@"didBecome: %@",@(didBecome));
                   //                   NSLog(@"isEditing: %@",@(textField.isEditing));
                   //                   NSLog(@"leftView.frame: %@",NSStringFromCGRect(textField.leadingView.frame));
                   //                   NSLog(@"leftView.hidden: %@",@(textField.leadingView.hidden));
                   // Then
                   //                   [self forceLayoutOfView:textField];
                   UIView *vieww = [view snapshotViewAfterScreenUpdates:YES];
                   [self generateSnapshotAndVerifyForView:vieww];
                   [e fulfill];
                 });
  
  [self waitForExpectations:@[e] timeout:3];
}


- (void)testNonEditingTextFieldWithLeadingViewWhileEditing {
  // Given
  MDCBaseTextField *textField = [self createBaseTextField];
  
  // When
  textField.text = @"Text";
  textField.leadingView = [self createBlueSideView];
  textField.leadingViewMode = UITextFieldViewModeWhileEditing;
  [self forceLayoutOfView:textField];
  // Then
  [self generateSnapshotAndVerifyForView:textField];
}


- (void)drainMainRunLoop {
  XCTestExpectation *expectation = [self expectationWithDescription:@"draining the main run loop"];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  
  [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)forceLayoutOfView:(UIView *)view {
  UIWindow *window = [[UIApplication sharedApplication]keyWindow];// [[UIWindow alloc] initWithFrame:view.bounds];
//  NSLog(@"window: %@",window);
  [window addSubview:view];
  [window setNeedsLayout];
  [window layoutIfNeeded];
  // Allow animation blocks to issue through the main run loop. This may not be sufficient for all
  // animations, but it appears to correct and deflake the rendering of long placeholder text.
  [self drainMainRunLoop];
}


@end
