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

#import "MDCTextInputController.h"

#import "MDCTextInput+Internal.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputTitleView.h"
#import "MDCTextInputUnderlineView.h"
#import "MaterialAnimationTiming.h"

NSString *const MDCTextInputValidatorErrorColorKey = @"MDCTextInputValidatorErrorColor";
NSString *const MDCTextInputValidatorErrorTextKey = @"MDCTextInputValidatorErrorText";
NSString *const MDCTextInputValidatorAXErrorTextKey = @"MDCTextInputValidatorAXErrorText";

// These numers are straight from the redlines in the docs here:
// https://spec.MDCgleplex.com/quantum/components/text-fields
static const CGFloat MDCTextInputVerticalPadding = 16.f;
static const CGFloat MDCTextInputFloatingLabelFontSize = 12.f;
static const CGFloat MDCTextInputFloatingLabelTextHeight = 16.f;
static const CGFloat MDCTextInputFloatingLabelMargin = 8.f;
static const CGFloat MDCTextInputFullWidthVerticalPadding = 20.f;
static const CGFloat MDCTextInputValidationMargin = 8.f;

static const NSTimeInterval MDCTextInputAnimationDuration = 0.3f;

static inline CGFloat MDCFabs(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return fabs(value);
#else
  return fabsf(value);
#endif
}

/**
  Checks whether the provided floating point number is approximately zero based on a small epsilon.

  Note that ULP-based comparisons are not used because ULP-space is significantly distorted around
  zero.

  Reference:
  https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/
 */
static inline BOOL MDCFloatIsApproximatelyZero(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return (MDCFabs(value) < DBL_EPSILON);
#else
  return (MDCFabs(value) < FLT_EPSILON);
#endif
}

static inline CGFloat MDCTextInputTitleScaleFactor(UIFont *font) {
  CGFloat pointSize = [font pointSize];
  if (!MDCFloatIsApproximatelyZero(pointSize)) {
    return MDCTextInputFloatingLabelFontSize / pointSize;
  }

  return 1;
}

@interface MDCTextInputController ()

@property(nonatomic, readonly) BOOL canValidate;
@property(nonatomic, strong) UILabel *characterLimitView;
@property(nonatomic, strong) UILabel *errorTextView;
@property(nonatomic, assign) CGAffineTransform floatingPlaceholderScaleTransform;
@property(nonatomic, readonly) BOOL isMultiline;
@property(nonatomic, weak) UIView<MDCControlledTextInput, MDCTextInput> *textInput;
@property(nonatomic, strong) MDCTextInputTitleView *titleView;
@property(nonatomic, strong) MDCTextInputUnderlineView *underlineView;

@end

@implementation MDCTextInputController

// We never use the text property. Instead always read from the text field.

@synthesize characterLimit = _characterLimit;
@synthesize characterLimitColor = _characterLimitColor;
@synthesize characterLimitFont = _characterLimitFont;
@synthesize characterCounter = _characterCounter;
@synthesize editing = _editing;
@synthesize floatingPlaceholderColor = _floatingPlaceholderColor;
@synthesize floatingPlaceholderScale = _floatingPlaceholderScale;
@synthesize inlinePlaceholderColor = _inlinePlaceholderColor;
@synthesize placeholderFont = _placeholderFont;
@synthesize presentationStyle = _presentationStyle;
@synthesize text = _do_no_use_text;
@synthesize textColor = _textColor;
@synthesize underlineAccessibilityText = _underlineAccessibilityText;
@synthesize underlineColor = _underlineColor;
@synthesize underlineText = _underlineText;
@synthesize underlineTextColor = _underlineTextColor;
@synthesize underlineTextFont = _underlineTextFont;
@synthesize underlineWidth = _underlineWidth;

- (instancetype)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (nonnull instancetype)initWithTextField:(UIView<MDCControlledTextInput> *_Nonnull)textInput
                              isMultiline:(BOOL)isMultiline {
  self = [super init];
  if (self) {
    _textInput = textInput;
    _isMultiline = isMultiline;

    _textColor = MDCTextInputTextColor();
    _inlinePlaceholderColor = MDCTextInputInlinePlaceholderTextColor();
    _floatingPlaceholderColor = MDCTextInputInlinePlaceholderTextColor();
    _underlineColor = MDCTextInputUnderlineColor();

    _floatingPlaceholderScale = 0.25;
    _floatingPlaceholderScaleTransform = CGAffineTransformIdentity;

    _titleView =
        [[MDCTextInputTitleView alloc] initWithFrame:[self placeholderDefaultPositionFrame]];
    // The default, kCAAlignmentNatural is not honored by CATextLayer. rdar://23881371
    if ([self shouldLayoutForRTL]) {
      [_titleView.backLayer setAlignmentMode:kCAAlignmentRight];
      [_titleView.frontLayer setAlignmentMode:kCAAlignmentRight];
    }
    _titleView.layer.anchorPoint = CGPointZero;
    _titleView.userInteractionEnabled = NO;
    _titleView.frontLayerColor = _textInput.tintColor.CGColor;
    _titleView.backLayerColor = _inlinePlaceholderColor.CGColor;
    _titleView.font = _textInput.font;
    _titleView.alpha = 0;
    [_textInput addSubview:_titleView];
    [_textInput sendSubviewToBack:_titleView];

    // Use the property accessor to create the underline view as needed.
    __unused MDCTextInputUnderlineView *underlineView = [self underlineView];
  }
  return self;
}

- (void)didSetText {
  [self didChange];
  [self.textInput setNeedsLayout];
}

- (void)didSetFont {
  UIFont *font = self.textInput.font;
  self.titleView.font = font;

  CGFloat scaleFactor = MDCTextInputTitleScaleFactor(font);
  self.floatingPlaceholderScaleTransform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);

  [self updatePlaceholderTransformAndPosition];
}

- (void)layoutSubviewsWithAnimationsDisabled {
  self.characterLimitView.frame = [self characterLimitFrame];
  self.errorTextView.frame = [self underlineTextFrame];
  self.underlineView.frame = [self underlineViewFrame];
  [self updatePlaceholderTransformAndPosition];
  [self updatePlaceholderAlpha];
}

- (UIEdgeInsets)textContainerInset {
  UIEdgeInsets textContainerInset = UIEdgeInsetsZero;
  switch (self.presentationStyle) {
    case MDCTextInputPresentationStyleDefault:
      textContainerInset.top = MDCTextInputVerticalPadding;
      textContainerInset.bottom = MDCTextInputVerticalPadding;
      break;
    case MDCTextInputPresentationStyleFloatingPlaceholder:
      textContainerInset.top = MDCTextInputVerticalPadding + MDCTextInputFloatingLabelTextHeight +
                               MDCTextInputFloatingLabelMargin;
      textContainerInset.bottom = MDCTextInputVerticalPadding;
      break;
    case MDCTextInputPresentationStyleFullWidth:
      textContainerInset.top = MDCTextInputFullWidthVerticalPadding;
      textContainerInset.bottom = MDCTextInputFullWidthVerticalPadding;
      textContainerInset.left = MDCTextInputFullWidthHorizontalPadding;
      textContainerInset.right = MDCTextInputFullWidthHorizontalPadding;
      break;
  }

  // TODO(larche) Check this removal of validator.
  // Adjust for the character limit and validator.
  // Full width single line text fields have their character counter on the same line as the text.
  if ((self.characterLimit) &&
      (self.presentationStyle != MDCTextInputPresentationStyleFullWidth || self.isMultiline)) {
    textContainerInset.bottom += MDCTextInputValidationMargin;
  }

  return textContainerInset;
}

- (void)didBeginEditing {
  // TODO(larche) Check this removal of underlineViewMode.
  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
    [self.underlineView setNormalUnderlineHidden:YES];
  }

  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputAnimationDuration];
  [CATransaction
      setAnimationTimingFunction:[CAMediaTimingFunction
                                     mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]];

  // TODO(larche) Check this removal of underlineViewMode.
  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
    [self.underlineView animateFocusUnderlineIn];
  }
  [self animatePlaceholderUp];
  [CATransaction commit];

  [self updateCharacterCountLimit];
}

- (void)didEndEditing {
  // TODO(larche) Check this removal of underlineViewMode.
  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
    [self.underlineView setNormalUnderlineHidden:NO];
  }

  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextInputDividerOutAnimationDuration];
  if (self.presentationStyle != MDCTextInputPresentationStyleFullWidth) {
    [self.underlineView animateFocusUnderlineOut];
  }
  [self animatePlaceholderDown];
  [CATransaction commit];

  UILabel *label = (UILabel *)[self textInputLabel];
  if ([label isKindOfClass:[UILabel class]]) {
    [label setLineBreakMode:NSLineBreakByTruncatingTail];
  }

  [self updateCharacterCountLimit];
}

- (void)didChange {
  [self updatePlaceholderAlpha];
  [self updateCharacterCountLimit];
}

// TODO(larche) Add back in properly.
- (BOOL)shouldLayoutForRTL {
  return NO;
  //  return MDCShouldLayoutForRTL() && MDCRTLCanSupportFullMirroring();
}

#pragma mark - Underline View Implementation

- (MDCTextInputUnderlineView *)underlineView {
  // TODO(larche) Check this removal of underlineViewMode.
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
    return nil;
  }

  if (!_underlineView) {
    _underlineView = [[MDCTextInputUnderlineView alloc] initWithFrame:[self underlineViewFrame]];
    if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
      _underlineView.normalUnderlineHidden = NO;
      _underlineView.focusUnderlineHidden = YES;
    } else {
      // TODO(larche) Check this removal of underlineViewMode.
      //      _underlineView.normalUnderlineHidden = (self.underlineViewMode ==
      //      UITextInputViewModeWhileEditing);
      // TODO(larche) Check this removal of underlineViewMode.
      //      _underlineView.focusUnderlineHidden = (self.underlineViewMode ==
      //      UITextInputViewModeUnlessEditing);
    }

    _underlineView.focusedColor = self.textInput.tintColor;
    _underlineView.unfocusedColor = self.underlineColor;

    [self.textInput addSubview:_underlineView];
    [self.textInput sendSubviewToBack:_underlineView];
  }

  return _underlineView;
}

- (CGRect)underlineViewFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect underlineFrame = CGRectZero;
  underlineFrame.size = [_underlineView sizeThatFits:bounds.size];
  CGRect textRect = [self.textInput textRectThatFitsForBounds:bounds];

  CGFloat underlineVerticalPadding = MDCTextInputUnderlineVerticalPadding;
  if ([self.textInput respondsToSelector:@selector(underlineVerticalPadding)]) {
    underlineVerticalPadding = self.textInput.underlineVerticalPadding;
  }

  if (self.isMultiline) {
    // For multiline text fields, the textRectThatFitsForBounds is essentially the text container
    // and we can just measure from the bottom.
    underlineFrame.origin.y =
        CGRectGetMaxY(textRect) + underlineVerticalPadding - underlineFrame.size.height;
  } else {
    // For single line text fields, the textRectThatFitsForBounds is a best guess at the text
    // rect for the line of text, which may be rect adjusted for pixel boundaries.  Measure from the
    // center to get the best underline placement.
    underlineFrame.origin.y = CGRectGetMidY(textRect) + (self.textInput.font.pointSize / 2.0f) +
                              underlineVerticalPadding - underlineFrame.size.height;
  }

  return underlineFrame;
}

#pragma mark - Properties Implementation

- (NSString *)placeholder {
  NSObject *placeholderString = self.titleView.string;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    return (NSString *)placeholderString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return [(NSAttributedString *)placeholderString string];
  }

  return nil;
}

- (void)setPlaceholder:(NSString *)placeholder {
  self.titleView.string = placeholder;
  [self updatePlaceholderAlpha];
  [self.textInput setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  self.underlineView.enabled = enabled;
}

- (void)setPresentationStyle:(MDCTextInputPresentationStyle)presentationStyle {
  if (_presentationStyle != presentationStyle) {
    _presentationStyle = presentationStyle;
    [self removeCharacterCountLimit];
    [self updateCharacterCountLimit];
    if (_presentationStyle == MDCTextInputPresentationStyleFullWidth) {
      [_underlineView removeFromSuperview];
      _underlineView = nil;
    }
    [self.textInput setNeedsLayout];
  }
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

- (void)setInlinePlaceholderColor:(UIColor *)inlinePlaceholderColor {
  if (!inlinePlaceholderColor) {
    inlinePlaceholderColor = MDCTextInputInlinePlaceholderTextColor();
  }

  if (_inlinePlaceholderColor != inlinePlaceholderColor) {
    _inlinePlaceholderColor = inlinePlaceholderColor;
    [self updateColors];
  }
}

- (void)setUnderlineTextColor:(UIColor *)underlineTextColor {
  if (!underlineTextColor) {
    underlineTextColor = MDCTextInputTextErrorColor();
  }

  if (_underlineTextColor != underlineTextColor) {
    _underlineTextColor = underlineTextColor;
    [self updateColors];
  }
}

- (void)setUnderlineColor:(UIColor *)underlineColor {
  if (!underlineColor) {
    underlineColor = MDCTextInputUnderlineColor();
  }

  if (_underlineColor != underlineColor) {
    _underlineColor = underlineColor;
    [self updateColors];
  }
}

- (void)setCharacterLimit:(NSUInteger)characterLimit {
  if (_characterLimit != characterLimit) {
    _characterLimit = characterLimit;
    [self updateCharacterCountLimit];
  }
}

- (void)setCharacterCounter:(id<MDCTextInputCharacterCounter>)characterCounter {
  if (_characterCounter != characterCounter) {
    _characterCounter = characterCounter;
    [self updateCharacterCountLimit];
  }
}

// TODO(larche) Check this removal of setUnderlineViewMode.

#pragma mark - Character Limit Implementation

- (UILabel *)characterLimitView {
  if (!_characterLimitView) {
    _characterLimitView = [[UILabel alloc] initWithFrame:CGRectZero];
    _characterLimitView.textAlignment = NSTextAlignmentRight;
    _characterLimitView.font = [MDCTypography captionFont];
  }

  NSString *text = [NSString stringWithFormat:@"%lu/%lu", (unsigned long)[self characterCount],
                                              (unsigned long)self.characterLimit];
  _characterLimitView.text = text;

  return _characterLimitView;
}

- (CGSize)characterLimitViewSize {
  [self.characterLimitView sizeToFit];
  return self.characterLimitView.bounds.size;
}

- (CGRect)characterLimitFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect characterLimitFrame = CGRectZero;
  characterLimitFrame.size = [self.characterLimitView sizeThatFits:bounds.size];
  if ([self shouldLayoutForRTL]) {
    characterLimitFrame.origin.x = 0.0f;
  } else {
    characterLimitFrame.origin.x = CGRectGetMaxX(bounds) - CGRectGetWidth(characterLimitFrame);
  }

  // If its single line full width, position on the line.
  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth && !self.isMultiline) {
    characterLimitFrame.origin.y =
        CGRectGetMidY(bounds) - CGRectGetHeight(characterLimitFrame) / 2.0f;
  } else {
    characterLimitFrame.origin.y = CGRectGetMaxY(bounds) - CGRectGetHeight(characterLimitFrame);
  }

  return characterLimitFrame;
}

- (void)removeCharacterCountLimit {
  [self.characterLimitView removeFromSuperview];
  self.characterLimitView = nil;
}

- (void)updateCharacterCountLimit {
  if (!self.characterLimit || !self.textInput.isEditing) {
    [self removeCharacterCountLimit];
    return;
  }

  BOOL pastLimit = [self characterCount] > self.characterLimit;

  UIColor *textColor = MDCTextInputInlinePlaceholderTextColor();
  if (pastLimit && self.textInput.isEditing) {
    textColor = MDCTextInputTextErrorColor();
  }

  self.characterLimitView.textColor = textColor;
  [self.characterLimitView sizeToFit];

  [self.textInput insertSubview:self.characterLimitView aboveSubview:self.titleView];
  [self.underlineView setErroneous:pastLimit];
}

#pragma mark - Placeholder Implementation

- (void)updatePlaceholderAlpha {
  CGFloat opacity = 1;

  if (self.textInput.text.length &&
      (self.presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder)) {
    opacity = 0;
  } else if (!self.placeholder.length) {
    opacity = 0;
  }

  self.titleView.alpha = opacity;
}

- (void)updatePlaceholderTransformAndPosition {
  CGAffineTransform transform = CGAffineTransformIdentity;
  CGRect frame = [self placeholderDefaultPositionFrame];

  // The placeholder is displayed as floating if:
  // - text has been entered, or
  // - the user is currently entering text, or
  // - the field has failed validation.
  if (self.presentationStyle == MDCTextInputPresentationStyleFloatingPlaceholder &&
      (self.textInput.text.length || self.textInput.isEditing || self.errorTextView)) {
    transform = self.floatingPlaceholderScaleTransform;
    frame = [self placeholderFloatingPositionFrame];
  }

  self.titleView.transform = transform;
  self.titleView.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
  self.titleView.center = frame.origin;
}

- (CGRect)placeholderDefaultPositionFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect placeholderRect = [self.textInput textRectThatFitsForBounds:bounds];
  // Calculating the offset to account for a rightView in case it is needed for RTL layout,
  // before the placeholderRect is modified to be just wide enough for the text.
  CGFloat placeholderLeftViewOffset =
      CGRectGetWidth(bounds) - CGRectGetWidth(placeholderRect) - CGRectGetMinX(placeholderRect);
  CGFloat placeHolderWidth = [self placeHolderRequiredWidth];
  placeholderRect.size.width = placeHolderWidth;
  if ([self shouldLayoutForRTL]) {
    // The leftView (or leading view) of a UITextInput is placed before the text.  The rect
    // returned by UITextInput::textRectThatFitsForBounds: returns a rect that fills the field
    // from the trailing edge of the leftView to the leading edge of the rightView.  Since this
    // rect is not used directly for the placeholder, the space for the leftView must calculated
    // to determine the correct origin for the placeholder view when rendering for RTL text.
    placeholderRect.origin.x =
        CGRectGetWidth(self.textInput.bounds) - placeHolderWidth - placeholderLeftViewOffset;
  }
  placeholderRect.size.height = self.fontHeight;
  return placeholderRect;
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

- (CGFloat)placeHolderRequiredWidth {
  if (!self.textInput.font) {
    return 0;
  }
  return [self.placeholder sizeWithAttributes:@{NSFontAttributeName : self.textInput.font}].width;
}

- (void)animatePlaceholderUp {
  if (self.presentationStyle != MDCTextInputPresentationStyleFloatingPlaceholder) {
    return;
  }

  // If there's an error, the view will already be up.
  if (!self.textInput.text.length && !self.errorTextView) {
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
  if (!self.textInput.text.length && !self.errorTextView) {
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

#pragma mark - Validator Implementation

- (CGRect)underlineTextFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect underlineTextFrame = CGRectZero;
  underlineTextFrame.size = [self.errorTextView sizeThatFits:bounds.size];
  if ([self shouldLayoutForRTL]) {
    underlineTextFrame.origin.x = CGRectGetMaxX(bounds) - CGRectGetWidth(underlineTextFrame);
  } else {
    underlineTextFrame.origin.x = CGRectGetMinX(bounds);
  }
  CGRect underlineFrame = [self underlineViewFrame];
  underlineTextFrame.origin.y = CGRectGetMaxY(underlineFrame) + MDCTextInputVerticalPadding -
                                CGRectGetHeight(underlineTextFrame);

  if (self.characterLimit) {
    CGRect characterLimitFrame = [self characterLimitFrame];
    if ([self shouldLayoutForRTL]) {
      underlineTextFrame.size.width =
          CGRectGetMaxX(underlineTextFrame) - CGRectGetMaxX(characterLimitFrame);
    } else {
      underlineTextFrame.size.width =
          CGRectGetMinX(characterLimitFrame) - CGRectGetMinX(underlineTextFrame);
    }
  }

  return underlineTextFrame;
}

#pragma mark - Private

- (void)updateColors {
  self.textInput.tintColor = MDCTextInputCursorColor();
  self.textInput.textColor = self.textColor;

  self.underlineView.focusedColor = self.textInput.tintColor;
  self.underlineView.unfocusedColor = self.underlineColor;

  self.titleView.frontLayerColor = self.textInput.tintColor.CGColor;
  self.titleView.backLayerColor = self.inlinePlaceholderColor.CGColor;
}

- (UIView *)textInputLabel {
  Class targetClass = NSClassFromString(@"UITextInputLabel");
  // Loop through the text field's views until we find the UITextInputLabel which is used for the
  // label in UITextInput.
  NSMutableArray *toVisit = [NSMutableArray arrayWithArray:self.textInput.subviews];
  while ([toVisit count]) {
    UIView *view = [toVisit objectAtIndex:0];
    if ([view isKindOfClass:targetClass]) {
      return view;
    }
    [toVisit addObjectsFromArray:view.subviews];
    [toVisit removeObjectAtIndex:0];
  }
  return nil;
}

- (CGFloat)fontHeight {
  return MDCCeil(self.textInput.font.lineHeight);
}

- (NSUInteger)characterCount {
  return self.characterCounter ? [self.characterCounter characterCountForTextInput:self.textInput]
                               : self.textInput.text.length;
}

@end
