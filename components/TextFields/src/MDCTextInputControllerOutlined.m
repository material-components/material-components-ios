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

#import "MDCTextInputControllerOutlined.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCTextInput.h"
#import "MDCTextInputBorderView.h"
#import "MDCTextInputController.h"
#import "MDCTextInputControllerBase.h"
#import "MDCTextInputControllerFloatingPlaceholder.h"
#import "MDCTextInputUnderlineView.h"
#import "private/MDCTextInputControllerBase+Subclassing.h"

#import "MaterialMath.h"

#pragma mark - Class Properties

static const CGFloat MDCTextInputOutlinedTextFieldFloatingPlaceholderPadding = 8;
static const CGFloat MDCTextInputOutlinedTextFieldFullPadding = 16;
static const CGFloat MDCTextInputOutlinedTextFieldNormalPlaceholderPadding = 20;
static const CGFloat MDCTextInputOutlinedTextFieldThreeQuartersPadding = 12;

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
  CGFloat textVerticalOffset = 0;
  offset.vertical = textVerticalOffset;
  return offset;
}

+ (UIRectCorner)roundedCornersDefault {
  return _roundedCornersDefault;
}

+ (void)setRoundedCornersDefault:(UIRectCorner)roundedCornersDefault {
  _roundedCornersDefault = roundedCornersDefault;
}

#pragma mark - MDCTextInputPositioningDelegate

- (CGRect)leadingViewRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  CGRect leadingViewRect = defaultRect;
  CGFloat xOffset = (self.textInput.mdf_effectiveUserInterfaceLayoutDirection ==
                     UIUserInterfaceLayoutDirectionRightToLeft)
                        ? -1 * MDCTextInputOutlinedTextFieldFullPadding
                        : MDCTextInputOutlinedTextFieldFullPadding;

  leadingViewRect = CGRectOffset(leadingViewRect, xOffset, 0);

  CGRect borderRect = [self borderRect];
  leadingViewRect.origin.y = CGRectGetMinY(borderRect) + CGRectGetHeight(borderRect) / 2 -
                             CGRectGetHeight(leadingViewRect) / 2;

  return leadingViewRect;
}

- (CGFloat)leadingViewTrailingPaddingConstant {
  return MDCTextInputOutlinedTextFieldFullPadding;
}

- (CGRect)trailingViewRectForBounds:(CGRect)bounds defaultRect:(CGRect)defaultRect {
  CGRect trailingViewRect = defaultRect;
  CGFloat xOffset = (self.textInput.mdf_effectiveUserInterfaceLayoutDirection ==
                     UIUserInterfaceLayoutDirectionRightToLeft)
                        ? MDCTextInputOutlinedTextFieldThreeQuartersPadding
                        : -1 * MDCTextInputOutlinedTextFieldThreeQuartersPadding;

  trailingViewRect = CGRectOffset(trailingViewRect, xOffset, 0);

  CGRect borderRect = [self borderRect];
  trailingViewRect.origin.y = CGRectGetMinY(borderRect) + CGRectGetHeight(borderRect) / 2 -
                              CGRectGetHeight(trailingViewRect) / 2;

  return trailingViewRect;
}

- (CGFloat)trailingViewTrailingPaddingConstant {
  return MDCTextInputOutlinedTextFieldThreeQuartersPadding;
}

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
  CGFloat textVerticalOffset = self.textInput.placeholderLabel.font.lineHeight * (CGFloat)0.5;

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  textInsets.top = [self borderHeight] - MDCTextInputOutlinedTextFieldFullPadding -
                   placeholderEstimatedHeight + textVerticalOffset;

  textInsets.left = MDCTextInputOutlinedTextFieldFullPadding;
  textInsets.right = MDCTextInputOutlinedTextFieldFullPadding;

  return textInsets;
}

#pragma mark - MDCTextInputControllerBase overrides

- (void)updateLayout {
  [super updateLayout];

  self.textInput.clipsToBounds = NO;
}

- (void)updateUnderline {
  self.textInput.underline.hidden = YES;
}

- (void)updateBorder {
  [super updateBorder];

  UIBezierPath *path;
  if ([self isPlaceholderUp]) {
    CGFloat placeholderWidth = 0;
    NSString *placeholderString = [self.textInput.placeholderLabel.text
        stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    if (placeholderString.length > 0) {
      placeholderWidth = [self.textInput.placeholderLabel
                             systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]
                             .width *
                         (CGFloat)self.floatingPlaceholderScale.floatValue;
      placeholderWidth += MDCTextInputOutlinedTextFieldFloatingPlaceholderPadding;
    }

    path = [self roundedPathFromRect:[self borderRect]
                       withTextSpace:placeholderWidth
                       leadingOffset:MDCTextInputOutlinedTextFieldFullPadding -
                                     MDCTextInputOutlinedTextFieldFloatingPlaceholderPadding / 2];
  } else {
    CGSize cornerRadius = CGSizeMake(MDCTextInputControllerBaseDefaultBorderRadius,
                                     MDCTextInputControllerBaseDefaultBorderRadius);
    path = [UIBezierPath bezierPathWithRoundedRect:[self borderRect]
                                 byRoundingCorners:self.roundedCorners
                                       cornerRadii:cornerRadius];
  }
  self.textInput.borderPath = path;

  UIColor *borderColor = self.textInput.isEditing ? self.activeColor : self.normalColor;
  if (!self.textInput.isEnabled) {
    borderColor = self.disabledColor;
  }
  self.textInput.borderView.borderStrokeColor =
      (self.isDisplayingCharacterCountError || self.isDisplayingErrorText) ? self.errorColor
                                                                           : borderColor;
  self.textInput.borderView.borderPath.lineWidth = self.textInput.isEditing ? 2 : 1;

  [self.textInput.borderView setNeedsLayout];

  [self updatePlaceholder];
}

- (CGRect)borderRect {
  CGRect pathRect = self.textInput.bounds;
  pathRect.origin.y =
      pathRect.origin.y + self.textInput.placeholderLabel.font.lineHeight * (CGFloat)0.5;
  pathRect.size.height = [self borderHeight];
  return pathRect;
}

- (UIBezierPath *)roundedPathFromRect:(CGRect)f
                        withTextSpace:(CGFloat)textSpace
                        leadingOffset:(CGFloat)offset {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat radius = MDCTextInputControllerBaseDefaultBorderRadius;
  CGFloat yOffset = f.origin.y;
  CGFloat xOffset = f.origin.x;

  // Draw the path
  [path moveToPoint:CGPointMake(radius + xOffset, yOffset)];
  if (self.textInput.mdf_effectiveUserInterfaceLayoutDirection ==
      UIUserInterfaceLayoutDirectionLeftToRight) {
    [path addLineToPoint:CGPointMake(offset + xOffset, yOffset)];
    [path moveToPoint:CGPointMake(textSpace + offset + xOffset, yOffset)];
    [path addLineToPoint:CGPointMake(f.size.width - radius + xOffset, yOffset)];
  } else {
    [path addLineToPoint:CGPointMake(xOffset + (f.size.width - (offset + textSpace)), yOffset)];
    [path moveToPoint:CGPointMake(xOffset + (f.size.width - offset), yOffset)];
    [path addLineToPoint:CGPointMake(xOffset + (f.size.width - radius), yOffset)];
  }

  [path addArcWithCenter:CGPointMake(f.size.width - radius + xOffset, radius + yOffset)
                  radius:radius
              startAngle:-(CGFloat)(M_PI / 2)
                endAngle:0
               clockwise:YES];
  [path addLineToPoint:CGPointMake(f.size.width + xOffset, f.size.height - radius + yOffset)];
  [path addArcWithCenter:CGPointMake(f.size.width - radius + xOffset,
                                     f.size.height - radius + yOffset)
                  radius:radius
              startAngle:0
                endAngle:-(CGFloat)((M_PI * 3) / 2)
               clockwise:YES];
  [path addLineToPoint:CGPointMake(radius + xOffset, f.size.height + yOffset)];
  [path addArcWithCenter:CGPointMake(radius + xOffset, f.size.height - radius + yOffset)
                  radius:radius
              startAngle:-(CGFloat)((M_PI * 3) / 2)
                endAngle:-(CGFloat)M_PI
               clockwise:YES];
  [path addLineToPoint:CGPointMake(xOffset, radius + yOffset)];
  [path addArcWithCenter:CGPointMake(radius + xOffset, radius + yOffset)
                  radius:radius
              startAngle:-(CGFloat)M_PI
                endAngle:-(CGFloat)(M_PI / 2)
               clockwise:YES];

  return path;
}

- (void)updatePlaceholder {
  [super updatePlaceholder];

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  CGFloat placeholderConstant = ([self borderHeight] / 2) - (placeholderEstimatedHeight / 2) +
                                self.textInput.placeholderLabel.font.lineHeight * (CGFloat)0.5;
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

  CGFloat placeholderLeadingConstant = MDCTextInputOutlinedTextFieldFullPadding;

  if ([self.textInput conformsToProtocol:@protocol(MDCLeadingViewTextInput)]) {
    UIView<MDCLeadingViewTextInput> *leadingViewInput =
        (UIView<MDCLeadingViewTextInput> *)self.textInput;
    if (leadingViewInput.leadingView.superview) {
      placeholderLeadingConstant += CGRectGetWidth(leadingViewInput.leadingView.frame) +
                                    [self leadingViewTrailingPaddingConstant];
    }
  }

  if (!self.placeholderLeading) {
    self.placeholderLeading = [NSLayoutConstraint constraintWithItem:self.textInput.placeholderLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.textInput
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1
                                                            constant:placeholderLeadingConstant];
    self.placeholderLeading.priority = UILayoutPriorityDefaultHigh;
    self.placeholderLeading.active = YES;
  }
  self.placeholderLeading.constant = placeholderLeadingConstant;
}

- (CGFloat)borderHeight {
  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  return MDCTextInputOutlinedTextFieldNormalPlaceholderPadding + placeholderEstimatedHeight +
         MDCTextInputOutlinedTextFieldNormalPlaceholderPadding;
}

@end
