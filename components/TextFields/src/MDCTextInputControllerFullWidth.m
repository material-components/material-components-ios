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

#import "MDCTextInputControllerFullWidth.h"

#import "MDCIntrinsicHeightTextView.h"
#import "MDCMultilineTextField.h"
#import "MDCTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputUnderlineView.h"

#import "MaterialAnimationTiming.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

static const CGFloat MDCTextInputControllerFullWidthHintTextOpacity = (CGFloat)0.54;
static const CGFloat MDCTextInputControllerFullWidthHorizontalInnerPadding = 8;
static const CGFloat MDCTextInputControllerFullWidthHorizontalPadding = 16;
static const CGFloat MDCTextInputControllerFullWidthVerticalPadding = 20;

static inline UIColor *MDCTextInputControllerFullWidthInlinePlaceholderTextColorDefault() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputControllerFullWidthHintTextOpacity];
}

static inline UIColor *MDCTextInputControllerFullWidthErrorColorDefault() {
  return [MDCPalette redPalette].accent400;
}

#pragma mark - Class Properties

static BOOL _mdc_adjustsFontForContentSizeCategoryDefault = NO;
static UIColor *_backgroundColorDefault;
static UIColor *_errorColorDefault;
static UIColor *_inlinePlaceholderColorDefault;
static UIColor *_trailingUnderlineLabelTextColorDefault;

static UIFont *_inlinePlaceholderFontDefault;
static UIFont *_textInputFontDefault;
static UIColor *_textInputClearButtonTintColorDefault;
static UIFont *_trailingUnderlineLabelFontDefault;

@interface MDCTextInputControllerFullWidth () {
  BOOL _mdc_adjustsFontForContentSizeCategory;

  MDCTextInputAllCharactersCounter *_characterCounter;

  UIColor *_backgroundColor;
  UIColor *_errorColor;
  UIColor *_inlinePlaceholderColor;
  UIColor *_trailingUnderlineLabelTextColor;

  UIFont *_inlinePlaceholderFont;
  UIFont *_textInputFont;
  UIColor *_textInputClearButtonTintColor;
  UIFont *_trailingUnderlineLabelFont;
}

@property(nonatomic, assign, readonly) BOOL isDisplayingCharacterCountError;

@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;

@property(nonatomic, strong) NSLayoutConstraint *characterCountY;
@property(nonatomic, strong) NSLayoutConstraint *characterCountTrailing;
@property(nonatomic, strong) NSLayoutConstraint *clearButtonY;
@property(nonatomic, strong) NSLayoutConstraint *clearButtonTrailingCharacterCountLeading;
@property(nonatomic, strong) NSLayoutConstraint *multilineCharacterCountHeight;
@property(nonatomic, strong) NSLayoutConstraint *multilinePlaceholderCenterY;
@property(nonatomic, strong) NSLayoutConstraint *multilineTextViewBottom;
@property(nonatomic, strong) NSLayoutConstraint *multilineTextViewTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingCharacterCountLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingSuperviewTrailing;

@property(nonatomic, copy) NSString *errorAccessibilityValue;
@property(nonatomic, copy, readwrite) NSString *errorText;
@property(nonatomic, copy) NSString *helperAccessibilityLabel;
@property(nonatomic, copy) NSString *previousLeadingText;

@property(nonatomic, strong) UIColor *previousPlaceholderColor;

@end

@implementation MDCTextInputControllerFullWidth

@synthesize backgroundColor = _backgroundColor;
@synthesize characterCountMax = _characterCountMax;
@synthesize characterCountViewMode = _characterCountViewMode;
@synthesize textInput = _textInput;

// TODO: (larche): Support in-line auto complete.

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCTextInputControllerFullWidthInitialization];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonMDCTextInputControllerFullWidthInitialization];
  }
  return self;
}

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)textInput {
  self = [self init];
  if (self) {
    _textInput = textInput;

    [self setupInput];
  }
  return self;
}

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCTextInputControllerFullWidth *copy = [[[self class] alloc] init];

  copy.characterCounter = self.characterCounter;  // Just a pointer value copy
  copy.characterCountViewMode = self.characterCountViewMode;
  copy.characterCountMax = self.characterCountMax;
  copy.errorAccessibilityValue = [self.errorAccessibilityValue copy];
  copy.errorColor = self.errorColor;
  copy.errorText = [self.errorText copy];
  copy.helperText = [self.helperText copy];
  copy.inlinePlaceholderColor = self.inlinePlaceholderColor;
  copy.inlinePlaceholderFont = self.inlinePlaceholderFont;
  copy.previousLeadingText = [self.previousLeadingText copy];
  copy.previousPlaceholderColor = self.previousPlaceholderColor;
  copy.textInput = self.textInput;  // Just a pointer value copy
  copy.trailingUnderlineLabelFont = self.trailingUnderlineLabelFont;
  copy.trailingUnderlineLabelTextColor = self.trailingUnderlineLabelTextColor;

  copy.activeColor = self.activeColor;
  copy.disabledColor = self.disabledColor;
  copy.normalColor = self.normalColor;

  return copy;
}

- (void)dealloc {
  [self unsubscribeFromNotifications];
}

- (void)commonMDCTextInputControllerFullWidthInitialization {
  _characterCountViewMode = UITextFieldViewModeAlways;
  _internalCharacterCounter = [[MDCTextInputAllCharactersCounter alloc] init];
}

- (void)setupInput {
  if (!_textInput) {
    return;
  }

  // This controller will handle Dynamic Type and all fonts for the text input
  _mdc_adjustsFontForContentSizeCategory =
      _textInput.mdc_adjustsFontForContentSizeCategory ||
      [self class].mdc_adjustsFontForContentSizeCategoryDefault;
  _textInput.mdc_adjustsFontForContentSizeCategory = NO;
  _textInput.positioningDelegate = self;

  [self subscribeForNotifications];
  _textInput.underline.color = [UIColor clearColor];
  _textInput.clearButton.tintColor = self.textInputClearButtonTintColor;
  [self updateLayout];
}

- (void)subscribeForNotifications {
  if (!_textInput) {
    return;
  }
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

  if ([_textInput isKindOfClass:[UITextField class]]) {
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidBeginEditing:)
                          name:UITextFieldTextDidBeginEditingNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidChange:)
                          name:UITextFieldTextDidChangeNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidEndEditing:)
                          name:UITextFieldTextDidEndEditingNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidChange:)
                          name:MDCTextFieldTextDidSetTextNotification
                        object:_textInput];
  }

  if ([_textInput isKindOfClass:[MDCMultilineTextField class]]) {
    MDCMultilineTextField *textField = (MDCMultilineTextField *)_textInput;
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidBeginEditing:)
                          name:UITextViewTextDidBeginEditingNotification
                        object:textField.textView];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidChange:)
                          name:UITextViewTextDidChangeNotification
                        object:textField.textView];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidEndEditing:)
                          name:UITextViewTextDidEndEditingNotification
                        object:textField.textView];
  }
}

- (void)unsubscribeFromNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self];
}

#pragma mark - Character Max Implementation

- (NSUInteger)characterCount {
  return [self.characterCounter characterCountForTextInput:self.textInput];
}

- (id<MDCTextInputCharacterCounter>)characterCounter {
  if (!_characterCounter) {
    _characterCounter = self.internalCharacterCounter;
  }
  return _characterCounter;
}

- (void)setCharacterCounter:(id<MDCTextInputCharacterCounter>)characterCounter {
  if (_characterCounter != characterCounter) {
    _characterCounter = characterCounter;
    [self updateLayout];
  }
}

- (void)setCharacterCountMax:(NSUInteger)characterCountMax {
  if (_characterCountMax != characterCountMax) {
    _characterCountMax = characterCountMax;
    [self updateLayout];
  }
}

#pragma  mark - TextInput Customization

- (void)updateTextInput {
  UIFont *font = self.textInputFont;
  if (self.mdc_adjustsFontForContentSizeCategory) {
    // TODO: (#4331) This needs to be converted to the new text scheme.
    font =
        [font mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                           scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  }
  self.textInput.font = font;
}

#pragma mark - Leading Label Customization

- (void)updateLeadingUnderlineLabel {
  self.textInput.leadingUnderlineLabel.text = nil;
  self.textInput.leadingUnderlineLabel.textColor = self.leadingUnderlineLabelTextColor;
}

#pragma mark - Placeholder Customization

- (void)updatePlaceholder {
  UIFont *placeHolderFont = self.inlinePlaceholderFont;
  if (self.mdc_adjustsFontForContentSizeCategory) {
    // TODO: (#4331) This needs to be converted to the new text scheme.
    placeHolderFont =
        [placeHolderFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                                      scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];

  }

  self.textInput.placeholderLabel.font = placeHolderFont;
  self.textInput.placeholderLabel.textColor = self.inlinePlaceholderColor;
  self.textInput.placeholderLabel.backgroundColor = self.backgroundColor;
}

#pragma mark - Trailing Label Customization

- (void)updateTrailingUnderlineLabel {
  if (!self.characterCountMax) {
    self.textInput.trailingUnderlineLabel.text = nil;
  } else {
    self.textInput.trailingUnderlineLabel.text = [self characterCountText];
    UIFont *font = self.trailingUnderlineLabelFont;
    if (self.mdc_adjustsFontForContentSizeCategory) {
      // TODO: (#4331) This needs to be converted to the new text scheme.
      font =
          [font mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleCaption
                             scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
    }
    self.textInput.trailingUnderlineLabel.font = font;
  }

  UIColor *textColor = self.trailingUnderlineLabelTextColor;

  if (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) {
    textColor = self.errorColor;
  }

  switch (self.characterCountViewMode) {
    case UITextFieldViewModeAlways:
      break;
    case UITextFieldViewModeWhileEditing:
      textColor = !self.textInput.isEditing ? [UIColor clearColor] : textColor;
      break;
    case UITextFieldViewModeUnlessEditing:
      textColor = self.textInput.isEditing ? [UIColor clearColor] : textColor;
      break;
    case UITextFieldViewModeNever:
      textColor = [UIColor clearColor];
      break;
  }

  self.textInput.trailingUnderlineLabel.textColor = textColor;
  self.textInput.trailingUnderlineLabel.backgroundColor = self.backgroundColor;
}

- (NSString *)characterCountText {
  // TODO: (larche) Localize
  return [NSString stringWithFormat:@"%lu / %lu", (unsigned long)[self characterCount],
                                    (unsigned long)self.characterCountMax];
}

#pragma mark - Underline Customization

- (void)updateUnderline {
  // Hide the underline.
  self.textInput.underline.color = [UIColor clearColor];
}

#pragma mark - Underline Labels Fonts

+ (UIFont *)placeholderFont {
  // TODO: (#4331) This needs to be converted to the new text scheme.
  return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleBody1];
}

+ (UIFont *)underlineLabelsFont {
  // TODO: (#4331) This needs to be converted to the new text scheme.
  return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];
}

#pragma mark - Properties Implementation

// The underline is never shown in this style.
- (void)setActiveColor:(__unused UIColor *)activeColor {
  [self updateUnderline];
}

- (UIColor *)activeColor {
  return [UIColor clearColor];
}

+ (UIColor *)activeColorDefault {
  return [UIColor clearColor];
}

+ (void)setActiveColorDefault:(__unused UIColor *)activeColorDefault {
  // Not implemented. Underline is always clear.
}

- (UIColor *)backgroundColor {
  if (!_backgroundColor) {
    _backgroundColor = [self class].backgroundColorDefault;
  }
  return _backgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  if (_backgroundColor != backgroundColor) {
    _backgroundColor = backgroundColor ?: [self class].backgroundColorDefault;
  }
}

+ (UIColor *)backgroundColorDefault {
  if (!_backgroundColorDefault) {
    _backgroundColorDefault = [UIColor clearColor];
  }
  return _backgroundColorDefault;
}

+ (void)setBackgroundColorDefault:(UIColor *)backgroundColorDefault {
  _backgroundColorDefault = backgroundColorDefault ?: [UIColor clearColor];
}

- (void)setCharacterCountViewMode:(UITextFieldViewMode)characterCountViewMode {
  if (_characterCountViewMode != characterCountViewMode) {
    _characterCountViewMode = characterCountViewMode;

    [self updateLayout];
  }
}

- (void)setDisabledColor:(__unused UIColor *)disabledColor {
  [self updateUnderline];
}

- (UIColor *)disabledColor {
  return [UIColor clearColor];
}

+ (void)setDisabledColorDefault:(__unused UIColor *)disabledColorDefault {
  // This controller does not have decorations that need to change for a disabled state.
}

+ (UIColor *)disabledColorDefault {
  return [UIColor clearColor];
}

- (void)setErrorAccessibilityValue:(NSString *)errorAccessibilityValue {
  _errorAccessibilityValue = [errorAccessibilityValue copy];
}

-(void)setHelperAccessibilityLabel:(NSString *)helperAccessibilityLabel {
  _helperAccessibilityLabel = [helperAccessibilityLabel copy];
  if ([self.textInput.leadingUnderlineLabel.text isEqualToString:self.helperText]) {
    self.textInput.leadingUnderlineLabel.accessibilityLabel = _helperAccessibilityLabel;
  }
}

- (UIColor *)errorColor {
  if (!_errorColor) {
    _errorColor = [self class].errorColorDefault;
  }
  return _errorColor;
}

- (void)setErrorColor:(UIColor *)errorColor {
  if (![_errorColor isEqual:errorColor]) {
    _errorColor = errorColor ? errorColor : [self class].errorColorDefault;
    if (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) {
      [self updateLeadingUnderlineLabel];
      [self updatePlaceholder];
      [self updateTrailingUnderlineLabel];
      [self updateUnderline];
    }
  }
}

+ (UIColor *)errorColorDefault {
  if (!_errorColorDefault) {
    _errorColorDefault = MDCTextInputControllerFullWidthErrorColorDefault();
  }
  return _errorColorDefault;
}

+ (void)setErrorColorDefault:(UIColor *)errorColorDefault {
  _errorColorDefault =
      errorColorDefault ? errorColorDefault : MDCTextInputControllerFullWidthErrorColorDefault();
}

- (void)setErrorText:(NSString *)errorText {
  _errorText = [errorText copy];
}

- (void)setHelperText:(NSString *)helperText {
  if (self.isDisplayingErrorText) {
    self.previousLeadingText = helperText;
  } else {
    if (![self.textInput.leadingUnderlineLabel.text isEqualToString:helperText]) {
      self.textInput.leadingUnderlineLabel.text = helperText;
      [self updateLayout];
    }
  }
}

- (NSString *)helperText {
  if (self.isDisplayingErrorText) {
    return self.previousLeadingText;
  } else {
    return self.textInput.leadingUnderlineLabel.text;
  }
}

- (void)setInlinePlaceholderColor:(UIColor *)inlinePlaceholderColor {
  if (![_inlinePlaceholderColor isEqual:inlinePlaceholderColor]) {
    _inlinePlaceholderColor = inlinePlaceholderColor;
    [self updatePlaceholder];
  }
}

- (UIColor *)inlinePlaceholderColor {
  return _inlinePlaceholderColor ? _inlinePlaceholderColor
                                 : [self class].inlinePlaceholderColorDefault;
}

+ (UIColor *)inlinePlaceholderColorDefault {
  if (!_inlinePlaceholderColorDefault) {
    _inlinePlaceholderColorDefault =
        MDCTextInputControllerFullWidthInlinePlaceholderTextColorDefault();
  }
  return _inlinePlaceholderColorDefault;
}

+ (void)setInlinePlaceholderColorDefault:(UIColor *)inlinePlaceholderColorDefault {
  _inlinePlaceholderColorDefault =
      inlinePlaceholderColorDefault
          ? inlinePlaceholderColorDefault
          : MDCTextInputControllerFullWidthInlinePlaceholderTextColorDefault();
}

- (UIFont *)inlinePlaceholderFont {
  return _inlinePlaceholderFont ?: [self class].inlinePlaceholderFontDefault;
}

- (void)setInlinePlaceholderFont:(UIFont *)inlinePlaceholderFont {
  if (![_inlinePlaceholderFont isEqual:inlinePlaceholderFont]) {
    _inlinePlaceholderFont = inlinePlaceholderFont;
    [self updateLayout];
  }
}

+ (UIFont *)inlinePlaceholderFontDefault {
  return _inlinePlaceholderFontDefault ?: [[self class] placeholderFont];
}

+ (void)setInlinePlaceholderFontDefault:(UIFont *)inlinePlaceholderFontDefault {
  _inlinePlaceholderFontDefault = inlinePlaceholderFontDefault;
}

- (BOOL)isDisplayingCharacterCountError {
  return self.characterCountMax && [self characterCount] > self.characterCountMax;
}

- (BOOL)isDisplayingErrorText {
  return self.errorText != nil;
}

- (UIFont *)leadingUnderlineLabelFont {
  // Not implemented. The leading underline label is never seen.
  return [[self class] leadingUnderlineLabelFontDefault];
}

- (void)setLeadingUnderlineLabelFont:(__unused UIColor *)leadingUnderlineLabelFont {
  // Not implemented. The leading underline label is never seen.
}

+ (UIFont *)leadingUnderlineLabelFontDefault {
  // Implemented only for protocol conformance. The leading underline label is never seen.
  return [[self class] underlineLabelsFont];
}

+ (void)setLeadingUnderlineLabelFontDefault:(__unused UIFont *)leadingUnderlineLabelFontDefault {
  // Not implemented. The leading underline label is never seen.
}

// The leading underline label must always be clear to not obstruct the placeholder and input.
- (UIColor *)leadingUnderlineLabelTextColor {
  return [UIColor clearColor];
}

- (void)setLeadingUnderlineLabelTextColor:(__unused UIColor *)leadingUnderlineLabelTextColor {
  // Not implemented. Leading underline label is always clear.
}

+ (UIColor *)leadingUnderlineLabelTextColorDefault {
  return [UIColor clearColor];
}

+ (void)setLeadingUnderlineLabelTextColorDefault:
        (__unused UIColor *)leadingUnderlineLabelTextColorDefault {
  // Not implemented. Leading underline label is always clear.
}

// The underline is never shown in this style.
- (void)setNormalColor:(__unused UIColor *)normalColor {
  [self updateUnderline];
}

- (UIColor *)normalColor {
  return [UIColor clearColor];
}

+ (void)setNormalColorDefault:(__unused UIColor *)normalColorDefault {
  // Not implemented. Underline is always clear.
}

+ (UIColor *)normalColorDefault {
  return [UIColor clearColor];
}

- (NSString *)placeholderText {
  return _textInput.placeholder;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
  if ([_textInput.placeholder isEqualToString:placeholderText]) {
    return;
  }
  _textInput.placeholder = [placeholderText copy];
}

- (void)setPreviousLeadingText:(NSString *)previousLeadingText {
  _previousLeadingText = [previousLeadingText copy];
}

- (void)setPreviousPlaceholderColor:(UIColor *)previousPlaceholderColor {
  _previousPlaceholderColor = previousPlaceholderColor;
}

- (UIRectCorner)roundedCorners {
  return 0;
}

- (void)setRoundedCorners:(__unused UIRectCorner)roundedCorners {
  // Not implemented. There are no corners to round.
}

+ (UIRectCorner)roundedCornersDefault {
  return 0;
}

+ (void)setRoundedCornersDefault:(__unused UIRectCorner)roundedCornersDefault {
  // Not implemented. There are no corners to round.
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  if (_textInput != textInput) {
    [self unsubscribeFromNotifications];

    _textInput = textInput;
    [self setupInput];
  }
}

- (UIFont *)textInputFont {
  if (_textInputFont) {
    return _textInputFont;
  }
  return [self class].textInputFontDefault ?: self.textInput.font;
}

- (void)setTextInputFont:(UIFont *)textInputFont {
  if (![_textInputFont isEqual:textInputFont]) {
    _textInputFont = textInputFont;
    [self updateLayout];
  }
}

+ (UIFont *)textInputFontDefault {
  return _textInputFontDefault;
}

+ (void)setTextInputFontDefault:(UIFont *)textInputFontDefault {
  _textInputFontDefault = textInputFontDefault;
}

- (UIColor *)textInputClearButtonTintColor {
    if (_textInputClearButtonTintColor) {
        return _textInputClearButtonTintColor;
    }
    return [self class].textInputClearButtonTintColorDefault ?: self.textInput.clearButton.tintColor;
}

- (void)setTextInputClearButtonTintColor:(UIColor *)textInputClearButtonTintColor {
    _textInputClearButtonTintColor = textInputClearButtonTintColor;
    _textInput.clearButton.tintColor = _textInputClearButtonTintColor;
}

+ (UIColor *)textInputClearButtonTintColorDefault {
    return _textInputClearButtonTintColorDefault;
}

+ (void)setTextInputClearButtonTintColorDefault:(UIColor *)textInputClearButtonTintColorDefault {
    _textInputClearButtonTintColorDefault = textInputClearButtonTintColorDefault;
}

- (UIFont *)trailingUnderlineLabelFont {
  return _trailingUnderlineLabelFont ?: [self class].trailingUnderlineLabelFontDefault;
}

- (void)setTrailingUnderlineLabelFont:(UIFont *)trailingUnderlineLabelFont {
  if (![_trailingUnderlineLabelFont isEqual:trailingUnderlineLabelFont]) {
    _trailingUnderlineLabelFont = trailingUnderlineLabelFont;
    [self updateLayout];
  }
}

+ (UIFont *)trailingUnderlineLabelFontDefault {
  return _trailingUnderlineLabelFontDefault ?: [[self class] underlineLabelsFont];
}

+ (void)setTrailingUnderlineLabelFontDefault:(UIFont *)trailingUnderlineLabelFontDefault {
  _trailingUnderlineLabelFontDefault = trailingUnderlineLabelFontDefault;
}

- (UIColor *)trailingUnderlineLabelTextColor {
  return _trailingUnderlineLabelTextColor ? _trailingUnderlineLabelTextColor
                                          : [self class].trailingUnderlineLabelTextColorDefault;
}

- (void)setTrailingUnderlineLabelTextColor:(UIColor *)trailingUnderlineLabelTextColor {
  if (_trailingUnderlineLabelTextColor != trailingUnderlineLabelTextColor) {
    _trailingUnderlineLabelTextColor = trailingUnderlineLabelTextColor
                                           ? trailingUnderlineLabelTextColor
                                           : [self class].trailingUnderlineLabelTextColorDefault;

    [self updateTrailingUnderlineLabel];
  }
}

+ (UIColor *)trailingUnderlineLabelTextColorDefault {
  if (!_trailingUnderlineLabelTextColorDefault) {
    _trailingUnderlineLabelTextColorDefault =
        MDCTextInputControllerFullWidthInlinePlaceholderTextColorDefault();
  }
  return _trailingUnderlineLabelTextColorDefault;
}

+ (void)setTrailingUnderlineLabelTextColorDefault:
        (UIColor *)trailingUnderlineLabelTextColorDefault {
  _trailingUnderlineLabelTextColorDefault =
      trailingUnderlineLabelTextColorDefault
          ? trailingUnderlineLabelTextColorDefault
          : MDCTextInputControllerFullWidthInlinePlaceholderTextColorDefault();
}

- (CGFloat)underlineHeightActive {
  return 0;
}

- (void)setUnderlineHeightActive:(__unused CGFloat)underlineHeightActive {
  // Not implemented. Underline is never shown.
}

+ (CGFloat)underlineHeightActiveDefault {
  return 0;
}

+ (void)setUnderlineHeightActiveDefault:(__unused CGFloat)underlineHeightActiveDefault {
  // Not implemented. Underline is never shown.
}

- (CGFloat)underlineHeightNormal {
  return 0;
}

- (void)setUnderlineHeightNormal:(__unused CGFloat)underlineHeightNormal {
  // Not implemented. Underline is never shown.
}

+ (CGFloat)underlineHeightNormalDefault {
  return 0;
}

+ (void)setUnderlineHeightNormalDefault:(__unused CGFloat)underlineHeightNormalDefault {
  // Not implemented. Underline is never shown.
}

- (UITextFieldViewMode)underlineViewMode {
  return UITextFieldViewModeNever;
}

- (void)setUnderlineViewMode:(__unused UITextFieldViewMode)underlineViewMode {
  [self updateLayout];
}

+ (UITextFieldViewMode)underlineViewModeDefault {
  return UITextFieldViewModeNever;
}

+ (void)setUnderlineViewModeDefault:(__unused UITextFieldViewMode)underlineViewModeDefault {
  // Not implemented. Underline is never shown.
}

#pragma mark - Layout

- (void)updateLayout {
  if (!_textInput) {
    return;
  }

  [self updatePlaceholder];
  [self updateLeadingUnderlineLabel];
  [self updateTrailingUnderlineLabel];
  [self updateTextInput];
  [self updateUnderline];
  [self updateConstraints];
}

- (void)updateConstraints {
  if (!self.characterCountTrailing) {
    self.characterCountTrailing = [NSLayoutConstraint
        constraintWithItem:self.textInput.trailingUnderlineLabel
                 attribute:NSLayoutAttributeTrailing
                 relatedBy:NSLayoutRelationEqual
                    toItem:self.textInput
                 attribute:NSLayoutAttributeTrailing
                multiplier:1
                  constant:-1 * MDCTextInputControllerFullWidthHorizontalPadding];
  }
  if (!self.clearButtonTrailingCharacterCountLeading) {
    self.clearButtonTrailingCharacterCountLeading =
        [NSLayoutConstraint constraintWithItem:self.textInput.clearButton
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput.trailingUnderlineLabel
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:0];
  }
  if (!self.placeholderLeading) {
    self.placeholderLeading =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:MDCTextInputControllerFullWidthHorizontalPadding];
  }
  if (!self.placeholderTrailingCharacterCountLeading) {
    self.placeholderTrailingCharacterCountLeading = [NSLayoutConstraint
        constraintWithItem:self.textInput.placeholderLabel
                 attribute:NSLayoutAttributeTrailing
                 relatedBy:NSLayoutRelationLessThanOrEqual
                    toItem:self.textInput.trailingUnderlineLabel
                 attribute:NSLayoutAttributeLeading
                multiplier:1
                  constant:-1 * MDCTextInputControllerFullWidthHorizontalInnerPadding];
  }
  if (!self.placeholderTrailingSuperviewTrailing) {
    self.placeholderTrailingSuperviewTrailing = [NSLayoutConstraint
        constraintWithItem:self.textInput.placeholderLabel
                 attribute:NSLayoutAttributeTrailing
                 relatedBy:NSLayoutRelationLessThanOrEqual
                    toItem:self.textInput
                 attribute:NSLayoutAttributeTrailing
                multiplier:1
                  constant:-1 * MDCTextInputControllerFullWidthHorizontalPadding];
  }

  // Multi-line Only
  if ([self.textInput isKindOfClass:[MDCMultilineTextField class]]) {
    [self.textInput.leadingUnderlineLabel setContentHuggingPriority:UILayoutPriorityRequired
                                                            forAxis:UILayoutConstraintAxisVertical];
    [self.textInput.leadingUnderlineLabel
        setContentCompressionResistancePriority:UILayoutPriorityRequired
                                        forAxis:UILayoutConstraintAxisVertical];

    [self.textInput.trailingUnderlineLabel
        setContentCompressionResistancePriority:UILayoutPriorityRequired
                                        forAxis:UILayoutConstraintAxisVertical];
    if (!self.characterCountY) {
      self.characterCountY =
          [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:((MDCMultilineTextField *)self.textInput).textView
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1
                                        constant:0];
    }
    if (!self.clearButtonY) {
      self.clearButtonY =
          [NSLayoutConstraint constraintWithItem:self.textInput.clearButton
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput.trailingUnderlineLabel
                                       attribute:NSLayoutAttributeCenterY
                                      multiplier:1
                                        constant:0];
    }

    if (!self.multilineTextViewBottom) {
      self.multilineTextViewBottom = [NSLayoutConstraint
          constraintWithItem:((MDCMultilineTextField *)self.textInput).textView
                   attribute:NSLayoutAttributeBottom
                   relatedBy:NSLayoutRelationEqual
                      toItem:self.textInput
                   attribute:NSLayoutAttributeBottom
                  multiplier:1
                    constant:-1 * MDCTextInputControllerFullWidthVerticalPadding];
    }
    if (!self.multilineTextViewTop) {
      self.multilineTextViewTop =
          [NSLayoutConstraint constraintWithItem:((MDCMultilineTextField *)self.textInput).textView
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1
                                        constant:MDCTextInputControllerFullWidthVerticalPadding];
    }

    if (!self.multilinePlaceholderCenterY) {
      self.multilinePlaceholderCenterY =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:((MDCMultilineTextField *)self.textInput).textView
                                       attribute:NSLayoutAttributeCenterY
                                      multiplier:1
                                        constant:0];
    }

    CGFloat scale = UIScreen.mainScreen.scale;
    CGFloat characterCountHeightConstant =
        MDCCeil(((MDCMultilineTextField *)self.textInput).textView.font.lineHeight * scale) / scale;
    if (!self.multilineCharacterCountHeight) {
      self.multilineCharacterCountHeight =
          [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                       attribute:NSLayoutAttributeHeight
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:nil
                                       attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1
                                        constant:characterCountHeightConstant];
    }
    self.multilineCharacterCountHeight.constant = characterCountHeightConstant;

    [NSLayoutConstraint activateConstraints:@[
      self.multilineTextViewBottom, self.multilineTextViewTop, self.multilinePlaceholderCenterY,
      self.multilineCharacterCountHeight
    ]];

    // A height constraint is not necessary for multiline. Its height is calculated in
    // intrinsicContentSize:
  } else {
    // Single-line Only
    // .fullWidth
    if (!self.characterCountY) {
      self.characterCountY =
          [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeCenterY
                                      multiplier:1
                                        constant:0];
    }
    if (!self.clearButtonY) {
      self.clearButtonY = [NSLayoutConstraint constraintWithItem:self.textInput.clearButton
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self.textInput
                                                       attribute:NSLayoutAttributeCenterY
                                                      multiplier:1
                                                        constant:0];
    }
  }
  [NSLayoutConstraint activateConstraints:@[
    self.characterCountY, self.characterCountTrailing,
    self.clearButtonTrailingCharacterCountLeading, self.clearButtonY, self.placeholderLeading,
    self.placeholderTrailingCharacterCountLeading, self.placeholderTrailingSuperviewTrailing
  ]];

  [self.textInput.trailingUnderlineLabel setContentHuggingPriority:UILayoutPriorityRequired
                                                           forAxis:UILayoutConstraintAxisVertical];
}

#pragma mark - MDCTextFieldPositioningDelegate

// clang-format off
/**
 textInsets: is the source of truth for vertical layout. It's used to figure out the proper
 height and also where to place the placeholder / text field.

 NOTE: It's applied before the textRect is flipped for RTL. So all calculations are done here à la
 LTR.

 The vertical layout is, simply:
 MDCTextInputControllerFullWidthVerticalPadding                       // Top padding
 MDCRint(MAX(self.textInput.font.lineHeight,                          // Text field or placeholder
             self.textInput.placeholderLabel.font.lineHeight))
 MDCTextInputControllerFullWidthVerticalPadding                       // Bottom padding
 */
// clang-format on
- (UIEdgeInsets)textInsets:(__unused UIEdgeInsets)defaultInsets {
  // NOTE: UITextFields have a centerY based layout. But you can change EITHER the height or the Y.
  // Not both. Don't know why. So, we have to leave the text rect as big as the bounds and move it
  // to a Y that works. In other words, no bottom inset will make a difference here for UITextFields
  UIEdgeInsets textInsets = UIEdgeInsetsZero;

  textInsets.top = MDCTextInputControllerFullWidthVerticalPadding;
  textInsets.bottom = MDCTextInputControllerFullWidthVerticalPadding;
  textInsets.left = MDCTextInputControllerFullWidthHorizontalPadding;
  textInsets.right = MDCTextInputControllerFullWidthHorizontalPadding;

  // The trailing label gets in the way. If it has a frame, it's used. But if not, an
  // estimate is made of the size the text will be.
  if (CGRectGetWidth(self.textInput.trailingUnderlineLabel.frame) > 1) {
    textInsets.right += MDCCeil(CGRectGetWidth(self.textInput.trailingUnderlineLabel.frame));
  } else if (self.characterCountMax) {
    CGRect charCountRect = [[self characterCountText]
        boundingRectWithSize:self.textInput.bounds.size
                     options:NSStringDrawingUsesLineFragmentOrigin
                  attributes:@{
                    NSFontAttributeName : self.textInput.trailingUnderlineLabel.font
                  }
                     context:nil];
    textInsets.right += MDCCeil(CGRectGetWidth(charCountRect));
  }

  return textInsets;
}

- (CGRect)editingRectForBounds:(__unused CGRect)bounds defaultRect:(CGRect)defaultRect {
  if (![self.textInput isKindOfClass:[UITextField class]]) {
    return CGRectZero;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;
  CGRect editingRect = defaultRect;

  // Full width text fields have their clear button in the horizontal margin, but because the
  // internal implementation of textRect calls [super clearButtonRectForBounds:] in its
  // implementation, our modifications are not picked up. Adjust accordingly.
  // Full width text fields also have their character count on the text input line.
  if (self.textInput.text.length > 0) {
    switch (textField.clearButtonMode) {
      case UITextFieldViewModeWhileEditing:
        editingRect.size.width -= CGRectGetWidth(self.textInput.clearButton.bounds);
      case UITextFieldViewModeUnlessEditing:
        // The 'defaultRect' is based on the textInsets so we need to compensate for
        // the button NOT being there.
        editingRect.size.width += CGRectGetWidth(self.textInput.clearButton.bounds);
        editingRect.size.width -= MDCTextInputControllerFullWidthHorizontalInnerPadding;
        break;
      default:
        break;
    }
  }

  return editingRect;
}

#pragma mark - UITextField & UITextView Notification Observation

- (void)textInputDidBeginEditing:(__unused NSNotification *)note {
  [self updateLayout];

  if (self.characterCountMax > 0) {
    NSString *announcementString;
    if (!announcementString.length) {
      announcementString = [NSString
          stringWithFormat:@"%lu character limit.", (unsigned long)self.characterCountMax];
    }

    // Simply sending a layout change notification does not seem to
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);
  }
}

- (void)textInputDidChange:(__unused NSNotification *)note {
  [self updateLayout];

  // Accessibility
  if (self.textInput.isEditing && self.characterCountMax > 0) {
    NSString *announcementString;
    if (!announcementString.length) {
      announcementString = [NSString
          stringWithFormat:@"%lu characters remaining",
                           (unsigned long)(self.characterCountMax -
                                           [self.characterCounter
                                               characterCountForTextInput:self.textInput])];
    }

    // Simply sending a layout change notification does not seem to
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);
  }
}

- (void)textInputDidEndEditing:(__unused NSNotification *)note {
  [self updateLayout];
}

#pragma mark - Public API

- (void)setErrorText:(NSString *)errorText
    errorAccessibilityValue:(NSString *)errorAccessibilityValue {
  // Turn on error:
  //
  // Here the 'magic' logic happens for error text.
  // When the user sets error text, we save the current state of their underline, leading text,
  // trailing text, and placeholder text for both content and color.
  if (errorText && !self.isDisplayingErrorText) {
    // If we are not in error, but will be, we need to save the existing state.
    self.previousLeadingText = self.textInput.leadingUnderlineLabel.text
                                   ? self.textInput.leadingUnderlineLabel.text.copy
                                   : @"";

    self.textInput.leadingUnderlineLabel.text = errorText;

    [self updatePlaceholder];
  }

  // Change error:
  if (errorText && self.isDisplayingErrorText) {
    self.textInput.leadingUnderlineLabel.text = errorText;
  }

  // Turn off error:
  //
  // If error text is unset (nil) we reset to previous values.
  if (!errorText) {
    // If there is a saved state, use it.
    if (self.previousLeadingText) {
      self.textInput.leadingUnderlineLabel.text = self.previousLeadingText;
    }

    // Clear out saved state.
    self.previousLeadingText = nil;
  }

  self.errorText = errorText;
  self.errorAccessibilityValue = errorAccessibilityValue;

  [self updateLayout];

  // Accessibility
  // TODO: (larche) Localize
  if (errorText) {
    NSString *announcementString = errorAccessibilityValue;
    if (!announcementString.length) {
      announcementString =
          errorText.length > 0 ? [NSString stringWithFormat:@"Error: %@", errorText] : @"Error.";
    }

    // Simply sending a layout change notification does not seem to
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);

    NSString *valueString = @"";

    if (self.textInput.text.length > 0) {
      valueString = [self.textInput.text copy];
    }
    if (self.textInput.placeholder.length > 0) {
      valueString = [NSString stringWithFormat:@"%@. %@", valueString, self.textInput.placeholder];
    }
    valueString = [valueString stringByAppendingString:@"."];

    self.textInput.accessibilityValue = valueString;
    NSString *leadingUnderlineLabelText = self.textInput.leadingUnderlineLabel.text;
    self.textInput.leadingUnderlineLabel.accessibilityLabel =
        [NSString stringWithFormat:@"Error: %@.",
                                   leadingUnderlineLabelText ? leadingUnderlineLabelText : @""];
  } else {
    self.textInput.accessibilityValue = nil;
    if ([self.textInput.leadingUnderlineLabel.text isEqualToString:self.helperText]) {
      self.textInput.leadingUnderlineLabel.accessibilityLabel = self.helperAccessibilityLabel;
    } else {
      self.textInput.leadingUnderlineLabel.accessibilityLabel = nil;
    }
  }
}

- (void)setHelperText:(NSString *)helperText
    helperAccessibilityLabel:(NSString *)helperAccessibilityLabel {
  self.helperText = helperText;
  self.helperAccessibilityLabel = helperAccessibilityLabel;
}

#pragma mark - Accessibility

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  [self updateLayout];

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

+ (BOOL)mdc_adjustsFontForContentSizeCategoryDefault {
  return _mdc_adjustsFontForContentSizeCategoryDefault;
}

+ (void)setMdc_adjustsFontForContentSizeCategoryDefault:
        (BOOL)mdc_adjustsFontForContentSizeCategoryDefault {
  _mdc_adjustsFontForContentSizeCategoryDefault = mdc_adjustsFontForContentSizeCategoryDefault;
}

- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateLayout];
}

@end
