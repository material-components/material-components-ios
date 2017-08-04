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

#import "MultilineTextFieldExample.h"

#import "MaterialTextFields.h"

@interface MultilineTextFieldExample () <UITextViewDelegate>

// Be sure to keep your controllers in memory somewhere like a property:
@property(nonatomic, strong) MDCTextInputControllerDefault *textFieldControllerDefaultCharMax;
@property(nonatomic, strong) MDCTextInputControllerDefault *textFieldControllerFloating;
@property(nonatomic, strong) MDCTextInputControllerFullWidth *textFieldControllerFullWidth;

@end

@implementation MultilineTextFieldExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];

  self.title = @"Material Multiline Text Fields";

  MDCMultilineTextField *multilineTextFieldUnstyled = [[MDCMultilineTextField alloc] init];
  [self.view addSubview:multilineTextFieldUnstyled];
  multilineTextFieldUnstyled.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldUnstyled.placeholder = @"No Controller (unstyled)";
  multilineTextFieldUnstyled.textView.delegate = self;
  multilineTextFieldUnstyled.leadingUnderlineLabel.text = @"Leading";
  multilineTextFieldUnstyled.trailingUnderlineLabel.text = @"Trailing";

  MDCMultilineTextField *multilineTextFieldUnstyledBox = [[MDCMultilineTextField alloc] init];
  [self.view addSubview:multilineTextFieldUnstyledBox];
  multilineTextFieldUnstyledBox.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldUnstyledBox.placeholder = @"No Controller (unstyled) minimum of 3 lines";
  multilineTextFieldUnstyledBox.textView.delegate = self;
  multilineTextFieldUnstyledBox.leadingUnderlineLabel.text = @"Leading";
  multilineTextFieldUnstyledBox.trailingUnderlineLabel.text = @"Trailing";
  multilineTextFieldUnstyledBox.minimumLines = 3;
  multilineTextFieldUnstyledBox.expandsOnOverflow = NO;

  MDCMultilineTextField *multilineTextFieldFloating = [[MDCMultilineTextField alloc] init];
  [self.view addSubview:multilineTextFieldFloating];
  multilineTextFieldFloating.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldFloating.placeholder = @"Floating Controller";
  multilineTextFieldFloating.textView.delegate = self;

  self.textFieldControllerFloating =
  [[MDCTextInputControllerDefault alloc] initWithTextInput:multilineTextFieldFloating];

  MDCMultilineTextField *multilineTextFieldCharMaxDefault = [[MDCMultilineTextField alloc] init];
  [self.view addSubview:multilineTextFieldCharMaxDefault];
  multilineTextFieldCharMaxDefault.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldCharMaxDefault.placeholder = @"Inline Placeholder Only";
  multilineTextFieldCharMaxDefault.textView.delegate = self;

  self.textFieldControllerDefaultCharMax =
    [[MDCTextInputControllerDefault alloc] initWithTextInput:multilineTextFieldCharMaxDefault];
  self.textFieldControllerDefaultCharMax.characterCountMax = 30;
  self.textFieldControllerDefaultCharMax.floatingEnabled = NO;

  MDCMultilineTextField *multilineTextFieldCharMaxFullWidth = [[MDCMultilineTextField alloc] init];
  [self.view addSubview:multilineTextFieldCharMaxFullWidth];
  multilineTextFieldCharMaxFullWidth.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldCharMaxFullWidth.placeholder = @"Full Width Controller";
  multilineTextFieldCharMaxFullWidth.textView.delegate = self;

  self.textFieldControllerFullWidth =
  [[MDCTextInputControllerFullWidth alloc] initWithTextInput:multilineTextFieldCharMaxFullWidth];
  self.textFieldControllerFullWidth.characterCountMax = 30;

  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"V:|-20-[unstyled]-[box]-[floating]-[charMax]-[fullWidth]"
                        options:0
                        metrics:nil
                        views:@{
                                @"unstyled": multilineTextFieldUnstyled,
                                @"box": multilineTextFieldUnstyledBox,
                                @"charMax" : multilineTextFieldCharMaxDefault,
                                @"floating": multilineTextFieldFloating,
                                @"fullWidth": multilineTextFieldCharMaxFullWidth
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[unstyled]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"unstyled": multilineTextFieldUnstyled
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[box]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"box": multilineTextFieldUnstyledBox
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[floating]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"floating": multilineTextFieldFloating
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[charMax]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"charMax": multilineTextFieldCharMaxDefault
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|[fullWidth]|"
                        options:0
                        metrics:nil
                        views:@{
                                @"fullWidth": multilineTextFieldCharMaxFullWidth
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
  return @"Simple MDCMultilineTextField example.";
}

@end
