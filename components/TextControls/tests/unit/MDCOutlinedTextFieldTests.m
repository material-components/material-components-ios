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

#import "MaterialAvailability.h"
#import "MaterialTextControls+Enums.h"
#import "MaterialTextControls+OutlinedTextFields.h"

@interface MDCOutlinedTextFieldTests : XCTestCase
@end

@implementation MDCOutlinedTextFieldTests

#pragma mark Tests

- (void)testOutlineColorDefaults {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCOutlinedTextField *textField = [[MDCOutlinedTextField alloc] initWithFrame:textFieldFrame];
  UIColor *defaultOutlineColor = UIColor.blackColor;
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    defaultOutlineColor = UIColor.labelColor;
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

  // Then
  XCTAssertEqualObjects(defaultOutlineColor,
                        [textField outlineColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(defaultOutlineColor,
                        [textField outlineColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects([defaultOutlineColor colorWithAlphaComponent:(CGFloat)0.60],
                        [textField outlineColorForState:MDCTextControlStateDisabled]);
}

- (void)testOutlineColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCOutlinedTextField *textField = [[MDCOutlinedTextField alloc] initWithFrame:textFieldFrame];
  UIColor *outlineColorNormal = UIColor.blueColor;
  UIColor *outlineColorEditing = UIColor.greenColor;
  UIColor *outlineColorDisabled = UIColor.purpleColor;

  // When
  [textField setOutlineColor:outlineColorNormal forState:MDCTextControlStateNormal];
  [textField setOutlineColor:outlineColorEditing forState:MDCTextControlStateEditing];
  [textField setOutlineColor:outlineColorDisabled forState:MDCTextControlStateDisabled];
  // Then
  XCTAssertEqualObjects(outlineColorNormal,
                        [textField outlineColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(outlineColorEditing,
                        [textField outlineColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(outlineColorDisabled,
                        [textField outlineColorForState:MDCTextControlStateDisabled]);
}

@end
