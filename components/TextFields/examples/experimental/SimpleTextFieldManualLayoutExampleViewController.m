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

#import "SimpleTextFieldManualLayoutExampleViewController.h"

#import "MaterialButtons.h"

#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"
#import "supplemental/MDCSimpleTextField.h"

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialButtons+ButtonThemer.h"

#import "supplemental/MDCSimpleTextField+MaterialTheming.h"

static const NSUInteger kDefaultPadding = 20;

@interface SimpleTextFieldManualLayoutExampleViewController ()

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) NSArray *scrollViewSubviews;

@property(strong, nonatomic) MDCButton *resignFirstResponderButton;
@property(strong, nonatomic) MDCButton *toggleErrorButton;
@property(strong, nonatomic) MDCSimpleTextField *filledTextField;
@property(strong, nonatomic) MDCSimpleTextField *outlinedTextField;
@property(strong, nonatomic) MDCSimpleTextField *unthemedTextField;

@property(nonatomic, assign) BOOL isErrored;

@end

@implementation SimpleTextFieldManualLayoutExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
    containerScheme.colorScheme = [[MDCSemanticColorScheme alloc] init];
    containerScheme.typographyScheme = [[MDCTypographyScheme alloc] init];
    self.containerScheme = containerScheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addObservers];
  self.view.backgroundColor = [UIColor whiteColor];
  [self addSubviews];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self layoutScrollView];
  [self layoutScrollViewSubviews];
  [self updateScrollViewContentSize];
  [self updateToggleButtonTheme];
}

- (void)addObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addSubviews {
  self.scrollView = [[UIScrollView alloc] init];
  [self.view addSubview:self.scrollView];
  self.scrollViewSubviews = @[
    [self createToggleErrorButton],
    [self createFirstResponderButton],
    [self createLabelWithText:@"Filled MDCSimpleTextField:"],
    [self createFilledTextField],
    [self createLabelWithText:@"Outlined MDCSimpleTextField:"],
    [self createOutlinedTextField],
    [self createLabelWithText:@"Unthemed MDCSimpleTextField:"],
    [self createUnthemedSimpleTextField],
  ];
  for (UIView *view in self.scrollViewSubviews) {
    [self.scrollView addSubview:view];
  }
}

- (void)layoutScrollView {
  CGFloat originX = CGRectGetMinX(self.view.bounds);
  CGFloat originY = CGRectGetMinY(self.view.bounds);
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGFloat height = CGRectGetHeight(self.view.bounds);
  if (@available(iOS 11.0, *)) {
    originX += self.view.safeAreaInsets.left;
    originY += self.view.safeAreaInsets.top;
    width -= (self.view.safeAreaInsets.left + self.view.safeAreaInsets.right);
    height -= (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom);
  }
  CGRect frame = CGRectMake(originX, originY, width, height);
  self.scrollView.frame = frame;
}

- (void)layoutScrollViewSubviews {
  CGFloat viewMinX = kDefaultPadding;
  CGFloat viewMinY = kDefaultPadding;
  for (UIView *view in self.scrollViewSubviews) {
    CGSize viewSize = view.frame.size;
    CGFloat textFieldWidth = CGRectGetWidth(self.scrollView.frame) - (2 * kDefaultPadding);
    if ([view isKindOfClass:[MDCSimpleTextField class]]) {
      viewSize = CGSizeMake(textFieldWidth, CGRectGetHeight(view.frame));
    }
    CGRect viewFrame = CGRectMake(viewMinX, viewMinY, viewSize.width, viewSize.height);
    view.frame = viewFrame;
    [view sizeToFit];
    viewMinY = viewMinY + CGRectGetHeight(view.frame) + kDefaultPadding;
  }
}

- (void)updateScrollViewContentSize {
  CGFloat maxX = CGRectGetWidth(self.scrollView.bounds);
  CGFloat maxY = CGRectGetHeight(self.scrollView.bounds);
  for (UIView *subview in self.scrollView.subviews) {
    CGFloat subViewMaxX = CGRectGetMaxX(subview.frame);
    if (subViewMaxX > maxX) {
      maxX = subViewMaxX;
    }
    CGFloat subViewMaxY = CGRectGetMaxY(subview.frame);
    if (subViewMaxY > maxY) {
      maxY = subViewMaxY;
    }
  }
  self.scrollView.contentSize = CGSizeMake(maxX, maxY);
}

- (MDCButton *)createFirstResponderButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Resign first responder" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(resignFirstResponderButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  self.resignFirstResponderButton = button;
  return button;
}

- (MDCButton *)createToggleErrorButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Toggle error" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(toggleErrorButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
  self.toggleErrorButton = button;
  return button;
}

- (UILabel *)createLabelWithText:(NSString *)text {
  UILabel *label = [[UILabel alloc] init];
  label.textColor = self.containerScheme.colorScheme.primaryColor;
  label.font = self.containerScheme.typographyScheme.subtitle2;
  label.text = text;
  return label;
}

- (MDCSimpleTextField *)createFilledTextField {
  MDCSimpleTextField *textField = [[MDCSimpleTextField alloc] init];
  [textField applyFilledThemeWithScheme:self.containerScheme];
  textField.placeholder = @"This is a placeholder";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  textField.leadingUnderlineLabel.numberOfLines = 0;
  textField.leadingUnderlineLabel.text = @"This is helper text.";
  self.filledTextField = textField;
  return textField;
}

- (MDCSimpleTextField *)createOutlinedTextField {
  MDCSimpleTextField *textField = [[MDCSimpleTextField alloc] init];
  [textField applyOutlinedThemeWithScheme:self.containerScheme];
  textField.placeholder = @"This is another placeholder";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.outlinedTextField = textField;
  return textField;
}

- (MDCSimpleTextField *)createUnthemedSimpleTextField {
  MDCSimpleTextField *textField = [[MDCSimpleTextField alloc] init];
  textField.placeholder = @"Placeholder City!";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.unthemedTextField = textField;
  return textField;
}

#pragma mark Private

- (void)updateToggleButtonTheme {
  if (self.isErrored) {
    MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
    colorScheme.primaryColor = colorScheme.errorColor;
    MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
    containerScheme.colorScheme = colorScheme;
    [self.toggleErrorButton applyContainedThemeWithScheme:containerScheme];
  } else {
    [self.toggleErrorButton applyOutlinedThemeWithScheme:self.containerScheme];
  }
}

- (void)updateTextFieldStates {
  if (self.isErrored) {
    self.filledTextField.isErrored = YES;
    self.filledTextField.leadingUnderlineLabel.text =
        @"Suspendisse quam elit, mattis sit amet justo vel, venenatis lobortis massa. Donec metus "
        @"dolor.";

    self.outlinedTextField.isErrored = YES;
    self.outlinedTextField.leadingUnderlineLabel.text = @"This is an error.";
    self.outlinedTextField.leadingUnderlineLabel.numberOfLines = 0;
  } else {
    self.filledTextField.isErrored = NO;
    self.filledTextField.leadingUnderlineLabel.text = @"This is helper text.";

    self.outlinedTextField.isErrored = NO;
    self.outlinedTextField.leadingUnderlineLabel.text = nil;
  }
  [self.view setNeedsLayout];
}

- (void)keyboardWillShow:(NSNotification *)notification {
  CGRect frame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(frame), 0);
}

- (void)keyboardWillHide:(NSNotification *)notification {
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark IBActions

- (void)resignFirstResponderButtonTapped:(UIButton *)button {
  [self.filledTextField resignFirstResponder];
  [self.outlinedTextField resignFirstResponder];
}

- (void)toggleErrorButtonTapped:(UIButton *)button {
  self.isErrored = !self.isErrored;
  [self updateToggleButtonTheme];
  [self updateTextFieldStates];
}

#pragma mark Catalog By Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", @"Simple Text Field (Manual Layout)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
