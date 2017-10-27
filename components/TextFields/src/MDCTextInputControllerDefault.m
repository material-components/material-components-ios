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

#import "MDCTextInputControllerDefault.h"
#import "private/MDCTextInputControllerDefault+Subclassing.h"

#import "MDCMultilineTextField.h"
#import "MDCTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputBorderView.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputUnderlineView.h"

#import "MaterialAnimationTiming.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

#pragma mark - Constants

const CGFloat MDCTextInputDefaultBorderRadius = 4.f;
static const CGFloat MDCTextInputDefaultFloatingPlaceholderScaleDefault = 0.75f;
static const CGFloat MDCTextInputDefaultHintTextOpacity = 0.54f;
const CGFloat MDCTextInputDefaultUnderlineActiveHeight = 2.f;
static const CGFloat MDCTextInputDefaultUnderlineNormalHeight = 1.f;
static const CGFloat MDCTextInputDefaultPadding = 8.f;

static const NSTimeInterval MDCTextInputDefaultFloatingPlaceholderDownAnimationDuration = 0.266666f;
static const NSTimeInterval MDCTextInputDefaultFloatingPlaceholderUpAnimationDuration = 0.3f;

static NSString *const MDCTextInputControllerDefaultActiveColorKey =
    @"MDCTextInputControllerDefaultActiveColorKey";
static NSString *const MDCTextInputControllerDefaultBorderFillColorKey =
    @"MDCTextInputControllerDefaultBorderFillColorKey";
static NSString *const MDCTextInputControllerDefaultCharacterCounterKey =
    @"MDCTextInputControllerDefaultCharacterCounterKey";
static NSString *const MDCTextInputControllerDefaultCharacterCountViewModeKey =
    @"MDCTextInputControllerDefaultCharacterCountViewModeKey";
static NSString *const MDCTextInputControllerDefaultCharacterCountMaxKey =
    @"MDCTextInputControllerDefaultCharacterCountMaxKey";
static NSString *const MDCTextInputControllerDefaultRoundedCorners =
    @"MDCTextInputControllerDefaultRoundedCorners";
static NSString *const MDCTextInputControllerDefaultDisabledColorKey =
    @"MDCTextInputControllerDefaultDisabledColorKey";
static NSString *const MDCTextInputControllerDefaultErrorAccessibilityValueKey =
    @"MDCTextInputControllerDefaultErrorAccessibilityValueKey";
static NSString *const MDCTextInputControllerDefaultErrorColorKey =
    @"MDCTextInputControllerDefaultErrorColorKey";
static NSString *const MDCTextInputControllerDefaultErrorTextKey =
    @"MDCTextInputControllerDefaultErrorTextKey";
static NSString *const MDCTextInputControllerDefaultExpandsOnOverflowKey =
    @"MDCTextInputControllerDefaultExpandsOnOverflowKey";
static NSString *const MDCTextInputControllerDefaultFloatingEnabledKey =
    @"MDCTextInputControllerDefaultFloatingEnabledKey";
static NSString *const MDCTextInputControllerDefaultFloatingPlaceholderNormalColorKey =
    @"MDCTextInputControllerDefaultFloatingPlaceholderNormalColorKey";
static NSString *const MDCTextInputControllerDefaultFloatingPlaceholderScaleKey =
    @"MDCTextInputControllerDefaultFloatingPlaceholderScaleKey";
static NSString *const MDCTextInputControllerDefaultHelperTextKey =
    @"MDCTextInputControllerDefaultHelperTextKey";
static NSString *const MDCTextInputControllerDefaultInlinePlaceholderFontKey =
    @"MDCTextInputControllerDefaultInlinePlaceholderFontKey";
static NSString *const MDCTextInputControllerDefaultInlinePlaceholderColorKey =
    @"MDCTextInputControllerDefaultInlinePlaceholderColorKey";
static NSString *const MDCTextInputControllerDefaultLeadingUnderlineLabelFontKey =
    @"MDCTextInputControllerDefaultLeadingUnderlineLabelFontKey";
static NSString *const MDCTextInputControllerDefaultLeadingUnderlineLabelTextColor =
    @"MDCTextInputControllerDefaultLeadingUnderlineLabelTextColor";
static NSString *const MDCTextInputControllerDefaultMinimumLinesKey =
    @"MDCTextInputControllerDefaultMinimumLinesKey";
static NSString *const MDCTextInputControllerDefaultNormalColorKey =
    @"MDCTextInputControllerDefaultNormalColorKey";
static NSString *const MDCTextInputControllerDefaultPresentationStyleKey =
    @"MDCTextInputControllerDefaultPresentationStyleKey";
static NSString *const MDCTextInputControllerDefaultTextInputKey =
    @"MDCTextInputControllerDefaultTextInputKey";
static NSString *const MDCTextInputControllerDefaultTrailingUnderlineLabelFontKey =
    @"MDCTextInputControllerDefaultTrailingUnderlineLabelFontKey";
static NSString *const MDCTextInputControllerDefaultTrailingUnderlineLabelTextColor =
    @"MDCTextInputControllerDefaultTrailingUnderlineLabelTextColor";
static NSString *const MDCTextInputControllerDefaultUnderlineViewModeKey =
    @"MDCTextInputControllerDefaultUnderlineViewModeKey";

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

static UIColor *_activeColorDefault;
static UIColor *_borderFillColorDefault;
static UIColor *_disabledColorDefault;
static UIColor *_errorColorDefault;
static UIColor *_floatingPlaceholderNormalColorDefault;
static UIColor *_inlinePlaceholderColorDefault;
static UIColor *_leadingUnderlineLabelTextColorDefault;
static UIColor *_normalColorDefault;
static UIColor *_trailingUnderlineLabelTextColorDefault;

static UIFont *_inlinePlaceholderFontDefault;
static UIFont *_leadingUnderlineLabelFontDefault;
static UIFont *_trailingUnderlineLabelFontDefault;

static UIRectCorner _roundedCornersDefault = 0;

static UITextFieldViewMode _underlineViewModeDefault = UITextFieldViewModeWhileEditing;

@interface MDCTextInputControllerDefault () {
  BOOL _mdc_adjustsFontForContentSizeCategory;

  MDCTextInputAllCharactersCounter *_characterCounter;

  NSNumber *_floatingPlaceholderScale;

  UIColor *_activeColor;
  UIColor *_borderFillColor;
  UIColor *_disabledColor;
  UIColor *_errorColor;
  UIColor *_floatingPlaceholderNormalColor;
  UIColor *_inlinePlaceholderColor;
  UIColor *_leadingUnderlineLabelTextColor;
  UIColor *_normalColor;
  UIColor *_trailingUnderlineLabelTextColor;

  UIFont *_inlinePlaceholderFont;
  UIFont *_leadingUnderlineLabelFont;
  UIFont *_trailingUnderlineLabelFont;

  UIRectCorner _roundedCorners;
}

@property(nonatomic, assign, readonly) BOOL isPlaceholderUp;

@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;

@property(nonatomic, copy) NSArray<NSLayoutConstraint *> *placeholderAnimationConstraints;

@property(nonatomic, strong) NSLayoutConstraint *placeholderAnimationConstraintLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderAnimationConstraintTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderAnimationConstraintTrailing;

@property(nonatomic, copy) NSString *errorAccessibilityValue;
@property(nonatomic, copy, readwrite) NSString *errorText;
@property(nonatomic, copy) NSString *previousLeadingText;

@end

@implementation MDCTextInputControllerDefault

@synthesize characterCountMax = _characterCountMax;
@synthesize characterCountViewMode = _characterCountViewMode;
@synthesize roundedCorners = _roundedCorners;
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

    _activeColor = [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultActiveColorKey];
    _borderFillColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultBorderFillColorKey];
    _characterCounter =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultCharacterCounterKey];
    _characterCountMax =
        [aDecoder decodeIntegerForKey:MDCTextInputControllerDefaultCharacterCountMaxKey];
    _characterCountViewMode =
        [aDecoder decodeIntegerForKey:MDCTextInputControllerDefaultCharacterCountViewModeKey];
    _roundedCorners =
        (UIRectCorner)[aDecoder decodeIntegerForKey:MDCTextInputControllerDefaultRoundedCorners];
    _disabledColor = [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultDisabledColorKey];
    _errorColor = [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultErrorColorKey];
    _expandsOnOverflow =
        [aDecoder decodeBoolForKey:MDCTextInputControllerDefaultExpandsOnOverflowKey];
    _floatingEnabled = [aDecoder decodeBoolForKey:MDCTextInputControllerDefaultFloatingEnabledKey];
    _floatingPlaceholderNormalColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultFloatingPlaceholderNormalColorKey];
    _floatingPlaceholderScale =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultFloatingPlaceholderScaleKey];
    _inlinePlaceholderColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultInlinePlaceholderColorKey];
    _inlinePlaceholderFont =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultInlinePlaceholderFontKey];
    _leadingUnderlineLabelFont =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultLeadingUnderlineLabelFontKey];
    _leadingUnderlineLabelTextColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultLeadingUnderlineLabelTextColor];
    _minimumLines = [aDecoder decodeIntegerForKey:MDCTextInputControllerDefaultMinimumLinesKey];
    _normalColor = [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultNormalColorKey];
    _textInput = [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultTextInputKey];
    _trailingUnderlineLabelFont =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultTrailingUnderlineLabelFontKey];
    _trailingUnderlineLabelTextColor =
        [aDecoder decodeObjectForKey:MDCTextInputControllerDefaultTrailingUnderlineLabelTextColor];
    _underlineViewMode = (UITextFieldViewMode)
        [aDecoder decodeIntegerForKey:MDCTextInputControllerDefaultUnderlineViewModeKey];
  }
  return self;
}

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)textInput {
  self = [self init];
  if (self) {
    _textInput = textInput;

    // This should happen last because it relies on the state of a ton of properties.
    [self setupInput];
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.activeColor forKey:MDCTextInputControllerDefaultActiveColorKey];
  [aCoder encodeObject:self.borderFillColor forKey:MDCTextInputControllerDefaultBorderFillColorKey];
  if ([self.characterCounter conformsToProtocol:@protocol(NSCoding)]) {
    [aCoder encodeObject:self.characterCounter
                  forKey:MDCTextInputControllerDefaultCharacterCounterKey];
  }
  [aCoder encodeInteger:self.characterCountMax
                 forKey:MDCTextInputControllerDefaultCharacterCountMaxKey];
  [aCoder encodeInteger:self.characterCountViewMode
                 forKey:MDCTextInputControllerDefaultCharacterCountViewModeKey];
  [aCoder encodeInteger:self.roundedCorners forKey:MDCTextInputControllerDefaultRoundedCorners];
  [aCoder encodeObject:self.disabledColor forKey:MDCTextInputControllerDefaultDisabledColorKey];
  [aCoder encodeObject:self.errorAccessibilityValue
                forKey:MDCTextInputControllerDefaultErrorAccessibilityValueKey];
  [aCoder encodeObject:self.errorColor forKey:MDCTextInputControllerDefaultErrorColorKey];
  [aCoder encodeObject:self.errorText forKey:MDCTextInputControllerDefaultErrorTextKey];
  [aCoder encodeBool:self.expandsOnOverflow
              forKey:MDCTextInputControllerDefaultExpandsOnOverflowKey];
  [aCoder encodeBool:self.isFloatingEnabled forKey:MDCTextInputControllerDefaultFloatingEnabledKey];
  [aCoder encodeObject:self.floatingPlaceholderNormalColor
                forKey:MDCTextInputControllerDefaultFloatingPlaceholderNormalColorKey];
  [aCoder encodeObject:self.floatingPlaceholderScale
                forKey:MDCTextInputControllerDefaultFloatingPlaceholderScaleKey];
  [aCoder encodeObject:self.helperText forKey:MDCTextInputControllerDefaultHelperTextKey];
  [aCoder encodeObject:self.inlinePlaceholderColor
                forKey:MDCTextInputControllerDefaultInlinePlaceholderColorKey];
  [aCoder encodeObject:self.inlinePlaceholderFont
                forKey:MDCTextInputControllerDefaultInlinePlaceholderFontKey];
  [aCoder encodeObject:self.leadingUnderlineLabelFont
                forKey:MDCTextInputControllerDefaultLeadingUnderlineLabelFontKey];
  [aCoder encodeObject:self.leadingUnderlineLabelTextColor
                forKey:MDCTextInputControllerDefaultLeadingUnderlineLabelTextColor];
  [aCoder encodeInteger:self.minimumLines forKey:MDCTextInputControllerDefaultMinimumLinesKey];
  [aCoder encodeObject:self.normalColor forKey:MDCTextInputControllerDefaultNormalColorKey];
  [aCoder encodeConditionalObject:self.textInput forKey:MDCTextInputControllerDefaultTextInputKey];
  [aCoder encodeObject:self.trailingUnderlineLabelFont
                forKey:MDCTextInputControllerDefaultTrailingUnderlineLabelFontKey];
  [aCoder encodeObject:self.trailingUnderlineLabelTextColor
                forKey:MDCTextInputControllerDefaultTrailingUnderlineLabelTextColor];
  [aCoder encodeInteger:self.underlineViewMode
                 forKey:MDCTextInputControllerDefaultUnderlineViewModeKey];
}

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCTextInputControllerDefault *copy = [[[self class] alloc] init];

  copy.activeColor = self.activeColor;
  copy.borderFillColor = self.borderFillColor;
  copy.characterCounter = self.characterCounter;  // Just a pointer value copy
  copy.characterCountViewMode = self.characterCountViewMode;
  copy.characterCountMax = self.characterCountMax;
  copy.roundedCorners = self.roundedCorners;
  copy.disabledColor = self.disabledColor;
  copy.errorAccessibilityValue = [self.errorAccessibilityValue copy];
  copy.errorColor = self.errorColor;
  copy.errorText = [self.errorText copy];
  copy.expandsOnOverflow = self.expandsOnOverflow;
  copy.floatingEnabled = self.isFloatingEnabled;
  copy.floatingPlaceholderNormalColor = self.floatingPlaceholderNormalColor;
  copy.floatingPlaceholderScale = self.floatingPlaceholderScale;
  copy.helperText = [self.helperText copy];
  copy.inlinePlaceholderColor = self.inlinePlaceholderColor;
  copy.inlinePlaceholderFont = self.inlinePlaceholderFont;
  copy.leadingUnderlineLabelFont = self.leadingUnderlineLabelFont;
  copy.leadingUnderlineLabelTextColor = self.leadingUnderlineLabelTextColor;
  copy.minimumLines = self.minimumLines;
  copy.normalColor = self.normalColor;
  copy.previousLeadingText = [self.previousLeadingText copy];
  copy.textInput = self.textInput;  // Just a pointer value copy
  copy.trailingUnderlineLabelFont = self.trailingUnderlineLabelFont;
  copy.trailingUnderlineLabelTextColor = self.trailingUnderlineLabelTextColor;
  copy.underlineViewMode = self.underlineViewMode;

  return copy;
}

- (void)dealloc {
  [self unsubscribeFromNotifications];
}

- (void)commonMDCTextInputControllerDefaultInitialization {
  _roundedCorners = [self class].roundedCornersDefault;
  _characterCountViewMode = UITextFieldViewModeAlways;
  _disabledColor = [self class].disabledColorDefault;
  _expandsOnOverflow = YES;
  _floatingEnabled = [self class].isFloatingEnabledDefault;
  _internalCharacterCounter = [[MDCTextInputAllCharactersCounter alloc] init];
  _minimumLines = 1;
  _underlineViewMode = [self class].underlineViewModeDefault;
  _textInput.hidesPlaceholderOnInput = NO;

  [self forceUpdatePlaceholderY];
}

- (void)setupInput {
  if (!_textInput) {
    return;
  }

  // This controller will handle Dynamic Type and all fonts for the text input
  _mdc_adjustsFontForContentSizeCategory =
      _textInput.mdc_adjustsFontForContentSizeCategory ||
      [self class].mdc_adjustsFontForContentSizeCategoryDefault;
  _textInput.underline.disabledColor = self.disabledColor;
  _textInput.mdc_adjustsFontForContentSizeCategory = NO;
  _textInput.positioningDelegate = self;
  _textInput.hidesPlaceholderOnInput = !self.isFloatingEnabled;
  _textInput.textInsetsMode = MDCTextInputTextInsetsModeAlways;

  if ([_textInput conformsToProtocol:@protocol(MDCMultilineTextInput)] &&
      [_textInput respondsToSelector:@selector(setMinimumLines:)]) {
    ((MDCMultilineTextField *)_textInput).minimumLines = self.minimumLines;
  }

  if ([_textInput conformsToProtocol:@protocol(MDCMultilineTextInput)] &&
      [_textInput respondsToSelector:@selector(setExpandsOnOverflow:)]) {
    ((MDCMultilineTextField *)_textInput).expandsOnOverflow = self.expandsOnOverflow;
  }

  [self subscribeForNotifications];
  _textInput.underline.color = [self class].normalColorDefault;
  [self forceUpdatePlaceholderY];
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
    [defaultCenter addObserver:self
                      selector:@selector(textInputDidChange:)
                          name:MDCTextFieldTextDidSetTextNotification
                        object:_textInput];
  }
}

- (void)unsubscribeFromNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self];
}

#pragma mark - Border Customization

- (void)updateBorder {
  self.textInput.borderView.borderFillColor = self.borderFillColor;
  self.textInput.borderPath = [self defaultBorderPath];
}

- (UIBezierPath *)defaultBorderPath {
  CGRect borderBound = self.textInput.bounds;
  borderBound.size.height = CGRectGetMaxY(self.textInput.underline.frame);
  return [UIBezierPath bezierPathWithRoundedRect:borderBound
                               byRoundingCorners:self.roundedCorners
                                     cornerRadii:CGSizeMake(MDCTextInputDefaultBorderRadius,
                                                            MDCTextInputDefaultBorderRadius)];
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
  self.textInput.leadingUnderlineLabel.font = self.leadingUnderlineLabelFont;

  self.textInput.leadingUnderlineLabel.textColor =
      (self.isDisplayingErrorText || self.isDisplayingCharacterCountError)
          ? self.errorColor
          : self.leadingUnderlineLabelTextColor;
}

#pragma mark - Placeholder Customization

- (void)updatePlaceholder {
  self.textInput.placeholderLabel.font = self.inlinePlaceholderFont;

  UIColor *placeholderColor;
  if (self.isPlaceholderUp) {
    UIColor *nonErrorColor = self.textInput.isEditing ? self.activeColor :
        self.floatingPlaceholderNormalColor;
    placeholderColor =
        (self.isDisplayingCharacterCountError || self.isDisplayingErrorText)
            ? self.errorColor : nonErrorColor;
  } else {
    placeholderColor = self.textInput.isEditing ? self.activeColor :
        self.inlinePlaceholderColor;
  }
  self.textInput.placeholderLabel.textColor = placeholderColor;
}

// Sometimes the text field is not showing the correct layout for its values (like when it's created
// with .text already entered) so we make sure it's in the right place always.
//
// Note that this calls updateLayout inside it so it is the only 'update-' method not included in
// updateLayout.
- (void)forceUpdatePlaceholderY {
  BOOL isDirectionToUp = NO;
  if (self.floatingEnabled) {
    isDirectionToUp = self.textInput.text.length >= 1 || self.textInput.isEditing;
  }

  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  [self movePlaceholderToUp:isDirectionToUp];
  [self updateLayout];

  [CATransaction commit];

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

  // The animation is accomplished pretty simply. A constraint for vertical and a constraint for
  // horizontal offset, both with a required priority (1000), are acivated on the placeholderLabel.
  // A simple scale transform is also applied. Then it's animated through the UIView animation API
  // (layoutIfNeeded). If in reverse (isToUp == NO), these things are just removed / deactivated.

  CGAffineTransform scaleTransform =
      isToUp ? floatingPlaceholderScaleTransform : CGAffineTransformIdentity;

  // We do this beforehand to flush the layout engine.
  [self.textInput layoutIfNeeded];
  [self updatePlaceholder];
  [self updatePlaceholderAnimationConstraints:isToUp];
  [UIView animateWithDuration:[CATransaction animationDuration]
      animations:^{
        self.textInput.placeholderLabel.transform = scaleTransform;

        [self.textInput layoutIfNeeded];
      }
      completion:^(__unused BOOL finished) {
        if (!isToUp) {
          [self cleanupPlaceholderAnimationConstraints];
        }
      }];
}

- (void)updatePlaceholderAnimationConstraints:(BOOL)isToUp {
  if (isToUp) {
    UIOffset offset = [self floatingPlaceholderOffset];
    UIEdgeInsets insets = self.textInput.textInsets;

    CGFloat horizontalLeading = insets.left - offset.horizontal;
    if (!self.placeholderAnimationConstraintLeading) {
      self.placeholderAnimationConstraintLeading =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:horizontalLeading];
    }
    self.placeholderAnimationConstraintLeading.constant = horizontalLeading;

    if (!self.placeholderAnimationConstraintTop) {
      self.placeholderAnimationConstraintTop =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1
                                        constant:offset.vertical];
    }
    self.placeholderAnimationConstraintTop.constant = offset.vertical;

    CGFloat horizontalTrailing = offset.horizontal - insets.right;
    if (!self.placeholderAnimationConstraintTrailing) {
      self.placeholderAnimationConstraintTrailing =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeTrailing
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:horizontalTrailing];
      self.placeholderAnimationConstraintTrailing.priority = UILayoutPriorityDefaultHigh - 1;
    }
    self.placeholderAnimationConstraintTrailing.constant = horizontalTrailing;

    self.placeholderAnimationConstraints = @[
      self.placeholderAnimationConstraintLeading, self.placeholderAnimationConstraintTop,
      self.placeholderAnimationConstraintTrailing
    ];
    [NSLayoutConstraint activateConstraints:self.placeholderAnimationConstraints];
  } else {
    [NSLayoutConstraint deactivateConstraints:self.placeholderAnimationConstraints];
  }
}

- (void)cleanupPlaceholderAnimationConstraints {
  self.placeholderAnimationConstraints = nil;
  self.placeholderAnimationConstraintLeading = nil;
  self.placeholderAnimationConstraintTop = nil;
  self.placeholderAnimationConstraintTrailing = nil;
}

- (UIOffset)floatingPlaceholderOffset {
  CGFloat vertical = MDCTextInputDefaultPadding;

  // Offsets needed due to transform working on normal (0.5,0.5) anchor point.
  // Why no anchor point of (0,0)? Because autolayout doesn't play well with anchor points.
  vertical -= self.textInput.placeholderLabel.font.lineHeight *
              (1 - (CGFloat)self.floatingPlaceholderScale.floatValue) * .5f;

  UIEdgeInsets insets = self.textInput.textInsets;
  CGFloat placeholderMaxWidth =
      CGRectGetWidth(self.textInput.bounds) / self.floatingPlaceholderScale.floatValue -
      insets.left - insets.right;

  CGFloat placeholderWidth =
      [self.textInput.placeholderLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]
          .width;
  if (placeholderWidth > placeholderMaxWidth) {
    placeholderWidth = placeholderMaxWidth;
  }

  CGFloat horizontal =
      placeholderWidth * (1 - (CGFloat)self.floatingPlaceholderScale.floatValue) * .5f;

  return UIOffsetMake(horizontal, vertical);
}

#pragma mark - Trailing Label Customization

- (void)updateTrailingUnderlineLabel {
  if (!self.characterCountMax) {
    self.textInput.trailingUnderlineLabel.text = nil;
  } else {
    self.textInput.trailingUnderlineLabel.text = [self characterCountText];
    self.textInput.trailingUnderlineLabel.font = self.trailingUnderlineLabelFont;
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
      underlineColor = self.activeColor;
      underlineHeight = MDCTextInputDefaultUnderlineActiveHeight;
      break;
    case UITextFieldViewModeWhileEditing:
      underlineColor = self.textInput.isEditing ? self.activeColor : self.normalColor;
      underlineHeight = self.textInput.isEditing ? MDCTextInputDefaultUnderlineActiveHeight
                                                 : MDCTextInputDefaultUnderlineNormalHeight;
      break;
    case UITextFieldViewModeUnlessEditing:
      underlineColor = !self.textInput.isEditing ? self.activeColor : self.normalColor;
      underlineHeight = !self.textInput.isEditing ? MDCTextInputDefaultUnderlineActiveHeight
                                                  : MDCTextInputDefaultUnderlineNormalHeight;
      break;
    case UITextFieldViewModeNever:
    default:
      underlineColor = self.normalColor;
      underlineHeight = MDCTextInputDefaultUnderlineNormalHeight;
      break;
  }
  self.textInput.underline.color =
      (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) ? self.errorColor
                                                                           : underlineColor;
  self.textInput.underline.lineHeight = underlineHeight;

  self.textInput.underline.disabledColor = self.disabledColor;
}

#pragma mark - Underline Labels Fonts

+ (UIFont *)placeholderFont {
  return [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
}

+ (UIFont *)underlineLabelsFont {
  return [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleCaption];
}

#pragma mark - Properties Implementation

- (UIColor *)activeColor {
  return _activeColor ? _activeColor : [self class].activeColorDefault;
}

- (void)setActiveColor:(UIColor *)activeColor {
  if (![_activeColor isEqual:activeColor]) {
    _activeColor = activeColor;
    [self updateUnderline];
  }
}

+ (UIColor *)activeColorDefault {
  if (!_activeColorDefault) {
    _activeColorDefault = MDCTextInputDefaultActiveColorDefault();
  }
  return _activeColorDefault;
}

+ (void)setActiveColorDefault:(UIColor *)activeColorDefault {
  _activeColorDefault =
      activeColorDefault ? activeColorDefault : MDCTextInputDefaultActiveColorDefault();
}

- (UIColor *)borderFillColor {
  if (!_borderFillColor) {
    _borderFillColor = [self class].borderFillColorDefault;
  }
  return _borderFillColor;
}

- (void)setBorderFillColor:(UIColor *)borderFillColor {
  if (_borderFillColor != borderFillColor) {
    _borderFillColor = borderFillColor ? borderFillColor : [self class].borderFillColorDefault;
    [self updateBorder];
  }
}

+ (UIColor *)borderFillColorDefault {
  if (!_borderFillColorDefault) {
    _borderFillColorDefault = [UIColor clearColor];
  }
  return _borderFillColorDefault;
}

+ (void)setBorderFillColorDefault:(UIColor *)borderFillColorDefault {
  _borderFillColorDefault = borderFillColorDefault ? borderFillColorDefault : [UIColor clearColor];
}

- (void)setCharacterCountViewMode:(UITextFieldViewMode)characterCountViewMode {
  if (_characterCountViewMode != characterCountViewMode) {
    _characterCountViewMode = characterCountViewMode;

    [self updateLayout];
  }
}

- (UIColor *)disabledColor {
  if (!_disabledColor) {
    _disabledColor = [self class].disabledColorDefault;
  }
  return _disabledColor;
}

- (void)setDisabledColor:(UIColor *)disabledColor {
  if (_disabledColor != disabledColor) {
    _disabledColor =
        disabledColor ? disabledColor : MDCTextInputDefaultNormalUnderlineColorDefault();
    [self updateLayout];
  }
}

+ (UIColor *)disabledColorDefault {
  if (!_disabledColorDefault) {
    _disabledColorDefault = MDCTextInputDefaultNormalUnderlineColorDefault();
  }
  return _disabledColorDefault;
}

+ (void)setDisabledColorDefault:(UIColor *)disabledColorDefault {
  _disabledColorDefault = disabledColorDefault ? disabledColorDefault
                                               : MDCTextInputDefaultNormalUnderlineColorDefault();
}

- (BOOL)isDisplayingCharacterCountError {
  return self.characterCountMax && [self characterCount] > self.characterCountMax;
}

- (BOOL)isDisplayingErrorText {
  return self.errorText != nil;
}

- (void)setErrorAccessibilityValue:(NSString *)errorAccessibilityValue {
  _errorAccessibilityValue = [errorAccessibilityValue copy];
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

- (void)setExpandsOnOverflow:(BOOL)expandsOnOverflow {
  if (_expandsOnOverflow != expandsOnOverflow) {
    _expandsOnOverflow = expandsOnOverflow;
    if ([_textInput conformsToProtocol:@protocol(MDCMultilineTextInput)] &&
        [_textInput respondsToSelector:@selector(setExpandsOnOverflow:)]) {
      ((MDCMultilineTextField *)_textInput).expandsOnOverflow = expandsOnOverflow;
    }
  }
}

- (UIColor *)floatingPlaceholderNormalColor {
  return _floatingPlaceholderNormalColor ? _floatingPlaceholderNormalColor
                                   : [self class].floatingPlaceholderNormalColorDefault;
}

- (void)setFloatingPlaceholderNormalColor:(UIColor *)floatingPlaceholderNormalColor {
  if (![_floatingPlaceholderNormalColor isEqual:floatingPlaceholderNormalColor]) {
    _floatingPlaceholderNormalColor = floatingPlaceholderNormalColor;
    [self updatePlaceholder];
  }
}

+ (UIColor *)floatingPlaceholderNormalColorDefault {
  if (!_floatingPlaceholderNormalColorDefault) {
    _floatingPlaceholderNormalColorDefault = [self class].inlinePlaceholderColorDefault;
  }
  return _floatingPlaceholderNormalColorDefault;
}

+ (void)setFloatingPlaceholderNormalColorDefault:(UIColor *)floatingPlaceholderNormalColorDefault {
  _floatingPlaceholderNormalColorDefault = floatingPlaceholderNormalColorDefault
                                         ? floatingPlaceholderNormalColorDefault
                                         : [self class].inlinePlaceholderColorDefault;
}

- (void)setFloatingEnabled:(BOOL)floatingEnabled {
  if (_floatingEnabled != floatingEnabled) {
    _floatingEnabled = floatingEnabled;
    [self forceUpdatePlaceholderY];
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
        [NSNumber numberWithFloat:(float)[self class].floatingPlaceholderScaleDefault];
  }
  return _floatingPlaceholderScale;
}

- (void)setFloatingPlaceholderScale:(NSNumber *)floatingPlaceholderScale {
  if (![_floatingPlaceholderScale isEqualToNumber:floatingPlaceholderScale]) {
    _floatingPlaceholderScale =
        floatingPlaceholderScale
            ? floatingPlaceholderScale
            : [NSNumber numberWithFloat:(float)[self class].floatingPlaceholderScaleDefault];

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
                                 : [self class].inlinePlaceholderColorDefault;
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

- (UIFont *)leadingUnderlineLabelFont {
  return _leadingUnderlineLabelFont ?: [self class].leadingUnderlineLabelFontDefault;
}

- (void)setLeadingUnderlineLabelFont:(UIFont *)leadingUnderlineLabelFont {
  if (![_leadingUnderlineLabelFont isEqual:leadingUnderlineLabelFont]) {
    _leadingUnderlineLabelFont = leadingUnderlineLabelFont;
    [self updateLayout];
  }
}

+ (UIFont *)leadingUnderlineLabelFontDefault {
  return _leadingUnderlineLabelFontDefault ?: [[self class] underlineLabelsFont];
}

+ (void)setLeadingUnderlineLabelFontDefault:(UIFont *)leadingUnderlineLabelFontDefault {
  _leadingUnderlineLabelFontDefault = leadingUnderlineLabelFontDefault;
}

- (UIColor *)leadingUnderlineLabelTextColor {
  return _leadingUnderlineLabelTextColor ? _leadingUnderlineLabelTextColor
                                         : [self class].leadingUnderlineLabelTextColorDefault;
}

- (void)setLeadingUnderlineLabelTextColor:(UIColor *)leadingUnderlineLabelTextColor {
  if (_leadingUnderlineLabelTextColor != leadingUnderlineLabelTextColor) {
    _leadingUnderlineLabelTextColor = leadingUnderlineLabelTextColor
                                          ? leadingUnderlineLabelTextColor
                                          : [self class].leadingUnderlineLabelTextColorDefault;

    [self updateLeadingUnderlineLabel];
  }
}

+ (UIColor *)leadingUnderlineLabelTextColorDefault {
  if (!_leadingUnderlineLabelTextColorDefault) {
    _leadingUnderlineLabelTextColorDefault = MDCTextInputDefaultInlinePlaceholderTextColorDefault();
  }
  return _leadingUnderlineLabelTextColorDefault;
}

+ (void)setLeadingUnderlineLabelTextColorDefault:(UIColor *)leadingUnderlineLabelTextColorDefault {
  _leadingUnderlineLabelTextColorDefault =
      leadingUnderlineLabelTextColorDefault
          ? leadingUnderlineLabelTextColorDefault
          : MDCTextInputDefaultInlinePlaceholderTextColorDefault();
}

- (void)setMinimumLines:(NSUInteger)minimumLines {
  if (_minimumLines != minimumLines) {
    _minimumLines = minimumLines;
    if ([_textInput conformsToProtocol:@protocol(MDCMultilineTextInput)] &&
        [_textInput respondsToSelector:@selector(setMinimumLines:)]) {
      ((MDCMultilineTextField *)_textInput).minimumLines = minimumLines;
    }
  }
}

- (UIColor *)normalColor {
  return _normalColor ? _normalColor : [self class].normalColorDefault;
}

- (void)setNormalColor:(UIColor *)normalColor {
  if (![_normalColor isEqual:normalColor]) {
    _normalColor = normalColor;
    [self updateUnderline];
  }
}

+ (UIColor *)normalColorDefault {
  if (!_normalColorDefault) {
    _normalColorDefault = MDCTextInputDefaultNormalUnderlineColorDefault();
  }
  return _normalColorDefault;
}

+ (void)setNormalColorDefault:(UIColor *)normalColorDefault {
  _normalColorDefault =
      normalColorDefault ? normalColorDefault : MDCTextInputDefaultNormalUnderlineColorDefault();
}

- (NSString *)placeholderText {
  return _textInput.placeholder;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
  if ([_textInput.placeholder isEqualToString: placeholderText]) {
    return;
  }
  _textInput.placeholder = [placeholderText copy];
  if (self.isFloatingEnabled && _textInput.text.length > 0) {
    [self updatePlaceholderAnimationConstraints:YES];
  }
}

- (void)setPreviousLeadingText:(NSString *)previousLeadingText {
  _previousLeadingText = [previousLeadingText copy];
}

- (void)setRoundedCorners:(UIRectCorner)roundedCorners {
  if (_roundedCorners != roundedCorners) {
    _roundedCorners = roundedCorners;

    [self updateLayout];
  }
}

+ (UIRectCorner)roundedCornersDefault {
  return _roundedCornersDefault;
}

+ (void)setRoundedCornersDefault:(UIRectCorner)roundedCornersDefault {
  _roundedCornersDefault = roundedCornersDefault;
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  if (_textInput != textInput) {
    [self unsubscribeFromNotifications];

    _textInput = textInput;
    [self setupInput];
  }
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
        MDCTextInputDefaultInlinePlaceholderTextColorDefault();
  }
  return _trailingUnderlineLabelTextColorDefault;
}

+ (void)setTrailingUnderlineLabelTextColorDefault:
        (UIColor *)trailingUnderlineLabelTextColorDefault {
  _trailingUnderlineLabelTextColorDefault =
      trailingUnderlineLabelTextColorDefault
          ? trailingUnderlineLabelTextColorDefault
          : MDCTextInputDefaultInlinePlaceholderTextColorDefault();
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
  [self updateBorder];
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
 MDCTextInputDefaultPadding +                                         // Top padding
 MDCRint(self.textInput.placeholderLabel.font.lineHeight * scale) +   // Placeholder when up
 MDCTextInputDefaultVerticalHalfPadding +                             // Small padding
 MDCCeil(MAX(self.textInput.font.lineHeight,                          // Text field or placeholder
            self.textInput.placeholderLabel.font.lineHeight)) +
 MDCTextInputDefaultPadding +                                         // Padding to underline
 --Underline--                                                        // Underline (height not counted)
 underlineLabelsOffset                                                // Depends on text insets mode
 */
// clang-format on
- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  // NOTE: UITextFields have a centerY based layout. But you can change EITHER the height or the Y.
  // Not both. Don't know why. So, we have to leave the text rect as big as the bounds and move it
  // to a Y that works. In other words, no bottom inset will make a difference here for UITextFields
  UIEdgeInsets textInsets = defaultInsets;

  if (!self.isFloatingEnabled) {
    return textInsets;
  }

  textInsets.top = MDCTextInputDefaultPadding +
                   MDCRint(self.textInput.placeholderLabel.font.lineHeight *
                           (CGFloat)self.floatingPlaceholderScale.floatValue) +
                   MDCTextInputDefaultPadding;

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat leadingOffset =
      MDCCeil(self.textInput.leadingUnderlineLabel.font.lineHeight * scale) / scale;
  CGFloat trailingOffset =
      MDCCeil(self.textInput.trailingUnderlineLabel.font.lineHeight * scale) / scale;

  // The amount of space underneath the underline is variable. It could just be
  // MDCTextInputHalfPadding or the biggest estimated underlineLabel height +
  // MDCTextInputHalfPadding. It's also dependent on the .textInsetsMode.
  CGFloat underlineOffset = 0;
  switch (self.textInput.textInsetsMode) {
    case MDCTextInputTextInsetsModeAlways:
      underlineOffset += MAX(leadingOffset, trailingOffset) + MDCTextInputDefaultPadding;
      break;
    case MDCTextInputTextInsetsModeIfContent: {
      // contentConditionalOffset will have the estimated text height for the largest underline
      // label that also has text.
      CGFloat contentConditionalOffset = 0;
      if (self.textInput.leadingUnderlineLabel.text.length) {
        contentConditionalOffset = leadingOffset;
      }
      if (self.textInput.trailingUnderlineLabel.text.length) {
        contentConditionalOffset = MAX(contentConditionalOffset, trailingOffset);
      }

      if (!MDCCGFloatEqual(contentConditionalOffset, 0)) {
        underlineOffset += contentConditionalOffset + MDCTextInputDefaultPadding;
      }
    } break;
    case MDCTextInputTextInsetsModeNever:
      break;
  }

  // .bottom = underlineOffset + the half padding ABOVE the line but below the text field
  // Legacy default has an additional padding here but this version does not.
  textInsets.bottom = underlineOffset + MDCTextInputDefaultPadding;

  return textInsets;
}

- (void)textInputDidLayoutSubviews {
  [self updateBorder];
}

- (void)textInputDidUpdateConstraints {
  if (self.isFloatingEnabled && _textInput.text.length > 0) {
    [self updatePlaceholderAnimationConstraints:YES];
  }
}

#pragma mark - UITextField & UITextView Notification Observation

- (void)textInputDidBeginEditing:(__unused NSNotification *)note {
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
    [self updateLayout];
    [self forceUpdatePlaceholderY];
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

- (void)textInputDidEndEditing:(__unused NSNotification *)note {
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

- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateFontsForDynamicType];
}

@end
