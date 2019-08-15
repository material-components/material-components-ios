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

static const CGFloat kFloatingLabelXOffsetFromTextArea = (CGFloat)3.0;

static const CGFloat kHorizontalPadding = (CGFloat)12.0;

@interface MDCBaseTextFieldLayout ()
@end

@implementation MDCBaseTextFieldLayout

#pragma mark Object Lifecycle

- (instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                       containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
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
                          clearButton:(MDCContainedInputViewClearButton *)clearButton
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
                            containerStyle:containerStyle
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
                               clearButton:clearButton
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
                          containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
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
                             clearButton:(MDCContainedInputViewClearButton *)clearButton
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode
                      leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                     rightAssistiveLabel:(UILabel *)rightAssistiveLabel
              underlineLabelDrawPriority:
                  (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
        customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                preferredContainerHeight:(CGFloat)preferredContainerHeight
                                   isRTL:(BOOL)isRTL
                               isEditing:(BOOL)isEditing {
  id<MDCContainerStyleVerticalPositioningReference> positioningDelegate =
      [containerStyle positioningReferenceWithFloatingFontLineHeight:floatingFont.lineHeight
                                                normalFontLineHeight:font.lineHeight
                                                       textRowHeight:font.lineHeight
                                                    numberOfTextRows:1
                                                             density:0
                                            preferredContainerHeight:preferredContainerHeight
                                                          labelState:labelState
                                                       labelBehavior:labelBehavior];

  BOOL shouldAttemptToDisplayLeftView = [self shouldAttemptToDisplaySideView:leftView
                                                                    viewMode:leftViewMode
                                                                   isEditing:isEditing];
  BOOL shouldAttemptToDisplayRightView = [self shouldAttemptToDisplaySideView:rightView
                                                                     viewMode:rightViewMode
                                                                    isEditing:isEditing];
  BOOL shouldAttemptToDisplayClearButton = [self shouldAttemptToDisplayClearButton:clearButton
                                                                          viewMode:clearButtonMode
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

  CGFloat apparentClearButtonMinX = 0;
  if (isRTL) {
    apparentClearButtonMinX =
        shouldAttemptToDisplayLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
  } else {
    CGFloat apparentClearButtonMaxX = shouldAttemptToDisplayRightView
                                          ? rightViewMinX - kHorizontalPadding
                                          : textFieldWidth - kHorizontalPadding;
    apparentClearButtonMinX = apparentClearButtonMaxX - clearButton.imageViewSideLength;
  }

  CGFloat clearButtonImageViewSideMargin =
      (clearButton.sideLength - clearButton.imageViewSideLength) * (CGFloat)0.5;
  CGFloat actualClearButtonMinX = apparentClearButtonMinX - clearButtonImageViewSideMargin;

  CGFloat floatingLabelMinY = positioningDelegate.paddingBetweenTopAndFloatingLabel;
  CGFloat floatingLabelHeight = floatingFont.lineHeight;
  CGFloat floatingLabelMaxY = floatingLabelMinY + floatingLabelHeight;

  CGFloat textRectMinYWithFloatingLabel =
      floatingLabelMaxY + positioningDelegate.paddingBetweenFloatingLabelAndText;

  CGFloat textRectHeight = [self textHeightWithFont:font];
  CGFloat textRectCenterYWithFloatingLabel =
      textRectMinYWithFloatingLabel + ((CGFloat)0.5 * textRectHeight);

  CGFloat topRowBottomRowDividerY = positioningDelegate.containerHeight;

  CGFloat textRectMinYNormal = positioningDelegate.paddingBetweenTopAndNormalLabel;
  CGFloat textRectCenterYNormal = textRectMinYNormal + ((CGFloat)0.5 * textRectHeight);
  CGFloat containerMidY = (CGFloat)0.5 * topRowBottomRowDividerY;

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

  CGFloat clearButtonMinY = 0;
  CGFloat clearButtonFloatingMinY = 0;
  if (shouldAttemptToDisplayClearButton) {
    clearButtonMinY = [self minYForSubviewWithHeight:clearButton.sideLength
                                             centerY:textRectCenterYNormal];
    clearButtonFloatingMinY = [self minYForSubviewWithHeight:clearButton.sideLength
                                                     centerY:textRectCenterYWithFloatingLabel];
  }

  CGFloat textRectMinX = 0;
  CGFloat textRectMaxX = 0;
  CGFloat normalLabelMinX = 0;
  CGFloat normalLabelMaxX = 0;
  CGFloat floatingLabelMinX = 0;
  CGFloat floatingLabelMaxX = 0;

  if (isRTL) {
    if (shouldAttemptToDisplayClearButton) {
      CGFloat apparentClearButtonMaxX = apparentClearButtonMinX + clearButton.imageViewSideLength;
      textRectMinX = apparentClearButtonMaxX + kHorizontalPadding;
      normalLabelMinX = textRectMinX;
      floatingLabelMinX = apparentClearButtonMinX;
    } else {
      textRectMinX =
          shouldAttemptToDisplayLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
      normalLabelMinX = textRectMinX;
      floatingLabelMinX = textRectMinX;
    }
    if (shouldAttemptToDisplayRightView) {
      textRectMaxX = rightViewMinX - kHorizontalPadding;
    } else {
      textRectMaxX = textFieldWidth - kHorizontalPadding;
    }
    normalLabelMaxX = textRectMaxX;
    floatingLabelMaxX = normalLabelMaxX - kFloatingLabelXOffsetFromTextArea;
  } else {
    textRectMinX =
        shouldAttemptToDisplayLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
    normalLabelMinX = textRectMinX;
    floatingLabelMinX = normalLabelMinX + kFloatingLabelXOffsetFromTextArea;
    if (shouldAttemptToDisplayClearButton) {
      textRectMaxX = apparentClearButtonMinX - kHorizontalPadding;
    } else {
      textRectMaxX = shouldAttemptToDisplayRightView ? rightViewMinX - kHorizontalPadding
                                                     : textFieldWidth - kHorizontalPadding;
    }
    normalLabelMaxX = textRectMaxX;
    floatingLabelMaxX = shouldAttemptToDisplayRightView ? rightViewMinX - kHorizontalPadding
                                                        : textFieldWidth - kHorizontalPadding;
  }

  CGFloat textRectWidth = textRectMaxX - textRectMinX;
  CGRect textRectNormal =
      CGRectMake(textRectMinX, textRectMinYNormal, textRectWidth, textRectHeight);
  CGFloat textRectMinYFloatingLabel =
      (CGFloat)floor((double)(textRectCenterYWithFloatingLabel - (textRectHeight * (CGFloat)0.5)));
  CGRect floatingLabelTextAreaRect =
      CGRectMake(textRectMinX, textRectMinYFloatingLabel, textRectWidth, textRectHeight);

  CGRect leftViewFrame = CGRectMake(leftViewMinX, leftViewMinY, leftViewWidth, leftViewHeight);
  CGRect rightViewFrame =
      CGRectMake(rightViewMinX, rightViewMinY, CGRectGetWidth(rightView.frame), rightViewHeight);
  CGRect clearButtonFrameNormal = CGRectMake(actualClearButtonMinX, clearButtonMinY,
                                             clearButton.sideLength, clearButton.sideLength);
  CGRect clearButtonFrameFloating = CGRectMake(actualClearButtonMinX, clearButtonFloatingMinY,
                                               clearButton.sideLength, clearButton.sideLength);

  CGRect labelFrameNormal = [self labelFrameWithText:label.text
                                          labelState:MDCContainedInputViewLabelStateNormal
                                                font:font
                                        floatingFont:floatingFont
                                   floatingLabelMinY:floatingLabelMinY
                               lowestPlaceholderMinX:normalLabelMinX
                              highestPlaceholderMaxX:normalLabelMaxX
                                            textRect:textRectNormal
                                               isRTL:isRTL];
  CGRect labelFrameFloating = [self labelFrameWithText:label.text
                                            labelState:MDCContainedInputViewLabelStateFloating
                                                  font:font
                                          floatingFont:floatingFont
                                     floatingLabelMinY:floatingLabelMinY
                                 lowestPlaceholderMinX:floatingLabelMinX
                                highestPlaceholderMaxX:floatingLabelMaxX
                                              textRect:textRectNormal
                                                 isRTL:isRTL];

  CGFloat assistiveLabelVerticalPadding = positioningDelegate.paddingAroundAssistiveLabels;
  self.underlineLabelViewLayout = [[MDCContainedInputAssistiveLabelViewLayout alloc]
                initWithSuperviewWidth:textFieldWidth
                    leftAssistiveLabel:leftAssistiveLabel
                   rightAssistiveLabel:rightAssistiveLabel
            underlineLabelDrawPriority:underlineLabelDrawPriority
      customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                     horizontalPadding:kHorizontalPadding
                       verticalPadding:assistiveLabelVerticalPadding
                                 isRTL:isRTL];
  self.underlineLabelViewFrame = CGRectMake(0, topRowBottomRowDividerY, textFieldWidth,
                                            self.underlineLabelViewLayout.calculatedHeight);

  self.leftViewFrame = leftViewFrame;
  self.rightViewFrame = rightViewFrame;
  self.clearButtonFrameFloating = clearButtonFrameFloating;
  self.clearButtonFrameNormal = clearButtonFrameNormal;
  self.textRectFloating = floatingLabelTextAreaRect;
  self.textRectNormal = textRectNormal;
  self.placeholderFrameFloating = floatingLabelTextAreaRect;
  self.placeholderFrameNormal = textRectNormal;
  self.labelFrameFloating = labelFrameFloating;
  self.labelFrameNormal = labelFrameNormal;
  self.topRowBottomRowDividerY = topRowBottomRowDividerY;
  self.clearButtonHidden = !shouldAttemptToDisplayClearButton;
  self.leftViewHidden = !shouldAttemptToDisplayLeftView;
  self.rightViewHidden = !shouldAttemptToDisplayRightView;
  self.topRowBottomRowDividerY = topRowBottomRowDividerY;
}

- (CGSize)underlineLabelSizeWithLabel:(UILabel *)label constrainedToWidth:(CGFloat)maxWidth {
  if (maxWidth <= 0 || label.text.length <= 0 || label.hidden) {
    return CGSizeZero;
  }
  CGSize fittingSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
  CGSize size = [label sizeThatFits:fittingSize];
  if (size.width > maxWidth) {
    size.width = maxWidth;
  }
  return size;
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

- (BOOL)shouldAttemptToDisplayClearButton:(UIButton *)clearButton
                                 viewMode:(UITextFieldViewMode)viewMode
                                isEditing:(BOOL)isEditing
                                     text:(NSString *)text {
  BOOL hasText = text.length > 0;
  BOOL shouldAttemptToDisplayClearButton = NO;
  switch (viewMode) {
    case UITextFieldViewModeWhileEditing:
      shouldAttemptToDisplayClearButton = isEditing && hasText;
      break;
    case UITextFieldViewModeUnlessEditing:
      shouldAttemptToDisplayClearButton = !isEditing;
      break;
    case UITextFieldViewModeAlways:
      shouldAttemptToDisplayClearButton = YES;
      break;
    case UITextFieldViewModeNever:
      shouldAttemptToDisplayClearButton = NO;
      break;
    default:
      break;
  }
  return shouldAttemptToDisplayClearButton;
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
       lowestPlaceholderMinX:(CGFloat)lowestPlaceholderMinX
      highestPlaceholderMaxX:(CGFloat)highestPlaceholderMaxX
                    textRect:(CGRect)textRect
                       isRTL:(BOOL)isRTL {
  CGFloat maxWidth = highestPlaceholderMaxX - lowestPlaceholderMinX;
  CGFloat textRectMidY = CGRectGetMidY(textRect);
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
        originX = highestPlaceholderMaxX - size.width;
      } else {
        originX = lowestPlaceholderMinX;
      }
      rect = CGRectMake(originX, originY, size.width, size.height);
      break;
    case MDCContainedInputViewLabelStateNormal:
      size = [self floatingLabelSizeWithText:text maxWidth:maxWidth font:font];
      originY = textRectMidY - ((CGFloat)0.5 * size.height);
      if (isRTL) {
        originX = highestPlaceholderMaxX - size.width;
      } else {
        originX = lowestPlaceholderMinX;
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
  CGFloat underlineLabelViewMaxY = CGRectGetMaxY(self.underlineLabelViewFrame);
  if (underlineLabelViewMaxY > maxY) {
    maxY = underlineLabelViewMaxY;
  }
  return maxY;
}

@end
