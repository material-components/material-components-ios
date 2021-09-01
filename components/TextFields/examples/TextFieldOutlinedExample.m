// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialTextFields.h"
#import "MaterialTextFields+Theming.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

@interface TextFieldOutlinedObjectiveCExample
    : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic) MDCTextInputControllerOutlined *nameController;
@property(nonatomic) MDCTextInputControllerOutlined *addressController;
@property(nonatomic) MDCTextInputControllerOutlined *cityController;
@property(nonatomic) MDCTextInputControllerOutlined *stateController;
@property(nonatomic) MDCTextInputControllerOutlined *zipController;
@property(nonatomic) MDCTextInputControllerOutlined *phoneController;

@property(nonatomic) MDCTextInputControllerOutlinedTextArea *messageController;

@property(nonatomic, strong) MDCContainerScheme *containerScheme;

@property(nonatomic) UIScrollView *scrollView;

@end

@implementation TextFieldOutlinedObjectiveCExample

- (void)styleTextInputController:(id<MDCTextInputController>)controller {
  if ([controller isKindOfClass:[MDCTextInputControllerOutlined class]]) {
    MDCTextInputControllerOutlined *outlinedController =
        (MDCTextInputControllerOutlined *)controller;
    [outlinedController applyThemeWithScheme:self.containerScheme];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;

  [self registerKeyboardNotifications];

  [self setupScrollView];

  MDCTextField *textFieldName = [[MDCTextField alloc] init];
  textFieldName.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldName];

  textFieldName.delegate = self;
  textFieldName.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldName.backgroundColor = [UIColor whiteColor];

  UIImage *leadingImage = [UIImage
                         imageNamed:@"ic_search"
                           inBundle:[NSBundle
                                        bundleForClass:[TextFieldOutlinedObjectiveCExample class]]
      compatibleWithTraitCollection:nil];
  textFieldName.leadingView = [[UIImageView alloc] initWithImage:leadingImage];
  textFieldName.leadingViewMode = UITextFieldViewModeAlways;

  UIImage *trailingImage = [UIImage
                         imageNamed:@"ic_done"
                           inBundle:[NSBundle
                                        bundleForClass:[TextFieldOutlinedObjectiveCExample class]]
      compatibleWithTraitCollection:nil];
  textFieldName.trailingView = [[UIImageView alloc] initWithImage:trailingImage];
  textFieldName.trailingViewMode = UITextFieldViewModeAlways;

  self.nameController = [[MDCTextInputControllerOutlined alloc] initWithTextInput:textFieldName];
  self.nameController.placeholderText = @"Full Name";
  [self styleTextInputController:self.nameController];

  MDCTextField *textFieldAddress = [[MDCTextField alloc] init];
  textFieldAddress.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldAddress];

  textFieldAddress.delegate = self;
  textFieldAddress.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldAddress.backgroundColor = [UIColor whiteColor];

  self.addressController =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:textFieldAddress];
  self.addressController.placeholderText = @"Address";
  [self styleTextInputController:self.addressController];

  MDCTextField *textFieldCity = [[MDCTextField alloc] init];
  textFieldCity.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldCity];

  textFieldCity.delegate = self;
  textFieldCity.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldCity.backgroundColor = [UIColor whiteColor];

  self.cityController = [[MDCTextInputControllerOutlined alloc] initWithTextInput:textFieldCity];
  self.cityController.placeholderText = @"City";
  [self styleTextInputController:self.cityController];

  MDCTextField *textFieldState = [[MDCTextField alloc] init];
  textFieldState.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldState.delegate = self;
  textFieldState.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldState.backgroundColor = [UIColor whiteColor];

  self.stateController = [[MDCTextInputControllerOutlined alloc] initWithTextInput:textFieldState];
  self.stateController.placeholderText = @"State";
  [self styleTextInputController:self.stateController];

  MDCTextField *textFieldZip = [[MDCTextField alloc] init];
  textFieldZip.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldZip.delegate = self;
  textFieldZip.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldZip.backgroundColor = [UIColor whiteColor];

  self.zipController = [[MDCTextInputControllerOutlined alloc] initWithTextInput:textFieldZip];
  self.zipController.placeholderText = @"Zip Code";
  [self styleTextInputController:self.zipController];

  UIView *stateZip = [[UIView alloc] initWithFrame:CGRectZero];
  stateZip.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:stateZip];
  stateZip.opaque = NO;

  [stateZip addSubview:textFieldState];
  [stateZip addSubview:textFieldZip];

  MDCTextField *textFieldPhone = [[MDCTextField alloc] init];
  textFieldPhone.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldPhone];

  textFieldPhone.delegate = self;
  textFieldPhone.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldPhone.backgroundColor = [UIColor whiteColor];

  self.phoneController = [[MDCTextInputControllerOutlined alloc] initWithTextInput:textFieldPhone];
  self.phoneController.placeholderText = @"Phone Number";
  self.phoneController.helperText = @"XXX-XXX-XXXX";
  [self styleTextInputController:self.phoneController];

  MDCMultilineTextField *textFieldMessage = [[MDCMultilineTextField alloc] init];
  textFieldMessage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:textFieldMessage];

  textFieldMessage.textView.delegate = self;

  self.messageController =
      [[MDCTextInputControllerOutlinedTextArea alloc] initWithTextInput:textFieldMessage];
  textFieldMessage.text = @"This is where you could put a multi-line message like an email.\n\n"
                           "It can even handle new lines.";
  self.messageController.placeholderText = @"Message";
  [self styleTextInputController:self.messageController];

  id<UILayoutSupport> topGuide = self.topLayoutGuide;
  NSDictionary *views = @{
    @"topGuide" : topGuide,
    @"name" : textFieldName,
    @"address" : textFieldAddress,
    @"city" : textFieldCity,
    @"state" : textFieldState,
    @"zip" : textFieldZip,
    @"stateZip" : stateZip,
    @"phone" : textFieldPhone,
    @"message" : textFieldMessage
  };
  NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray
      arrayWithArray:[NSLayoutConstraint
                         constraintsWithVisualFormat:
                             @"V:[topGuide]-[name]-[address]-[city]-[stateZip]-[phone]-[message]"

                                             options:NSLayoutFormatAlignAllLeading |
                                                     NSLayoutFormatAlignAllTrailing
                                             metrics:nil
                                               views:views]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:textFieldName
                                                      attribute:NSLayoutAttributeLeading
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.view
                                                      attribute:NSLayoutAttributeLeadingMargin
                                                     multiplier:1
                                                       constant:0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:textFieldName
                                                      attribute:NSLayoutAttributeTrailing
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.view
                                                      attribute:NSLayoutAttributeTrailingMargin
                                                     multiplier:1
                                                       constant:0]];
  [NSLayoutConstraint activateConstraints:@[
    [NSLayoutConstraint constraintWithItem:textFieldName
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView.contentLayoutGuide
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:20],
    [NSLayoutConstraint constraintWithItem:textFieldMessage
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView.contentLayoutGuide
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1
                                  constant:-20]
  ]];

  [constraints
      addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[state(80)]-[zip]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:views]];
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[state]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[zip]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
  [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupScrollView {
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.scrollView];

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{@"scrollView" : self.scrollView}]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{@"scrollView" : self.scrollView}]];
  UIEdgeInsets margins = UIEdgeInsetsMake(0, 16, 0, 16);
  self.scrollView.layoutMargins = margins;

  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidTouch:)];
  [self.scrollView addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];

  if (textField == (UITextField *)self.nameController.textInput) {
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].length &&
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
  } else if (textField == (UITextField *)self.cityController.textInput) {
    if ([textField.text rangeOfCharacterFromSet:[[NSCharacterSet letterCharacterSet] invertedSet]]
            .length > 0) {
      [self.cityController setErrorText:@"Error: City can only contain letters"
                errorAccessibilityValue:nil];
    } else {
      [self.cityController setErrorText:nil errorAccessibilityValue:nil];
    }
  } else if (textField == (UITextField *)self.phoneController.textInput) {
    if (![self isValidPhoneNumber:textField.text partially:NO]) {
      [self.phoneController setErrorText:@"Invalid Phone Number" errorAccessibilityValue:nil];
    } else if (self.phoneController.errorText != nil) {
      [self.phoneController setErrorText:nil errorAccessibilityValue:nil];
    }
  } else if (textField == (UITextField *)self.zipController.textInput) {
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].length > 0) {
      [self.zipController setErrorText:@"Error: Zip can only contain numbers"
               errorAccessibilityValue:nil];
    } else if (textField.text.length > 5) {
      [self.zipController setErrorText:@"Error: Zip can only contain five digits"
               errorAccessibilityValue:nil];
    } else {
      [self.zipController setErrorText:nil errorAccessibilityValue:nil];
    }
  }

  return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
  if (textField == (UITextField *)self.nameController.textInput) {
    [self.nameController setErrorText:nil errorAccessibilityValue:nil];
  } else if (textField == (UITextField *)self.cityController.textInput) {
    [self.cityController setErrorText:nil errorAccessibilityValue:nil];
  } else if (textField == (UITextField *)self.phoneController.textInput) {
    [self.phoneController setErrorText:nil errorAccessibilityValue:nil];
  } else if (textField == (UITextField *)self.zipController.textInput) {
    [self.zipController setErrorText:nil errorAccessibilityValue:nil];
  }
  return YES;
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *finishedString = [textField.text stringByReplacingCharactersInRange:range
                                                                     withString:string];

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
    if ([finishedString rangeOfCharacterFromSet:[[NSCharacterSet letterCharacterSet] invertedSet]]
            .length > 0) {
      [self.cityController setErrorText:@"Error: City can only contain letters"
                errorAccessibilityValue:nil];
    } else {
      [self.cityController setErrorText:nil errorAccessibilityValue:nil];
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
      [self.zipController setErrorText:nil errorAccessibilityValue:nil];
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
                    selector:@selector(keyboardWillShow:)
                        name:UIKeyboardWillChangeFrameNotification
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

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", @"Outlined text fields" ],
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end
