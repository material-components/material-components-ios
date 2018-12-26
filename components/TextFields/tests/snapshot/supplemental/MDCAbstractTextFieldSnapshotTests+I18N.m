// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import <MDFInternationalization/MDFInternationalization.h>
#import <UIKit/UIKit.h>

#import "MDCAbstractTextFieldSnapshotTests+I18N.h"
#import "MDCTextFieldSnapshotTestsStrings.h"

@implementation MDCAbstractTextFieldSnapshotTests (I18N)

- (void)MDCForceTextInputRightToLeft:(UIView *)view {
  if ([view conformsToProtocol:@protocol(UITextInput)]) {
    id<UITextInput> textInput = (id<UITextInput>)view;
    UITextRange *textRange = [textInput textRangeFromPosition:textInput.beginningOfDocument
                                                   toPosition:textInput.endOfDocument];
    if (textRange) {
      [textInput setBaseWritingDirection:UITextWritingDirectionRightToLeft forRange:textRange];
    } else {
      XCTAssertNotNil(textRange);
    }
  }
  for (UIView *subview in view.subviews) {
    [self MDCForceTextInputRightToLeft:subview];
  }
}

- (void)MDCForceViewLayoutRightToLeft:(UIView *)view NS_AVAILABLE_IOS(9.0) {
  // Setting semanticContentAttribute results in a call to effectiveUserInterfaceLayoutDirection, so
  // make sure we set it first.
  [self.textField
      MDCtest_setEffectiveUserInterfaceLayoutDirection:UIUserInterfaceLayoutDirectionRightToLeft];

  view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  for (UIView *subview in view.subviews) {
    [self MDCForceViewLayoutRightToLeft:subview];
  }
}

- (void)changeStringsToArabic {
  self.shortInputText = MDCTextFieldSnapshotTestsInputShortTextArabic;
  self.longInputText = MDCTextFieldSnapshotTestsInputLongTextArabic;
  self.shortPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextArabic;
  self.longPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextArabic;
  self.shortHelperText = MDCTextFieldSnapshotTestsHelperShortTextArabic;
  self.longHelperText = MDCTextFieldSnapshotTestsHelperLongTextArabic;
  self.shortErrorText = MDCTextFieldSnapshotTestsErrorShortTextArabic;
  self.longErrorText = MDCTextFieldSnapshotTestsErrorLongTextArabic;
}

- (void)changeLayoutToRTL {
  [self MDCForceTextInputRightToLeft:self.textField];
  [self MDCForceViewLayoutRightToLeft:self.textField];
}

@end
