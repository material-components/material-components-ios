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

#import "MDCTextInputControllerBase.h"
#import "private/MDCTextInputControllerBase+Subclassing.h"

#import "MDCMultilineTextField.h"
#import "MDCTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputBorderView.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputController.h"
#import "MDCTextInputControllerFloatingPlaceholder.h"
#import "MDCTextInputUnderlineView.h"

#import "MaterialAnimationTiming.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

#pragma mark - Constants

const CGFloat MDCTextInputControllerBaseDefaultBorderRadius = 4.f;
static const CGFloat MDCTextInputControllerBaseDefaultFloatingPlaceholderScaleDefault = 0.75f;
static const CGFloat MDCTextInputControllerBaseDefaultHintTextOpacity = 0.54f;
static const CGFloat MDCTextInputControllerBaseDefaultPadding = 8.f;

static const NSTimeInterval
    MDCTextInputControllerBaseDefaultFloatingPlaceholderDownAnimationDuration = 0.266666f;
static const NSTimeInterval
    MDCTextInputControllerBaseDefaultFloatingPlaceholderUpAnimationDuration = 0.3f;

static inline UIColor *MDCTextInputControllerBaseDefaultInlinePlaceholderTextColorDefault() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputControllerBaseDefaultHintTextOpacity];
}

static inline UIColor *MDCTextInputControllerBaseDefaultActiveColorDefault() {
  return [MDCPalette bluePalette].accent700;
}

static inline UIColor *MDCTextInputControllerBaseDefaultNormalUnderlineColorDefault() {
  return [UIColor lightGrayColor];
}

static inline UIColor *MDCTextInputControllerBaseDefaultTextErrorColorDefault() {
  return [MDCPalette redPalette].accent400;
}

#pragma mark - Class Properties

static BOOL _floatingEnabledDefault = YES;
static BOOL _mdc_adjustsFontForContentSizeCategoryDefault = NO;

static CGFloat _floatingPlaceholderScaleDefault =
    MDCTextInputControllerBaseDefaultFloatingPlaceholderScaleDefault;
static CGFloat _underlineHeightActiveDefault = 0;
static CGFloat _underlineHeightNormalDefault = 0;

static UIColor *_activeColorDefault;
static UIColor *_borderFillColorDefault;
static UIColor *_disabledColorDefault;
static UIColor *_errorColorDefault;
static UIColor *_floatingPlaceholderActiveColorDefault;
static UIColor *_floatingPlaceholderNormalColorDefault;
static UIColor *_inlinePlaceholderColorDefault;
static UIColor *_leadingUnderlineLabelTextColorDefault;
static UIColor *_normalColorDefault;
static UIColor *_trailingUnderlineLabelTextColorDefault;

static UIFont *_inlinePlaceholderFontDefault;
static UIFont *_leadingUnderlineLabelFontDefault;
static UIFont *_textInputFontDefault;
static UIColor *_textInputClearButtonTintColorDefault;
static UIFont *_trailingUnderlineLabelFontDefault;

static UIRectCorner _roundedCornersDefault = 0;

static UITextFieldViewMode _underlineViewModeDefault = UITextFieldViewModeWhileEditing;

@interface MDCTextInputControllerBase () {
  BOOL _mdc_adjustsFontForContentSizeCategory;

  MDCTextInputAllCharactersCounter *_characterCounter;

  NSNumber *_floatingPlaceholderScale;

  UIColor *_activeColor;
  UIColor *_borderFillColor;
  UIColor *_disabledColor;
  UIColor *_errorColor;
  UIColor *_floatingPlaceholderActiveColor;
  UIColor *_floatingPlaceholderNormalColor;
  UIColor *_inlinePlaceholderColor;
  UIColor *_leadingUnderlineLabelTextColor;
  UIColor *_normalColor;
  UIColor *_trailingUnderlineLabelTextColor;

  UIFont *_inlinePlaceholderFont;
  UIFont *_leadingUnderlineLabelFont;
  UIFont *_textInputFont;
  UIColor *_textInputClearButtonTintColor;
  UIFont *_trailingUnderlineLabelFont;

  UIRectCorner _roundedCorners;
}

@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;

@property(nonatomic, copy) NSArray<NSLayoutConstraint *> *placeholderAnimationConstraints;

@property(nonatomic, strong) NSLayoutConstraint *placeholderAnimationConstraintLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderAnimationConstraintTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderAnimationConstraintTrailing;

@property(nonatomic, copy) NSString *errorAccessibilityValue;
@property(nonatomic, copy, readwrite) NSString *errorText;
@property(nonatomic, copy) NSString *helperAccessibilityLabel;
@property(nonatomic, copy) NSString *previousLeadingText;

@end

@implementation MDCTextInputControllerBase

@synthesize characterCountMax = _characterCountMax;
@synthesize characterCountViewMode = _characterCountViewMode;
@synthesize floatingEnabled = _floatingEnabled;
@synthesize roundedCorners = _roundedCorners;
@synthesize textInput = _textInput;
@synthesize underlineHeightActive = _underlineHeightActive;
@synthesize underlineHeightNormal = _underlineHeightNormal;
@synthesize underlineViewMode = _underlineViewMode;

// TODO: (larche): Support in-line auto complete.

- (instancetype)init {
  self = [super init];
  if (self) {
    if ([self isMemberOfClass:[MDCTextInputControllerBase class]]) {
      NSLog(@"NOTE: MDCTextInputControllerBase is a base class meant to be subclassed.\nFor more"
             "information, see the README.md file");
    }
    [self commonMDCTextInputControllerBaseInitialization];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonMDCTextInputControllerBaseInitialization];

    // This should happen last because it relies on the state of a ton of properties.
    [self setupInput];
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

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCTextInputControllerBase *copy = [[[self class] alloc] init];

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
  copy.floatingPlaceholderActiveColor = self.floatingPlaceholderActiveColor;
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
  copy.underlineHeightActive = self.underlineHeightActive;
  copy.underlineHeightNormal = self.underlineHeightNormal;
  copy.underlineViewMode = self.underlineViewMode;

  return copy;
}

- (void)dealloc {
  [self unsubscribeFromNotifications];
}

- (void)commonMDCTextInputControllerBaseInitialization {
  _roundedCorners = [self class].roundedCornersDefault;
  _characterCountViewMode = UITextFieldViewModeAlways;
  _disabledColor = [self class].disabledColorDefault;
  _expandsOnOverflow = YES;
  _floatingEnabled = [self class].isFloatingEnabledDefault;
  _internalCharacterCounter = [[MDCTextInputAllCharactersCounter alloc] init];
  _minimumLines = 1;
  _underlineHeightActive = [self class].underlineHeightActiveDefault;
  _underlineHeightNormal = [self class].underlineHeightNormalDefault;
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
  _textInput.textInsetsMode = [self textInsetModeDefault];

  if ([_textInput conformsToProtocol:@protocol(MDCMultilineTextInput)] &&
      [_textInput respondsToSelector:@selector(setMinimumLines:)]) {
    ((id<MDCMultilineTextInput>)_textInput).minimumLines = self.minimumLines;
  }

  if ([_textInput conformsToProtocol:@protocol(MDCMultilineTextInput)] &&
      [_textInput respondsToSelector:@selector(setExpandsOnOverflow:)]) {
    ((id<MDCMultilineTextInput>)_textInput).expandsOnOverflow = self.expandsOnOverflow;
  }

  [self subscribeForNotifications];
  _textInput.underline.color = [self class].normalColorDefault;
  _textInput.clearButton.tintColor = self.textInputClearButtonTintColor;
  [self forceUpdatePlaceholderY];
}

- (MDCTextInputTextInsetsMode)textInsetModeDefault {
  return MDCTextInputTextInsetsModeAlways;
}

- (void)subscribeForNotifications {
  if (!_textInput) {
    return;
  }
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

  [defaultCenter addObserver:self
                    selector:@selector(textInputDidToggleEnabled:)
                        name:MDCTextInputDidToggleEnabledNotification
                      object:_textInput];

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

  [defaultCenter addObserver:self
                    selector:@selector(textInputDidChange:)
                        name:MDCTextFieldTextDidSetTextNotification
                      object:_textInput];
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
  return [UIBezierPath
      bezierPathWithRoundedRect:borderBound
              byRoundingCorners:self.roundedCorners
                    cornerRadii:CGSizeMake(MDCTextInputControllerBaseDefaultBorderRadius,
                                           MDCTextInputControllerBaseDefaultBorderRadius)];
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

#pragma mark - Cursor Customization

- (void)updateCursor {
  self.textInput.cursorColor = (self.isDisplayingErrorText || self.isDisplayingCharacterCountError)
                                   ? self.errorColor
                                   : self.activeColor;
}

#pragma mark - Leading Label Customization

- (void)updateLeadingUnderlineLabel {
  UIFont *font = self.leadingUnderlineLabelFont;
  if (self.mdc_adjustsFontForContentSizeCategory) {
    // TODO: (#4331) This needs to be converted to the new text scheme.
    font = [font mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleCaption
                              scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  }
  self.textInput.leadingUnderlineLabel.font = font;

  self.textInput.leadingUnderlineLabel.textColor =
      (self.isDisplayingErrorText || self.isDisplayingCharacterCountError)
          ? self.errorColor
          : self.leadingUnderlineLabelTextColor;
}

#pragma  mark - TextInput Customization

- (void)updateTextInput {
  UIFont *font = self.textInputFont;
  if (self.mdc_adjustsFontForContentSizeCategory) {
    font = [font mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                              scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
    // TODO: (#4331) This needs to be converted to the new text scheme.
  }
  self.textInput.font = font;
}

#pragma mark - Placeholder Customization

// This updates the placeholder's visual characteristics and not its layout. See the section
// "Placeholder Floating" for methods that update the layout.
- (void)updatePlaceholder {
  UIFont *placeHolderFont = self.inlinePlaceholderFont;
  if (self.mdc_adjustsFontForContentSizeCategory) {
    // TODO: (#4331) This needs to be converted to the new text scheme.
    placeHolderFont =
        [placeHolderFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleBody1
                                      scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];

  }

  // Aside from not wanting to kick off extra work for setting a font that hasn't changed, we use
  // this custom equality check to prevent an edge case that caused a 1 pixel change in width even
  // when the important parts of the new font were the same as the existing font.
  if (![self.textInput.placeholderLabel.font mdc_isSimplyEqual:placeHolderFont]){
    self.textInput.placeholderLabel.font = placeHolderFont;
  }

  UIColor *placeholderColor;
  if ([self isPlaceholderUp]) {
    UIColor *nonErrorColor =
        self.textInput.isEditing
                           ? self.floatingPlaceholderActiveColor
                           : self.floatingPlaceholderNormalColor;
    placeholderColor = (self.isDisplayingCharacterCountError || self.isDisplayingErrorText)
                           ? self.errorColor
                           : nonErrorColor;
  } else {
    placeholderColor = self.textInput.isEditing ? self.activeColor : self.inlinePlaceholderColor;
  }
  if (!self.textInput.isEnabled) {
    placeholderColor = self.disabledColor;
  }
  self.textInput.placeholderLabel.textColor = placeholderColor;
}

#pragma mark - Placeholder Floating

// 'Up' in these methods always means the placeholder is floating; it's .y is smaller and it's not
// 'inline' with the text input. The placeholder also doesn't disappear when you type since it's
// functioning as a title label when 'up'.

- (void)movePlaceholderToUp:(BOOL)isToUp {
  if ([self isPlaceholderUp] == isToUp) {
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
  [self updatePlaceholderAnimationConstraints:isToUp];
  [UIView animateWithDuration:[CATransaction animationDuration]
      animations:^{
        self.textInput.placeholderLabel.transform = scaleTransform;
        [self updatePlaceholder];
        [self updateBorder];
        [self.textInput layoutIfNeeded];
      }
      completion:^(__unused BOOL finished) {
        if (!isToUp) {
          [self cleanupPlaceholderAnimationConstraints];
        }
      }];
}

- (BOOL)isPlaceholderUp {
  return self.placeholderAnimationConstraints.count > 0 &&
         !CGAffineTransformEqualToTransform(self.textInput.placeholderLabel.transform,
                                            CGAffineTransformIdentity);
}

// Sometimes we set up the animation constraints for floating up before we have a width for the text
// field. Since there is math that needs to compensate for the transform in relation to the width,
// we update the constants on the constraints.
//
// Note: this method is not called inside updateLayout.
- (void)updatePlaceholderAnimationConstraints:(BOOL)isToUp {
  if (isToUp) {
    UIOffset offset = [self floatingPlaceholderOffset];

    // Remember, the insets are always in LTR. It's automatically flipped when used in RTL.
    // See MDCTextInputController.h.
    UIEdgeInsets insets = self.textInput.textInsets;

    CGFloat leadingConstant =
        [self floatingPlaceholderAnimationConstraintLeadingConstant:insets offset:offset];
    if (!self.placeholderAnimationConstraintLeading) {
      self.placeholderAnimationConstraintLeading =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1
                                        constant:leadingConstant];
    }
    self.placeholderAnimationConstraintLeading.constant = leadingConstant;

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

    CGFloat trailingConstant =
        [self floatingPlaceholderAnimationConstraintTrailingConstant:insets offset:offset];
    if (!self.placeholderAnimationConstraintTrailing) {
      self.placeholderAnimationConstraintTrailing =
          [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                       attribute:NSLayoutAttributeTrailing
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:self.textInput
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1
                                        constant:trailingConstant];
      self.placeholderAnimationConstraintTrailing.priority = UILayoutPriorityDefaultHigh - 1;
    }
    self.placeholderAnimationConstraintTrailing.constant = trailingConstant;

    self.placeholderAnimationConstraints = @[
      self.placeholderAnimationConstraintLeading, self.placeholderAnimationConstraintTop,
      self.placeholderAnimationConstraintTrailing
    ];
    [NSLayoutConstraint activateConstraints:self.placeholderAnimationConstraints];
  } else {
    [NSLayoutConstraint deactivateConstraints:self.placeholderAnimationConstraints];
  }
}

// Sometimes we set up the animation constraints for floating up before we have a width for the text
// field. Since there is math that needs to compensate for the transform in relation to the width,
// we check to see if the constraints still have the correct constants.
- (BOOL)needsUpdatePlaceholderAnimationConstraintsToUp {
  if (![self isPlaceholderUp]) {
    return NO;
  }

  // Remember, the insets are always in LTR. It's automatically flipped when used in RTL.
  // See MDCTextInputController.h.
  UIEdgeInsets insets = self.textInput.textInsets;

  UIOffset offset = [self floatingPlaceholderOffset];

  CGFloat leadingConstant =
      [self floatingPlaceholderAnimationConstraintLeadingConstant:insets offset:offset];
  CGFloat trailingConstant =
      [self floatingPlaceholderAnimationConstraintTrailingConstant:insets offset:offset];

  return self.placeholderAnimationConstraintLeading.constant != leadingConstant &&
         self.placeholderAnimationConstraintTrailing.constant != trailingConstant;
}

// When placeholder is not up, it just uses the layout code that comes for free from the text field
// itself. That means these constraints need go away. So, we can use the existence of them as a
// way to check if the placeholder is floating up. See isplaceholderUp.
- (void)cleanupPlaceholderAnimationConstraints {
  self.placeholderAnimationConstraints = nil;
  self.placeholderAnimationConstraintLeading = nil;
  self.placeholderAnimationConstraintTop = nil;
  self.placeholderAnimationConstraintTrailing = nil;
}

// Sometimes the text field is not showing the correct layout for its values (like when it's created
// with .text already entered) so we make sure it's in the right place always.
//
// Note that this calls updateLayout inside it so it is not included in updateLayout.
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

// The placeholder has a simple scale transform on it. The default is to reduce the size by 25%.
// Unfortunately, auto layout has no concept of compensating for transforms and it keeps the same
// alignmentRect as if it weren't transformed at all. That gives the impression the placeholder,
// when floating up, is too far to the trailing side. This offset is part of a compensation for
// that. It calculates the amount of space between the alignmentRect's sides and the actual shrunken
// placeholder label.
- (UIOffset)floatingPlaceholderOffset {
  CGFloat vertical = MDCTextInputControllerBaseDefaultPadding;

  // Offsets needed due to transform working on normal (0.5,0.5) anchor point.
  // Why no anchor point of (0,0)? Because autolayout doesn't play well with anchor points.
  vertical -= self.textInput.placeholderLabel.font.lineHeight *
              (1 - (CGFloat)self.floatingPlaceholderScale.floatValue) * .5f;

  // Remember, the insets are always in LTR. It's automatically flipped when used in RTL.
  // See MDCTextInputController.h.
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

// Remember, the insets are always in LTR. It's automatically flipped when used in RTL.
// See MDCTextInputController.h.
- (CGFloat)floatingPlaceholderAnimationConstraintLeadingConstant:(UIEdgeInsets)textInsets
                                                          offset:(UIOffset)offset {
  CGFloat constant = textInsets.left - offset.horizontal;
  return constant;
}

// Remember, the insets are always in LTR. It's automatically flipped when used in RTL.
// See MDCTextInputController.h.
- (CGFloat)floatingPlaceholderAnimationConstraintTrailingConstant:(UIEdgeInsets)textInsets
                                                           offset:(UIOffset)offset {
  CGFloat constant = offset.horizontal - textInsets.right;
  return constant;
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
      underlineHeight = self.underlineHeightActive;
      break;
    case UITextFieldViewModeWhileEditing:
      underlineColor = self.textInput.isEditing ? self.activeColor : self.normalColor;
      underlineHeight =
          self.textInput.isEditing ? self.underlineHeightActive : self.underlineHeightNormal;
      break;
    case UITextFieldViewModeUnlessEditing:
      underlineColor = !self.textInput.isEditing ? self.activeColor : self.normalColor;
      underlineHeight =
          !self.textInput.isEditing ? self.underlineHeightActive : self.underlineHeightNormal;
      break;
    case UITextFieldViewModeNever:
    default:
      underlineColor = self.normalColor;
      underlineHeight = self.underlineHeightNormal;
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
  return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleBody1];
  // TODO: (#4331) This needs to be converted to the new text scheme.
}

+ (UIFont *)underlineLabelsFont {
  // TODO: (#4331) This needs to be converted to the new text scheme.
  return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];
}

#pragma mark - Properties Implementation

- (UIColor *)activeColor {
  return _activeColor ? _activeColor : [self class].activeColorDefault;
}

- (void)setActiveColor:(UIColor *)activeColor {
  if (![_activeColor isEqual:activeColor]) {
    _activeColor = activeColor;
    [self updateLayout];
  }
}

+ (UIColor *)activeColorDefault {
  if (!_activeColorDefault) {
    _activeColorDefault = MDCTextInputControllerBaseDefaultActiveColorDefault();
  }
  return _activeColorDefault;
}

+ (void)setActiveColorDefault:(UIColor *)activeColorDefault {
  _activeColorDefault = activeColorDefault ? activeColorDefault
                                           : MDCTextInputControllerBaseDefaultActiveColorDefault();
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
    _disabledColor = disabledColor ? disabledColor
                                   : [self class].disabledColorDefault;
    [self updateLayout];
  }
}

+ (UIColor *)disabledColorDefault {
  if (!_disabledColorDefault) {
    _disabledColorDefault = MDCTextInputControllerBaseDefaultNormalUnderlineColorDefault();
  }
  return _disabledColorDefault;
}

+ (void)setDisabledColorDefault:(UIColor *)disabledColorDefault {
  _disabledColorDefault = disabledColorDefault
                              ? disabledColorDefault
                              : MDCTextInputControllerBaseDefaultNormalUnderlineColorDefault();
}

// This is when the character count text is red because the inputted text has more characters than
// the characterCountMax allows.
- (BOOL)isDisplayingCharacterCountError {
  return self.characterCountMax && [self characterCount] > self.characterCountMax;
}

- (BOOL)isDisplayingErrorText {
  return self.errorText != nil;
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
    _errorColorDefault = MDCTextInputControllerBaseDefaultTextErrorColorDefault();
  }
  return _errorColorDefault;
}

+ (void)setErrorColorDefault:(UIColor *)errorColorDefault {
  _errorColorDefault = errorColorDefault ? errorColorDefault
                                         : MDCTextInputControllerBaseDefaultTextErrorColorDefault();
}

- (void)setErrorText:(NSString *)errorText {
  _errorText = [errorText copy];
}

- (void)setExpandsOnOverflow:(BOOL)expandsOnOverflow {
  if (_expandsOnOverflow != expandsOnOverflow) {
    _expandsOnOverflow = expandsOnOverflow;
    if ([_textInput conformsToProtocol:@protocol(MDCMultilineTextInput)] &&
        [_textInput respondsToSelector:@selector(setExpandsOnOverflow:)]) {
      ((id<MDCMultilineTextInput>)_textInput).expandsOnOverflow = expandsOnOverflow;
    }
  }
}
- (UIColor *)floatingPlaceholderActiveColor {
  return _floatingPlaceholderActiveColor ? _floatingPlaceholderActiveColor
  : [self class].floatingPlaceholderActiveColorDefault;
}

- (void)setFloatingPlaceholderActiveColor:(UIColor *)floatingPlaceholderActiveColor {
  if (![_floatingPlaceholderActiveColor isEqual:floatingPlaceholderActiveColor]) {
    _floatingPlaceholderActiveColor = floatingPlaceholderActiveColor;
    [self updatePlaceholder];
  }
}

+ (UIColor *)floatingPlaceholderActiveColorDefault {
  if (!_floatingPlaceholderActiveColorDefault) {
    _floatingPlaceholderActiveColorDefault = [self class].activeColorDefault;
  }
  return _floatingPlaceholderActiveColorDefault;
}

+ (void)setFloatingPlaceholderActiveColorDefault:(UIColor *)floatingPlaceholderActiveColorDefault {
  _floatingPlaceholderActiveColorDefault = floatingPlaceholderActiveColorDefault
  ? floatingPlaceholderActiveColorDefault
  : [self class].activeColorDefault;
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
  if (_floatingPlaceholderScale == nil) {
    _floatingPlaceholderScale =
        [NSNumber numberWithFloat:(float)[self class].floatingPlaceholderScaleDefault];
  }
  return _floatingPlaceholderScale;
}

- (void)setFloatingPlaceholderScale:(NSNumber *)floatingPlaceholderScale {
  if (![_floatingPlaceholderScale isEqualToNumber:floatingPlaceholderScale]) {
    _floatingPlaceholderScale =
        (floatingPlaceholderScale != nil)
            ? floatingPlaceholderScale
            : [NSNumber numberWithFloat:(float)[self class].floatingPlaceholderScaleDefault];

    [self updatePlaceholder];
    [self.textInput setNeedsUpdateConstraints];
  }
}

+ (CGFloat)floatingPlaceholderScaleDefault {
  return _floatingPlaceholderScaleDefault;
}

+ (void)setFloatingPlaceholderScaleDefault:(CGFloat)floatingPlaceholderScaleDefault {
  _floatingPlaceholderScaleDefault = floatingPlaceholderScaleDefault;
  if (floatingPlaceholderScaleDefault <= 0) {
    _floatingPlaceholderScaleDefault =
        MDCTextInputControllerBaseDefaultFloatingPlaceholderScaleDefault;
  }
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
        MDCTextInputControllerBaseDefaultInlinePlaceholderTextColorDefault();
  }
  return _inlinePlaceholderColorDefault;
}

+ (void)setInlinePlaceholderColorDefault:(UIColor *)inlinePlaceholderColorDefault {
  _inlinePlaceholderColorDefault =
      inlinePlaceholderColorDefault
          ? inlinePlaceholderColorDefault
          : MDCTextInputControllerBaseDefaultInlinePlaceholderTextColorDefault();
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
    _leadingUnderlineLabelTextColorDefault =
        MDCTextInputControllerBaseDefaultInlinePlaceholderTextColorDefault();
  }
  return _leadingUnderlineLabelTextColorDefault;
}

+ (void)setLeadingUnderlineLabelTextColorDefault:(UIColor *)leadingUnderlineLabelTextColorDefault {
  _leadingUnderlineLabelTextColorDefault =
      leadingUnderlineLabelTextColorDefault
          ? leadingUnderlineLabelTextColorDefault
          : MDCTextInputControllerBaseDefaultInlinePlaceholderTextColorDefault();
}

- (void)setMinimumLines:(NSUInteger)minimumLines {
  if (_minimumLines != minimumLines) {
    _minimumLines = minimumLines;
    if ([_textInput conformsToProtocol:@protocol(MDCMultilineTextInput)] &&
        [_textInput respondsToSelector:@selector(setMinimumLines:)]) {
      ((id<MDCMultilineTextInput>)_textInput).minimumLines = minimumLines;
    }
  }
}

- (UIColor *)normalColor {
  return _normalColor ? _normalColor : [self class].normalColorDefault;
}

- (void)setNormalColor:(UIColor *)normalColor {
  if (![_normalColor isEqual:normalColor]) {
    _normalColor = normalColor;
    [self updateLayout];
  }
}

+ (UIColor *)normalColorDefault {
  if (!_normalColorDefault) {
    _normalColorDefault = MDCTextInputControllerBaseDefaultNormalUnderlineColorDefault();
  }
  return _normalColorDefault;
}

+ (void)setNormalColorDefault:(UIColor *)normalColorDefault {
  _normalColorDefault = normalColorDefault
                            ? normalColorDefault
                            : MDCTextInputControllerBaseDefaultNormalUnderlineColorDefault();
}

- (NSString *)placeholderText {
  return _textInput.placeholder;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
  if ([_textInput.placeholder isEqualToString:placeholderText]) {
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
        MDCTextInputControllerBaseDefaultInlinePlaceholderTextColorDefault();
  }
  return _trailingUnderlineLabelTextColorDefault;
}

+ (void)setTrailingUnderlineLabelTextColorDefault:
        (UIColor *)trailingUnderlineLabelTextColorDefault {
  _trailingUnderlineLabelTextColorDefault =
      trailingUnderlineLabelTextColorDefault
          ? trailingUnderlineLabelTextColorDefault
          : MDCTextInputControllerBaseDefaultInlinePlaceholderTextColorDefault();
}

- (void)setUnderlineHeightActive:(CGFloat)underlineHeightActive {
  if (_underlineHeightActive != underlineHeightActive) {
    _underlineHeightActive = underlineHeightActive;
    [self updateLayout];
  }
}

+ (CGFloat)underlineHeightActiveDefault {
  return _underlineHeightActiveDefault;
}

+ (void)setUnderlineHeightActiveDefault:(CGFloat)underlineHeightActiveDefault {
  _underlineHeightActiveDefault = underlineHeightActiveDefault;
}

- (void)setUnderlineHeightNormal:(CGFloat)underlineHeightNormal {
  if (_underlineHeightNormal != underlineHeightNormal) {
    _underlineHeightNormal = underlineHeightNormal;
    [self updateLayout];
  }
}

+ (CGFloat)underlineHeightNormalDefault {
  return _underlineHeightNormalDefault;
}

+ (void)setUnderlineHeightNormalDefault:(CGFloat)underlineHeightNormalDefault {
  _underlineHeightNormalDefault = underlineHeightNormalDefault;
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

  [self updateCursor];
  [self updatePlaceholder];
  [self updateLeadingUnderlineLabel];
  [self updateTrailingUnderlineLabel];
  [self updateTextInput];
  [self updateUnderline];
  [self updateBorder];
}

#pragma mark - MDCTextFieldPositioningDelegate

// clang-format off
/**
 textInsets: is the source of truth for vertical layout. It's used to figure out the proper
 height and also where to place the placeholder / text field.

 NOTE: It's applied before the textRect is flipped for RTL. So all calculations are done here à la
 LTR.

 The vertical layout is, at most complex, this form:
 MDCTextInputControllerBaseDefaultPadding                             // Top padding
 MDCRint(self.textInput.placeholderLabel.font.lineHeight * scale)     // Placeholder when up
 MDCTextInputControllerBaseDefaultPadding                             // Padding
 MDCCeil(MAX(self.textInput.font.lineHeight,                          // Text field or placeholder
             self.textInput.placeholderLabel.font.lineHeight))
 MDCTextInputControllerBaseDefaultPadding                             // Padding to underline
 --Underline--                                                        // Underline (height not counted)
 underlineLabelsOffset                                                // Depends on text insets mode
 */
// clang-format on
- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  // NOTE: UITextFields have a centerY based layout. And you can change EITHER the height or the Y.
  // Not both. Don't know why. So, we have to leave the text rect as big as the bounds and move it
  // to a Y that works. In other words, no bottom inset will make a difference here for UITextFields
  UIEdgeInsets textInsets = defaultInsets;

  if (!self.isFloatingEnabled) {
    return textInsets;
  }

  textInsets.top = MDCTextInputControllerBaseDefaultPadding +
                   MDCRint(self.textInput.placeholderLabel.font.lineHeight *
                           (CGFloat)self.floatingPlaceholderScale.floatValue) +
                   MDCTextInputControllerBaseDefaultPadding;

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat leadingOffset =
      MDCCeil(self.textInput.leadingUnderlineLabel.font.lineHeight * scale) / scale;
  CGFloat trailingOffset =
      MDCCeil(self.textInput.trailingUnderlineLabel.font.lineHeight * scale) / scale;

  // The amount of space underneath the underline is variable. It could just be
  // MDCTextInputControllerBaseDefaultPadding or the biggest estimated underlineLabel height +
  // MDCTextInputControllerBaseDefaultPadding. It's also dependent on the .textInsetsMode.
  CGFloat underlineOffset = 0;
  switch (self.textInput.textInsetsMode) {
    case MDCTextInputTextInsetsModeAlways:
      underlineOffset +=
          MAX(leadingOffset, trailingOffset) + MDCTextInputControllerBaseDefaultPadding;
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
        underlineOffset += contentConditionalOffset + MDCTextInputControllerBaseDefaultPadding;
      }
    } break;
    case MDCTextInputTextInsetsModeNever:
      break;
  }

  // .bottom = underlineOffset + MDCTextInputControllerBaseDefaultPadding
  // Legacy default has an additional padding here but this version does not.
  textInsets.bottom = underlineOffset + MDCTextInputControllerBaseDefaultPadding;

  return textInsets;
}

- (void)textInputDidLayoutSubviews {
  [self updateBorder];

  if ([self needsUpdatePlaceholderAnimationConstraintsToUp]) {
    [self updatePlaceholderAnimationConstraints:YES];
  }
}

- (void)textInputDidUpdateConstraints {
  if (self.isFloatingEnabled && _textInput.text.length > 0) {
    [self updatePlaceholderAnimationConstraints:YES];
  }
}

#pragma mark - UITextField & UITextView Notification Observation

- (void)textInputDidBeginEditing:(__unused NSNotification *)note {
  [CATransaction begin];
  [CATransaction
      setAnimationDuration:MDCTextInputControllerBaseDefaultFloatingPlaceholderUpAnimationDuration];
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

- (void)textInputDidToggleEnabled:(NSNotification *)notification {
  if (notification.object != self.textInput) {
    return;
  }
  [self updateLayout];
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
  [CATransaction setAnimationDuration:
                     MDCTextInputControllerBaseDefaultFloatingPlaceholderDownAnimationDuration];
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
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.textInput.leadingUnderlineLabel);
  } else {
    self.textInput.accessibilityValue = nil;
    if ([self.textInput.leadingUnderlineLabel.text isEqualToString:self.helperText]) {
      self.textInput.leadingUnderlineLabel.accessibilityLabel = self.helperAccessibilityLabel;
    } else {
      self.textInput.leadingUnderlineLabel.accessibilityLabel = nil;
    }
  }
}

-(void)setHelperText:(NSString *)helperText
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
