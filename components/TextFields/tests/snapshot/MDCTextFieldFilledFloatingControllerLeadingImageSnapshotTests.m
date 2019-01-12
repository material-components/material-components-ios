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
// WITHOUT WARRANTIES OR CONDITIONS OF ANY MDCTextFieldSnapshotTestsIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "supplemental/MDCAbstractTextFieldSnapshotTests+LeadingImage.h"
#import "supplemental/MDCAbstractTextFieldSnapshotTests.h"
#import "supplemental/MDCTextFieldSnapshotTestsStrings.h"
#import "MaterialTextFields.h"

@interface MDCTextFieldFilledFloatingControllerLeadingImageSnapshotTests
    : MDCAbstractTextFieldSnapshotTests
@end

@implementation MDCTextFieldFilledFloatingControllerLeadingImageSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate the golden images for all test methods. Add it to a test method to
  // update only that golden image.
  //  self.recordMode = YES;

  self.textField.clearButtonMode = UITextFieldViewModeAlways;

  [self addLeadingImage];

  MDCTextInputControllerFilled *controller =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:self.textField];
  controller.floatingEnabled = YES;
  self.textFieldController = controller;
}

// NOTE: Additional test methods can be found in MDCAbstractTextFieldSnapshotTests.m

@end
