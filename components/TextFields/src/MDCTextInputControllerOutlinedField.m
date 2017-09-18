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

#import "MDCTextInputControllerOutlinedField.h"

#import "MDCTextInputBorderView.h"
#import "private/MDCPaddedLabel.h"
#import "private/MDCTextInputControllerDefault+Subclassing.h"

#import "MDCMath.h"

#pragma mark - Class Properties

static const CGFloat MDCTextInputTextFieldOutlinedFullPadding = 16.f;
static const CGFloat MDCTextInputTextFieldOutlinedNormalPlaceholderPadding = 20.f;
static const CGFloat MDCTextInputTextFieldOutlinedPlaceholderPadding = 4.f;

static UIRectCorner _roundedCornersDefault = UIRectCornerAllCorners;

@interface MDCTextInputControllerOutlinedField ()

@property(nonatomic, strong) NSLayoutConstraint *placeholderCenterY;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;

@end

@implementation MDCTextInputControllerOutlinedField

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)input {
  NSAssert(![input conformsToProtocol:@protocol(MDCMultilineTextInput)],
           @"This design is meant for single-line text fields only. For a complementary multi-line "
           @"style, see MDCTextInputControllerTextArea.");
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

- (CGPoint)floatingPlaceholderDestination {
  CGPoint destination = [super floatingPlaceholderDestination];
  CGFloat offset = self.textInput.placeholderLabel.font.lineHeight -
                   self.textInput.placeholderLabel.font.xHeight;
  destination.y = -1 * offset;
  MDCPaddedLabel *placeholderLabel = (MDCPaddedLabel *)self.textInput.placeholderLabel;
  destination.x -= placeholderLabel.horizontalPadding;
  return destination;
}

+ (UIRectCorner)roundedCornersDefault {
  return _roundedCornersDefault;
}

+ (void)setRoundedCornersDefault:(UIRectCorner)roundedCornersDefault {
  _roundedCornersDefault = roundedCornersDefault;
}

#pragma mark - MDCTextInputPositioningDelegate

- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets {
  UIEdgeInsets textInsets = [super textInsets:defaultInsets];

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  textInsets.top =
      [self borderHeight] - MDCTextInputTextFieldOutlinedFullPadding - placeholderEstimatedHeight;

  textInsets.left = MDCTextInputTextFieldOutlinedFullPadding;
  textInsets.right = MDCTextInputTextFieldOutlinedFullPadding;

  return textInsets;
}

#pragma mark - MDCTextInputControllerDefault overrides

- (void)updateLayout {
  [super updateLayout];

  self.textInput.underline.alpha = 0;
  self.textInput.clipsToBounds = NO;
}

- (void)updateBorder {
  [super updateBorder];

  CGRect pathRect = self.textInput.bounds;
  pathRect.size.height = [self borderHeight];
  UIBezierPath *path =
      [UIBezierPath bezierPathWithRoundedRect:pathRect
                            byRoundingCorners:self.roundedCorners
                                  cornerRadii:CGSizeMake(MDCTextInputDefaultBorderRadius,
                                                         MDCTextInputDefaultBorderRadius)];
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
  placeholderLabel.horizontalPadding = MDCTextInputTextFieldOutlinedPlaceholderPadding;

  if (!self.placeholderLeading) {
    self.placeholderLeading = [NSLayoutConstraint
        constraintWithItem:self.textInput.placeholderLabel
                 attribute:NSLayoutAttributeLeading
                 relatedBy:NSLayoutRelationEqual
                    toItem:self.textInput
                 attribute:NSLayoutAttributeLeading
                multiplier:1
                  constant:MDCTextInputTextFieldOutlinedFullPadding -
                               placeholderLabel.horizontalPadding];
    self.placeholderLeading.priority = UILayoutPriorityDefaultHigh;
    self.placeholderLeading.active = YES;
  }
}

- (CGFloat)borderHeight {
  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  return MDCTextInputTextFieldOutlinedNormalPlaceholderPadding + placeholderEstimatedHeight +
         MDCTextInputTextFieldOutlinedNormalPlaceholderPadding;
}

@end
