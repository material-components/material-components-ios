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

@interface MultilineTextFieldLegacyExample : UIViewController <UITextViewDelegate>

// Be sure to keep your controllers in memory somewhere like a property:
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *textFieldControllerDefaultCharMax;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *textFieldControllerFloating;
@property(nonatomic, strong) MDCTextInputControllerLegacyFullWidth *textFieldControllerFullWidth;
@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MultilineTextFieldLegacyExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];

  self.title = @"Legacy Multiline Styles";

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

  MDCMultilineTextField *multilineTextFieldUnstyled = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldUnstyled];
  multilineTextFieldUnstyled.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldUnstyled.placeholder = @"No Controller (unstyled)";
  multilineTextFieldUnstyled.textView.delegate = self;
  multilineTextFieldUnstyled.leadingUnderlineLabel.text = @"Leading";
  multilineTextFieldUnstyled.trailingUnderlineLabel.text = @"Trailing";

  MDCMultilineTextField *multilineTextFieldUnstyledBox = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldUnstyledBox];
  multilineTextFieldUnstyledBox.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldUnstyledBox.placeholder = @"No Controller (unstyled) minimum of 3 lines";
  multilineTextFieldUnstyledBox.textView.delegate = self;
  multilineTextFieldUnstyledBox.leadingUnderlineLabel.text = @"Leading";
  multilineTextFieldUnstyledBox.trailingUnderlineLabel.text = @"Trailing";
  multilineTextFieldUnstyledBox.minimumLines = 3;
  multilineTextFieldUnstyledBox.expandsOnOverflow = NO;

  MDCMultilineTextField *multilineTextFieldFloating = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldFloating];
  multilineTextFieldFloating.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldFloating.placeholder = @"Floating Controller";
  multilineTextFieldFloating.textView.delegate = self;

  self.textFieldControllerFloating =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:multilineTextFieldFloating];

  MDCMultilineTextField *multilineTextFieldCharMaxDefault = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldCharMaxDefault];
  multilineTextFieldCharMaxDefault.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldCharMaxDefault.placeholder = @"Inline Placeholder Only";
  multilineTextFieldCharMaxDefault.textView.delegate = self;

  self.textFieldControllerDefaultCharMax =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:multilineTextFieldCharMaxDefault];
  self.textFieldControllerDefaultCharMax.characterCountMax = 30;
  self.textFieldControllerDefaultCharMax.floatingEnabled = NO;

  MDCMultilineTextField *multilineTextFieldCharMaxFullWidth = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldCharMaxFullWidth];
  multilineTextFieldCharMaxFullWidth.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldCharMaxFullWidth.placeholder = @"Full Width Controller";
  multilineTextFieldCharMaxFullWidth.textView.delegate = self;

  self.textFieldControllerFullWidth = [[MDCTextInputControllerLegacyFullWidth alloc]
      initWithTextInput:multilineTextFieldCharMaxFullWidth];
  self.textFieldControllerFullWidth.characterCountMax = 140;

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                                  @"V:|-20-[unstyled]-[box]-[floating]-[charMax]-[fullWidth]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"unstyled" : multilineTextFieldUnstyled,
                                                      @"box" : multilineTextFieldUnstyledBox,
                                                      @"charMax" : multilineTextFieldCharMaxDefault,
                                                      @"floating" : multilineTextFieldFloating,
                                                      @"fullWidth" :
                                                          multilineTextFieldCharMaxFullWidth
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
                              constraintsWithVisualFormat:@"H:|-[box]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"box" : multilineTextFieldUnstyledBox
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
  return @[ @"Text Field", @"[Legacy] Multiline (Objective C)" ];
}

+ (NSString *)catalogDescription {
  return @"Simple Legacy MDCMultilineTextField example.";
}

@end

@implementation MultilineTextFieldLegacyExample (UITextViewDelegate)

- (void)textViewDidChange:(UITextView *)textView {
  NSLog(@"%@", textView.text);
}

@end
