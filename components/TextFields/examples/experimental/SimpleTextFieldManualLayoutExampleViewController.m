// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
#import "SimpleTextField.h"

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialButtons+ButtonThemer.h"

@interface SimpleTextFieldManualLayoutExampleViewController ()

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) MDCButton *resignFirstResponderButton;
@property(strong, nonatomic) MDCButton *toggleErrorButton;
@property(strong, nonatomic) SimpleTextField *filledTextField;
@property(strong, nonatomic) SimpleTextField *outlinedTextField;
@property(strong, nonatomic) UITextField *uiTextField;

@property(strong, nonatomic) MDCContainerScheme *containerScheme;

@property(nonatomic, assign) BOOL isErrored;

@end

@implementation SimpleTextFieldManualLayoutExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addObservers];
  self.view.backgroundColor = [UIColor whiteColor];
  self.containerScheme = [[MDCContainerScheme alloc] init];
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
  [self addScrollView];
  [self addResignFirstResponderButton];
  [self addToggleErrorButton];
  [self addFilledTextField];
  [self addOutlinedTextField];
  [self addUiTextField];
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
  CGFloat padding = 30;
  CGFloat resignFirstResponderButtonMinX = padding;
  CGFloat resignFirstResponderButtonMinY = padding;
  CGFloat resignFirstResponderButtonWidth = CGRectGetWidth(self.resignFirstResponderButton.frame);
  CGFloat resignFirstResponderButtonHeight = CGRectGetHeight(self.resignFirstResponderButton.frame);
  CGRect resignFirstResponderButtonFrame =
      CGRectMake(resignFirstResponderButtonMinX, resignFirstResponderButtonMinY,
                 resignFirstResponderButtonWidth, resignFirstResponderButtonHeight);
  self.resignFirstResponderButton.frame = resignFirstResponderButtonFrame;

  CGFloat toggleErrorButtonMinX = padding;
  CGFloat toggleErrorButtonMinY =
      resignFirstResponderButtonMinY + resignFirstResponderButtonHeight + padding;
  CGFloat toggleErrorButtonWidth = CGRectGetWidth(self.toggleErrorButton.frame);
  CGFloat toggleErrorButtonHeight = CGRectGetHeight(self.toggleErrorButton.frame);
  CGRect toggleErrorButtonFrame = CGRectMake(toggleErrorButtonMinX, toggleErrorButtonMinY,
                                             toggleErrorButtonWidth, toggleErrorButtonHeight);
  self.toggleErrorButton.frame = toggleErrorButtonFrame;

  CGFloat textFieldWidth = CGRectGetWidth(self.scrollView.frame) - (2 * padding);
  CGSize textFieldFittingSize = CGSizeMake(textFieldWidth, CGFLOAT_MAX);

  CGFloat filledTextFieldMinX = padding;
  CGFloat filledTextFieldMinY = toggleErrorButtonMinY + toggleErrorButtonHeight + padding;
  CGSize filledTextFieldSize = [self.filledTextField sizeThatFits:textFieldFittingSize];
  CGRect filledTextFieldButtonFrame =
      CGRectMake(filledTextFieldMinX, filledTextFieldMinY, filledTextFieldSize.width,
                 filledTextFieldSize.height);
  self.filledTextField.frame = filledTextFieldButtonFrame;
  [self.filledTextField setNeedsLayout];

  CGFloat outlinedTextFieldMinX = padding;
  CGFloat outlinedTextFieldMinY = filledTextFieldMinY + filledTextFieldSize.height + padding;
  CGSize outlinedTextFieldSize = [self.outlinedTextField sizeThatFits:textFieldFittingSize];
  CGRect outlinedTextFieldFrame =
      CGRectMake(outlinedTextFieldMinX, outlinedTextFieldMinY, outlinedTextFieldSize.width,
                 outlinedTextFieldSize.height);
  self.outlinedTextField.frame = outlinedTextFieldFrame;
  [self.outlinedTextField setNeedsLayout];

  CGFloat uiTextFieldMinX = padding;
  CGFloat uiTextFieldMinY = outlinedTextFieldMinY + outlinedTextFieldSize.height + padding;
  CGRect uiTextFieldFrame = CGRectMake(uiTextFieldMinX, uiTextFieldMinY, textFieldWidth,
                                       CGRectGetHeight(self.uiTextField.frame));
  self.uiTextField.frame = uiTextFieldFrame;
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

- (void)addScrollView {
  self.scrollView = [[UIScrollView alloc] init];
  [self.view addSubview:self.scrollView];
}

- (void)addResignFirstResponderButton {
  self.resignFirstResponderButton = [[MDCButton alloc] init];
  [self.resignFirstResponderButton setTitle:@"Resign first responder"
                                   forState:UIControlStateNormal];
  [self.resignFirstResponderButton addTarget:self
                                      action:@selector(resignFirstResponderButtonTapped:)
                            forControlEvents:UIControlEventTouchUpInside];
  [self.resignFirstResponderButton applyContainedThemeWithScheme:self.containerScheme];
  [self.resignFirstResponderButton sizeToFit];
  [self.scrollView addSubview:self.resignFirstResponderButton];
}

- (void)addToggleErrorButton {
  self.toggleErrorButton = [[MDCButton alloc] init];
  [self.toggleErrorButton setTitle:@"Toggle error" forState:UIControlStateNormal];
  [self.toggleErrorButton addTarget:self
                             action:@selector(toggleErrorButtonTapped:)
                   forControlEvents:UIControlEventTouchUpInside];
  [self.toggleErrorButton applyContainedThemeWithScheme:self.containerScheme];
  [self.toggleErrorButton sizeToFit];
  [self.scrollView addSubview:self.toggleErrorButton];
}

- (void)addFilledTextField {
  self.filledTextField = [[SimpleTextField alloc] init];
  self.filledTextField.textFieldStyle = TextFieldStyleFilled;
  self.filledTextField.placeholder = @"This is a placeholder";
  self.filledTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.filledTextField.leadingUnderlineLabel.numberOfLines = 0;
  self.filledTextField.leadingUnderlineLabel.text = @"This is helper text.";
  [self.scrollView addSubview:self.filledTextField];
}

- (void)addOutlinedTextField {
  self.outlinedTextField = [[SimpleTextField alloc] init];
  self.outlinedTextField.textFieldStyle = TextFieldStyleOutline;
  self.outlinedTextField.placeholder = @"This is another placeholder";
  self.outlinedTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  [self.scrollView addSubview:self.outlinedTextField];
}

- (void)addUiTextField {
  self.uiTextField = [[UITextField alloc] init];
  self.uiTextField.borderStyle = UITextBorderStyleRoundedRect;
  self.uiTextField.clearButtonMode = UITextFieldViewModeWhileEditing;


  [self.scrollView addSubview:self.uiTextField];
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
  [self.uiTextField resignFirstResponder];
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
