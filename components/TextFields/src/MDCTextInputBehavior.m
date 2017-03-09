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
//static const CGFloat MDCTextInputVerticalPadding = 16.f;
//static const CGFloat MDCTextInputFloatingLabelFontSize = 12.f;
static const CGFloat MDCTextInputFloatingLabelTextHeight = 16.f;
static const CGFloat MDCTextInputFloatingLabelMargin = 8.f;
//static const CGFloat MDCTextInputFullWidthVerticalPadding = 20.f;
//static const CGFloat MDCTextInputValidationMargin = 8.f;
//
//static const NSTimeInterval MDCTextInputAnimationDuration = 0.3f;
static const NSTimeInterval MDCTextInputDividerOutAnimationDuration = 0.266666f;

static NSString *const MDCTextInputBehaviorErrorColorKey = @"MDCTextInputBehaviorErrorColorKey";

//static inline CGFloat MDCFabs(CGFloat value) {
//#if CGFLOAT_IS_DOUBLE
//  return fabs(value);
//#else
//  return fabsf(value);
//#endif
//}
//
//
//static inline BOOL MDCFloatIsApproximatelyZero(CGFloat value) {
//#if CGFLOAT_IS_DOUBLE
//  return (MDCFabs(value) < DBL_EPSILON);
//#else
//  return (MDCFabs(value) < FLT_EPSILON);
//#endif
//}


static inline UIColor *MDCTextInputInlinePlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputHintTextOpacity];
}

//static inline UIColor *MDCTextInputUnderlineColor() {
//  return [UIColor lightGrayColor];
//}

static inline UIColor *MDCTextInputTextErrorColor() {
  return [MDCPalette redPalette].tint500;
}

//static inline CGFloat MDCTextInputTitleScaleFactor(UIFont *font) {
//  CGFloat pointSize = [font pointSize];
//  if (!MDCFloatIsApproximatelyZero(pointSize)) {
//    return MDCTextInputFloatingLabelFontSize / pointSize;
//  }
//
//  return 1;
//}

@interface MDCTextInputBehavior ()

@property(nonatomic, assign) CGAffineTransform floatingPlaceholderScaleTransform;
@property(nonatomic, strong) MDCTextInputTitleView *titleView;
@property(nonatomic, strong) MDCTextInputAllCharactersCounter *internalCharacterCounter;

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
    [self subscribeForNotifications];
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
  [defaultCenter removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:_textInput];
  [defaultCenter removeObserver:self name:UITextFieldTextDidEndEditingNotification object:_textInput];
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
    [self.textInput setNeedsLayout];
  }
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  if (_textInput != textInput) {
    [self unsubscribeFromNotifications];
    _textInput = textInput;
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
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth && ![self.textInput isKindOfClass:[UITextView class]]) {
    characterMaxFrame.origin.y =
    CGRectGetMidY(bounds) - CGRectGetHeight(characterMaxFrame) / 2.0f;
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

  NSString *text = [NSString stringWithFormat:
                    @"%lu/%lu", (unsigned long)[self characterCount], (unsigned long)self.characterCountMax];
  self.textInput.trailingUnderlineLabel.text = text;

  BOOL pastMax = [self characterCount] > self.characterCountMax;

  UIColor *textColor = MDCTextInputInlinePlaceholderTextColor();
  if (pastMax && self.textInput.isEditing) {
    textColor = self.errorColor;
  }

  self.textInput.trailingUnderlineLabel.textColor = textColor;
  [self.textInput.trailingUnderlineLabel sizeToFit];


//  [self.textInput.underlineView setErroneous:pastMax];
}

// TODO(larche) Add back in properly.
- (BOOL)shouldLayoutForRTL {
  return NO;
  //  return MDCShouldLayoutForRTL() && MDCRTLCanSupportFullMirroring();
}

#pragma mark - Placeholder Implementation

- (void)updatePlaceholderAlpha {
  CGFloat opacity = 1;

  //  if (self.textInput.text.length &&
  //      (self.presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder)) {
  //    opacity = 0;
  //  } else if (!self.placeholder.length) {
  //    opacity = 0;
  //  }

  self.titleView.alpha = opacity;
}

- (void)updatePlaceholderTransformAndPosition {
  CGAffineTransform transform = CGAffineTransformIdentity;
  CGRect frame = [self placeholderDefaultPositionFrame];

  // The placeholder is displayed as floating if:
  // - text has been entered, or
  // - the user is currently entering text, or
  // - the field has failed validation.
  //  if (self.presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder &&
  //      (self.textInput.text.length || self.textInput.isEditing || self.errorTextView)) {
  //    transform = self.floatingPlaceholderScaleTransform;
  //    frame = [self placeholderFloatingPositionFrame];
  //  }

  self.titleView.transform = transform;
  self.titleView.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
  self.titleView.center = frame.origin;
}

- (CGRect)placeholderDefaultPositionFrame {
  CGRect bounds = self.textInput.bounds;
//  if (CGRectIsEmpty(bounds)) {
    return bounds;
//  }
//
//  CGRect placeholderRect = [self.textInput textRectThatFitsForBounds:bounds];
//  // Calculating the offset to account for a rightView in case it is needed for RTL layout,
//  // before the placeholderRect is modified to be just wide enough for the text.
//  CGFloat placeholderLeftViewOffset =
//  CGRectGetWidth(bounds) - CGRectGetWidth(placeholderRect) - CGRectGetMinX(placeholderRect);
//  CGFloat placeHolderWidth = [self placeHolderRequiredWidth];
//  placeholderRect.size.width = placeHolderWidth;
//  if ([self shouldLayoutForRTL]) {
//    // The leftView (or leading view) of a UITextInput is placed before the text.  The rect
//    // returned by UITextInput::textRectThatFitsForBounds: returns a rect that fills the field
//    // from the trailing edge of the leftView to the leading edge of the rightView.  Since this
//    // rect is not used directly for the placeholder, the space for the leftView must calculated
//    // to determine the correct origin for the placeholder view when rendering for RTL text.
//    placeholderRect.origin.x =
//    CGRectGetWidth(self.textInput.bounds) - placeHolderWidth - placeholderLeftViewOffset;
//  }
//  placeholderRect.size.height = self.fontHeight;
//  return placeholderRect;
}

#pragma mark - Underline Implementation


#pragma mark - Placeholder Animation

- (void)animatePlaceholderUp {
  if (self.presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder) {
    return;
  }

  // If there's an error, the view will already be up.
  if (!self.textInput.text.length && !self.textInput.leadingUnderlineLabel) {
    CALayer *titleLayer = self.titleView.layer;

    CGRect destinationFrame = [self placeholderFloatingPositionFrame];

    CATransform3D titleScaleTransform =
    CATransform3DMakeAffineTransform(self.floatingPlaceholderScaleTransform);

    CABasicAnimation *fontSizeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [fontSizeAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    [fontSizeAnimation setToValue:[NSValue valueWithCATransform3D:titleScaleTransform]];

    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [positionAnimation setFromValue:[NSValue valueWithCGPoint:[titleLayer position]]];
    [positionAnimation setToValue:[NSValue valueWithCGPoint:destinationFrame.origin]];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[ fontSizeAnimation, positionAnimation ];
    [titleLayer addAnimation:animationGroup forKey:@"animatePlaceholderUp"];
    self.titleView.transform = self.floatingPlaceholderScaleTransform;
    self.titleView.center = destinationFrame.origin;
  }

  CALayer *frontTitleViewLayer = self.titleView.frontLayer;
  CAKeyframeAnimation *fontColorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
  fontColorAnimation.values = @[ @0, @0, @0.25, @1 ];

  [frontTitleViewLayer addAnimation:fontColorAnimation forKey:@"animatePlaceholderUp"];
  frontTitleViewLayer.opacity = 1;
}

- (void)animatePlaceholderDown {
  if (self.presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder) {
    return;
  }

  // If there's an error, the placeholder should stay up.
  if (!self.textInput.text.length && !self.textInput.leadingUnderlineLabel) {
    CGRect destinationFrame = [self placeholderDefaultPositionFrame];
    CALayer *titleLayer = self.titleView.layer;

    CABasicAnimation *fontSizeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [fontSizeAnimation setFromValue:[NSValue valueWithCATransform3D:[titleLayer transform]]];
    [fontSizeAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];

    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [positionAnimation setFromValue:[NSValue valueWithCGPoint:[titleLayer position]]];
    [positionAnimation setToValue:[NSValue valueWithCGPoint:destinationFrame.origin]];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[ fontSizeAnimation, positionAnimation ];

    [titleLayer addAnimation:animationGroup forKey:@"animatePlaceholderDown"];
    self.titleView.transform = CGAffineTransformIdentity;
    self.titleView.center = destinationFrame.origin;
  }

  CAKeyframeAnimation *fontColorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
  fontColorAnimation.values = @[ @1, @0.25, @0, @0 ];

  CALayer *frontTitleViewLayer = self.titleView.frontLayer;
  [frontTitleViewLayer addAnimation:fontColorAnimation forKey:@"animatePlaceholderDown"];
  frontTitleViewLayer.opacity = 0;
}

- (CGRect)placeholderFloatingPositionFrame {
  CGRect placeholderRect = [self placeholderDefaultPositionFrame];
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
  if (self.underlineViewMode == UITextFieldViewModeUnlessEditing &&
      self.presentationStyle != GOOTextFieldPresentationStyleFullWidth) {
    [self.borderView setNormalBorderHidden:YES];
  }

  [self validateEvents:GOOTextFieldValidatorEventBeginEditing];

  [CATransaction begin];
  [CATransaction setAnimationDuration:kGOOTextFieldAnimationDuration];
  [CATransaction
   setAnimationTimingFunction:[QTMAnimationCurve animationTimingFunctionForCurve:
                               kQTMAnimationTimingCurveQuantumEaseInOut]];

// TODO(larche) Decide how best to handle underline changes.
//  if (self.underlineViewMode != UITextFieldViewModeUnlessEditing &&
//      self.presentationStyle != GOOTextFieldPresentationStyleFullWidth) {
//    [self.underderlineView animateFocusBorderIn];
//  }
  [self animatePlaceholderUp];
  [CATransaction commit];
}

- (void)textFieldDidEndEditing:(NSNotification *)note {
    if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
      // TODO(larche) Reset underline color to inactive state color.
    }
  
    [CATransaction begin];
    [CATransaction setAnimationDuration:MDCTextInputDividerOutAnimationDuration];
    if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
      // TODO(larche) Consider how best to handle underline changes.
      // [self.underlineView animateFocusUnderlineOut];
    }
    [self animatePlaceholderDown];
    [CATransaction commit];
  
}

- (void)textFieldDidChange:(NSNotification *)note {
    [self updatePlaceholderAlpha];
    [self updateCharacterCountMax];
}

#pragma mark - Public API

- (void)setErrorText:(NSString *)errorText
    errorAccessibilityValue:(NSString *)errorAccessibilityValue {
}

@end
