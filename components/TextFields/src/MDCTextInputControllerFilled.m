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

#import "MDCTextInputControllerFilled.h"

#import "private/MDCTextInputArt.h"
#import "private/MDCTextInputControllerDefault+Subclassing.h"

#import "MaterialMath.h"

/**
 Note: Right now this is a subclass of MDCTextInputControllerDefault since they share a vast
 majority of code. If the designs diverge further, this would make a good candidate for its own
 class.
 */

#pragma mark - Constants

static const CGFloat MDCTextInputFilledClearButtonPaddingAddition = -2.f;
static const CGFloat MDCTextInputFilledFullPadding = 16.f;

// The guidelines have 8 points of padding but since the fonts on iOS are slightly smaller, we need
// to add points to keep the versions at the same height.
static const CGFloat MDCTextInputFilledHalfPadding = 8.f;
static const CGFloat MDCTextInputFilledHalfPaddingAddition = 1.f;
static const CGFloat MDCTextInputFilledNormalPlaceholderPadding = 20.f;

static inline UIColor *MDCTextInputDefaultBorderFillColorDefault() {
  return [UIColor colorWithWhite:0 alpha:.06f];
}

#pragma mark - Class Properties

static UIColor *_borderFillColorDefault;

static UIRectCorner _roundedCornersDefault = UIRectCornerAllCorners;

@interface MDCTextInputControllerFilled ()

@property(nonatomic, strong) NSLayoutConstraint *clearButtonBottom;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *underlineBottom;

@end

@implementation MDCTextInputControllerFilled

#pragma mark - Properties Implementations

+ (UIColor *)borderFillColorDefault {
  if (!_borderFillColorDefault) {
    _borderFillColorDefault = MDCTextInputDefaultBorderFillColorDefault();
  }
  return _borderFillColorDefault;
}

+ (UIRectCorner)roundedCornersDefault {
  return _roundedCornersDefault;
}

+ (void)setRoundedCornersDefault:(UIRectCorner)roundedCornersDefault {
  _roundedCornersDefault = roundedCornersDefault;
}

#pragma mark - MDCTextInputPositioningDelegate

// clang-format off
/**
 textInsets: is the source of truth for vertical layout. It's used to figure out the proper
 height and also where to place the placeholder / text field.



 NOTE: It's applied before the textRect is flipped for RTL. So all calculations are done here à la
 LTR.

 The vertical layout is, at most complex (floating), this form:
 MDCTextInputFilledHalfPadding +                                // Small padding
 MDCRint(self.textInput.placeholderLabel.font.lineHeight * scale) +   // Placeholder when up
 MDCTextInputDefaultVerticalHalfPadding +                             // Small padding
 MDCCeil(MAX(self.textInput.font.lineHeight,                          // Text field or placeholder line height
 self.textInput.placeholderLabel.font.lineHeight)) +
 MDCTextInputDefaultPadding +                                         // Padding to underline (equal to small padding)
 --Underline--                                                        // Underline (height not counted)
 underlineLabelsOffset                                                // Depends on text insets mode. See the super class.
 */
// clang-format on
- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textInsets = [super textInsets:defaultInsets];
  if (self.isFloatingEnabled) {
    textInsets.top =
        MDCTextInputFilledHalfPadding + MDCTextInputFilledHalfPaddingAddition +
        MDCRint(self.textInput.placeholderLabel.font.lineHeight *
                (CGFloat)self.floatingPlaceholderScale.floatValue) +
        MDCTextInputFilledHalfPadding + MDCTextInputFilledHalfPaddingAddition;
  } else {
    textInsets.top = MDCTextInputFilledNormalPlaceholderPadding;
  }

  textInsets.bottom = [self beneathInputPadding] + [self underlineOffset];

  textInsets.left = MDCTextInputFilledFullPadding;
  textInsets.right = MDCTextInputFilledHalfPadding;

  return textInsets;
}

- (void)updateLayout {
  [super updateLayout];

  if (!self.textInput) {
    return;
  }

  CGFloat clearButtonConstant =
      -1 * ([self beneathInputPadding] - MDCTextInputClearButtonImageBuiltInPadding +
            MDCTextInputFilledClearButtonPaddingAddition);
  if (!self.clearButtonBottom) {
    self.clearButtonBottom = [NSLayoutConstraint constraintWithItem:self.textInput.clearButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.textInput.underline
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:clearButtonConstant];
    self.clearButtonBottom.active = YES;
  }
  self.clearButtonBottom.constant = clearButtonConstant;
}

#pragma mark - Layout

- (void)updatePlaceholder {
  [super updatePlaceholder];

  if (!self.placeholderTop) {
    self.placeholderTop =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:MDCTextInputFilledNormalPlaceholderPadding];
    self.placeholderTop.priority = UILayoutPriorityDefaultHigh;
    self.placeholderTop.active = YES;
  }

  UIEdgeInsets textInsets = [self textInsets:UIEdgeInsetsZero];
  CGFloat underlineBottomConstant =
      textInsets.top + [self estimatedTextHeight] + [self beneathInputPadding];
  // When floating placeholders are turned off, the underline will drift up unless this is set. Even
  // tho it is redundant when floating is on, we just keep it on always for simplicity.
  // Note: This is an issue only on single-line text fields.
  if (!self.underlineBottom) {
    if ([self.textInput isKindOfClass:[MDCMultilineTextField class]]) {
      self.underlineBottom =
          [NSLayoutConstraint constraintWithItem:self.textInput.underline
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:((MDCMultilineTextField *)self.textInput).textView
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1
                                        constant:[self beneathInputPadding]];
      self.underlineBottom.active = YES;

    } else {
      self.underlineBottom = [NSLayoutConstraint constraintWithItem:self.textInput.underline
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.textInput
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:underlineBottomConstant];
      self.underlineBottom.active = YES;
    }
  }
  if ([self.textInput isKindOfClass:[MDCMultilineTextField class]]) {
    self.underlineBottom.constant = [self beneathInputPadding];
  } else {
    self.underlineBottom.constant = underlineBottomConstant;
  }
}

// The measurement from bottom to underline bottom. Only used in non-floating case.
- (CGFloat)underlineOffset {
  // The amount of space underneath the underline may depend on whether there is content in the
  // underline labels.

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat leadingOffset =
      MDCCeil(self.textInput.leadingUnderlineLabel.font.lineHeight * scale) / scale;
  CGFloat trailingOffset =
      MDCCeil(self.textInput.trailingUnderlineLabel.font.lineHeight * scale) / scale;

  CGFloat underlineOffset = 0;
  switch (self.textInput.textInsetsMode) {
    case MDCTextInputTextInsetsModeAlways:
      underlineOffset += MAX(leadingOffset, trailingOffset) + MDCTextInputFilledHalfPadding;
      break;
    case MDCTextInputTextInsetsModeIfContent: {
      // contentConditionalOffset will have the estimated text height for the largest underline
      // label that also has text.
      CGFloat contentConditionalOffset = 0;
      if (self.textInput.leadingUnderlineLabel.text.length) {
        contentConditionalOffset = leadingOffset;
      }
      if (self.textInput.trailingUnderlineLabel.text.length) {
        contentConditionalOffset = MAX(contentConditionalOffset, trailingOffset);
      }

      if (!MDCCGFloatEqual(contentConditionalOffset, 0)) {
        underlineOffset += contentConditionalOffset + MDCTextInputFilledHalfPadding;
      }
    } break;
    case MDCTextInputTextInsetsModeNever:
      break;
  }
  return underlineOffset;
}

- (CGFloat)estimatedTextHeight {
  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat estimatedTextHeight = MDCCeil(self.textInput.font.lineHeight * scale) / scale;

  return estimatedTextHeight;
}

// The space ABOVE the underline but under the text input area.
- (CGFloat)beneathInputPadding {
  if (self.isFloatingEnabled) {
    return MDCTextInputFilledHalfPadding + MDCTextInputFilledHalfPaddingAddition;
  } else {
    return MDCTextInputFilledNormalPlaceholderPadding;
  }
}

@end
