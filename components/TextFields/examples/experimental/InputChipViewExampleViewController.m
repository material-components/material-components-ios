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

#import "InputChipViewExampleViewController.h"

#import "MaterialButtons.h"

#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"
#import "InputChipView.h"

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialButtons+ButtonThemer.h"

@interface InputChipViewExampleViewController () <UITextFieldDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) MDCButton *resignFirstResponderButton;
@property(strong, nonatomic) MDCButton *toggleErrorButton;
@property(strong, nonatomic) InputChipView *nonWrappingInputChipView;
@property(strong, nonatomic) InputChipView *wrappingInputChipView;
@property(strong, nonatomic) UITextField *uiTextField;

@property(strong, nonatomic) MDCContainerScheme *containerScheme;

@property(nonatomic, assign) BOOL isErrored;

@end

@implementation InputChipViewExampleViewController

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
  [self addNonWrappingInputChipView];
  [self addWrappingInputChipView];
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

  CGFloat inputChipViewWidth = CGRectGetWidth(self.scrollView.frame) - (2 * padding);
//  CGSize inputChipViewFittingSize = CGSizeMake(inputChipViewWidth, CGFLOAT_MAX);

  CGFloat nonWrappingInputChipViewMinX = padding;
  CGFloat nonWrappingInputChipViewMinY = toggleErrorButtonMinY + toggleErrorButtonHeight + padding;
  CGSize nonWrappingInputChipViewSize = CGSizeMake(inputChipViewWidth, 60);
  CGRect nonWrappingInputChipViewButtonFrame =
      CGRectMake(nonWrappingInputChipViewMinX, nonWrappingInputChipViewMinY, nonWrappingInputChipViewSize.width,
                 nonWrappingInputChipViewSize.height);
  self.nonWrappingInputChipView.frame = nonWrappingInputChipViewButtonFrame;
  [self.nonWrappingInputChipView setNeedsLayout];

  CGFloat wrappingInputChipViewMinX = padding;
  CGFloat wrappingInputChipViewMinY = nonWrappingInputChipViewMinY + nonWrappingInputChipViewSize.height + padding;
  CGSize wrappingInputChipViewSize = CGSizeMake(inputChipViewWidth, 150);
  CGRect wrappingInputChipViewFrame =
      CGRectMake(wrappingInputChipViewMinX, wrappingInputChipViewMinY, wrappingInputChipViewSize.width,
                 wrappingInputChipViewSize.height);
  self.wrappingInputChipView.frame = wrappingInputChipViewFrame;
  [self.wrappingInputChipView setNeedsLayout];
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

- (void)addNonWrappingInputChipView {
  self.nonWrappingInputChipView = [[InputChipView alloc] init];
  self.nonWrappingInputChipView.canChipsWrap = NO;
  [self.scrollView addSubview:self.nonWrappingInputChipView];
  self.nonWrappingInputChipView.textField.delegate = self;
  self.nonWrappingInputChipView.layer.borderColor = [UIColor blackColor].CGColor;
  self.nonWrappingInputChipView.layer.borderWidth = 1;
}

- (void)addWrappingInputChipView {
  self.wrappingInputChipView = [[InputChipView alloc] init];
  self.wrappingInputChipView.canChipsWrap = YES;
  self.wrappingInputChipView.contentInsets = UIEdgeInsetsMake(8, 12, 8, 12);
  self.wrappingInputChipView.chipRowHeight = 50;
  [self.scrollView addSubview:self.wrappingInputChipView];
  self.wrappingInputChipView.textField.delegate = self;
  self.wrappingInputChipView.layer.borderColor = [UIColor blackColor].CGColor;
  self.wrappingInputChipView.layer.borderWidth = 1;
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

- (void)updateInputChipViewStates {
//  if (self.isErrored) {
//    self.nonWrappingInputChipView.isErrored = YES;
//    self.nonWrappingInputChipView.leadingUnderlineLabel.text =
//        @"Suspendisse quam elit, mattis sit amet justo vel, venenatis lobortis massa. Donec metus "
//        @"dolor.";
//
//    self.wrappingInputChipView.isErrored = YES;
//    self.wrappingInputChipView.leadingUnderlineLabel.text = @"This is an error.";
//    self.wrappingInputChipView.leadingUnderlineLabel.numberOfLines = 0;
//  } else {
//    self.nonWrappingInputChipView.isErrored = NO;
//    self.nonWrappingInputChipView.leadingUnderlineLabel.text = @"This is helper text.";
//
//    self.wrappingInputChipView.isErrored = NO;
//    self.wrappingInputChipView.leadingUnderlineLabel.text = nil;
//  }
//  [self.view setNeedsLayout];
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
//  [self.nonWrappingInputChipView resignFirstResponder];
//  [self.wrappingInputChipView resignFirstResponder];
//  [self.uiTextField resignFirstResponder];
  [self.nonWrappingInputChipView resignFirstResponder];
  [self.wrappingInputChipView resignFirstResponder];
}

- (void)toggleErrorButtonTapped:(UIButton *)button {
  self.isErrored = !self.isErrored;
  [self updateToggleButtonTheme];
  [self updateInputChipViewStates];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.nonWrappingInputChipView.textField) {
    if (textField.text.length > 0) {
      MDCChipView *chipView = [[MDCChipView alloc] init];
      chipView.titleLabel.text = textField.text;
      [chipView sizeToFit];
      [chipView addTarget:self
                   action:@selector(selectedChip:)
         forControlEvents:UIControlEventTouchUpInside];
      [self.nonWrappingInputChipView addChip:chipView];
    }
  } else if (textField == self.wrappingInputChipView.textField) {
    if (textField.text.length > 0) {
      MDCChipView *chipView = [[MDCChipView alloc] init];
      chipView.titleLabel.text = textField.text;
      [chipView sizeToFit];
      [chipView addTarget:self
                   action:@selector(selectedChip:)
         forControlEvents:UIControlEventTouchUpInside];
      [self.wrappingInputChipView addChip:chipView];
    }
  }
  return NO;
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//  const char *character = [string cStringUsingEncoding:NSUTF8StringEncoding];
//  int isBackSpace = strcmp(character, "\\b");
//  if (isBackSpace == -92) {
//    NSLog(@"Backspace was pressed");
//  }
//  return true;
//}

#pragma mark User Interaction

- (void)selectedChip:(MDCChipView *)chip {
  chip.selected = !chip.selected;
  NSLog(@"%@",@(chip.isHighlighted));
}

#pragma mark Catalog By Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", @"Input Chip View" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
