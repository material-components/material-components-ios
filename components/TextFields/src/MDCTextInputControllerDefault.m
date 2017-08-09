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

#import "MDCTextInputControllerDefault.h"

#import "MDCMultilineTextField.h"
#import "MDCTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputUnderlineView.h"

#import "MaterialAnimationTiming.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialRTL.h"
#import "MaterialTypography.h"

#pragma mark - Constants

static const CGFloat MDCTextInputDefaultFloatingPlaceholderScaleDefault = 0.75f;
static const CGFloat MDCTextInputDefaultHintTextOpacity = 0.54f;
static const CGFloat MDCTextInputDefaultUnderlineActiveHeight = 2.f;
static const CGFloat MDCTextInputDefaultUnderlineNormalHeight = 1.f;
static const CGFloat MDCTextInputDefaultVerticalHalfPadding = 8.f;
static const CGFloat MDCTextInputDefaultVerticalPadding = 16.f;

static const NSTimeInterval MDCTextInputDefaultFloatingPlaceholderDownAnimationDuration = 0.266666f;
static const NSTimeInterval MDCTextInputDefaultFloatingPlaceholderUpAnimationDuration = 0.3f;

static NSString *const MDCTextInputControllerDefaultCharacterCounterKey =
    @"MDCTextInputControllerDefaultCharacterCounterKey";
static NSString *const MDCTextInputControllerDefaultCharacterCountViewModeKey =
    @"MDCTextInputControllerDefaultCharacterCountViewModeKey";
static NSString *const MDCTextInputControllerDefaultCharacterCountMaxKey =
    @"MDCTextInputControllerDefaultCharacterCountMaxKey";
static NSString *const MDCTextInputControllerDefaultErrorAccessibilityValueKey =
    @"MDCTextInputControllerDefaultErrorAccessibilityValueKey";
static NSString *const MDCTextInputControllerDefaultErrorColorKey =
    @"MDCTextInputControllerDefaultErrorColorKey";
static NSString *const MDCTextInputControllerDefaultErrorTextKey =
    @"MDCTextInputControllerDefaultErrorTextKey";
static NSString *const MDCTextInputControllerDefaultFloatingEnabledKey =
    @"MDCTextInputControllerDefaultFloatingEnabledKey";
static NSString *const MDCTextInputControllerDefaultFloatingPlaceholderColorKey =
    @"MDCTextInputControllerDefaultFloatingPlaceholderColorKey";
static NSString *const MDCTextInputControllerDefaultFloatingPlaceholderScaleKey =
    @"MDCTextInputControllerDefaultFloatingPlaceholderScaleKey";
static NSString *const MDCTextInputControllerDefaultHelperTextKey =
    @"MDCTextInputControllerDefaultHelperTextKey";
static NSString *const MDCTextInputControllerDefaultInlinePlaceholderColorKey =
    @"MDCTextInputControllerDefaultInlinePlaceholderColorKey";
static NSString *const MDCTextInputControllerDefaultPresentationStyleKey =
    @"MDCTextInputControllerDefaultPresentationStyleKey";
static NSString *const MDCTextInputControllerDefaultTextInputKey =
    @"MDCTextInputControllerDefaultTextInputKey";
static NSString *const MDCTextInputControllerDefaultUnderlineColorActiveKey =
    @"MDCTextInputControllerDefaultUnderlineColorActiveKey";
static NSString *const MDCTextInputControllerDefaultUnderlineColorNormalKey =
    @"MDCTextInputControllerDefaultUnderlineColorNormalKey";
static NSString *const MDCTextInputControllerDefaultUnderlineViewModeKey =
    @"MDCTextInputControllerDefaultUnderlineViewModeKey";

static NSString *const MDCTextInputControllerDefaultKVOKeyFont = @"font";

static inline UIColor *MDCTextInputDefaultInlinePlaceholderTextColorDefault() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputDefaultHintTextOpacity];
}

static inline UIColor *MDCTextInputDefaultActiveColorDefault() {
  return [MDCPalette bluePalette].accent700;
}

static inline UIColor *MDCTextInputDefaultNormalUnderlineColorDefault() {
  return [UIColor lightGrayColor];
}

static inline UIColor *MDCTextInputDefaultTextErrorColorDefault() {
  return [MDCPalette redPalette].accent400;
}

#pragma mark - Class Properties

static BOOL _floatingEnabledDefault = YES;
static BOOL _mdc_adjustsFontForContentSizeCategoryDefault = YES;

static CGFloat _floatingPlaceholderScaleDefault =
    MDCTextInputDefaultFloatingPlaceholderScaleDefault;

static UIColor *_errorColorDefault;
static UIColor *_floatingPlaceholderColorDefault;
static UIColor *_inlinePlaceholderColorDefault;
static UIColor *_underlineColorActiveDefault;
static UIColor *_underlineColorNormalDefault;

static UITextFieldViewMode _underlineViewModeDefault = UITextFieldViewModeWhileEditing;

@interface MDCTextInputControllerDefault () {
  BOOL _mdc_adjustsFontForContentSizeCategory;

  UIColor *_floatingPlaceholderColor;
  UIColor *_inlinePlaceholderColor;
  UIColor *_underlineColorActive;
  UIColor *_underlineColorNormal;
}

@property(nonatomic, assign, readonly) BOOL isDisplayingCharacterCountError;
@property(nonatomic, assign, readonly) BOOL isDisplayingErrorText;
@property(nonatomic, assign, readonly) BOOL isPlaceholderUp;
@property(nonatomic, assign) BOOL isRegisteredForKVO;

@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;

@property(nonatomic, strong) NSArray<NSLayoutConstraint *> *placeholderAnimationConstraints;

@property(nonatomic, strong) NSLayoutConstraint *characterCountY;
@property(nonatomic, strong) NSLayoutConstraint *characterCountTrailing;
@property(nonatomic, strong) NSLayoutConstraint *clearButtonY;
@property(nonatomic, strong) NSLayoutConstraint *clearButtonTrailingCharacterCountLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingCharacterCountLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingSuperviewTrailing;

@property(nonatomic, copy) NSString *errorAccessibilityValue;
@property(nonatomic, copy, readwrite) NSString *errorText;
@property(nonatomic, copy) NSString *previousLeadingText;

@property(nonatomic, strong) UIColor *previousPlaceholderColor;

@property(nonatomic, strong) UIFont *customLeadingFont;
@property(nonatomic, strong) UIFont *customPlaceholderFont;
@property(nonatomic, strong) UIFont *customTrailingFont;

@end

@implementation MDCTextInputControllerDefault

@synthesize characterCounter = _characterCounter;
@synthesize characterCountMax = _characterCountMax;
@synthesize characterCountViewMode = _characterCountViewMode;
@synthesize errorColor = _errorColor;
@synthesize floatingPlaceholderScale = _floatingPlaceholderScale;
@synthesize textInput = _textInput;
@synthesize underlineViewMode = _underlineViewMode;

// TODO: (larche): Support in-line auto complete.

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCTextInputControllerDefaultInitialization];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonMDCTextInputControllerDefaultInitialization];

    _characterCounter =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultCharacterCounterKey];
    _characterCountMax =
        [aDecoder decodeIntegerForKey:MDCTextInputControllerDefaultCharacterCountMaxKey];
    _characterCountViewMode =
        [aDecoder decodeIntegerForKey:MDCTextInputControllerDefaultCharacterCountViewModeKey];
    _errorColor = [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultErrorColorKey];
    _floatingEnabled = [aDecoder decodeBoolForKey:MDCTextInputControllerDefaultFloatingEnabledKey];
    _floatingPlaceholderColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultFloatingPlaceholderColorKey];
    _floatingPlaceholderScale =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultFloatingPlaceholderScaleKey];
    _inlinePlaceholderColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultInlinePlaceholderColorKey];
    _textInput = [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultTextInputKey];
    _underlineColorActive =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultUnderlineColorActiveKey];
    _underlineColorNormal =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultUnderlineColorNormalKey];
    _underlineViewMode = (UITextFieldViewMode)
        [aDecoder decodeIntegerForKey:MDCTextInputControllerDefaultUnderlineViewModeKey];
  }
  return self;
}

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)textInput {
  self = [self init];
  if (self) {
    _textInput = textInput;
  }

  // This should happen last because it relies on the state of a ton of properties.
  [self setupInput];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  if ([self.characterCounter conformsToProtocol:@protocol(NSCoding)]) {
    [aCoder encodeObject:self.characterCounter
                  forKey:MDCTextInputControllerDefaultCharacterCounterKey];
  }
  [aCoder encodeInteger:self.characterCountMax
                 forKey:MDCTextInputControllerDefaultCharacterCountMaxKey];
  [aCoder encodeInteger:self.characterCountViewMode
                 forKey:MDCTextInputControllerDefaultCharacterCountViewModeKey];
  [aCoder encodeObject:self.errorAccessibilityValue
                forKey:MDCTextInputControllerDefaultErrorAccessibilityValueKey];
  [aCoder encodeObject:self.errorColor forKey:MDCTextInputControllerDefaultErrorColorKey];
  [aCoder encodeObject:self.errorText forKey:MDCTextInputControllerDefaultErrorTextKey];
  [aCoder encodeBool:self.isFloatingEnabled forKey:MDCTextInputControllerDefaultFloatingEnabledKey];
  [aCoder encodeObject:self.floatingPlaceholderColor
                forKey:MDCTextInputControllerDefaultFloatingPlaceholderColorKey];
  [aCoder encodeObject:self.floatingPlaceholderScale
                forKey:MDCTextInputControllerDefaultFloatingPlaceholderScaleKey];
  [aCoder encodeObject:self.helperText forKey:MDCTextInputControllerDefaultHelperTextKey];
  [aCoder encodeObject:self.inlinePlaceholderColor
                forKey:MDCTextInputControllerDefaultInlinePlaceholderColorKey];
  [aCoder encodeConditionalObject:self.textInput forKey:MDCTextInputControllerDefaultTextInputKey];
  [aCoder encodeObject:self.underlineColorActive
                forKey:MDCTextInputControllerDefaultUnderlineColorActiveKey];
  [aCoder encodeObject:self.underlineColorNormal
                forKey:MDCTextInputControllerDefaultUnderlineColorNormalKey];
  [aCoder encodeInteger:self.underlineViewMode
                 forKey:MDCTextInputControllerDefaultUnderlineViewModeKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextInputControllerDefault *copy = [[[self class] alloc] init];

  copy.characterCounter = self.characterCounter;  // Just a pointer value copy
  copy.characterCountViewMode = self.characterCountViewMode;
  copy.characterCountMax = self.characterCountMax;
  copy.errorAccessibilityValue = [self.errorAccessibilityValue copy];
  copy.errorColor = self.errorColor;
  copy.errorText = [self.errorText copy];
  copy.floatingEnabled = self.isFloatingEnabled;
  copy.floatingPlaceholderColor = self.floatingPlaceholderColor;
  copy.floatingPlaceholderScale = self.floatingPlaceholderScale;
  copy.helperText = [self.helperText copy];
  copy.inlinePlaceholderColor = self.inlinePlaceholderColor;
  copy.previousLeadingText = [self.previousLeadingText copy];
  copy.previousPlaceholderColor = self.previousPlaceholderColor;
  copy.textInput = self.textInput;  // Just a pointer value copy
  copy.underlineColorActive = self.underlineColorActive;
  copy.underlineColorNormal = self.underlineColorNormal;
  copy.underlineViewMode = self.underlineViewMode;

  return copy;
}

- (void)dealloc {
  [self unsubscribeFromNotifications];
  [self unsubscribeFromKVO];
}

- (void)commonMDCTextInputControllerDefaultInitialization {
  _characterCountViewMode = UITextFieldViewModeAlways;
  _floatingEnabled = [[self class] isFloatingEnabledDefault];
  _internalCharacterCounter = [MDCTextInputAllCharactersCounter new];
  _underlineViewMode = [[self class] underlineViewModeDefault];
  _textInput.hidesPlaceholderOnInput = NO;

  [self updatePlaceholderY];
}

- (void)setupInput {
  if (!_textInput) {
    return;
  }

  // This controller will handle Dynamic Type and all fonts for the text input
  _mdc_adjustsFontForContentSizeCategory =
      _textInput.mdc_adjustsFontForContentSizeCategory ||
      [[self class] mdc_adjustsFontForContentSizeCategoryDefault];
  _textInput.mdc_adjustsFontForContentSizeCategory = NO;
  _textInput.positioningDelegate = self;
  _textInput.hidesPlaceholderOnInput = !self.isFloatingEnabled;

  [self subscribeForNotifications];
  [self subscribeForKVO];
  _textInput.underline.color = [[self class] underlineColorNormalDefault];
  [self updatePlaceholderY];
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
    MDCMultilineTextField *textField = (MDCMultilineTextField*)_textInput;
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

- (void)subscribeForKVO {
  if (!_textInput) {
    return;
  }
  [_textInput.leadingUnderlineLabel addObserver:self
                                     forKeyPath:MDCTextInputControllerDefaultKVOKeyFont
                                        options:0
                                        context:nil];
  [_textInput.placeholderLabel addObserver:self
                                forKeyPath:MDCTextInputControllerDefaultKVOKeyFont
                                   options:0
                                   context:nil];
  [_textInput.trailingUnderlineLabel addObserver:self
                                      forKeyPath:MDCTextInputControllerDefaultKVOKeyFont
                                         options:0
                                         context:nil];
  _isRegisteredForKVO = YES;
}

- (void)unsubscribeFromKVO {
  if (!self.textInput || !self.isRegisteredForKVO) {
    return;
  }
  @try {
    [self.textInput.leadingUnderlineLabel removeObserver:self
                                              forKeyPath:MDCTextInputControllerDefaultKVOKeyFont];
    [self.textInput.placeholderLabel removeObserver:self
                                         forKeyPath:MDCTextInputControllerDefaultKVOKeyFont];
    [self.textInput.trailingUnderlineLabel removeObserver:self
                                               forKeyPath:MDCTextInputControllerDefaultKVOKeyFont];
  } @catch (NSException *exception) {
  }
  _isRegisteredForKVO = NO;
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
  if (!self.customLeadingFont) {
    self.textInput.leadingUnderlineLabel.font = [[self class] underlineLabelsFont];
  }

  self.textInput.leadingUnderlineLabel.textColor =
      (self.isDisplayingErrorText || self.isDisplayingCharacterCountError)
          ? self.errorColor
          : MDCTextInputDefaultInlinePlaceholderTextColorDefault();
}

#pragma mark - Placeholder Customization

- (void)updatePlaceholder {
  if (!self.customPlaceholderFont) {
    self.textInput.placeholderLabel.font = [[self class] placeholderFont];
  }

  if (self.isPlaceholderUp) {
    self.textInput.placeholderLabel.textColor =
        (self.isDisplayingCharacterCountError || self.isDisplayingErrorText)
            ? self.errorColor
            : self.floatingPlaceholderColor;
  } else {
    self.textInput.placeholderLabel.textColor = self.inlinePlaceholderColor;
  }
}

// Sometimes the text field is not showing the correct layout for its values (like when it's created
// with .text already entered) so we make sure it's in the right place always.
//
// Note that this calls updateLayout inside it so it is the only 'update-' method not included in
// updateLayout.
- (void)updatePlaceholderY {
  BOOL isDirectionToUp = NO;
  if (self.floatingEnabled) {
    isDirectionToUp = self.textInput.text.length >= 1 || self.textInput.isEditing;
  }

  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  [self movePlaceholderToUp:isDirectionToUp];
  [CATransaction commit];

  [self updateLayout];

  self.textInput.hidesPlaceholderOnInput = !self.floatingEnabled;
  [self.textInput layoutIfNeeded];
}

- (BOOL)isPlaceholderUp {
  return self.placeholderAnimationConstraints.count > 0 &&
         !CGAffineTransformEqualToTransform(self.textInput.placeholderLabel.transform,
                                            CGAffineTransformIdentity);
}

#pragma mark - Placeholder Animation

- (void)movePlaceholderToUp:(BOOL)isToUp {
  if (self.isPlaceholderUp == isToUp) {
    return;
  }

  CGFloat scaleFactor = (CGFloat)self.floatingPlaceholderScale.floatValue;
  CGAffineTransform floatingPlaceholderScaleTransform =
      CGAffineTransformMakeScale(scaleFactor, scaleFactor);

  void (^animationBlock)(void);

  // The animation is accomplished pretty simply. A constraint for vertical and a constraint for
  // horizontal offset, both with a required priority (1000), are acivated on the placeholderLabel.
  // A simple scale transform is also applied. Then it's animated through the UIView animation API
  // (layoutIfNeeded). If in reverse (isToUp == NO), these things are just removed / deactivated.

  if (isToUp) {
    CGPoint destination = [self placeholderFloatingPosition];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.textInput
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:destination.y];

    NSLayoutConstraint *leading =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:destination.x];
    self.placeholderAnimationConstraints = @[ top, leading ];

    self.previousPlaceholderColor = self.textInput.placeholderLabel.textColor;

    animationBlock = ^{
      self.textInput.placeholderLabel.transform = floatingPlaceholderScaleTransform;

      self.textInput.placeholderLabel.textColor =
          (self.isDisplayingCharacterCountError || self.isDisplayingErrorText)
              ? self.errorColor
              : self.floatingPlaceholderColor;
      [NSLayoutConstraint activateConstraints:self.placeholderAnimationConstraints];
    };
  } else {
    animationBlock = ^{
      self.textInput.placeholderLabel.transform = CGAffineTransformIdentity;

      if (self.previousPlaceholderColor) {
        self.textInput.placeholderLabel.textColor = self.previousPlaceholderColor;
      } else {
        self.textInput.placeholderLabel.textColor = self.inlinePlaceholderColor;
      }

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

- (CGPoint)placeholderFloatingPosition {
  CGFloat placeholderY = MDCTextInputDefaultVerticalPadding;

  // Offsets needed due to transform working on normal (0.5,0.5) anchor point.
  // Why no anchor point of (0,0)? Because our users wouldn't expect it.
  placeholderY -= self.textInput.placeholderLabel.font.lineHeight *
                  (1 - (CGFloat)self.floatingPlaceholderScale.floatValue) * .5f;

  CGFloat estimatedWidth = MDCCeil(CGRectGetWidth([self.textInput.placeholderLabel.text
      boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.textInput.placeholderLabel.font.lineHeight)
                   options:0
                attributes:@{
                  NSFontAttributeName : self.textInput.font
                }
                   context:nil]));
  CGFloat placeholderX =
      -1 * estimatedWidth * (1 - (CGFloat)self.floatingPlaceholderScale.floatValue) * .5f;

  return CGPointMake(placeholderX, placeholderY);
}

#pragma mark - Trailing Label Customization

- (void)updateTrailingUnderlineLabel {
  if (!self.characterCountMax) {
    self.textInput.trailingUnderlineLabel.text = nil;
  } else {
    self.textInput.trailingUnderlineLabel.text = [self characterCountText];
    if (!self.customTrailingFont) {
      self.textInput.trailingUnderlineLabel.font = [[self class] underlineLabelsFont];
    }
  }

  UIColor *textColor = [[self class] inlinePlaceholderColorDefault];

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
}

- (NSString *)characterCountText {
  // TODO: (larche) Localize
  return [NSString stringWithFormat:@"%lu / %lu", (unsigned long)[self characterCount],
                                    (unsigned long)self.characterCountMax];
}

#pragma mark - Underline Customization

- (void)updateUnderline {
  UIColor *underlineColor;
  CGFloat underlineHeight;

  switch (self.underlineViewMode) {
    case UITextFieldViewModeAlways:
      underlineColor = self.underlineColorActive;
      underlineHeight = MDCTextInputDefaultUnderlineActiveHeight;
      break;
    case UITextFieldViewModeWhileEditing:
      underlineColor =
          self.textInput.isEditing ? self.underlineColorActive : self.underlineColorNormal;
      underlineHeight = self.textInput.isEditing ? MDCTextInputDefaultUnderlineActiveHeight
                                                 : MDCTextInputDefaultUnderlineNormalHeight;
      break;
    case UITextFieldViewModeUnlessEditing:
      underlineColor =
          !self.textInput.isEditing ? self.underlineColorActive : self.underlineColorNormal;
      underlineHeight = !self.textInput.isEditing ? MDCTextInputDefaultUnderlineActiveHeight
                                                  : MDCTextInputDefaultUnderlineNormalHeight;
      break;
    case UITextFieldViewModeNever:
    default:
      underlineColor = self.underlineColorNormal;
      underlineHeight = MDCTextInputDefaultUnderlineNormalHeight;
      break;
  }
  self.textInput.underline.color =
      (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) ? self.errorColor
                                                                           : underlineColor;
  self.textInput.underline.lineHeight = underlineHeight;
}

#pragma mark - Underline Labels Fonts

+ (UIFont *)placeholderFont {
  return [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
}

+ (UIFont *)underlineLabelsFont {
  return [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleCaption];
}

#pragma mark - Properties Implementation

- (void)setCharacterCountViewMode:(UITextFieldViewMode)characterCountViewMode {
  if (_characterCountViewMode != characterCountViewMode) {
    _characterCountViewMode = characterCountViewMode;

    [self updateLayout];
  }
}

- (void)setErrorAccessibilityValue:(NSString *)errorAccessibilityValue {
  _errorAccessibilityValue = [errorAccessibilityValue copy];
}

- (UIColor *)errorColor {
  if (!_errorColor) {
    _errorColor = [[self class] errorColorDefault];
  }
  return _errorColor;
}

- (void)setErrorColor:(UIColor *)errorColor {
  if (![_errorColor isEqual:errorColor]) {
    _errorColor = errorColor ? errorColor : [[self class] errorColorDefault];
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
    _errorColorDefault = MDCTextInputDefaultTextErrorColorDefault();
  }
  return _errorColorDefault;
}

+ (void)setErrorColorDefault:(UIColor *)errorColorDefault {
  _errorColorDefault =
      errorColorDefault ? errorColorDefault : MDCTextInputDefaultTextErrorColorDefault();
}

- (void)setErrorText:(NSString *)errorText {
  _errorText = [errorText copy];
}

- (void)setFloatingPlaceholderColor:(UIColor *)floatingPlaceholderColor {
  if (![_floatingPlaceholderColor isEqual:floatingPlaceholderColor]) {
    _floatingPlaceholderColor = floatingPlaceholderColor;
    [self updatePlaceholder];
  }
}

- (UIColor *)floatingPlaceholderColor {
  return _floatingPlaceholderColor ? _floatingPlaceholderColor
                                   : [[self class] floatingPlaceholderColorDefault];
}

+ (UIColor *)floatingPlaceholderColorDefault {
  if (!_floatingPlaceholderColorDefault) {
    _floatingPlaceholderColorDefault = MDCTextInputDefaultActiveColorDefault();
  }
  return _floatingPlaceholderColorDefault;
}

+ (void)setFloatingPlaceholderColorDefault:(UIColor *)floatingPlaceholderColorDefault {
  _floatingPlaceholderColorDefault = floatingPlaceholderColorDefault
                                         ? floatingPlaceholderColorDefault
                                         : MDCTextInputDefaultActiveColorDefault();
}

- (void)setFloatingEnabled:(BOOL)floatingEnabled {
  if (_floatingEnabled != floatingEnabled) {
    _floatingEnabled = floatingEnabled;
    [self updatePlaceholderY];
  }
}

+ (BOOL)isFloatingEnabledDefault {
  return _floatingEnabledDefault;
}

+ (void)setFloatingEnabledDefault:(BOOL)floatingEnabledDefault {
  _floatingEnabledDefault = floatingEnabledDefault;
}

- (NSNumber *)floatingPlaceholderScale {
  if (!_floatingPlaceholderScale) {
    _floatingPlaceholderScale =
        [NSNumber numberWithFloat:(float)[[self class] floatingPlaceholderScaleDefault]];
  }
  return _floatingPlaceholderScale;
}

- (void)setFloatingPlaceholderScale:(NSNumber *)floatingPlaceholderScale {
  if (![_floatingPlaceholderScale isEqualToNumber:floatingPlaceholderScale]) {
    _floatingPlaceholderScale =
        floatingPlaceholderScale
            ? floatingPlaceholderScale
            : [NSNumber numberWithFloat:(float)[[self class] floatingPlaceholderScaleDefault]];

    [self updatePlaceholder];
  }
}

+ (CGFloat)floatingPlaceholderScaleDefault {
  return _floatingPlaceholderScaleDefault;
}

+ (void)setFloatingPlaceholderScaleDefault:(CGFloat)floatingPlaceholderScaleDefault {
  _floatingPlaceholderScaleDefault = floatingPlaceholderScaleDefault;
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
                                 : [[self class] inlinePlaceholderColorDefault];
}

+ (UIColor *)inlinePlaceholderColorDefault {
  if (!_inlinePlaceholderColorDefault) {
    _inlinePlaceholderColorDefault = MDCTextInputDefaultInlinePlaceholderTextColorDefault();
  }
  return _inlinePlaceholderColorDefault;
}

+ (void)setInlinePlaceholderColorDefault:(UIColor *)inlinePlaceholderColorDefault {
  _inlinePlaceholderColorDefault = inlinePlaceholderColorDefault
                                       ? inlinePlaceholderColorDefault
                                       : MDCTextInputDefaultInlinePlaceholderTextColorDefault();
}

- (BOOL)isDisplayingCharacterCountError {
  return self.characterCountMax && [self characterCount] > self.characterCountMax;
}

- (BOOL)isDisplayingErrorText {
  return self.errorText != nil;
}

- (void)setPreviousLeadingText:(NSString *)previousLeadingText {
  _previousLeadingText = [previousLeadingText copy];
}

- (void)setPreviousPlaceholderColor:(UIColor *)previousPlaceholderColor {
  _previousPlaceholderColor = previousPlaceholderColor;
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  if (_textInput != textInput) {
    [self unsubscribeFromNotifications];
    [self unsubscribeFromKVO];

    _textInput = textInput;
    [self setupInput];
  }
}

- (UIColor *)underlineColorActive {
  return _underlineColorActive ? _underlineColorActive : [[self class] underlineColorActiveDefault];
}

- (void)setUnderlineColorActive:(UIColor *)underlineColorActive {
  if (![_underlineColorActive isEqual:underlineColorActive]) {
    _underlineColorActive = underlineColorActive;
    [self updateUnderline];
  }
}

+ (UIColor *)underlineColorActiveDefault {
  if (!_underlineColorActiveDefault) {
    _underlineColorActiveDefault = MDCTextInputDefaultActiveColorDefault();
  }
  return _underlineColorActiveDefault;
}

+ (void)setUnderlineColorActiveDefault:(UIColor *)underlineColorActiveDefault {
  _underlineColorActiveDefault = underlineColorActiveDefault
                                     ? underlineColorActiveDefault
                                     : MDCTextInputDefaultActiveColorDefault();
}

- (UIColor *)underlineColorNormal {
  return _underlineColorNormal ? _underlineColorNormal : [[self class] underlineColorNormalDefault];
}

- (void)setUnderlineColorNormal:(UIColor *)underlineColorNormal {
  if (![_underlineColorNormal isEqual:underlineColorNormal]) {
    _underlineColorNormal = underlineColorNormal;
    [self updateUnderline];
  }
}

+ (UIColor *)underlineColorNormalDefault {
  if (!_underlineColorNormalDefault) {
    _underlineColorNormalDefault = MDCTextInputDefaultNormalUnderlineColorDefault();
  }
  return _underlineColorNormalDefault;
}

+ (void)setUnderlineColorNormalDefault:(UIColor *)underlineColorNormalDefault {
  _underlineColorNormalDefault = underlineColorNormalDefault
                                     ? underlineColorNormalDefault
                                     : MDCTextInputDefaultNormalUnderlineColorDefault();
}

- (void)setUnderlineViewMode:(UITextFieldViewMode)underlineViewMode {
  if (_underlineViewMode != underlineViewMode) {
    _underlineViewMode = underlineViewMode;
    [self updateLayout];
  }
}

+ (UITextFieldViewMode)underlineViewModeDefault {
  return _underlineViewModeDefault;
}

+ (void)setUnderlineViewModeDefault:(UITextFieldViewMode)underlineViewModeDefault {
  _underlineViewModeDefault = underlineViewModeDefault;
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
  // These constraints are deactivated via .active (vs deactivate()) in case they are nil.
  self.characterCountTrailing.active = NO;
  self.characterCountY.active = NO;
  self.clearButtonY.active = NO;
  self.clearButtonTrailingCharacterCountLeading.active = NO;
  self.placeholderLeading.active = NO;
  self.placeholderTrailingCharacterCountLeading.active = NO;
  self.placeholderTrailingSuperviewTrailing.active = NO;
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
 textInsets: is the source of truth for vertical layout. It's used to figure out the proper
 height and also where to place the placeholder / text field.
 
 NOTE: It's applied before the textRect is flipped for RTL. So all calculations are done here à la
 LTR.

 The vertical layout is, at most complex, this form:
 MDCTextInputDefaultVerticalPadding +                                        // Top padding
 MDCRint(self.textInput.placeholderLabel.font.lineHeight * scale) +   // Placeholder when up
 MDCTextInputDefaultVerticalHalfPadding +                                    // Small padding
 MDCRint(MAX(self.textInput.font.lineHeight,                          // Text field or placeholder
              self.textInput.placeholderLabel.font.lineHeight)) +
 MDCTextInputDefaultVerticalHalfPadding +                                    // Small padding
 --Underline-- (height not counted)                                   // Underline (height ignored)
 MAX(underlineLabelsOffset,MDCTextInputDefaultVerticalHalfPadding)           // Padding and/or labels
 */
// clang-format on
- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  // NOTE: UITextFields have a centerY based layout. But you can change EITHER the height or the Y.
  // Not both. Don't know why. So, we have to leave the text rect as big as the bounds and move it
  // to a Y that works. In other words, no bottom inset will make a difference here for UITextFields
  UIEdgeInsets textInsets = defaultInsets;

  if (!self.isFloatingEnabled) {
    return defaultInsets;
  }

  textInsets.top = MDCTextInputDefaultVerticalPadding +
                   MDCRint(self.textInput.placeholderLabel.font.lineHeight *
                           (CGFloat)self.floatingPlaceholderScale.floatValue) +
                   MDCTextInputDefaultVerticalHalfPadding;

  // The amount of space underneath the underline is variable. It could just be
  // MDCTextInputDefaultVerticalPadding or the biggest estimated underlineLabel height +
  // MDCTextInputDefaultVerticalHalfPadding
  CGFloat underlineLabelsOffset = 0;
  if (self.textInput.leadingUnderlineLabel.text.length) {
    underlineLabelsOffset =
        MDCCeil(self.textInput.leadingUnderlineLabel.font.lineHeight * 2.f) / 2.f;
  }
  if (self.textInput.trailingUnderlineLabel.text.length || self.characterCountMax) {
    underlineLabelsOffset =
        MAX(underlineLabelsOffset,
            MDCCeil(self.textInput.trailingUnderlineLabel.font.lineHeight * 2.f) / 2.f);
  }
  CGFloat underlineOffset = MDCTextInputDefaultVerticalHalfPadding + underlineLabelsOffset;

  // .bottom = underlineOffset + the half padding above the line but below the text field
  textInsets.bottom = underlineOffset + MDCTextInputDefaultVerticalHalfPadding;

  return textInsets;
}

#pragma mark - UITextField & UITextView Notification Observation

- (void)textInputDidBeginEditing:(NSNotification *)note {
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputDefaultFloatingPlaceholderUpAnimationDuration];
  [CATransaction
      setAnimationTimingFunction:[CAMediaTimingFunction
                                     mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];

  [self updateLayout];

  if (self.isFloatingEnabled && self.textInput.text.length == 0) {
    [self movePlaceholderToUp:YES];
  }
  [CATransaction commit];

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

- (void)textInputDidChange:(NSNotification *)note {
  if ([note.name isEqualToString:MDCTextFieldTextDidSetTextNotification]) {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0];
    [self updatePlaceholderY];
    [CATransaction commit];
  } else {
    [self updateLayout];
  }

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

- (void)textInputDidEndEditing:(NSNotification *)note {
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputDefaultFloatingPlaceholderDownAnimationDuration];
  [CATransaction
      setAnimationTimingFunction:[CAMediaTimingFunction
                                     mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];

  [self updateLayout];

  if (self.isFloatingEnabled && self.textInput.text.length == 0) {
    [self movePlaceholderToUp:NO];
  }
  [CATransaction commit];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  // Listening to outside setting of custom fonts.
  if (![keyPath isEqualToString:MDCTextInputControllerDefaultKVOKeyFont]) {
    return;
  }

  if (object == _textInput.leadingUnderlineLabel &&
      ![_textInput.leadingUnderlineLabel.font isEqual:[[self class] underlineLabelsFont]]) {
    _customLeadingFont = _textInput.leadingUnderlineLabel.font;
  } else if (object == _textInput.placeholderLabel &&
             ![_textInput.placeholderLabel.font isEqual:[[self class] placeholderFont]]) {
    _customPlaceholderFont = _textInput.placeholderLabel.font;
  } else if (object == _textInput.trailingUnderlineLabel &&
             ![_textInput.trailingUnderlineLabel.font isEqual:[[self class] underlineLabelsFont]]) {
    _customTrailingFont = _textInput.trailingUnderlineLabel.font;
  } else {
    return;
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
    self.textInput.leadingUnderlineLabel.accessibilityLabel = nil;
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

+ (BOOL)mdc_adjustsFontForContentSizeCategoryDefault {
  return _mdc_adjustsFontForContentSizeCategoryDefault;
}

+ (void)setMdc_adjustsFontForContentSizeCategoryDefault:
        (BOOL)mdc_adjustsFontForContentSizeCategoryDefault {
  _mdc_adjustsFontForContentSizeCategoryDefault = mdc_adjustsFontForContentSizeCategoryDefault;
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  [self updateFontsForDynamicType];
}

@end
