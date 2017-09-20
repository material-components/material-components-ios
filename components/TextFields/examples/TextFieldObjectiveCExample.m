/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

@interface TextFieldOutlinedObjectiveCExample : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic) MDCTextInputControllerOutlinedField *nameController;
@property(nonatomic) MDCTextInputControllerOutlinedField *addressController;
@property(nonatomic) MDCTextInputControllerOutlinedField *cityController;
@property(nonatomic) MDCTextInputControllerOutlinedField *stateController;
@property(nonatomic) MDCTextInputControllerOutlinedField *zipController;
@property(nonatomic) MDCTextInputControllerOutlinedField *phoneController;

@property(nonatomic) MDCTextInputControllerTextArea *messageController;

@property(nonatomic) UIScrollView *scrollView;

@end

@implementation TextFieldOutlinedObjectiveCExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  [self registerKeyboardNotifications];

  [self setupScrollView];

  MDCTextField *textFieldName = [[MDCTextField alloc] init];
  textFieldName.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldName];

  textFieldName.placeholder = @"Full Name";
  textFieldName.delegate = self;
  textFieldName.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldName.backgroundColor = [UIColor whiteColor];

  self.nameController = [[MDCTextInputControllerOutlinedField alloc] initWithTextInput:textFieldName];

  MDCTextField *textFieldAddress = [[MDCTextField alloc] init];
  textFieldAddress.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldAddress];

  textFieldAddress.placeholder = @"Address";
  textFieldAddress.delegate = self;
  textFieldAddress.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldAddress.backgroundColor = [UIColor whiteColor];

  self.addressController = [[MDCTextInputControllerOutlinedField alloc] initWithTextInput:textFieldAddress];

  MDCTextField *textFieldCity = [[MDCTextField alloc] init];
  textFieldCity.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldCity];

  textFieldCity.placeholder = @"City";
  textFieldCity.delegate = self;
  textFieldCity.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldCity.backgroundColor = [UIColor whiteColor];

  self.cityController = [[MDCTextInputControllerOutlinedField alloc] initWithTextInput:textFieldCity];

  MDCTextField *textFieldState = [[MDCTextField alloc] init];
  textFieldState.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldState.placeholder = @"State";
  textFieldState.delegate = self;
  textFieldState.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldState.backgroundColor = [UIColor whiteColor];

  self.stateController = [[MDCTextInputControllerOutlinedField alloc] initWithTextInput:textFieldState];

  MDCTextField *textFieldZip = [[MDCTextField alloc] init];
  textFieldZip.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldZip.placeholder = @"Zip Code";
  textFieldZip.delegate = self;
  textFieldZip.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldZip.backgroundColor = [UIColor whiteColor];

  self.zipController = [[MDCTextInputControllerOutlinedField alloc] initWithTextInput:textFieldZip];

  UIView *stateZip = [[UIView alloc] initWithFrame:CGRectZero];
  stateZip.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:stateZip];
  stateZip.opaque = NO;

  [stateZip addSubview:textFieldState];
  [stateZip addSubview:textFieldZip];

  MDCTextField *textFieldPhone = [[MDCTextField alloc] init];
  textFieldPhone.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldPhone];

  textFieldPhone.placeholder = @"Phone Number";
  textFieldPhone.delegate = self;
  textFieldPhone.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldPhone.backgroundColor = [UIColor whiteColor];

  self.phoneController = [[MDCTextInputControllerOutlinedField alloc] initWithTextInput:textFieldPhone];
  self.phoneController.helperText = @"XXX-XXX-XXXX";

  MDCMultilineTextField *textFieldMessage = [[MDCMultilineTextField alloc] init];
  textFieldMessage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldMessage];
  
  textFieldMessage.placeholder = @"Message";
  textFieldMessage.textView.delegate = self;

  self.messageController = [[MDCTextInputControllerTextArea alloc] initWithTextInput:textFieldMessage];

  NSDictionary *views = @{
                         @"name": textFieldName,
                         @"address": textFieldAddress,
                         @"city": textFieldCity,
                         @"state": textFieldState,
                         @"zip": textFieldZip,
                         @"stateZip": stateZip,
                         @"phone": textFieldPhone,
                         @"message": textFieldMessage
                         };
  NSMutableArray <NSLayoutConstraint *> *constraints = [NSMutableArray arrayWithArray:
       [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[name]-[address]-[city]-[stateZip]-[phone]-[message]-20-|"

                                               options:NSLayoutFormatAlignAllLeading |
                                                          NSLayoutFormatAlignAllTrailing
                                               metrics:nil
                                                 views:views]];
  [constraints addObject:
     [NSLayoutConstraint constraintWithItem:textFieldName
                                  attribute:NSLayoutAttributeLeading
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeLeadingMargin
                                 multiplier:1
                                   constant:0]];
  [constraints addObject:
      [NSLayoutConstraint constraintWithItem:textFieldName
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeTrailingMargin
                                  multiplier:1
                                    constant:0]];
  [constraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[state(80)]-[zip]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
  [constraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[state]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
  [constraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[zip]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
  [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupScrollView {
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.scrollView];

  [NSLayoutConstraint activateConstraints:
       [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                               options:0
                                               metrics:nil
                                                 views:@{@"scrollView": self.scrollView}]];
  [NSLayoutConstraint activateConstraints:
   [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|"
                                           options:0
                                           metrics:nil
                                             views:@{@"scrollView": self.scrollView}]];
  UIEdgeInsets margins = UIEdgeInsetsMake(0, 16, 0, 16);
  self.scrollView.layoutMargins = margins;

  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidTouch:)];
  [self.scrollView addGestureRecognizer:tapGestureRecognizer];
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
        ![self.nameController.errorText isEqualToString:@"Error: You cannot enter numbers"]) {
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

  if (textField == (UITextField *)self.cityController.textInput) {
    if ([finishedString rangeOfCharacterFromSet:[[NSCharacterSet letterCharacterSet] invertedSet]].length > 0) {
      [self.cityController setErrorText:@"Error: City can only contain letters"
                errorAccessibilityValue:nil];
    } else {
      [self.cityController setErrorText:nil
                errorAccessibilityValue:nil];
    }
  }

  if (textField == (UITextField *)self.zipController.textInput) {
    if ([finishedString rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].length > 0) {
      [self.zipController setErrorText:@"Error: Zip can only contain numbers"
                errorAccessibilityValue:nil];
    } else if (finishedString.length > 5) {
      [self.zipController setErrorText:@"Error: Zip can only contain five digits"
               errorAccessibilityValue:nil];
    } else {
      [self.zipController setErrorText:nil
                errorAccessibilityValue:nil];
    }
  }

  if (textField == (UITextField *)self.phoneController.textInput) {
    if (![self isValidPhoneNumber:finishedString partially:YES] &&
        ![self.phoneController.errorText isEqualToString:@"Error: Invalid phone number"]) {
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

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
  NSLog(@"%@", textView.text);
}

#pragma mark - Gesture Handling

- (void)tapDidTouch:(UIGestureRecognizer *)sender {
  [self.view endEditing:YES];
}

#pragma mark - Keyboard Handling

- (void)registerKeyboardNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

  [defaultCenter addObserver:self
                    selector:@selector(keyboardWillShow:)
                        name:UIKeyboardWillShowNotification
                      object:nil];
  [defaultCenter addObserver:self
                    selector:@selector(keyboardWillHide:)
                        name:UIKeyboardWillHideNotification
                      object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notif {
  CGRect keyboardFrame = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(keyboardFrame), 0);
}

- (void)keyboardWillHide:(NSNotification *)notif {
  self.scrollView.contentInset = UIEdgeInsetsZero;
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

@implementation TextFieldOutlinedObjectiveCExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"Text Field Typical Use (Objective-C)" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
