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

#import <UIKit/UIKit.h>
#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCAbstractTextFieldSnapshotTests+I18N.h"
#import "MDCTextFieldSnapshotTestsStrings.h"

@implementation MDCAbstractTextFieldSnapshotTests (I18N)

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
  // Setting semanticContentAttribute results in a call to effectiveUserInterfaceLayoutDirection, so
  // make sure we set it first.
  [self.textField
      MDCtest_setEffectiveUserInterfaceLayoutDirection:UIUserInterfaceLayoutDirectionRightToLeft];
  
  // UISemanticContentAttribute was added in iOS SDK 9.0 but is available on devices running earlier
  // version of iOS. We ignore the partial-availability warning that gets thrown on our use of this
  // symbol.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
  self.textField.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
#pragma clang diagnostic pop
}

@end
