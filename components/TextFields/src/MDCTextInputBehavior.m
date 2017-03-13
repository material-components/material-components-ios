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

#import "MDCTextInputBehavior.h"

#import "MaterialAnimationTiming.h"
#import "MaterialPalettes.h"
#import "MaterialRTL.h"
#import "MaterialTypography.h"

#import "MDCTextInput.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputTitleView.h"

#pragma mark - Constants

static const CGFloat MDCTextInputHintTextOpacity = 0.54f;
// static const CGFloat MDCTextInputVerticalPadding = 16.f;
static const CGFloat MDCTextInputFloatingLabelFontSize = 12.f;
static const CGFloat MDCTextInputFloatingLabelTextHeight = 16.f;
static const CGFloat MDCTextInputFloatingLabelMargin = 8.f;
// static const CGFloat MDCTextInputFullWidthVerticalPadding = 20.f;
static const CGFloat MDCTextInputUnderlineActiveWidth = 4.f;
static const CGFloat MDCTextInputUnderlineNormalWidth = 2.f;

static const NSTimeInterval MDCTextInputFloatingPlaceholderAnimationDuration = 0.3f;
static const NSTimeInterval MDCTextInputDividerOutAnimationDuration = 0.266666f;

static NSString *const MDCTextInputBehaviorErrorColorKey = @"MDCTextInputBehaviorErrorColorKey";

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

@interface MDCTextInputBehavior ()

@property(nonatomic, assign) CGAffineTransform floatingPlaceholderScaleTransform;
@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;
@property(nonatomic, readonly) BOOL isPlaceholderUp;
@property(nonatomic, assign) CGRect placeholderDefaultPositionFrame;
@property(nonatomic, strong) NSArray<NSLayoutConstraint *> *placeholderAnimationConstraints;
@property(nonatomic, strong) UIColor *previousLeadingTextColor;
@property(nonatomic, strong) NSString *previousLeadingText;
@property(nonatomic, strong) UIColor *previousPlaceholderColor;
@property(nonatomic, strong) UIColor *previousTrailingTextColor;
@property(nonatomic, strong) UIColor *previousUnderlineColor;

@end

@implementation MDCTextInputBehavior

@synthesize characterCounter = _characterCounter;
@synthesize characterCountMax = _characterCountMax;
@synthesize presentationStyle = _presentationStyle;

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
  }

  return self;
}

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)textInput {
  self = [self init];
  if (self) {
    _textInput = textInput;
    _placeholderDefaultPositionFrame = textInput.frame;

    [self subscribeForNotifications];
    _textInput.underlineColor = MDCTextInputNormalUnderlineColor();
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.errorColor forKey:MDCTextInputBehaviorErrorColorKey];
  // TODO(larche) All properties
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextInputBehavior *copy = [[[self class] alloc] init];
  // TODO(larche) All properties
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

- (void)setPresentationStyle:(MDCTextInputPresentationStyle)presentationStyle {
  if (_presentationStyle != presentationStyle) {
    _presentationStyle = presentationStyle;

    [self updateCharacterCountMax];
    if (_presentationStyle == MDCTextInputPresentationStyleFullWidth) {
      self.textInput.underlineColor = [UIColor clearColor];
    }
    self.textInput.hidesPlaceholderOnInput =
    _presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder;
    [self.textInput setNeedsLayout];
  }
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  if (_textInput != textInput) {
    [self unsubscribeFromNotifications];
    _textInput = textInput;
    _placeholderDefaultPositionFrame = textInput.frame;
    [self subscribeForNotifications];
    [self updateCharacterCountMax];
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
    [self updateCharacterCountMax];
  }
}

- (void)setCharacterCountMax:(NSUInteger)characterCountMax {
  if (_characterCountMax != characterCountMax) {
    _characterCountMax = characterCountMax;
    [self updateCharacterCountMax];
  }
}

- (CGRect)characterMaxFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect characterMaxFrame = CGRectZero;
  characterMaxFrame.size = [self.textInput.trailingUnderlineLabel sizeThatFits:bounds.size];
  if ([self shouldLayoutForRTL]) {
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

- (CGSize)trailingUnderlineLabelSize {
  [self.textInput.trailingUnderlineLabel sizeToFit];
  return self.textInput.trailingUnderlineLabel.bounds.size;
}

- (void)updateCharacterCountMax {
  if (!self.characterCountMax) {
    self.textInput.trailingUnderlineLabel.text = nil;
    return;
  }

  NSString *text = [NSString stringWithFormat:@"%lu/%lu", (unsigned long)[self characterCount],
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

// TODO(larche) Add back in properly.
- (BOOL)shouldLayoutForRTL {
  return NO;
  //  return MDCShouldLayoutForRTL() && MDCRTLCanSupportFullMirroring();
}

#pragma mark - Placeholder Implementation

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

  // If there's an error, the view will already be up.
  // TODO(larche) Deal with error state check.
  if (isToUp) {
    destinationPosition = [self placeholderFloatingPositionFrame].origin;

    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.textInput
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:destinationPosition.y];
    NSLayoutConstraint *leading =
    [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.textInput
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:destinationPosition.x];
    self.placeholderAnimationConstraints = @[ top, leading ];

    animationBlock = ^{
      self.textInput.placeholderLabel.transform =
      self.floatingPlaceholderScaleTransform;

      self.textInput.placeholderLabel.textColor = self.textInput.tintColor;

      [self.textInput addConstraints:self.placeholderAnimationConstraints];
    };
  } else {
    animationBlock = ^{
      self.textInput.placeholderLabel.transform = CGAffineTransformIdentity;

      [self.textInput removeConstraints:self.placeholderAnimationConstraints];
    };
  }

  [UIView animateWithDuration:[CATransaction animationDuration]
                   animations:^{
                     animationBlock();
                     [self.textInput.placeholderLabel layoutIfNeeded];
                   } completion:^(BOOL finished) {
                     if (!isToUp) {
                       self.placeholderAnimationConstraints = nil;
                     }
                   }];
}

- (void)animatePlaceholderDown {
  if (self.presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder ||
      !self.isPlaceholderUp) {
    return;
  }

  // If there's an error, the view will already be up.
  // TODO(larche) Deal with error state check.
  if (self.textInput.text.length == 0) {
    [UIView animateWithDuration:[CATransaction animationDuration]
                     animations:^{
                       self.textInput.placeholderLabel.transform = CGAffineTransformIdentity;

                       [self.textInput removeConstraints:self.placeholderAnimationConstraints];
                       [self.textInput.placeholderLabel layoutIfNeeded];
                     } completion:^(BOOL finished) {
                       self.placeholderAnimationConstraints = nil;
                     }];
  }
}

- (CGRect)placeholderFloatingPositionFrame {
  CGRect placeholderRect = self.placeholderDefaultPositionFrame;
  if (CGRectIsEmpty(placeholderRect)) {
    return placeholderRect;
  }

  placeholderRect.origin.y -= MDCTextInputFloatingLabelMargin + MDCTextInputFloatingLabelTextHeight;

  // In RTL Layout, make the title view go up and to the right.
  if ([self shouldLayoutForRTL]) {
    placeholderRect.origin.x =
    CGRectGetWidth(self.textInput.bounds) -
    placeholderRect.size.width * self.floatingPlaceholderScaleTransform.a;
  }

  return placeholderRect;
}

#pragma mark - UITextField Notification Observation

- (void)textFieldDidBeginEditing:(NSNotification *)note {
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputFloatingPlaceholderAnimationDuration];
  [CATransaction
   setAnimationTimingFunction:[CAMediaTimingFunction
                               mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];

  // TODO(larche) Decide how best to handle underline changes.
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
    // TODO(larche) Consider how best to handle underline changes.
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
  [self updateCharacterCountMax];
}

#pragma mark - Public API

- (void)setErrorText:(NSString *)errorText
errorAccessibilityValue:(NSString *)errorAccessibilityValue {
  if (errorText &&
      ![self.previousLeadingText isEqualToString:self.textInput.leadingUnderlineLabel.text]) {
    self.previousLeadingText = self.textInput.leadingUnderlineLabel.text;
  }
  self.textInput.leadingUnderlineLabel.text = errorText ?: self.previousLeadingText;

  if (errorText &&
      ![self.previousLeadingTextColor isEqual:self.textInput.leadingUnderlineLabel.textColor] &&
      ![self.textInput.leadingUnderlineLabel.textColor isEqual:self.errorColor]) {
    self.previousLeadingTextColor = self.textInput.leadingUnderlineLabel.textColor;
  }
  self.textInput.leadingUnderlineLabel.textColor =
  errorText ? self.errorColor : self.previousLeadingTextColor;

  if (errorText &&
      ![self.previousTrailingTextColor isEqual:self.textInput.leadingUnderlineLabel.textColor] &&
      ![self.textInput.leadingUnderlineLabel.textColor isEqual:self.errorColor]) {
    self.previousTrailingTextColor = self.textInput.trailingUnderlineLabel.textColor;
  }
  self.textInput.trailingUnderlineLabel.textColor =
  errorText ? self.errorColor : self.previousTrailingTextColor;

  if (errorText &&
      ![self.previousUnderlineColor isEqual:self.textInput.underlineColor] &&
      ![self.textInput.underlineColor isEqual:self.errorColor]) {
    self.previousUnderlineColor = self.textInput.underlineColor;
  }
  self.textInput.underlineColor =
  errorText ? self.errorColor : self.previousUnderlineColor;

  if (errorText &&
      ![self.previousPlaceholderColor isEqual:self.textInput.placeholderLabel.textColor] &&
      ![self.textInput.placeholderLabel.textColor isEqual:self.errorColor]) {
    self.previousPlaceholderColor = self.textInput.placeholderLabel.textColor;
  }
  self.textInput.placeholderLabel.textColor =
  errorText ? self.errorColor : self.previousPlaceholderColor;
}

@end
