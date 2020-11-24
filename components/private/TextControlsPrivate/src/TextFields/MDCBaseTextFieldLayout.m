// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBaseTextFieldLayout.h"

#import "MaterialTextControlsPrivate+Shared.h"

@interface MDCBaseTextFieldLayout ()
@end

@implementation MDCBaseTextFieldLayout

#pragma mark Object Lifecycle

- (instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                 positioningReference:
                     (id<MDCTextControlVerticalPositioningReference>)positioningReference
       horizontalPositioningReference:
           (id<MDCTextControlHorizontalPositioning>)horizontalPositioningReference
                                 text:(NSString *)text
                                 font:(UIFont *)font
                         floatingFont:(UIFont *)floatingFont
                                label:(UILabel *)label
                        labelPosition:(MDCTextControlLabelPosition)labelPosition
                        labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
                    sideViewAlignment:(MDCTextControlTextFieldSideViewAlignment)sideViewAlignment
                          leadingView:(UIView *)leadingView
                      leadingViewMode:(UITextFieldViewMode)leadingViewMode
                         trailingView:(UIView *)trailingView
                     trailingViewMode:(UITextFieldViewMode)trailingViewMode
                clearButtonSideLength:(CGFloat)clearButtonSideLength
                      clearButtonMode:(UITextFieldViewMode)clearButtonMode
                leadingAssistiveLabel:(nonnull UILabel *)leadingAssistiveLabel
               trailingAssistiveLabel:(nonnull UILabel *)trailingAssistiveLabel
           assistiveLabelDrawPriority:
               (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
     customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithTextFieldSize:textFieldSize
                      positioningReference:positioningReference
            horizontalPositioningReference:horizontalPositioningReference
                                      text:text
                                      font:font
                              floatingFont:floatingFont
                                     label:label
                             labelPosition:labelPosition
                             labelBehavior:labelBehavior
                         sideViewAlignment:sideViewAlignment
                               leadingView:leadingView
                           leadingViewMode:leadingViewMode
                              trailingView:trailingView
                          trailingViewMode:trailingViewMode
                     clearButtonSideLength:clearButtonSideLength
                           clearButtonMode:clearButtonMode
                     leadingAssistiveLabel:leadingAssistiveLabel
                    trailingAssistiveLabel:trailingAssistiveLabel
                assistiveLabelDrawPriority:assistiveLabelDrawPriority
          customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                                     isRTL:isRTL
                                 isEditing:isEditing];
    return self;
  }
  return nil;
}

#pragma mark Layout Calculation

- (void)calculateLayoutWithTextFieldSize:(CGSize)textFieldSize
                    positioningReference:
                        (id<MDCTextControlVerticalPositioningReference>)positioningReference
          horizontalPositioningReference:
              (id<MDCTextControlHorizontalPositioning>)horizontalPositioningReference
                                    text:(NSString *)text
                                    font:(UIFont *)font
                            floatingFont:(UIFont *)floatingFont
                                   label:(UILabel *)label
                           labelPosition:(MDCTextControlLabelPosition)labelPosition
                           labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
                       sideViewAlignment:(MDCTextControlTextFieldSideViewAlignment)sideViewAlignment
                             leadingView:(UIView *)leadingView
                         leadingViewMode:(UITextFieldViewMode)leadingViewMode
                            trailingView:(UIView *)trailingView
                        trailingViewMode:(UITextFieldViewMode)trailingViewMode
                   clearButtonSideLength:(CGFloat)clearButtonSideLength
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode
                   leadingAssistiveLabel:(nonnull UILabel *)leadingAssistiveLabel
                  trailingAssistiveLabel:(nonnull UILabel *)trailingAssistiveLabel
              assistiveLabelDrawPriority:
                  (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
        customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                                   isRTL:(BOOL)isRTL
                               isEditing:(BOOL)isEditing {
  UIView *leftView = isRTL ? trailingView : leadingView;
  UIView *rightView = isRTL ? leadingView : trailingView;
  UITextFieldViewMode leftViewMode = isRTL ? trailingViewMode : leadingViewMode;
  UITextFieldViewMode rightViewMode = isRTL ? leadingViewMode : trailingViewMode;

  BOOL displaysLeftView =
      MDCTextControlShouldDisplaySideViewWithSideView(leftView, leftViewMode, isEditing);
  BOOL displaysRightView =
      MDCTextControlShouldDisplaySideViewWithSideView(rightView, rightViewMode, isEditing);
  BOOL displaysClearButton = [self shouldDisplayClearButtonWithViewMode:clearButtonMode
                                                              isEditing:isEditing
                                                                   text:text];

  CGFloat leadingEdgePadding = horizontalPositioningReference.leadingEdgePadding;
  CGFloat trailingEdgePadding = horizontalPositioningReference.trailingEdgePadding;
  CGFloat leftEdgePadding = isRTL ? trailingEdgePadding : leadingEdgePadding;
  CGFloat rightEdgePadding = isRTL ? leadingEdgePadding : trailingEdgePadding;
  CGFloat horizontalInterItemPadding = horizontalPositioningReference.horizontalInterItemSpacing;

  CGFloat leftViewWidth = CGRectGetWidth(leftView.frame);
  CGFloat leftViewMinX = 0;
  CGFloat leftViewMaxX = 0;
  if (displaysLeftView) {
    leftViewMinX = leftEdgePadding;
    leftViewMaxX = leftViewMinX + leftViewWidth;
  }

  CGFloat textFieldWidth = textFieldSize.width;
  CGFloat rightViewMinX = 0;
  if (displaysRightView) {
    CGFloat rightViewMaxX = textFieldWidth - rightEdgePadding;
    rightViewMinX = rightViewMaxX - CGRectGetWidth(rightView.frame);
  }

  CGFloat clearButtonMinX = 0;
  if (isRTL) {
    clearButtonMinX =
        displaysLeftView ? leftViewMaxX + horizontalInterItemPadding : leftEdgePadding;
  } else {
    CGFloat clearButtonMaxX = displaysRightView ? rightViewMinX - horizontalInterItemPadding
                                                : textFieldWidth - rightEdgePadding;
    clearButtonMinX = clearButtonMaxX - clearButtonSideLength;
  }

  CGFloat textRectMinX = 0;
  CGFloat textRectMaxX = 0;
  CGFloat labelMinX = 0;
  CGFloat floatingLabelMinX = 0;

  if (isRTL) {
    if (displaysClearButton) {
      CGFloat clearButtonMaxX = clearButtonMinX + clearButtonSideLength;
      textRectMinX = clearButtonMaxX + horizontalInterItemPadding;
      labelMinX = textRectMinX;
      floatingLabelMinX = clearButtonMinX;
    } else {
      textRectMinX = displaysLeftView ? leftViewMaxX + horizontalInterItemPadding : leftEdgePadding;
      labelMinX = textRectMinX;
      floatingLabelMinX = textRectMinX;
    }
    if (displaysRightView) {
      textRectMaxX = rightViewMinX - horizontalInterItemPadding;
    } else {
      textRectMaxX = textFieldWidth - horizontalInterItemPadding;
    }
  } else {
    textRectMinX = displaysLeftView ? leftViewMaxX + horizontalInterItemPadding : leftEdgePadding;
    labelMinX = textRectMinX;
    floatingLabelMinX = labelMinX;
    if (displaysClearButton) {
      textRectMaxX = clearButtonMinX - horizontalInterItemPadding;
    } else {
      textRectMaxX = displaysRightView ? rightViewMinX - horizontalInterItemPadding
                                       : textFieldWidth - rightEdgePadding;
    }
  }

  BOOL shouldLayoutForFloatingLabel = MDCTextControlShouldLayoutForFloatingLabelWithLabelPosition(
      labelPosition, labelBehavior, label.text);
  CGFloat textRectMinYNormal = 0;
  if (shouldLayoutForFloatingLabel) {
    textRectMinYNormal = positioningReference.paddingBetweenContainerTopAndNormalLabel;
  } else {
    textRectMinYNormal = positioningReference.paddingAroundTextWhenNoFloatingLabel;
  }

  CGFloat textRectWidth = textRectMaxX - textRectMinX;
  CGFloat textRectHeight = [self textHeightWithFont:font];
  CGRect textRectNormal =
      CGRectMake(textRectMinX, textRectMinYNormal, textRectWidth, textRectHeight);

  CGFloat floatingLabelMinY = positioningReference.paddingBetweenContainerTopAndFloatingLabel;
  CGFloat floatingLabelHeight = floatingFont.lineHeight;
  CGFloat floatingLabelMaxY = floatingLabelMinY + floatingLabelHeight;
  CGFloat textRectMinYWithFloatingLabel =
      floatingLabelMaxY + positioningReference.paddingBetweenFloatingLabelAndEditingText;
  CGFloat textRectCenterYWithFloatingLabel =
      textRectMinYWithFloatingLabel + ((CGFloat)0.5 * textRectHeight);
  CGFloat textRectMinYFloatingLabel =
      (CGFloat)floor((double)(textRectCenterYWithFloatingLabel - (textRectHeight * (CGFloat)0.5)));
  CGRect textRectFloating =
      CGRectMake(textRectMinX, textRectMinYFloatingLabel, textRectWidth, textRectHeight);

  CGFloat containerHeight = shouldLayoutForFloatingLabel
                                ? positioningReference.containerHeightWithFloatingLabel
                                : positioningReference.containerHeightWithoutFloatingLabel;
  CGFloat containerMidY = (CGFloat)0.5 * containerHeight;
  BOOL isFloatingLabel = labelPosition == MDCTextControlLabelPositionFloating;
  CGFloat textRectMidY =
      isFloatingLabel ? CGRectGetMidY(textRectFloating) : CGRectGetMidY(textRectNormal);
  CGFloat sideViewMidY = [self sideViewMidYWithSideViewAlignment:sideViewAlignment
                                                   containerMidY:containerMidY
                                                    textRectMidY:textRectMidY];

  CGFloat leftViewHeight = CGRectGetHeight(leftView.frame);
  CGFloat rightViewHeight = CGRectGetHeight(rightView.frame);
  CGFloat leftViewMinY = [self minYForSubviewWithHeight:leftViewHeight centerY:sideViewMidY];
  CGFloat rightViewMinY = [self minYForSubviewWithHeight:rightViewHeight centerY:sideViewMidY];
  CGRect leftViewFrame = CGRectMake(leftViewMinX, leftViewMinY, leftViewWidth, leftViewHeight);
  CGRect rightViewFrame =
      CGRectMake(rightViewMinX, rightViewMinY, CGRectGetWidth(rightView.frame), rightViewHeight);
  CGFloat clearButtonMinY = [self minYForSubviewWithHeight:clearButtonSideLength
                                                   centerY:sideViewMidY];
  CGRect clearButtonFrame =
      CGRectMake(clearButtonMinX, clearButtonMinY, clearButtonSideLength, clearButtonSideLength);

  CGRect labelFrameNormal = [self labelFrameWithText:label.text
                                       labelPosition:MDCTextControlLabelPositionNormal
                                                font:font
                                        floatingFont:floatingFont
                                   floatingLabelMinY:floatingLabelMinY
                                            textRect:textRectNormal
                                               isRTL:isRTL];
  CGRect labelFrameFloating = [self labelFrameWithText:label.text
                                         labelPosition:MDCTextControlLabelPositionFloating
                                                  font:font
                                          floatingFont:floatingFont
                                     floatingLabelMinY:floatingLabelMinY
                                              textRect:textRectNormal
                                                 isRTL:isRTL];

  self.assistiveLabelViewLayout = [[MDCTextControlAssistiveLabelViewLayout alloc]
                         initWithWidth:textFieldWidth
                 leadingAssistiveLabel:leadingAssistiveLabel
                trailingAssistiveLabel:trailingAssistiveLabel
            assistiveLabelDrawPriority:assistiveLabelDrawPriority
      customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                    leadingEdgePadding:leadingEdgePadding
                   trailingEdgePadding:trailingEdgePadding
           paddingAboveAssistiveLabels:positioningReference.paddingAboveAssistiveLabels
           paddingBelowAssistiveLabels:positioningReference.paddingBelowAssistiveLabels
                                 isRTL:isRTL];
  self.assistiveLabelViewFrame = CGRectMake(0, containerHeight, textFieldWidth,
                                            self.assistiveLabelViewLayout.calculatedHeight);
  self.leadingViewFrame = isRTL ? rightViewFrame : leftViewFrame;
  self.trailingViewFrame = isRTL ? leftViewFrame : rightViewFrame;
  self.displaysLeadingView = isRTL ? displaysRightView : displaysLeftView;
  self.displaysTrailingView = isRTL ? displaysLeftView : displaysRightView;
  self.clearButtonFrame = clearButtonFrame;
  self.textRectFloating = textRectFloating;
  self.textRectNormal = textRectNormal;
  self.labelFrameFloating = labelFrameFloating;
  self.labelFrameNormal = labelFrameNormal;
  self.containerHeight = containerHeight;
}

- (CGFloat)sideViewMidYWithSideViewAlignment:
               (MDCTextControlTextFieldSideViewAlignment)sideViewAlignment
                               containerMidY:(CGFloat)containerMidY
                                textRectMidY:(CGFloat)textRectMidY {
  CGFloat sideViewMidY = containerMidY;
  switch (sideViewAlignment) {
    case MDCTextControlTextFieldSideViewAlignmentCenteredInContainer:
      break;
    case MDCTextControlTextFieldSideViewAlignmentAlignedWithText:
      sideViewMidY = textRectMidY;
      break;
    default:
      break;
  }
  return sideViewMidY;
}

- (CGFloat)minYForSubviewWithHeight:(CGFloat)height centerY:(CGFloat)centerY {
  return (CGFloat)round((double)(centerY - ((CGFloat)0.5 * height)));
}

- (BOOL)shouldDisplayClearButtonWithViewMode:(UITextFieldViewMode)viewMode
                                   isEditing:(BOOL)isEditing
                                        text:(NSString *)text {
  BOOL hasText = text.length > 0;
  switch (viewMode) {
    case UITextFieldViewModeWhileEditing:
      return isEditing && hasText;
    case UITextFieldViewModeUnlessEditing:
      return !isEditing;
    case UITextFieldViewModeAlways:
      return YES;
    case UITextFieldViewModeNever:
      return NO;
    default:
      return NO;
  }
}

- (CGSize)floatingLabelSizeWithText:(NSString *)placeholder
                           maxWidth:(CGFloat)maxWidth
                               font:(UIFont *)font {
  if (!font) {
    return CGSizeZero;
  }
  CGSize fittingSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
  NSDictionary *attributes = @{NSFontAttributeName : font};
  CGRect rect = [placeholder boundingRectWithSize:fittingSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attributes
                                          context:nil];
  rect.size.height = font.lineHeight;
  return rect.size;
}

- (CGRect)labelFrameWithText:(NSString *)text
               labelPosition:(MDCTextControlLabelPosition)labelPosition
                        font:(UIFont *)font
                floatingFont:(UIFont *)floatingFont
           floatingLabelMinY:(CGFloat)floatingLabelMinY
                    textRect:(CGRect)textRect
                       isRTL:(BOOL)isRTL {
  CGFloat labelMinX = CGRectGetMinX(textRect);
  CGFloat labelMaxX = CGRectGetMaxX(textRect);
  CGFloat maxWidth = labelMaxX - labelMinX;
  CGSize size = CGSizeZero;
  CGRect rect = CGRectZero;
  CGFloat originX = 0;
  CGFloat originY = 0;
  switch (labelPosition) {
    case MDCTextControlLabelPositionNone:
      break;
    case MDCTextControlLabelPositionFloating:
      size = [self floatingLabelSizeWithText:text maxWidth:maxWidth font:floatingFont];
      originY = floatingLabelMinY;
      if (isRTL) {
        originX = labelMaxX - size.width;
      } else {
        originX = labelMinX;
      }
      rect = CGRectMake(originX, originY, size.width, size.height);
      break;
    case MDCTextControlLabelPositionNormal:
      size = [self floatingLabelSizeWithText:text maxWidth:maxWidth font:font];
      CGFloat textRectMidY = CGRectGetMidY(textRect);
      originY = textRectMidY - ((CGFloat)0.5 * size.height);
      if (isRTL) {
        originX = labelMaxX - size.width;
      } else {
        originX = labelMinX;
      }
      rect = CGRectMake(originX, originY, size.width, size.height);
      break;
    default:
      break;
  }
  return rect;
}

- (CGFloat)textHeightWithFont:(UIFont *)font {
  return (CGFloat)ceil((double)font.lineHeight);
}

- (CGFloat)calculatedHeight {
  CGFloat maxY = self.containerHeight;
  CGFloat assistiveLabelViewMaxY = CGRectGetMaxY(self.assistiveLabelViewFrame);
  if (assistiveLabelViewMaxY > maxY) {
    maxY = assistiveLabelViewMaxY;
  }
  return ceil(maxY);
}

- (CGRect)labelFrameWithLabelPosition:(MDCTextControlLabelPosition)labelPosition {
  if (labelPosition == MDCTextControlLabelPositionFloating) {
    return self.labelFrameFloating;
  } else if (labelPosition == MDCTextControlLabelPositionNormal) {
    return self.labelFrameNormal;
  } else {
    return CGRectZero;
  }
}

@end
