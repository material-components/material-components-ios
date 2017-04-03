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

#import "MaterialTypography.h"

NSString *const MDCTextFieldClearButtonColorKey = @"MDCTextFieldClearButtonColorKey";
NSString *const MDCTextFieldClearButtonImageKey = @"MDCTextFieldClearButtonImageKey";
NSString *const MDCTextFieldCoordinatorKey = @"MDCTextFieldCoordinatorKey";

static const CGFloat MDCClearButtonImageSquareSize = 24.f;
static const CGFloat MDCClearButtonImageSystemSquareSize = 14.0f;
static const CGFloat MDCTextInputUnderlineVerticalSpacing = 8.f;

static inline CGFloat MDCCeil(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return ceil(value);
#else
  return ceilf(value);
#endif
}

@interface MDCTextField () <MDCControlledTextInput>

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
    [self commonMDCTextFieldInitialization];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCTextFieldInitialization];

    _clearButtonImage = [aDecoder decodeObjectForKey:MDCTextFieldClearButtonImageKey];
    _clearButtonColor = [aDecoder decodeObjectForKey:MDCTextFieldClearButtonColorKey];
    _coordinator = [aDecoder decodeObjectForKey:MDCTextFieldCoordinatorKey];
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
  _coordinator = [[MDCTextInputLayoutCoordinator alloc] initWithTextInput:self];

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

- (UIImage *)drawnClearButtonImage:(CGSize)size {
  if (CGSizeEqualToSize(size, CGSizeZero)) {
    size = CGSizeMake(MDCClearButtonImageSquareSize, MDCClearButtonImageSquareSize);
  }
  CGFloat scale = [UIScreen mainScreen].scale;
  CGRect bounds = CGRectMake(0, 0, size.width * scale, size.height * scale);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
  [self.clearButtonColor setFill];
  [MDCPathForClearButtonImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

#pragma mark - Properties Implementation

- (void)setClearButtonColor:(UIColor *)clearButtonColor {
  if (_clearButtonColor != clearButtonColor) {
    _clearButtonColor = clearButtonColor;
    self.clearButtonImage = [self drawnClearButtonImage:self.clearButtonImage.size];
  }
}

- (BOOL)hidesPlaceholderOnInput {
  return _coordinator.hidesPlaceholderOnInput;
}

- (void)setHidesPlaceholderOnInput:(BOOL)hidesPlaceholderOnInput {
  _coordinator.hidesPlaceholderOnInput = hidesPlaceholderOnInput;
}

- (UILabel *)leadingUnderlineLabel {
  return _coordinator.leadingUnderlineLabel;
}

- (UILabel *)placeholderLabel {
  return _coordinator.placeholderLabel;
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
      if (CGSizeEqualToSize(button.imageView.image.size,
                            CGSizeMake(MDCClearButtonImageSystemSquareSize,
                                       MDCClearButtonImageSystemSquareSize))) {
        _internalClearButton = button;
        return _internalClearButton;
      }
    }
    [toVisit addObjectsFromArray:view.subviews];
    [toVisit removeObjectAtIndex:0];
  }
  return nil;
}

- (NSString *)placeholder {
  return self.coordinator.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [super setPlaceholder:placeholder];
  [self.coordinator setPlaceholder:placeholder];
}

- (id<MDCTextInputPositioningDelegate>)positioningDelegate {
  return _coordinator.positioningDelegate;
}

- (void)setPositioningDelegate:(id<MDCTextInputPositioningDelegate>)positioningDelegate {
  _coordinator.positioningDelegate = positioningDelegate;
}

- (void)setText:(NSString *)text {
  [super setText:text];
  [_coordinator didSetText];
}

#pragma mark - UITextField Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = bounds;
  UIEdgeInsets textContainerInset = [_coordinator textContainerInset];
  textRect.origin.x += textContainerInset.left;
  textRect.size.width -= textContainerInset.left + textContainerInset.right;

  // UITextFields have a centerY based layout. But you can change EITHER the height or the Y. Not
  // both. Don't know why. So, we have to leave the text rect as big as the bounds and move it to a
  // Y that works.
  CGFloat actualY = (CGRectGetHeight(bounds) / 2.0) - self.font.lineHeight / 2.0;
  actualY = textContainerInset.top - actualY;

  textRect.origin.y = actualY;

  return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  CGRect editingRect = [self textRectForBounds:bounds];

  // The image for the clear button is sized by the scale of the screen pixel density. We need to
  // adjust for that while giving it room.
  CGFloat scale = [UIScreen mainScreen].scale;
  editingRect.size.width -= self.clearButtonImage.size.width / scale;

  if ([self.coordinator.positioningDelegate
          respondsToSelector:@selector(editingRectForBounds:defaultRect:)]) {
    return
        [self.coordinator.positioningDelegate editingRectForBounds:bounds defaultRect:editingRect];
  }

  return editingRect;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  CGRect clearButtonRect = [super clearButtonRectForBounds:bounds];

  // Get the clear button if it exists.
  UIButton *clearButton = self.internalClearButton;
  if (clearButton != nil) {
    if (!self.clearButtonImage || !CGSizeEqualToSize(self.clearButtonImage.size, clearButtonRect.size)) {
      self.clearButtonImage = [self drawnClearButtonImage:clearButtonRect.size];
    }

    // If the image is not our image, set it.
    if (clearButton.imageView.image != self.clearButtonImage) {
      [clearButton setImage:self.clearButtonImage forState:UIControlStateNormal];
      [clearButton setImage:self.clearButtonImage forState:UIControlStateHighlighted];
      [clearButton setImage:self.clearButtonImage forState:UIControlStateSelected];
    }
  }

  UIEdgeInsets textContainerInset = [_coordinator textContainerInset];
  clearButtonRect.origin.y = textContainerInset.top;

  if ([self.coordinator.positioningDelegate
          respondsToSelector:@selector(clearButtonRectForBounds:defaultRect:)]) {
    return [self.coordinator.positioningDelegate clearButtonRectForBounds:bounds
                                                              defaultRect:clearButtonRect];
  }

  return clearButtonRect;
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

  CGFloat height = MDCTextInputUnderlineVerticalPadding + MDCCeil(self.font.lineHeight) +
    MDCTextInputUnderlineVerticalSpacing +
                   MAX(MDCCeil(self.leadingUnderlineLabel.font.lineHeight),
                       MDCCeil(self.trailingUnderlineLabel.font.lineHeight));
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

#pragma mark - MDCControlledTextInput

- (CGRect)textRectThatFitsForBounds:(CGRect)bounds {
  CGRect textRect = [self textRectForBounds:bounds];
  CGFloat fontHeight = MDCCeil(self.font.lineHeight);
  // The text rect has been shifted as necessary, but now needs to be sized accordingly.
  textRect.origin.y = CGRectGetMidY(textRect) - (fontHeight / 2.0f);
  textRect.size.height = fontHeight;
  return CGRectIntegral(textRect);
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

@end
