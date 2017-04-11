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

#import "MDCTextFieldArt.h"
#import "MDCTextFieldPositioningDelegate.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputLayoutCoordinator.h"

#import "MaterialRTL.h"
#import "MaterialTypography.h"

NSString *const MDCTextFieldClearButtonColorKey = @"MDCTextFieldClearButtonColorKey";
NSString *const MDCTextFieldClearButtonImageKey = @"MDCTextFieldClearButtonImageKey";
NSString *const MDCTextFieldCoordinatorKey = @"MDCTextFieldCoordinatorKey";
NSString *const MDCTextFieldTextDidSetTextNotification = @"MDCTextFieldTextDidSetTextNotification";

static const CGFloat MDCTextInputTextRectRightPaddingCorrection = -4.f;
static const CGFloat MDCTextInputEditingRectRightPaddingCorrection = -2.f;
static const CGFloat MDCTextInputEditingRectClearPaddingCorrection = -8.f;

const CGFloat MDCClearButtonImageSquareSize = 24.f;
static const CGFloat MDCClearButtonImageSystemSquareSize = 14.0f;

static inline CGFloat MDCRound(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return rint(value);
#else
  return rintf(value);
#endif
}

@interface MDCTextField ()

@property(nonatomic, strong) UIImage *clearButtonImage;
@property(nonatomic, strong) MDCTextInputLayoutCoordinator *coordinator;
@property(nonatomic, readonly, weak) UIButton *internalClearButton;

@end

@implementation MDCTextField

@dynamic borderStyle;

@synthesize internalClearButton = _internalClearButton;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _coordinator = [[MDCTextInputLayoutCoordinator alloc] initWithTextInput:self];

    [self commonMDCTextFieldInitialization];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    NSString *interfaceBuilderPlaceholder = super.placeholder;
    [self commonMDCTextFieldInitialization];

    _clearButtonImage = [aDecoder decodeObjectForKey:MDCTextFieldClearButtonImageKey];
    _clearButtonColor = [aDecoder decodeObjectForKey:MDCTextFieldClearButtonColorKey];
    _coordinator = [aDecoder decodeObjectForKey:MDCTextFieldCoordinatorKey]
                       ?: [[MDCTextInputLayoutCoordinator alloc] initWithTextInput:self];

    if (interfaceBuilderPlaceholder.length) {
      self.placeholder = interfaceBuilderPlaceholder;
    }
    [self setNeedsLayout];
  }
  return self;
}

- (instancetype)initWithLeftView:(UIView *)leftView {
  self = [self initWithFrame:CGRectZero];
  if (self) {
    self.leftView = leftView;
  }
  return self;
}

- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:self.clearButtonColor forKey:MDCTextFieldClearButtonColorKey];
  [aCoder encodeObject:self.clearButtonImage forKey:MDCTextFieldClearButtonImageKey];
  [aCoder encodeConditionalObject:self.coordinator forKey:MDCTextFieldCoordinatorKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextField *copy = [[[self class] alloc] init];

  copy.clearButtonColor = self.clearButtonColor.copy;
  copy.clearButtonImage = self.clearButtonImage.copy;

  // Just a pointer value copies.
  copy.coordinator = self.coordinator;

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

#pragma mark - Clear Button Image

- (UIImage *)drawnClearButtonImage:(CGSize)size color:(UIColor *)color {
  if (CGSizeEqualToSize(size, CGSizeZero)) {
    size = CGSizeMake(MDCClearButtonImageSquareSize, MDCClearButtonImageSquareSize);
  }
  CGFloat scale = [UIScreen mainScreen].scale;
  CGRect bounds = CGRectMake(0, 0, size.width * scale, size.height * scale);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
  [color setFill];
  [MDCPathForClearButtonImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

#pragma mark - Properties Implementation

- (void)setClearButtonColor:(UIColor *)clearButtonColor {
  if (![_clearButtonColor isEqual:clearButtonColor]) {
    _clearButtonColor = clearButtonColor;
    self.clearButtonImage = [self drawnClearButtonImage:self.clearButtonImage.size color:_clearButtonColor];
  }
}

- (BOOL)hidesPlaceholderOnInput {
  return _coordinator.hidesPlaceholderOnInput;
}

- (void)setHidesPlaceholderOnInput:(BOOL)hidesPlaceholderOnInput {
  _coordinator.hidesPlaceholderOnInput = hidesPlaceholderOnInput;
}

- (UIButton *)internalClearButton {
  if (_internalClearButton != nil) {
    return _internalClearButton;
  }
  Class targetClass = [UIButton class];
  // Loop through child views until we find the UIButton that is used to display the clear button
  // internally in UITextField.
  NSMutableArray *toVisit = [NSMutableArray arrayWithArray:self.subviews];
  while ([toVisit count]) {
    UIView *view = [toVisit objectAtIndex:0];
    if ([view isKindOfClass:targetClass]) {
      UIButton *button = (UIButton *)view;
      // In case other buttons exist, do our best to ensure this is the clear button
      if (button.imageView.image.size.width == MDCClearButtonImageSystemSquareSize ||
          button.imageView.image.size.width == MDCClearButtonImageSquareSize) {
        _internalClearButton = button;
        return _internalClearButton;
      }
    }
    [toVisit addObjectsFromArray:view.subviews];
    [toVisit removeObjectAtIndex:0];
  }
  return nil;
}

- (UILabel *)leadingUnderlineLabel {
  return _coordinator.leadingUnderlineLabel;
}

- (UILabel *)placeholderLabel {
  return _coordinator.placeholderLabel;
}

- (id<MDCTextInputPositioningDelegate>)positioningDelegate {
  return _coordinator.positioningDelegate;
}

- (void)setPositioningDelegate:(id<MDCTextInputPositioningDelegate>)positioningDelegate {
  _coordinator.positioningDelegate = positioningDelegate;
}

- (UIColor *)textColor {
  return _coordinator.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  [super setTextColor:textColor];
  _coordinator.textColor = textColor;
}

- (UILabel *)trailingUnderlineLabel {
  return _coordinator.trailingUnderlineLabel;
}

- (UIColor *)underlineColor {
  return _coordinator.underlineColor;
}

- (void)setUnderlineColor:(UIColor *)underlineColor {
  _coordinator.underlineColor = underlineColor;
}

- (CGFloat)underlineHeight {
  return _coordinator.underlineHeight;
}

- (void)setUnderlineHeight:(CGFloat)underlineHeight {
  _coordinator.underlineHeight = underlineHeight;
}

#pragma mark - UITextField Property Overrides

- (NSAttributedString *)attributedPlaceholder {
  return _coordinator.attributedPlaceholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  [super setAttributedPlaceholder:attributedPlaceholder];
  _coordinator.attributedPlaceholder = attributedPlaceholder;
}

- (void)setFont:(UIFont *)font {
  [super setFont:font];
  [_coordinator didSetFont];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  _coordinator.enabled = enabled;
}

- (NSString *)placeholder {
  return self.coordinator.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [super setPlaceholder:placeholder];
  [self.coordinator setPlaceholder:placeholder];
}

- (void)setText:(NSString *)text {
  [super setText:text];
  [_coordinator didSetText];
  [[NSNotificationCenter defaultCenter] postNotificationName:MDCTextFieldTextDidSetTextNotification
                                                      object:self];
}

#pragma mark - UITextField Overrides

// This method doesn't have a positioning delegate mirror per se. But it uses the
// textContainerInsets value the positioning delegate can return to inset this text rect.
- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = bounds;

  // Standard textRect calculation
  UIEdgeInsets textContainerInset = [_coordinator textContainerInset];
  if (self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    textRect.origin.x += textContainerInset.right;
  } else {
    textRect.origin.x += textContainerInset.left;
  }
  textRect.size.width -= textContainerInset.left + textContainerInset.right;

  // Adjustments for .leftView, .rightView
  CGFloat leftViewWidth = CGRectGetWidth([self leftViewRectForBounds:bounds]);
  CGFloat rightViewWidth = CGRectGetWidth([self rightViewRectForBounds:bounds]);
  rightViewWidth += MDCTextInputTextRectRightPaddingCorrection;

  if (self.leftView.superview) {
    textRect.size.width -= leftViewWidth;
  }
  if (self.rightView.superview) {
    textRect.size.width -= rightViewWidth;
  }

  // Adjustments for RTL and clear button
  // .leftView and .rightView actually are leading and trailing: their placement is reversed in RTL.
  CGFloat scale = [UIScreen mainScreen].scale;
  CGFloat clearButtonWidth = self.clearButtonImage.size.width / scale;
  clearButtonWidth += MDCTextInputTextRectRightPaddingCorrection;

  if (self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    // EITHER the rightView or clear button will be shown.
    if (self.rightView.superview) {
      textRect.origin.x += rightViewWidth;
    } else {
      // Clear buttons are only shown if there is entered or set text to clear.
      if (self.text.length > 0) {
        switch (self.clearButtonMode) {
          case UITextFieldViewModeAlways:
          case UITextFieldViewModeUnlessEditing:
            textRect.size.width -= clearButtonWidth;
            textRect.origin.x += clearButtonWidth;
            break;
          default:
            break;
        }
      }
    }
  } else {
    if (self.leftView.superview) {
      textRect.origin.x += leftViewWidth;
    }
    if (self.rightView.superview) {
    } else {
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
  }

  // UITextFields have a centerY based layout. And you can change EITHER the height or the Y. Not
  // both. Don't know why. So, we have to leave the text rect as big as the bounds and move it to a
  // Y that works.
  CGFloat actualY =
      (CGRectGetHeight(bounds) / 2.f) - MDCRound(MAX(self.font.lineHeight,
                                                     self.placeholderLabel.font.lineHeight) /
                                                 2.f);  // Text field or placeholder
  actualY = textContainerInset.top - actualY;
  textRect.origin.y = actualY;

  return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  // First the textRect is loaded. Then it's shaved for cursor and/or clear button.
  CGRect editingRect = [self textRectForBounds:bounds];
  // UITextFields show EITHER the clear button or the rightView. If the rightView has a superview,
  // then it's being shown and the clear button isn't.
  if (!self.rightView.superview) {
    if (self.text.length > 0) {
      CGFloat scale = [UIScreen mainScreen].scale;
      CGFloat clearButtonWidth = self.clearButtonImage.size.width / scale;
      clearButtonWidth += MDCTextInputEditingRectClearPaddingCorrection;
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
  } else {
    editingRect.size.width += MDCTextInputEditingRectRightPaddingCorrection;
  }

  if ([self.coordinator.positioningDelegate
          respondsToSelector:@selector(editingRectForBounds:defaultRect:)]) {
    return
        [self.coordinator.positioningDelegate editingRectForBounds:bounds defaultRect:editingRect];
  }

  return editingRect;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  CGRect clearButtonRect = [super clearButtonRectForBounds:bounds];

  if (self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    clearButtonRect.origin.x = 0;
  } else {
    clearButtonRect.origin.x = CGRectGetWidth(bounds) - CGRectGetWidth(clearButtonRect);
  }

  // Get the clear button if it exists.
  UIButton *clearButton = self.internalClearButton;
  if (clearButton != nil) {
    if (!self.clearButtonImage ||
        !CGSizeEqualToSize(self.clearButtonImage.size, clearButtonRect.size)) {
      self.clearButtonImage = [self drawnClearButtonImage:clearButtonRect.size color:self.clearButtonColor];
    }

    // If the image is not our image, set it.
    if (clearButton.imageView.image != self.clearButtonImage) {
      [clearButton setImage:self.clearButtonImage forState:UIControlStateNormal];
      [clearButton setImage:self.clearButtonImage forState:UIControlStateHighlighted];
      [clearButton setImage:self.clearButtonImage forState:UIControlStateSelected];
    }
  }

  UIEdgeInsets textContainerInset = [_coordinator textContainerInset];
  // The clear button is a different height than the text field or placeholder. It's expected to be
  // Y-centered to the field or placeholder.
  CGFloat actualY = textContainerInset.top +
                    MAX(self.font.lineHeight, self.placeholderLabel.font.lineHeight) / 2.f;
  actualY = actualY - CGRectGetHeight(clearButtonRect) / 2.f;
  clearButtonRect.origin.y = actualY;

  if ([self.coordinator.positioningDelegate
          respondsToSelector:@selector(clearButtonRectForBounds:defaultRect:)]) {
    return [self.coordinator.positioningDelegate clearButtonRectForBounds:bounds
                                                              defaultRect:clearButtonRect];
  }
  return clearButtonRect;
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
  CGFloat centerY = [_coordinator textContainerInset].top +
                    (self.placeholderLabel.font.lineHeight / 2.f) - (heightOfView / 2.f);
  return centerY;
}

#pragma mark - UITextField Draw Overrides

- (void)drawPlaceholderInRect:(CGRect)rect {
  // We implement our own placeholder that is managed by the coordinator. However, to observe normal
  // VO placeholder behavior, we still set the placeholder on the UITextField, and need to not draw
  // it here.
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
  CGSize boundingSize = CGSizeZero;
  boundingSize.width = UIViewNoIntrinsicMetric;

  CGFloat height = MDCTextInputVerticalPadding + MDCRound(self.font.lineHeight) +
                   MDCTextInputUnderlineVerticalSpacing * 2.f;

  CGFloat underlineLabelsHeight =
      MAX(MDCRound(CGRectGetHeight(self.leadingUnderlineLabel.bounds)),
          MDCRound(CGRectGetHeight(self.trailingUnderlineLabel.bounds)));
  height += underlineLabelsHeight;
  boundingSize.height = height;

  return boundingSize;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [_coordinator layoutSubviewsOfInput];
}

- (void)updateConstraints {
  [_coordinator updateConstraintsOfInput];

  [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

#pragma mark - UITextField Notification Observation

- (void)textFieldDidBeginEditing:(NSNotification *)note {
  [_coordinator didBeginEditing];
}

- (void)textFieldDidChange:(NSNotification *)note {
  [_coordinator didChange];
}

#pragma mark - Accessibility

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _coordinator.mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  [_coordinator mdc_setAdjustsFontForContentSizeCategory:adjusts];
}

- (NSString *)accessibilityValue {
  if (self.leadingUnderlineLabel.text.length > 0) {
    return [NSString stringWithFormat:@"%@ %@", [super accessibilityValue],
                                      self.leadingUnderlineLabel.accessibilityLabel];
  }

  return [super accessibilityValue];
}

@end
