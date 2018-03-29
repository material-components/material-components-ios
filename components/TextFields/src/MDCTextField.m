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

#import "MDCTextField.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCTextFieldPositioningDelegate.h"
#import "MDCTextInput.h"
#import "MDCTextInputBorderView.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputUnderlineView.h"
#import "private/MDCTextInputCommonFundament.h"

#import "MaterialMath.h"
#import "MaterialTypography.h"

static NSString *const MDCTextFieldCursorColorKey = @"MDCTextFieldCursorColorKey";
static NSString *const MDCTextFieldFundamentKey = @"MDCTextFieldFundamentKey";
static NSString *const MDCTextFieldLeftViewModeKey = @"MDCTextFieldLeftViewModeKey";
static NSString *const MDCTextFieldRightViewModeKey = @"MDCTextFieldRightViewModeKey";

NSString *const MDCTextFieldTextDidSetTextNotification = @"MDCTextFieldTextDidSetTextNotification";

// The image we use for the clear button has a little too much air around it. So we have to shrink
// by this amount on each side.
static const CGFloat MDCTextInputClearButtonImageBuiltInPadding = -2.5f;
static const CGFloat MDCTextInputEditingRectRightViewPaddingCorrection = -2.f;

@interface MDCTextField () {
  UIColor *_cursorColor;
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

    if ([aDecoder containsValueForKey:MDCTextFieldFundamentKey]) {
      _fundament = [aDecoder decodeObjectOfClass:[MDCTextInputCommonFundament class]
                                          forKey:MDCTextFieldFundamentKey];
    } else {
      _fundament = [[MDCTextInputCommonFundament alloc] initWithTextInput:self];
    }

    [self commonMDCTextFieldInitialization];
    _cursorColor = [aDecoder decodeObjectForKey:MDCTextFieldCursorColorKey];

    self.leftViewMode =
        (UITextFieldViewMode)[aDecoder decodeIntegerForKey:MDCTextFieldLeftViewModeKey];
    self.rightViewMode =
        (UITextFieldViewMode)[aDecoder decodeIntegerForKey:MDCTextFieldRightViewModeKey];

    if (interfaceBuilderPlaceholder.length) {
      self.placeholder = interfaceBuilderPlaceholder;
    }

    [self setNeedsLayout];
  }
  return self;
}

- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:self.cursorColor forKey:MDCTextFieldCursorColorKey];
  [aCoder encodeObject:self.fundament forKey:MDCTextFieldFundamentKey];
  [aCoder encodeInteger:self.leftViewMode forKey:MDCTextFieldLeftViewModeKey];
  [aCoder encodeInteger:self.rightViewMode forKey:MDCTextFieldRightViewModeKey];
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

#pragma mark - Applying Color

- (void)applyCursorColor {
  self.tintColor = self.cursorColor;
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
  [super setTextColor:textColor];
  _fundament.textColor = textColor;
}

- (UIEdgeInsets)textInsets {
  return self.fundament.textInsets;
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
  [super setFont:font];
  [_fundament didSetFont];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  _fundament.enabled = enabled;
}

// In iOS 8, .leftView and .rightView are not swapped in RTL so we have to do that manually.
- (UIView *)leadingView {
  if ([self shouldManuallyEnforceRightToLeftLayoutForOverlayViews] &&
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    return self.rightView;
  }
  return self.leftView;
}

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

#pragma mark - UITextField Overrides

// This method doesn't have a positioning delegate mirror per se. But it uses the
// textInsets' value that the positioning delegate can return to inset this text rect.
- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = bounds;

  // Standard textRect calculation
  UIEdgeInsets textInsets = self.textInsets;
  textRect.origin.x += textInsets.left;
  textRect.size.width -= textInsets.left + textInsets.right;

  // Adjustments for .leftView, .rightView
  // When in RTL mode, the .rightView is presented using the leftViewRectForBounds frame and the
  // .leftView is presented using the rightViewRectForBounds frame.
  // To keep things simple, we correct this so .leftView gets the value for leftViewRectForBounds
  // and .rightView gets the value for rightViewRectForBounds.

  CGFloat leftViewWidth =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
          ? CGRectGetWidth([self rightViewRectForBounds:bounds])
          : CGRectGetWidth([self leftViewRectForBounds:bounds]);
  CGFloat rightViewWidth =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
          ? CGRectGetWidth([self leftViewRectForBounds:bounds])
          : CGRectGetWidth([self rightViewRectForBounds:bounds]);

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
    if (self.text.length > 0) {
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
      (CGRectGetHeight(bounds) / 2.f) - MDCRint(MAX(self.font.lineHeight,
                                                    self.placeholderLabel.font.lineHeight) /
                                                2.f);  // Text field or placeholder
  actualY = textInsets.top - actualY;
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
    if (self.text.length > 0) {
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

  if ([self.fundament.positioningDelegate
          respondsToSelector:@selector(editingRectForBounds:defaultRect:)]) {
    editingRect =
        [self.fundament.positioningDelegate editingRectForBounds:bounds defaultRect:editingRect];
  }

  return editingRect;
}

- (CGRect)clearButtonRectForBounds:(__unused CGRect)bounds {
  return self.clearButton.frame;
}

// NOTE: leftViewRectForBounds: and rightViewRectForBounds: should return LTR values regardless of
// layout direction. Then the OS flips it when it renders it.
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
  CGRect defaultRect = [super leftViewRectForBounds:bounds];
  defaultRect.origin.y = [self centerYForOverlayViews:CGRectGetHeight(defaultRect)];

  return defaultRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
  CGRect defaultRect = [super rightViewRectForBounds:bounds];
  defaultRect.origin.y = [self centerYForOverlayViews:CGRectGetHeight(defaultRect)];

  return defaultRect;
}

- (CGFloat)centerYForOverlayViews:(CGFloat)heightOfView {
  CGFloat centerY =
      self.textInsets.top + (self.placeholderLabel.font.lineHeight / 2.f) - (heightOfView / 2.f);
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
  CGFloat estimatedTextHeight = MDCCeil(self.font.lineHeight * scale) / scale;

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
  CGSize sizeThatFits = [self intrinsicContentSize];
  sizeThatFits.width = size.width;

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

  if ([self.positioningDelegate respondsToSelector:@selector(textInputDidLayoutSubviews)]) {
    [self.positioningDelegate textInputDidLayoutSubviews];
  }
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

- (NSString *)accessibilityValue {
  if (self.leadingUnderlineLabel.text.length > 0) {
    return [NSString stringWithFormat:@"%@ %@", [super accessibilityValue],
                                      self.leadingUnderlineLabel.accessibilityLabel];
  }

  return [super accessibilityValue];
}

@end
