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

#import "MDCTextControlState.h"
#import "MaterialTextControls+FilledTextAreas.h"

@interface MDCFilledTextAreaTests : XCTestCase
@end

@implementation MDCFilledTextAreaTests

#pragma mark Tests

- (void)testFilledBackgroundColorAccessors {
  // Given
  MDCFilledTextArea *textArea = [[MDCFilledTextArea alloc] init];
  UIColor *filledBackgroundColorNormal = UIColor.blueColor;
  UIColor *filledBackgroundColorEditing = UIColor.greenColor;
  UIColor *filledBackgroundColorDisabled = UIColor.purpleColor;

  // When
  [textArea setFilledBackgroundColor:filledBackgroundColorNormal
                            forState:MDCTextControlStateNormal];
  [textArea setFilledBackgroundColor:filledBackgroundColorEditing
                            forState:MDCTextControlStateEditing];
  [textArea setFilledBackgroundColor:filledBackgroundColorDisabled
                            forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(filledBackgroundColorNormal,
                        [textArea filledBackgroundColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(filledBackgroundColorEditing,
                        [textArea filledBackgroundColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(filledBackgroundColorDisabled,
                        [textArea filledBackgroundColorForState:MDCTextControlStateDisabled]);
}

- (void)testUnderlineColorAccessors {
  // Given
  MDCFilledTextArea *textArea = [[MDCFilledTextArea alloc] init];
  UIColor *underlineColorNormal = UIColor.blueColor;
  UIColor *underlineColorEditing = UIColor.greenColor;
  UIColor *underlineColorDisabled = UIColor.purpleColor;

  // When
  [textArea setUnderlineColor:underlineColorNormal forState:MDCTextControlStateNormal];
  [textArea setUnderlineColor:underlineColorEditing forState:MDCTextControlStateEditing];
  [textArea setUnderlineColor:underlineColorDisabled forState:MDCTextControlStateDisabled];
  // Then
  XCTAssertEqualObjects(underlineColorNormal,
                        [textArea underlineColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(underlineColorEditing,
                        [textArea underlineColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(underlineColorDisabled,
                        [textArea underlineColorForState:MDCTextControlStateDisabled]);
}

@end
