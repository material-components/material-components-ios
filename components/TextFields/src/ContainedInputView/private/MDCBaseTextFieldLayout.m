// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

static const CGFloat kHorizontalPadding = (CGFloat)12.0;

@interface MDCBaseTextFieldLayout ()
@end

@implementation MDCBaseTextFieldLayout

#pragma mark Object Lifecycle

- (instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                 positioningReference:
                     (id<MDCContainerStyleVerticalPositioningReference>)positioningReference
                                 text:(NSString *)text
                          placeholder:(NSString *)placeholder
                                 font:(UIFont *)font
                         floatingFont:(UIFont *)floatingFont
                                label:(UILabel *)label
                           labelState:(MDCContainedInputViewLabelState)labelState
                        labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
                             leftView:(UIView *)leftView
                         leftViewMode:(UITextFieldViewMode)leftViewMode
                            rightView:(UIView *)rightView
                        rightViewMode:(UITextFieldViewMode)rightViewMode
                clearButtonSideLength:(CGFloat)clearButtonSideLength
                      clearButtonMode:(UITextFieldViewMode)clearButtonMode
                   leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                  rightAssistiveLabel:(UILabel *)rightAssistiveLabel
           underlineLabelDrawPriority:
               (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
     customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
             preferredContainerHeight:(CGFloat)preferredContainerHeight
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithTextFieldSize:textFieldSize
                      positioningReference:positioningReference
                                      text:text
                               placeholder:placeholder
                                      font:font
                              floatingFont:floatingFont
                                     label:label
                                labelState:labelState
                             labelBehavior:labelBehavior
                                  leftView:leftView
                              leftViewMode:leftViewMode
                                 rightView:rightView
                             rightViewMode:rightViewMode
                     clearButtonSideLength:clearButtonSideLength
                           clearButtonMode:clearButtonMode
                        leftAssistiveLabel:leftAssistiveLabel
                       rightAssistiveLabel:rightAssistiveLabel
                underlineLabelDrawPriority:underlineLabelDrawPriority
          customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                  preferredContainerHeight:preferredContainerHeight
                                     isRTL:isRTL
                                 isEditing:isEditing];
    return self;
  }
  return nil;
}

#pragma mark Layout Calculation

- (void)calculateLayoutWithTextFieldSize:(CGSize)textFieldSize
                    positioningReference:
                        (id<MDCContainerStyleVerticalPositioningReference>)positioningReference
                                    text:(NSString *)text
                             placeholder:(NSString *)placeholder
                                    font:(UIFont *)font
                            floatingFont:(UIFont *)floatingFont
                                   label:(UILabel *)label
                              labelState:(MDCContainedInputViewLabelState)labelState
                           labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
                                leftView:(UIView *)leftView
                            leftViewMode:(UITextFieldViewMode)leftViewMode
                               rightView:(UIView *)rightView
                           rightViewMode:(UITextFieldViewMode)rightViewMode
                   clearButtonSideLength:(CGFloat)clearButtonSideLength
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode
                      leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                     rightAssistiveLabel:(UILabel *)rightAssistiveLabel
              underlineLabelDrawPriority:
                  (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
        customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                preferredContainerHeight:(CGFloat)preferredContainerHeight
                                   isRTL:(BOOL)isRTL
                               isEditing:(BOOL)isEditing {
  BOOL shouldAttemptToDisplayLeftView = [self shouldAttemptToDisplaySideView:leftView
                                                                    viewMode:leftViewMode
                                                                   isEditing:isEditing];
  BOOL shouldAttemptToDisplayRightView = [self shouldAttemptToDisplaySideView:rightView
                                                                     viewMode:rightViewMode
                                                                    isEditing:isEditing];
  BOOL shouldAttemptToDisplayClearButton =
      [self shouldDisplayClearButtonWithViewMode:clearButtonMode
                                       isEditing:isEditing
                                            text:text];

  CGFloat leftViewWidth = CGRectGetWidth(leftView.frame);
  CGFloat leftViewMinX = 0;
  CGFloat leftViewMaxX = 0;
  if (shouldAttemptToDisplayLeftView) {
    leftViewMinX = kHorizontalPadding;
    leftViewMaxX = leftViewMinX + leftViewWidth;
  }

  CGFloat textFieldWidth = textFieldSize.width;
  CGFloat rightViewMinX = 0;
  if (shouldAttemptToDisplayRightView) {
    CGFloat rightViewMaxX = textFieldWidth - kHorizontalPadding;
    rightViewMinX = rightViewMaxX - CGRectGetWidth(rightView.frame);
  }

  CGFloat clearButtonMinX = 0;
  if (isRTL) {
    clearButtonMinX =
        shouldAttemptToDisplayLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
  } else {
    CGFloat clearButtonMaxX = shouldAttemptToDisplayRightView
                                          ? rightViewMinX - kHorizontalPadding
                                          : textFieldWidth - kHorizontalPadding;
    clearButtonMinX = clearButtonMaxX - clearButtonSideLength;
  }

  CGFloat floatingLabelMinY = positioningReference.paddingBetweenTopAndFloatingLabel;
  CGFloat floatingLabelHeight = floatingFont.lineHeight;
  CGFloat floatingLabelMaxY = floatingLabelMinY + floatingLabelHeight;

  CGFloat textRectMinYWithFloatingLabel =
      floatingLabelMaxY + positioningReference.paddingBetweenFloatingLabelAndText;

  CGFloat textRectHeight = [self textHeightWithFont:font];
  CGFloat textRectCenterYWithFloatingLabel =
      textRectMinYWithFloatingLabel + ((CGFloat)0.5 * textRectHeight);

  CGFloat textRectMinYNormal = positioningReference.paddingBetweenTopAndNormalLabel;
  CGFloat textRectCenterYNormal = textRectMinYNormal + ((CGFloat)0.5 * textRectHeight);
  CGFloat containerMidY = (CGFloat)0.5 * positioningReference.containerHeight;

  CGFloat leftViewHeight = CGRectGetHeight(leftView.frame);
  CGFloat leftViewMinY = 0;
  if (shouldAttemptToDisplayLeftView) {
    leftViewMinY = [self minYForSubviewWithHeight:leftViewHeight centerY:containerMidY];
  }

  CGFloat rightViewHeight = CGRectGetHeight(rightView.frame);
  CGFloat rightViewMinY = 0;
  if (shouldAttemptToDisplayRightView) {
    rightViewMinY = [self minYForSubviewWithHeight:rightViewHeight centerY:containerMidY];
  }

  CGFloat clearButtonMinY = [self minYForSubviewWithHeight:clearButtonSideLength
                                                   centerY:textRectCenterYNormal];
  CGFloat clearButtonFloatingMinY = [self minYForSubviewWithHeight:clearButtonSideLength
                                                           centerY:textRectCenterYWithFloatingLabel];

  CGFloat textRectMinX = 0;
  CGFloat textRectMaxX = 0;
  CGFloat labelMinX = 0;
  CGFloat labelMaxX = 0;
  CGFloat floatingLabelMinX = 0;
  CGFloat floatingLabelMaxX = 0;

  if (isRTL) {
    if (shouldAttemptToDisplayClearButton) {
      CGFloat clearButtonMaxX = clearButtonMinX + clearButtonSideLength;
      textRectMinX = clearButtonMaxX + kHorizontalPadding;
      labelMinX = textRectMinX;
      floatingLabelMinX = clearButtonMinX;
    } else {
      textRectMinX =
          shouldAttemptToDisplayLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
      labelMinX = textRectMinX;
      floatingLabelMinX = textRectMinX;
    }
    if (shouldAttemptToDisplayRightView) {
      textRectMaxX = rightViewMinX - kHorizontalPadding;
    } else {
      textRectMaxX = textFieldWidth - kHorizontalPadding;
    }
    labelMaxX = textRectMaxX;
    floatingLabelMaxX = labelMaxX;
  } else {
    textRectMinX =
        shouldAttemptToDisplayLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
    labelMinX = textRectMinX;
    floatingLabelMinX = labelMinX;
    if (shouldAttemptToDisplayClearButton) {
      textRectMaxX = clearButtonMinX - kHorizontalPadding;
    } else {
      textRectMaxX = shouldAttemptToDisplayRightView ? rightViewMinX - kHorizontalPadding
                                                     : textFieldWidth - kHorizontalPadding;
    }
    labelMaxX = textRectMaxX;
    floatingLabelMaxX = shouldAttemptToDisplayRightView ? rightViewMinX - kHorizontalPadding
                                                        : textFieldWidth - kHorizontalPadding;
  }

  CGFloat textRectWidth = textRectMaxX - textRectMinX;
  CGRect textRectNormal =
      CGRectMake(textRectMinX, textRectMinYNormal, textRectWidth, textRectHeight);
  CGFloat textRectMinYFloatingLabel =
      (CGFloat)floor((double)(textRectCenterYWithFloatingLabel - (textRectHeight * (CGFloat)0.5)));
  CGRect textRectFloating =
      CGRectMake(textRectMinX, textRectMinYFloatingLabel, textRectWidth, textRectHeight);

  CGRect leftViewFrame = CGRectMake(leftViewMinX, leftViewMinY, leftViewWidth, leftViewHeight);
  CGRect rightViewFrame =
      CGRectMake(rightViewMinX, rightViewMinY, CGRectGetWidth(rightView.frame), rightViewHeight);
  CGRect clearButtonFrameNormal = CGRectMake(clearButtonMinX, clearButtonMinY,
                                             clearButtonSideLength, clearButtonSideLength);
  CGRect clearButtonFrameFloating = CGRectMake(clearButtonMinX, clearButtonFloatingMinY,
                                               clearButtonSideLength, clearButtonSideLength);

  CGRect labelFrameNormal = [self labelFrameWithText:label.text
                                          labelState:MDCContainedInputViewLabelStateNormal
                                                font:font
                                        floatingFont:floatingFont
                                   floatingLabelMinY:floatingLabelMinY
                                           labelMinX:labelMinX
                                           labelMaxX:labelMaxX
                                            textRect:textRectNormal
                                               isRTL:isRTL];
  CGRect labelFrameFloating = [self labelFrameWithText:label.text
                                            labelState:MDCContainedInputViewLabelStateFloating
                                                  font:font
                                          floatingFont:floatingFont
                                     floatingLabelMinY:floatingLabelMinY
                                             labelMinX:floatingLabelMinX
                                             labelMaxX:floatingLabelMaxX
                                              textRect:textRectNormal
                                                 isRTL:isRTL];

  CGFloat assistiveLabelVerticalPadding = positioningReference.paddingAroundAssistiveLabels;
  self.assistiveLabelViewLayout = [[MDCContainedInputAssistiveLabelViewLayout alloc]
                initWithSuperviewWidth:textFieldWidth
                    leftAssistiveLabel:leftAssistiveLabel
                   rightAssistiveLabel:rightAssistiveLabel
            underlineLabelDrawPriority:underlineLabelDrawPriority
      customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                     horizontalPadding:kHorizontalPadding
                       verticalPadding:assistiveLabelVerticalPadding
                                 isRTL:isRTL];
  self.assistiveLabelViewFrame = CGRectMake(0, positioningReference.containerHeight, textFieldWidth,
                                            self.assistiveLabelViewLayout.calculatedHeight);

  self.leftViewFrame = leftViewFrame;
  self.rightViewFrame = rightViewFrame;
  self.clearButtonFrameFloating = clearButtonFrameFloating;
  self.clearButtonFrameNormal = clearButtonFrameNormal;
  self.textRectFloating = textRectFloating;
  self.textRectNormal = textRectNormal;
  self.placeholderFrameFloating = textRectFloating;
  self.placeholderFrameNormal = textRectNormal;
  self.labelFrameFloating = labelFrameFloating;
  self.labelFrameNormal = labelFrameNormal;
  self.leftViewHidden = !shouldAttemptToDisplayLeftView;
  self.rightViewHidden = !shouldAttemptToDisplayRightView;
  self.topRowBottomRowDividerY = positioningReference.containerHeight;
}

- (CGFloat)leadingAssistiveLabelWidthWithCombinedAssistiveLabelsWidth:
               (CGFloat)totalAssistiveLabelsWidth
                                                   customDrawPriority:(CGFloat)customDrawPriority {
  return customDrawPriority * totalAssistiveLabelsWidth;
}

- (CGFloat)minYForSubviewWithHeight:(CGFloat)height centerY:(CGFloat)centerY {
  return (CGFloat)round((double)(centerY - ((CGFloat)0.5 * height)));
}

- (BOOL)shouldAttemptToDisplaySideView:(UIView *)subview
                              viewMode:(UITextFieldViewMode)viewMode
                             isEditing:(BOOL)isEditing {
  BOOL shouldAttemptToDisplaySideView = NO;
  if (subview && !CGSizeEqualToSize(CGSizeZero, subview.frame.size)) {
    switch (viewMode) {
      case UITextFieldViewModeWhileEditing:
        shouldAttemptToDisplaySideView = isEditing;
        break;
      case UITextFieldViewModeUnlessEditing:
        shouldAttemptToDisplaySideView = !isEditing;
        break;
      case UITextFieldViewModeAlways:
        shouldAttemptToDisplaySideView = YES;
        break;
      case UITextFieldViewModeNever:
        shouldAttemptToDisplaySideView = NO;
        break;
      default:
        break;
    }
  }
  return shouldAttemptToDisplaySideView;
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
                  labelState:(MDCContainedInputViewLabelState)labelState
                        font:(UIFont *)font
                floatingFont:(UIFont *)floatingFont
           floatingLabelMinY:(CGFloat)floatingLabelMinY
                   labelMinX:(CGFloat)labelMinX
                   labelMaxX:(CGFloat)labelMaxX
                    textRect:(CGRect)textRect
                       isRTL:(BOOL)isRTL {
  CGFloat maxWidth = labelMaxX - labelMinX;
  CGSize size = CGSizeZero;
  CGRect rect = CGRectZero;
  CGFloat originX = 0;
  CGFloat originY = 0;
  switch (labelState) {
    case MDCContainedInputViewLabelStateNone:
      break;
    case MDCContainedInputViewLabelStateFloating:
      size = [self floatingLabelSizeWithText:text maxWidth:maxWidth font:floatingFont];
      originY = floatingLabelMinY;
      if (isRTL) {
        originX = labelMaxX - size.width;
      } else {
        originX = labelMinX;
      }
      rect = CGRectMake(originX, originY, size.width, size.height);
      break;
    case MDCContainedInputViewLabelStateNormal:
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
  CGFloat maxY = 0;
  CGFloat labelFrameFloatingMaxY = CGRectGetMaxY(self.labelFrameFloating);
  if (labelFrameFloatingMaxY > maxY) {
    maxY = labelFrameFloatingMaxY;
  }
  CGFloat labelFrameNormalMaxY = CGRectGetMaxY(self.labelFrameNormal);
  if (labelFrameFloatingMaxY > maxY) {
    maxY = labelFrameNormalMaxY;
  }
  CGFloat textRectNormalMaxY = CGRectGetMaxY(self.textRectNormal);
  if (textRectNormalMaxY > maxY) {
    maxY = textRectNormalMaxY;
  }
  CGFloat textRectFloatingMaxY = CGRectGetMaxY(self.textRectFloating);
  if (textRectFloatingMaxY > maxY) {
    maxY = textRectFloatingMaxY;
  }
  CGFloat clearButtonFrameNormalMaxY = CGRectGetMaxY(self.clearButtonFrameNormal);
  if (clearButtonFrameNormalMaxY > maxY) {
    maxY = clearButtonFrameNormalMaxY;
  }
  CGFloat clearButtonFrameFloatingMaxY = CGRectGetMaxY(self.clearButtonFrameFloating);
  if (clearButtonFrameFloatingMaxY > maxY) {
    maxY = clearButtonFrameFloatingMaxY;
  }
  CGFloat leftViewFrameMaxY = CGRectGetMaxY(self.leftViewFrame);
  if (leftViewFrameMaxY > maxY) {
    maxY = leftViewFrameMaxY;
  }
  CGFloat rightViewFrameMaxY = CGRectGetMaxY(self.rightViewFrame);
  if (rightViewFrameMaxY > maxY) {
    maxY = rightViewFrameMaxY;
  }
  if (self.topRowBottomRowDividerY > maxY) {
    maxY = self.topRowBottomRowDividerY;
  }
  CGFloat underlineLabelViewMaxY = CGRectGetMaxY(self.assistiveLabelViewFrame);
  if (underlineLabelViewMaxY > maxY) {
    maxY = underlineLabelViewMaxY;
  }
  return maxY;
}

@end
