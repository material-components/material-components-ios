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

#import "MaterialTextFields+Theming.h"
#import "MaterialTextFields.h"

#import "supplemental/TextFieldControllerStylesExampleSupplemental.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

@interface TextFieldControllerStylesExample ()

// Be sure to keep your controllers in memory somewhere like a property:
@property(nonatomic, strong) MDCTextInputControllerOutlined *textFieldControllerOutlined;
@property(nonatomic, strong) MDCTextInputControllerFilled *textFieldControllerFilled;
@property(nonatomic, strong) MDCTextInputControllerUnderline *textFieldControllerUnderline;

@property(nonatomic, strong) UIImage *leadingImage;
@property(nonatomic, strong) UIImage *trailingImage;

@end

@implementation TextFieldControllerStylesExample

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.containerScheme == nil) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }
  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  self.title = @"Material Text Fields";

  [self setupExampleViews];
  [self setupImages];
  [self setupTextFields];
  [self registerKeyboardNotifications];
}

- (void)setupImages {
  self.leadingImage = [UIImage imageNamed:@"system_icons/search"
                                 inBundle:[NSBundle bundleForClass:[TextFieldControllerStylesExample
                                                                       class]]
            compatibleWithTraitCollection:nil];
  self.trailingImage =
      [UIImage imageNamed:@"system_icons/done"
                               inBundle:[NSBundle
                                            bundleForClass:[TextFieldControllerStylesExample class]]
          compatibleWithTraitCollection:nil];
}

- (void)setupTextFields {
  // Default with Character Count and Floating Placeholder Text Fields

  // First the text field is added to the view hierarchy
  MDCTextField *textFieldOutlined = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldOutlined];
  textFieldOutlined.translatesAutoresizingMaskIntoConstraints = NO;

  int characterCountMax = 25;
  textFieldOutlined.delegate = self;
  textFieldOutlined.clearButtonMode = UITextFieldViewModeAlways;

  textFieldOutlined.leadingView = [[UIImageView alloc] initWithImage:self.leadingImage];
  textFieldOutlined.leadingViewMode = UITextFieldViewModeAlways;
  textFieldOutlined.trailingView = [[UIImageView alloc] initWithImage:self.trailingImage];
  textFieldOutlined.trailingViewMode = UITextFieldViewModeAlways;

  // Second the controller is created to manage the text field
  self.textFieldControllerOutlined =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:textFieldOutlined];
  self.textFieldControllerOutlined.placeholderText = @"MDCTextInputControllerOutlined";
  self.textFieldControllerOutlined.characterCountMax = characterCountMax;

  [self.textFieldControllerOutlined mdc_setAdjustsFontForContentSizeCategory:YES];

  MDCTextField *textFieldFilled = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldFilled];
  textFieldFilled.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldFilled.delegate = self;
  textFieldFilled.clearButtonMode = UITextFieldViewModeUnlessEditing;

  textFieldFilled.leadingView = [[UIImageView alloc] initWithImage:self.leadingImage];
  textFieldFilled.leadingViewMode = UITextFieldViewModeAlways;
  textFieldFilled.trailingView = [[UIImageView alloc] initWithImage:self.trailingImage];
  textFieldFilled.trailingViewMode = UITextFieldViewModeAlways;

  self.textFieldControllerFilled =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:textFieldFilled];
  self.textFieldControllerFilled.placeholderText = @"MDCTextInputControllerFilled";
  self.textFieldControllerFilled.characterCountMax = characterCountMax;

  [self.textFieldControllerFilled mdc_setAdjustsFontForContentSizeCategory:YES];

  id<UILayoutSupport> topGuide = self.topLayoutGuide;
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:[topGuide]-[charMax]-[floating]"
                                                  options:NSLayoutFormatAlignAllLeading |
                                                          NSLayoutFormatAlignAllTrailing
                                                  metrics:nil
                                                    views:@{
                                                      @"topGuide" : topGuide,
                                                      @"charMax" : textFieldOutlined,
                                                      @"floating" : textFieldFilled
                                                    }]];
  [NSLayoutConstraint constraintWithItem:textFieldOutlined
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeLeadingMargin
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldOutlined
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeTrailingMargin
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldOutlined
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeTrailingMargin
                              multiplier:1
                                constant:0]
      .active = YES;

  // Full Width Text Field
  MDCTextField *textFieldUnderline = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldUnderline];
  textFieldUnderline.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldUnderline.delegate = self;
  textFieldUnderline.clearButtonMode = UITextFieldViewModeUnlessEditing;

  textFieldUnderline.leadingView = [[UIImageView alloc] initWithImage:self.leadingImage];
  textFieldUnderline.leadingViewMode = UITextFieldViewModeAlways;
  textFieldUnderline.trailingView = [[UIImageView alloc] initWithImage:self.trailingImage];
  textFieldUnderline.trailingViewMode = UITextFieldViewModeAlways;

  self.textFieldControllerUnderline =
      [[MDCTextInputControllerUnderline alloc] initWithTextInput:textFieldUnderline];
  self.textFieldControllerUnderline.placeholderText = @"MDCTextInputControllerUnderline";
  self.textFieldControllerUnderline.characterCountMax = characterCountMax;

  [self.textFieldControllerUnderline mdc_setAdjustsFontForContentSizeCategory:YES];
  [self.textFieldControllerUnderline applyThemeWithScheme:self.containerScheme];

  [NSLayoutConstraint constraintWithItem:textFieldUnderline
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:textFieldFilled
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:1]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldUnderline
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeLeadingMargin
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldUnderline
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeTrailingMargin
                              multiplier:1
                                constant:0]
      .active = YES;

  [NSLayoutConstraint constraintWithItem:textFieldOutlined
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView.contentLayoutGuide
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:20]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldOutlined
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView.contentLayoutGuide
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:-20]
      .active = YES;
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
