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

#import "MDCTextInputControllerOutlined.h"

#import "MDCTextInput.h"
#import "MDCTextInputBorderView.h"
#import "MDCTextInputController.h"
#import "MDCTextInputControllerBase.h"
#import "MDCTextInputControllerFloatingPlaceholder.h"
#import "MDCTextInputUnderlineView.h"
#import "private/MDCPaddedLabel.h"
#import "private/MDCTextInputControllerBase+Subclassing.h"

#import "MaterialMath.h"

#pragma mark - Class Properties

static const CGFloat MDCTextInputOutlinedTextFieldFullPadding = 16.f;
static const CGFloat MDCTextInputOutlinedTextFieldNormalPlaceholderPadding = 20.f;
static const CGFloat MDCTextInputOutlinedTextFieldPlaceholderPadding = 4.f;

static UIRectCorner _roundedCornersDefault = UIRectCornerAllCorners;

@interface MDCTextInputControllerOutlined ()

@property(nonatomic, strong) NSLayoutConstraint *placeholderCenterY;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;

@end

@implementation MDCTextInputControllerOutlined

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)input {
  NSAssert(![input conformsToProtocol:@protocol(MDCMultilineTextInput)],
           @"This design is meant for single-line text fields only. For a complementary multi-line "
           @"style, see MDCTextInputControllerOutlinedTextArea.");
  self = [super initWithTextInput:input];
  if (self) {
    input.textInsetsMode = MDCTextInputTextInsetsModeAlways;
  }
  return self;
}

#pragma mark - Properties Implementations

- (BOOL)isFloatingEnabled {
  return YES;
}

- (void)setFloatingEnabled:(__unused BOOL)floatingEnabled {
  // Unused. Floating is always enabled.
}

- (UIOffset)floatingPlaceholderOffset {
  UIOffset offset = [super floatingPlaceholderOffset];
  CGFloat textVerticalOffset = self.textInput.placeholderLabel.font.lineHeight -
                               self.textInput.placeholderLabel.font.xHeight;
  offset.vertical = -1 * textVerticalOffset;
  MDCPaddedLabel *placeholderLabel = (MDCPaddedLabel *)self.textInput.placeholderLabel;
  offset.horizontal += placeholderLabel.horizontalPadding;
  return offset;
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

 This one is a little different because the placeholder crosses the top bordered area when floating.

 The vertical layout is, at most complex, this form:

 placeholderEstimatedHeight                                           // Height of placeholder
 MDCTextInputOutlinedTextFieldFullPadding                             // Padding
 MDCCeil(MAX(self.textInput.font.lineHeight,                          // Text field or placeholder
             self.textInput.placeholderLabel.font.lineHeight))
 MDCTextInputControllerBaseDefaultPadding                             // Padding to bottom of border rect
 underlineLabelsOffset                                                // From super class.
 */
// clang-format on
- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textInsets = [super textInsets:defaultInsets];

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  textInsets.top =
      [self borderHeight] - MDCTextInputOutlinedTextFieldFullPadding - placeholderEstimatedHeight;

  textInsets.left = MDCTextInputOutlinedTextFieldFullPadding;
  textInsets.right = MDCTextInputOutlinedTextFieldFullPadding;

  return textInsets;
}

#pragma mark - MDCTextInputControllerBase overrides

- (void)updateLayout {
  [super updateLayout];

  self.textInput.clipsToBounds = NO;
}

- (void)updateBorder {
  [super updateBorder];

  CGRect pathRect = self.textInput.bounds;
  pathRect.size.height = [self borderHeight];
  UIBezierPath *path = [UIBezierPath
      bezierPathWithRoundedRect:pathRect
              byRoundingCorners:self.roundedCorners
                    cornerRadii:CGSizeMake(MDCTextInputControllerBaseDefaultBorderRadius,
                                           MDCTextInputControllerBaseDefaultBorderRadius)];
  self.textInput.borderPath = path;

  UIColor *borderColor = self.textInput.isEditing ? self.activeColor : self.normalColor;
  self.textInput.borderView.borderStrokeColor =
      (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) ? self.errorColor
                                                                           : borderColor;
  self.textInput.borderView.borderPath.lineWidth = self.textInput.isEditing ? 2 : 1;

  [self updatePlaceholder];
}

- (void)updatePlaceholder {
  [super updatePlaceholder];

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  CGFloat placeholderConstant = ([self borderHeight] / 2.f) - (placeholderEstimatedHeight / 2.f);
  if (!self.placeholderCenterY) {
    self.placeholderCenterY = [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.textInput
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:placeholderConstant];
    self.placeholderCenterY.priority = UILayoutPriorityDefaultHigh;
    self.placeholderCenterY.active = YES;

    [self.textInput.placeholderLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh + 1
                                                       forAxis:UILayoutConstraintAxisVertical];
  }
  self.placeholderCenterY.constant = placeholderConstant;

  MDCPaddedLabel *placeholderLabel = (MDCPaddedLabel *)self.textInput.placeholderLabel;
  placeholderLabel.horizontalPadding = MDCTextInputOutlinedTextFieldPlaceholderPadding;

  if (!self.placeholderLeading) {
    self.placeholderLeading =
        [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textInput
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:MDCTextInputOutlinedTextFieldFullPadding -
                                               placeholderLabel.horizontalPadding];
    self.placeholderLeading.priority = UILayoutPriorityDefaultHigh;
    self.placeholderLeading.active = YES;
  }
}

- (CGFloat)borderHeight {
  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  return MDCTextInputOutlinedTextFieldNormalPlaceholderPadding + placeholderEstimatedHeight +
         MDCTextInputOutlinedTextFieldNormalPlaceholderPadding;
}

@end
