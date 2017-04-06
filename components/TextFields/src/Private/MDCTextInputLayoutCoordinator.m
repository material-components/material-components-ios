/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MDCTextInput.h"

#import "MDCTextField.h"
#import "MDCTextFieldPositioningDelegate.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputLayoutCoordinator.h"
#import "MDCTextInputUnderlineView.h"

#import "MaterialAnimationTiming.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

NSString *const MDCTextInputCoordinatorCharacterRelativeSuperviewKey =
    @"MDCTextInputCoordinatorCharacterRelativeSuperviewKey";
NSString *const MDCTextInputCoordinatorHidesPlaceholderKey =
    @"MDCTextInputCoordinatorHidesPlaceholderKey";
NSString *const MDCTextInputCoordinatorInputKey = @"MDCTextInputCoordinatorInputKey";
NSString *const MDCTextInputCoordinatorLeadingLabelKey = @"MDCTextInputCoordinatorLeadingLabelKey";
NSString *const MDCTextInputCoordinatorMDCAdjustsFontsKey =
    @"MDCTextInputCoordinatorMDCAdjustsFontsKey";
NSString *const MDCTextInputPositioningDelegateKey = @"MDCTextInputPositioningDelegateKey";
NSString *const MDCTextInputCoordinatorPlaceholderLabelKey =
    @"MDCTextInputCoordinatorPlaceholderLabelKey";
NSString *const MDCTextInputCoordinatorTextColorKey = @"MDCTextInputCoordinatorTextColorKey";
NSString *const MDCTextInputCoordinatorTrailingLabelKey =
    @"MDCTextInputCoordinatorTrailingLabelKey";
NSString *const MDCTextInputCoordinatorUnderlineViewKey =
    @"MDCTextInputCoordinatorUnderlineViewKey";

static const CGFloat MDCTextInputOverlayViewToEditingRectPadding = 2.f;
static const CGFloat MDCTextInputHintTextOpacity = 0.54f;
const CGFloat MDCTextInputVerticalPadding = 16.f;
const CGFloat MDCTextInputUnderlineVerticalSpacing = 8.f;

static inline UIColor *_Nonnull MDCTextInputCursorColor() {
  return [MDCPalette indigoPalette].tint500;
}

static inline UIColor *MDCTextInputDefaultPlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputHintTextOpacity];
}

static inline UIColor *MDCTextInputTextColor() {
  return [UIColor colorWithWhite:0 alpha:[MDCTypography body1FontOpacity]];
}

static inline UIColor *MDCTextInputUnderlineColor() {
  return [UIColor lightGrayColor];
}

static inline CGFloat MDCRound(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return rint(value);
#else
  return rintf(value);
#endif
}

@interface MDCTextInputLayoutCoordinator () {
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

@property(nonatomic, strong) NSLayoutConstraint *placeholderHeight;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeadingLeftViewTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingRightViewLeading;
@property(nonatomic, strong) UIView *relativeSuperview;
@property(nonatomic, weak) UIView<MDCTextInput> *textInput;
@property(nonatomic, strong) MDCTextInputUnderlineView *underlineView;
@property(nonatomic, strong) NSLayoutConstraint *underlineY;

@end

@implementation MDCTextInputLayoutCoordinator

// We never use the text property. Instead always read from the text field.

@synthesize attributedText = _do_no_use_attributedText;
@synthesize editing = _editing;
@synthesize hidesPlaceholderOnInput = _hidesPlaceholderOnInput;
@synthesize leadingUnderlineLabel = _leadingUnderlineLabel;
@synthesize placeholderLabel = _placeholderLabel;
@synthesize positioningDelegate = _positioningDelegate;
@synthesize text = _do_no_use_text;
@synthesize textColor = _textColor;
@synthesize trailingUnderlineLabel = _trailingUnderlineLabel;
@synthesize underlineColor = _underlineColor;
@synthesize underlineView = _underlineView;

- (instancetype)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (nonnull instancetype)initWithTextInput:(UIView<MDCTextInput> *_Nonnull)textInput {
  self = [super init];
  if (self) {
    _textInput = textInput;

    _cursorColor = MDCTextInputCursorColor();
    _textColor = MDCTextInputTextColor();
    _underlineColor = MDCTextInputUnderlineColor();

    self.textInput.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];

    // Initialize elements of UI
    [self setupRelativeSuperview];
    [self setupPlaceholderLabel];

    // This has to happen before the underline labels are added to the hierarchy.
    [self setupUnderlineView];
    [self setupUnderlineLabels];

    [self updateColors];
    [self mdc_setAdjustsFontForContentSizeCategory:YES];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  UIView<MDCTextInput> *input = [aDecoder decodeObjectForKey:MDCTextInputCoordinatorInputKey];

  self = [self initWithTextInput:input];
  if (self) {
    _hidesPlaceholderOnInput =
        [aDecoder decodeBoolForKey:MDCTextInputCoordinatorHidesPlaceholderKey];
    _leadingUnderlineLabel = [aDecoder decodeObjectForKey:MDCTextInputCoordinatorLeadingLabelKey];
    _mdc_adjustsFontForContentSizeCategory =
        [aDecoder decodeBoolForKey:MDCTextInputCoordinatorMDCAdjustsFontsKey];
    _placeholderLabel = [aDecoder decodeObjectForKey:MDCTextInputCoordinatorTextColorKey];
    _positioningDelegate = [aDecoder decodeObjectForKey:MDCTextInputPositioningDelegateKey];
    _relativeSuperview =
        [aDecoder decodeObjectForKey:MDCTextInputCoordinatorCharacterRelativeSuperviewKey];
    _textColor = [aDecoder decodeObjectForKey:MDCTextInputCoordinatorTextColorKey];
    _trailingUnderlineLabel = [aDecoder decodeObjectForKey:MDCTextInputCoordinatorTrailingLabelKey];
    _underlineView = [aDecoder decodeObjectForKey:MDCTextInputCoordinatorUnderlineViewKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeBool:self.hidesPlaceholderOnInput
              forKey:MDCTextInputCoordinatorHidesPlaceholderKey];
  [aCoder encodeObject:self.leadingUnderlineLabel forKey:MDCTextInputCoordinatorLeadingLabelKey];
  [aCoder encodeBool:self.mdc_adjustsFontForContentSizeCategory
              forKey:MDCTextInputCoordinatorMDCAdjustsFontsKey];
  [aCoder encodeObject:self.placeholderLabel forKey:MDCTextInputCoordinatorPlaceholderLabelKey];
  [aCoder encodeObject:self.positioningDelegate forKey:MDCTextInputPositioningDelegateKey];
  [aCoder encodeObject:self.relativeSuperview
                forKey:MDCTextInputCoordinatorCharacterRelativeSuperviewKey];
  [aCoder encodeObject:self.textColor forKey:MDCTextInputCoordinatorTextColorKey];
  [aCoder encodeObject:self.trailingUnderlineLabel forKey:MDCTextInputCoordinatorTrailingLabelKey];
  [aCoder encodeObject:self.underlineView forKey:MDCTextInputCoordinatorUnderlineViewKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextInputLayoutCoordinator *copy = [[[self class] alloc] init];

  copy.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
  copy.positioningDelegate = self.positioningDelegate;
  copy.relativeSuperview = self.relativeSuperview.copy;
  copy.textColor = self.textColor.copy;
  copy.underlineView = self.underlineView.copy;

  return copy;
}

- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

  [defaultCenter removeObserver:self];
}

// UITextViews are subclasses of UIScrollView and that complicates autolayout. This container is
// just a box to give a 'real' value to constraints related to superview.
- (void)setupRelativeSuperview {
  if ([_textInput isKindOfClass:[UIScrollView class]]) {
    _relativeSuperview = [[UIView alloc] initWithFrame:CGRectZero];
    [_textInput addSubview:_relativeSuperview];
    [_textInput sendSubviewToBack:_relativeSuperview];
    _relativeSuperview.opaque = NO;
    _relativeSuperview.backgroundColor = [UIColor clearColor];
    [_textInput setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                  forAxis:UILayoutConstraintAxisVertical];
    [_textInput setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                  forAxis:UILayoutConstraintAxisHorizontal];
  } else {
    _relativeSuperview = _textInput;
  }
}

- (void)setupPlaceholderLabel {
  _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [_placeholderLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                                     forAxis:UILayoutConstraintAxisHorizontal];
  _placeholderLabel.textAlignment = NSTextAlignmentNatural;

  _placeholderLabel.userInteractionEnabled = NO;
  _placeholderLabel.opaque = NO;

  _placeholderLabel.textColor = MDCTextInputDefaultPlaceholderTextColor();
  _placeholderLabel.font = _textInput.font;

  [_textInput addSubview:_placeholderLabel];
  [_textInput sendSubviewToBack:_placeholderLabel];

  [NSLayoutConstraint activateConstraints:[self placeholderDefaultConstaints]];

  _hidesPlaceholderOnInput = YES;
}

- (void)setupUnderlineLabels {
  _leadingUnderlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _trailingUnderlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];

  _leadingUnderlineLabel.textColor = MDCTextInputDefaultPlaceholderTextColor();
  _leadingUnderlineLabel.font = _textInput.font;
  _leadingUnderlineLabel.textAlignment = NSTextAlignmentNatural;

  _leadingUnderlineLabel.opaque = NO;

  [_leadingUnderlineLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_textInput addSubview:_leadingUnderlineLabel];

  _trailingUnderlineLabel.textColor = [UIColor grayColor];
  _trailingUnderlineLabel.font = _textInput.font;

  _trailingUnderlineLabel.opaque = NO;

  [_trailingUnderlineLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_textInput addSubview:_trailingUnderlineLabel];

  NSLayoutConstraint *leadingLeading =
      [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_relativeSuperview
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  leadingLeading.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *trailingTrailing =
      [NSLayoutConstraint constraintWithItem:_trailingUnderlineLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_relativeSuperview
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:0];
  trailingTrailing.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *labelSpacing =
      [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_trailingUnderlineLabel
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  labelSpacing.priority = UILayoutPriorityDefaultLow;

  [NSLayoutConstraint activateConstraints:@[ labelSpacing, leadingLeading, trailingTrailing ]];

  NSLayoutConstraint *leadingBottom = [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_relativeSuperview
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
  leadingBottom.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *trailingBottom =
      [NSLayoutConstraint constraintWithItem:_trailingUnderlineLabel
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_relativeSuperview
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0];
  trailingBottom.priority = UILayoutPriorityDefaultLow;

  [NSLayoutConstraint activateConstraints:@[ leadingBottom, trailingBottom ]];

  [_trailingUnderlineLabel
      setContentCompressionResistancePriority:UILayoutPriorityRequired
                                      forAxis:UILayoutConstraintAxisHorizontal];
  [_trailingUnderlineLabel setContentHuggingPriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setupUnderlineView {
  _underlineView = [[MDCTextInputUnderlineView alloc] initWithFrame:CGRectZero];
  _underlineView.color = self.underlineColor;
  _underlineView.translatesAutoresizingMaskIntoConstraints = NO;

  [self.textInput addSubview:_underlineView];
  [self.textInput sendSubviewToBack:_underlineView];

  [NSLayoutConstraint constraintWithItem:_underlineView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:_relativeSuperview
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:_underlineView
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:_relativeSuperview
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:0]
      .active = YES;
  _underlineY = [NSLayoutConstraint constraintWithItem:_underlineView
                                             attribute:NSLayoutAttributeCenterY
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:_relativeSuperview
                                             attribute:NSLayoutAttributeBottom
                                            multiplier:1
                                              constant:-1 * MDCTextInputUnderlineVerticalSpacing];
  _underlineY.active = YES;
}

- (void)layoutSubviewsOfInput {
  if (self.relativeSuperview != self.textInput) {
    self.relativeSuperview.frame = self.textInput.bounds;
    [self.textInput setNeedsUpdateConstraints];
  }

  if ([self.textInput isKindOfClass:[UITextView class]] &&
      !UIEdgeInsetsEqualToEdgeInsets(((UITextView *)self.textInput).textContainerInset,
                                     self.textContainerInset)) {
    ((UITextView *)self.textInput).textContainerInset = self.textContainerInset;
  }

  [self updatePlaceholderAlpha];
  [self updatePlaceholderPosition];
  [self updateColors];
}

- (void)updateConstraintsOfInput {
  [self updatePlaceholderPosition];
  [self updateUnderlinePosition];
}

#pragma mark - Underline View Implementation

- (void)setUnderlineColor:(UIColor *)underlineColor {
  if (!underlineColor) {
    underlineColor = MDCTextInputUnderlineColor();
  }

  if (_underlineColor != underlineColor) {
    _underlineColor = underlineColor;
    [self updateColors];
  }
}

- (CGFloat)underlineHeight {
  return self.underlineView.lineHeight;
}

- (void)setUnderlineHeight:(CGFloat)underlineHeight {
  self.underlineView.lineHeight = underlineHeight;
  [self.textInput setNeedsUpdateConstraints];
}

- (void)updateUnderlinePosition {
  // Usually the underline is halfway between the text and the bottom of the view. But if there are
  // underline labels, we need to be above them.

  CGFloat underlineYConstant = MDCTextInputUnderlineVerticalSpacing;

  CGFloat underlineLabelsHeight =
      MAX(MDCRound(CGRectGetHeight(self.leadingUnderlineLabel.bounds)),
          MDCRound(CGRectGetHeight(self.trailingUnderlineLabel.bounds)));
  underlineYConstant += underlineLabelsHeight;
  underlineYConstant *= -1;

  if (self.underlineY.constant != underlineYConstant) {
    self.underlineY.constant = underlineYConstant;
    [self.textInput invalidateIntrinsicContentSize];
  }
}

#pragma mark - Properties Implementation

- (NSAttributedString *)attributedPlaceholder {
  id placeholderString = self.placeholderLabel.text;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    // TODO: (larche) Return string attributes also. Tho I feel like that should come from the
    // placeholderLabel itself somehow.
    NSAttributedString *constructedString =
        [[NSAttributedString alloc] initWithString:(NSString *)placeholderString attributes:nil];
    return constructedString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return (NSAttributedString *)placeholderString;
  }

  return nil;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  self.placeholderLabel.text = attributedPlaceholder.string;
  // TODO: (larche) Read string attributes also. Tho I feel like that should come from the
  // placeholderLabel itself somehow.

  [self updatePlaceholderAlpha];
  [self.textInput setNeedsUpdateConstraints];
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  self.underlineView.enabled = enabled;
}

- (UIFont *)font {
  return self.textInput.font;
}

- (void)setFont:(UIFont *)font {
  [self.textInput setFont:font];
}

- (NSString *)placeholder {
  id placeholderString = self.placeholderLabel.text;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    return (NSString *)placeholderString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return [(NSAttributedString *)placeholderString string];
  }

  return nil;
}

- (void)setPlaceholder:(NSString *)placeholder {
  self.placeholderLabel.text = placeholder;
  [self updatePlaceholderAlpha];
  [self.textInput setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor {
  if (!textColor) {
    textColor = MDCTextInputTextColor();
  }

  if (_textColor != textColor) {
    _textColor = textColor;
    [self updateColors];
  }
}

- (UIEdgeInsets)textContainerInset {
  UIEdgeInsets textContainerInset = UIEdgeInsetsZero;

  textContainerInset.top = MDCTextInputVerticalPadding;
  textContainerInset.bottom = MDCTextInputVerticalPadding;

  if ([self.textInput.positioningDelegate respondsToSelector:@selector(textContainerInset:)]) {
    return [self.textInput.positioningDelegate textContainerInset:textContainerInset];
  }
  return textContainerInset;
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  _textInput = textInput;

  [_textInput setNeedsLayout];
}

#pragma mark - Layout

- (void)updateColors {
  self.textInput.tintColor = self.cursorColor;
  self.textInput.textColor = self.textColor;

  self.underlineView.color = self.underlineColor;
}

- (void)updateFontsForDynamicType {
  if (self.mdc_adjustsFontForContentSizeCategory) {
    UIFont *textFont = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
    self.textInput.font = textFont;
    self.leadingUnderlineLabel.font = textFont;
    self.trailingUnderlineLabel.font = textFont;
    self.placeholderLabel.font = textFont;
  }
}

- (void)updatePlaceholderToOverlayViewsPosition {
  if (![self.textInput isKindOfClass:[MDCTextField class]]) {
    return;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;
  if (textField.leftView.superview && !self.placeholderLeadingLeftViewTrailing) {
    self.placeholderLeadingLeftViewTrailing =
        [NSLayoutConstraint constraintWithItem:textField.placeholderLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:textField.leftView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:MDCTextInputOverlayViewToEditingRectPadding];
    self.placeholderLeadingLeftViewTrailing.priority = UILayoutPriorityDefaultLow + 1;
    self.placeholderLeadingLeftViewTrailing.active = YES;
  } else if (!textField.leftView.superview && self.placeholderLeadingLeftViewTrailing) {
    self.placeholderLeadingLeftViewTrailing = nil;
  }

  if (textField.rightView.superview && !self.placeholderTrailingRightViewLeading) {
    self.placeholderTrailingRightViewLeading =
        [NSLayoutConstraint constraintWithItem:textField.placeholderLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                        toItem:textField.rightView
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:MDCTextInputOverlayViewToEditingRectPadding];
    self.placeholderTrailingRightViewLeading.priority = UILayoutPriorityDefaultLow + 1;
    self.placeholderTrailingRightViewLeading.active = YES;
  } else if (!textField.rightView.superview && self.placeholderTrailingRightViewLeading) {
    self.placeholderTrailingRightViewLeading = nil;
  }
}

- (void)updatePlaceholderAlpha {
  if (!self.hidesPlaceholderOnInput) {
    return;
  }
  CGFloat opacity = self.textInput.text.length ? 0 : 1;
  self.placeholderLabel.alpha = opacity;
}

- (void)updatePlaceholderPosition {
  if (self.placeholderLabel.layer.animationKeys.count > 0) {
    // We don't need to get in the middle of animations.
    return;
  }

  self.placeholderTop.constant = [self textContainerInset].top;

  [self updatePlaceholderToOverlayViewsPosition];
  [self.textInput invalidateIntrinsicContentSize];
}

- (NSArray<NSLayoutConstraint *> *)placeholderDefaultConstaints {
  self.placeholderTop = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_relativeSuperview
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:[self textContainerInset].top];

  // This can be affected by .leftView and .rightView.
  // See updatePlaceholderToAssociateViewsPosition()
  self.placeholderLeading = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_relativeSuperview
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1
                                                          constant:[self textContainerInset].left];
  self.placeholderTrailing = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                             toItem:_relativeSuperview
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:8];

  [self.placeholderTop setPriority:UILayoutPriorityDefaultLow];
  [self.placeholderLeading setPriority:UILayoutPriorityDefaultLow];
  [self.placeholderTrailing setPriority:UILayoutPriorityDefaultLow];

  return @[ self.placeholderTop, self.placeholderLeading, self.placeholderTrailing ];
}

#pragma mark - Text Input Events

- (void)didBeginEditing {
  [self.textInput invalidateIntrinsicContentSize];
}

- (void)didChange {
  [self updatePlaceholderAlpha];
  [self updatePlaceholderPosition];
}

- (void)didSetFont {
  UIFont *font = self.textInput.font;
  self.placeholderLabel.font = font;

  [self updatePlaceholderPosition];
}

- (void)didSetText {
  [self didChange];
  [self.textInput setNeedsLayout];
}

#pragma mark - Accessibility

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (adjusts) {
    [self updateFontsForDynamicType];
  }

  if (_mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  [self updateFontsForDynamicType];
}

@end
