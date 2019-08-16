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

#import <XCTest/XCTest.h>

#import "MaterialTextFields+ContainedInputView.h"

@interface MDCBaseTextField (Testing)
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;
- (CGRect)adjustTextAreaFrame:(CGRect)textRect
 withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame;
@end

@interface MDCBaseTextFieldTests : XCTestCase
@end

@implementation MDCBaseTextFieldTests

- (UIView *)createSideView {
  UIView *sideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  sideView.backgroundColor = [UIColor blueColor];
  return sideView;
}

- (void)testLeadingViewLTR {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  UIView *sideView = [self createSideView];
  textField.leadingView = sideView;
  XCTAssertTrue(textField.leftView == textField.leadingView,
                @"The leading view should be the left view.");
}

- (void)testLeadingViewRTL {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  UIView *sideView = [self createSideView];
  textField.leadingView = sideView;
  XCTAssertTrue(textField.rightView == textField.leadingView,
                @"The leading view should be the right view.");
}

- (void)testTrailingViewLTR {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  UIView *sideView = [self createSideView];
  textField.trailingView = sideView;
  XCTAssertTrue(textField.rightView == textField.trailingView,
                @"The trailing view should be the right view.");
}

- (void)testTrailingViewRTL {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  UIView *sideView = [self createSideView];
  textField.trailingView = sideView;
  XCTAssertTrue(textField.leftView == textField.trailingView,
                @"The trailing view should be the left view.");
}

- (void)testLeadingViewModeLTR {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  textField.leadingViewMode = UITextFieldViewModeAlways;
  XCTAssertTrue(textField.leftViewMode == textField.leadingViewMode,
                @"The leading view mode should be equal to the left view mode.");
}

- (void)testLeadingViewModeRTL {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  textField.leadingViewMode = UITextFieldViewModeAlways;
  XCTAssertTrue(textField.rightViewMode == textField.leadingViewMode,
                @"The leading view mode should be equal to the right view mode.");
}

- (void)testTrailingViewModeLTR {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  textField.trailingViewMode = UITextFieldViewModeAlways;
  XCTAssertTrue(textField.rightView == textField.trailingView,
                @"The trailing view mode should be equal to the right view mode.");
}

- (void)testTrailingViewModeRTL {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  textField.trailingViewMode = UITextFieldViewModeAlways;
  XCTAssertTrue(textField.leftViewMode == textField.trailingViewMode,
                @"The trailing view mode should be equal to left view mode.");
}

- (void)testAdjustTextAreaFrameWithParentClassTextAreaFrame {
  CGRect textAreaFrame = CGRectMake(30, 50, 120, 20);
  CGRect parentClassTextAreaFrame = CGRectMake(20, 30, 120, 50);
  CGRect correctFinalTextAreaFrame = CGRectMake(30, 35, 120, 50);
  CGRect finalTextAreaFrame =
  [[[MDCBaseTextField alloc] init] adjustTextAreaFrame:textAreaFrame
                          withParentClassTextAreaFrame:parentClassTextAreaFrame];
  XCTAssertEqualObjects(NSStringFromCGRect(correctFinalTextAreaFrame),
                        NSStringFromCGRect(finalTextAreaFrame));
}

@end
