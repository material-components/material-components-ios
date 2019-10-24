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

#import "supplemental/MDCAbstractTextFieldSnapshotTests.h"

#import "MaterialTextFields.h"
#import "supplemental/MDCTextFieldSnapshotTestsStrings.h"
#import "supplemental/SnapshotFakeMDCTextField.h"

@interface MDCTextFieldOutlinedControllerPreferredFontAXXXLSnapshotTestsFake
    : SnapshotFakeMDCTextField
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCTextFieldOutlinedControllerPreferredFontAXXXLSnapshotTestsFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCTextFieldOutlinedControllerPreferredFontAXXXLSnapshotTests
    : MDCAbstractTextFieldSnapshotTests <MDCTextFieldSnapshotTestCaseHooking>

@end

@implementation MDCTextFieldOutlinedControllerPreferredFontAXXXLSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate the golden images for all test methods. Add it to a test method to
  // update only that golden image.
  //  self.recordMode = YES;

  // Skip empty tests since this is only testing Dynamic Type.
  self.shouldExecuteEmptyTests = NO;

  if (@available(iOS 11.0, *)) {
    MDCTextFieldOutlinedControllerPreferredFontAXXXLSnapshotTestsFake *fakeTextField =
        [[MDCTextFieldOutlinedControllerPreferredFontAXXXLSnapshotTestsFake alloc] init];
    fakeTextField.traitCollectionOverride =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                               UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    self.textField = fakeTextField;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;

    MDCTextInputControllerOutlined *controller =
        [[MDCTextInputControllerOutlined alloc] initWithTextInput:self.textField];
    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    controller.textInputFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino"
                                                                              size:20]];
    controller.inlinePlaceholderFont =
        [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:20]];
    controller.leadingUnderlineLabelFont =
        [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:20]];
    controller.trailingUnderlineLabelFont =
        [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:20]];
    self.textFieldController = controller;

    ((id<UIContentSizeCategoryAdjusting>)self.textField).adjustsFontForContentSizeCategory = YES;
  }
}

- (void)willGenerateSnapshotAndVerify {
  [self.textField traitCollectionDidChange:nil];
}

// NOTE: Additional test methods can be found in MDCAbstractTextFieldSnapshotTests.m

@end
