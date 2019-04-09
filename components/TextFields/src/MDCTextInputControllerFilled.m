// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextInputControllerFilled.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCMultilineTextField.h"
#import "MDCTextInput.h"
#import "MDCTextInputBorderView.h"
#import "MDCTextInputController.h"
#import "MDCTextInputControllerBase.h"
#import "MDCTextInputControllerFloatingPlaceholder.h"
#import "private/MDCTextInputArt.h"
#import "private/MDCTextInputControllerBase+Subclassing.h"

#import "MaterialMath.h"

/**
 Note: Right now this is a subclass of MDCTextInputControllerBase since they share a vast
 majority of code. If the designs diverge further, this would make a good candidate for its own
 class.
 */

#pragma mark - Constants

static const CGFloat MDCTextInputControllerFilledClearButtonPaddingAddition = -2;
static const CGFloat MDCTextInputControllerFilledDefaultUnderlineActiveHeight = 2;
static const CGFloat MDCTextInputControllerFilledDefaultUnderlineNormalHeight = 1;
static const CGFloat MDCTextInputControllerFilledFullPadding = 16;

// The guidelines have 8 points of padding but since the fonts on iOS are slightly smaller, we need
// to add points to keep the versions at the same height.
static const CGFloat MDCTextInputControllerFilledHalfPadding = 8;
static const CGFloat MDCTextInputControllerFilledHalfPaddingAddition = 1;
static const CGFloat MDCTextInputControllerFilledNormalPlaceholderPadding = 20;
static const CGFloat MDCTextInputControllerFilledThreeQuartersPadding = 12;

static inline UIColor *MDCTextInputControllerFilledDefaultBorderFillColorDefault() {
  return [UIColor colorWithWhite:0 alpha:(CGFloat)0.06];
}

#pragma mark - Class Properties

static UIColor *_borderFillColorDefault;

static UIRectCorner _roundedCornersDefault = UIRectCornerTopLeft | UIRectCornerTopRight;

static CGFloat _underlineHeightActiveDefault =
    MDCTextInputControllerFilledDefaultUnderlineActiveHeight;
static CGFloat _underlineHeightNormalDefault =
    MDCTextInputControllerFilledDefaultUnderlineNormalHeight;

@interface MDCTextInputControllerFilled ()

@property(nonatomic, strong) NSLayoutConstraint *clearButtonBottom;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *underlineBottom;

@end

@implementation MDCTextInputControllerFilled

#pragma mark - Properties Implementations

+ (UIColor *)borderFillColorDefault {
  if (!_borderFillColorDefault) {
    _borderFillColorDefault = MDCTextInputControllerFilledDefaultBorderFillColorDefault();
  }
  return _borderFillColorDefault;
}

+ (UIRectCorner)roundedCornersDefault {
  return _roundedCornersDefault;
}

+ (void)setRoundedCornersDefault:(UIRectCorner)roundedCornersDefault {
  _roundedCornersDefault = roundedCornersDefault;
}

+ (CGFloat)underlineHeightActiveDefault {
  return _underlineHeightActiveDefault;
}

+ (void)setUnderlineHeightActiveDefault:(CGFloat)underlineHeightActiveDefault {
  _underlineHeightActiveDefault = underlineHeightActiveDefault;
}

+ (CGFloat)underlineHeightNormalDefault {
  return _underlineHeightNormalDefault;
}

+ (void)setUnderlineHeightNormalDefault:(CGFloat)underlineHeightNormalDefault {
  _underlineHeightNormalDefault = underlineHeightNormalDefault;
}

#pragma mark - MDCTextInputPositioningDelegate

- (CGRect)leadingViewRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  CGRect leadingViewRect = defaultRect;
  CGFloat xOffset = (self.textInput.mdf_effectiveUserInterfaceLayoutDirection ==
                     UIUserInterfaceLayoutDirectionRightToLeft)
                        ? -1 * MDCTextInputControllerFilledFullPadding
                        : MDCTextInputControllerFilledFullPadding;

  leadingViewRect = CGRectOffset(leadingViewRect, xOffset, 0);

  leadingViewRect.origin.y =
      CGRectGetHeight(self.textInput.borderPath.bounds) / 2 - CGRectGetHeight(leadingViewRect) / 2;

  return leadingViewRect;
}

- (CGFloat)leadingViewTrailingPaddingConstant {
  return MDCTextInputControllerFilledFullPadding;
}

- (CGRect)trailingViewRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  CGRect trailingViewRect = defaultRect;
  CGFloat xOffset = (self.textInput.mdf_effectiveUserInterfaceLayoutDirection ==
                     UIUserInterfaceLayoutDirectionRightToLeft)
                        ? MDCTextInputControllerFilledThreeQuartersPadding
                        : -1 * MDCTextInputControllerFilledThreeQuartersPadding;

  trailingViewRect = CGRectOffset(trailingViewRect, xOffset, 0);

  trailingViewRect.origin.y =
      CGRectGetHeight(self.textInput.borderPath.bounds) / 2 - CGRectGetHeight(trailingViewRect) / 2;

  return trailingViewRect;
}

- (CGFloat)trailingViewTrailingPaddingConstant {
  return MDCTextInputControllerFilledThreeQuartersPadding;
}

// clang-format off
/**
 textInsets: is the source of truth for vertical layout. It's used to figure out the proper
 height and also where to place the placeholder / text field.

 NOTE: It's applied before the textRect is flipped for RTL. So all calculations are done here à la
 LTR.

 The vertical layout is, at most complex (floating), this form:
 MDCTextInputControllerFilledHalfPadding +                            // Small padding
 MDCTextInputControllerFilledHalfPaddingAddition                      // Additional point (iOS specific)
 MDCRint(self.textInput.placeholderLabel.font.lineHeight * scale)     // Placeholder when up
 MDCTextInputControllerFilledHalfPadding +                            // Small padding
 MDCTextInputControllerFilledHalfPaddingAddition                      // Additional point (iOS specific)
   MDCCeil(MAX(self.textInput.font.lineHeight,                        // Text field or placeholder line height
             self.textInput.placeholderLabel.font.lineHeight))
 MDCTextInputControllerFilledHalfPadding +                            // Small padding
 MDCTextInputControllerFilledHalfPaddingAddition                      // Additional point (iOS specific)
 --Underline--                                                        // Underline (height not counted)
 underlineLabelsOffset                                                // Depends on text insets mode. See the super class.
 */
// clang-format on
- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textInsets = [super textInsets:defaultInsets];
  if (self.isFloatingEnabled) {
    textInsets.top =
        MDCTextInputControllerFilledHalfPadding + MDCTextInputControllerFilledHalfPaddingAddition +
        MDCRint(self.textInput.placeholderLabel.font.lineHeight *
                (CGFloat)self.floatingPlaceholderScale.floatValue) +
        MDCTextInputControllerFilledHalfPadding + MDCTextInputControllerFilledHalfPaddingAddition;
  } else {
    textInsets.top = MDCTextInputControllerFilledNormalPlaceholderPadding;
  }

  textInsets.bottom = [self beneathInputPadding] + [self underlineOffset];

  textInsets.left = MDCTextInputControllerFilledFullPadding;
  textInsets.right = MDCTextInputControllerFilledHalfPadding;

  return textInsets;
}

- (void)updateLayout {
  [super updateLayout];

  if (!self.textInput) {
    return;
  }

  CGFloat clearButtonConstant =
      -1 * ([self beneathInputPadding] - MDCTextInputClearButtonImageBuiltInPadding +
            MDCTextInputControllerFilledClearButtonPaddingAddition);
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
    self.placeholderTop = [NSLayoutConstraint
        constraintWithItem:self.textInput.placeholderLabel
                 attribute:NSLayoutAttributeTop
                 relatedBy:NSLayoutRelationEqual
                    toItem:self.textInput
                 attribute:NSLayoutAttributeTop
                multiplier:1
                  constant:MDCTextInputControllerFilledNormalPlaceholderPadding];
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
      underlineOffset +=
          MAX(leadingOffset, trailingOffset) + MDCTextInputControllerFilledHalfPadding;
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
        underlineOffset += contentConditionalOffset + MDCTextInputControllerFilledHalfPadding;
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

- (UIOffset)floatingPlaceholderOffset {
  UIOffset offset = [super floatingPlaceholderOffset];

  if ([self.textInput conformsToProtocol:@protocol(MDCLeadingViewTextInput)]) {
    UIView<MDCLeadingViewTextInput> *input = (UIView<MDCLeadingViewTextInput> *)self.textInput;
    if (input.leadingView.superview) {
      offset.horizontal -=
          CGRectGetWidth(input.leadingView.frame) + [self leadingViewTrailingPaddingConstant];
    }
  }
  return offset;
}

// The space ABOVE the underline but under the text input area.
- (CGFloat)beneathInputPadding {
  if (self.isFloatingEnabled) {
    return MDCTextInputControllerFilledHalfPadding +
           MDCTextInputControllerFilledHalfPaddingAddition;
  } else {
    return MDCTextInputControllerFilledNormalPlaceholderPadding;
  }
}

@end
