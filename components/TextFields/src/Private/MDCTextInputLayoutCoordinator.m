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

#import "MDCTextField.h"
#import "MDCTextFieldPositioningDelegate.h"
#import "MDCTextInputLayoutCoordinator.h"

#import "MDCTextInput+Internal.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputUnderlineView.h"
#import "MaterialAnimationTiming.h"

NSString *const MDCTextInputValidatorErrorColorKey = @"MDCTextInputValidatorErrorColor";
NSString *const MDCTextInputValidatorErrorTextKey = @"MDCTextInputValidatorErrorText";
NSString *const MDCTextInputValidatorAXErrorTextKey = @"MDCTextInputValidatorAXErrorText";
static const CGFloat MDCTextInputVerticalPadding = 16.f;

static inline UIColor *MDCTextInputUnderlineColor() {
  return [UIColor lightGrayColor];
}

@interface MDCTextInputLayoutCoordinator ()

@property(nonatomic, readonly) BOOL canValidate;
@property(nonatomic, strong) UILabel *characterLimitView;
@property(nonatomic, strong) UILabel *errorTextView;
@property(nonatomic, strong) NSLayoutConstraint *placeholderHeight;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeadingLeftViewTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingRightViewLeading;
@property(nonatomic, weak) UIView<MDCControlledTextInput, MDCTextInput> *textInput;
@property(nonatomic, strong) MDCTextInputUnderlineView *underlineView;

@end

@implementation MDCTextInputLayoutCoordinator

// We never use the text property. Instead always read from the text field.

@synthesize attributedText = _do_no_use_attributedText;
@synthesize editing = _editing;
@synthesize hidesPlaceholderOnInput = _hidesPlaceholderOnInput;
@synthesize leadingUnderlineLabel = _leadingUnderlineLabel;
@synthesize placeholderLabel = _placeholderLabel;
@synthesize text = _do_no_use_text;
@synthesize textColor = _textColor;
@synthesize trailingUnderlineLabel = _trailingUnderlineLabel;
@synthesize underlineColor = _underlineColor;
@synthesize underlineView = _underlineView;

- (instancetype)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (nonnull instancetype)initWithTextField:(UIView<MDCControlledTextInput> *_Nonnull)textInput
                              isMultiline:(BOOL)isMultiline {
  self = [super init];
  if (self) {
    _textInput = textInput;

    _textColor = MDCTextInputTextColor();
    _underlineColor = MDCTextInputUnderlineColor();
    _cursorColor = MDCTextInputCursorColor();

    // Initialize elements of UI
    [self setupPlaceholderLabel];

    // This has to happen before the underline labels are added to the hierarchy.
    [self setupUnderlineView];
    [self setupUnderlineLabels];

    [self updateColors];
  }
  return self;
}

- (void)setupPlaceholderLabel {
  _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [_placeholderLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                                     forAxis:UILayoutConstraintAxisHorizontal];
  _placeholderLabel.textAlignment = NSTextAlignmentNatural;

  _placeholderLabel.userInteractionEnabled = NO;
  _placeholderLabel.opaque = NO;

  // TODO: (larche) Get real default placeholder text color.
  _placeholderLabel.textColor = [UIColor grayColor];
  _placeholderLabel.font = _textInput.font;

  [_textInput addSubview:_placeholderLabel];
  [_textInput sendSubviewToBack:_placeholderLabel];

  [NSLayoutConstraint activateConstraints:[self placeholderDefaultConstaints]];

  _hidesPlaceholderOnInput = YES;
}

- (void)setupUnderlineLabels {
  _leadingUnderlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _trailingUnderlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];

  // TODO: (larche) Get real default leading text color.
  _leadingUnderlineLabel.textColor = [UIColor grayColor];
  _leadingUnderlineLabel.font = _textInput.font;
  _leadingUnderlineLabel.textAlignment = NSTextAlignmentNatural;

  _leadingUnderlineLabel.opaque = NO;

  [_leadingUnderlineLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_textInput addSubview:_leadingUnderlineLabel];

  _trailingUnderlineLabel.textColor = [UIColor grayColor];
  _trailingUnderlineLabel.font = _textInput.font;

  _trailingUnderlineLabel.opaque = NO;

  [_trailingUnderlineLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_textInput addSubview:_trailingUnderlineLabel];

  NSString *horizontalString;
  horizontalString = @"H:|[leading]-4-[trailing]|";
  NSArray <NSLayoutConstraint *> *constraints = [NSLayoutConstraint
                                                 constraintsWithVisualFormat:horizontalString
                                                 options:0
                                                 metrics:nil
                                                 views:@{
                                                         @"leading" : _leadingUnderlineLabel,
                                                         @"trailing" : _trailingUnderlineLabel
                                                         }];
  for (NSLayoutConstraint *constraint in constraints) {
    constraint.priority = UILayoutPriorityDefaultLow;
  }

  [NSLayoutConstraint
      activateConstraints:constraints];

  NSLayoutConstraint *underlineBottom =
      [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_textInput
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0];
  underlineBottom.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *leadingTop = [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_underlineView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0];
  leadingTop.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *trailingBottom =
      [NSLayoutConstraint constraintWithItem:_trailingUnderlineLabel
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_textInput
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0];
  trailingBottom.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *trailingTop = [NSLayoutConstraint constraintWithItem:_trailingUnderlineLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_underlineView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1
                                                                  constant:0];
  trailingTop.priority = UILayoutPriorityDefaultLow;

  [NSLayoutConstraint
      activateConstraints:@[ underlineBottom, leadingTop, trailingBottom, trailingTop ]];

  [_trailingUnderlineLabel
      setContentCompressionResistancePriority:UILayoutPriorityRequired
                                      forAxis:UILayoutConstraintAxisHorizontal];
  [_trailingUnderlineLabel setContentHuggingPriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setupUnderlineView {
  _underlineView = [[MDCTextInputUnderlineView alloc] initWithFrame:[self underlineViewFrame]];
  _underlineView.color = self.underlineColor;

  [self.textInput addSubview:_underlineView];
  [self.textInput sendSubviewToBack:_underlineView];
}

- (void)didSetText {
  [self didChange];
  [self.textInput setNeedsLayout];
}

- (void)didSetFont {
  UIFont *font = self.textInput.font;
  self.placeholderLabel.font = font;

  [self updatePlaceholderPosition];
}

- (void)layoutSubviewsOfInput {
  self.underlineView.frame = [self underlineViewFrame];
  [self updatePlaceholderPosition];
  [self updatePlaceholderAlpha];
}

- (UIEdgeInsets)textContainerInset {
  UIEdgeInsets textContainerInset = UIEdgeInsetsZero;

  if (![self.textInput isKindOfClass:[UITextField class]]) {
    return textContainerInset;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;

  textContainerInset.top = MDCTextInputVerticalPadding;
  textContainerInset.bottom = MDCTextInputVerticalPadding;

  if ([textField.positioningDelegate respondsToSelector:@selector(textContainerInset:)]) {
    return [textField.positioningDelegate textContainerInset:textContainerInset];
  }
  return textContainerInset;
}

- (void)didBeginEditing {
  // TODO: (larche) Check this removal of underlineViewMode.

  // TODO: (larche) Maybe add getting rid of placeholder when typing by default. OR leave it on for
  // autocomplete.
}

- (void)didEndEditing {
  // TODO: (larche) Check this removal of underlineViewMode.
}

- (void)didChange {
  [self updatePlaceholderAlpha];
  [self updatePlaceholderPosition];
}

#pragma mark - Underline View Implementation

- (void)setUnderlineColor:(UIColor *)underlineColor {
  if (!underlineColor) {
    underlineColor = MDCTextInputUnderlineColor();
  }

  if (_underlineColor != underlineColor) {
    _underlineColor = underlineColor;
    [self updateColors];
  }
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

  if ([self.textInput isKindOfClass:[UITextView class]]) {
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

- (CGFloat)underlineHeight {
  return self.underlineView.lineHeight;
}

- (void)setUnderlineHeight:(CGFloat)underlineHeight {
  self.underlineView.lineHeight = underlineHeight;
}

#pragma mark - Properties Implementation

- (NSAttributedString *)attributedPlaceholder {
  id placeholderString = self.placeholderLabel.text;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    // TODO: (larche) Return string attributes also. Tho I feel like that should come from the
    // placeholderLabel
    NSAttributedString *constructedString =
        [[NSAttributedString alloc] initWithString:(NSString *)placeholderString attributes:nil];
    return constructedString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return (NSAttributedString *)placeholderString;
  }

  return nil;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  self.placeholderLabel.text = attributedPlaceholder.string;
  // TODO: (larche) Read string attributes also. Tho I feel like that should come from the
  // placeholderLabel

  [self updatePlaceholderAlpha];
  [self.textInput setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  self.underlineView.enabled = enabled;
}

- (UIFont *)font {
  return self.textInput.font;
}

- (void)setFont:(UIFont *)font {
  [self.textInput setFont:font];
}

- (NSString *)placeholder {
  id placeholderString = self.placeholderLabel.text;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    return (NSString *)placeholderString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return [(NSAttributedString *)placeholderString string];
  }

  return nil;
}

- (void)setPlaceholder:(NSString *)placeholder {
  self.placeholderLabel.text = placeholder;
  [self updatePlaceholderAlpha];
  [self.textInput setNeedsLayout];
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

// TODO: (larche) Check this removal of setUnderlineViewMode.
- (void)updatePlaceholderPosition {
  if (self.placeholderLabel.layer.animationKeys.count > 0) {
    // We don't need to get in the middle of animations.
    return;
  }

  CGRect destinationFrame = [self placeholderDefaultPositionFrame];

  self.placeholderHeight.constant = CGRectGetHeight(destinationFrame);

  [self updatePlaceholderPositionOverlays];
}

- (void)updatePlaceholderPositionOverlays {
  if (![self.textInput isKindOfClass:[MDCTextField class]]) {
    return;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;
  if (textField.leftView.superview && !self.placeholderLeadingLeftViewTrailing) {
    self.placeholderLeadingLeftViewTrailing =
        [NSLayoutConstraint constraintWithItem:textField.placeholderLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:textField.leftView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:0];
    self.placeholderLeadingLeftViewTrailing.priority = UILayoutPriorityDefaultLow + 1;
    self.placeholderLeadingLeftViewTrailing.active = YES;
  } else if (!textField.leftView.superview && self.placeholderLeadingLeftViewTrailing) {
    self.placeholderLeadingLeftViewTrailing = nil;
  }

  if (textField.rightView.superview && !self.placeholderTrailingRightViewLeading) {
    self.placeholderTrailingRightViewLeading =
    [NSLayoutConstraint constraintWithItem:textField.placeholderLabel
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                    toItem:textField.rightView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:0];
    self.placeholderTrailingRightViewLeading.priority = UILayoutPriorityDefaultLow + 1;
    self.placeholderTrailingRightViewLeading.active = YES;
  } else if (!textField.rightView.superview && self.placeholderTrailingRightViewLeading) {
    self.placeholderTrailingRightViewLeading = nil;
  }
}

// TODO: (larche) Replace with only needed information or remove altogether.
- (CGRect)placeholderDefaultPositionFrame {
  CGRect bounds = self.textInput.bounds;
  if (CGRectIsEmpty(bounds)) {
    return bounds;
  }

  CGRect placeholderRect = [self.textInput textRectThatFitsForBounds:bounds];
  return placeholderRect;
}

- (NSArray<NSLayoutConstraint *> *)placeholderDefaultConstaints {
  CGRect placeholderRect = [self placeholderDefaultPositionFrame];

  self.placeholderTop = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_placeholderLabel.superview
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0];

  // This can be affected by .leftView and .rightView.
  // See updatePlaceholderPositionOverlays()
  self.placeholderLeading =
      [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_placeholderLabel.superview
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:CGRectGetMinX(placeholderRect)];
  self.placeholderTrailing =
      [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                      toItem:_placeholderLabel.superview
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:8];
  self.placeholderHeight = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1
                                                         constant:CGRectGetHeight(placeholderRect)];

  [self.placeholderTop setPriority:UILayoutPriorityDefaultLow];
  [self.placeholderLeading setPriority:UILayoutPriorityDefaultLow];
  [self.placeholderTrailing setPriority:UILayoutPriorityDefaultLow];
  [self.placeholderHeight setPriority:UILayoutPriorityDefaultLow];

  return @[ self.placeholderHeight, self.placeholderTop, self.placeholderLeading,
            self.placeholderTrailing ];
}

- (void)updatePlaceholderAlpha {
  if (!self.hidesPlaceholderOnInput) {
    return;
  }
  CGFloat opacity = self.textInput.text.length ? 0 : 1;
  self.placeholderLabel.alpha = opacity;
}

- (CGFloat)underlineLabelRequiredHeight:(UILabel *)label {
  if (!label.font) {
    return 0;
  }
  return [label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

#pragma mark - Private

- (void)updateColors {
  self.textInput.tintColor = self.cursorColor;
  self.textInput.textColor = self.textColor;

  self.underlineView.color = self.underlineColor;
}

@end
