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

#import "TextViewExample.h"

#import "MaterialTextFields.h"

@interface TextViewExample () <UITextViewDelegate>

@end

@implementation TextViewExample

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];

  self.title = @"Material Text Views";

  MDCTextView *textViewUnstyled = [[MDCTextView alloc] init];
  [self.view addSubview:textViewUnstyled];
  textViewUnstyled.translatesAutoresizingMaskIntoConstraints = NO;

  textViewUnstyled.placeholder = @"No controller (unstyled)";
  textViewUnstyled.delegate = self;
  textViewUnstyled.leadingUnderlineLabel.text = @"Leading";
  textViewUnstyled.trailingUnderlineLabel.text = @"Trailing";

  MDCTextView *textViewCharMaxFullWidth = [[MDCTextView alloc] init];
  [self.view addSubview:textViewCharMaxFullWidth];
  textViewCharMaxFullWidth.translatesAutoresizingMaskIntoConstraints = NO;

  textViewCharMaxFullWidth.placeholder = @"Enter up to 50 characters";
  textViewCharMaxFullWidth.delegate = self;
  textViewCharMaxFullWidth.backgroundColor = [UIColor whiteColor];

  MDCTextInputController *textViewControllerDefaultCharMax =
  [[MDCTextInputController alloc] initWithTextInput:textViewCharMaxFullWidth];
  textViewControllerDefaultCharMax.characterCountMax = 50;
  textViewControllerDefaultCharMax.presentationStyle = MDCTextInputPresentationStyleFullWidth;

  MDCTextView *textViewFloating = [[MDCTextView alloc] init];
  [self.view addSubview:textViewFloating];
  textViewFloating.translatesAutoresizingMaskIntoConstraints = NO;

  textViewFloating.placeholder = @"Full Name";
  textViewFloating.delegate = self;

  MDCTextInputController *textViewControllerFloating =
  [[MDCTextInputController alloc] initWithTextInput:textViewFloating];

  textViewControllerFloating.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;

  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"V:|-20-[unstyled]-[charMax]-[floating]"
                        options:0
                        metrics:nil
                        views:@{
                                @"unstyled": textViewUnstyled,
                                @"charMax" : textViewCharMaxFullWidth,
                                @"floating": textViewFloating
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[unstyled]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"unstyled": textViewUnstyled
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|[charMaxFullWidth]|"
                        options:0
                        metrics:nil
                        views:@{
                                @"charMaxFullWidth": textViewCharMaxFullWidth
                                }]];

  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[floating]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"floating": textViewFloating
                                }]];

  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(tapDidTouch)];
  [self.view addGestureRecognizer:tapRecognizer];
}

- (void)tapDidTouch {
  [self.view endEditing:YES];
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"Multiline (Objective C)" ];
}

+ (NSString *)catalogDescription {
  return @"Simple MDCTextView example.";
}

@end
