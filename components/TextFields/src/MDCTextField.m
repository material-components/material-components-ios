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
#import "MDCTextInput+Internal.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputLayoutCoordinator.h"

static const CGFloat MDCClearButtonImageSystemSquareSize = 14.0f;
static const CGFloat MDCClearButtonImageSquareSize = 32.0f;

@interface MDCTextField () <MDCControlledTextInput>

@property(nonatomic, strong) MDCTextInputLayoutCoordinator *coordinator;
@property(nonatomic, strong) UIImage *clearButtonImage;
@property(nonatomic, readonly, weak) UIButton *internalClearButton;

@end

@implementation MDCTextField

@dynamic borderStyle;

@synthesize internalClearButton = _internalClearButton;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInitialization];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInitialization];
  }

  return self;
}

- (void)dealloc {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextFieldTextDidEndEditingNotification object:self];
  [defaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}

- (void)commonInitialization {
  _coordinator = [[MDCTextInputLayoutCoordinator alloc] initWithTextField:self isMultiline:NO];

  self.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];

  // Set the clear button color to black with 54% opacity.
  [self setClearButtonColor:[UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]]];

  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidBeginEditing:)
                        name:UITextFieldTextDidBeginEditingNotification
                      object:self];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidEndEditing:)
                        name:UITextFieldTextDidEndEditingNotification
                      object:self];
  [defaultCenter addObserver:self
                    selector:@selector(textFieldDidChange:)
                        name:UITextFieldTextDidChangeNotification
                      object:self];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [_coordinator layoutSubviewsOfInput];
}

- (CGSize)intrinsicContentSize {
  CGSize boundingSize = CGSizeZero;
  boundingSize.width = UIViewNoIntrinsicMetric;

  CGFloat height = 2 * MDCTextInputUnderlineVerticalPadding + MDCCeil(self.font.lineHeight) +
                   2 * MDCTextInputUnderlineVerticalSpacing +
                   MAX(MDCCeil(self.leadingUnderlineLabel.font.lineHeight),
                       MDCCeil(self.trailingUnderlineLabel.font.lineHeight));
  boundingSize.height = height;

  return boundingSize;
}

#pragma mark - Properties Implementation

- (void)setClearButtonColor:(UIColor *)clearButtonColor {
  if (_clearButtonColor != clearButtonColor) {
    _clearButtonColor = clearButtonColor;
    self.clearButtonImage = [self drawnClearButtonImage];
  }
}

- (BOOL)hidesPlaceholderOnInput {
  return _coordinator.hidesPlaceholderOnInput;
}

- (void)setHidesPlaceholderOnInput:(BOOL)hidesPlaceholderOnInput {
  _coordinator.hidesPlaceholderOnInput = hidesPlaceholderOnInput;
}

- (UILabel *)placeholderLabel {
  return _coordinator.placeholderLabel;
}

- (UILabel *)leadingUnderlineLabel {
  return _coordinator.leadingUnderlineLabel;
}

- (UIColor *)textColor {
  return _coordinator.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  [super setTextColor:textColor];
  _coordinator.textColor = textColor;
}

- (UIEdgeInsets)textContainerInset {
  return _coordinator.textContainerInset;
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

- (void)setText:(NSString *)text {
  [super setText:text];
  [_coordinator didSetText];
}

- (NSString *)placeholder {
  return self.coordinator.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [super setPlaceholder:placeholder];
  [self.coordinator setPlaceholder:placeholder];
}

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

#pragma mark - UITextField Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = [super textRectForBounds:bounds];
  UIEdgeInsets textContainerInset = [_coordinator textContainerInset];
  textRect.origin.x += textContainerInset.left;
  textRect.size.width -= textContainerInset.left + textContainerInset.right;

  switch (self.contentVerticalAlignment) {
    case UIControlContentVerticalAlignmentTop:
      // Shift the text rect down to accomodate text.
      textRect.origin.y += textContainerInset.top;
      break;
    case UIControlContentVerticalAlignmentBottom:
      // Shift the text rect up to accomodate text.
      textRect.origin.y -= textContainerInset.bottom;
      break;
    case UIControlContentVerticalAlignmentCenter:
    case UIControlContentVerticalAlignmentFill: {
      break;
    }
  }

  return CGRectIntegral(textRect);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  CGRect editingRect = [self textRectForBounds:bounds];

  if ([self.positioningDelegate respondsToSelector:@selector(editingRectForBounds:)]) {
    return [self.positioningDelegate editingRectForBounds:bounds defaultRect:editingRect];
  }

  return editingRect;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  CGRect clearButtonRect = [super clearButtonRectForBounds:bounds];

  // Get the clear button if it exists.
  UIButton *clearButton = self.internalClearButton;
  if (clearButton != nil) {
    // If the image is not our image, set it.
    if (clearButton.imageView.image != self.clearButtonImage) {
      [clearButton setImage:self.clearButtonImage forState:UIControlStateNormal];
      [clearButton setImage:self.clearButtonImage forState:UIControlStateHighlighted];
      [clearButton setImage:self.clearButtonImage forState:UIControlStateSelected];
    }

    // If the rect doesn't fit the image, adjust accordingly
    if (!CGSizeEqualToSize(clearButtonRect.size, self.clearButtonImage.size)) {
      // Resize and shift the clearButtonRect to fit the clearButtonImage
      CGFloat xDelta = (clearButtonRect.size.width - self.clearButtonImage.size.width) / 2.0f;
      CGFloat yDelta = (clearButtonRect.size.height - self.clearButtonImage.size.height) / 2.0f;
      clearButtonRect = CGRectInset(clearButtonRect, xDelta, yDelta);
    }
  }

  // [super clearButtonRectForBounds:] is rect integral centered. Instead, we need to center to the
  // text without calling textRectForBounds (which will cause a cycle).

  // Offset origin to center to the font height.
  clearButtonRect.origin.y = (MDCCeil(self.font.lineHeight) - clearButtonRect.size.height) / 2.0f;

  UIEdgeInsets textContainerInset = [_coordinator textContainerInset];
  switch (self.contentVerticalAlignment) {
    case UIControlContentVerticalAlignmentTop:
      clearButtonRect.origin.y += textContainerInset.top;
      break;
    case UIControlContentVerticalAlignmentBottom:
      clearButtonRect.origin.y =
          self.bounds.size.height - textContainerInset.bottom - CGRectGetMaxY(clearButtonRect);
      break;
    case UIControlContentVerticalAlignmentCenter:
    case UIControlContentVerticalAlignmentFill: {
      // Vertically center the clear rect based upon the center per the insets.
      CGRect tempRect = UIEdgeInsetsInsetRect(self.bounds, textContainerInset);
      CGFloat centerY = CGRectGetMidY(tempRect);
      CGFloat minY = clearButtonRect.size.height / 2.0f;
      clearButtonRect = CGRectMake(clearButtonRect.origin.x, centerY - minY,
                                   clearButtonRect.size.width, clearButtonRect.size.height);
      break;
    }
  }

  clearButtonRect = CGRectIntegral(clearButtonRect);

  if ([self.positioningDelegate
          respondsToSelector:@selector(clearButtonRectForBounds:defaultRect:)]) {
    return [self.positioningDelegate clearButtonRectForBounds:bounds defaultRect:clearButtonRect];
  }

  return clearButtonRect;
}

#pragma mark - UITextField Draw Overrides

- (void)drawPlaceholderInRect:(CGRect)rect {
  // We implement our own placeholder that is managed by the coordinator. However, to observe normal
  // VO placeholder behavior, we still set the placeholder on the UITextField, and need to not draw
  // it here.
}

#pragma mark - Clear Button Image

- (UIImage *)drawnClearButtonImage {
  CGFloat scale = [UIScreen mainScreen].scale;
  CGRect bounds = CGRectMake(0, 0, MDCClearButtonImageSquareSize, MDCClearButtonImageSquareSize);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
  [self.clearButtonColor setFill];
  [MDCPathForClearButtonImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

#pragma mark - UITextField Notification Observation

- (void)textFieldDidBeginEditing:(NSNotification *)note {
  [_coordinator didBeginEditing];
}

- (void)textFieldDidEndEditing:(NSNotification *)note {
  [_coordinator didEndEditing];
}

- (void)textFieldDidChange:(NSNotification *)note {
  [_coordinator didChange];
}

#pragma mark - MDCControlledTextInput

- (CGRect)textRectThatFitsForBounds:(CGRect)bounds {
  CGRect textRect = [self textRectForBounds:bounds];
  CGFloat fontHeight = MDCCeil(self.font.lineHeight);
  // The text rect has been shifted as necessary, but now needs to be sized accordingly.
  switch (self.contentVerticalAlignment) {
    case UIControlContentVerticalAlignmentTop:
      // We just need to update the height, which is handled generically below.
      break;
    case UIControlContentVerticalAlignmentBottom:
      textRect.origin.y = CGRectGetMaxY(textRect) - fontHeight;
      break;
    case UIControlContentVerticalAlignmentCenter:
    case UIControlContentVerticalAlignmentFill:
      textRect.origin.y = CGRectGetMidY(textRect) - (fontHeight / 2.0f);
      break;
  }
  textRect.size.height = fontHeight;
  return CGRectIntegral(textRect);
}

@end
