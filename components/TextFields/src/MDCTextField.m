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

#import "MDCTextInput+Internal.h"
#import "MDCTextInputCharacterCounter.h"
#import "MDCTextInputController.h"

// TODO(larche): Support left icon view with a enum property for the icon to show
// TODO(larche): Support in-line auto complete

static const CGSize MDCClearButtonImageDefaultSize = {14.0f, 14.0f};

@interface MDCTextField () <MDCControlledTextInput>

@property(nonatomic, strong) MDCTextInputController *controller;
@property(nonatomic, strong) CAShapeLayer *clearButtonImage;
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
  _controller = [[MDCTextInputController alloc] initWithTextField:self isMultiline:NO];

  self.tintColor = _controller.cursorColor;
  self.textColor = _controller.textColor;
  self.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];

  // Set the clear button color to black with 54% opacity.
  self.clearButtonColor = [UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]];

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
  BOOL animationsWereEnabled = [UIView areAnimationsEnabled];
  [UIView setAnimationsEnabled:NO];

  [super layoutSubviews];

  [_controller layoutSubviewsWithAnimationsDisabled];

  [UIView setAnimationsEnabled:animationsWereEnabled];
}

- (CGSize)sizeThatFits:(CGSize)size {
  // Use the super class implementation to get the correct width.
  size = [super sizeThatFits:size];

  UIEdgeInsets textContainerInset = _controller.textContainerInset;
  size.height = self.font.pointSize + textContainerInset.top + textContainerInset.bottom;

  return size;
}

- (CGSize)intrinsicContentSize {
  CGSize boundingSize = [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  if (boundingSize.width == CGFLOAT_MAX) {
    boundingSize.width = UIViewNoIntrinsicMetric;
  }

  if (boundingSize.height == CGFLOAT_MAX) {
    boundingSize.height = UIViewNoIntrinsicMetric;
  }

  return boundingSize;
}

#pragma mark - Properties Implementation

- (void)setClearButtonColor:(UIColor *)clearButtonColor {
  if (_clearButtonColor != clearButtonColor) {
    _clearButtonColor = clearButtonColor;
    self.clearButtonImage.fillColor = _clearButtonColor.CGColor;
  }
}


- (UILabel *)placeholderLabel {
  return _controller.placeholderLabel;
}

- (UILabel *)leadingUnderlineLabel {
  return _controller.leadingUnderlineLabel;
}

- (UIColor *)textColor {
  return _controller.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  [super setTextColor:textColor];
  _controller.textColor = textColor;
}

- (UILabel *)trailingUnderlineLabel {
  return _controller.trailingUnderlineLabel;
}

- (UIColor *)underlineColor {
  return _controller.underlineColor;
}

- (void)setUnderlineColor:(UIColor *)underlineColor {
  _controller.underlineColor = underlineColor;
}

- (CGFloat)underlineWidth {
  return _controller.underlineWidth;
}

- (void)setUnderlineWidth:(CGFloat)underlineWidth {
  _controller.underlineWidth = underlineWidth;
}


#pragma mark - UITextField Property Overrides

- (void)setText:(NSString *)text {
  [super setText:text];
  [_controller didSetText];
}

- (NSString *)placeholder {
  return self.controller.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [super setPlaceholder:placeholder];
  [self.controller setPlaceholder:placeholder];
}

- (NSAttributedString *)attributedPlaceholder {
  return _controller.attributedPlaceholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  [super setAttributedPlaceholder:attributedPlaceholder];
  _controller.attributedPlaceholder = attributedPlaceholder;
}

- (void)setFont:(UIFont *)font {
  [super setFont:font];
  [_controller didSetFont];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  _controller.enabled = enabled;
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
      if (CGSizeEqualToSize(button.imageView.image.size, MDCClearButtonImageDefaultSize)) {
        _internalClearButton = button;
        return _internalClearButton;
      }
    }
    [toVisit addObjectsFromArray:view.subviews];
    [toVisit removeObjectAtIndex:0];
  }
  return nil;
}




#pragma mark - UITextField Positioning Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect textRect = [super textRectForBounds:bounds];
  UIEdgeInsets textContainerInset = [_controller textContainerInset];
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
      // Vertically center the text rect based upon the center per the insets.
      CGRect tempRect = UIEdgeInsetsInsetRect(textRect, textContainerInset);
      CGFloat centerY = CGRectGetMidY(tempRect);
      CGFloat minY = textRect.size.height / 2.0f;
      textRect =
          CGRectMake(textRect.origin.x, centerY - minY, textRect.size.width, textRect.size.height);
      break;
    }
  }

  return CGRectIntegral(textRect);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  CGRect editingRect = [self textRectForBounds:bounds];

  // Full width text fields have their clear button in the horizontal margin, but because the
  // internal implementation of textRect calls [super clearButtonRectForBounds:] in its
  // implementation, our modifications are not picked up. Adjust accordingly.
//  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth) {
//    editingRect.size.width += MDCTextInputFullWidthHorizontalPadding;
//    // Full width text boxes have their character count on the text input line
//    if (self.characterLimit) {
//      editingRect.size.width -= _controller.characterLimitViewSize.width;
//      if ([_controller shouldLayoutForRTL]) {
//        editingRect.origin.x += _controller.characterLimitViewSize.width;
//      }
//    }
//  }
  return editingRect;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  CGRect clearButtonRect = [super clearButtonRectForBounds:bounds];

  // Get the clear button if it exists.
  UIButton *clearButton = self.internalClearButton;
  if (clearButton != nil) {
    // If the image is not our image, set it.

    // TODO(larche) Finish converting to layer.
    //    if (clearButton.imageView.image != self.clearButtonImage) {
    //      [clearButton setImage:self.clearButtonImage forState:UIControlStateNormal];
    //      [clearButton setImage:self.clearButtonImage forState:UIControlStateHighlighted];
    //      [clearButton setImage:self.clearButtonImage forState:UIControlStateSelected];
    //    }
    //
    //    // If the rect doesn't fit the image, adjust accordingly
    //    if (!CGSizeEqualToSize(clearButtonRect.size, self.clearButtonImage.size)) {
    //      // Resize and shift the clearButtonRect to fit the clearButtonImage
    //      CGFloat xDelta = (clearButtonRect.size.width - self.clearButtonImage.size.width) / 2.0f;
    //      CGFloat yDelta = (clearButtonRect.size.height - self.clearButtonImage.size.height) /
    //      2.0f;
    //      clearButtonRect = CGRectInset(clearButtonRect, xDelta, yDelta);
    //    }
  }

  // Full width text boxes have their character count on the text input line
//  if (self.presentationStyle == MDCTextInputPresentationStyleFullWidth && self.characterLimit) {
//    if ([_controller shouldLayoutForRTL]) {
//      clearButtonRect.origin.x += _controller.characterLimitViewSize.width;
//    } else {
//      clearButtonRect.origin.x -= _controller.characterLimitViewSize.width;
//    }
//  }

  // [super clearButtonRectForBounds:] is rect integral centered. Instead, we need to center to the
  // text without calling textRectForBounds (which will cause a cycle).

  // Offset origin to center to the font height.
  clearButtonRect.origin.y = (_controller.fontHeight - clearButtonRect.size.height) / 2.0f;

  UIEdgeInsets textContainerInset = [_controller textContainerInset];
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

  return CGRectIntegral(clearButtonRect);
}

#pragma mark - UITextField Draw Overrides

- (void)drawPlaceholderInRect:(CGRect)rect {
  // We implement our own placeholder that is managed by the controller. However, to observe normal
  // VO placeholder behavior, we still set the placeholder on the UITextField, and need to not draw
  // it here.
}

#pragma mark - UITextField Notification Observation

- (void)textFieldDidBeginEditing:(NSNotification *)note {
  [_controller didBeginEditing];
}

- (void)textFieldDidEndEditing:(NSNotification *)note {
  [_controller didEndEditing];
}

- (void)textFieldDidChange:(NSNotification *)note {
  [_controller didChange];
}

#pragma mark - MDCControlledTextInput

- (CGRect)textRectThatFitsForBounds:(CGRect)bounds {
  CGRect textRect = [self textRectForBounds:bounds];
  CGFloat fontHeight = _controller.fontHeight;
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

#pragma mark - Drawing

- (UIBezierPath *)pathForClearButtonImageFrame:(CGRect)frame {
  // GENERATED CODE

  CGRect innerBounds = CGRectMake(CGRectGetMinX(frame) + 10, CGRectGetMinY(frame) + 10,
                                  floor((frame.size.width - 10) * 0.73684 + 0.5),
                                  floor((frame.size.height - 10) * 0.73684 + 0.5));

  UIBezierPath *ic_clear_path = [UIBezierPath bezierPath];
  [ic_clear_path
      moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + 0.10107 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.89893 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.00000 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50000 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.39893 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.10107 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.00000 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.00000 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.10107 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.39893 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.50000 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.00000 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.89893 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.10107 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 1.00000 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50000 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.60107 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.89893 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 1.00000 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.89893 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.60107 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.50000 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000 * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.10107 * innerBounds.size.height)];
  [ic_clear_path closePath];

  return ic_clear_path;
}

@end
