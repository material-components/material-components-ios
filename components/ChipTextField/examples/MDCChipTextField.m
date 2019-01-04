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

#import "MDCChipTextField.h"

#import "MDCChipTextFieldScrollView.h"
#import "MaterialChips.h"

static CGFloat const kChipsSpacing = 0.0f;
static CGFloat const kTextToEnterPlaceholderLength = 16.0f;

@interface MDCChipTextField () <MDCChipTextFieldScrollViewDataSource>

@property(nonatomic, strong) MDCChipTextFieldScrollView *chipsContainerView;

@property(nonatomic, readwrite, weak) NSLayoutConstraint *chipContainerViewConstraintLeading;
@property(nonatomic, readwrite, weak) NSLayoutConstraint *chipContainerViewConstraintTrailing;
@property(nonatomic) CGFloat chipContainerViewConstraintTrailingConstant;
// Chip view models
@property(nonatomic, strong) NSMutableArray<MDCChipView *> *chipViews;

@end

@implementation MDCChipTextField

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _chipViews = [[NSMutableArray alloc] init];
    _chipContainerViewConstraintTrailingConstant = 0.0f;
    [self setupChipsContainerView];

    [self addTarget:self
                  action:@selector(chipTextFieldTextDidChange)
        forControlEvents:UIControlEventEditingChanged];

    [self addTextFieldObservers];
  }
  return self;
}

- (void)addTextFieldObservers {
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textFieldDidEndEditingWithNotification:)
             name:UITextFieldTextDidEndEditingNotification
           object:self];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textFieldDidBeginEditingWithNotification:)
             name:UITextFieldTextDidBeginEditingNotification
           object:self];
}

- (void)setupChipsContainerView {
  MDCChipTextFieldScrollView *chipsContainerView =
      [[MDCChipTextFieldScrollView alloc] initWithFrame:CGRectZero];
  chipsContainerView.translatesAutoresizingMaskIntoConstraints = NO;
  chipsContainerView.chipSpacing = kChipsSpacing;
  chipsContainerView.dataSource = self;
  self.chipsContainerView = chipsContainerView;
  [self addSubview:chipsContainerView];

  NSLayoutConstraint *chipContainerViewConstraintTop =
      [NSLayoutConstraint constraintWithItem:self.chipsContainerView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *chipContainerViewConstraintBottom =
      [NSLayoutConstraint constraintWithItem:self.chipsContainerView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0];
  [NSLayoutConstraint
      activateConstraints:@[ chipContainerViewConstraintTop, chipContainerViewConstraintBottom ]];
  [self updateChipViewLeadingConstraints];
  [self updateChipViewTrailingConstraints];
}

- (void)appendChipWithText:(NSString *)text {
  MDCChipView *chipView = [[MDCChipView alloc] init];
  chipView.titleLabel.text = text;
  chipView.translatesAutoresizingMaskIntoConstraints = NO;

  [self.chipsContainerView appendChipView:chipView];

  // recalculate the layout to get a correct chip frame values
  [self.chipsContainerView layoutIfNeeded];
  [self.chipViews addObject:chipView];

  [self clearChipsContainerOffsetWithConstant:kTextToEnterPlaceholderLength];
}

// TODO: the constant here reflects the margin, places calling this method need to be refactored.
- (void)clearChipsContainerOffsetWithConstant:(CGFloat)constant {
  self.chipContainerViewConstraintTrailingConstant = -constant;
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
  [self layoutIfNeeded];
  [self.chipsContainerView setNeedsLayout];
  [self.chipsContainerView layoutIfNeeded];
  [self.chipsContainerView scrollToRight];
}

#pragma mark - Text Editing Handler

- (void)chipTextFieldTextDidChange {
  [self deselectAllChips];
  [self setupEditingRect];
}

- (void)setupEditingRect {
  if (CGRectGetWidth(self.chipsContainerView.frame) <= 0) {
    return;
  }

  UITextRange *textRange = [self textRangeFromPosition:self.beginningOfDocument
                                            toPosition:self.endOfDocument];
  CGRect inputRect = [self firstRectForRange:textRange];
  CGFloat inputRectLength = inputRect.size.width;

  self.chipContainerViewConstraintTrailingConstant =
      -(inputRectLength + kTextToEnterPlaceholderLength);
  [self setNeedsUpdateConstraints];
  [self setNeedsLayout];
  [self layoutIfNeeded];
  [self.chipsContainerView setNeedsLayout];
  [self.chipsContainerView layoutIfNeeded];
  [self.chipsContainerView scrollToRight];
}

#pragma mark - Constraints

- (void)updateConstraints {
  // TODO: This is not optimized for performance, but due to how MDCTextInputController works, we
  // need to update constraints here
  [self updateChipViewLeadingConstraints];
  [self updateChipViewTrailingConstraints];

  [super updateConstraints];
}

- (void)updateChipViewLeadingConstraints {
  self.chipContainerViewConstraintLeading.active = NO;

  NSLayoutConstraint *chipContainerViewConstraintLeading = nil;
  if (self.leftView) {
    chipContainerViewConstraintLeading =
        [NSLayoutConstraint constraintWithItem:self.chipsContainerView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.leftView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:self.textInsets.left];
  } else {
    chipContainerViewConstraintLeading =
        [NSLayoutConstraint constraintWithItem:self.chipsContainerView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:self.textInsets.left];
  }
  chipContainerViewConstraintLeading.active = YES;

  self.chipContainerViewConstraintLeading = chipContainerViewConstraintLeading;
}

- (void)updateChipViewTrailingConstraints {
  self.chipContainerViewConstraintTrailing.active = NO;

  NSLayoutConstraint *chipContainerViewConstraintTrailing = nil;
  if (self.rightView) {
    chipContainerViewConstraintTrailing =
        [NSLayoutConstraint constraintWithItem:self.chipsContainerView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                        toItem:self.rightView
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:self.chipContainerViewConstraintTrailingConstant];
  } else {
    chipContainerViewConstraintTrailing =
        [NSLayoutConstraint constraintWithItem:self.chipsContainerView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                        toItem:self.clearButton
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:self.chipContainerViewConstraintTrailingConstant];
  }
  chipContainerViewConstraintTrailing.active = YES;

  self.chipContainerViewConstraintTrailing = chipContainerViewConstraintTrailing;
}

#pragma mark - overrides

- (void)setLeftViewMode:(UITextFieldViewMode)leftViewMode {
  [super setLeftViewMode:leftViewMode];

  [self updateChipViewLeadingConstraints];
  [self setNeedsUpdateConstraints];
}

- (void)setLeftView:(UIView *)leftView {
  [super setLeftView:leftView];

  [self updateChipViewLeadingConstraints];
  [self setNeedsUpdateConstraints];
}

- (void)setRightViewMode:(UITextFieldViewMode)rightViewMode {
  [super setRightViewMode:rightViewMode];

  [self updateChipViewTrailingConstraints];
  [self setNeedsUpdateConstraints];
}

- (void)setRightView:(UIView *)rightView {
  [super setRightView:rightView];

  [self updateChipViewTrailingConstraints];
  [self setNeedsUpdateConstraints];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = [super textRectForBounds:bounds];
  textRect.origin.x = CGRectGetMaxX(self.chipsContainerView.frame);
  textRect.size.width = MAX(0, textRect.size.width - CGRectGetWidth(self.chipsContainerView.frame));
  return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  CGRect editingRect = [super editingRectForBounds:bounds];
  return editingRect;
}

- (void)deleteBackward {
  NSInteger cursorPosition = [self offsetFromPosition:self.beginningOfDocument
                                           toPosition:self.selectedTextRange.start];
  if (cursorPosition == 0) {
    [self respondToDeleteBackward];
  }
  [super deleteBackward];
}

- (BOOL)hasTextContent {
  return self.text.length > 0 || self.chipViews.count > 0;
}

- (void)clearText {
  self.text = @"";
  for (NSInteger index = self.chipViews.count - 1; index >= 0; --index) {
    MDCChipView *chipView = self.chipViews[index];
    [self removeChip:chipView];
  }
}

#pragma mark - Deletion

- (void)deselectAllChipsExceptChip:(MDCChipView *)chip {
  for (MDCChipView *otherChip in self.chipViews) {
    if (chip != otherChip) {
      otherChip.selected = NO;
    }
  }
}

- (void)selectLastChip {
  MDCChipView *lastChip = self.chipViews.lastObject;
  [self deselectAllChipsExceptChip:lastChip];
  lastChip.selected = YES;
  UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,
                                  [lastChip accessibilityLabel]);
}

- (void)deselectAllChips {
  [self deselectAllChipsExceptChip:nil];
}

- (void)removeChip:(MDCChipView *)chip {
  [self.chipViews removeObject:chip];
  [self.chipsContainerView removeChipView:chip];
  [self clearChipsContainerOffsetWithConstant:kTextToEnterPlaceholderLength];

  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (void)removeSelectedChips {
  NSMutableArray *chipsToRemove = [NSMutableArray array];
  for (MDCChipView *chip in self.chipViews) {
    if (chip.isSelected) {
      [chipsToRemove addObject:chip];
    }
  }
  for (MDCChipView *chip in chipsToRemove) {
    [self removeChip:chip];
  }
}

- (BOOL)isAnyChipSelected {
  for (MDCChipView *chip in self.chipViews) {
    if (chip.isSelected) {
      return YES;
    }
  }
  return NO;
}

- (void)respondToDeleteBackward {
  if ([self isAnyChipSelected]) {
    [self removeSelectedChips];
    [self deselectAllChips];
  } else {
    [self selectLastChip];
  }
}
#pragma mark Notification Listener Methods

- (void)textFieldDidBeginEditingWithNotification:(NSNotification *)notification {
  [self setupEditingRect];
}

- (void)textFieldDidEndEditingWithNotification:(NSNotification *)notification {
  [self clearChipsContainerOffsetWithConstant:0.0f];
  [self.chipsContainerView scrollToLeft];
}

#pragma mark - MDCChipTextFieldScrollViewDataSource

- (NSInteger)numberOfChipsOnScrollView:(MDCChipTextFieldScrollView *)scrollView {
  return self.chipViews.count;
}

- (MDCChipView *)scrollView:(MDCChipTextFieldScrollView *)scrollView chipForIndex:(NSInteger)index {
  return self.chipViews[index];
}

@end
