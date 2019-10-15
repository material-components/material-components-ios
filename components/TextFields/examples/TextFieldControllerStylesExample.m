// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialTextFields.h"

#import "supplemental/TextFieldControllerStylesExampleSupplemental.h"

@interface TextFieldControllerStylesExample ()

// Be sure to keep your controllers in memory somewhere like a property:
@property(nonatomic, strong) MDCTextInputControllerOutlined *textFieldControllerOutlined;
@property(nonatomic, strong) MDCTextInputControllerFilled *textFieldControllerFilled;
@property(nonatomic, strong) MDCTextField *textFieldOutlined;
@property(nonatomic, strong) MDCTextField *textFieldFilled;
@property(nonatomic, strong) UITextField *uiTextField;
@property(nonatomic, strong) UIImage *leadingImage;
@property(nonatomic, strong) UIImage *trailingImage;

@end

@implementation TextFieldControllerStylesExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.97 alpha:1];
  self.title = @"Material Text Fields";

  [self setupExampleViews];
  [self setupImages];
  [self setupTextFields];
  [self registerKeyboardNotifications];
}

- (void)setupImages {
  self.leadingImage = [UIImage imageNamed:@"ic_search"
                                 inBundle:[NSBundle bundleForClass:[TextFieldControllerStylesExample
                                                                       class]]
            compatibleWithTraitCollection:nil];
  self.trailingImage =
      [UIImage imageNamed:@"ic_done"
                               inBundle:[NSBundle
                                            bundleForClass:[TextFieldControllerStylesExample class]]
          compatibleWithTraitCollection:nil];
}

- (void)setupTextFields {
  // Default with Character Count and Floating Placeholder Text Fields

  // First the text field is added to the view hierarchy
  self.textFieldOutlined = [[MDCTextField alloc] init];
  [self.view addSubview:self.textFieldOutlined];
  self.textFieldOutlined.translatesAutoresizingMaskIntoConstraints = NO;

  int characterCountMax = 25;
  self.textFieldOutlined.delegate = self;

  // Second the controller is created to manage the text field
  self.textFieldControllerOutlined =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:self.textFieldOutlined];
  self.textFieldControllerOutlined.placeholderText = @"MDCTextInputControllerOutlined";
  self.textFieldControllerOutlined.characterCountMax = characterCountMax;

  [self.textFieldControllerOutlined mdc_setAdjustsFontForContentSizeCategory:YES];

  self.textFieldFilled = [[MDCTextField alloc] init];
  [self.view addSubview:self.textFieldFilled];
  self.textFieldFilled.translatesAutoresizingMaskIntoConstraints = NO;

  self.textFieldFilled.delegate = self;

  self.textFieldControllerFilled =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:self.textFieldFilled];
  self.textFieldControllerFilled.placeholderText = @"MDCTextInputControllerFilled";
  self.textFieldControllerFilled.characterCountMax = characterCountMax;

  [self.textFieldControllerFilled mdc_setAdjustsFontForContentSizeCategory:YES];

  self.uiTextField = [[UITextField alloc] init];
  self.uiTextField.backgroundColor = UIColor.lightGrayColor;
  [self.view addSubview:self.uiTextField];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  self.textFieldFilled.frame = CGRectMake(16, 100, CGRectGetWidth(self.view.frame) - 32, 100);
  self.uiTextField.frame = CGRectMake(16, 120, CGRectGetWidth(self.view.frame) - 32, 72);
}

#pragma mark - UITextFieldDelegate

// All the usual UITextFieldDelegate methods work with MDCTextField
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
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
                        name:UIKeyboardDidChangeFrameNotification
                      object:nil];
  [defaultCenter addObserver:self
                    selector:@selector(keyboardWillHide:)
                        name:UIKeyboardWillHideNotification
                      object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
  CGRect frame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(frame), 0);
}

- (void)keyboardWillHide:(NSNotification *)notification {
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
