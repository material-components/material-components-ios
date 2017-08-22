/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MaterialTextFields.h"

@interface TextFieldManualLayoutLegacyExample : UIViewController <UITextFieldDelegate>

@property(nonatomic) MDCTextInputControllerLegacyDefault *nameController;
@property(nonatomic) MDCTextInputControllerLegacyDefault *phoneController;

@end

@implementation TextFieldManualLayoutLegacyExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  MDCTextField *textFieldName = [[MDCTextField alloc] init];
  [self.view addSubview:textFieldName];

  textFieldName.placeholder = @"Full Name";
  textFieldName.delegate = self;
  textFieldName.clearButtonMode = UITextFieldViewModeUnlessEditing;

  self.nameController = [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:textFieldName];

  textFieldName.frame = CGRectMake(10, 40, CGRectGetWidth(self.view.bounds) - 20, 0);

  MDCTextField *textFieldPhone = [[MDCTextField alloc] init];
  [self.view addSubview:textFieldPhone];

  textFieldPhone.placeholder = @"Phone Number";
  textFieldPhone.delegate = self;
  textFieldPhone.clearButtonMode = UITextFieldViewModeUnlessEditing;

  self.phoneController = [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:textFieldPhone];

  textFieldPhone.frame = CGRectMake(10, CGRectGetMaxY(self.nameController.textInput.frame) + 20,
                                    CGRectGetWidth(self.view.bounds) - 20, 0);

  self.phoneController.helperText = @"XXX-XXX-XXXX";
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self.nameController.textInput sizeToFit];
  [self.phoneController.textInput sizeToFit];
  self.phoneController.textInput.frame = CGRectMake(
      10, CGRectGetMaxY(self.nameController.textInput.frame) + 20,
      CGRectGetWidth(self.view.bounds) - 20, CGRectGetHeight(self.phoneController.textInput.frame));
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];

  if (textField == (UITextField *)self.phoneController.textInput &&
      ![self isValidPhoneNumber:textField.text partially:NO]) {
    [self.phoneController setErrorText:@"Invalid Phone Number" errorAccessibilityValue:nil];
  }

  return NO;
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *finishedString =
      [textField.text stringByReplacingCharactersInRange:range withString:string];

  if (textField == (UITextField *)self.nameController.textInput) {
    if ([finishedString rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].length &&
        ![self.nameController.errorText isEqualToString:@"You cannot enter numbers"]) {
      // The entered text contains numbers and we have not set an error
      [self.nameController setErrorText:@"You cannot enter numbers" errorAccessibilityValue:nil];

      // Since we are doing manual layout, we need to react to the expansion of the input that will
      // come from setting an error.
      [self.view setNeedsLayout];
    } else if (self.nameController.errorText != nil) {
      // There should be no error but error text is being shown.
      [self.nameController setErrorText:nil errorAccessibilityValue:nil];

      // Since we are doing manual layout, we need to react to the contraction of the input that
      // will come from setting an error.
      [self.view setNeedsLayout];
    }
  }

  if (textField == (UITextField *)self.phoneController.textInput) {
    if (![self isValidPhoneNumber:finishedString partially:YES] &&
        ![self.phoneController.errorText isEqualToString:@"Invalid phone number"]) {
      // The entered text is not valid and we have not set an error
      [self.phoneController setErrorText:@"Invalid phone number" errorAccessibilityValue:nil];

      // The text field has helper text that already expanded the frame so we don't need to call
      // setNeedsLayout.
    } else if (self.phoneController.errorText != nil) {
      [self.phoneController setErrorText:nil errorAccessibilityValue:nil];

      // The text field has helper text and cannot contract the frame so we don't need to call
      // setNeedsLayout.
    }
  }

  return YES;
}

#pragma mark - Phone Number Validation

- (BOOL)isValidPhoneNumber:(NSString *)inputString partially:(BOOL)isPartialCheck {
  // In real life there would be much more robust validation that takes locale into account, checks
  // against invalid phone numbers (like those that begin with 0), and perhaps even auto-inserts the
  // hyphens so the user doesn't have to.

  if (inputString.length == 0) {
    return YES;
  }

  NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789-"];
  characterSet = [characterSet invertedSet];

  BOOL isValid = ![inputString rangeOfCharacterFromSet:characterSet].length;

  if (!isPartialCheck) {
    isValid = isValid && inputString.length == 12;
  } else {
    isValid = isValid && inputString.length <= 12;
  }
  return isValid;
}

@end

@implementation TextFieldManualLayoutLegacyExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"[Legacy] Manual Layout (Objective C)" ];
}

@end
