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

#import "MDCTextInput.h"
#import "MDCTextInput+Internal.h"
#import "MDCTextInputCharacterCounter.h"
#import "Private/MDCTextFieldTitleView.h"
#import "Private/MDCUnderlineView.h"

NSString *const MDCTextFieldValidatorErrorColorKey = @"MDCTextFieldValidatorErrorColor";
NSString *const MDCTextFieldValidatorErrorTextKey = @"MDCTextFieldValidatorErrorText";
NSString *const MDCTextFieldValidatorAXErrorTextKey = @"MDCTextFieldValidatorAXErrorText";

// These numers are straight from the redlines in the docs here:
// https://spec.googleplex.com/quantum/components/text-fields
static const CGFloat MDCTextFieldVerticalPadding = 16.f;
static const CGFloat MDCTextFieldFloatingLabelFontSize = 12.f;
static const CGFloat MDCTextFieldFloatingLabelTextHeight = 16.f;
static const CGFloat MDCTextFieldFloatingLabelMargin = 8.f;
static const CGFloat MDCTextFieldFullWidthVerticalPadding = 20.f;
static const CGFloat MDCTextFieldValidationMargin = 8.f;

static const NSTimeInterval MDCTextFieldAnimationDuration = 0.3f;

NS_INLINE CGFloat MDCTextFieldTitleScaleFactor(UIFont *font) {
  CGFloat pointSize = [font pointSize];
  if (!MDCFloatIsApproximatelyZero(pointSize)) {
    return MDCTextFieldFloatingLabelFontSize / pointSize;
  }

  return 1;
}

@interface MDCTextInputController ()

@property(nonatomic, weak) UIView<MDCControlledTextField> *textField;
@property(nonatomic, readonly) BOOL isMultiline;
@property(nonatomic, strong) MDCTextFieldTitleView *titleView;
@property(nonatomic, assign) CGAffineTransform floatingTitleScale;
@property(nonatomic, strong) MDCUnderlineView *borderView;
@property(nonatomic, strong) UILabel *characterLimitView;
@property(nonatomic, strong) UILabel *errorTextView;
@property(nonatomic, readonly) BOOL canValidate;

@end

@implementation MDCTextInputController

// We never use the text property. Instead always read from the text field.
@synthesize text = _do_no_use_text;
@synthesize presentationStyle = _presentationStyle;
@synthesize colorGroup = _colorGroup;
@synthesize textColor = _textColor;
@synthesize placeholderColor = _placeholderColor;
@synthesize errorColor = _errorColor;
@synthesize borderColor = _borderColor;
@synthesize characterLimit = _characterLimit;
@synthesize characterCounter = _characterCounter;
@synthesize underlineViewMode = _underlineViewMode;
@synthesize validator = _validator;

- (instancetype)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithTextField:(UIView<MDCControlledTextField> *)textField
                      isMultiline:(BOOL)isMultiline {
  self = [super init];
  if (self) {
    _textField = textField;
    _isMultiline = isMultiline;

    _colorGroup = [QTMColorGroup colorGroupWithID:kQTMColorGroupIndigo];
    _textColor = GOOTextFieldTextColor();
    _placeholderColor = GOOTextFieldPlaceholderTextColor();
    _errorColor = GOOTextFieldTextErrorColor();
    _borderColor = GOOTextFieldBorderColor();

    _floatingTitleScale = CGAffineTransformIdentity;
    _underlineViewMode = UITextFieldViewModeAlways;

    _titleView =
        [[GOOTextFieldTitleView alloc] initWithFrame:[self placeholderDefaultPositionFrame]];
    // The default, kCAAlignmentNatural is not honored by CATextLayer. rdar://23881371
    if ([self shouldLayoutForRTL]) {
      [_titleView.backLayer setAlignmentMode:kCAAlignmentRight];
      [_titleView.frontLayer setAlignmentMode:kCAAlignmentRight];
    }
    _titleView.layer.anchorPoint = CGPointZero;
    _titleView.userInteractionEnabled = NO;
    _titleView.frontLayerColor = _textField.tintColor.CGColor;
    _titleView.backLayerColor = _placeholderColor.CGColor;
    _titleView.font = _textField.font;
    _titleView.alpha = 0;
    [_textField addSubview:_titleView];
    [_textField sendSubviewToBack:_titleView];

    // Use the property accessor to create the border view as needed.
    __unused GOOUnderlineView *underlineView = [self borderView];
  }
  return self;
}

- (void)didSetText {
  [self didChange];
  [self.textField setNeedsLayout];
}

- (void)didSetFont {
  UIFont *font = self.textField.font;
  self.titleView.font = font;

  CGFloat scaleFactor = GOOTextFieldTitleScaleFactor(font);
  self.floatingTitleScale = CGAffineTransformMakeScale(scaleFactor, scaleFactor);

  [self updatePlaceholderTransformAndPosition];
}

- (void)layoutSubviewsWithAnimationsDisabled {
  self.characterLimitView.frame = [self characterLimitFrame];
  self.errorTextView.frame = [self errorTextFrame];
  self.borderView.frame = [self borderViewFrame];
  [self updatePlaceholderTransformAndPosition];
  [self updatePlaceholderAlpha];
}

- (UIEdgeInsets)textContainerInset {
  UIEdgeInsets textContainerInset = UIEdgeInsetsZero;
  switch (self.presentationStyle) {
    case GOOTextFieldPresentationStyleDefault:
      textContainerInset.top = MDCTextFieldVerticalPadding;
      textContainerInset.bottom = MDCTextFieldVerticalPadding;
      break;
    case GOOTextFieldPresentationStyleFloatingPlaceholder:
      textContainerInset.top = MDCTextFieldVerticalPadding + MDCTextFieldFloatingLabelTextHeight +
                               MDCTextFieldFloatingLabelMargin;
      textContainerInset.bottom = MDCTextFieldVerticalPadding;
      break;
    case GOOTextFieldPresentationStyleFullWidth:
      textContainerInset.top = MDCTextFieldFullWidthVerticalPadding;
      textContainerInset.bottom = MDCTextFieldFullWidthVerticalPadding;
      textContainerInset.left = MDCTextFieldFullWidthHorizontalPadding;
      textContainerInset.right = MDCTextFieldFullWidthHorizontalPadding;
      break;
  }
  // Adjust for the character limit and validator.
  // Full width single line text fields have their character counter on the same line as the text.
  if ((self.characterLimit || self.validator) &&
      (self.presentationStyle != GOOTextFieldPresentationStyleFullWidth || self.isMultiline)) {
    textContainerInset.bottom += MDCTextFieldValidationMargin;
  }

  return textContainerInset;
}

- (void)didBeginEditing {
  if (self.underlineViewMode == UITextFieldViewModeUnlessEditing &&
      self.presentationStyle != GOOTextFieldPresentationStyleFullWidth) {
    [self.borderView setNormalBorderHidden:YES];
  }

  [self validateEvents:GOOTextFieldValidatorEventBeginEditing];

  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextFieldAnimationDuration];
  [CATransaction
      setAnimationTimingFunction:[QTMAnimationCurve animationTimingFunctionForCurve:
                                                        kQTMAnimationTimingCurveQuantumEaseInOut]];
  if (self.underlineViewMode != UITextFieldViewModeUnlessEditing &&
      self.presentationStyle != GOOTextFieldPresentationStyleFullWidth) {
    [self.borderView animateFocusBorderIn];
  }
  [self animatePlaceholderUp];
  [CATransaction commit];

  [self updateCharacterCountLimit];
}

- (void)didEndEditing {
  if (self.underlineViewMode == UITextFieldViewModeUnlessEditing &&
      self.presentationStyle != GOOTextFieldPresentationStyleFullWidth) {
    [self.borderView setNormalBorderHidden:NO];
  }

  [self validateEvents:GOOTextFieldValidatorEventEndEditing];

  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCTextFieldDividerOutAnimationDuration];
  if (self.presentationStyle != GOOTextFieldPresentationStyleFullWidth) {
    [self.borderView animateFocusBorderOut];
  }
  [self animatePlaceholderDown];
  [CATransaction commit];

  UILabel *label = (UILabel *)[self textFieldLabel];
  if ([label isKindOfClass:[UILabel class]]) {
    [label setLineBreakMode:NSLineBreakByTruncatingTail];
  }

  [self updateCharacterCountLimit];
}

- (void)didChange {
  [self updatePlaceholderAlpha];
  [self updateCharacterCountLimit];
  [self validateEvents:GOOTextFieldValidatorEventTextChange];
}

- (void)validate {
  if (self.canValidate) {
    [self performValidation];
  }
}

- (BOOL)shouldLayoutForRTL {
  return GOOShouldLayoutForRTL() && GOORTLCanSupportFullMirroring();
}

#pragma mark - Border View Implementation

- (GOOUnderlineView *)borderView {
  if (self.underlineViewMode == UITextFieldViewModeNever ||
      self.presentationStyle == GOOTextFieldPresentationStyleFullWidth) {
    return nil;
  }

  if (!_borderView) {
    _borderView = [[GOOUnderlineView alloc] initWithFrame:[self borderViewFrame]];
    if (self.presentationStyle == GOOTextFieldPresentationStyleFullWidth) {
      _borderView.normalBorderHidden = NO;
      _borderView.focusBorderHidden = YES;
    } else {
      _borderView.normalBorderHidden = (self.underlineViewMode == UITextFieldViewModeWhileEditing);
      _borderView.focusBorderHidden = (self.underlineViewMode == UITextFieldViewModeUnlessEditing);
    }

    _borderView.focusedColor = self.textField.tintColor;
    _borderView.unfocusedColor = self.borderColor;

    [self.textField addSubview:_borderView];
    [self.textField sendSubviewToBack:_borderView];
  }

  return _borderView;
}

- (CGRect)borderViewFrame {
  CGRect bounds = self.textField.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect borderFrame = CGRectZero;
  borderFrame.size = [_borderView sizeThatFits:bounds.size];
  CGRect textRect = [self.textField textRectThatFitsForBounds:bounds];

  CGFloat borderVerticalPadding = MDCTextFieldBorderVerticalPadding;
  if ([self.textField respondsToSelector:@selector(borderVerticalPadding)]) {
    borderVerticalPadding = self.textField.borderVerticalPadding;
  }

  if (self.isMultiline) {
    // For multiline text fields, the textRectThatFitsForBounds is essentially the text container
    // and we can just measure from the bottom.
    borderFrame.origin.y =
        CGRectGetMaxY(textRect) + borderVerticalPadding - borderFrame.size.height;
  } else {
    // For single line text fields, the textRectThatFitsForBounds is a best guess at the text
    // rect for the line of text, which may be rect adjusted for pixel boundaries.  Measure from the
    // center to get the best border placement.
    borderFrame.origin.y = CGRectGetMidY(textRect) + (self.textField.font.pointSize / 2.0f) +
                           borderVerticalPadding - borderFrame.size.height;
  }

  return borderFrame;
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
  [self.textField setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  self.borderView.enabled = enabled;
}

- (void)setPresentationStyle:(GOOTextFieldPresentationStyle)presentationStyle {
  if (_presentationStyle != presentationStyle) {
    _presentationStyle = presentationStyle;
    [self removeCharacterCountLimit];
    [self updateCharacterCountLimit];
    if (_presentationStyle == GOOTextFieldPresentationStyleFullWidth) {
      [_borderView removeFromSuperview];
      _borderView = nil;
    }
    [self validateEvents:GOOTextFieldValidatorEventPropertyChange];
    [self.textField setNeedsLayout];
  }
}

- (void)setColorGroup:(QTMColorGroup *)colorGroup {
  if (!colorGroup) {
    colorGroup = [QTMColorGroup colorGroupWithID:kQTMColorGroupIndigo];
  }

  if (_colorGroup != colorGroup) {
    _colorGroup = colorGroup;
    [self updateColors];
    [self.textField setNeedsDisplay];
  }
}

- (void)setTextColor:(UIColor *)textColor {
  if (!textColor) {
    textColor = GOOTextFieldTextColor();
  }

  if (_textColor != textColor) {
    _textColor = textColor;
    [self updateColors];
  }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
  if (!placeholderColor) {
    placeholderColor = GOOTextFieldPlaceholderTextColor();
  }

  if (_placeholderColor != placeholderColor) {
    _placeholderColor = placeholderColor;
    [self updateColors];
  }
}

- (void)setErrorColor:(UIColor *)errorColor {
  if (!errorColor) {
    errorColor = GOOTextFieldTextErrorColor();
  }

  if (_errorColor != errorColor) {
    _errorColor = errorColor;
    [self updateColors];
  }
}

- (void)setBorderColor:(UIColor *)borderColor {
  if (!borderColor) {
    borderColor = GOOTextFieldBorderColor();
  }

  if (_borderColor != borderColor) {
    _borderColor = borderColor;
    [self updateColors];
  }
}

- (void)setCharacterLimit:(NSUInteger)characterLimit {
  if (_characterLimit != characterLimit) {
    _characterLimit = characterLimit;
    [self updateCharacterCountLimit];
    [self validateEvents:GOOTextFieldValidatorEventPropertyChange];
  }
}

- (void)setCharacterCounter:(id<GOOTextFieldCharacterCounter>)characterCounter {
  if (_characterCounter != characterCounter) {
    _characterCounter = characterCounter;
    [self updateCharacterCountLimit];
    [self validateEvents:GOOTextFieldValidatorEventPropertyChange];
  }
}

- (void)setUnderlineViewMode:(UITextFieldViewMode)mode {
  if (_underlineViewMode != mode) {
    _underlineViewMode = mode;

    if (_underlineViewMode == UITextFieldViewModeNever) {
      [_borderView removeFromSuperview];
      _borderView = nil;
    } else {
      [_borderView setNormalBorderHidden:(_underlineViewMode == UITextFieldViewModeWhileEditing)];
      [_borderView setFocusBorderHidden:(_underlineViewMode == UITextFieldViewModeUnlessEditing)];
    }
    [self.textField setNeedsDisplay];
  }
}

#pragma mark - Character Limit Implementation

- (UILabel *)characterLimitView {
  if (!_characterLimitView) {
    _characterLimitView = [[UILabel alloc] initWithFrame:CGRectZero];
    _characterLimitView.textAlignment = NSTextAlignmentRight;
    _characterLimitView.font = [GOOTypography captionFont];
  }

  NSString *text = [NSString stringWithFormat:
      @"%lu/%lu", (unsigned long)[self characterCount], (unsigned long)self.characterLimit];
  _characterLimitView.text = text;

  return _characterLimitView;
}

- (CGSize)characterLimitViewSize {
  [self.characterLimitView sizeToFit];
  return self.characterLimitView.bounds.size;
}

- (CGRect)characterLimitFrame {
  CGRect bounds = self.textField.bounds;
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
  if (self.presentationStyle == GOOTextFieldPresentationStyleFullWidth && !self.isMultiline) {
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
  if (!self.characterLimit || !self.textField.isEditing) {
    [self removeCharacterCountLimit];
    return;
  }

  BOOL pastLimit = [self characterCount] > self.characterLimit;

  UIColor *textColor = GOOTextFieldPlaceholderTextColor();
  if (pastLimit && self.textField.isEditing) {
    textColor = GOOTextFieldTextErrorColor();
  }

  self.characterLimitView.textColor = textColor;
  [self.characterLimitView sizeToFit];

  [self.textField insertSubview:self.characterLimitView aboveSubview:self.titleView];
  [self.borderView setErroneous:pastLimit];
}

#pragma mark - Placeholder Implementation

- (void)updatePlaceholderAlpha {
  CGFloat opacity = 1;

  if (self.textField.text.length &&
      (self.presentationStyle != GOOTextFieldPresentationStyleFloatingPlaceholder)) {
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
  if (self.presentationStyle == GOOTextFieldPresentationStyleFloatingPlaceholder &&
      (self.textField.text.length || self.textField.isEditing || self.errorTextView)) {
    transform = self.floatingTitleScale;
    frame = [self placeholderFloatingPositionFrame];
  }

  self.titleView.transform = transform;
  self.titleView.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
  self.titleView.center = frame.origin;
}

- (CGRect)placeholderDefaultPositionFrame {
  CGRect bounds = self.textField.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect placeholderRect = [self.textField textRectThatFitsForBounds:bounds];
  // Calculating the offset to account for a rightView in case it is needed for RTL layout,
  // before the placeholderRect is modified to be just wide enough for the text.
  CGFloat placeholderLeftViewOffset =
        CGRectGetWidth(bounds) - CGRectGetWidth(placeholderRect) - CGRectGetMinX(placeholderRect);
  CGFloat placeHolderWidth = [self placeHolderRequiredWidth];
  placeholderRect.size.width = placeHolderWidth;
  if ([self shouldLayoutForRTL]) {
    // The leftView (or leading view) of a UITextField is placed before the text.  The rect
    // returned by UITextField::textRectThatFitsForBounds: returns a rect that fills the field
    // from the trailing edge of the leftView to the leading edge of the rightView.  Since this
    // rect is not used directly for the placeholder, the space for the leftView must calculated
    // to determine the correct origin for the placeholder view when rendering for RTL text.
    placeholderRect.origin.x =
        CGRectGetWidth(self.textField.bounds) - placeHolderWidth - placeholderLeftViewOffset;
  }
  placeholderRect.size.height = self.fontHeight;
  return placeholderRect;
}

- (CGRect)placeholderFloatingPositionFrame {
  CGRect placeholderRect = [self placeholderDefaultPositionFrame];
  if (CGRectIsEmpty(placeholderRect)) {
    return placeholderRect;
  }

  placeholderRect.origin.y -=
      MDCTextFieldFloatingLabelMargin + MDCTextFieldFloatingLabelTextHeight;

  // In RTL Layout, make the title view go up and to the right.
  if ([self shouldLayoutForRTL]) {
    placeholderRect.origin.x = CGRectGetWidth(self.textField.bounds)
        - placeholderRect.size.width * self.floatingTitleScale.a;
  }

  return placeholderRect;
}

- (CGFloat)placeHolderRequiredWidth {
  if (!self.textField.font) {
    return 0;
  }
  return [self.placeholder sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
}

- (void)animatePlaceholderUp {
  if (self.presentationStyle != GOOTextFieldPresentationStyleFloatingPlaceholder) {
    return;
  }

  // If there's an error, the view will already be up.
  if (!self.textField.text.length && !self.errorTextView) {
    CALayer *titleLayer = self.titleView.layer;

    CGRect destinationFrame = [self placeholderFloatingPositionFrame];

    CATransform3D titleScaleTransform = CATransform3DMakeAffineTransform(self.floatingTitleScale);

    CABasicAnimation *fontSizeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [fontSizeAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    [fontSizeAnimation setToValue:[NSValue valueWithCATransform3D:titleScaleTransform]];

    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [positionAnimation setFromValue:[NSValue valueWithCGPoint:[titleLayer position]]];
    [positionAnimation setToValue:[NSValue valueWithCGPoint:destinationFrame.origin]];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[ fontSizeAnimation, positionAnimation ];
    [titleLayer addAnimation:animationGroup forKey:@"animatePlaceholderUp"];
    self.titleView.transform = self.floatingTitleScale;
    self.titleView.center = destinationFrame.origin;
  }

  CALayer *frontTitleViewLayer = self.titleView.frontLayer;
  CAKeyframeAnimation *fontColorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
  fontColorAnimation.values = @[ @0, @0, @0.25, @1 ];

  [frontTitleViewLayer addAnimation:fontColorAnimation forKey:@"animatePlaceholderUp"];
  frontTitleViewLayer.opacity = 1;
}

- (void)animatePlaceholderDown {
  if (self.presentationStyle != GOOTextFieldPresentationStyleFloatingPlaceholder) {
    return;
  }

  // If there's an error, the placeholder should stay up.
  if (!self.textField.text.length && !self.errorTextView) {
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

- (void)setValidator:(id<GOOTextFieldValidator>)validator {
  if (_validator == validator) {
    return;
  }

  _validator = validator;
  if (self.validator) {
    [self validateEvents:GOOTextFieldValidatorEventPropertyChange];
  } else if (self.errorTextView) {
    [self.errorTextView removeFromSuperview];
    self.errorTextView = nil;
    [self.borderView setErroneous:NO];
  }
}

- (CGRect)errorTextFrame {
  CGRect bounds = self.textField.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect errorTextFrame = CGRectZero;
  errorTextFrame.size = [self.errorTextView sizeThatFits:bounds.size];
  if ([self shouldLayoutForRTL]) {
    errorTextFrame.origin.x = CGRectGetMaxX(bounds) - CGRectGetWidth(errorTextFrame);
  } else {
    errorTextFrame.origin.x = CGRectGetMinX(bounds);
  }
  CGRect borderFrame = [self borderViewFrame];
  errorTextFrame.origin.y =
      CGRectGetMaxY(borderFrame) + MDCTextFieldVerticalPadding - CGRectGetHeight(errorTextFrame);

  if (self.characterLimit) {
    CGRect characterLimitFrame = [self characterLimitFrame];
    if ([self shouldLayoutForRTL]) {
      errorTextFrame.size.width =
          CGRectGetMaxX(errorTextFrame) - CGRectGetMaxX(characterLimitFrame);
    } else {
      errorTextFrame.size.width =
          CGRectGetMinX(characterLimitFrame) - CGRectGetMinX(errorTextFrame);
    }
  }

  return errorTextFrame;
}

- (void)validateEvents:(GOOTextFieldValidatorEvent)events {
  if ([self shouldValidateEvents:events]) {
    [self performValidation];
  }
}

- (BOOL)canValidate {
  // Single line full width text fields do not support validators.
  if (!self.validator ||
      (!self.isMultiline && self.presentationStyle == GOOTextFieldPresentationStyleFullWidth)) {
    return NO;
  }

  if (![self.validator respondsToSelector:@selector(validationResultsForTextField:)]) {
    return NO;
  }
  return YES;
}

- (BOOL)shouldValidateEvents:(GOOTextFieldValidatorEvent)events {
  if (!self.canValidate) {
    return NO;
  }

  GOOTextFieldValidatorEvent allowedEvents = GOOTextFieldValidatorEventAll;
  if ([self.validator respondsToSelector:@selector(validateEventsForTextField:)]) {
    allowedEvents = [self.validator validateEventsForTextField:self.textField];
  }
  return ((allowedEvents & events) != GOOTextFieldValidatorEventNever);
}

- (void)performValidation {
  NSDictionary *validationResult = [self.validator validationResultsForTextField:self.textField];
  NSString *errorText = [validationResult objectForKey:MDCTextFieldValidatorErrorTextKey];
  UIColor *errorColor = [validationResult objectForKey:MDCTextFieldValidatorErrorColorKey];

  BOOL erroneous = ([errorText length] > 0);
  if (!erroneous) {
    errorColor = nil;

    [self.errorTextView removeFromSuperview];
    self.errorTextView = nil;
  } else {
    if (!self.errorTextView) {
      self.errorTextView = [[UILabel alloc] initWithFrame:CGRectZero];
      [self.errorTextView setTextAlignment:NSTextAlignmentLeft];
      [self.errorTextView setFont:[GOOTypography captionFont]];
      [self.textField insertSubview:self.errorTextView aboveSubview:self.titleView];
    }

    if (!errorColor) {
      errorColor = GOOTextFieldTextErrorColor();
    }
  }

  [self.borderView setErrorColor:errorColor];
  [self.borderView setErroneous:erroneous];
  [self.errorTextView setTextColor:errorColor];
  [self.errorTextView setText:errorText];

  if (self.errorTextView) {
    NSString *announcementString =
        [validationResult objectForKey:MDCTextFieldValidatorAXErrorTextKey];
    if (![announcementString length]) {
      announcementString = errorText;
    }

    // Simply sending a layout change notification does not seem to
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcementString);
  }

  [self.textField setNeedsLayout];
}

#pragma mark - Private

- (void)updateColors {
  self.textField.tintColor = self.colorGroup.regularColor;
  self.textField.textColor = self.textColor;

  self.borderView.focusedColor = self.textField.tintColor;
  self.borderView.unfocusedColor = self.borderColor;

  self.titleView.frontLayerColor = self.textField.tintColor.CGColor;
  self.titleView.backLayerColor = self.placeholderColor.CGColor;
}

- (UIView *)textFieldLabel {
  Class targetClass = NSClassFromString(@"UITextFieldLabel");
  // Loop through the text field's views until we find the UITextFieldLabel which is used for the
  // label in UITextField.
  NSMutableArray *toVisit = [NSMutableArray arrayWithArray:self.textField.subviews];
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
  return GOOCeil(self.textField.font.lineHeight);
}

- (NSUInteger)characterCount {
  return self.characterCounter
      ? [self.characterCounter characterCountForTextField:self.textField]
      : self.textField.text.length;
}

@end
