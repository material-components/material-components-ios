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

#pragma mark - Public API

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

- (void)changeStringsToCyrillic {
  self.shortInputText = MDCTextFieldSnapshotTestsInputShortTextCyrillic;
  self.longInputText = MDCTextFieldSnapshotTestsInputLongTextCyrillic;
  self.shortPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextCyrillic;
  self.longPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextCyrillic;
  self.shortHelperText = MDCTextFieldSnapshotTestsHelperShortTextCyrillic;
  self.longHelperText = MDCTextFieldSnapshotTestsHelperLongTextCyrillic;
  self.shortErrorText = MDCTextFieldSnapshotTestsErrorShortTextCyrillic;
  self.longErrorText = MDCTextFieldSnapshotTestsErrorLongTextCyrillic;
}

- (void)changeStringsToHindi {
  self.shortInputText = MDCTextFieldSnapshotTestsInputShortTextHindi;
  self.longInputText = MDCTextFieldSnapshotTestsInputLongTextHindi;
  self.shortPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextHindi;
  self.longPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextHindi;
  self.shortHelperText = MDCTextFieldSnapshotTestsHelperShortTextHindi;
  self.longHelperText = MDCTextFieldSnapshotTestsHelperLongTextHindi;
  self.shortErrorText = MDCTextFieldSnapshotTestsErrorShortTextHindi;
  self.longErrorText = MDCTextFieldSnapshotTestsErrorLongTextHindi;
}

- (void)changeStringsToKorean {
  self.shortInputText = MDCTextFieldSnapshotTestsInputShortTextKorean;
  self.longInputText = MDCTextFieldSnapshotTestsInputLongTextKorean;
  self.shortPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderShortTextKorean;
  self.longPlaceholderText = MDCTextFieldSnapshotTestsPlaceholderLongTextKorean;
  self.shortHelperText = MDCTextFieldSnapshotTestsHelperShortTextKorean;
  self.longHelperText = MDCTextFieldSnapshotTestsHelperLongTextKorean;
  self.shortErrorText = MDCTextFieldSnapshotTestsErrorShortTextKorean;
  self.longErrorText = MDCTextFieldSnapshotTestsErrorLongTextKorean;
}

- (void)changeLayoutToRTL {
  [self changeViewToRTL:self.textField];
}

@end
