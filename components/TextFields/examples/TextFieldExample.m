//
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

#import "TextFieldExample.h"

#import "MaterialTextFields.h"
#import "MaterialAppBar.h"

@interface TextFieldExample ()

@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TextFieldExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];

  self.title = @"Material Text Fields";

  [self setupScrollView];

  MDCTextField *textFieldDefaultCharMax = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldDefaultCharMax];
  textFieldDefaultCharMax.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldDefaultCharMax.placeholder = @"Enter up to 50 characters";
  textFieldDefaultCharMax.delegate = self;

  // Second the controller is created to manage the text field
  MDCTextInputController *textFieldControllerDefaultCharMax = [[MDCTextInputController alloc] initWithTextInput: textFieldDefaultCharMax];
  textFieldControllerDefaultCharMax.characterCountMax = 50;

  MDCTextField *textFieldFloating = [[MDCTextField alloc] init];
  [self.scrollView addSubview:textFieldFloating];
  textFieldFloating.translatesAutoresizingMaskIntoConstraints = NO;

  textFieldFloating.placeholder = @"Full Name";
  textFieldFloating.delegate = self;
  textFieldFloating.clearButtonMode = UITextFieldViewModeUnlessEditing;

  MDCTextInputController *textFieldControllerFloating = [[MDCTextInputController alloc] initWithTextInput:textFieldFloating];

  textFieldControllerFloating.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;

}

- (void)setupScrollView {
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  [self.view addSubview:self.scrollView];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

  [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:@{@"scrollView": self.scrollView}]];
  [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:@{@"scrollView": self.scrollView}]];

  CGFloat marginOffset = 16;
  UIEdgeInsets margins = UIEdgeInsetsMake(0, marginOffset, 0, marginOffset);
  self.scrollView.layoutMargins = margins;

}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"Typical Use (Objective C)" ];
}

+ (NSString *)catalogDescription {
  return @"The Material Design Text Fields take the familiar element to a new level by adding useful animations, character counts, helper text and error states.";
}

@end
