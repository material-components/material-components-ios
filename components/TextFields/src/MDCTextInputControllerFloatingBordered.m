/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTextInputControllerFloatingBordered.h"

#import "MDCTextInputBorderView.h"
#import "private/MDCTextInputControllerDefault+Subclassing.h"

#pragma mark - Class Properties

static const CGFloat MDCTextInputTextFieldBoxFullPadding = 16.f;
static const CGFloat MDCTextInputTextFieldBoxHalfPadding = 8.f;

static UIRectCorner _roundedCornersDefault = UIRectCornerAllCorners;

@implementation MDCTextInputControllerFloatingBordered

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)input {
  NSAssert([input isKindOfClass:[MDCMultilineTextField class]], @"This design is meant for single-line text fields only. For a complementary multi-line style, see MDCTextInputControllerTextArea.");
  self = [super initWithTextInput:input];
  if (self) {

  }
  return self;
}

#pragma mark - Properties Implementations

+ (UIRectCorner)roundedCornersDefault {
  return _roundedCornersDefault;
}

+ (void)setRoundedCornersDefault:(UIRectCorner)roundedCornersDefault {
  _roundedCornersDefault = roundedCornersDefault;
}

- (BOOL)isFloatingEnabled {
  return YES;
}

- (void)setFloatingEnabled:(BOOL)floatingEnabled {
  // Unused. Floating is always enabled.
}

#pragma mark - MDCTextInputPositioningDelegate

- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textInsets = [super textInsets:defaultInsets];
  textInsets.top = MDCTextInputTextFieldBoxHalfPadding + MDCTextInputTextFieldBoxPaddingAdjustment +
  MDCRint(self.textInput.placeholderLabel.font.lineHeight *
          (CGFloat)self.floatingPlaceholderScale.floatValue) +
  MDCTextInputTextFieldBoxHalfPadding + MDCTextInputTextFieldBoxPaddingAdjustment;

  // .bottom = underlineOffset + the half padding above the line but below the text field and any
  // space needed for the labels and / or line.
  // Legacy has an additional half padding here but this version does not.
  CGFloat underlineOffset = [self underlineOffset];

  textInsets.bottom = underlineOffset;
  textInsets.left = MDCTextInputTextFieldBoxFullPadding;
  textInsets.right = MDCTextInputTextFieldBoxFullPadding;

  return textInsets;
}

#pragma mark - MDCTextInputControllerDefault overrides

- (void)textInputDidLayoutSubviews {
  [self updateBorder];

  [self.textInput setBackgroundColor:[UIColor whiteColor]];
}

- (void)updateBorder {
  [super updateBorder];
  UIColor *borderColor = self.textInput.isEditing ? self.activeColor : self.normalColor;
  self.textInput.borderView.borderStrokeColor =
      (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) ? self.errorColor
      : borderColor;
  self.textInput.borderView.borderPath.lineWidth = self.textInput.isEditing ? 2 : 1;
}

@end
