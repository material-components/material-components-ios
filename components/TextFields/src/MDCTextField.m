// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCTextField.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCTextFieldPositioningDelegate.h"
#import "MDCTextInputBorderView.h"
#import "MDCTextInputUnderlineView.h"
#import "private/MDCTextField+Testing.h"
#import "private/MDCTextInputCommonFundament.h"

#import "MaterialMath.h"
#import "MaterialTypography.h"

NSString *const MDCTextFieldTextDidSetTextNotification = @"MDCTextFieldTextDidSetTextNotification";
NSString *const MDCTextInputDidToggleEnabledNotification =
    @"MDCTextInputDidToggleEnabledNotification";

// The image we use for the clear button has a little too much air around it. So we have to shrink
// by this amount on each side.
static const CGFloat MDCTextInputClearButtonImageBuiltInPadding = (CGFloat)-2.5;
static const CGFloat MDCTextInputEditingRectRightViewPaddingCorrection = -2;
static const CGFloat MDCTextInputTextRectYCorrection = 1;

@interface MDCTextField () {
  UIColor *_cursorColor;

  UILabel *_inputLayoutStrut;
}

@property(nonatomic, strong) MDCTextInputCommonFundament *fundament;

/**
 Constraint for center Y of the underline view.

 Default constant: self.top + font line height + MDCTextInputHalfPadding.
 eg: ~4 pts below the input rect.
 */
@property(nonatomic, strong) NSLayoutConstraint *underlineY;

@end

@implementation MDCTextField

@dynamic borderStyle;
@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;
@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _fundament = [[MDCTextInputCommonFundament alloc] initWithTextInput:self];

    [self commonMDCTextFieldInitialization];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    NSString *interfaceBuilderPlaceholder = super.placeholder;

    _fundament = [[MDCTextInputCommonFundament alloc] initWithTextInput:self];

    [self commonMDCTextFieldInitialization];

    if (interfaceBuilderPlaceholder.length) {
      self.placeholder = interfaceBuilderPlaceholder;
    }
    self.placeholderLabel.backgroundColor = self.backgroundColor;

    [self setNeedsLayout];
  }
  return self;
}

- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self];
}

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCTextField *copy = [[[self class] alloc] initWithFrame:self.frame];

  copy.cursorColor = self.cursorColor;
  copy.fundament = [self.fundament copy];
  copy.enabled = self.isEnabled;
  if ([self.leadingView conformsToProtocol:@protocol(NSCopying)]) {
    copy.leadingView = [self.leadingView copy];
  }
  copy.leadingViewMode = self.leadingViewMode;
  copy.placeholder = [self.placeholder copy];
  copy.text = [self.text copy];
  copy.clearButton.tintColor = self.clearButton.tintColor;
  if ([self.trailingView conformsToProtocol:@protocol(NSCopying)]) {
    copy.trailingView = [self.trailingView copy];
  }
  copy.trailingViewMode = self.trailingViewMode;

  return copy;
}

- (void)commonMDCTextFieldInitialization {
  [super setBorderStyle:UITextBorderStyleNone];

  // Set the clear button color to black with 54% opacity.
  self.clearButton.tintColor = [UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]];

  _cursorColor = MDCTextInputCursorColor();
  [self applyCursorColor];

  [self setupUnderlineConstraints];

  [self setupInputLayoutStrut];

  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidBeginEditing:)
                        name:UITextFieldTextDidBeginEditingNotification
                      object:self];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidChange:)
                        name:UITextFieldTextDidChangeNotification
                      object:self];

  [self setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1
                                        forAxis:UILayoutConstraintAxisVertical];
  _mdc_overrideBaseElevation = -1;
}

#pragma mark - Underline View Implementation

- (void)setupUnderlineConstraints {
  NSLayoutConstraint *underlineLeading =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  underlineLeading.priority = UILayoutPriorityDefaultLow;
  underlineLeading.active = YES;

  NSLayoutConstraint *underlineTrailing =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:0];
  underlineTrailing.priority = UILayoutPriorityDefaultLow;
  underlineTrailing.active = YES;

  _underlineY =
      [NSLayoutConstraint constraintWithItem:self.underline
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:[self textInsets].top + [self estimatedTextHeight] +
                                             MDCTextInputHalfPadding];
  _underlineY.priority = UILayoutPriorityDefaultLow;
  _underlineY.active = YES;
}

- (CGFloat)underlineYConstant {
  return [self textInsets].top + [self estimatedTextHeight] + MDCTextInputHalfPadding;
}

- (BOOL)needsUpdateUnderlinePosition {
  return !MDCCGFloatEqual(self.underlineY.constant, [self underlineYConstant]);
}

- (void)updateUnderlinePosition {
  self.underlineY.constant = [self underlineYConstant];
  [self invalidateIntrinsicContentSize];
}

#pragma mark - Border Implementation

- (UIBezierPath *)defaultBorderPath {
  CGRect borderBound = self.bounds;
  borderBound.size.height = CGRectGetMaxY(self.underline.frame);
  return [UIBezierPath
      bezierPathWithRoundedRect:borderBound
              byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                    cornerRadii:CGSizeMake(MDCTextInputBorderRadius, MDCTextInputBorderRadius)];
}

- (void)updateBorder {
  self.borderView.borderPath = self.borderPath;
}

#pragma mark - Input Layout Strut Implementation

- (void)setupInputLayoutStrut {
  self.inputLayoutStrut.hidden = YES;
  self.inputLayoutStrut.numberOfLines = 1;

  [self addSubview:self.inputLayoutStrut];
}

- (void)updateInputLayoutStrut {
  self.inputLayoutStrut.font = self.font;
  self.inputLayoutStrut.text = self.text;

  UIEdgeInsets insets = [self textInsets];
  self.inputLayoutStrut.frame =
      CGRectMake(insets.left, insets.top, CGRectGetWidth(self.bounds) - insets.right,
                 self.inputLayoutStrut.intrinsicContentSize.height);
}

#pragma mark - Applying Color

- (void)applyCursorColor {
  self.tintColor = self.cursorColor;
}

#pragma mark - MDCLeadingViewTextInput Implementation

- (void)setLeadingView:(UIView *)leadingView {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    self.rightView = leadingView;
  } else {
    self.leftView = leadingView;
  }
}

- (UITextFieldViewMode)leadingViewMode {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    return self.rightViewMode;
  }
  return self.leftViewMode;
}

- (void)setLeadingViewMode:(UITextFieldViewMode)leadingViewMode {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    self.rightViewMode = leadingViewMode;
  } else {
    self.leftViewMode = leadingViewMode;
  }
}

#pragma mark - Properties Implementation

- (UIBezierPath *)borderPath {
  return self.fundament.borderPath ? self.fundament.borderPath : [self defaultBorderPath];
}

- (void)setBorderPath:(UIBezierPath *)borderPath {
  if (![self.fundament.borderPath isEqual:borderPath]) {
    self.fundament.borderPath = borderPath;
    [self updateBorder];
  }
}

- (MDCTextInputBorderView *)borderView {
  return self.fundament.borderView;
}

- (void)setBorderView:(MDCTextInputBorderView *)borderView {
  self.fundament.borderView = borderView;
}

- (UIButton *)clearButton {
  return _fundament.clearButton;
}

- (UIColor *)cursorColor {
  return _cursorColor ?: MDCTextInputCursorColor();
}

- (void)setCursorColor:(UIColor *)cursorColor {
  _cursorColor = cursorColor;
  [self applyCursorColor];
}

- (BOOL)hidesPlaceholderOnInput {
  return _fundament.hidesPlaceholderOnInput;
}

- (void)setHidesPlaceholderOnInput:(BOOL)hidesPlaceholderOnInput {
  _fundament.hidesPlaceholderOnInput = hidesPlaceholderOnInput;
}

- (UILabel *)inputLayoutStrut {
  if (!_inputLayoutStrut) {
    _inputLayoutStrut = [[UILabel alloc] initWithFrame:CGRectZero];
  }
  return _inputLayoutStrut;
}

- (UILabel *)leadingUnderlineLabel {
  return _fundament.leadingUnderlineLabel;
}

- (UILabel *)placeholderLabel {
  return _fundament.placeholderLabel;
}

- (id<MDCTextInputPositioningDelegate>)positioningDelegate {
  return _fundament.positioningDelegate;
}

- (void)setPositioningDelegate:(id<MDCTextInputPositioningDelegate>)positioningDelegate {
  _fundament.positioningDelegate = positioningDelegate;
}

- (UIColor *)textColor {
  return _fundament.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  // This identity check was added in
  // https://github.com/material-components/material-components-ios/pull/9480 in response to
  // b/148159587
  if (textColor != self.textColor) {
    [super setTextColor:textColor];
    _fundament.textColor = textColor;
  }
}

- (UIEdgeInsets)textInsets {
  return self.fundament.textInsets;
}

- (CGFloat)sizeThatFitsWidthHint {
  return self.fundament.sizeThatFitsWidthHint;
}

- (void)setSizeThatFitsWidthHint:(CGFloat)sizeThatFitsWidthHint {
  self.fundament.sizeThatFitsWidthHint = sizeThatFitsWidthHint;
}

- (MDCTextInputTextInsetsMode)textInsetsMode {
  return self.fundament.textInsetsMode;
}

- (void)setTextInsetsMode:(MDCTextInputTextInsetsMode)textInsetsMode {
  self.fundament.textInsetsMode = textInsetsMode;
}

- (UILabel *)trailingUnderlineLabel {
  return _fundament.trailingUnderlineLabel;
}

// In iOS 8, .leftView and .rightView are not swapped in RTL so we have to do that manually.
- (UIView *)trailingView {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    return self.leftView;
  }
  return self.rightView;
}

- (void)setTrailingView:(UIView *)trailingView {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    self.leftView = trailingView;
  } else {
    self.rightView = trailingView;
  }
}

- (UITextFieldViewMode)trailingViewMode {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    return self.leftViewMode;
  }
  return self.rightViewMode;
}

- (void)setTrailingViewMode:(UITextFieldViewMode)trailingViewMode {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    self.leftViewMode = trailingViewMode;
  } else {
    self.rightViewMode = trailingViewMode;
  }
}

- (MDCTextInputUnderlineView *)underline {
  return _fundament.underline;
}

- (BOOL)hasTextContent {
  return self.text.length > 0;
}

- (void)clearText {
  self.text = nil;
}

#pragma mark - UITextField Property Overrides

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_0)
- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  [super setAdjustsFontForContentSizeCategory:adjustsFontForContentSizeCategory];
  [self mdc_setAdjustsFontForContentSizeCategory:adjustsFontForContentSizeCategory];
}
#endif

- (NSAttributedString *)attributedPlaceholder {
  return _fundament.attributedPlaceholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  [super setAttributedPlaceholder:attributedPlaceholder];
  _fundament.attributedPlaceholder = attributedPlaceholder;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  [super setBackgroundColor:backgroundColor];

  self.placeholderLabel.backgroundColor = backgroundColor;
}

- (UITextFieldViewMode)clearButtonMode {
  return _fundament.clearButtonMode;
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
  _fundament.clearButtonMode = clearButtonMode;
}

- (void)setFont:(UIFont *)font {
  UIFont *previousFont = self.font;
  [super setFont:font];
  [_fundament didSetFont:previousFont];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  _fundament.enabled = enabled;
  [[NSNotificationCenter defaultCenter]
      postNotificationName:MDCTextInputDidToggleEnabledNotification
                    object:self];
}

// In iOS 8, .leftView and .rightView are not swapped in RTL so we have to do that manually.
- (UIView *)leadingView {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    return self.rightView;
  }
  return self.leftView;
}

- (NSString *)placeholder {
  return self.fundament.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [super setPlaceholder:placeholder];
  [self.fundament setPlaceholder:placeholder];
}

// Note: this is also called by the internals of UITextField when editing ends (iOS 8 to 10).
- (void)setText:(NSString *)text {
  [super setText:text];
  [_fundament didSetText];

  if (!self.isFirstResponder) {
    [[NSNotificationCenter defaultCenter]
        postNotificationName:MDCTextFieldTextDidSetTextNotification
                      object:self];
  }
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
  [super setAttributedText:attributedText];
  [_fundament didSetText];

  if (!self.isFirstResponder) {
    [[NSNotificationCenter defaultCenter]
        postNotificationName:MDCTextFieldTextDidSetTextNotification
                      object:self];
  }
}

#pragma mark - UITextField Overrides

// This method doesn't have a positioning delegate mirror per se. But it uses the
// textInsets' value that the positioning delegate can return to inset this text rect.
- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = bounds;

  // Standard textRect calculation
  UIEdgeInsets textInsets = self.textInsets;
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    textRect.origin.x += textInsets.right;
  } else {
    textRect.origin.x += textInsets.left;
  }
  textRect.size.width -= textInsets.left + textInsets.right;

  // Adjustments for .leftView, .rightView
  // When in RTL mode, the .rightView is presented using the leftViewRectForBounds frame and the
  // .leftView is presented using the rightViewRectForBounds frame.
  // To keep things simple, we correct this so .leftView gets the value for leftViewRectForBounds
  // and .rightView gets the value for rightViewRectForBounds.

  CGFloat leadingViewPadding = 0;
  if ([self.positioningDelegate respondsToSelector:@selector(leadingViewTrailingPaddingConstant)]) {
    leadingViewPadding = [self.positioningDelegate leadingViewTrailingPaddingConstant];
  }

  CGFloat trailingViewPadding = 0;
  if ([self.positioningDelegate
          respondsToSelector:@selector(trailingViewTrailingPaddingConstant)]) {
    trailingViewPadding = [self.positioningDelegate trailingViewTrailingPaddingConstant];
  }

  CGFloat leftViewWidth =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
          ? CGRectGetWidth([self rightViewRectForBounds:bounds])
          : CGRectGetWidth([self leftViewRectForBounds:bounds]);
  leftViewWidth +=
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
          ? trailingViewPadding
          : leadingViewPadding;

  CGFloat rightViewWidth =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
          ? CGRectGetWidth([self leftViewRectForBounds:bounds])
          : CGRectGetWidth([self rightViewRectForBounds:bounds]);
  rightViewWidth +=
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
          ? leadingViewPadding
          : trailingViewPadding;

  if (self.leftView.superview) {
    textRect.origin.x += leftViewWidth;
    textRect.size.width -= leftViewWidth;
  }

  if (self.rightView.superview) {
    textRect.size.width -= rightViewWidth;
    // If there is a rightView, the clearButton will not be shown.
  } else {
    CGFloat clearButtonWidth = CGRectGetWidth(self.clearButton.bounds);
    clearButtonWidth += 2 * MDCTextInputClearButtonImageBuiltInPadding;

    // Clear buttons are only shown if there is entered text or programatically set text to clear.
    if (self.hasTextContent) {
      switch (self.clearButtonMode) {
        case UITextFieldViewModeAlways:
        case UITextFieldViewModeUnlessEditing:
          textRect.size.width -= clearButtonWidth;
          break;
        default:
          break;
      }
    }
  }

  // UITextFields have a centerY based layout. And you can change EITHER the height or the Y. Not
  // both. Don't know why. So, we have to leave the text rect as big as the bounds and move it to a
  // Y that works.
  CGFloat actualY =
      (CGRectGetHeight(bounds) / 2) - rint(MAX(self.font.lineHeight,
                                               self.placeholderLabel.font.lineHeight) /
                                           2);  // Text field or placeholder
  actualY = textInsets.top - actualY + MDCTextInputTextRectYCorrection;
  textRect.origin.y = actualY;

  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    // Now that the text field is laid out as if it were LTR, we can flip it if necessary.
    textRect = MDFRectFlippedHorizontally(textRect, CGRectGetWidth(bounds));
  }

  return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  // First the textRect is loaded. Then it's shaved for cursor and/or clear button.
  CGRect editingRect = [self textRectForBounds:bounds];

  // The textRect comes to us flipped for RTL (if RTL) so we flip it back before adjusting.
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    editingRect = MDFRectFlippedHorizontally(editingRect, CGRectGetWidth(bounds));
  }

  // UITextFields show EITHER the clear button or the rightView. If the rightView has a superview,
  // then it's being shown and the clear button isn't.
  if (self.rightView.superview) {
    editingRect.size.width += MDCTextInputEditingRectRightViewPaddingCorrection;
  } else {
    if (self.hasTextContent) {
      CGFloat clearButtonWidth = CGRectGetWidth(self.clearButton.bounds);

      // The width is adjusted by the padding twice: once for the right side, once for left.
      clearButtonWidth += 2 * MDCTextInputClearButtonImageBuiltInPadding;

      // The clear button's width is already subtracted from the textRect.width if .always or
      // .unlessEditing.
      switch (self.clearButtonMode) {
        case UITextFieldViewModeUnlessEditing:
          editingRect.size.width += clearButtonWidth;
          break;
        case UITextFieldViewModeWhileEditing:
          editingRect.size.width -= clearButtonWidth;
          break;
        default:
          break;
      }
    }
  }

  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    editingRect = MDFRectFlippedHorizontally(editingRect, CGRectGetWidth(bounds));
  }

  if ([self.fundament.positioningDelegate respondsToSelector:@selector(editingRectForBounds:
                                                                                defaultRect:)]) {
    editingRect = [self.fundament.positioningDelegate editingRectForBounds:bounds
                                                               defaultRect:editingRect];
  }

  return editingRect;
}

- (CGRect)clearButtonRectForBounds:(__unused CGRect)bounds {
  return self.clearButton.frame;
}

// In RTL, the OS assigns this to the .rightView.
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
  CGRect leftViewRect = [super leftViewRectForBounds:bounds];
  leftViewRect.origin.y = [self centerYForOverlayViews:CGRectGetHeight(leftViewRect)];

  if ((self.mdf_effectiveUserInterfaceLayoutDirection ==
       UIUserInterfaceLayoutDirectionRightToLeft) &&
      [self.positioningDelegate respondsToSelector:@selector(trailingViewRectForBounds:
                                                                           defaultRect:)]) {
    leftViewRect = [self.positioningDelegate trailingViewRectForBounds:bounds
                                                           defaultRect:leftViewRect];
  } else if ((self.mdf_effectiveUserInterfaceLayoutDirection ==
              UIUserInterfaceLayoutDirectionLeftToRight) &&
             [self.positioningDelegate respondsToSelector:@selector(leadingViewRectForBounds:
                                                                                 defaultRect:)]) {
    leftViewRect = [self.positioningDelegate leadingViewRectForBounds:bounds
                                                          defaultRect:leftViewRect];
  }

  return leftViewRect;
}

// In RTL, the OS assigns this to the .leftView.
- (CGRect)rightViewRectForBounds:(CGRect)bounds {
  CGRect rightViewRect = [super rightViewRectForBounds:bounds];
  rightViewRect.origin.y = [self centerYForOverlayViews:CGRectGetHeight(rightViewRect)];

  if ((self.mdf_effectiveUserInterfaceLayoutDirection ==
       UIUserInterfaceLayoutDirectionRightToLeft) &&
      [self.positioningDelegate respondsToSelector:@selector(leadingViewRectForBounds:
                                                                          defaultRect:)]) {
    rightViewRect = [self.positioningDelegate leadingViewRectForBounds:bounds
                                                           defaultRect:rightViewRect];
  } else if ((self.mdf_effectiveUserInterfaceLayoutDirection ==
              UIUserInterfaceLayoutDirectionLeftToRight) &&
             [self.positioningDelegate respondsToSelector:@selector(trailingViewRectForBounds:
                                                                                  defaultRect:)]) {
    rightViewRect = [self.positioningDelegate trailingViewRectForBounds:bounds
                                                            defaultRect:rightViewRect];
  }
  return rightViewRect;
}

- (CGFloat)centerYForOverlayViews:(CGFloat)heightOfView {
  CGFloat centerY =
      self.textInsets.top + (self.placeholderLabel.font.lineHeight / 2) - (heightOfView / 2);
  return centerY;
}

#pragma mark - UITextField Draw Overrides

- (void)drawPlaceholderInRect:(__unused CGRect)rect {
  // We implement our own placeholder that is managed by the fundament. However, to observe normal
  // VO placeholder behavior, we still set the placeholder on the UITextField, and need to not draw
  // it here.
}

#pragma mark - Layout (Custom)

- (CGFloat)estimatedTextHeight {
  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat estimatedTextHeight = ceil(self.font.lineHeight * scale) / scale;

  return estimatedTextHeight;
}

#pragma mark - Layout (UIView)

- (CGSize)intrinsicContentSize {
  CGSize boundingSize = CGSizeZero;
  boundingSize.width = UIViewNoIntrinsicMetric;

  boundingSize.height =
      [self textInsets].top + [self estimatedTextHeight] + [self textInsets].bottom;

  return boundingSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
  self.sizeThatFitsWidthHint = size.width;
  CGSize sizeThatFits = [self intrinsicContentSize];
  sizeThatFits.width = self.sizeThatFitsWidthHint;
  self.sizeThatFitsWidthHint = 0;
  return sizeThatFits;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [_fundament layoutSubviewsOfInput];
  if ([self needsUpdateUnderlinePosition]) {
    [self setNeedsUpdateConstraints];
  }
  [self updateBorder];
  [self applyCursorColor];
  [self updateInputLayoutStrut];

  if ([self.positioningDelegate respondsToSelector:@selector(textInputDidLayoutSubviews)]) {
    [self.positioningDelegate textInputDidLayoutSubviews];
  }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (CGFloat)mdc_currentElevation {
  return 0;
}

- (void)updateConstraints {
  [_fundament updateConstraintsOfInput];

  [self updateUnderlinePosition];
  [super updateConstraints];
  if ([self.positioningDelegate respondsToSelector:@selector(textInputDidUpdateConstraints)]) {
    [self.positioningDelegate textInputDidUpdateConstraints];
  }
}

+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

- (UIView *)viewForFirstBaselineLayout {
  return self.inputLayoutStrut;
}

- (UIView *)viewForLastBaselineLayout {
  return self.inputLayoutStrut;
}

#pragma mark - UITextField Notification Observation

- (void)textFieldDidBeginEditing:(__unused NSNotification *)note {
  [_fundament didBeginEditing];
}

- (void)textFieldDidChange:(__unused NSNotification *)note {
  [_fundament didChange];
}

- (void)textFieldDidEndEditing:(__unused NSNotification *)note {
  [_fundament didEndEditing];
}

#pragma mark - RTL

// TODO: (larche) remove when we drop iOS 8
// Prior to iOS 9 RTL was not automatically applied, so we need to apply fixes manually.
- (BOOL)shouldManuallyEnforceRightToLeftLayoutForOverlayViews {
  NSOperatingSystemVersion iOS9Version = {9, 0, 0};
  NSProcessInfo *processInfo = [NSProcessInfo processInfo];
  return ![processInfo isOperatingSystemAtLeastVersion:iOS9Version];
}

#pragma mark - Accessibility

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _fundament.mdc_adjustsFontForContentSizeCategory;
}

// TODO: (larche) remove when we drop iOS 9
- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  // Prior to iOS 10 dynamic type was not automatically applied.
  if ([super respondsToSelector:@selector(setAdjustsFontForContentSizeCategory:)]) {
    [super setAdjustsFontForContentSizeCategory:adjusts];
  }

  [_fundament mdc_setAdjustsFontForContentSizeCategory:adjusts];
}

/*
 Returns a combination of the following:
 -  The superclass `accessibilityLabel` value
 -  The placeholder label.
 -  The leading underline label (if not nil).
 -  The trailing underline label (if not nil).
 */
- (NSString *)accessibilityLabel {
  NSMutableArray *accessibilityStrings = [[NSMutableArray alloc] init];
  if ([super accessibilityLabel].length > 0) {
    [accessibilityStrings addObject:[super accessibilityLabel]];
  } else if (self.placeholderLabel.accessibilityLabel.length > 0) {
    [accessibilityStrings addObject:self.placeholderLabel.accessibilityLabel];
  }
  if (self.leadingUnderlineLabel.accessibilityLabel.length > 0) {
    [accessibilityStrings addObject:self.leadingUnderlineLabel.accessibilityLabel];
  }
  if (self.trailingUnderlineLabel.accessibilityLabel.length > 0) {
    [accessibilityStrings addObject:self.trailingUnderlineLabel.accessibilityLabel];
  }
  return accessibilityStrings.count > 0 ? [accessibilityStrings componentsJoinedByString:@", "]
                                        : nil;
}

- (NSString *)accessibilityValue {
  // If there is no text, return nothing. If there is placeholder text, we don't want it returning
  // that as the `accessibilityValue`. Instead, we should only return user-input text.
  if (self.text.length > 0) {
    return [super accessibilityValue];
  }

  // Returning nil here causes iOS to default to [super accessibilityValue], which results in both
  // accessibilityValue and accessibilityLabel being read out by VoiceOver, so we return the empty
  // string instead.
  return @"";
}

#pragma mark - Testing

- (void)clearButtonDidTouch {
  [_fundament clearButtonDidTouch];
}

@end
