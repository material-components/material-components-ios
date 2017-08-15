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

static const CGFloat MDCTextInputTextFieldBoxFullPadding = 16.f;

// The guidelines have 8 points of padding but since the fonts on iOS are slightly smaller, we need
// to add points to keep the versions at the same height.
static const CGFloat MDCTextInputTextFieldBoxHalfPadding = 9.f;

#pragma mark - Class Properties

static UIRectCorner _cornersRoundedDefault = UIRectCornerAllCorners;

@interface MDCTextInputControllerTextArea()

@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;

@end

@implementation MDCTextInputControllerTextArea

#pragma mark - Properties Implementations

+ (UIRectCorner)cornersRoundedDefault {
  return _cornersRoundedDefault;
}

+ (void)setCornersRoundedDefault:(UIRectCorner)cornersRoundedDefault {
  _cornersRoundedDefault = cornersRoundedDefault;
}

- (BOOL)isFloatingEnabled {
  return YES;
}

- (void)setFloatingEnabled:(BOOL)floatingEnabled {
  // Unused. Floating is always enabled.
}

#pragma mark - MDCTextInputPositioningDelegate

- (void)textInputDidLayoutSubviews {
  [self updateBorder];
}

- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textInsets = [super textInsets:defaultInsets];
    textInsets.top = MDCTextInputTextFieldBoxHalfPadding + MDCRint(self.textInput.placeholderLabel.font.lineHeight *
                                                                   (CGFloat)self.floatingPlaceholderScale.floatValue) + MDCTextInputTextFieldBoxHalfPadding;

  // .bottom = underlineOffset + the half padding above the line but below the text field and any
  // space needed for the labels and / or line.
  // Legacy has an additional half padding here but this version does not.
  CGFloat underlineOffset = [self underlineOffset];



  textInsets.bottom = underlineOffset;
  textInsets.left = MDCTextInputTextFieldBoxFullPadding;
  textInsets.right = MDCTextInputTextFieldBoxHalfPadding;

  return textInsets;
}

#pragma mark - Layout

- (void)updateBorder {
  [super updateBorder];
  UIColor *borderColor = self.textInput.isEditing ? self.activeColor : self.normalColor;
  self.textInput.borderView.borderStrokeColor =
      (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) ? self.errorColor
      : borderColor;
}

- (void)updateLayout {
  [super updateLayout];

  if (!self.textInput) {
    return;
  }
  
  ((MDCMultilineTextField *)self.textInput).expandsOnOverflow = NO;
  ((MDCMultilineTextField *)self.textInput).minimumLines = 5;

  self.textInput.underline.alpha = 0;

  if (!self.placeholderTop) {
    self.placeholderTop = [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textInput attribute:NSLayoutAttributeTop multiplier:1 constant:MDCTextInputTextFieldBoxFullPadding];
    self.placeholderTop.priority = UILayoutPriorityDefaultHigh;
    self.placeholderTop.active = YES;
  }
}

// Measurement from bottom to underline center Y
- (CGFloat)underlineOffset {
  // The amount of space underneath the underline depends on whether there is content in the
  // underline labels.
  CGFloat underlineLabelsOffset = 0;
  if (self.textInput.leadingUnderlineLabel.text.length) {
    underlineLabelsOffset =
    MDCCeil(self.textInput.leadingUnderlineLabel.font.lineHeight * 2.f) / 2.f;
  }
  if (self.textInput.trailingUnderlineLabel.text.length || self.characterCountMax) {
    underlineLabelsOffset =
    MAX(underlineLabelsOffset,
        MDCCeil(self.textInput.trailingUnderlineLabel.font.lineHeight * 2.f) / 2.f);
  }

  CGFloat underlineOffset = underlineLabelsOffset;
  underlineOffset += MDCTextInputTextFieldBoxHalfPadding;

  if (!MDCCGFloatEqual(underlineLabelsOffset, 0)) {
    underlineOffset += MDCTextInputTextFieldBoxHalfPadding;
  }

  return underlineOffset;
}

@end
