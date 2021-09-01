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
  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.97 alpha:1];

  self.title = @"Legacy Multi-line Styles";

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
                                                    views:@{@"scrollView" : self.scrollView}]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{@"scrollView" : self.scrollView}]];

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

  multilineTextFieldFloating.textView.delegate = self;

  self.textFieldControllerFloating =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:multilineTextFieldFloating];
  self.textFieldControllerFloating.placeholderText = @"Floating Controller";

  MDCMultilineTextField *multilineTextFieldCharMaxDefault = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldCharMaxDefault];
  multilineTextFieldCharMaxDefault.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldCharMaxDefault.textView.delegate = self;

  self.textFieldControllerDefaultCharMax = [[MDCTextInputControllerLegacyDefault alloc]
      initWithTextInput:multilineTextFieldCharMaxDefault];
  self.textFieldControllerDefaultCharMax.characterCountMax = 30;
  self.textFieldControllerDefaultCharMax.floatingEnabled = NO;
  self.textFieldControllerDefaultCharMax.placeholderText = @"Inline Placeholder Only";

  MDCMultilineTextField *multilineTextFieldCharMaxFullWidth = [[MDCMultilineTextField alloc] init];
  [self.scrollView addSubview:multilineTextFieldCharMaxFullWidth];
  multilineTextFieldCharMaxFullWidth.translatesAutoresizingMaskIntoConstraints = NO;

  multilineTextFieldCharMaxFullWidth.textView.delegate = self;

  self.textFieldControllerFullWidth = [[MDCTextInputControllerLegacyFullWidth alloc]
      initWithTextInput:multilineTextFieldCharMaxFullWidth];
  self.textFieldControllerFullWidth.characterCountMax = 140;
  self.textFieldControllerFullWidth.placeholderText = @"Full Width Controller";

  id<UILayoutSupport> topGuide = self.topLayoutGuide;
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                                  @"V:[topGuide]-[unstyled]-[area]-[floating]-[charMax]-[fullWidth]"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"topGuide" : topGuide,
                                                      @"unstyled" : multilineTextFieldUnstyled,
                                                      @"area" : multilineTextFieldUnstyledArea,
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
                              constraintsWithVisualFormat:@"H:|-[area]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:@{
                                                      @"area" : multilineTextFieldUnstyledArea
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

  [NSLayoutConstraint activateConstraints:@[
    [NSLayoutConstraint constraintWithItem:multilineTextFieldUnstyled
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView.contentLayoutGuide
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:20],
    [NSLayoutConstraint constraintWithItem:multilineTextFieldCharMaxFullWidth
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView.contentLayoutGuide
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1
                                  constant:-20]
  ]];

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

  [self registerKeyboardNotifications];
}

- (void)tapDidTouch {
  [self.view endEditing:YES];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", @"[Legacy] Multi-line" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
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

@implementation MultilineTextFieldLegacyExample (UITextViewDelegate)

- (void)textViewDidChange:(UITextView *)textView {
  NSLog(@"%@", textView.text);
}

@end
