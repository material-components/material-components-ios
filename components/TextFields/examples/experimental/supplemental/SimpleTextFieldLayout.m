// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "SimpleTextFieldLayout.h"

#import "SimpleTextField.h"
#import "SimpleTextFieldLayoutUtils.h"

@interface SimpleTextFieldLayout ()
@end

@implementation SimpleTextFieldLayout

#pragma mark Object Lifecycle

- (instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                       textFieldStyle:(TextFieldStyle)textFieldStyle
                                 text:(NSString *)text
                          placeholder:(NSString *)placeholder
                                 font:(UIFont *)font
              floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                  canPlaceholderFloat:(BOOL)canPlaceholderFloat
                             leftView:(UIView *)leftView
                         leftViewMode:(UITextFieldViewMode)leftViewMode
                            rightView:(UIView *)rightView
                        rightViewMode:(UITextFieldViewMode)rightViewMode
                          clearButton:(UIButton *)clearButton
                      clearButtonMode:(UITextFieldViewMode)clearButtonMode
                   leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                  rightUnderlineLabel:(UILabel *)rightUnderlineLabel
           underlineLabelDrawPriority:(UnderlineLabelDrawPriority)underlineLabelDrawPriority
     customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithTextFieldSize:textFieldSize
                            textFieldStyle:textFieldStyle
                                      text:text
                               placeholder:placeholder
                                      font:font
                   floatingPlaceholderFont:floatingPlaceholderFont
                       canPlaceholderFloat:canPlaceholderFloat
                                  leftView:leftView
                              leftViewMode:leftViewMode
                                 rightView:rightView
                             rightViewMode:rightViewMode
                               clearButton:clearButton
                           clearButtonMode:clearButtonMode
                        leftUnderlineLabel:leftUnderlineLabel
                       rightUnderlineLabel:rightUnderlineLabel
                underlineLabelDrawPriority:underlineLabelDrawPriority
          customUnderlineLabelDrawPriority:customUnderlineLabelDrawPriority
                                     isRTL:isRTL
                                 isEditing:isEditing];
    return self;
  }
  return nil;
}

#pragma mark Layout Calculation

- (void)calculateLayoutWithTextFieldSize:(CGSize)textFieldSize
                          textFieldStyle:(TextFieldStyle)textFieldStyle
                                    text:(NSString *)text
                             placeholder:(NSString *)placeholder
                                    font:(UIFont *)font
                 floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                     canPlaceholderFloat:(BOOL)canPlaceholderFloat
                                leftView:(UIView *)leftView
                            leftViewMode:(UITextFieldViewMode)leftViewMode
                               rightView:(UIView *)rightView
                           rightViewMode:(UITextFieldViewMode)rightViewMode
                             clearButton:(UIButton *)clearButton
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode
                      leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                     rightUnderlineLabel:(UILabel *)rightUnderlineLabel
              underlineLabelDrawPriority:(UnderlineLabelDrawPriority)underlineLabelDrawPriority
        customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
                                   isRTL:(BOOL)isRTL
                               isEditing:(BOOL)isEditing {
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
    leftViewMinX = [self minXForLeftView:leftView isRTL:isRTL];
    leftViewMaxX = leftViewMinX + leftViewWidth;
  }

  CGFloat textFieldWidth = textFieldSize.width;
  CGFloat rightViewMinX = 0;
  if (shouldAttemptToDisplayRightView) {
    rightViewMinX = [self minXForRightView:rightView textFieldWidth:textFieldWidth isRTL:isRTL];
  }

  CGFloat clearButtonMinX = 0;
  CGFloat rightViewWidth = CGRectGetWidth(rightView.frame);
  CGFloat clearButtonImageViewSideMargin =
      (kClearButtonTouchTargetSideLength - kClearButtonImageViewSideLength) * 0.5;
  if (shouldAttemptToDisplayClearButton) {
    // RTL
    CGFloat uncorrectedVisualLeftMargin = isRTL ? kTrailingMargin : kLeadingMargin;
    CGFloat correctedVisualLeftMargin =
        uncorrectedVisualLeftMargin - clearButtonImageViewSideMargin;
    CGFloat lowestPossibleMinX = 0;
    if (shouldAttemptToDisplayLeftView) {
      lowestPossibleMinX = leftViewMaxX + correctedVisualLeftMargin;
    } else {
      lowestPossibleMinX = correctedVisualLeftMargin;
    }

    // LTR
    CGFloat uncorrectedVisualRightMargin = isRTL ? kLeadingMargin : kTrailingMargin;
    CGFloat correctedVisualRightMargin =
        uncorrectedVisualRightMargin - clearButtonImageViewSideMargin;
    CGFloat highestPossibleMaxX = 0;
    if (shouldAttemptToDisplayRightView) {
      highestPossibleMaxX = rightViewMinX - correctedVisualRightMargin;
    } else {
      highestPossibleMaxX = textFieldWidth - correctedVisualRightMargin;
    }

    clearButtonMinX = [self clearButtonMinXWithLowestPossibleMinX:lowestPossibleMinX
                                              highestPossibleMaxX:highestPossibleMaxX
                                                 clearButtonWidth:kClearButtonTouchTargetSideLength
                                                            isRTL:isRTL];
  }
  CGFloat floatingPlaceholderHeight =
      canPlaceholderFloat ? [self textHeightWithFont:floatingPlaceholderFont] : 0;
  CGFloat floatingPlaceholderMinY =
      [self floatingPlaceholderMinYWithFloatingHeight:floatingPlaceholderHeight
                                       textFieldStyle:textFieldStyle];

  CGFloat textAreaHeight = [self textHeightWithFont:font];
  CGFloat lowestAllowableTextAreaCenterY =
      [self lowestAllowableTextAreaCenterYWithFloatingPlaceholderMinY:floatingPlaceholderMinY
                                            floatingPlaceholderHeight:floatingPlaceholderHeight
                                                       textAreaHeight:textAreaHeight
                                                       textFieldStyle:textFieldStyle
                                                  placeholderCanFloat:canPlaceholderFloat];

  CGFloat topRowSubviewCenterY =
      [self topRowSubviewCenterYWithLeftView:leftView
                                   rightView:rightView
                                        font:font
                                floatingFont:floatingPlaceholderFont
                              textFieldStyle:textFieldStyle
              lowestAllowableTextAreaCenterY:lowestAllowableTextAreaCenterY];

  CGFloat leftViewHeight = CGRectGetHeight(leftView.frame);
  CGFloat leftViewMinY = 0;
  CGFloat leftViewMaxY = 0;
  if (shouldAttemptToDisplayLeftView) {
    leftViewMinY = [self minYForSubviewWithHeight:leftViewHeight centerY:topRowSubviewCenterY];
    leftViewMaxY = leftViewMinY + leftViewHeight;
  }

  CGFloat rightViewHeight = CGRectGetHeight(rightView.frame);
  CGFloat rightViewMinY = 0;
  CGFloat rightViewMaxY = 0;
  if (shouldAttemptToDisplayRightView) {
    rightViewMinY = [self minYForSubviewWithHeight:rightViewHeight centerY:topRowSubviewCenterY];
    rightViewMaxY = rightViewMinY + rightViewHeight;
  }

  CGFloat clearButtonMinY = 0;
  if (shouldAttemptToDisplayClearButton) {
    clearButtonMinY = [self minYForSubviewWithHeight:kClearButtonTouchTargetSideLength
                                             centerY:topRowSubviewCenterY];
  }

  CGFloat textAreaMinX = 0;
  CGFloat textAreaMaxX = 0;
  if (isRTL) {
    if (shouldAttemptToDisplayClearButton) {
      CGFloat clearButtonMaxX =
          clearButtonMinX + kClearButtonTouchTargetSideLength + clearButtonImageViewSideMargin;
      textAreaMinX = clearButtonMaxX;
    } else if (shouldAttemptToDisplayLeftView) {
      textAreaMinX = leftViewMaxX + kTrailingMargin;
    } else {
      textAreaMinX = kTrailingMargin;
    }
    if (shouldAttemptToDisplayRightView) {
      textAreaMaxX = rightViewMinX - kLeadingMargin;
    } else {
      textAreaMaxX = textFieldWidth - kLeadingMargin;
    }
  } else {
    if (shouldAttemptToDisplayLeftView) {
      textAreaMinX = leftViewMaxX + kLeadingMargin;
    } else {
      textAreaMinX = kLeadingMargin;
    }
    if (shouldAttemptToDisplayClearButton) {
      textAreaMaxX = clearButtonMinX - clearButtonImageViewSideMargin;
    } else if (shouldAttemptToDisplayRightView) {
      textAreaMaxX = rightViewMinX - kTrailingMargin;
    } else {
      textAreaMaxX = textFieldWidth - kTrailingMargin;
    }
  }

  CGFloat textAreaWidth = textAreaMaxX - textAreaMinX;
  CGFloat textAreaMinY = round((double)(topRowSubviewCenterY - (textAreaHeight * 0.5)));
  CGFloat textAreaMaxY = textAreaMinY + textAreaHeight;
  CGRect textAreaFrame = CGRectMake(textAreaMinX, textAreaMinY, textAreaWidth, textAreaHeight);
  CGRect leftViewFrame = CGRectMake(leftViewMinX, leftViewMinY, leftViewWidth, leftViewHeight);
  CGRect rightViewFrame = CGRectMake(rightViewMinX, rightViewMinY, rightViewWidth, rightViewHeight);
  CGRect clearButtonFrame =
      CGRectMake(clearButtonMinX, clearButtonMinY, kClearButtonTouchTargetSideLength,
                 kClearButtonTouchTargetSideLength);

  CGRect placeholderFrameNormal = [self placeholderFrameWithPlaceholder:placeholder
                                                         textFieldStyle:textFieldStyle
                                                       placeholderState:PlaceholderStateNormal
                                                                   font:font
                                                floatingPlaceholderFont:floatingPlaceholderFont
                                                floatingPlaceholderMinY:floatingPlaceholderMinY
                                                           textAreaRect:textAreaFrame
                                                                  isRTL:isRTL];
  CGRect placeholderFrameFloating = [self placeholderFrameWithPlaceholder:placeholder
                                                           textFieldStyle:textFieldStyle
                                                         placeholderState:PlaceholderStateFloating
                                                                     font:font
                                                  floatingPlaceholderFont:floatingPlaceholderFont
                                                  floatingPlaceholderMinY:floatingPlaceholderMinY
                                                             textAreaRect:textAreaFrame
                                                                    isRTL:isRTL];

  CGFloat underlineLabelsCombinedMinX = isRTL ? kTrailingMargin : kLeadingMargin;
  CGFloat underlineLabelsCombinedMaxX =
      isRTL ? textFieldWidth - kLeadingMargin : textFieldWidth - kTrailingMargin;
  CGFloat underlineLabelsCombinedMaxWidth =
      underlineLabelsCombinedMaxX - underlineLabelsCombinedMinX;

  CGFloat topRowSubviewMaxY = [self topRowSubviewMaxYWithTextAreaMaxY:textAreaMaxY
                                                         leftViewMaxY:leftViewMaxY
                                                        rightViewMaxY:rightViewMaxY];

  CGFloat topRowBottomRowDividerY = 0;
  switch (textFieldStyle) {
    case TextFieldStyleNone:
      topRowBottomRowDividerY = topRowSubviewMaxY;
      break;
    case TextFieldStyleFilled:
    default:
      topRowBottomRowDividerY = topRowSubviewMaxY + kTopRowBottomRowDividerVerticalPadding;
      break;
    case TextFieldStyleOutline:
      topRowBottomRowDividerY = topRowSubviewCenterY * 2;
      break;
  }

  CGFloat underlineLabelsCombinedMinY =
      topRowBottomRowDividerY + kTopRowBottomRowDividerVerticalPadding;
  CGFloat leadingUnderlineLabelWidth = 0;
  CGFloat trailingUnderlineLabelWidth = 0;
  CGSize leadingUnderlineLabelSize = CGSizeZero;
  CGSize trailingUnderlineLabelSize = CGSizeZero;
  UILabel *leadingUnderlineLabel = isRTL ? rightUnderlineLabel : leftUnderlineLabel;
  UILabel *trailingUnderlineLabel = isRTL ? leftUnderlineLabel : rightUnderlineLabel;
  switch (underlineLabelDrawPriority) {
    case UnderlineLabelDrawPriorityCustom:
      leadingUnderlineLabelWidth = [self
          leadingUnderlineLabelWidthWithCombinedUnderlineLabelsWidth:underlineLabelsCombinedMaxWidth
                                                  customDrawPriority:
                                                      customUnderlineLabelDrawPriority];
      trailingUnderlineLabelWidth = underlineLabelsCombinedMaxWidth - leadingUnderlineLabelWidth;
      leadingUnderlineLabelSize = [self underlineLabelSizeWithLabel:leadingUnderlineLabel
                                                 constrainedToWidth:leadingUnderlineLabelWidth];
      trailingUnderlineLabelSize = [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                                                  constrainedToWidth:trailingUnderlineLabelWidth];
      break;
    case UnderlineLabelDrawPriorityLeading:
      leadingUnderlineLabelSize =
          [self underlineLabelSizeWithLabel:leadingUnderlineLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth];
      trailingUnderlineLabelSize =
          [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth -
                                            leadingUnderlineLabelSize.width];
      break;
    case UnderlineLabelDrawPriorityTrailing:
      trailingUnderlineLabelSize =
          [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth];
      leadingUnderlineLabelSize =
          [self underlineLabelSizeWithLabel:leadingUnderlineLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth -
                                            trailingUnderlineLabelSize.width];
      break;
    default:
      break;
  }

  CGSize leftUnderlineLabelSize = isRTL ? trailingUnderlineLabelSize : leadingUnderlineLabelSize;
  CGSize rightUnderlineLabelSize = isRTL ? leadingUnderlineLabelSize : trailingUnderlineLabelSize;
  CGRect leftUnderlineLabelFrame = CGRectZero;
  CGRect rightUnderlineLabelFrame = CGRectZero;
  if (!CGSizeEqualToSize(leftUnderlineLabelSize, CGSizeZero)) {
    leftUnderlineLabelFrame =
        CGRectMake(underlineLabelsCombinedMinX, underlineLabelsCombinedMinY,
                   leftUnderlineLabelSize.width, leftUnderlineLabelSize.height);
  }
  if (!CGSizeEqualToSize(rightUnderlineLabelSize, CGSizeZero)) {
    rightUnderlineLabelFrame = CGRectMake(
        underlineLabelsCombinedMaxX - rightUnderlineLabelSize.width, underlineLabelsCombinedMinY,
        rightUnderlineLabelSize.width, rightUnderlineLabelSize.height);
  }

  self.leftViewFrame = leftViewFrame;
  self.rightViewFrame = rightViewFrame;
  self.clearButtonFrame = clearButtonFrame;
  self.textAreaFrame = textAreaFrame;
  self.placeholderFrameFloating = placeholderFrameFloating;
  self.placeholderFrameNormal = placeholderFrameNormal;
  self.leftUnderlineLabelFrame = leftUnderlineLabelFrame;
  self.rightUnderlineLabelFrame = rightUnderlineLabelFrame;
  self.topRowBottomRowDividerY = topRowBottomRowDividerY;
  self.clearButtonHidden = !shouldAttemptToDisplayClearButton;
  self.leftViewHidden = !shouldAttemptToDisplayLeftView;
  self.rightViewHidden = !shouldAttemptToDisplayRightView;
  self.topRowBottomRowDividerY = topRowBottomRowDividerY;
}

- (CGFloat)topRowSubviewMaxYWithTextAreaMaxY:(CGFloat)textAreaMaxY
                                leftViewMaxY:(CGFloat)leftViewMaxY
                               rightViewMaxY:(CGFloat)rightViewMaxY {
  CGFloat max = textAreaMaxY;
  max = MAX(max, leftViewMaxY);
  max = MAX(max, rightViewMaxY);
  return max;
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

- (CGFloat)leadingUnderlineLabelWidthWithCombinedUnderlineLabelsWidth:
               (CGFloat)totalUnderlineLabelsWidth
                                                   customDrawPriority:(CGFloat)customDrawPriority {
  return customDrawPriority * totalUnderlineLabelsWidth;
}

- (CGFloat)minXForLeftUnderlineLabel:(UILabel *)label isRTL:(BOOL)isRTL {
  return isRTL ? kTrailingMargin : kLeadingMargin;
}

- (CGFloat)maxXForRightUnderlineLabel:(UILabel *)label isRTL:(BOOL)isRTL {
  return isRTL ? kTrailingMargin : kLeadingMargin;
}

- (CGFloat)minXForLeftView:(UIView *)leftView isRTL:(BOOL)isRTL {
  return isRTL ? kTrailingMargin : kLeadingMargin;
}

- (CGFloat)minXForRightView:(UIView *)rightView
             textFieldWidth:(CGFloat)textFieldWidth
                      isRTL:(BOOL)isRTL {
  CGFloat rightMargin = isRTL ? kLeadingMargin : kTrailingMargin;
  CGFloat maxX = textFieldWidth - rightMargin;
  return maxX - CGRectGetWidth(rightView.frame);
}

- (CGFloat)clearButtonMinXWithLowestPossibleMinX:(CGFloat)lowestPossibleMinX
                             highestPossibleMaxX:(CGFloat)highestPossibleMaxX
                                clearButtonWidth:(CGFloat)clearButtonWidth
                                           isRTL:(BOOL)isRTL {
  CGFloat minX = 0;
  if (isRTL) {
    minX = lowestPossibleMinX;
  } else {
    minX = highestPossibleMaxX - clearButtonWidth;
  }
  return minX;
}

- (CGFloat)minYForSubviewWithHeight:(CGFloat)height centerY:(CGFloat)centerY {
  return round((double)(centerY - (0.5 * height)));
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

- (CGFloat)
    lowestAllowableTextAreaCenterYWithFloatingPlaceholderMinY:(CGFloat)floatingPlaceholderMinY
                                    floatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight
                                               textAreaHeight:(CGFloat)textAreaHeight
                                               textFieldStyle:(TextFieldStyle)textFieldStyle
                                          placeholderCanFloat:(BOOL)placeholderCanFloat {
  if (placeholderCanFloat) {
    CGFloat spaceBetweenPlaceholderAndTextArea = 0;
    CGFloat floatingPlaceholderMaxY = floatingPlaceholderMinY + floatingPlaceholderHeight;
    CGFloat outlinedTextFieldSpaceHeuristic = floatingPlaceholderHeight * 0.22;
    switch (textFieldStyle) {
      case TextFieldStyleNone:
      case TextFieldStyleFilled:
      default:
        spaceBetweenPlaceholderAndTextArea = (0.25 * floatingPlaceholderMaxY);
        break;
      case TextFieldStyleOutline:
        spaceBetweenPlaceholderAndTextArea =
            floatingPlaceholderMaxY + outlinedTextFieldSpaceHeuristic;
        break;
    }
    CGFloat lowestAllowableTextAreaMinY =
        floatingPlaceholderMaxY + spaceBetweenPlaceholderAndTextArea;
    return lowestAllowableTextAreaMinY + (0.5 * textAreaHeight);
  } else {
    CGFloat lowestAllowableTextAreaMinY = kTopRowBottomRowDividerVerticalPadding;
    return lowestAllowableTextAreaMinY + (0.5 * textAreaHeight);
  }
}

- (CGFloat)floatingPlaceholderMinYWithFloatingHeight:(CGFloat)floatingPlaceholderHeight
                                      textFieldStyle:(TextFieldStyle)textFieldStyle {
  if (floatingPlaceholderHeight <= 0) {
    return 0;
  }
  CGFloat filledPlaceholderTopPaddingScaleHeuristic = ((CGFloat)50.0 / (CGFloat)70.0);
  CGFloat floatingPlaceholderMinY = 0;
  switch (textFieldStyle) {
    case TextFieldStyleOutline:
      floatingPlaceholderMinY = 0 - (0.5 * floatingPlaceholderHeight);
      break;
    case TextFieldStyleNone:
    case TextFieldStyleFilled:
    default:
      floatingPlaceholderMinY =
          filledPlaceholderTopPaddingScaleHeuristic * floatingPlaceholderHeight;
      break;
  }
  return floatingPlaceholderMinY;
}

- (CGFloat)topRowSubviewCenterYWithLeftView:(UIView *)leftView
                                  rightView:(UIView *)rightView
                                       font:(UIFont *)font
                               floatingFont:(UIFont *)floatingFont
                             textFieldStyle:(TextFieldStyle)textFieldStyle
             lowestAllowableTextAreaCenterY:(CGFloat)lowestAllowableTextAreaCenterY {
  CGFloat sideViewMaxHeight =
      MAX(CGRectGetHeight(leftView.bounds), CGRectGetHeight(rightView.bounds));
  CGFloat lowestAllowableSideViewCenterY = kTopMargin + (0.5 * sideViewMaxHeight);
  CGFloat sharedCenterY = MAX(lowestAllowableTextAreaCenterY, lowestAllowableSideViewCenterY);
  return sharedCenterY;
}

- (CGFloat)maxPlaceholderWidthWithTextAreaWidth:(CGFloat)textAreaWidth
                               placeholderState:(PlaceholderState)placeholderState {
  CGFloat maxPlaceholderWidth = 0;
  switch (placeholderState) {
    case PlaceholderStateNone:
      break;
    case PlaceholderStateFloating:
      maxPlaceholderWidth = textAreaWidth - (2 * kFloatingPlaceholderXOffsetFromTextArea);
      break;
    case PlaceholderStateNormal:
      maxPlaceholderWidth = textAreaWidth;
      break;
    default:
      break;
  }
  return maxPlaceholderWidth;
}

- (CGSize)placeholderSizeWithPlaceholder:(NSString *)placeholder
                     maxPlaceholderWidth:(CGFloat)maxPlaceholderWidth
                                    font:(UIFont *)font {
  if (!font) {
    return CGSizeZero;
  }
  CGSize fittingSize = CGSizeMake(maxPlaceholderWidth, CGFLOAT_MAX);
  NSDictionary *attributes = @{NSFontAttributeName : font};
  CGRect rect = [placeholder boundingRectWithSize:fittingSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attributes
                                          context:nil];
  return rect.size;
}

- (CGRect)placeholderFrameWithPlaceholder:(NSString *)placeholder
                           textFieldStyle:(TextFieldStyle)textFieldStyle
                         placeholderState:(PlaceholderState)placeholderState
                                     font:(UIFont *)font
                  floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                  floatingPlaceholderMinY:(CGFloat)floatingPlaceholderMinY
                             textAreaRect:(CGRect)textAreaRect
                                    isRTL:(BOOL)isRTL {
  CGFloat textAreaWidth = CGRectGetWidth(textAreaRect);
  CGFloat maxPlaceholderWidth = [self maxPlaceholderWidthWithTextAreaWidth:textAreaWidth
                                                          placeholderState:placeholderState];
  CGFloat textAreaMinX = CGRectGetMinX(textAreaRect);
  CGFloat textAreaMaxX = CGRectGetMaxX(textAreaRect);
  CGFloat textAreaMidY = CGRectGetMidY(textAreaRect);
  CGSize size = CGSizeZero;
  CGRect rect = CGRectZero;
  CGFloat originX = 0;
  CGFloat originY = 0;
  switch (placeholderState) {
    case PlaceholderStateNone:
      break;
    case PlaceholderStateFloating:
      size = [self placeholderSizeWithPlaceholder:placeholder
                              maxPlaceholderWidth:maxPlaceholderWidth
                                             font:floatingPlaceholderFont];
      originY = floatingPlaceholderMinY;
      if (isRTL) {
        originX = textAreaMaxX - kFloatingPlaceholderXOffsetFromTextArea - size.width;
      } else {
        originX = textAreaMinX + kFloatingPlaceholderXOffsetFromTextArea;
      }
      rect = CGRectMake(originX, originY, size.width, size.height);
      break;
    case PlaceholderStateNormal:
      size = [self placeholderSizeWithPlaceholder:placeholder
                              maxPlaceholderWidth:maxPlaceholderWidth
                                             font:font];
      originY = textAreaMidY - (0.5 * size.height);
      if (isRTL) {
        originX = textAreaMaxX - size.width;
      } else {
        originX = textAreaMinX;
      }
      rect = CGRectMake(originX, originY, size.width, size.height);
      break;
    default:
      break;
  }
  return rect;
}

- (CGFloat)textHeightWithFont:(UIFont *)font {
  return ceil((double)font.lineHeight);
}

- (CGFloat)calculatedHeight {
  CGFloat maxY = 0;
  CGFloat placeholderFrameFloatingMaxY = CGRectGetMaxY(self.placeholderFrameFloating);
  if (placeholderFrameFloatingMaxY > maxY) {
    maxY = placeholderFrameFloatingMaxY;
  }
  CGFloat placeholderFrameNormalMaxY = CGRectGetMaxY(self.placeholderFrameNormal);
  if (placeholderFrameFloatingMaxY > maxY) {
    maxY = placeholderFrameNormalMaxY;
  }
  CGFloat textAreaFrameMaxY = CGRectGetMaxY(self.textAreaFrame);
  if (textAreaFrameMaxY > maxY) {
    maxY = textAreaFrameMaxY;
  }
  CGFloat clearButtonFrameMaxY = CGRectGetMaxY(self.clearButtonFrame);
  if (clearButtonFrameMaxY > maxY) {
    maxY = clearButtonFrameMaxY;
  }
  CGFloat leftViewFrameMaxY = CGRectGetMaxY(self.leftViewFrame);
  if (leftViewFrameMaxY > maxY) {
    maxY = leftViewFrameMaxY;
  }
  CGFloat rightViewFrameMaxY = CGRectGetMaxY(self.rightViewFrame);
  if (rightViewFrameMaxY > maxY) {
    maxY = rightViewFrameMaxY;
  }
  CGFloat leftUnderlineLabelFrameMaxY = CGRectGetMaxY(self.leftUnderlineLabelFrame);
  if (leftUnderlineLabelFrameMaxY > maxY) {
    maxY = leftUnderlineLabelFrameMaxY;
  }
  CGFloat rightUnderlineLabelFrameMaxY = CGRectGetMaxY(self.rightUnderlineLabelFrame);
  if (rightUnderlineLabelFrameMaxY > maxY) {
    maxY = rightUnderlineLabelFrameMaxY;
  }
  if (self.topRowBottomRowDividerY > maxY) {
    maxY = self.topRowBottomRowDividerY;
  }
  return maxY;
}

@end
