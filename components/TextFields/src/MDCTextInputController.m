/*
 Copyright 2016-present the Material Components for iOS authors. All Rights
 Reserved.

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

#import "MaterialAnimationTiming.h"
#import "MaterialPalettes.h"
#import "MaterialRTL.h"
#import "MaterialTypography.h"

#import "MDCTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputCharacterCounter.h"

#pragma mark - Constants

static const CGFloat MDCTextInputAlmostRequiredPriority = 999;
static const CGFloat MDCTextInputHintTextOpacity = 0.54f;
static const CGFloat MDCTextInputFloatingLabelFontSize = 12.f;
static const CGFloat MDCTextInputFloatingLabelTextHeight = 16.f;
static const CGFloat MDCTextInputFloatingLabelMargin = 8.f;
static const CGFloat MDCTextInputFullWidthHorizontalPadding = 16.f;
static const CGFloat MDCTextInputFullWidthVerticalPadding = 20.f;
static const CGFloat MDCTextInputUnderlineActiveWidth = 4.f;
static const CGFloat MDCTextInputUnderlineNormalWidth = 2.f;
static const CGFloat MDCTextInputVerticalPadding = 16.f;

static const NSTimeInterval MDCTextInputFloatingPlaceholderAnimationDuration = 0.3f;
static const NSTimeInterval MDCTextInputDividerOutAnimationDuration = 0.266666f;

static NSString *const MDCTextInputControllerErrorColorKey = @"MDCTextInputControllerErrorColorKey";

static inline CGFloat MDCFabs(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return fabs(value);
#else
  return fabsf(value);
#endif
}

static inline BOOL MDCFloatIsApproximatelyZero(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return (MDCFabs(value) < DBL_EPSILON);
#else
  return (MDCFabs(value) < FLT_EPSILON);
#endif
}

static inline UIColor *MDCTextInputInlinePlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputHintTextOpacity];
}

static inline UIColor *MDCTextInputNormalUnderlineColor() {
  return [UIColor lightGrayColor];
}

static inline UIColor *MDCTextInputTextErrorColor() {
  return [MDCPalette redPalette].tint500;
}

static inline CGFloat MDCTextInputTitleScaleFactor(UIFont *font) {
  CGFloat pointSize = [font pointSize];
  if (!MDCFloatIsApproximatelyZero(pointSize)) {
    return MDCTextInputFloatingLabelFontSize / pointSize;
  }

  return 1;
}

@interface MDCTextInputController ()

@property(nonatomic, assign) CGAffineTransform floatingPlaceholderScaleTransform;
@property(nonatomic, strong) NSLayoutConstraint *fullWidthCharacterCountConstraint;
@property(nonatomic, strong) NSLayoutConstraint *fullWidthHeightConstraint;
@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;
@property(nonatomic, assign) BOOL isDisplayingErrorText;
@property(nonatomic, readonly) BOOL isPlaceholderUp;
@property(nonatomic, assign) CGRect placeholderDefaultPositionFrame;
@property(nonatomic, strong) NSArray<NSLayoutConstraint *> *placeholderAnimationConstraints;
@property(nonatomic, strong) UIColor *previousLeadingTextColor;
@property(nonatomic, strong) NSString *previousLeadingText;
@property(nonatomic, strong) UIColor *previousPlaceholderColor;
@property(nonatomic, strong) UIColor *previousTrailingTextColor;
@property(nonatomic, strong) UIColor *previousUnderlineColor;

@end

@implementation MDCTextInputController

@synthesize characterCounter = _characterCounter;
@synthesize characterCountMax = _characterCountMax;
@synthesize presentationStyle = _presentationStyle;

// TODO: (larche): Support left icon view with a enum property for the icon / view to show.
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
    // commonInitialization sets up defaults in properties that should have been saved in this case.
    // TODO: (larche) All properties
  }

  return self;
}

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)textInput {
  self = [self init];
  if (self) {
    _textInput = textInput;
    if ([_textInput isKindOfClass:[UITextField class]]) {
      ((MDCTextField*)_textInput).positioningDelegate = self;
    }
    _placeholderDefaultPositionFrame = textInput.frame;

    [self subscribeForNotifications];
    _textInput.underlineColor = MDCTextInputNormalUnderlineColor();
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.errorColor forKey:MDCTextInputControllerErrorColorKey];
  // TODO: (larche) All properties
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextInputController *copy = [[[self class] alloc] init];
  // TODO: (larche) All properties
  return copy;
}

- (void)dealloc {
  [self unsubscribeFromNotifications];
}

- (void)commonInitialization {
  _floatingPlaceholderScaleTransform = CGAffineTransformIdentity;
  _internalCharacterCounter = [MDCTextInputAllCharactersCounter new];
  _errorColor = MDCTextInputTextErrorColor();
}

- (void)subscribeForNotifications {
  if (!_textInput) {
    return;
  }
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidBeginEditing:)
                        name:UITextFieldTextDidBeginEditingNotification
                      object:_textInput];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidEndEditing:)
                        name:UITextFieldTextDidEndEditingNotification
                      object:_textInput];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidChange:)
                        name:UITextFieldTextDidChangeNotification
                      object:_textInput];
}

- (void)unsubscribeFromNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self
                           name:UITextFieldTextDidBeginEditingNotification
                         object:_textInput];
  [defaultCenter removeObserver:self
                           name:UITextFieldTextDidEndEditingNotification
                         object:_textInput];
  [defaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:_textInput];
}

#pragma mark - Properties Implementation

- (void)setHelperText:(NSString *)helperText {
  if (self.isDisplayingErrorText) {
    self.previousLeadingText = helperText;
  } else {
    self.textInput.leadingUnderlineLabel.text = helperText;
  }
}

- (NSString *)helperText {
  if (self.isDisplayingErrorText) {
    return self.previousLeadingText;
  } else {
    return self.textInput.leadingUnderlineLabel.text;
  }
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

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  if (_textInput != textInput) {
    [self unsubscribeFromNotifications];
    _textInput = textInput;
    if ([_textInput isKindOfClass:[UITextField class]]) {
      ((MDCTextField*)_textInput).positioningDelegate = self;
    }

    _placeholderDefaultPositionFrame = textInput.placeholderLabel.frame;
    [self subscribeForNotifications];
    [self updateLayout];
  }
}

#pragma mark - Layout for Presentation Style

- (void)updateLayout {
  [self updateConstraints];
  [self updateLeadingUnderlineLabel];
  [self updateTrailingUnderlineLabel];
  [self updateUnderline];
}

- (void)updateConstraints {
  if (_presentationStyle == MDCTextInputPresentationStyleFullWidth) {
    if ([self.textInput isKindOfClass:[UITextView class]]) {
      if (!self.fullWidthCharacterCountConstraint) {
        self.fullWidthCharacterCountConstraint =
        [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput.trailingUnderlineLabel.superview
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:0];
      }
      [self.textInput.leadingUnderlineLabel
       setContentHuggingPriority:UILayoutPriorityRequired
       forAxis:UILayoutConstraintAxisVertical];
      [self.textInput.leadingUnderlineLabel
       setContentCompressionResistancePriority:UILayoutPriorityRequired
       forAxis:UILayoutConstraintAxisVertical];

      [self.textInput.trailingUnderlineLabel
       setContentCompressionResistancePriority:UILayoutPriorityRequired
       forAxis:UILayoutConstraintAxisVertical];

    } else {
      if (!self.fullWidthCharacterCountConstraint) {
        self.fullWidthCharacterCountConstraint =
        [NSLayoutConstraint constraintWithItem:self.textInput.trailingUnderlineLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
      }

      if (!self.fullWidthHeightConstraint) {
        self.fullWidthHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.textInput
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1
                                      constant:2 * MDCTextInputFullWidthVerticalPadding];
      }
      self.fullWidthHeightConstraint.active = YES;
    }

    [self.textInput.trailingUnderlineLabel
     setContentHuggingPriority:UILayoutPriorityRequired
     forAxis:UILayoutConstraintAxisVertical];
    [self placeholderYconstraint].priority = MDCTextInputAlmostRequiredPriority;
    self.fullWidthCharacterCountConstraint.active = YES;
  } else {
    self.fullWidthHeightConstraint.active = NO;

    [self placeholderYconstraint].priority = UILayoutPriorityDefaultLow;
    self.fullWidthCharacterCountConstraint.active = NO;
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
    [self updateTrailingUnderlineLabel];
  }
}

- (void)setCharacterCountMax:(NSUInteger)characterCountMax {
  if (_characterCountMax != characterCountMax) {
    _characterCountMax = characterCountMax;
    [self updateTrailingUnderlineLabel];
  }
}

- (CGRect)characterMaxFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect characterMaxFrame = CGRectZero;
  characterMaxFrame.size = [self.textInput.trailingUnderlineLabel sizeThatFits:bounds.size];
  if (self.textInput.mdc_effectiveUserInterfaceLayoutDirection ==
      UIUserInterfaceLayoutDirectionRightToLeft) {
    characterMaxFrame.origin.x = 0.0f;
  } else {
    characterMaxFrame.origin.x = CGRectGetMaxX(bounds) - CGRectGetWidth(characterMaxFrame);
  }

  // If its single line full width, position on the line.
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth &&
      ![self.textInput isKindOfClass:[UITextView class]]) {
    characterMaxFrame.origin.y = CGRectGetMidY(bounds) - CGRectGetHeight(characterMaxFrame) / 2.0f;
  } else {
    characterMaxFrame.origin.y = CGRectGetMaxY(bounds) - CGRectGetHeight(characterMaxFrame);
  }

  return characterMaxFrame;
}

#pragma mark - Leading Label Customization

- (void)updateLeadingUnderlineLabel {
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
    self.textInput.leadingUnderlineLabel.text = nil;
  }
}

#pragma mark - Placeholder Customization

- (void)updatePlaceholderAlpha {
  CGFloat opacity = 1;

  BOOL hidesPlaceholderOnInput = NO;
  if (self.textInput.text.length &&
      (self.presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder)) {
    opacity = 0;
    hidesPlaceholderOnInput = YES;
  }

  self.textInput.hidesPlaceholderOnInput = hidesPlaceholderOnInput;
  self.textInput.placeholderLabel.alpha = opacity;
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

  CGFloat scaleFactor = MDCTextInputTitleScaleFactor(self.textInput.placeholderLabel.font);
  self.floatingPlaceholderScaleTransform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);

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

    animationBlock = ^{
      self.textInput.placeholderLabel.transform = self.floatingPlaceholderScaleTransform;

      self.textInput.placeholderLabel.textColor = self.textInput.tintColor;
      [NSLayoutConstraint activateConstraints:self.placeholderAnimationConstraints];
    };
  } else {
    animationBlock = ^{
      self.textInput.placeholderLabel.transform = CGAffineTransformIdentity;

      [NSLayoutConstraint deactivateConstraints:self.placeholderAnimationConstraints];
    };
  }

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

  placeholderRect.origin.y -= MDCTextInputFloatingLabelMargin + MDCTextInputFloatingLabelTextHeight;

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

#pragma mark - Trailing Label Customization

- (CGSize)trailingUnderlineLabelSize {
  [self.textInput.trailingUnderlineLabel sizeToFit];
  return self.textInput.trailingUnderlineLabel.bounds.size;
}

- (void)updateTrailingUnderlineLabel {
  if (!self.characterCountMax) {
    self.textInput.trailingUnderlineLabel.text = nil;
    return;
  }

  NSString *text = [NSString stringWithFormat:@"%lu / %lu", (unsigned long)[self characterCount],
                    (unsigned long)self.characterCountMax];
  self.textInput.trailingUnderlineLabel.text = text;

  BOOL pastMax = [self characterCount] > self.characterCountMax;

  UIColor *textColor = MDCTextInputInlinePlaceholderTextColor();
  if (pastMax && self.textInput.isEditing) {
    textColor = self.errorColor;
  }

  self.textInput.trailingUnderlineLabel.textColor = textColor;
  [self.textInput.trailingUnderlineLabel sizeToFit];
}

#pragma mark - Underline Customization

- (void)updateUnderline {
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
    self.textInput.underlineColor = [UIColor clearColor];
  }
}

#pragma mark - UITextField Notification Observation

- (void)textFieldDidBeginEditing:(NSNotification *)note {
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputFloatingPlaceholderAnimationDuration];
  [CATransaction
   setAnimationTimingFunction:[CAMediaTimingFunction
                               mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];

  if (self.underlineViewMode != UITextFieldViewModeUnlessEditing &&
      self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
    self.textInput.underlineColor = self.textInput.tintColor;
    self.textInput.underlineWidth = MDCTextInputUnderlineActiveWidth;
  }

  if (self.presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder) {
    [self animatePlaceholderToUp:YES];
  }
  [CATransaction commit];
}

- (void)textFieldDidEndEditing:(NSNotification *)note {
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputDividerOutAnimationDuration];
  [CATransaction
   setAnimationTimingFunction:[CAMediaTimingFunction
                               mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];

  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
    self.textInput.underlineWidth = MDCTextInputUnderlineNormalWidth;

    UIColor *commonColor = self.textInput.leadingUnderlineLabel.textColor;
    self.textInput.placeholderLabel.textColor = commonColor;
    self.textInput.underlineColor = commonColor;
  }

  if (self.presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder) {
    [self animatePlaceholderToUp:NO];
  }
  [CATransaction commit];
}

- (void)textFieldDidChange:(NSNotification *)note {
  [self updatePlaceholderAlpha];
  [self updateTrailingUnderlineLabel];
}

#pragma mark - MDCTextFieldPositioningDelegate

- (CGRect)clearButtonRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  if (![self.textInput isKindOfClass:[UITextField class]]) {
    return CGRectZero;
  }

  MDCTextField *textField = (MDCTextField*)self.textInput;
  CGRect clearButtonRect = defaultRect;

  // Full width text boxes have their character count on the text input line
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth && self.characterCountMax) {
    if (self.textInput.mdc_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft){
      clearButtonRect.origin.x += CGRectGetWidth(textField.trailingUnderlineLabel.frame);
    } else {
      clearButtonRect.origin.x -= CGRectGetWidth(textField.trailingUnderlineLabel.frame);
    }
  }

  return clearButtonRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  if (![self.textInput isKindOfClass:[UITextField class]]) {
    return CGRectZero;
  }

  MDCTextField *textField = (MDCTextField*)self.textInput;
  CGRect editingRect = defaultRect;

  // Full width text fields have their clear button in the horizontal margin, but because the
  // internal implementation of textRect calls [super clearButtonRectForBounds:] in its
  // implementation, our modifications are not picked up. Adjust accordingly.
    if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
      editingRect.size.width += MDCTextInputFullWidthHorizontalPadding;
      // Full width text boxes have their character count on the text input line
      if (self.characterCountMax) {
        editingRect.size.width -= CGRectGetWidth(textField.trailingUnderlineLabel.frame);
        if (self.textInput.mdc_effectiveUserInterfaceLayoutDirection ==
            UIUserInterfaceLayoutDirectionRightToLeft) {
          editingRect.origin.x += CGRectGetWidth(textField.trailingUnderlineLabel.frame);
        }
      }
    }

  return editingRect;
}

- (UIEdgeInsets)textContainerInset:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textContainerInset = defaultInsets;
    switch (self.presentationStyle) {
      case MDCTextInputPresentationStyleDefault:
        break;
      case MDCTextInputPresentationStyleFloatingPlaceholder:
        textContainerInset.top = MDCTextInputVerticalPadding + MDCTextInputFloatingLabelTextHeight
        +
                                 MDCTextInputFloatingLabelMargin;
        textContainerInset.bottom = MDCTextInputVerticalPadding;
        break;
      case MDCTextInputPresentationStyleFullWidth:
        textContainerInset.top = MDCTextInputFullWidthVerticalPadding;
        textContainerInset.bottom = MDCTextInputFullWidthVerticalPadding;
        break;
    }
  
    // TODO: (larche) Check this removal of validator.
    // Adjust for the character limit and validator.
    // Full width single line text fields have their character counter on the same line as the
    //text.
    if ((self.characterCountMax) &&
        (self.presentationStyle != MDCTextInputPresentationStyleFullWidth || [self.textInput
        isKindOfClass:[UITextView class]])) {
      textContainerInset.bottom += CGRectGetHeight(self.textInput.trailingUnderlineLabel.frame);
    }
  
  return textContainerInset;
}

#pragma mark - Public API

- (void)setErrorText:(NSString *)errorText
errorAccessibilityValue:(NSString *)errorAccessibilityValue {
  // Here the 'magic' logic happens for error text:
  // When the user sets error text, we save the current state of their underline, leading text,
  // trailing text,
  // and placeholder text for both content and color. If error text is unset (nil) we reset to those
  // previous
  // values.

  // Leading Underline Label: Text
  if (errorText &&
      ![self.previousLeadingText isEqualToString:self.textInput.leadingUnderlineLabel.text]) {
    self.previousLeadingText = self.textInput.leadingUnderlineLabel.text;
  }
  self.textInput.leadingUnderlineLabel.text = errorText ?: self.previousLeadingText;

  // Leading Underline Label: Color
  if (errorText &&
      ![self.previousLeadingTextColor isEqual:self.textInput.leadingUnderlineLabel.textColor] &&
      ![self.textInput.leadingUnderlineLabel.textColor isEqual:self.errorColor]) {
    self.previousLeadingTextColor = self.textInput.leadingUnderlineLabel.textColor;
  }
  self.textInput.leadingUnderlineLabel.textColor =
  errorText ? self.errorColor : self.previousLeadingTextColor;

  // Trailing Underline Label: Color
  if (errorText &&
      ![self.previousTrailingTextColor isEqual:self.textInput.leadingUnderlineLabel.textColor] &&
      ![self.textInput.leadingUnderlineLabel.textColor isEqual:self.errorColor]) {
    self.previousTrailingTextColor = self.textInput.trailingUnderlineLabel.textColor;
  }
  self.textInput.trailingUnderlineLabel.textColor =
  errorText ? self.errorColor : self.previousTrailingTextColor;

  // Underline: Color
  if (errorText && ![self.previousUnderlineColor isEqual:self.textInput.underlineColor] &&
      ![self.textInput.underlineColor isEqual:self.errorColor]) {
    self.previousUnderlineColor = self.textInput.underlineColor;
  }
  self.textInput.underlineColor = errorText ? self.errorColor : self.previousUnderlineColor;

  // Placeholder Label: Color
  if (errorText &&
      ![self.previousPlaceholderColor isEqual:self.textInput.placeholderLabel.textColor] &&
      ![self.textInput.placeholderLabel.textColor isEqual:self.errorColor]) {
    self.previousPlaceholderColor = self.textInput.placeholderLabel.textColor;
  }
  self.textInput.placeholderLabel.textColor =
  errorText ? self.errorColor : self.previousPlaceholderColor;

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

@end
