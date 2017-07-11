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

#import "MDCTextFieldPositioningDelegate.h"
#import "MDCTextInputCharacterCounter.h"
#import "private/MDCTextInputCommonFundament.h"

#import "MaterialMath.h"
#import "MaterialRTL.h"
#import "MaterialTypography.h"

static NSString *const MDCTextFieldFundamentKey = @"MDCTextFieldFundamentKey";
NSString *const MDCTextFieldTextDidSetTextNotification = @"MDCTextFieldTextDidSetTextNotification";

// The image we use for the clear button has a little too much air around it. So we have to shrink
// by this amount on each side.
static const CGFloat MDCTextInputClearButtonImageBuiltInPadding = -2.5f;
static const CGFloat MDCTextInputEditingRectRightViewPaddingCorrection = -2.f;

@interface MDCTextField ()

@property(nonatomic, strong) MDCTextInputCommonFundament *fundament;

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
    [self commonMDCTextFieldInitialization];

    MDCTextInputCommonFundament *fundament = [aDecoder decodeObjectForKey:MDCTextFieldFundamentKey];
    _fundament =
        fundament ? fundament : [[MDCTextInputCommonFundament alloc] initWithTextInput:self];

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
  [aCoder encodeObject:self.fundament forKey:MDCTextFieldFundamentKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextField *copy = [[[self class] alloc] init];

  copy.fundament = [self.fundament copy];
  copy.enabled = self.isEnabled;
  copy.placeholder = [self.placeholder copy];
  copy.text = [self.text copy];

  return copy;
}

- (void)commonMDCTextFieldInitialization {
  [super setBorderStyle:UITextBorderStyleNone];

  // Set the clear button color to black with 54% opacity.
  [self setClearButtonColor:[UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]]];

  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidBeginEditing:)
                        name:UITextFieldTextDidBeginEditingNotification
                      object:self];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidChange:)
                        name:UITextFieldTextDidChangeNotification
                      object:self];
}

#pragma mark - Properties Implementation

- (UIButton *)clearButton {
  return _fundament.clearButton;
}

- (UIColor *)clearButtonColor {
  return _fundament.clearButtonColor;
}

- (void)setClearButtonColor:(UIColor *)clearButtonColor {
  _fundament.clearButtonColor = clearButtonColor;
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

- (UILabel *)trailingUnderlineLabel {
  return _fundament.trailingUnderlineLabel;
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

- (NSString *)placeholder {
  return self.fundament.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [super setPlaceholder:placeholder];
  [self.fundament setPlaceholder:placeholder];
}

// Note: this is also called by the internals of UITextField when editing ends.
- (void)setText:(NSString *)text {
  [super setText:text];
  [_fundament didSetText];
  [[NSNotificationCenter defaultCenter] postNotificationName:MDCTextFieldTextDidSetTextNotification
                                                      object:self];
}

#pragma mark - UITextField Overrides

// This method doesn't have a positioning delegate mirror per se. But it uses the
// textContainerInsets' value that the positioning delegate can return to inset this text rect.
- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = bounds;

  // Standard textRect calculation
  UIEdgeInsets textContainerInset = [_fundament textContainerInset];
  textRect.origin.x += textContainerInset.left;
  textRect.size.width -= textContainerInset.left + textContainerInset.right;

  // Adjustments for .leftView, .rightView
  // When in RTL mode, the .rightView is presented using the leftViewRectForBounds frame and the
  // .leftView is presented using the rightViewRectForBounds frame.
  // To keep things simple, we correct this so .leftView gets the value for leftViewRectForBounds
  // and .rightView gets the value for rightViewRectForBounds.

  CGFloat leftViewWidth =
      self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
          ? CGRectGetWidth([self rightViewRectForBounds:bounds])
          : CGRectGetWidth([self leftViewRectForBounds:bounds]);
  CGFloat rightViewWidth =
      self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
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
  actualY = textContainerInset.top - actualY;
  textRect.origin.y = actualY;

  if (self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    // Now that the text field is laid out as if it were LTR, we can flip it if necessary.
    textRect = MDCRectFlippedForRTL(textRect, CGRectGetWidth(bounds),
                                    UIUserInterfaceLayoutDirectionRightToLeft);
  }

  return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  // First the textRect is loaded. Then it's shaved for cursor and/or clear button.
  CGRect editingRect = [self textRectForBounds:bounds];

  // The textRect comes to us flipped for RTL (if RTL) so we flip it back before adjusting.
  if (self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    editingRect = MDCRectFlippedForRTL(editingRect, CGRectGetWidth(bounds),
                                       UIUserInterfaceLayoutDirectionRightToLeft);
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

  if (self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    editingRect = MDCRectFlippedForRTL(editingRect, CGRectGetWidth(bounds),
                                       UIUserInterfaceLayoutDirectionRightToLeft);
  }

  if ([self.fundament.positioningDelegate
          respondsToSelector:@selector(editingRectForBounds:defaultRect:)]) {
    editingRect =
        [self.fundament.positioningDelegate editingRectForBounds:bounds defaultRect:editingRect];
  }

  return editingRect;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  return self.clearButton.frame;
}

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
  CGFloat centerY = [_fundament textContainerInset].top +
                    (self.placeholderLabel.font.lineHeight / 2.f) - (heightOfView / 2.f);
  return centerY;
}

#pragma mark - UITextField Draw Overrides

- (void)drawPlaceholderInRect:(CGRect)rect {
  // We implement our own placeholder that is managed by the fundament. However, to observe normal
  // VO placeholder behavior, we still set the placeholder on the UITextField, and need to not draw
  // it here.
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
  CGSize boundingSize = CGSizeZero;
  boundingSize.width = UIViewNoIntrinsicMetric;

  CGFloat estimatedTextHeight = MDCCeil(self.font.lineHeight * 2.f) / 2.f;

  CGFloat height = MDCTextInputFullPadding + estimatedTextHeight + MDCTextInputHalfPadding * 2.f;

  CGFloat underlineLabelsHeight =
      MAX(MDCCeil(self.leadingUnderlineLabel.font.lineHeight * 2.f) / 2.f,
          MDCCeil(self.trailingUnderlineLabel.font.lineHeight * 2.f) / 2.f);
  height += underlineLabelsHeight;
  boundingSize.height = height;

  return boundingSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize sizeThatFits = [self intrinsicContentSize];
  sizeThatFits.width = size.width;

  if ([self.positioningDelegate respondsToSelector:@selector(sizeThatFits:defaultSize:)]) {
    sizeThatFits = [self.positioningDelegate sizeThatFits:size defaultSize:sizeThatFits];
  }
  return sizeThatFits;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [_fundament layoutSubviewsOfInput];
}

- (void)updateConstraints {
  [_fundament updateConstraintsOfInput];

  [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

#pragma mark - UITextField Notification Observation

- (void)textFieldDidBeginEditing:(NSNotification *)note {
  [_fundament didBeginEditing];
}

- (void)textFieldDidChange:(NSNotification *)note {
  [_fundament didChange];
}

- (void)textFieldDidEndEditing:(NSNotification *)note {
  [_fundament didEndEditing];
}

#pragma mark - Accessibility

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _fundament.mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  // Prior to iOS 9 RTL was not automatically applied, so we don't need to apply any fixes.
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
