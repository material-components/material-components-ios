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

#import "MaterialTextFields.h"

@interface TextFieldCustomFontExample : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic) MDCTextInputControllerOutlined *systemFontController;
@property(nonatomic) MDCTextInputControllerOutlined *systemFontDynamicController;
@property(nonatomic) MDCTextInputControllerOutlined *customFontController;
@property(nonatomic) MDCTextInputControllerOutlined *customFontDynamicController;

@property(nonatomic) MDCTextInputControllerOutlinedTextArea *multilineController;
@property(nonatomic) MDCTextInputControllerOutlinedTextArea *multilineDynamicController;
@property(nonatomic) MDCTextInputControllerOutlinedTextArea *multilineCustomFontDynamicController;

@property(nonatomic) UIFont *normalTextFont;

@property(nonatomic) UIScrollView *scrollView;

@end

@implementation TextFieldCustomFontExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  [self registerKeyboardNotifications];

  [self setupScrollView];

  // Create a System Font TextField.
  MDCTextField *systemFontTextField = [self setupSystemFontTextField];

  // Create a System Font Dynamic TextField.
  MDCTextField *systemFontDynamicTextField = [self setupSystemFontDynamicTextField];

  // Create a Custom Font TextField.
  MDCTextField *customFontTextField = [self setupCustomFontTextField];
  ;

  // Create a Custom Font Dynamic TextField.
  MDCTextField *customFontDynamicTextField = [self setupCustomFontDynamicTextField];
  ;

  // Create a System Multiline TextField.
  MDCMultilineTextField *multilineTextField = [self setupSystemMultilineTextField];

  // Create a System Multiline Dynamic TextField.
  MDCMultilineTextField *multilineDynamicTextField = [self setupSystemMultilineDynamicTextField];

  // Create a Custom Multiline Dyamic TextField.
  MDCMultilineTextField *multilineCustomDynamicTextField =
      [self setupCustomMultilineDynamicTextField];

  NSDictionary *views = @{
    @"t1" : systemFontTextField,
    @"t2" : systemFontDynamicTextField,
    @"t3" : customFontTextField,
    @"t4" : customFontDynamicTextField,
    @"t5" : multilineTextField,
    @"t6" : multilineDynamicTextField,
    @"t7" : multilineCustomDynamicTextField
  };
  NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray
      arrayWithArray:[NSLayoutConstraint
                         constraintsWithVisualFormat:@"V:[t1]-[t2]-[t3]-[t4]-[t5]-[t6]-[t7]"

                                             options:NSLayoutFormatAlignAllLeading |
                                                     NSLayoutFormatAlignAllTrailing
                                             metrics:nil
                                               views:views]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:systemFontTextField
                                                      attribute:NSLayoutAttributeLeading
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.view
                                                      attribute:NSLayoutAttributeLeadingMargin
                                                     multiplier:1
                                                       constant:0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:systemFontTextField
                                                      attribute:NSLayoutAttributeTrailing
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.view
                                                      attribute:NSLayoutAttributeTrailingMargin
                                                     multiplier:1
                                                       constant:0]];
  [NSLayoutConstraint activateConstraints:@[
    [NSLayoutConstraint constraintWithItem:systemFontTextField
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView.contentLayoutGuide
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:20],
    [NSLayoutConstraint constraintWithItem:multilineCustomDynamicTextField
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView.contentLayoutGuide
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1
                                  constant:-20]
  ]];

  [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupScrollView {
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.scrollView];
  id<UILayoutSupport> topGuide = self.topLayoutGuide;
  NSArray *constraints = [NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[topGuide]-[scrollView]|"
                          options:0
                          metrics:nil
                            views:@{@"topGuide" : topGuide, @"scrollView" : self.scrollView}];

  [NSLayoutConstraint activateConstraints:constraints];
  constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                        options:0
                                                        metrics:nil
                                                          views:@{@"scrollView" : self.scrollView}];
  [NSLayoutConstraint activateConstraints:constraints];
  UIEdgeInsets margins = UIEdgeInsetsMake(0, 16, 0, 16);
  self.scrollView.layoutMargins = margins;

  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidTouch:)];
  [self.scrollView addGestureRecognizer:tapGestureRecognizer];
}

- (MDCTextField *)setupSystemFontTextField {
  MDCTextField *systemFontTextField = [[MDCTextField alloc] init];
  self.normalTextFont = systemFontTextField.font;
  systemFontTextField.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:systemFontTextField];

  systemFontTextField.delegate = self;
  systemFontTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
  systemFontTextField.backgroundColor = [UIColor whiteColor];

  self.systemFontController =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:systemFontTextField];
  self.systemFontController.placeholderText = @"System Font";
  self.systemFontController.mdc_adjustsFontForContentSizeCategory = NO;
  return systemFontTextField;
}

- (MDCTextField *)setupSystemFontDynamicTextField {
  MDCTextField *systemFontDynamicTextField = [[MDCTextField alloc] init];
  systemFontDynamicTextField.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:systemFontDynamicTextField];

  systemFontDynamicTextField.delegate = self;
  systemFontDynamicTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
  systemFontDynamicTextField.backgroundColor = [UIColor whiteColor];

  self.systemFontDynamicController =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:systemFontDynamicTextField];
  self.systemFontDynamicController.placeholderText = @"System Font - Dynamic";
  self.systemFontDynamicController.mdc_adjustsFontForContentSizeCategory = YES;
  return systemFontDynamicTextField;
}

- (MDCTextField *)setupCustomFontTextField {
  MDCTextField *customFontTextField = [[MDCTextField alloc] init];
  customFontTextField.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:customFontTextField];

  customFontTextField.delegate = self;
  customFontTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
  customFontTextField.backgroundColor = [UIColor whiteColor];

  self.customFontController =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:customFontTextField];
  self.customFontController.placeholderText = @"Custom Font";
  self.customFontController.mdc_adjustsFontForContentSizeCategory = NO;
  self.customFontController.leadingUnderlineLabelFont = [UIFont fontWithName:@"AmericanTypewriter"
                                                                        size:12];
  self.customFontController.trailingUnderlineLabelFont = [UIFont fontWithName:@"Chalkduster"
                                                                         size:12];
  self.customFontController.inlinePlaceholderFont = [UIFont fontWithName:@"AmericanTypewriter"
                                                                    size:12];
  self.customFontController.textInputFont = [UIFont fontWithName:@"Chalkduster" size:16];
  return customFontTextField;
}

- (MDCTextField *)setupCustomFontDynamicTextField {
  MDCTextField *customFontDynamicTextField = [[MDCTextField alloc] init];
  customFontDynamicTextField.translatesAutoresizingMaskIntoConstraints = NO;

  customFontDynamicTextField.delegate = self;
  customFontDynamicTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
  customFontDynamicTextField.backgroundColor = [UIColor whiteColor];

  self.customFontDynamicController =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:customFontDynamicTextField];
  self.customFontDynamicController.placeholderText = @"Custom Font - Dynamic";
  self.customFontDynamicController.helperText = @"Helper";
  self.customFontDynamicController.leadingUnderlineLabelFont = [UIFont fontWithName:@"Zapfino"
                                                                               size:12];
  self.customFontDynamicController.trailingUnderlineLabelFont = [UIFont fontWithName:@"Chalkduster"
                                                                                size:12];
  self.customFontDynamicController.inlinePlaceholderFont = [UIFont fontWithName:@"Zapfino" size:12];
  self.customFontDynamicController.textInputFont = [UIFont fontWithName:@"Zapfino" size:16];
  self.customFontDynamicController.mdc_adjustsFontForContentSizeCategory = YES;

  [self.scrollView addSubview:customFontDynamicTextField];
  return customFontDynamicTextField;
}

- (MDCMultilineTextField *)setupSystemMultilineTextField {
  MDCMultilineTextField *multilineTextField = [[MDCMultilineTextField alloc] init];
  multilineTextField.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:multilineTextField];

  multilineTextField.textView.delegate = self;

  self.multilineController =
      [[MDCTextInputControllerOutlinedTextArea alloc] initWithTextInput:multilineTextField];
  self.multilineController.placeholderText = @"Multiline Text";
  self.multilineController.mdc_adjustsFontForContentSizeCategory = NO;
  return multilineTextField;
}

- (MDCMultilineTextField *)setupSystemMultilineDynamicTextField {
  MDCMultilineTextField *multilineDynamicTextField = [[MDCMultilineTextField alloc] init];
  multilineDynamicTextField.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:multilineDynamicTextField];

  multilineDynamicTextField.textView.delegate = self;

  self.multilineDynamicController =
      [[MDCTextInputControllerOutlinedTextArea alloc] initWithTextInput:multilineDynamicTextField];
  self.multilineDynamicController.placeholderText = @"Multiline Dynamic Text";
  self.multilineDynamicController.mdc_adjustsFontForContentSizeCategory = YES;
  return multilineDynamicTextField;
}

- (MDCMultilineTextField *)setupCustomMultilineDynamicTextField {
  MDCMultilineTextField *multilineCustomDynamicTextField = [[MDCMultilineTextField alloc] init];
  multilineCustomDynamicTextField.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:multilineCustomDynamicTextField];

  multilineCustomDynamicTextField.textView.delegate = self;

  self.multilineCustomFontDynamicController = [[MDCTextInputControllerOutlinedTextArea alloc]
      initWithTextInput:multilineCustomDynamicTextField];
  self.multilineCustomFontDynamicController.placeholderText = @"Multiline Custom Font Dynamic Text";
  self.multilineCustomFontDynamicController.leadingUnderlineLabelFont =
      [UIFont fontWithName:@"AmericanTypewriter" size:12];
  self.customFontDynamicController.trailingUnderlineLabelFont = [UIFont fontWithName:@"Chalkduster"
                                                                                size:12];
  self.multilineCustomFontDynamicController.inlinePlaceholderFont = [UIFont fontWithName:@"Zapfino"
                                                                                    size:12];
  self.multilineCustomFontDynamicController.textInputFont =
      [UIFont fontWithName:@"AmericanTypewriter" size:16];
  self.multilineCustomFontDynamicController.mdc_adjustsFontForContentSizeCategory = YES;
  return multilineCustomDynamicTextField;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];

  return NO;
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *finishedString = [textField.text stringByReplacingCharactersInRange:range
                                                                     withString:string];

  if (textField == (UITextField *)self.systemFontController.textInput) {
    if ([finishedString rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].length &&
        ![self.systemFontController.errorText isEqualToString:@"Error: You cannot enter numbers"]) {
      // The entered text contains numbers and we have not set an error
      [self.systemFontController setErrorText:@"You cannot enter numbers"
                      errorAccessibilityValue:nil];

      // Since we are doing manual layout, we need to react to the expansion of the input that will
      // come from setting an error.
      [self.view setNeedsLayout];
    } else if (self.systemFontController.errorText != nil) {
      // There should be no error but error text is being shown.
      [self.systemFontController setErrorText:nil errorAccessibilityValue:nil];

      // Since we are doing manual layout, we need to react to the contraction of the input that
      // will come from setting an error.
      [self.view setNeedsLayout];
    }
  }

  if (textField == (UITextField *)self.customFontController.textInput) {
    if ([finishedString rangeOfCharacterFromSet:[[NSCharacterSet letterCharacterSet] invertedSet]]
            .length > 0) {
      [self.customFontController setErrorText:@"Error: City can only contain letters"
                      errorAccessibilityValue:nil];
    } else {
      [self.customFontController setErrorText:nil errorAccessibilityValue:nil];
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

@implementation TextFieldCustomFontExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", @"Custom Fonts" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
