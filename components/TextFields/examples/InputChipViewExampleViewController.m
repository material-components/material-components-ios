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

#import "MDCBaseInputChipView+MaterialTheming.h"
#import "MDCBaseInputChipView.h"
#import "MDCFilledInputChipView+MaterialTheming.h"
#import "MDCFilledInputChipView.h"
#import "MDCOutlinedInputChipView+MaterialTheming.h"
#import "MDCOutlinedInputChipView.h"
#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"

#import "MaterialChips.h"

#import "MDCBaseInputChipView+MaterialTheming.h"

static const CGFloat kSideMargin = (CGFloat)20.0;

@interface InputChipViewExampleViewController () <UITextFieldDelegate, MDCInputChipViewDelegate>

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
    [self createLabelWithText:@"Filled InputChipView:"],
    [self createFilledNonWrappingInputChipView],
    [self createLabelWithText:@"Wrapping filled InputChipView:"],
    [self createFilledWrappingInputChipView],
    [self createLabelWithText:@"Outlined InputChipView:"],
    [self createOutlinedNonWrappingInputChipView],
    [self createLabelWithText:@"Wrapping outlined InputChipView:"],
    [self createOutlinedWrappingInputChipView],
    [self createLabelWithText:@"Base InputChipView:"],
    [self createBaseNonWrappingInputChipView],
    [self createLabelWithText:@"Wrapping base InputChipView:"],
    [self createBaseWrappingInputChipView],
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
    if ([view isKindOfClass:[MDCBaseInputChipView class]]) {
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

- (MDCBaseInputChipView *)createBaseNonWrappingInputChipView {
  MDCBaseInputChipView *inputChipView = [[MDCBaseInputChipView alloc] init];
  inputChipView.delegate = self;
  inputChipView.label.text = @"Base non-wrapping";
  [inputChipView applyThemeWithScheme:self.containerScheme];
  inputChipView.chipsWrap = NO;
  inputChipView.labelBehavior = MDCTextControlLabelBehaviorFloats;
  inputChipView.chipRowHeight = self.chipHeight;
  [inputChipView sizeToFit];
  inputChipView.textField.delegate = self;
  inputChipView.mdc_adjustsFontForContentSizeCategory = YES;
  inputChipView.layer.borderColor = [UIColor blackColor].CGColor;
  inputChipView.layer.borderWidth = 1;
  return inputChipView;
}

- (MDCBaseInputChipView *)createBaseWrappingInputChipView {
  MDCBaseInputChipView *inputChipView = [self createBaseNonWrappingInputChipView];
  inputChipView.label.text = @"Base wrapping";
  inputChipView.chipsWrap = YES;
  //  inputChipView.labelBehavior = MDCTextControlLabelBehaviorDisappears;
  inputChipView.preferredNumberOfVisibleRows = 4;
  //  inputChipView.preferredContainerHeight = 150;
  [inputChipView sizeToFit];
  inputChipView.mdc_adjustsFontForContentSizeCategory = YES;
  return inputChipView;
}

- (MDCOutlinedInputChipView *)createOutlinedNonWrappingInputChipView {
  MDCOutlinedInputChipView *inputChipView = [[MDCOutlinedInputChipView alloc] init];
  inputChipView.delegate = self;
  inputChipView.label.text = @"Outlined non-wrapping";
  [inputChipView applyThemeWithScheme:self.containerScheme];
  inputChipView.chipsWrap = NO;
  inputChipView.labelBehavior = MDCTextControlLabelBehaviorFloats;
  inputChipView.chipRowHeight = self.chipHeight;
  [inputChipView sizeToFit];
  inputChipView.textField.delegate = self;
  inputChipView.mdc_adjustsFontForContentSizeCategory = YES;
  return inputChipView;
}

- (MDCOutlinedInputChipView *)createOutlinedWrappingInputChipView {
  MDCOutlinedInputChipView *inputChipView = [self createOutlinedNonWrappingInputChipView];
  inputChipView.label.text = @"Outlined wrapping";
  inputChipView.chipsWrap = YES;
  //  inputChipView.labelBehavior = MDCTextControlLabelBehaviorDisappears;
  inputChipView.preferredNumberOfVisibleRows = 4;
  //  inputChipView.preferredContainerHeight = 150;
  [inputChipView sizeToFit];
  inputChipView.mdc_adjustsFontForContentSizeCategory = YES;
  return inputChipView;
}

- (MDCFilledInputChipView *)createFilledNonWrappingInputChipView {
  MDCFilledInputChipView *inputChipView = [[MDCFilledInputChipView alloc] init];
  inputChipView.delegate = self;
  inputChipView.mdc_adjustsFontForContentSizeCategory = YES;
  inputChipView.label.text = @"Filled non-wrapping";
  [inputChipView applyThemeWithScheme:self.containerScheme];
  inputChipView.chipsWrap = NO;
  //  inputChipView.labelBehavior = MDCTextControlLabelBehaviorDisappears;
  inputChipView.chipRowHeight = self.chipHeight;
  [inputChipView sizeToFit];
  inputChipView.textField.delegate = self;
  return inputChipView;
}

- (MDCFilledInputChipView *)createFilledWrappingInputChipView {
  MDCFilledInputChipView *inputChipView = [self createFilledNonWrappingInputChipView];
  inputChipView.label.text = @"Filled wrapping";
  inputChipView.chipsWrap = YES;
  inputChipView.preferredContainerHeight = 150;
  inputChipView.chipRowHeight = self.chipHeight;
  [inputChipView sizeToFit];
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
  [self.allInputChipViews enumerateObjectsUsingBlock:^(MDCBaseInputChipView *inputChipView,
                                                       NSUInteger idx, BOOL *stop) {
    BOOL isEven = idx % 2 == 0;
    if (self.isErrored) {
      // TODO: Make InputChipView respond to error theme selector
      //      if ([inputChipView respondsToSelector:@selector(applyErrorThemeWithScheme:)]) {
      //        [inputChipView applyErrorThemeWithScheme:self.containerScheme];
      //      }
      if (isEven) {
        inputChipView.leadingAssistiveLabel.text = @"Suspendisse quam elit, mattis sit amet justo "
                                                   @"vel, venenatis lobortis massa. Donec metus "
                                                   @"dolor.";
      } else {
        inputChipView.leadingAssistiveLabel.text = @"This is an error.";
      }
    } else {
      if ([inputChipView respondsToSelector:@selector(applyThemeWithScheme:)]) {
        [inputChipView applyThemeWithScheme:self.containerScheme];
      }
      if (isEven) {
        inputChipView.leadingAssistiveLabel.text = @"This is helper text.";
      } else {
        inputChipView.leadingAssistiveLabel.text = nil;
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

- (NSArray<MDCBaseInputChipView *> *)allInputChipViews {
  return [self allViewsOfClass:[MDCBaseInputChipView class]];
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
  [self.allInputChipViews enumerateObjectsUsingBlock:^(MDCBaseInputChipView *inputChipView,
                                                       NSUInteger idx, BOOL *stop) {
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
  MDCBaseInputChipView *inputChipView = [self inputChipViewWithTextField:textField];
  [inputChipView addChip:chipView];
  return NO;
}

- (MDCBaseInputChipView *)inputChipViewWithTextField:(UITextField *)textField {
  for (MDCBaseInputChipView *inputChipView in self.allInputChipViews) {
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
    @"breadcrumbs" : @[ @"Text Field", @"CIV Input Chip Views" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

#pragma mark MDCInputChipViewDelegate

- (void)inputChipViewDidDeleteBackwards:(nonnull MDCBaseInputChipView *)inputChipView
                                oldText:(nullable NSString *)oldText
                                newText:(nullable NSString *)newText {
  BOOL isEmpty = newText.length == 0;
  BOOL isNewlyEmpty = oldText.length > 0 && newText.length == 0;
  if (isEmpty) {
    if (!isNewlyEmpty) {
      NSArray<MDCChipView *> *selectedChips = [self selectedChipsWithChips:inputChipView.chips];
      if (selectedChips.count > 0) {
        [inputChipView removeChips:selectedChips];
      } else if (inputChipView.chips.count > 0) {
        [self selectChip:inputChipView.chips.lastObject];
      }
    }
  }
}

- (NSArray<MDCChipView *> *)selectedChipsWithChips:(NSArray<UIView *> *)chips {
  NSMutableArray *selectedChips = [NSMutableArray new];
  for (UIView *view in chips) {
    if ([view isKindOfClass:[MDCChipView class]]) {
      MDCChipView *chipView = (MDCChipView *)view;
      if (chipView.isSelected) {
        [selectedChips addObject:chipView];
      }
    }
  }
  return [selectedChips copy];
}

- (void)selectChip:(UIView *)chip {
  if ([chip isKindOfClass:[MDCChipView class]]) {
    MDCChipView *chipView = (MDCChipView *)chip;
    chipView.selected = YES;
  }
  UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,
                                  [chip accessibilityLabel]);
}


@end
