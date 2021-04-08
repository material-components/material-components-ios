// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MDCTextControlState.h"
#import "MaterialTextControls+OutlinedTextAreas.h"

@interface MDCOutlinedTextAreaTests : XCTestCase
@end

@implementation MDCOutlinedTextAreaTests

#pragma mark Tests

- (void)testOutlineColorDefaults {
  // Given
  MDCOutlinedTextArea *textArea = [[MDCOutlinedTextArea alloc] init];
  UIColor *defaultOutlineColor = UIColor.blackColor;
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    defaultOutlineColor = UIColor.labelColor;
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

  // Then
  XCTAssertEqualObjects(defaultOutlineColor,
                        [textArea outlineColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(defaultOutlineColor,
                        [textArea outlineColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects([defaultOutlineColor colorWithAlphaComponent:(CGFloat)0.60],
                        [textArea outlineColorForState:MDCTextControlStateDisabled]);
}

- (void)testOutlineColorAccessors {
  // Given
  MDCOutlinedTextArea *textArea = [[MDCOutlinedTextArea alloc] init];
  UIColor *outlineColorNormal = UIColor.blueColor;
  UIColor *outlineColorEditing = UIColor.greenColor;
  UIColor *outlineColorDisabled = UIColor.purpleColor;

  // When
  [textArea setOutlineColor:outlineColorNormal forState:MDCTextControlStateNormal];
  [textArea setOutlineColor:outlineColorEditing forState:MDCTextControlStateEditing];
  [textArea setOutlineColor:outlineColorDisabled forState:MDCTextControlStateDisabled];
  // Then
  XCTAssertEqualObjects(outlineColorNormal,
                        [textArea outlineColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(outlineColorEditing,
                        [textArea outlineColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(outlineColorDisabled,
                        [textArea outlineColorForState:MDCTextControlStateDisabled]);
}

@end
