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

#import "MDCTextInputControllerTextArea.h"

#import "MDCTextInputBorderView.h"
#import "private/MDCTextInputControllerDefault+Subclassing.h"

#import "MaterialMath.h"

/**
 Note: Right now this is a subclass of MDCTextInputControllerDefault since they share a vast
 majority of code. If the designs diverge further, this would make a good candidate for its own
 class.
 */

#pragma mark - Constants

static const CGFloat MDCTextInputTextFieldTextAreaFullPadding = 16.f;
static const CGFloat MDCTextInputTextFieldTextAreaHalfPadding = 8.f;

// The guidelines have 8 points of padding but since the fonts on iOS are slightly smaller, we need
// to add points to keep the versions at the same height.
static const CGFloat MDCTextInputTextFieldTextAreaPaddingAdjustment = 1.f;

#pragma mark - Class Properties

static UIRectCorner _roundedCornersDefault = UIRectCornerAllCorners;

@interface MDCTextInputControllerTextArea ()

@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;

@end

@implementation MDCTextInputControllerTextArea

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)input {
  NSAssert([input conformsToProtocol:@protocol(MDCMultilineTextInput)],
           @"This design is meant for multi-line text fields only.");
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

- (void)setFloatingEnabled:(__unused BOOL)floatingEnabled {
  // Unused. Floating is always enabled.
}

#pragma mark - MDCTextInputPositioningDelegate

- (void)textInputDidLayoutSubviews {
  [self updateBorder];
}

- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textInsets = [super textInsets:defaultInsets];
  textInsets.top =
      MDCTextInputTextFieldTextAreaHalfPadding + MDCTextInputTextFieldTextAreaPaddingAdjustment +
      MDCRint(self.textInput.placeholderLabel.font.lineHeight *
              (CGFloat)self.floatingPlaceholderScale.floatValue) +
      MDCTextInputTextFieldTextAreaHalfPadding + MDCTextInputTextFieldTextAreaPaddingAdjustment;

  // .bottom = underlineOffset + the half padding above the line but below the text field and any
  // space needed for the labels and / or line.
  // Legacy has an additional half padding here but this version does not.
  CGFloat underlineOffset = [self underlineOffset];

  textInsets.bottom = underlineOffset;
  textInsets.left = MDCTextInputTextFieldTextAreaFullPadding;
  textInsets.right = MDCTextInputTextFieldTextAreaFullPadding;

  return textInsets;
}

#pragma mark - Layout

- (void)updateBorder {
  [super updateBorder];
  UIColor *borderColor = self.textInput.isEditing ? self.activeColor : self.normalColor;
  self.textInput.borderView.borderStrokeColor =
      (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) ? self.errorColor
                                                                           : borderColor;
  self.textInput.borderView.borderPath.lineWidth = self.textInput.isEditing ? 2 : 1;
}

- (void)updateLayout {
  [super updateLayout];

  if (!self.textInput) {
    return;
  }

  NSAssert([self.textInput conformsToProtocol:@protocol(MDCMultilineTextInput)],
           @"This design is meant for multi-line text fields only.");
  if (![self.textInput conformsToProtocol:@protocol(MDCMultilineTextInput)]) {
    return;
  }

  ((UIView<MDCMultilineTextInput> *)self.textInput).expandsOnOverflow = NO;
  ((UIView<MDCMultilineTextInput> *)self.textInput).minimumLines = 5;

  self.textInput.underline.alpha = 0;

  if (!self.placeholderTop) {
    self.placeholderTop =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:MDCTextInputTextFieldTextAreaFullPadding];
    self.placeholderTop.priority = UILayoutPriorityDefaultHigh;
    self.placeholderTop.active = YES;
  }
}

// The measurement from bottom to underline center Y.
- (CGFloat)underlineOffset {
  // The amount of space underneath the underline depends on whether there is content in the
  // underline labels.
  CGFloat underlineLabelsOffset = 0;
  CGFloat scale = UIScreen.mainScreen.scale;

  if (self.textInput.leadingUnderlineLabel.text.length) {
    underlineLabelsOffset =
        MDCCeil(self.textInput.leadingUnderlineLabel.font.lineHeight * scale) / scale;
  }
  if (self.textInput.trailingUnderlineLabel.text.length || self.characterCountMax) {
    underlineLabelsOffset =
        MAX(underlineLabelsOffset,
            MDCCeil(self.textInput.trailingUnderlineLabel.font.lineHeight * scale) / scale);
  }

  CGFloat underlineOffset = underlineLabelsOffset;
  underlineOffset += MDCTextInputTextFieldTextAreaHalfPadding;

  if (!MDCCGFloatEqual(underlineLabelsOffset, 0)) {
    underlineOffset += MDCTextInputTextFieldTextAreaHalfPadding;
  }

  return underlineOffset;
}

@end
