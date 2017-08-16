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

@interface MultilineTextFieldExample : UIViewController <UITextViewDelegate>

// Be sure to keep your controllers in memory somewhere like a property:
@property(nonatomic, strong) MDCTextInputControllerTextArea *textFieldControllerTextArea;
@property(nonatomic, strong) MDCTextInputControllerTextFieldBox *textFieldControllerTextFieldBox;
@property(nonatomic, strong) MDCTextInputControllerTextFieldBox *textFieldControllerTextAreaBox;
@property(nonatomic, strong) MDCTextInputControllerDefault *textFieldControllerDefaultCharMax;
@property(nonatomic, strong) MDCTextInputControllerDefault *textFieldControllerFloating;
@property(nonatomic, strong) MDCTextInputControllerFullWidth *textFieldControllerFullWidth;
@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MultilineTextFieldExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];

  self.title = @"Material Multiline Text Fields";

  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  [self.view addSubview:self.scrollView];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

  UIEdgeInsets margins = UIEdgeInsetsMake(0, 16, 0, 16);
  self.scrollView.layoutMargins = margins;

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"scrollView" : self.scrollView
                                                    }]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"scrollView" : self.scrollView
                                                    }]];

  MDCMultilineTextField *multilineTextFieldTextArea = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldTextArea];
  multilineTextFieldTextArea.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldTextArea.placeholder = @"Text Area";
  multilineTextFieldTextArea.textView.delegate = self;

  self.textFieldControllerTextArea =
      [[MDCTextInputControllerTextArea alloc] initWithTextInput:multilineTextFieldTextArea];

  MDCMultilineTextField *multilineTextFieldTextBox = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldTextBox];
  multilineTextFieldTextBox.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldTextBox.placeholder = @"Text Field Box";
  multilineTextFieldTextBox.textView.delegate = self;

  self.textFieldControllerTextFieldBox =
      [[MDCTextInputControllerTextFieldBox alloc] initWithTextInput:multilineTextFieldTextBox];

  MDCMultilineTextField *multilineTextFieldTextAreaBox = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldTextAreaBox];
  multilineTextFieldTextAreaBox.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldTextAreaBox.placeholder = @"Text Area Box";
  multilineTextFieldTextAreaBox.textView.delegate = self;

  self.textFieldControllerTextAreaBox =
      [[MDCTextInputControllerTextFieldBox alloc] initWithTextInput:multilineTextFieldTextAreaBox];
  self.textFieldControllerTextAreaBox.minimumLines = 5;
  self.textFieldControllerTextAreaBox.expandsOnOverflow = NO;

  MDCMultilineTextField *multilineTextFieldUnstyled = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldUnstyled];
  multilineTextFieldUnstyled.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldUnstyled.placeholder = @"No Controller (unstyled)";
  multilineTextFieldUnstyled.textView.delegate = self;
  multilineTextFieldUnstyled.leadingUnderlineLabel.text = @"Leading";
  multilineTextFieldUnstyled.trailingUnderlineLabel.text = @"Trailing";

  MDCMultilineTextField *multilineTextFieldUnstyledArea = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldUnstyledArea];
  multilineTextFieldUnstyledArea.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldUnstyledArea.placeholder = @"No Controller (unstyled) minimum of 3 lines";
  multilineTextFieldUnstyledArea.textView.delegate = self;
  multilineTextFieldUnstyledArea.leadingUnderlineLabel.text = @"Leading";
  multilineTextFieldUnstyledArea.trailingUnderlineLabel.text = @"Trailing";
  multilineTextFieldUnstyledArea.minimumLines = 3;
  multilineTextFieldUnstyledArea.expandsOnOverflow = NO;

  MDCMultilineTextField *multilineTextFieldFloating = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldFloating];
  multilineTextFieldFloating.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldFloating.placeholder = @"Floating Controller";
  multilineTextFieldFloating.textView.delegate = self;

  self.textFieldControllerFloating =
      [[MDCTextInputControllerDefault alloc] initWithTextInput:multilineTextFieldFloating];

  MDCMultilineTextField *multilineTextFieldCharMaxDefault = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldCharMaxDefault];
  multilineTextFieldCharMaxDefault.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldCharMaxDefault.placeholder = @"Inline Placeholder Only";
  multilineTextFieldCharMaxDefault.textView.delegate = self;

  self.textFieldControllerDefaultCharMax =
      [[MDCTextInputControllerDefault alloc] initWithTextInput:multilineTextFieldCharMaxDefault];
  self.textFieldControllerDefaultCharMax.characterCountMax = 30;
  self.textFieldControllerDefaultCharMax.floatingEnabled = NO;

  MDCMultilineTextField *multilineTextFieldCharMaxFullWidth = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldCharMaxFullWidth];
  multilineTextFieldCharMaxFullWidth.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldCharMaxFullWidth.placeholder = @"Full Width Controller";
  multilineTextFieldCharMaxFullWidth.textView.delegate = self;

  self.textFieldControllerFullWidth = [[MDCTextInputControllerFullWidth alloc]
      initWithTextInput:multilineTextFieldCharMaxFullWidth];
  self.textFieldControllerFullWidth.characterCountMax = 140;

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                                  @"V:|-20-[textArea]-[textBox]-[textAreaBox]-[unstyled]-[unstyledArea]-[floating]-[charMax]-[fullWidth]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                            @"textArea" : multilineTextFieldTextArea,
                                                            @"textBox" : multilineTextFieldTextBox,
                                                            @"textAreaBox" : multilineTextFieldTextAreaBox,
                                                            @"unstyled" : multilineTextFieldUnstyled,
                                                      @"unstyledArea" : multilineTextFieldUnstyledArea,
                                                      @"charMax" : multilineTextFieldCharMaxDefault,
                                                      @"floating" : multilineTextFieldFloating,
                                                      @"fullWidth" :
                                                          multilineTextFieldCharMaxFullWidth
                                                    }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[textArea]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"textArea" : multilineTextFieldTextArea
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[textBox]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"textBox" : multilineTextFieldTextBox
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-[textAreaBox]-|"
                        options:0
                        metrics:nil
                        views:@{
                                @"textAreaBox" : multilineTextFieldTextAreaBox
                                }]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[unstyled]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"unstyled" : multilineTextFieldUnstyled
                                                    }]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[unstyledArea]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"unstyledArea" : multilineTextFieldUnstyledArea
                                                    }]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[floating]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"floating" : multilineTextFieldFloating
                                                    }]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[charMax]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"charMax" : multilineTextFieldCharMaxDefault
                                                    }]];

  [NSLayoutConstraint constraintWithItem:multilineTextFieldCharMaxFullWidth
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:multilineTextFieldCharMaxFullWidth
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[fullWidth]|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"fullWidth" :
                                                          multilineTextFieldCharMaxFullWidth
                                                    }]];

  UITapGestureRecognizer *tapRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidTouch)];
  [self.view addGestureRecognizer:tapRecognizer];

  [[NSNotificationCenter defaultCenter]
      addObserverForName:UIKeyboardWillShowNotification
                  object:nil
                   queue:[NSOperationQueue mainQueue]
              usingBlock:^(NSNotification *_Nonnull note) {
                CGRect frame =
                    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
                self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(frame), 0);
              }];
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

@implementation MultilineTextFieldExample (UITextViewDelegate)

- (void)textViewDidChange:(UITextView *)textView {
  NSLog(@"%@", textView.text);
}

@end
