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

#import "supplemental/TextFieldPresentationStylesLegacyExampleSupplemental.h"

@import MaterialComponents.MaterialTextFields;

@interface TextFieldPresentationStylesExample ()

// Be sure to keep your controllers in memory somewhere like a property:
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *textFieldControllerDefaultCharMax;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *textFieldControllerFloating;
@property(nonatomic, strong) MDCTextInputControllerLegacyFullWidth *textFieldControllerFullWidth;

@end

@implementation TextFieldPresentationStylesExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
  self.title = @"Material Text Fields";

  [self setupExampleViews];

  [self setupTextFields];
}

- (void)setupTextFields {
  // Default with Character Count and Floating Placeholder Text Fields

  // First the text field is added to the view hierarchy
  MDCTextField *textFieldDefaultCharMax = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldDefaultCharMax];
  textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = NO;

  int defaultMax = 25;
  textFieldDefaultCharMax.delegate = self;
  textFieldDefaultCharMax.clearButtonMode = UITextFieldViewModeAlways;

  // Second the controller is created to manage the text field
  self.textFieldControllerDefaultCharMax =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:textFieldDefaultCharMax];
  self.textFieldControllerDefaultCharMax.characterCountMax = defaultMax;
  [self.textFieldControllerDefaultCharMax mdc_setAdjustsFontForContentSizeCategory:YES];
  self.textFieldControllerDefaultCharMax.floatingEnabled = NO;
  self.textFieldControllerDefaultCharMax.placeholderText =
      [NSString stringWithFormat:@"Enter up to %d characters", defaultMax];

  MDCTextField *textFieldFloating = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldFloating];
  textFieldFloating.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldFloating.delegate = self;
  textFieldFloating.clearButtonMode = UITextFieldViewModeUnlessEditing;
  NSOperatingSystemVersion iOS10Version = {10, 0, 0};
  NSProcessInfo *processInfo = [NSProcessInfo processInfo];
  if ([processInfo respondsToSelector:@selector(isOperatingSystemAtLeastVersion:)] &&
      [processInfo isOperatingSystemAtLeastVersion:iOS10Version]) {
    textFieldFloating.adjustsFontForContentSizeCategory = YES;
  } else {
    [textFieldFloating mdc_setAdjustsFontForContentSizeCategory:YES];
  }

  self.textFieldControllerFloating =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:textFieldFloating];
  self.textFieldControllerFloating.placeholderText = @"Floating Placeholder";

  [self.textFieldControllerFloating mdc_setAdjustsFontForContentSizeCategory:YES];

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:[charMax]-[floating]"
                                                  options:NSLayoutFormatAlignAllLeading |
                                                          NSLayoutFormatAlignAllTrailing
                                                  metrics:nil
                                                    views:@{
                                                      @"charMax" : textFieldDefaultCharMax,
                                                      @"floating" : textFieldFloating
                                                    }]];
  [NSLayoutConstraint constraintWithItem:textFieldDefaultCharMax
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeLeadingMargin
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldDefaultCharMax
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeTrailingMargin
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldDefaultCharMax
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeTrailingMargin
                              multiplier:1
                                constant:0]
      .active = YES;

  // Full Width Text Field
  MDCTextField *textFieldFullWidth = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldFullWidth];
  textFieldFullWidth.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldFullWidth.delegate = self;
  textFieldFullWidth.clearButtonMode = UITextFieldViewModeUnlessEditing;
  textFieldFullWidth.backgroundColor = [UIColor whiteColor];

  self.textFieldControllerFullWidth =
      [[MDCTextInputControllerLegacyFullWidth alloc] initWithTextInput:textFieldFullWidth];
  self.textFieldControllerFullWidth.placeholderText = @"Full Width";

  [self.textFieldControllerFullWidth mdc_setAdjustsFontForContentSizeCategory:YES];

  [NSLayoutConstraint constraintWithItem:textFieldFullWidth
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:textFieldFloating
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:1]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldFullWidth
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:textFieldFullWidth
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:0]
      .active = YES;

  // Unstyled Text Field
  MDCTextField *unstyledTextField = [[MDCTextField alloc] init];
  [self.scrollView addSubview:unstyledTextField];
  unstyledTextField.translatesAutoresizingMaskIntoConstraints = NO;

  unstyledTextField.placeholder = @"Text Field without Controller";
  unstyledTextField.delegate = self;
  unstyledTextField.clearButtonMode = UITextFieldViewModeAlways;

  [NSLayoutConstraint constraintWithItem:unstyledTextField
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:textFieldFullWidth
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:1]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:unstyledTextField
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:textFieldDefaultCharMax
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:unstyledTextField
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:textFieldDefaultCharMax
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:0]
      .active = YES;

#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    [NSLayoutConstraint constraintWithItem:textFieldDefaultCharMax
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView.contentLayoutGuide
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:20]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:unstyledTextField
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView.contentLayoutGuide
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1
                                  constant:-20]
        .active = YES;

  } else {
    [NSLayoutConstraint constraintWithItem:textFieldDefaultCharMax
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:20]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:unstyledTextField
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1
                                  constant:-20]
        .active = YES;
  }
#else
  [NSLayoutConstraint constraintWithItem:textFieldDefaultCharMax
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:20]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:unstyledTextField
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeBottomMargin
                              multiplier:1
                                constant:-20]
      .active = YES;
#endif

  //  Flip comments from here down in this method for testing
//  UITextField *appleField = [[UITextField alloc] initWithFrame:CGRectZero];
//  [self.scrollView addSubview:appleField];
//  appleField.translatesAutoresizingMaskIntoConstraints = NO;
//
//  appleField.placeholder = @"UIKit Text Field";
//  appleField.delegate = self;
//  appleField.clearButtonMode = UITextFieldViewModeWhileEditing;
//
//  NSBundle *bundle = [NSBundle bundleForClass:[TextFieldPresentationStylesExample class]];
//  UIImage *image =
//      [UIImage imageNamed:@"ic_search" inBundle:bundle compatibleWithTraitCollection:nil];
//  UIImageView *left = [[UIImageView alloc] initWithImage:image];
//  UIImageView *right = [[UIImageView alloc] initWithImage:image];
//
//  appleField.leftView = left;
//  appleField.leftViewMode = UITextFieldViewModeAlways;
//  appleField.rightView = right;
//  appleField.rightViewMode = UITextFieldViewModeAlways;
//
//  [NSLayoutConstraint constraintWithItem:appleField
//                               attribute:NSLayoutAttributeTop
//                               relatedBy:NSLayoutRelationEqual
//                                  toItem:unstyledTextField
//                               attribute:NSLayoutAttributeBottom
//                              multiplier:1
//                                constant:10]
//      .active = YES;
//  [NSLayoutConstraint constraintWithItem:appleField
//                               attribute:NSLayoutAttributeLeading
//                               relatedBy:NSLayoutRelationEqual
//                                  toItem:textFieldDefaultCharMax
//                               attribute:NSLayoutAttributeLeading
//                              multiplier:1
//                                constant:0]
//      .active = YES;
//  [NSLayoutConstraint constraintWithItem:appleField
//                               attribute:NSLayoutAttributeTrailing
//                               relatedBy:NSLayoutRelationEqual
//                                  toItem:textFieldDefaultCharMax
//                               attribute:NSLayoutAttributeTrailing
//                              multiplier:1
//                                constant:0]
//      .active = YES;
}

#pragma mark - UITextFieldDelegate

// All the usual UITextFieldDelegate methods work with MDCTextField
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  return YES;
}

@end
