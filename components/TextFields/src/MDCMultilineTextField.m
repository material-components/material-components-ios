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

#import "MDCMultilineTextField.h"

#import "MDCTextFieldPositioningDelegate.h"
#import "MDCTextInputCharacterCounter.h"
#import "private/MDCTextInputCommonFundament.h"

#import "MaterialMath.h"
#import "MaterialRTL.h"
#import "MaterialTypography.h"

static NSString *const MDCMultilineTextFieldExpandsOnOverflowKey =
    @"MDCMultilineTextFieldExpandsOnOverflowKey";
static NSString *const MDCMultilineTextFieldFundamentKey = @"MDCMultilineTextFieldFundamentKey";
static NSString *const MDCMultilineTextFieldLayoutDelegateKey =
    @"MDCMultilineTextFieldLayoutDelegateKey";
static NSString *const MDCMultilineTextFieldMinimumLinesKey = @"MDCMultilineTextMinimumLinesKey";
static NSString *const MDCMultilineTextFieldTextViewKey = @"MDCMultilineTextFieldTextViewKey";
static NSString *const MDCMultilineTextFieldTrailingViewModeKey =
    @"MDCMultilineTextFieldTrailingViewModeKey";

@interface MDCMultilineTextField () {
  UITextView *_textView;
}

@property(nonatomic, assign, getter=isEditing) BOOL editing;

@property(nonatomic, strong) MDCTextInputCommonFundament *fundament;

@property(nonatomic, strong) NSLayoutConstraint *textViewLeading;
@property(nonatomic, strong) NSLayoutConstraint *textViewMinHeight;
@property(nonatomic, strong) NSLayoutConstraint *textViewTop;
@property(nonatomic, strong) NSLayoutConstraint *textViewTrailing;

// textViewTrailingTrailingViewLeading is a constraint from .textView's trailing edge to
// .trailingView's leading edge.
@property(nonatomic, strong) NSLayoutConstraint *textViewTrailingTrailingViewLeading;
@property(nonatomic, strong) NSLayoutConstraint *trailingViewCenterY;
@property(nonatomic, strong) NSLayoutConstraint *trailingViewTrailing;

@end

@implementation MDCMultilineTextField

@synthesize expandsOnOverflow = _expandsOnOverflow;
@synthesize minimumLines = _minimumLines;
@synthesize trailingViewMode = _trailingViewMode;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _fundament = [[MDCTextInputCommonFundament alloc] initWithTextInput:self];

    [self commonMDCMultilineTextFieldInitialization];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    MDCTextInputCommonFundament *fundament =
        [aDecoder decodeObjectForKey:MDCMultilineTextFieldFundamentKey];
    _fundament =
        fundament ? fundament : [[MDCTextInputCommonFundament alloc] initWithTextInput:self];

    [self commonMDCMultilineTextFieldInitialization];

    if ([aDecoder containsValueForKey:MDCMultilineTextFieldExpandsOnOverflowKey]) {
      _expandsOnOverflow = [aDecoder decodeBoolForKey:MDCMultilineTextFieldExpandsOnOverflowKey];
    }
    _layoutDelegate = [aDecoder decodeObjectForKey:MDCMultilineTextFieldLayoutDelegateKey];
    if ([aDecoder containsValueForKey:MDCMultilineTextFieldMinimumLinesKey]) {
      _minimumLines = [aDecoder decodeIntegerForKey:MDCMultilineTextFieldMinimumLinesKey];
    }
    if ([aDecoder containsValueForKey:MDCMultilineTextFieldTextViewKey]) {
      _textView = [aDecoder decodeObjectForKey:MDCMultilineTextFieldTextViewKey];
    } else {
      _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    }
    _trailingViewMode = (UITextFieldViewMode)
        [aDecoder decodeIntegerForKey:MDCMultilineTextFieldTrailingViewModeKey];
  }

  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeBool:self.expandsOnOverflow forKey:MDCMultilineTextFieldExpandsOnOverflowKey];
  [aCoder encodeObject:self.fundament forKey:MDCMultilineTextFieldFundamentKey];
  [aCoder encodeConditionalObject:self.layoutDelegate
                           forKey:MDCMultilineTextFieldLayoutDelegateKey];
  [aCoder encodeInteger:self.minimumLines forKey:MDCMultilineTextFieldMinimumLinesKey];
  [aCoder encodeObject:self.textView forKey:MDCMultilineTextFieldTextViewKey];
  [aCoder encodeInteger:self.trailingViewMode forKey:MDCMultilineTextFieldTrailingViewModeKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCMultilineTextField *copy = [[[self class] alloc] initWithFrame:self.frame];

  copy.expandsOnOverflow = self.expandsOnOverflow;
  copy.fundament = [self.fundament copy];
  copy.layoutDelegate = self.layoutDelegate;
  copy.minimumLines = self.minimumLines;
  copy.placeholder = self.placeholder;
  copy.text = self.text;
  copy.trailingViewMode = self.trailingViewMode;

  return copy;
}

- (void)commonMDCMultilineTextFieldInitialization {
  self.backgroundColor = [UIColor clearColor];

  self.textColor = _fundament.textColor;
  self.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
  self.clearButtonColor = [UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]];
  self.clearButtonMode = UITextFieldViewModeWhileEditing;

  self.editable = YES;

  _expandsOnOverflow = YES;
  _minimumLines = 1;

  [self setupUnderlineConstraints];
}

- (BOOL)becomeFirstResponder {
  return [self.textView becomeFirstResponder];
}

- (void)subscribeForNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter addObserver:self
                    selector:@selector(textViewDidBeginEditing:)
                        name:UITextViewTextDidBeginEditingNotification
                      object:self.textView];
  [defaultCenter addObserver:self
                    selector:@selector(textViewDidEndEditing:)
                        name:UITextViewTextDidEndEditingNotification
                      object:self.textView];
  [defaultCenter addObserver:self
                    selector:@selector(textViewDidChange:)
                        name:UITextViewTextDidChangeNotification
                      object:self.textView];
}

#pragma mark - TextView Implementation

- (void)setupTextView {
  [self insertSubview:self.textView atIndex:0];
  self.textView.translatesAutoresizingMaskIntoConstraints = NO;
  self.textView.scrollEnabled = NO;

  [self.textView setContentHuggingPriority:UILayoutPriorityDefaultLow - 1
                                   forAxis:UILayoutConstraintAxisHorizontal];
  [self.textView setContentHuggingPriority:UILayoutPriorityDefaultLow - 1
                                   forAxis:UILayoutConstraintAxisVertical];
  [self.textView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow - 1
                                                 forAxis:UILayoutConstraintAxisHorizontal];

  self.textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
  self.textView.textContainer.lineFragmentPadding = 0;

  self.textView.textContainerInset = UIEdgeInsetsZero;
  [self subscribeForNotifications];

  self.textView.backgroundColor = [UIColor clearColor];
  self.textView.opaque = NO;
}

#pragma mark - Underline View Implementation

- (void)setupUnderlineConstraints {
  NSLayoutConstraint *underlineLeading =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  underlineLeading.priority = UILayoutPriorityDefaultLow;
  underlineLeading.active = YES;

  NSLayoutConstraint *underlineTrailing =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:0];
  underlineTrailing.priority = UILayoutPriorityDefaultLow;
  underlineTrailing.active = YES;

  NSLayoutConstraint *underlineYTextView =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.textView
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:MDCTextInputHalfPadding];
  underlineYTextView.priority = UILayoutPriorityDefaultLow;
  underlineYTextView.active = YES;

  NSLayoutConstraint *underlineYSuperviewBottom =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:-1 * MDCTextInputHalfPadding];
  underlineYSuperviewBottom.priority = UILayoutPriorityDefaultLow;
  underlineYSuperviewBottom.active = YES;

  NSLayoutConstraint *underlineYLeadingLabelTop =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                      toItem:self.leadingUnderlineLabel
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:-1 * MDCTextInputHalfPadding];
  underlineYLeadingLabelTop.priority = UILayoutPriorityDefaultLow;
  underlineYLeadingLabelTop.active = YES;

  NSLayoutConstraint *underlineYTrailingLabelTop =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                      toItem:self.trailingUnderlineLabel
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:-1 * MDCTextInputHalfPadding];
  underlineYTrailingLabelTop.priority = UILayoutPriorityDefaultLow;
  underlineYTrailingLabelTop.active = YES;
}

#pragma mark - Layout (Custom)

- (UIEdgeInsets)textInsets {
  UIEdgeInsets textInsets = UIEdgeInsetsZero;

  textInsets.top = MDCTextInputFullPadding;

  // The amount of space underneath the underline is variable. It could just be
  // MDCTextInputHalfPadding or the biggest estimated underlineLabel height +
  // MDCTextInputHalfPadding
  CGFloat underlineLabelsOffset = 0;
  if (self.leadingUnderlineLabel.text.length) {
    underlineLabelsOffset = MDCCeil(self.leadingUnderlineLabel.font.lineHeight * 2.f) / 2.f;
  }
  if (self.trailingUnderlineLabel.text.length) {
    underlineLabelsOffset = MAX(underlineLabelsOffset,
                                MDCCeil(self.trailingUnderlineLabel.font.lineHeight * 2.f) / 2.f);
  }
  CGFloat underlineOffset = MDCTextInputHalfPadding + underlineLabelsOffset;

  // .bottom = underlineOffset + the half padding above the line but below the text field
  textInsets.bottom = underlineOffset + MDCTextInputHalfPadding;

  if ([self.positioningDelegate respondsToSelector:@selector(textInsets:)]) {
    return [self.positioningDelegate textInsets:textInsets];
  }
  return textInsets;
}

#pragma mark - Layout (UIView)

- (CGSize)intrinsicContentSize {
  CGSize boundingSize = CGSizeZero;
  boundingSize.width = UIViewNoIntrinsicMetric;

  [self.textView layoutIfNeeded];
  CGFloat estimatedTextViewHeight =
      [self.textView systemLayoutSizeFittingSize:CGSizeMake(CGRectGetWidth(self.textView.bounds), 0)
                   withHorizontalFittingPriority:UILayoutPriorityDefaultLow
                         verticalFittingPriority:UILayoutPriorityDefaultLow]
          .height;

  boundingSize.height = [self textInsets].top + estimatedTextViewHeight + [self textInsets].bottom;

  return boundingSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize sizeThatFits = [self intrinsicContentSize];
  sizeThatFits.width = size.width;

  return sizeThatFits;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (![self.textView isDescendantOfView:self]) {
    [self setupTextView];
  }
  if (self.subviews.firstObject != self.textView) {
    [self sendSubviewToBack:self.textView];
  }

  [self updateTrailingViewAlpha];

  [self.fundament layoutSubviewsOfInput];
}

- (void)updateConstraints {
  if (!self.textViewLeading) {
    self.textViewLeading = [NSLayoutConstraint constraintWithItem:self.textView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1
                                                         constant:self.textInsets.left];
    self.textViewLeading.priority = UILayoutPriorityDefaultLow;
    self.textViewLeading.active = YES;
  }
  self.textViewLeading.constant = self.textInsets.left;

  if (!self.textViewTop) {
    self.textViewTop = [NSLayoutConstraint constraintWithItem:self.textView
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1
                                                     constant:self.textInsets.top];
    self.textViewTop.priority = UILayoutPriorityDefaultLow;
    self.textViewTop.active = YES;
  }
  self.textViewTop.constant = self.textInsets.top;

  if (!self.textViewTrailing) {
    self.textViewTrailing = [NSLayoutConstraint constraintWithItem:self.textView
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.clearButton
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1
                                                          constant:0];
    self.textViewTrailing.priority = UILayoutPriorityDefaultLow;
    self.textViewTrailing.active = YES;
  }

  if (!self.textViewMinHeight) {
    self.textViewMinHeight = [NSLayoutConstraint
        constraintWithItem:self.textView
                 attribute:NSLayoutAttributeHeight
                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                    toItem:nil
                 attribute:NSLayoutAttributeNotAnAttribute
                multiplier:1
                  constant:[self estimatedTextViewLineHeight] * self.minimumLines];
    self.textViewMinHeight.priority = UILayoutPriorityDefaultLow;
  }
  self.textViewMinHeight.active = self.minimumLines > 1;
  self.textViewMinHeight.constant = [self estimatedTextViewLineHeight] * self.minimumLines;

  [self.fundament updateConstraintsOfInput];

  [self updateTrailingViewLayout];

  [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

- (CGFloat)estimatedTextViewLineHeight {
  return MDCCeil(self.textView.font.lineHeight * 2.f) / 2.f;
}

#pragma mark - Trailing View Implementation

- (void)updateTrailingViewLayout {
  if (!self.trailingView) {
    return;
  }

  self.trailingView.translatesAutoresizingMaskIntoConstraints = NO;

  if (![self.trailingView isDescendantOfView:self]) {
    [self addSubview:self.trailingView];
  }

  if (!self.trailingViewTrailing) {
    self.trailingViewTrailing = [NSLayoutConstraint constraintWithItem:self.trailingView
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.clearButton
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1
                                                              constant:0];
  }
  self.trailingViewTrailing.active = YES;

  if (!self.trailingViewCenterY) {
    self.trailingViewCenterY = [NSLayoutConstraint constraintWithItem:self.trailingView
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.clearButton
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1
                                                             constant:0];
  }
  self.trailingViewCenterY.active = YES;
  
  if (!self.textViewTrailingTrailingViewLeading) {
    self.textViewTrailingTrailingViewLeading = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.trailingView attribute:NSLayoutAttributeLeading multiplier:1 constant:self.textViewTrailing.constant];
  }
  self.textViewTrailingTrailingViewLeading.active = !MDCCGFloatEqual([self trailingViewAlpha], 0.f);
}

- (void)updateTrailingViewAlpha {
  self.trailingView.alpha = [self trailingViewAlpha];
}

- (CGFloat)trailingViewAlpha {
  // The trailing view has the same behavior as .rightView in UITextField: It has visual precedence
  // over the clear button.
  CGFloat trailingViewAlpha = self.trailingView.alpha;
  switch (self.trailingViewMode) {
    case UITextFieldViewModeAlways:
      trailingViewAlpha = 1.f;
      break;
    case UITextFieldViewModeWhileEditing:
      trailingViewAlpha = self.isEditing ? 1.f : 0.f;
      break;
    case UITextFieldViewModeUnlessEditing:
      trailingViewAlpha = self.isEditing ? 0.f : 1.f;
      break;
    case UITextFieldViewModeNever:
      trailingViewAlpha = 0.f;
      break;
  }
  return trailingViewAlpha;
}

#pragma mark - Properties Implementation

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_0)
- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  [super setAdjustsFontForContentSizeCategory:adjustsFontForContentSizeCategory];
  [self mdc_setAdjustsFontForContentSizeCategory:adjustsFontForContentSizeCategory];
}
#endif

- (BOOL)adjustsFontForContentSizeCategory {
  return self.mdc_adjustsFontForContentSizeCategory;
}

- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  [self mdc_setAdjustsFontForContentSizeCategory:adjustsFontForContentSizeCategory];
}

- (NSAttributedString *)attributedPlaceholder {
  return self.fundament.attributedPlaceholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  self.fundament.attributedPlaceholder = attributedPlaceholder;
}

- (NSAttributedString *)attributedText {
  return self.textView.attributedText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
  self.textView.attributedText = attributedText;
  [self.fundament didSetText];
}

- (UIButton *)clearButton {
  return self.fundament.clearButton;
}

- (UIColor *)clearButtonColor {
  return self.fundament.clearButtonColor;
}

- (void)setClearButtonColor:(UIColor *)clearButtonColor {
  self.fundament.clearButtonColor = clearButtonColor;
}

- (UITextFieldViewMode)clearButtonMode {
  return self.fundament.clearButtonMode;
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
  self.fundament.clearButtonMode = clearButtonMode;
}

- (void)setEditable:(BOOL)editable {
  [self.textView setEditable:editable];
  self.fundament.enabled = editable;
}

- (BOOL)isEnabled {
  return self.fundament.isEnabled && self.textView.isEditable;
}

- (void)setEnabled:(BOOL)enabled {
  self.fundament.enabled = enabled;
  self.textView.editable = enabled;
}

- (void)setExpandsOnOverflow:(BOOL)expandsOnOverflow {
  if (_expandsOnOverflow != expandsOnOverflow) {
    _expandsOnOverflow = expandsOnOverflow;
    self.textView.scrollEnabled = !expandsOnOverflow;
  }
}

- (UIFont *)font {
  return self.textView.font;
}

- (void)setFont:(UIFont *)font {
  if (self.textView.font != font) {
    [self.textView setFont:font];
    [_fundament didSetFont];
  }
}

- (BOOL)hidesPlaceholderOnInput {
  return self.fundament.hidesPlaceholderOnInput;
}

- (void)setHidesPlaceholderOnInput:(BOOL)hidesPlaceholderOnInput {
  self.fundament.hidesPlaceholderOnInput = hidesPlaceholderOnInput;
}

- (UILabel *)leadingUnderlineLabel {
  return self.fundament.leadingUnderlineLabel;
}

- (NSUInteger)minimumLines {
  if (_minimumLines < 1) {
    _minimumLines = 1;
  }
  return _minimumLines;
}

- (void)setMinimumLines:(NSUInteger)minimumLines {
  if (_minimumLines != minimumLines) {
    _minimumLines = minimumLines > 0 ? minimumLines : 1;
    [self setNeedsUpdateConstraints];
  }
}

- (NSString *)placeholder {
  return self.fundament.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [self.fundament setPlaceholder:placeholder];
}

- (UILabel *)placeholderLabel {
  return self.fundament.placeholderLabel;
}

- (id<MDCTextInputPositioningDelegate>)positioningDelegate {
  return self.fundament.positioningDelegate;
}

- (void)setPositioningDelegate:(id<MDCTextInputPositioningDelegate>)positioningDelegate {
  self.fundament.positioningDelegate = positioningDelegate;
}

- (NSString *)text {
  return self.textView.text;
}

- (void)setText:(NSString *)text {
  [self.textView setText:text];
  [self.fundament didSetText];
  [[NSNotificationCenter defaultCenter] postNotificationName:MDCTextFieldTextDidSetTextNotification
                                                      object:self];
}

- (UIColor *)textColor {
  return self.fundament.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  [self.textView setTextColor:textColor];
  self.fundament.textColor = textColor;
}

- (UITextView *)textView {
  if (!_textView) {
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [self setupTextView];
  }
  return _textView;
}

- (void)setTextView:(UITextView *)textView {
  if (![textView isEqual:textView]) {
    _textView = textView;
    if (textView) {
      [self setupTextView];
    }
  }
}

- (UILabel *)trailingUnderlineLabel {
  return self.fundament.trailingUnderlineLabel;
}

- (UIView *)trailingView {
  return self.fundament.trailingView;
}

- (void)setTrailingView:(UIView *)trailingView {
  self.fundament.trailingView = trailingView;
}

- (MDCTextInputUnderlineView *)underline {
  return self.fundament.underline;
}

#pragma mark - UITextView Notification Observation

- (void)textViewDidBeginEditing:(UITextView *)textView {
  self.editing = YES;
  [self.fundament didBeginEditing];
}

- (void)textViewDidChange:(UITextView *)textView {
  [self.fundament didChange];
  CGSize currentSize = self.bounds.size;
  CGSize requiredSize = [self sizeThatFits:CGSizeMake(currentSize.width, CGFLOAT_MAX)];
  if (currentSize.height != requiredSize.height && self.textView.delegate &&
      [self.layoutDelegate
          respondsToSelector:@selector(multilineTextField:didChangeContentSize:)]) {
    id<MDCMultilineTextInputLayoutDelegate> delegate =
        (id<MDCMultilineTextInputLayoutDelegate>)self.layoutDelegate;
    [delegate multilineTextField:self didChangeContentSize:requiredSize];
  }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  self.editing = NO;
  [self.fundament didEndEditing];
}

#pragma mark - Accessibility

- (NSString *)accessibilityValue {
  NSString *value = [self.text length] ? self.text : self.placeholder;

  if (self.leadingUnderlineLabel.text.length > 0) {
    [value stringByAppendingFormat:@"%@ %@", [super accessibilityValue],
                                   self.leadingUnderlineLabel.accessibilityLabel];
  }

  return value;
}

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _fundament.mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  // Prior to iOS 9 RTL was not automatically applied, so we don't need to apply any fixes.
  if ([self.textView respondsToSelector:@selector(setAdjustsFontForContentSizeCategory:)]) {
    [self.textView setAdjustsFontForContentSizeCategory:adjusts];
  }

  [_fundament mdc_setAdjustsFontForContentSizeCategory:adjusts];
}

@end
