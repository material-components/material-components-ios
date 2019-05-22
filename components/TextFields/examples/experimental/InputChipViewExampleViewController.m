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

static const CGFloat kSideMargin = (CGFloat)20.0;

@interface InputChipViewExampleViewController () <UITextFieldDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) NSArray *scrollViewSubviews;

@property(strong, nonatomic) MDCContainerScheme *containerScheme;

@property(nonatomic, assign) BOOL isErrored;

@end

@implementation InputChipViewExampleViewController

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
  [self updateButtonThemes];
  [self updateLabelColors];
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
    [self createResignFirstResponderButton],
    [self createLabelWithText:@"High density outlined InputChipView:"],
    [self createOutlinedNonWrappingInputChipViewWithMaximalDensity],
    [self createLabelWithText:@"Average density outlined InputChipView:"],
    [self createOutlinedNonWrappingInputChipView],
    [self createLabelWithText:@"Low density outlined InputChipView:"],
    [self createOutlinedNonWrappingInputChipViewWithMinimalDensity],
    [self createLabelWithText:@"Wrapping outlined InputChipView:"],
    [self createOutlinedWrappingInputChipView],
    [self createLabelWithText:@"High density filled InputChipView:"],
    [self createFilledNonWrappingInputChipViewWithMaximalDensity],
    [self createLabelWithText:@"Average density filled InputChipView:"],
    [self createFilledNonWrappingInputChipView],
    [self createLabelWithText:@"Low density filled InputChipView:"],
    [self createFilledNonWrappingInputChipViewWithMinimalDensity],
    [self createLabelWithText:@"Wrapping filled InputChipView:"],
    [self createFilledWrappingInputChipView],
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
  CGFloat viewMinX = kSideMargin;
  CGFloat viewMinY = kSideMargin;
  for (UIView *view in self.scrollViewSubviews) {
    CGSize viewSize = view.frame.size;
    CGFloat textFieldWidth = CGRectGetWidth(self.scrollView.frame) - (2 * kSideMargin);
    if ([view isKindOfClass:[InputChipView class]]) {
      viewSize = CGSizeMake(textFieldWidth, CGRectGetHeight(view.frame));
    }
    CGRect viewFrame = CGRectMake(viewMinX, viewMinY, viewSize.width, viewSize.height);
    view.frame = viewFrame;
    [view sizeToFit];
    viewMinY = viewMinY + CGRectGetHeight(view.frame) + kSideMargin;
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
  self.scrollView.contentSize = CGSizeMake(maxX, maxY + kSideMargin);
}

- (MDCButton *)createResignFirstResponderButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Resign first responder" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(resignFirstResponderButtonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
  [button applyContainedThemeWithScheme:self.containerScheme];
  [button sizeToFit];
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
  return button;
}

- (UILabel *)createLabelWithText:(NSString *)text {
  UILabel *label = [[UILabel alloc] init];
  label.textColor = self.containerScheme.colorScheme.primaryColor;
  label.font = self.containerScheme.typographyScheme.subtitle2;
  label.text = text;
  return label;
}

- (InputChipView *)createOutlinedNonWrappingInputChipView {
  InputChipView *inputChipView = [[InputChipView alloc] init];
  inputChipView.textField.placeholder = @"Outlined non-wrapping";
  [inputChipView applyOutlinedThemeWithScheme:self.containerScheme];
  inputChipView.chipsWrap = NO;
  inputChipView.canFloatingLabelFloat = YES;
  inputChipView.chipRowHeight = self.chipHeight;
  [inputChipView sizeToFit];
  inputChipView.textField.delegate = self;
  return inputChipView;
}

- (InputChipView *)createOutlinedNonWrappingInputChipViewWithMaximalDensity {
  InputChipView *inputChipView = [self createOutlinedNonWrappingInputChipView];
  inputChipView.containerStyler.positioningDelegate.verticalDensity = 1.0;
  return inputChipView;
}

- (InputChipView *)createOutlinedNonWrappingInputChipViewWithMinimalDensity {
  InputChipView *inputChipView = [self createOutlinedNonWrappingInputChipView];
  inputChipView.containerStyler.positioningDelegate.verticalDensity = 0.0;
  return inputChipView;
}

- (InputChipView *)createOutlinedWrappingInputChipView {
  InputChipView *inputChipView = [[InputChipView alloc] init];
  inputChipView.textField.placeholder = @"Outlined wrapping";
  [inputChipView applyOutlinedThemeWithScheme:self.containerScheme];
  inputChipView.chipsWrap = YES;
  inputChipView.preferredMainContentAreaHeight = 120;
  inputChipView.canFloatingLabelFloat = YES;
  inputChipView.chipRowHeight = self.chipHeight;
  [inputChipView sizeToFit];
  inputChipView.textField.delegate = self;
  return inputChipView;
}

- (InputChipView *)createFilledNonWrappingInputChipView {
  InputChipView *inputChipView = [[InputChipView alloc] init];
  inputChipView.textField.placeholder = @"Filled non-wrapping";
  [inputChipView applyFilledThemeWithScheme:self.containerScheme];
  inputChipView.chipsWrap = NO;
  inputChipView.canFloatingLabelFloat = YES;
  inputChipView.chipRowHeight = self.chipHeight;
  [inputChipView sizeToFit];
  inputChipView.textField.delegate = self;
  return inputChipView;
}

- (InputChipView *)createFilledNonWrappingInputChipViewWithMaximalDensity {
  InputChipView *inputChipView = [self createFilledNonWrappingInputChipView];
  inputChipView.containerStyler.positioningDelegate.verticalDensity = 1.0;
  return inputChipView;
}

- (InputChipView *)createFilledNonWrappingInputChipViewWithMinimalDensity {
  InputChipView *inputChipView = [self createFilledNonWrappingInputChipView];
  inputChipView.containerStyler.positioningDelegate.verticalDensity = 0.0;
  return inputChipView;
}

- (InputChipView *)createFilledWrappingInputChipView {
  InputChipView *inputChipView = [[InputChipView alloc] init];
  inputChipView.textField.placeholder = @"Outlined wrapping";
  [inputChipView applyFilledThemeWithScheme:self.containerScheme];
  inputChipView.chipsWrap = YES;
  inputChipView.preferredMainContentAreaHeight = 120;
  inputChipView.canFloatingLabelFloat = YES;
  inputChipView.chipRowHeight = self.chipHeight;
  [inputChipView sizeToFit];
  inputChipView.textField.delegate = self;
  return inputChipView;
}

- (CGFloat)chipHeight {
  MDCChipView *chip = [self createChipWithText:@"Test"
                                          font:self.allInputChipViews.firstObject.textField.font];
  return CGRectGetHeight(chip.frame);
}

#pragma mark Private

- (void)updateButtonThemes {
  [self.allButtons enumerateObjectsUsingBlock:^(MDCButton *button, NSUInteger idx, BOOL *stop) {
    if (self.isErrored) {
      MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
      colorScheme.primaryColor = colorScheme.errorColor;
      MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
      containerScheme.colorScheme = colorScheme;
      [button applyContainedThemeWithScheme:containerScheme];
    } else {
      [button applyOutlinedThemeWithScheme:self.containerScheme];
    }
  }];
}

- (void)updateInputChipViewStates {
  [self.allInputChipViews enumerateObjectsUsingBlock:^(InputChipView *inputChipView, NSUInteger idx,
                                                       BOOL *stop) {
    inputChipView.isErrored = self.isErrored;
    BOOL isEven = idx % 2 == 0;
    if (inputChipView.isErrored) {
      if (isEven) {
        inputChipView.leadingUnderlineLabel.text = @"Suspendisse quam elit, mattis sit amet justo "
                                                   @"vel, venenatis lobortis massa. Donec metus "
                                                   @"dolor.";
      } else {
        inputChipView.leadingUnderlineLabel.text = @"This is an error.";
      }
    } else {
      if (isEven) {
        inputChipView.leadingUnderlineLabel.text = @"This is helper text.";
      } else {
        inputChipView.leadingUnderlineLabel.text = nil;
      }
    }
  }];
  [self.view setNeedsLayout];
}

- (void)updateLabelColors {
  [self.allLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
    id<MDCColorScheming> colorScheme = self.containerScheme.colorScheme;
    UIColor *textColor = self.isErrored ? colorScheme.errorColor : colorScheme.primaryColor;
    label.textColor = textColor;
  }];
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

- (NSArray<InputChipView *> *)allInputChipViews {
  return [self allViewsOfClass:[InputChipView class]];
}

- (NSArray<MDCButton *> *)allButtons {
  return [self allViewsOfClass:[MDCButton class]];
}

- (NSArray<UILabel *> *)allLabels {
  return [self allViewsOfClass:[UILabel class]];
}

- (NSArray *)allViewsOfClass:(Class)class {
  return [self.scrollViewSubviews
      objectsAtIndexes:[self.scrollViewSubviews indexesOfObjectsPassingTest:^BOOL(
                                                    UIView *view, NSUInteger idx, BOOL *stop) {
        return [view isKindOfClass:class];
      }]];
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
  [self.allInputChipViews
      enumerateObjectsUsingBlock:^(InputChipView *inputChipView, NSUInteger idx, BOOL *stop) {
        [inputChipView resignFirstResponder];
      }];
}

- (void)toggleErrorButtonTapped:(UIButton *)button {
  self.isErrored = !self.isErrored;
  [self updateButtonThemes];
  [self updateInputChipViewStates];
  [self updateLabelColors];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField.text.length <= 0) {
    return NO;
  }
  MDCChipView *chipView = [self createChipWithText:textField.text font:textField.font];
  InputChipView *inputChipView = [self inputChipViewWithTextField:textField];
  [inputChipView addChip:chipView];
  return NO;
}

- (InputChipView *)inputChipViewWithTextField:(UITextField *)textField {
  for (InputChipView *inputChipView in self.allInputChipViews) {
    if (inputChipView.textField == textField) {
      return inputChipView;
    }
  }
  return nil;
}

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
