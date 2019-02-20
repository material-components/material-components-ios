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

#import "InputChipViewExampleViewController.h"

#import "MaterialButtons.h"

#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"
#import "supplemental/InputChipView.h"

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialChips.h"

#import "supplemental/InputChipView+MaterialTheming.h"

static const CGFloat kSideMargin = (CGFloat)30.0;

@interface InputChipViewExampleViewController () <UITextFieldDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) MDCButton *resignFirstResponderButton;
@property(strong, nonatomic) MDCButton *toggleErrorButton;
@property(strong, nonatomic) InputChipView *filledNonWrappingInputChipView;
@property(strong, nonatomic) InputChipView *filledWrappingInputChipView;
@property(strong, nonatomic) InputChipView *outlinedNonWrappingInputChipView;
@property(strong, nonatomic) InputChipView *outlinedWrappingInputChipView;

@property(strong, nonatomic) MDCContainerScheme *containerScheme;

@property(nonatomic, assign) BOOL isErrored;

@end

@implementation InputChipViewExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addObservers];
  [self setUpContainerScheme];
  self.view.backgroundColor = [UIColor whiteColor];
  [self addSubviews];
}

- (void)setUpContainerScheme {
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.typographyScheme = [[MDCTypographyScheme alloc] init];
  self.containerScheme.colorScheme = [[MDCSemanticColorScheme alloc] init];
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
  [self addOutlinedWrappingInputChipView];
  [self addOutlinedNonWrappingInputChipView];
  [self addFilledWrappingInputChipView];
  [self addFilledNonWrappingInputChipView];
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
  CGFloat resignFirstResponderButtonMinX = kSideMargin;
  CGFloat resignFirstResponderButtonMinY = kSideMargin;
  CGFloat resignFirstResponderButtonWidth = CGRectGetWidth(self.resignFirstResponderButton.frame);
  CGFloat resignFirstResponderButtonHeight = CGRectGetHeight(self.resignFirstResponderButton.frame);
  CGRect resignFirstResponderButtonFrame =
      CGRectMake(resignFirstResponderButtonMinX, resignFirstResponderButtonMinY,
                 resignFirstResponderButtonWidth, resignFirstResponderButtonHeight);
  self.resignFirstResponderButton.frame = resignFirstResponderButtonFrame;

  CGFloat toggleErrorButtonMinX = kSideMargin;
  CGFloat toggleErrorButtonMinY =
      resignFirstResponderButtonMinY + resignFirstResponderButtonHeight + kSideMargin;
  CGFloat toggleErrorButtonWidth = CGRectGetWidth(self.toggleErrorButton.frame);
  CGFloat toggleErrorButtonHeight = CGRectGetHeight(self.toggleErrorButton.frame);
  CGRect toggleErrorButtonFrame = CGRectMake(toggleErrorButtonMinX, toggleErrorButtonMinY,
                                             toggleErrorButtonWidth, toggleErrorButtonHeight);
  self.toggleErrorButton.frame = toggleErrorButtonFrame;

  CGFloat inputChipViewMinX = kSideMargin;
  CGFloat inputChipViewWidth = CGRectGetWidth(self.scrollView.frame) - (2 * kSideMargin);

  CGFloat outlinedNonWrappingInputChipViewMinY =
      toggleErrorButtonMinY + toggleErrorButtonHeight + kSideMargin;
  CGRect temporaryOutlinedNonWrappingInputChipViewFrame =
      CGRectMake(inputChipViewMinX, outlinedNonWrappingInputChipViewMinY, inputChipViewWidth, 0);
  self.outlinedNonWrappingInputChipView.frame = temporaryOutlinedNonWrappingInputChipViewFrame;
  [self.outlinedNonWrappingInputChipView sizeToFit];
  [self.outlinedNonWrappingInputChipView setNeedsLayout];

  CGFloat outlinedWrappingInputChipViewMinY =
      CGRectGetMaxY(self.outlinedNonWrappingInputChipView.frame) + kSideMargin;
  CGRect temporaryOutlinedWrappingInputChipViewFrame =
      CGRectMake(inputChipViewMinX, outlinedWrappingInputChipViewMinY, inputChipViewWidth, 0);
  self.outlinedWrappingInputChipView.frame = temporaryOutlinedWrappingInputChipViewFrame;
  [self.outlinedWrappingInputChipView sizeToFit];
  [self.outlinedWrappingInputChipView setNeedsLayout];

  CGFloat filledNonWrappingInputChipViewMinY =
      CGRectGetMaxY(self.outlinedWrappingInputChipView.frame) + kSideMargin;
  CGRect temporaryFilledNonWrappingInputChipViewFrame =
      CGRectMake(inputChipViewMinX, filledNonWrappingInputChipViewMinY, inputChipViewWidth, 0);
  self.filledNonWrappingInputChipView.frame = temporaryFilledNonWrappingInputChipViewFrame;
  [self.filledNonWrappingInputChipView sizeToFit];
  [self.filledNonWrappingInputChipView setNeedsLayout];

  CGFloat filledWrappingWrappingInputChipViewMinY =
      CGRectGetMaxY(self.filledNonWrappingInputChipView.frame) + kSideMargin;
  CGRect temporaryFilledWrappingInputChipViewFrame =
      CGRectMake(inputChipViewMinX, filledWrappingWrappingInputChipViewMinY, inputChipViewWidth, 0);
  self.filledWrappingInputChipView.frame = temporaryFilledWrappingInputChipViewFrame;
  [self.filledWrappingInputChipView sizeToFit];
  [self.filledWrappingInputChipView setNeedsLayout];
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

- (void)addOutlinedNonWrappingInputChipView {
  InputChipView *outlinedNonWrappingInputChipView = [[InputChipView alloc] init];
  outlinedNonWrappingInputChipView.textField.placeholder = @"Outlined non-wrapping";
  [outlinedNonWrappingInputChipView applyOutlinedThemeWithScheme:self.containerScheme];
  outlinedNonWrappingInputChipView.chipsWrap = NO;
  outlinedNonWrappingInputChipView.canPlaceholderFloat = YES;
  outlinedNonWrappingInputChipView.chipRowHeight = self.chipHeight;
  [outlinedNonWrappingInputChipView sizeToFit];
  [self.scrollView addSubview:outlinedNonWrappingInputChipView];
  outlinedNonWrappingInputChipView.textField.delegate = self;
  self.outlinedNonWrappingInputChipView = outlinedNonWrappingInputChipView;
}

- (void)addOutlinedWrappingInputChipView {
  InputChipView *outlinedWrappingInputChipView = [[InputChipView alloc] init];
  outlinedWrappingInputChipView.textField.placeholder = @"Outlined wrapping";
  [outlinedWrappingInputChipView applyOutlinedThemeWithScheme:self.containerScheme];
  outlinedWrappingInputChipView.chipsWrap = YES;
  outlinedWrappingInputChipView.preferredMainContentAreaHeight = 120;
  outlinedWrappingInputChipView.canPlaceholderFloat = YES;
  outlinedWrappingInputChipView.chipRowHeight = self.chipHeight;
  [outlinedWrappingInputChipView sizeToFit];
  [self.scrollView addSubview:outlinedWrappingInputChipView];
  outlinedWrappingInputChipView.textField.delegate = self;
  self.outlinedWrappingInputChipView = outlinedWrappingInputChipView;
}

- (void)addFilledNonWrappingInputChipView {
  InputChipView *filledNonWrappingInputChipView = [[InputChipView alloc] init];
  filledNonWrappingInputChipView.textField.placeholder = @"Filled non-wrapping";
  [filledNonWrappingInputChipView applyFilledThemeWithScheme:self.containerScheme];
  filledNonWrappingInputChipView.chipsWrap = NO;
  filledNonWrappingInputChipView.canPlaceholderFloat = YES;
  filledNonWrappingInputChipView.chipRowHeight = self.chipHeight;
  [filledNonWrappingInputChipView sizeToFit];
  [self.scrollView addSubview:filledNonWrappingInputChipView];
  filledNonWrappingInputChipView.textField.delegate = self;
  self.filledNonWrappingInputChipView = filledNonWrappingInputChipView;
}

- (void)addFilledWrappingInputChipView {
  InputChipView *filledWrappingInputChipView = [[InputChipView alloc] init];
  filledWrappingInputChipView.textField.placeholder = @"Outlined wrapping";
  [filledWrappingInputChipView applyFilledThemeWithScheme:self.containerScheme];
  filledWrappingInputChipView.chipsWrap = YES;
  filledWrappingInputChipView.preferredMainContentAreaHeight = 120;
  filledWrappingInputChipView.canPlaceholderFloat = YES;
  filledWrappingInputChipView.chipRowHeight = self.chipHeight;
  [filledWrappingInputChipView sizeToFit];
  [self.scrollView addSubview:filledWrappingInputChipView];
  filledWrappingInputChipView.textField.delegate = self;
  self.filledWrappingInputChipView = filledWrappingInputChipView;
}

- (CGFloat)chipHeight {
  MDCChipView *chip = [self createChipWithText:@"Test"
                                          font:self.filledWrappingInputChipView.textField.font];
  return CGRectGetHeight(chip.frame);
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
  if (self.isErrored) {
    self.filledNonWrappingInputChipView.isErrored = YES;
    self.filledNonWrappingInputChipView.leadingUnderlineLabel.text =
        @"Suspendisse quam elit, mattis sit amet justo vel, venenatis lobortis massa. Donec metus "
        @"dolor.";

    self.filledWrappingInputChipView.isErrored = YES;
    self.filledWrappingInputChipView.leadingUnderlineLabel.text = @"This is an error.";
    self.filledWrappingInputChipView.leadingUnderlineLabel.numberOfLines = 0;

    self.outlinedNonWrappingInputChipView.isErrored = YES;
    self.outlinedNonWrappingInputChipView.leadingUnderlineLabel.text =
        @"Suspendisse quam elit, mattis sit amet justo vel, venenatis lobortis massa. Donec metus "
        @"dolor.";

    self.outlinedWrappingInputChipView.isErrored = YES;
    self.outlinedWrappingInputChipView.leadingUnderlineLabel.text = @"This is an error.";
    self.outlinedWrappingInputChipView.leadingUnderlineLabel.numberOfLines = 0;
  } else {
    self.filledNonWrappingInputChipView.isErrored = NO;
    self.filledNonWrappingInputChipView.leadingUnderlineLabel.text = @"This is helper text.";

    self.filledWrappingInputChipView.isErrored = NO;
    self.filledWrappingInputChipView.leadingUnderlineLabel.text = nil;

    self.outlinedNonWrappingInputChipView.isErrored = NO;
    self.outlinedNonWrappingInputChipView.leadingUnderlineLabel.text = @"This is helper text.";

    self.outlinedWrappingInputChipView.isErrored = NO;
    self.outlinedWrappingInputChipView.leadingUnderlineLabel.text = nil;
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

- (MDCChipView *)createChipWithText:(NSString *)text font:(UIFont *)font {
  MDCChipView *chipView = [[MDCChipView alloc] init];
  chipView.titleLabel.text = text;
  chipView.titleLabel.font = font;
  [chipView sizeToFit];
  [chipView addTarget:self
                action:@selector(selectedChip:)
      forControlEvents:UIControlEventTouchUpInside];
  return chipView;
}

#pragma mark IBActions

- (void)resignFirstResponderButtonTapped:(UIButton *)button {
  [self.filledNonWrappingInputChipView resignFirstResponder];
  [self.filledWrappingInputChipView resignFirstResponder];
  [self.outlinedNonWrappingInputChipView resignFirstResponder];
  [self.outlinedWrappingInputChipView resignFirstResponder];
}

- (void)toggleErrorButtonTapped:(UIButton *)button {
  self.isErrored = !self.isErrored;
  [self updateToggleButtonTheme];
  [self updateInputChipViewStates];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField.text.length <= 0) {
    return NO;
  }
  MDCChipView *chipView = [self createChipWithText:textField.text font:textField.font];
  InputChipView *inputChipView = nil;
  if (textField == self.filledNonWrappingInputChipView.textField) {
    inputChipView = self.filledNonWrappingInputChipView;
  } else if (textField == self.filledWrappingInputChipView.textField) {
    inputChipView = self.filledWrappingInputChipView;
  } else if (textField == self.outlinedWrappingInputChipView.textField) {
    inputChipView = self.outlinedWrappingInputChipView;
  } else if (textField == self.outlinedNonWrappingInputChipView.textField) {
    inputChipView = self.outlinedNonWrappingInputChipView;
  }
  [inputChipView addChip:chipView];
  return NO;
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
// replacementString:(NSString *)string {
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
  NSLog(@"%@", @(chip.isHighlighted));
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
