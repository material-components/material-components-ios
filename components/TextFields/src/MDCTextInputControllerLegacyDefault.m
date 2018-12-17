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

#import "MDCTextInputControllerLegacyDefault.h"

#import "MDCMultilineTextField.h"
#import "MDCTextInputUnderlineView.h"
#import "private/MDCTextInputArt.h"

#import "MaterialTypography.h"

#pragma mark - Constants

static const CGFloat MDCTextInputControllerLegacyDefaultClearButtonImageSquareWidthHeight = 24;
static const CGFloat MDCTextInputControllerLegacyDefaultUnderlineActiveHeight = 2;
static const CGFloat MDCTextInputControllerLegacyDefaultUnderlineNormalHeight = 1;
static const CGFloat MDCTextInputControllerLegacyDefaultVerticalHalfPadding = 8;
static const CGFloat MDCTextInputControllerLegacyDefaultVerticalPadding = 16;

static inline UIBezierPath *MDCTextInputControllerLegacyDefaultEmptyPath() {
  return [UIBezierPath bezierPath];
}

#pragma mark - Class Properties

static CGFloat _underlineHeightActiveLegacyDefault =
    MDCTextInputControllerLegacyDefaultUnderlineActiveHeight;
static CGFloat _underlineHeightNormalLegacyDefault =
    MDCTextInputControllerLegacyDefaultUnderlineNormalHeight;

@interface MDCTextInputControllerBase ()
- (void)setupInput;
@end

@implementation MDCTextInputControllerLegacyDefault

- (void)setupInput {
  [super setupInput];
  if (!self.textInput) {
    return;
  }
  [self setupClearButton];
}

- (MDCTextInputTextInsetsMode)textInsetModeDefault {
  return MDCTextInputTextInsetsModeIfContent;
}

- (void)setupClearButton {
  UIImage *image = [self
      drawnClearButtonImage:[UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]]];
  [self.textInput.clearButton setImage:image forState:UIControlStateNormal];
}

#pragma mark - Border Customization

- (void)updateBorder {
  self.textInput.borderPath = MDCTextInputControllerLegacyDefaultEmptyPath();
}

#pragma mark - Clear Button Customization

- (UIImage *)drawnClearButtonImage:(UIColor *)color {
  CGSize clearButtonSize =
      CGSizeMake(MDCTextInputControllerLegacyDefaultClearButtonImageSquareWidthHeight,
                 MDCTextInputControllerLegacyDefaultClearButtonImageSquareWidthHeight);

  CGFloat scale = [UIScreen mainScreen].scale;
  CGRect bounds = CGRectMake(0, 0, clearButtonSize.width * scale, clearButtonSize.height * scale);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
  [color setFill];

  [MDCPathForClearButtonLegacyImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  return image;
}

#pragma mark - Properties Implementation

+ (CGFloat)underlineHeightActiveDefault {
  return _underlineHeightActiveLegacyDefault;
}

+ (void)setUnderlineHeightActiveDefault:(CGFloat)underlineHeightActiveDefault {
  _underlineHeightActiveLegacyDefault = underlineHeightActiveDefault;
}

+ (CGFloat)underlineHeightNormalDefault {
  return _underlineHeightNormalLegacyDefault;
}

+ (void)setUnderlineHeightNormalDefault:(CGFloat)underlineHeightNormalDefault {
  _underlineHeightNormalLegacyDefault = underlineHeightNormalDefault;
}

- (UIRectCorner)roundedCorners {
  return 0;
}

- (void)setRoundedCorners:(__unused UIRectCorner)roundedCorners {
  // Not implemented. Corners are not rounded.
}

+ (UIRectCorner)roundedCornersDefault {
  return 0;
}

+ (void)setRoundedCornersDefault:(__unused UIRectCorner)roundedCornersDefault {
  // Not implemented. Corners are not rounded.
}

- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  // NOTE: UITextFields have a centerY based layout. But you can change EITHER the height or the Y.
  // Not both. Don't know why. So, we have to leave the text rect as big as the bounds and move it
  // to a Y that works. In other words, no bottom inset will make a difference here for UITextFields
  UIEdgeInsets textInsets = defaultInsets;

  if (!self.isFloatingEnabled) {
    return defaultInsets;
  }

  textInsets.top = MDCTextInputControllerLegacyDefaultVerticalPadding +
  MDCRint(self.textInput.placeholderLabel.font.lineHeight *
          (CGFloat)self.floatingPlaceholderScale.floatValue) +
  MDCTextInputControllerLegacyDefaultVerticalHalfPadding;
  return textInsets;
}

- (UIOffset)floatingPlaceholderOffset {
  CGFloat vertical = MDCTextInputControllerLegacyDefaultVerticalPadding;

  // Offsets needed due to transform working on normal (0.5,0.5) anchor point.
  // Why no anchor point of (0,0)? Because autolayout doesn't play well with anchor points.
  vertical -= self.textInput.placeholderLabel.font.lineHeight *
              (1 - (CGFloat)self.floatingPlaceholderScale.floatValue) * (CGFloat)0.5;

  // Remember, the insets are always in LTR. It's automatically flipped when used in RTL.
  // See MDCTextInputController.h.
  UIEdgeInsets insets = self.textInput.textInsets;

  CGFloat placeholderMaxWidth =
      CGRectGetWidth(self.textInput.bounds) / self.floatingPlaceholderScale.floatValue -
      insets.left - insets.right;

  CGFloat placeholderWidth =
      [self.textInput.placeholderLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]
      .width;
  if (placeholderWidth > placeholderMaxWidth) {
    placeholderWidth = placeholderMaxWidth;
  }

  CGFloat horizontal =
      placeholderWidth * (1 - (CGFloat)self.floatingPlaceholderScale.floatValue) * (CGFloat)0.5;

  return UIOffsetMake(horizontal, vertical);
}

@end
