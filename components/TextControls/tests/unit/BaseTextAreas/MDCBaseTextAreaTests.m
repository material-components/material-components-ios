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

#import "MaterialTextControls+BaseTextAreas.h"
#import "MaterialTextControlsPrivate+BaseStyle.h"

@interface MDCBaseTextArea (Private)
- (BOOL)shouldLayoutForRTL;
@end

@interface MDCBaseTextAreaTests : XCTestCase
@end

@implementation MDCBaseTextAreaTests

- (void)testFloatingLabelColorAccessorsReturnCorrectValuesAfterBeingSet {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];
  UIColor *floatingLabelColorNormal = UIColor.blueColor;
  UIColor *floatingLabelColorEditing = UIColor.greenColor;
  UIColor *floatingLabelColorDisabled = UIColor.purpleColor;

  // When
  [textArea setFloatingLabelColor:floatingLabelColorNormal forState:MDCTextControlStateNormal];
  [textArea setFloatingLabelColor:floatingLabelColorEditing forState:MDCTextControlStateEditing];
  [textArea setFloatingLabelColor:floatingLabelColorDisabled forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(floatingLabelColorNormal,
                        [textArea floatingLabelColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(floatingLabelColorEditing,
                        [textArea floatingLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(floatingLabelColorDisabled,
                        [textArea floatingLabelColorForState:MDCTextControlStateDisabled]);
}

- (void)testNormalLabelColorAccessorsReturnCorrectValuesAfterBeingSet {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];
  UIColor *normalLabelColorNormal = UIColor.blueColor;
  UIColor *normalLabelColorEditing = UIColor.greenColor;
  UIColor *normalLabelColorDisabled = UIColor.purpleColor;

  // When
  [textArea setNormalLabelColor:normalLabelColorNormal forState:MDCTextControlStateNormal];
  [textArea setNormalLabelColor:normalLabelColorEditing forState:MDCTextControlStateEditing];
  [textArea setNormalLabelColor:normalLabelColorDisabled forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(normalLabelColorNormal,
                        [textArea normalLabelColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(normalLabelColorEditing,
                        [textArea normalLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(normalLabelColorDisabled,
                        [textArea normalLabelColorForState:MDCTextControlStateDisabled]);
}

- (void)testTextColorAccessorsReturnCorrectValuesAfterBeingSet {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];
  UIColor *textColorNormal = UIColor.blueColor;
  UIColor *textColorEditing = UIColor.greenColor;
  UIColor *textColorDisabled = UIColor.purpleColor;

  // When
  [textArea setTextColor:textColorNormal forState:MDCTextControlStateNormal];
  [textArea setTextColor:textColorEditing forState:MDCTextControlStateEditing];
  [textArea setTextColor:textColorDisabled forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(textColorNormal, [textArea textColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(textColorEditing, [textArea textColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(textColorDisabled,
                        [textArea textColorForState:MDCTextControlStateDisabled]);
}

- (void)testAssistiveLabelColorAccessorsReturnCorrectValuesAfterBeingSet {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];
  UIColor *leadingAssistiveLabelColorNormal = UIColor.blueColor;
  UIColor *leadingAssistiveLabelColorEditing = UIColor.greenColor;
  UIColor *leadingAssistiveLabelColorDisabled = UIColor.purpleColor;
  UIColor *trailingAssistiveLabelColorNormal = UIColor.brownColor;
  UIColor *trailingAssistiveLabelColorEditing = UIColor.magentaColor;
  UIColor *trailingAssistiveLabelColorDisabled = UIColor.yellowColor;

  // When
  [textArea setLeadingAssistiveLabelColor:leadingAssistiveLabelColorNormal
                                 forState:MDCTextControlStateNormal];
  [textArea setLeadingAssistiveLabelColor:leadingAssistiveLabelColorEditing
                                 forState:MDCTextControlStateEditing];
  [textArea setLeadingAssistiveLabelColor:leadingAssistiveLabelColorDisabled
                                 forState:MDCTextControlStateDisabled];
  [textArea setTrailingAssistiveLabelColor:trailingAssistiveLabelColorNormal
                                  forState:MDCTextControlStateNormal];
  [textArea setTrailingAssistiveLabelColor:trailingAssistiveLabelColorEditing
                                  forState:MDCTextControlStateEditing];
  [textArea setTrailingAssistiveLabelColor:trailingAssistiveLabelColorDisabled
                                  forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(leadingAssistiveLabelColorNormal,
                        [textArea leadingAssistiveLabelColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(leadingAssistiveLabelColorEditing,
                        [textArea leadingAssistiveLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(leadingAssistiveLabelColorDisabled,
                        [textArea leadingAssistiveLabelColorForState:MDCTextControlStateDisabled]);
  XCTAssertEqualObjects(trailingAssistiveLabelColorNormal,
                        [textArea trailingAssistiveLabelColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(trailingAssistiveLabelColorEditing,
                        [textArea trailingAssistiveLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(trailingAssistiveLabelColorDisabled,
                        [textArea trailingAssistiveLabelColorForState:MDCTextControlStateDisabled]);
}

- (void)testAdjustsFontForContentSizeCategory {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];

  // When
  textArea.adjustsFontForContentSizeCategory = YES;

  // Then
  XCTAssertTrue(textArea.adjustsFontForContentSizeCategory);
  XCTAssertTrue(textArea.leadingAssistiveLabel.adjustsFontForContentSizeCategory);
  XCTAssertTrue(textArea.trailingAssistiveLabel.adjustsFontForContentSizeCategory);
}

- (void)testIntrinsicContentInvalidationWhenWidthChanges {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 100, 100);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];
  CGSize intrinsicContentSizeBeforeWidthChange = textArea.intrinsicContentSize;

  // When
  textArea.frame = CGRectMake(0, 0, 90, 100);
  [textArea setNeedsLayout];
  [textArea layoutIfNeeded];

  // Then
  XCTAssertNotEqual(textArea.intrinsicContentSize.width,
                    intrinsicContentSizeBeforeWidthChange.width);
}

- (void)testIntrinsicContentInvalidationWhenCalculatedHeightChanges {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 100, 100);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];
  CGSize intrinsicContentSizeBeforeCalculatedHeightChange = textArea.intrinsicContentSize;

  // When
  textArea.textView.font = [UIFont systemFontOfSize:(CGFloat)30.0];
  [textArea setNeedsLayout];
  [textArea layoutIfNeeded];

  // Then
  XCTAssertNotEqual(textArea.intrinsicContentSize.height,
                    intrinsicContentSizeBeforeCalculatedHeightChange.height);
}

- (void)testShouldLayoutForRTLWhenForcingRTL {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 100, 100);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];

  // When
  textArea.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;

  // Then
  XCTAssertTrue(textArea.shouldLayoutForRTL);
}

- (void)testShouldLayoutForRTLWhenForcingLTR {
  // Given
  CGRect textAreaFrame = CGRectMake(0, 0, 100, 100);
  MDCBaseTextArea *textArea = [[MDCBaseTextArea alloc] initWithFrame:textAreaFrame];

  // When
  textArea.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;

  // Then
  XCTAssertFalse(textArea.shouldLayoutForRTL);
}

@end
