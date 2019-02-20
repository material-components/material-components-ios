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

#import "MDCSimpleTextFieldLayout.h"

#import "MDCContainedInputView.h"
#import "MDCSimpleTextField.h"

static const CGFloat kLeadingMargin = (CGFloat)12.0;
static const CGFloat kTrailingMargin = (CGFloat)12.0;
static const CGFloat kTopRowBottomRowDividerVerticalPadding = (CGFloat)9.0;
static const CGFloat kFloatingPlaceholderXOffsetFromTextArea = (CGFloat)3.0;
static const CGFloat kClearButtonTouchTargetSideLength = (CGFloat)30.0;
static const CGFloat kClearButtonImageViewSideLength = (CGFloat)18.0;

@interface MDCSimpleTextFieldLayout ()
@end

@implementation MDCSimpleTextFieldLayout

#pragma mark Object Lifecycle

- (instancetype)initWithTextFieldSize:(CGSize)textFieldSize
                       containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
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
           underlineLabelDrawPriority:
               (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
     customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
       preferredMainContentAreaHeight:(CGFloat)preferredMainContentAreaHeight
    preferredUnderlineLabelAreaHeight:(CGFloat)preferredUnderlineLabelAreaHeight
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithTextFieldSize:textFieldSize
                            containerStyle:containerStyle
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
            preferredMainContentAreaHeight:preferredMainContentAreaHeight
         preferredUnderlineLabelAreaHeight:preferredUnderlineLabelAreaHeight
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
              underlineLabelDrawPriority:
                  (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
        customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
          preferredMainContentAreaHeight:(CGFloat)preferredMainContentAreaHeight
       preferredUnderlineLabelAreaHeight:(CGFloat)preferredUnderlineLabelAreaHeight
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
  CGFloat floatingPlaceholderMinY = [containerStyle.densityInformer
      floatingPlaceholderMinYWithFloatingPlaceholderHeight:floatingPlaceholderHeight];
  CGFloat floatingPlaceholderMaxY = floatingPlaceholderMinY + floatingPlaceholderHeight;
  CGFloat textRectMinYWithFloatingPlaceholder = [containerStyle.densityInformer
      contentAreaTopPaddingWithFloatingPlaceholderMaxY:floatingPlaceholderMaxY];
  CGFloat textRectHeight = [self textHeightWithFont:font];
  CGFloat textRectCenterYWithFloatingPlaceholder =
      textRectMinYWithFloatingPlaceholder + ((CGFloat)0.5 * textRectHeight);
  CGFloat textRectMaxYWithFloatingPlaceholder =
      textRectMinYWithFloatingPlaceholder + textRectHeight;
  CGFloat bottomPadding = [containerStyle.densityInformer normalContentAreaBottomPadding];
  CGFloat intrinsicContentAreaHeight = textRectMaxYWithFloatingPlaceholder + bottomPadding;
  CGFloat topRowBottomRowDividerY = intrinsicContentAreaHeight;
  if (preferredMainContentAreaHeight > intrinsicContentAreaHeight) {
    topRowBottomRowDividerY = preferredMainContentAreaHeight;
  }

  CGFloat textRectCenterYNormal = topRowBottomRowDividerY * (CGFloat)0.5;
  CGFloat textRectMinYNormal = textRectCenterYNormal - (textRectHeight * (CGFloat)0.5);

  CGFloat leftViewHeight = CGRectGetHeight(leftView.frame);
  CGFloat leftViewMinY = 0;
  CGFloat leftViewMaxY = 0;
  if (shouldAttemptToDisplayLeftView) {
    leftViewMinY = [self minYForSubviewWithHeight:leftViewHeight centerY:textRectCenterYNormal];
    leftViewMaxY = leftViewMinY + leftViewHeight;
  }

  CGFloat rightViewHeight = CGRectGetHeight(rightView.frame);
  CGFloat rightViewMinY = 0;
  CGFloat rightViewMaxY = 0;
  if (shouldAttemptToDisplayRightView) {
    rightViewMinY = [self minYForSubviewWithHeight:rightViewHeight centerY:textRectCenterYNormal];
    rightViewMaxY = rightViewMinY + rightViewHeight;
  }

  CGFloat clearButtonMinY = 0;
  CGFloat clearButtonFloatingPlaceholderMinY = 0;
  if (shouldAttemptToDisplayClearButton) {
    clearButtonMinY = [self minYForSubviewWithHeight:kClearButtonTouchTargetSideLength
                                             centerY:textRectCenterYNormal];
    clearButtonFloatingPlaceholderMinY =
        [self minYForSubviewWithHeight:kClearButtonTouchTargetSideLength
                               centerY:textRectCenterYWithFloatingPlaceholder];
  }

  CGFloat textRectMinX = 0;
  CGFloat textRectMaxX = 0;
  if (isRTL) {
    if (shouldAttemptToDisplayClearButton) {
      CGFloat clearButtonMaxX =
          clearButtonMinX + kClearButtonTouchTargetSideLength + clearButtonImageViewSideMargin;
      textRectMinX = clearButtonMaxX;
    } else if (shouldAttemptToDisplayLeftView) {
      textRectMinX = leftViewMaxX + kTrailingMargin;
    } else {
      textRectMinX = kTrailingMargin;
    }
    if (shouldAttemptToDisplayRightView) {
      textRectMaxX = rightViewMinX - kLeadingMargin;
    } else {
      textRectMaxX = textFieldWidth - kLeadingMargin;
    }
  } else {
    if (shouldAttemptToDisplayLeftView) {
      textRectMinX = leftViewMaxX + kLeadingMargin;
    } else {
      textRectMinX = kLeadingMargin;
    }
    if (shouldAttemptToDisplayClearButton) {
      textRectMaxX = clearButtonMinX - clearButtonImageViewSideMargin;
    } else if (shouldAttemptToDisplayRightView) {
      textRectMaxX = rightViewMinX - kTrailingMargin;
    } else {
      textRectMaxX = textFieldWidth - kTrailingMargin;
    }
  }

  CGFloat textRectWidth = textRectMaxX - textRectMinX;
  CGRect textRectNormal =
      CGRectMake(textRectMinX, textRectMinYNormal, textRectWidth, textRectHeight);
  CGFloat textRectMinYFloatingPlaceholder = (CGFloat)round(
      (double)(textRectCenterYWithFloatingPlaceholder - (textRectHeight * (CGFloat)0.5)));
  CGRect floatingPlaceholderTextAreaRect =
      CGRectMake(textRectMinX, textRectMinYFloatingPlaceholder, textRectWidth, textRectHeight);

  CGRect leftViewFrame = CGRectMake(leftViewMinX, leftViewMinY, leftViewWidth, leftViewHeight);
  CGRect rightViewFrame = CGRectMake(rightViewMinX, rightViewMinY, rightViewWidth, rightViewHeight);
  CGRect clearButtonFrame =
      CGRectMake(clearButtonMinX, clearButtonMinY, kClearButtonTouchTargetSideLength,
                 kClearButtonTouchTargetSideLength);
  CGRect clearButtonFrameFloatingPlaceholder =
      CGRectMake(clearButtonMinX, clearButtonFloatingPlaceholderMinY,
                 kClearButtonTouchTargetSideLength, kClearButtonTouchTargetSideLength);

  CGRect placeholderFrameNormal =
      [self placeholderFrameWithPlaceholder:placeholder
                             containerStyle:containerStyle
                           placeholderState:MDCContainedInputViewPlaceholderStateNormal
                                       font:font
                    floatingPlaceholderFont:floatingPlaceholderFont
                    floatingPlaceholderMinY:floatingPlaceholderMinY
                               textRectRect:textRectNormal
                                      isRTL:isRTL];
  CGRect placeholderFrameFloating =
      [self placeholderFrameWithPlaceholder:placeholder
                             containerStyle:containerStyle
                           placeholderState:MDCContainedInputViewPlaceholderStateFloating
                                       font:font
                    floatingPlaceholderFont:floatingPlaceholderFont
                    floatingPlaceholderMinY:floatingPlaceholderMinY
                               textRectRect:textRectNormal
                                      isRTL:isRTL];

  CGFloat underlineLabelsCombinedMinX = isRTL ? kTrailingMargin : kLeadingMargin;
  CGFloat underlineLabelsCombinedMaxX =
      isRTL ? textFieldWidth - kLeadingMargin : textFieldWidth - kTrailingMargin;
  CGFloat underlineLabelsCombinedMaxWidth =
      underlineLabelsCombinedMaxX - underlineLabelsCombinedMinX;

  CGFloat underlineLabelsCombinedMinY =
      topRowBottomRowDividerY + kTopRowBottomRowDividerVerticalPadding;
  CGFloat leadingUnderlineLabelWidth = 0;
  CGFloat trailingUnderlineLabelWidth = 0;
  CGSize leadingUnderlineLabelSize = CGSizeZero;
  CGSize trailingUnderlineLabelSize = CGSizeZero;
  UILabel *leadingUnderlineLabel = isRTL ? rightUnderlineLabel : leftUnderlineLabel;
  UILabel *trailingUnderlineLabel = isRTL ? leftUnderlineLabel : rightUnderlineLabel;
  switch (underlineLabelDrawPriority) {
    case MDCContainedInputViewUnderlineLabelDrawPriorityCustom:
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
    case MDCContainedInputViewUnderlineLabelDrawPriorityLeading:
      leadingUnderlineLabelSize =
          [self underlineLabelSizeWithLabel:leadingUnderlineLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth];
      trailingUnderlineLabelSize =
          [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth -
                                            leadingUnderlineLabelSize.width];
      break;
    case MDCContainedInputViewUnderlineLabelDrawPriorityTrailing:
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
  self.clearButtonFrameFloatingPlaceholder = clearButtonFrameFloatingPlaceholder;
  self.textRect = textRectNormal;
  self.textRectFloatingPlaceholder = floatingPlaceholderTextAreaRect;
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

- (CGFloat)topRowSubviewMaxYWithTextAreaMaxY:(CGFloat)textRectMaxY
             floatingPlaceholderTextAreaMaxY:(CGFloat)floatingPlaceholderTextAreaMaxY
                                leftViewMaxY:(CGFloat)leftViewMaxY
                               rightViewMaxY:(CGFloat)rightViewMaxY {
  CGFloat max = textRectMaxY;
  max = MAX(max, floatingPlaceholderTextAreaMaxY);
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

- (CGFloat)maxPlaceholderWidthWithTextAreaWidth:(CGFloat)textRectWidth
                               placeholderState:
                                   (MDCContainedInputViewPlaceholderState)placeholderState {
  CGFloat maxPlaceholderWidth = 0;
  switch (placeholderState) {
    case MDCContainedInputViewPlaceholderStateNone:
      break;
    case MDCContainedInputViewPlaceholderStateFloating:
      maxPlaceholderWidth = textRectWidth - (2 * kFloatingPlaceholderXOffsetFromTextArea);
      break;
    case MDCContainedInputViewPlaceholderStateNormal:
      maxPlaceholderWidth = textRectWidth;
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
                           containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                         placeholderState:(MDCContainedInputViewPlaceholderState)placeholderState
                                     font:(UIFont *)font
                  floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                  floatingPlaceholderMinY:(CGFloat)floatingPlaceholderMinY
                             textRectRect:(CGRect)textRectRect
                                    isRTL:(BOOL)isRTL {
  CGFloat textRectWidth = CGRectGetWidth(textRectRect);
  CGFloat maxPlaceholderWidth = [self maxPlaceholderWidthWithTextAreaWidth:textRectWidth
                                                          placeholderState:placeholderState];
  CGFloat textRectMinX = CGRectGetMinX(textRectRect);
  CGFloat textRectMaxX = CGRectGetMaxX(textRectRect);
  CGFloat textRectMidY = CGRectGetMidY(textRectRect);
  CGSize size = CGSizeZero;
  CGRect rect = CGRectZero;
  CGFloat originX = 0;
  CGFloat originY = 0;
  switch (placeholderState) {
    case MDCContainedInputViewPlaceholderStateNone:
      break;
    case MDCContainedInputViewPlaceholderStateFloating:
      size = [self placeholderSizeWithPlaceholder:placeholder
                              maxPlaceholderWidth:maxPlaceholderWidth
                                             font:floatingPlaceholderFont];
      originY = floatingPlaceholderMinY;
      if (isRTL) {
        originX = textRectMaxX - kFloatingPlaceholderXOffsetFromTextArea - size.width;
      } else {
        originX = textRectMinX + kFloatingPlaceholderXOffsetFromTextArea;
      }
      rect = CGRectMake(originX, originY, size.width, size.height);
      break;
    case MDCContainedInputViewPlaceholderStateNormal:
      size = [self placeholderSizeWithPlaceholder:placeholder
                              maxPlaceholderWidth:maxPlaceholderWidth
                                             font:font];
      originY = textRectMidY - ((CGFloat)0.5 * size.height);
      if (isRTL) {
        originX = textRectMaxX - size.width;
      } else {
        originX = textRectMinX;
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
  CGFloat placeholderFrameFloatingMaxY = CGRectGetMaxY(self.placeholderFrameFloating);
  if (placeholderFrameFloatingMaxY > maxY) {
    maxY = placeholderFrameFloatingMaxY;
  }
  CGFloat placeholderFrameNormalMaxY = CGRectGetMaxY(self.placeholderFrameNormal);
  if (placeholderFrameFloatingMaxY > maxY) {
    maxY = placeholderFrameNormalMaxY;
  }
  CGFloat textRectMaxY = CGRectGetMaxY(self.textRect);
  if (textRectMaxY > maxY) {
    maxY = textRectMaxY;
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

+ (CGFloat)clearButtonImageViewSideLength {
  return kClearButtonImageViewSideLength;
}

+ (CGFloat)clearButtonSideLength {
  return kClearButtonTouchTargetSideLength;
}

@end
