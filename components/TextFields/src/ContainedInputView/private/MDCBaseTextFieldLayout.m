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
#import "MDCContainedInputViewLabelState.h"

static const CGFloat kHorizontalPadding = (CGFloat)12.0;

@interface MDCBaseTextFieldLayout ()
@end

@implementation MDCBaseTextFieldLayout

#pragma mark Object Lifecycle

- (instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                 positioningReference:
                     (id<MDCContainerStyleVerticalPositioningReference>)positioningReference
                                 text:(NSString *)text
                                 font:(UIFont *)font
                         floatingFont:(UIFont *)floatingFont
                                label:(UILabel *)label
                             leftView:(UIView *)leftView
                         leftViewMode:(UITextFieldViewMode)leftViewMode
                            rightView:(UIView *)rightView
                        rightViewMode:(UITextFieldViewMode)rightViewMode
                          clearButton:(MDCContainedInputViewClearButton *)clearButton
                      clearButtonMode:(UITextFieldViewMode)clearButtonMode
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithTextFieldSize:textFieldSize
                      positioningReference:positioningReference
                                      text:text
                                      font:font
                              floatingFont:floatingFont
                                     label:label
                                  leftView:leftView
                              leftViewMode:leftViewMode
                                 rightView:rightView
                             rightViewMode:rightViewMode
                               clearButton:clearButton
                           clearButtonMode:clearButtonMode
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
                                    font:(UIFont *)font
                            floatingFont:(UIFont *)floatingFont
                                   label:(UILabel *)label
                                leftView:(UIView *)leftView
                            leftViewMode:(UITextFieldViewMode)leftViewMode
                               rightView:(UIView *)rightView
                           rightViewMode:(UITextFieldViewMode)rightViewMode
                             clearButton:(MDCContainedInputViewClearButton *)clearButton
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode
                                   isRTL:(BOOL)isRTL
                               isEditing:(BOOL)isEditing {
  BOOL displaysLeftView = [self displaysSideView:leftView
                                        viewMode:leftViewMode
                                       isEditing:isEditing];
  BOOL displaysRightView = [self displaysSideView:rightView
                                         viewMode:rightViewMode
                                        isEditing:isEditing];
  BOOL displaysClearButton = [self shouldDisplayClearButton:clearButton
                                                   viewMode:clearButtonMode
                                                  isEditing:isEditing
                                                       text:text];
  CGFloat leftViewWidth = CGRectGetWidth(leftView.frame);
  CGFloat leftViewMinX = 0;
  CGFloat leftViewMaxX = 0;
  if (displaysLeftView) {
    leftViewMinX = kHorizontalPadding;
    leftViewMaxX = leftViewMinX + leftViewWidth;
  }

  CGFloat textFieldWidth = textFieldSize.width;
  CGFloat rightViewMinX = 0;
  if (displaysRightView) {
    CGFloat rightViewMaxX = textFieldWidth - kHorizontalPadding;
    rightViewMinX = rightViewMaxX - CGRectGetWidth(rightView.frame);
  }

  CGFloat apparentClearButtonMinX = 0;
  if (isRTL) {
    apparentClearButtonMinX =
        displaysLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
  } else {
    CGFloat apparentClearButtonMaxX = displaysRightView ? rightViewMinX - kHorizontalPadding
                                                        : textFieldWidth - kHorizontalPadding;
    apparentClearButtonMinX = apparentClearButtonMaxX - clearButton.imageViewSideLength;
  }

  CGFloat clearButtonImageViewSideMargin =
      (clearButton.sideLength - clearButton.imageViewSideLength) * (CGFloat)0.5;
  CGFloat actualClearButtonMinX = apparentClearButtonMinX - clearButtonImageViewSideMargin;

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
  if (displaysLeftView) {
    leftViewMinY = [self minYForSubviewWithHeight:leftViewHeight centerY:containerMidY];
  }

  CGFloat rightViewHeight = CGRectGetHeight(rightView.frame);
  CGFloat rightViewMinY = 0;
  if (displaysRightView) {
    rightViewMinY = [self minYForSubviewWithHeight:rightViewHeight centerY:containerMidY];
  }

  CGFloat clearButtonMinY = 0;
  CGFloat clearButtonFloatingMinY = 0;
  if (displaysClearButton) {
    clearButtonMinY = [self minYForSubviewWithHeight:clearButton.sideLength
                                             centerY:textRectCenterYNormal];
    clearButtonFloatingMinY = [self minYForSubviewWithHeight:clearButton.sideLength
                                                     centerY:textRectCenterYWithFloatingLabel];
  }

  CGFloat textRectMinX = 0;
  CGFloat textRectMaxX = 0;
  CGFloat labelMinX = 0;
  CGFloat labelMaxX = 0;
  CGFloat floatingLabelMinX = 0;
  CGFloat floatingLabelMaxX = 0;

  if (isRTL) {
    if (displaysClearButton) {
      CGFloat apparentClearButtonMaxX = apparentClearButtonMinX + clearButton.imageViewSideLength;
      textRectMinX = apparentClearButtonMaxX + kHorizontalPadding;
      labelMinX = textRectMinX;
      floatingLabelMinX = apparentClearButtonMinX;
    } else {
      textRectMinX = displaysLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
      labelMinX = textRectMinX;
      floatingLabelMinX = textRectMinX;
    }
    if (displaysRightView) {
      textRectMaxX = rightViewMinX - kHorizontalPadding;
    } else {
      textRectMaxX = textFieldWidth - kHorizontalPadding;
    }
    labelMaxX = textRectMaxX;
    floatingLabelMaxX = labelMaxX;
  } else {
    textRectMinX = displaysLeftView ? leftViewMaxX + kHorizontalPadding : kHorizontalPadding;
    labelMinX = textRectMinX;
    floatingLabelMinX = labelMinX;
    if (displaysClearButton) {
      textRectMaxX = apparentClearButtonMinX - kHorizontalPadding;
    } else {
      textRectMaxX = displaysRightView ? rightViewMinX - kHorizontalPadding
                                       : textFieldWidth - kHorizontalPadding;
    }
    labelMaxX = textRectMaxX;
    floatingLabelMaxX = displaysRightView ? rightViewMinX - kHorizontalPadding
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

  CGRect clearButtonFrameNormal = CGRectMake(actualClearButtonMinX, clearButtonMinY,
                                             clearButton.sideLength, clearButton.sideLength);
  CGRect clearButtonFrameFloating = CGRectMake(actualClearButtonMinX, clearButtonFloatingMinY,
                                               clearButton.sideLength, clearButton.sideLength);

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

  self.leftViewFrame = leftViewFrame;
  self.rightViewFrame = rightViewFrame;
  self.clearButtonFrameFloating = clearButtonFrameFloating;
  self.clearButtonFrameNormal = clearButtonFrameNormal;
  self.textRectFloating = textRectFloating;
  self.textRectNormal = textRectNormal;
  self.labelFrameFloating = labelFrameFloating;
  self.labelFrameNormal = labelFrameNormal;
  self.clearButtonHidden = !displaysClearButton;
  self.leftViewHidden = !displaysLeftView;
  self.rightViewHidden = !displaysRightView;
}

- (CGFloat)minYForSubviewWithHeight:(CGFloat)height centerY:(CGFloat)centerY {
  return (CGFloat)round((double)(centerY - ((CGFloat)0.5 * height)));
}

- (BOOL)displaysSideView:(UIView *)subview
                viewMode:(UITextFieldViewMode)viewMode
               isEditing:(BOOL)isEditing {
  BOOL displaysSideView = NO;
  if (subview && !CGSizeEqualToSize(CGSizeZero, subview.frame.size)) {
    switch (viewMode) {
      case UITextFieldViewModeWhileEditing:
        displaysSideView = isEditing;
        break;
      case UITextFieldViewModeUnlessEditing:
        displaysSideView = !isEditing;
        break;
      case UITextFieldViewModeAlways:
        displaysSideView = YES;
        break;
      case UITextFieldViewModeNever:
        displaysSideView = NO;
        break;
      default:
        break;
    }
  }
  return displaysSideView;
}

- (BOOL)shouldDisplayClearButton:(UIButton *)clearButton
                        viewMode:(UITextFieldViewMode)viewMode
                       isEditing:(BOOL)isEditing
                            text:(NSString *)text {
  BOOL hasText = text.length > 0;
  BOOL shouldDisplayClearButton = NO;
  switch (viewMode) {
    case UITextFieldViewModeWhileEditing:
      shouldDisplayClearButton = isEditing && hasText;
      break;
    case UITextFieldViewModeUnlessEditing:
      shouldDisplayClearButton = !isEditing;
      break;
    case UITextFieldViewModeAlways:
      shouldDisplayClearButton = YES;
      break;
    case UITextFieldViewModeNever:
      shouldDisplayClearButton = NO;
      break;
    default:
      break;
  }
  return shouldDisplayClearButton;
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

@end
