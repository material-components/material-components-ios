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

#import "MDCTextInputController.h"

#import "MDCTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputCharacterCounter.h"

#import "MaterialAnimationTiming.h"
#import "MaterialPalettes.h"
#import "MaterialRTL.h"
#import "MaterialTypography.h"

#pragma mark - Constants

static const CGFloat MDCTextInputAlmostRequiredPriority = 999;
static const CGFloat MDCTextInputFloatingPlaceholderDefaultScale = 0.75f;
static const CGFloat MDCTextInputFullWidthHorizontalInnerPadding = 8.f;
static const CGFloat MDCTextInputFullWidthHorizontalPadding = 16.f;
static const CGFloat MDCTextInputFullWidthVerticalPadding = 20.f;
static const CGFloat MDCTextInputHintTextOpacity = 0.54f;
static const CGFloat MDCTextInputUnderlineActiveHeight = 2.f;
static const CGFloat MDCTextInputUnderlineNormalHeight = 1.f;
static const CGFloat MDCTextInputVerticalHalfPadding = 8.f;
static const CGFloat MDCTextInputVerticalPadding = 16.f;

static const NSTimeInterval MDCTextInputFloatingPlaceholderDownAnimationDuration = 0.266666f;
static const NSTimeInterval MDCTextInputFloatingPlaceholderUpAnimationDuration = 0.3f;

static NSString *const MDCTextInputControllerCharacterCounterKey =
    @"MDCTextInputControllerCharacterCounterKey";
static NSString *const MDCTextInputControllerCharacterCountViewModeKey =
    @"MDCTextInputControllerCharacterCountViewModeKey";
static NSString *const MDCTextInputControllerCharacterCountMaxKey =
    @"MDCTextInputControllerCharacterCountMaxKey";
static NSString *const MDCTextInputControllerErrorAccessibilityValueKey =
    @"MDCTextInputControllerErrorAccessibilityValueKey";
static NSString *const MDCTextInputControllerErrorColorKey = @"MDCTextInputControllerErrorColorKey";
static NSString *const MDCTextInputControllerErrorTextKey = @"MDCTextInputControllerErrorTextKey";
static NSString *const MDCTextInputControllerFloatingPlaceholderColorKey =
    @"MDCTextInputControllerFloatingPlaceholderColorKey";
static NSString *const MDCTextInputControllerFloatingPlaceholderScaleKey =
    @"MDCTextInputControllerFloatingPlaceholderScaleKey";
static NSString *const MDCTextInputControllerHelperTextKey = @"MDCTextInputControllerHelperTextKey";
static NSString *const MDCTextInputControllerInlinePlaceholderColorKey =
    @"MDCTextInputControllerInlinePlaceholderColorKey";
static NSString *const MDCTextInputControllerPresentationStyleKey =
    @"MDCTextInputControllerPresentationStyleKey";
static NSString *const MDCTextInputControllerTextInputKey = @"MDCTextInputControllerTextInputKey";
static NSString *const MDCTextInputControllerUnderlineViewModeKey =
    @"MDCTextInputControllerUnderlineViewModeKey";

static NSString *const MDCTextInputControllerKVOKeyFont = @"font";

static inline CGFloat MDCCeil(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return ceil(value);
#else
  return ceilf(value);
#endif
}

static inline CGFloat MDCRound(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return rint(value);
#else
  return rintf(value);
#endif
}

static inline UIColor *MDCTextInputInlinePlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputHintTextOpacity];
}

static inline UIColor *MDCTextInputActiveUnderlineColor() {
  return [MDCPalette indigoPalette].tint500;
}

static inline UIColor *MDCTextInputNormalUnderlineColor() {
  return [UIColor lightGrayColor];
}

static inline UIColor *MDCTextInputTextErrorColor() {
  return [MDCPalette redPalette].tint500;
}

@interface MDCTextInputController () {
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

@property(nonatomic, strong) NSLayoutConstraint *characterCountY;
@property(nonatomic, strong) NSLayoutConstraint *characterCountTrailing;
@property(nonatomic, strong) UIFont *customLeadingFont;
@property(nonatomic, strong) UIFont *customPlaceholderFont;
@property(nonatomic, strong) UIFont *customTrailingFont;
@property(nonatomic, copy) NSString *errorText;
@property(nonatomic, copy) NSString *errorAccessibilityValue;
@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;
@property(nonatomic, readonly) BOOL isDisplayingErrorText;
@property(nonatomic, readonly) BOOL isPlaceholderUp;
@property(nonatomic, strong) NSArray<NSLayoutConstraint *> *placeholderAnimationConstraints;
@property(nonatomic, assign) CGRect placeholderDefaultPositionFrame;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingCharacterCountLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingSuperviewTrailing;
@property(nonatomic, copy) NSString *previousLeadingText;
@property(nonatomic, copy) UIColor *previousPlaceholderColor;

@end

@implementation MDCTextInputController

@synthesize characterCounter = _characterCounter;
@synthesize characterCountMax = _characterCountMax;
@synthesize presentationStyle = _presentationStyle;

// TODO: (larche): Support in-line auto complete.

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonInitialization];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonInitialization];

    _errorColor = [aDecoder decodeObjectForKey:MDCTextInputControllerErrorColorKey];
    _characterCounter = [aDecoder decodeObjectForKey:MDCTextInputControllerCharacterCounterKey];
    _characterCountMax = [aDecoder decodeIntegerForKey:MDCTextInputControllerCharacterCountMaxKey];
    _characterCountViewMode =
        [aDecoder decodeIntegerForKey:MDCTextInputControllerCharacterCountViewModeKey];
    _floatingPlaceholderColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerFloatingPlaceholderColorKey];
    _floatingPlaceholderScale =
        [aDecoder decodeObjectForKey:MDCTextInputControllerFloatingPlaceholderScaleKey];
    _inlinePlaceholderColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerInlinePlaceholderColorKey];
    _presentationStyle = (MDCTextInputPresentationStyle)
        [aDecoder decodeIntegerForKey:MDCTextInputControllerPresentationStyleKey];
    _textInput = [aDecoder decodeObjectForKey:MDCTextInputControllerTextInputKey];
    _underlineViewMode = (UITextFieldViewMode)
        [aDecoder decodeIntegerForKey:MDCTextInputControllerUnderlineViewModeKey];
  }
  return self;
}

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)textInput {
  self = [self init];
  if (self) {
    _textInput = textInput;

    [self commonInitializationWithInput];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.characterCounter forKey:MDCTextInputControllerCharacterCounterKey];
  [aCoder encodeInteger:self.characterCountMax forKey:MDCTextInputControllerCharacterCountMaxKey];
  [aCoder encodeInteger:self.characterCountViewMode
                 forKey:MDCTextInputControllerCharacterCountViewModeKey];
  [aCoder encodeObject:self.errorAccessibilityValue
                forKey:MDCTextInputControllerErrorAccessibilityValueKey];
  [aCoder encodeObject:self.errorColor forKey:MDCTextInputControllerErrorColorKey];
  [aCoder encodeObject:self.errorText forKey:MDCTextInputControllerErrorTextKey];
  [aCoder encodeObject:self.floatingPlaceholderColor
                forKey:MDCTextInputControllerFloatingPlaceholderColorKey];
  [aCoder encodeObject:self.floatingPlaceholderScale
                forKey:MDCTextInputControllerFloatingPlaceholderScaleKey];
  [aCoder encodeObject:self.helperText forKey:MDCTextInputControllerHelperTextKey];
  [aCoder encodeObject:self.inlinePlaceholderColor
                forKey:MDCTextInputControllerInlinePlaceholderColorKey];
  [aCoder encodeInteger:self.presentationStyle forKey:MDCTextInputControllerPresentationStyleKey];
  [aCoder encodeConditionalObject:self.textInput forKey:MDCTextInputControllerTextInputKey];
  [aCoder encodeInteger:self.underlineViewMode forKey:MDCTextInputControllerUnderlineViewModeKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextInputController *copy = [[[self class] alloc] init];

  copy.characterCounter = self.characterCounter;  // Just a pointer value copy
  copy.characterCountViewMode = self.characterCountViewMode;
  copy.characterCountMax = self.characterCountMax;
  copy.errorAccessibilityValue = self.errorAccessibilityValue.copy;
  copy.errorColor = self.errorColor.copy;
  copy.errorText = self.errorText.copy;
  copy.floatingPlaceholderColor = self.floatingPlaceholderColor.copy;
  copy.floatingPlaceholderScale = self.floatingPlaceholderScale;
  copy.helperText = self.helperText.copy;
  copy.inlinePlaceholderColor = self.inlinePlaceholderColor.copy;
  copy.presentationStyle = self.presentationStyle;
  copy.previousLeadingText = self.previousLeadingText.copy;
  copy.previousPlaceholderColor = self.previousPlaceholderColor.copy;
  copy.textInput = self.textInput;  // Just a pointer value copy
  copy.underlineViewMode = self.underlineViewMode;

  return copy;
}

- (void)dealloc {
  [self unsubscribeFromNotifications];
  [self unsubscribeFromKVO];
}

- (void)commonInitialization {
  _characterCountViewMode = UITextFieldViewModeAlways;
  _errorColor = MDCTextInputTextErrorColor();
  _internalCharacterCounter = [MDCTextInputAllCharactersCounter new];
  _underlineViewMode = UITextFieldViewModeWhileEditing;
}

- (void)commonInitializationWithInput {
  if (!_textInput) {
    return;
  }

  // This controller will handle Dynamic Type and all fonts for the text input
  _mdc_adjustsFontForContentSizeCategory = _textInput.mdc_adjustsFontForContentSizeCategory;
  _textInput.mdc_adjustsFontForContentSizeCategory = NO;
  _textInput.positioningDelegate = self;
  _placeholderDefaultPositionFrame = _textInput.frame;

  [self subscribeForNotifications];
  [self subscribeForKVO];
  _textInput.underlineColor = MDCTextInputNormalUnderlineColor();
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
  }

  if ([_textInput isKindOfClass:[UITextView class]]) {
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidBeginEditing:)
                          name:UITextViewTextDidBeginEditingNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidChange:)
                          name:UITextViewTextDidChangeNotification
                        object:_textInput];
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidEndEditing:)
                          name:UITextViewTextDidEndEditingNotification
                        object:_textInput];
  }
}

- (void)unsubscribeFromNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

  [defaultCenter removeObserver:self];
}

- (void)subscribeForKVO {
  if (!_textInput) {
    return;
  }
  [_textInput.leadingUnderlineLabel addObserver:self
                                     forKeyPath:MDCTextInputControllerKVOKeyFont
                                        options:0
                                        context:nil];
  [_textInput.placeholderLabel addObserver:self
                                forKeyPath:MDCTextInputControllerKVOKeyFont
                                   options:0
                                   context:nil];
  [_textInput.trailingUnderlineLabel addObserver:self
                                      forKeyPath:MDCTextInputControllerKVOKeyFont
                                         options:0
                                         context:nil];
}

- (void)unsubscribeFromKVO {
  @try {
    [_textInput.leadingUnderlineLabel removeObserver:self
                                          forKeyPath:MDCTextInputControllerKVOKeyFont];
    [_textInput.placeholderLabel removeObserver:self forKeyPath:MDCTextInputControllerKVOKeyFont];
    [_textInput.trailingUnderlineLabel removeObserver:self
                                           forKeyPath:MDCTextInputControllerKVOKeyFont];
  } @catch (NSException *exception) {
  }
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

#pragma mark - Leading Label Customization

- (void)updateLeadingUnderlineLabel {
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
    self.textInput.leadingUnderlineLabel.text = nil;
    return;
  }

  if (!self.customLeadingFont) {
    self.textInput.leadingUnderlineLabel.font =
        [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleCaption];
  }

  self.textInput.leadingUnderlineLabel.textColor =
      self.isDisplayingErrorText ? self.errorColor : MDCTextInputInlinePlaceholderTextColor();
}

#pragma mark - Placeholder Customization

- (void)updatePlaceholder {
  if (!self.customPlaceholderFont) {
    self.textInput.placeholderLabel.font =
        [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
  }
}

- (BOOL)isPlaceholderUp {
  return self.placeholderAnimationConstraints.count > 0;
}

#pragma mark - Placeholder Animation

- (void)animatePlaceholderToUp:(BOOL)isToUp {
  if (self.presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder ||
      self.textInput.text.length > 0) {
    return;
  }

  if (self.isPlaceholderUp && isToUp) {
    return;
  }

  if (!self.isPlaceholderUp && !isToUp) {
    return;
  }

  self.placeholderDefaultPositionFrame = self.textInput.placeholderLabel.frame;

  CGFloat scaleFactor = [self effectiveFloatingScale];
  CGAffineTransform floatingPlaceholderScaleTransform =
      CGAffineTransformMakeScale(scaleFactor, scaleFactor);

  CGPoint destinationPosition;
  void (^animationBlock)(void);

  if (isToUp) {
    destinationPosition = [self placeholderFloatingPositionFrame].origin;

    // Due to transform working on normal (0.5,0.5) anchor point.
    // Why no anchor point of (0,0)? Because our users wouldn't expect it.
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.textInput
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:destinationPosition.y];
    CGFloat xOffset =
        (scaleFactor - 1.0f) * CGRectGetWidth(self.textInput.placeholderLabel.frame) / 2.0f;
    NSLayoutConstraint *leading =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:xOffset];
    self.placeholderAnimationConstraints = @[ top, leading ];

    self.previousPlaceholderColor = self.textInput.placeholderLabel.textColor;

    animationBlock = ^{
      self.textInput.placeholderLabel.transform = floatingPlaceholderScaleTransform;

      self.textInput.placeholderLabel.textColor = self.textInput.tintColor;
      [NSLayoutConstraint activateConstraints:self.placeholderAnimationConstraints];
    };
  } else {
    animationBlock = ^{
      self.textInput.placeholderLabel.transform = CGAffineTransformIdentity;

      self.textInput.placeholderLabel.textColor =
          self.previousPlaceholderColor ?: self.textInput.placeholderLabel.textColor;
      [NSLayoutConstraint deactivateConstraints:self.placeholderAnimationConstraints];
    };
  }

  // We do this beforehand to flush the layout engine.
  [self.textInput layoutIfNeeded];
  [UIView animateWithDuration:[CATransaction animationDuration]
      animations:^{
        animationBlock();
        [self.textInput layoutIfNeeded];
      }
      completion:^(BOOL finished) {
        if (!isToUp) {
          self.placeholderAnimationConstraints = nil;
        }
      }];
}

- (CGRect)placeholderFloatingPositionFrame {
  CGRect placeholderRect = self.placeholderDefaultPositionFrame;
  if (CGRectIsEmpty(placeholderRect)) {
    return placeholderRect;
  }

  placeholderRect.origin.y -=
      MDCTextInputVerticalHalfPadding + MDCRound(self.textInput.placeholderLabel.font.lineHeight);

  return placeholderRect;
}

- (NSLayoutConstraint *)placeholderYconstraint {
  for (NSLayoutConstraint *constraint in self.textInput.constraints) {
    if (constraint.firstItem == self.textInput.placeholderLabel &&
        (constraint.firstAttribute == NSLayoutAttributeTop ||
         constraint.firstAttribute == NSLayoutAttributeCenterY)) {
      return constraint;
    }
  }
  return nil;
}

- (CGFloat)effectiveFloatingScale {
  CGFloat scaleFactor = self.floatingPlaceholderScale
                            ? (CGFloat)self.floatingPlaceholderScale.floatValue
                            : MDCTextInputFloatingPlaceholderDefaultScale;

  return scaleFactor;
}

#pragma mark - Trailing Label Customization

- (void)updateTrailingUnderlineLabel {
  if (!self.characterCountMax) {
    self.textInput.trailingUnderlineLabel.text = nil;
    return;
  }

  if (!self.customTrailingFont) {
    self.textInput.trailingUnderlineLabel.font =
        [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleCaption];
  }

  self.textInput.trailingUnderlineLabel.text = [self characterCountText];

  BOOL pastMax = [self characterCount] > self.characterCountMax;
  UIColor *textColor = MDCTextInputInlinePlaceholderTextColor();

  if ((pastMax && self.textInput.isEditing) || self.isDisplayingErrorText) {
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
}

- (NSString *)characterCountText {
  return [NSString stringWithFormat:@"%lu / %lu", (unsigned long)[self characterCount],
                             (unsigned long)self.characterCountMax];
}

#pragma mark - Underline Customization

- (void)updateUnderline {
  if (_presentationStyle == MDCTextInputPresentationStyleFullWidth) {
    // Hide the underline.
    self.textInput.underlineColor = [UIColor clearColor];
  } else {
    UIColor *underlineColor;
    UIColor *activeColor = MDCTextInputActiveUnderlineColor();
    UIColor *normalColor = MDCTextInputNormalUnderlineColor();

    CGFloat underlineHeight;

    switch (self.underlineViewMode) {
      case UITextFieldViewModeAlways:
        underlineColor = activeColor;
        underlineHeight = MDCTextInputUnderlineActiveHeight;
        break;
      case UITextFieldViewModeWhileEditing:
        underlineColor = self.textInput.isEditing ? activeColor : normalColor;
        underlineHeight = self.textInput.isEditing ? MDCTextInputUnderlineActiveHeight
                                                   : MDCTextInputUnderlineNormalHeight;
        break;
      case UITextFieldViewModeUnlessEditing:
        underlineColor = !self.textInput.isEditing ? activeColor : normalColor;
        underlineHeight = !self.textInput.isEditing ? MDCTextInputUnderlineActiveHeight
                                                    : MDCTextInputUnderlineNormalHeight;
        break;
      case UITextFieldViewModeNever:
      default:
        underlineColor = normalColor;
        underlineHeight = MDCTextInputUnderlineNormalHeight;
        break;
    }

    self.textInput.underlineColor = self.isDisplayingErrorText ? self.errorColor : underlineColor;
    self.textInput.underlineHeight = underlineHeight;
  }
}

#pragma mark - Properties Implementation

- (void)setCharacterCountViewMode:(UITextFieldViewMode)characterCountViewMode {
  if (_characterCountViewMode != characterCountViewMode) {
    _characterCountViewMode = characterCountViewMode;

    [self updateLayout];
  }
}

- (void)setErrorAccessibilityValue:(NSString *)errorAccessibilityValue {
  _errorAccessibilityValue = errorAccessibilityValue.copy;
}

- (void)setErrorText:(NSString *)errorText {
  _errorText = errorText.copy;
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

- (BOOL)isDisplayingErrorText {
  return self.errorText != nil;
}

- (void)setPresentationStyle:(MDCTextInputPresentationStyle)presentationStyle {
  if (_presentationStyle != presentationStyle) {
    _presentationStyle = presentationStyle;

    [self updateLayout];

    self.textInput.hidesPlaceholderOnInput =
        _presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder;
    [self.textInput setNeedsLayout];
  }
}

- (void)setPreviousLeadingText:(NSString *)previousLeadingText {
  _previousLeadingText = previousLeadingText.copy;
}

- (void)setPreviousPlaceholderColor:(UIColor *)previousPlaceholderColor {
  _previousPlaceholderColor = previousPlaceholderColor.copy;
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  if (_textInput != textInput) {
    [self unsubscribeFromNotifications];
    [self unsubscribeFromKVO];

    _textInput = textInput;
    [self commonInitializationWithInput];
  }
}

- (void)setUnderlineViewMode:(UITextFieldViewMode)underlineViewMode {
  if (_underlineViewMode != underlineViewMode) {
    _underlineViewMode = underlineViewMode;

    [self updateLayout];
  }
}

#pragma mark - Layout

- (void)updateLayout {
  if (!_textInput) {
    return;
  }

  [self updatePlaceholder];
  [self updateLeadingUnderlineLabel];
  [self updateTrailingUnderlineLabel];
  [self updateUnderline];
  [self updateConstraints];
}

- (void)updateConstraints {
  if (!self.heightConstraint) {
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self.textInput
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1
                                                          constant:0];
  }

  if (_presentationStyle == MDCTextInputPresentationStyleFullWidth) {
    if (!self.characterCountTrailing) {
      self.characterCountTrailing =
          [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                       attribute:NSLayoutAttributeTrailing
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:-1 * MDCTextInputFullWidthHorizontalPadding];
    }
    if (!self.placeholderLeading) {
      self.placeholderLeading =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:MDCTextInputFullWidthHorizontalPadding];
    }
    if (!self.placeholderTrailingCharacterCountLeading) {
      self.placeholderTrailingCharacterCountLeading =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeTrailing
                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                          toItem:self.textInput.trailingUnderlineLabel
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:-1 * MDCTextInputFullWidthHorizontalInnerPadding];
    }
    if (!self.placeholderTrailingSuperviewTrailing) {
      self.placeholderTrailingSuperviewTrailing =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeTrailing
                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:-1 * MDCTextInputFullWidthHorizontalPadding];
    }

    // Multi Line Only
    // .fullWidth
    if ([self.textInput isKindOfClass:[UITextView class]]) {
      [self.textInput.leadingUnderlineLabel
          setContentHuggingPriority:UILayoutPriorityRequired
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
                                            toItem:self.textInput
                                         attribute:NSLayoutAttributeBottom
                                        multiplier:1
                                          constant:0];
      }

    } else {
      // Single Line Only
      // .fullWidth
      self.heightConstraint.constant =
          2 * MDCTextInputFullWidthVerticalPadding + MDCRound(self.textInput.font.lineHeight);

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
    }
    [NSLayoutConstraint activateConstraints:@[
      self.characterCountY, self.characterCountTrailing, self.placeholderLeading,
      self.placeholderTrailingCharacterCountLeading, self.placeholderTrailingSuperviewTrailing
    ]];

    [self.textInput.trailingUnderlineLabel
        setContentHuggingPriority:UILayoutPriorityRequired
                          forAxis:UILayoutConstraintAxisVertical];
    [self placeholderYconstraint].priority = MDCTextInputAlmostRequiredPriority;
  } else {
    // .floatingPlaceholder and .default
    [self placeholderYconstraint].priority = UILayoutPriorityDefaultLow;

    // These constraints are deactivated via .active in case they are nil.
    self.characterCountY.active = NO;
    self.characterCountTrailing.active = NO;
    self.placeholderLeading.active = NO;
    self.placeholderTrailingCharacterCountLeading.active = NO;
    self.placeholderTrailingSuperviewTrailing.active = NO;

    UIEdgeInsets insets = [self textContainerInset:UIEdgeInsetsZero];

    if (_presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder) {
      self.heightConstraint.constant =
          insets.top +  // Labels and padding
          MDCRound(MAX(self.textInput.font.lineHeight,
                       self.textInput.placeholderLabel.font.lineHeight)) +  // Text field
          insets.bottom;                                                    // Padding or labels

    }  // else is .default which needs no heightConstraint.
  }

  // Default just uses the built in intrinsic content size but floating placeholder needs more
  // height and full width needs less. (Constants set above.)
  self.heightConstraint.active = _presentationStyle != MDCTextInputPresentationStyleDefault;
}

- (void)updateFontsForDynamicType {
  if (self.mdc_adjustsFontForContentSizeCategory) {
    UIFont *textFont = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
    self.textInput.font = textFont;

    [self updateLayout];
  }
}

#pragma mark - MDCTextFieldPositioningDelegate

// clang-format off
/**
 textContainerInset: is the source of truth for vertical layout. It's used to figure out the proper
 height and also where to place the placeholder / text field.

 The vertical layout is, at most complex, this form:
 MDCTextInputVerticalPadding +                                        // Top padding
 MDCRound(self.textInput.placeholderLabel.font.lineHeight * scale) +  // Placeholder when up
 MDCTextInputVerticalHalfPadding +                                    // Small padding
 MDCRound(MAX(self.textInput.font.lineHeight,                         // Text field or placeholder
              self.textInput.placeholderLabel.font.lineHeight)) +
 MDCTextInputVerticalHalfPadding +                                    // Small padding
 --Underline-- (height not counted)                                   // Underline (height ignored)
 MAX(underlineLabelsOffset,MDCTextInputVerticalPadding)               // Padding and/or labels
 */
// clang-format on
- (UIEdgeInsets)textContainerInset:(UIEdgeInsets)defaultInsets {
  // NOTE: UITextFields have a centerY based layout. But you can change EITHER the height or the Y.
  // Not both. Don't know why. So, we have to leave the text rect as big as the bounds and move it
  // to a Y that works. In other words, no bottom inset will make a difference here for UITextFields
  UIEdgeInsets textContainerInset = defaultInsets;

  switch (self.presentationStyle) {
    case MDCTextInputPresentationStyleDefault:
      break;
    case MDCTextInputPresentationStyleFloatingPlaceholder: {
      CGFloat scale = [self effectiveFloatingScale];
      // The amount of space underneath the underline is variable. It could just be
      // MDCTextInputVerticalPadding or the biggest estimated underlineLabel height +
      // MDCTextInputVerticalHalfPadding
      CGFloat underlineLabelsOffset = 0;
      if (self.textInput.leadingUnderlineLabel.text.length) {
        underlineLabelsOffset = MDCRound(self.textInput.leadingUnderlineLabel.font.lineHeight);
      }
      if (self.textInput.trailingUnderlineLabel.text.length || self.characterCountMax) {
        underlineLabelsOffset = MAX(
            underlineLabelsOffset, MDCRound(self.textInput.trailingUnderlineLabel.font.lineHeight));
      }
      CGFloat underlineOffset = MAX(underlineLabelsOffset, MDCTextInputVerticalHalfPadding);
      underlineOffset += MDCTextInputVerticalHalfPadding;

      textContainerInset.top = MDCTextInputVerticalPadding +
                               MDCRound(self.textInput.placeholderLabel.font.lineHeight * scale) +
                               MDCTextInputVerticalHalfPadding;

      // .bottom = underlineOffset + the half padding above the line but below the text field
      textContainerInset.bottom = underlineOffset + MDCTextInputVerticalHalfPadding;

    } break;
    case MDCTextInputPresentationStyleFullWidth:
      textContainerInset.top = MDCTextInputFullWidthVerticalPadding;
      textContainerInset.bottom = MDCTextInputFullWidthVerticalPadding;
      textContainerInset.left = MDCTextInputFullWidthHorizontalPadding;
      textContainerInset.right = MDCTextInputFullWidthHorizontalPadding;

        // The trailing label gets in the way. If it has a frame, it's used. But if not, an
        // estimate is made of the size the text will be.
        if (CGRectGetWidth(self.textInput.trailingUnderlineLabel.frame) > 1.f) {
          textContainerInset.right += MDCCeil(CGRectGetWidth(self.textInput.trailingUnderlineLabel.frame));
        } else if (self.characterCountMax) {
          CGRect charCountRect = [[self characterCountText] boundingRectWithSize:self.textInput.bounds.size
                                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                                      attributes:@{NSFontAttributeName: self.textInput.trailingUnderlineLabel.font}
                                                                         context:nil];
          textContainerInset.right += MDCCeil(CGRectGetWidth(charCountRect));
        }
      // Space does not need to be made for the clear button because the default text rect already
      // made space for it. However space needs to be made to allow the clear button to have some
      // padding from the character count (trailing label) or the text from the character count.
      textContainerInset.right += MDCTextInputFullWidthHorizontalInnerPadding;

      break;
  }

  return textContainerInset;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  if (![self.textInput isKindOfClass:[UITextField class]]) {
    return CGRectZero;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;
  CGRect clearButtonRect = defaultRect;

  // Full width text boxes have their character count on the text input line
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth && self.characterCountMax) {
    if (self.textInput.mdc_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      clearButtonRect.origin.x += CGRectGetWidth(textField.trailingUnderlineLabel.frame);
    } else {
      clearButtonRect.origin.x = CGRectGetMinX(textField.trailingUnderlineLabel.frame);
      clearButtonRect.origin.x -= MDCTextInputFullWidthHorizontalInnerPadding;
      clearButtonRect.origin.x -= CGRectGetWidth(clearButtonRect);
      clearButtonRect.origin.x = [[self class] xOriginRoundedUpTo4:CGRectGetMinX(clearButtonRect)];
    }
  }

  return clearButtonRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  if (![self.textInput isKindOfClass:[UITextField class]]) {
    return CGRectZero;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;
  CGRect editingRect = defaultRect;

  // Full width text fields have their clear button in the horizontal margin, but because the
  // internal implementation of textRect calls [super clearButtonRectForBounds:] in its
  // implementation, our modifications are not picked up. Adjust accordingly.
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
//    editingRect.size.width += MDCTextInputFullWidthHorizontalPadding;
//    // Full width text boxes have their character count on the text input line
//    if (self.characterCountMax) {
//      editingRect.size.width -= CGRectGetWidth(textField.trailingUnderlineLabel.frame);
//      if (self.textInput.mdc_effectiveUserInterfaceLayoutDirection ==
//          UIUserInterfaceLayoutDirectionRightToLeft) {
//        editingRect.origin.x += CGRectGetWidth(textField.trailingUnderlineLabel.frame);
//      } else {
//      }
//    }
            switch (textField.clearButtonMode) {
              case UITextFieldViewModeWhileEditing:
                editingRect.size.width -= MDCClearButtonImageSquareSize;
              case UITextFieldViewModeUnlessEditing:
                // The 'defaultRect' is based on the textContainerInsets so we need to compensate for
                // the button NOT being there.
                editingRect.size.width += MDCClearButtonImageSquareSize;
                editingRect.size.width -= MDCTextInputFullWidthHorizontalInnerPadding;
                break;
              default:
                break;
            }
  }

  return editingRect;
}

// TODO: (larche) Make it keep track of the largest one and only increase size if it hits larger one
+ (CGFloat)xOriginRoundedUpTo4:(CGFloat)inputX {
  NSInteger x = (NSInteger)MDCCeil(inputX);
  if (x % 4 != 0) {
    x = ((NSInteger)(inputX / 4) + 1) * 4;
  }
  return (CGFloat)x;
}

#pragma mark - UITextField & UITextView Notification Observation

- (void)textInputDidBeginEditing:(NSNotification *)note {
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputFloatingPlaceholderUpAnimationDuration];
  [CATransaction
      setAnimationTimingFunction:[CAMediaTimingFunction
                                     mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];

  [self updateLayout];

  if (self.presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder) {
    [self animatePlaceholderToUp:YES];
  }
  [CATransaction commit];
}

- (void)textInputDidChange:(NSNotification *)note {
  [self updateLayout];
}

- (void)textInputDidEndEditing:(NSNotification *)note {
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputFloatingPlaceholderDownAnimationDuration];
  [CATransaction
      setAnimationTimingFunction:[CAMediaTimingFunction
                                     mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];

  [self updateLayout];

  if (self.presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder) {
    [self animatePlaceholderToUp:NO];
  }
  [CATransaction commit];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  if (![keyPath isEqualToString:MDCTextInputControllerKVOKeyFont]) {
    return;
  }

  if (object == _textInput.leadingUnderlineLabel) {
    _customLeadingFont = _textInput.leadingUnderlineLabel.font;
  }
  if (object == _textInput.placeholderLabel) {
    _customPlaceholderFont = _textInput.placeholderLabel.font;
  }
  if (object == _textInput.trailingUnderlineLabel) {
    _customTrailingFont = _textInput.trailingUnderlineLabel.font;
  }
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
    self.textInput.leadingUnderlineLabel.text =
        self.previousLeadingText ?: self.textInput.leadingUnderlineLabel.text;

    // Clear out saved state.
    self.previousLeadingText = nil;
  }

  self.errorText = errorText;
  self.errorAccessibilityValue = errorAccessibilityValue;

  [self updateLayout];

  // Accessibility
  if (errorText) {
    NSString *announcementString = errorAccessibilityValue;
    if (!announcementString.length) {
      announcementString = errorText.length > 0 ? errorText : @"Error.";
    }

    // Simply sending a layout change notification does not seem to
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);
  }
}

#pragma mark - Accessibility

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (_mdc_adjustsFontForContentSizeCategory) {
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
