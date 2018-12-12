//
//  SimpleTextFieldLayout.m
//  ComponentsProject
//
//  Created by Andrew Overton on 12/6/18.
//  Copyright © 2018 andrewoverton. All rights reserved.
//

#import "SimpleTextFieldLayout.h"

#import "SimpleTextField.h"
#import "SimpleTextFieldLayoutUtils.h"


@interface SimpleTextFieldLayout ()
@end

@implementation SimpleTextFieldLayout

#pragma mark Object Lifecycle

- (instancetype)initWithTextFieldBounds:(CGRect)textFieldBounds
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
    [self calculateLayoutWithTextFieldBounds:textFieldBounds
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

- (void)calculateLayoutWithTextFieldBounds:(CGRect)textFieldBounds
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
    leftViewMinX = [self minXForLeftView:leftView
                                   isRTL:isRTL];
    leftViewMaxX = leftViewMinX + leftViewWidth;
  }

  CGFloat textFieldWidth = CGRectGetWidth(textFieldBounds);
  CGFloat rightViewMinX = 0;
  if (shouldAttemptToDisplayRightView) {
    rightViewMinX = [self minXForRightView:rightView
                            textFieldWidth:textFieldWidth
                                     isRTL:isRTL];
  }

  CGFloat clearButtonMinX = 0;
  if (shouldAttemptToDisplayClearButton) {
    CGFloat leftMargin = isRTL ? kLeadingMargin : kTrailingMargin;
    CGFloat rightMargin = isRTL ? kTrailingMargin : kLeadingMargin;
    CGFloat lowestPossibleMinX = shouldAttemptToDisplayLeftView ? leftViewMaxX : leftMargin;
    CGFloat highestPossibleMaxX = shouldAttemptToDisplayRightView ? rightViewMinX : textFieldWidth - rightMargin;
    clearButtonMinX = [self clearButtonMinXWithLowestPossibleMinX:lowestPossibleMinX
                                              highestPossibleMaxX:highestPossibleMaxX
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
    leftViewMinY = [self minYForSubviewWithHeight:leftViewHeight
                                          centerY:topRowSubviewCenterY];
    leftViewMaxY = leftViewMinY + leftViewHeight;
  }

  CGFloat rightViewHeight = CGRectGetHeight(rightView.frame);
  CGFloat rightViewMinY = 0;
  CGFloat rightViewMaxY = 0;
  if (shouldAttemptToDisplayRightView) {
    rightViewMinY = [self minYForSubviewWithHeight:rightViewHeight
                                           centerY:topRowSubviewCenterY];
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
    textAreaMinX = kTrailingMargin;
    if (shouldAttemptToDisplayClearButton) {
      CGFloat clearButtonMaxX = clearButtonMinX + kClearButtonTouchTargetSideLength;
      textAreaMinX = clearButtonMaxX;
    } else if (shouldAttemptToDisplayLeftView) {
      textAreaMinX = leftViewMaxX + kTextRectSidePadding;
    }

    textAreaMaxX = textFieldWidth - kLeadingMargin;
    if (shouldAttemptToDisplayRightView) {
      textAreaMaxX = rightViewMinX - kTextRectSidePadding;
    }
  } else {
    textAreaMinX = kLeadingMargin;
    if (shouldAttemptToDisplayLeftView) {
      textAreaMinX = leftViewMaxX + kTextRectSidePadding;
    }
    textAreaMaxX = textFieldWidth - kTrailingMargin;
    if (shouldAttemptToDisplayClearButton) {
      textAreaMaxX = clearButtonMinX - kTextRectSidePadding;
    } else if (shouldAttemptToDisplayRightView) {
      textAreaMaxX = rightViewMinX - kTextRectSidePadding;
    }
  }

  CGFloat textAreaWidth = textAreaMaxX - textAreaMinX;
  CGFloat textAreaMinY = round((double)(topRowSubviewCenterY - (textAreaHeight * 0.5)));
  CGFloat textAreaMaxY = textAreaMinY + textAreaHeight;
  CGRect textAreaFrame = CGRectMake(textAreaMinX, textAreaMinY, textAreaWidth, textAreaHeight);
  CGRect leftViewFrame = CGRectMake(leftViewMinX, leftViewMinY, leftViewWidth, leftViewHeight);
  CGFloat rightViewWidth = CGRectGetWidth(rightView.frame);
  CGRect rightViewFrame = CGRectMake(rightViewMinX, rightViewMinY, rightViewWidth, rightViewHeight);
  CGRect clearButtonFrame = CGRectMake(clearButtonMinX, clearButtonMinY, kClearButtonTouchTargetSideLength, kClearButtonTouchTargetSideLength);

  CGRect placeholderFrameNormal = [self placeholderFrameWithPlaceholder:placeholder
                                                         textFieldStyle:textFieldStyle
                                                       placeholderState:PlaceholderStateNormal
                                                                   font:font
                                                floatingPlaceholderFont:floatingPlaceholderFont
                                                floatingPlaceholderMinY:floatingPlaceholderMinY
                                                           textAreaRect:textAreaFrame];
  CGRect placeholderFrameFloating = [self placeholderFrameWithPlaceholder:placeholder
                                                           textFieldStyle:textFieldStyle
                                                         placeholderState:PlaceholderStateFloating
                                                                     font:font
                                                  floatingPlaceholderFont:floatingPlaceholderFont
                                                  floatingPlaceholderMinY:floatingPlaceholderMinY
                                                             textAreaRect:textAreaFrame];

  CGFloat underlineLabelsCombinedMinX = isRTL ? kTrailingMargin : kLeadingMargin;
  CGFloat underlineLabelsCombinedMaxX = isRTL ? textFieldWidth - kLeadingMargin : textFieldWidth - kTrailingMargin;
  CGFloat underlineLabelsCombinedMaxWidth = underlineLabelsCombinedMaxX - underlineLabelsCombinedMinX;

  CGFloat topRowSubviewMaxY = [self topRowSubviewMaxYWithTextAreaMaxY:textAreaMaxY
                                                         leftViewMaxY:leftViewMaxY
                                                        rightViewMaxY:rightViewMaxY];

  CGFloat topRowBottomRowDividerY = topRowSubviewCenterY;
  if (textFieldStyle == TextFieldStyleOutline) {
    topRowBottomRowDividerY = topRowSubviewCenterY * 2;
  } else if (textFieldStyle == TextFieldStyleFilled) {
    topRowBottomRowDividerY = topRowSubviewMaxY + kTopRowSubviewVerticalPadding;
  }

  CGFloat underlineLabelsCombinedMinY = topRowBottomRowDividerY + kUnderlineLabelsTopPadding;
  CGFloat leadingUnderlineLabelWidth = 0;
  CGFloat trailingUnderlineLabelWidth = 0;
  CGSize leadingUnderlineLabelSize = CGSizeZero;
  CGSize trailingUnderlineLabelSize = CGSizeZero;
  UILabel *leadingUnderlineLabel = isRTL ? rightUnderlineLabel : leftUnderlineLabel;
  UILabel *trailingUnderlineLabel = isRTL ? leftUnderlineLabel : rightUnderlineLabel;
  switch (underlineLabelDrawPriority) {
    case UnderlineLabelDrawPriorityCustom:
      leadingUnderlineLabelWidth = [self leadingUnderlineLabelWidthWithCombinedUnderlineLabelsWidth:underlineLabelsCombinedMaxWidth
                                                                                 customDrawPriority:customUnderlineLabelDrawPriority];
      trailingUnderlineLabelWidth = underlineLabelsCombinedMaxWidth - leadingUnderlineLabelWidth;
      leadingUnderlineLabelSize = [self underlineLabelSizeWithLabel:leadingUnderlineLabel
                                                 constrainedToWidth:leadingUnderlineLabelWidth];
      trailingUnderlineLabelSize = [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                                                  constrainedToWidth:trailingUnderlineLabelWidth];
      break;
    case UnderlineLabelDrawPriorityLeading:
      leadingUnderlineLabelSize = [self underlineLabelSizeWithLabel:leadingUnderlineLabel
                                                 constrainedToWidth:underlineLabelsCombinedMaxWidth];
      trailingUnderlineLabelSize = [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                                                  constrainedToWidth:underlineLabelsCombinedMaxWidth - leadingUnderlineLabelSize.width];
      break;
    case UnderlineLabelDrawPriorityTrailing:
      trailingUnderlineLabelSize = [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                                                  constrainedToWidth:underlineLabelsCombinedMaxWidth];
      leadingUnderlineLabelSize = [self underlineLabelSizeWithLabel:leadingUnderlineLabel
                                                 constrainedToWidth:underlineLabelsCombinedMaxWidth - trailingUnderlineLabelSize.width];
      break;
    default:
      break;
  }

  CGSize leftUnderlineLabelSize = isRTL ? trailingUnderlineLabelSize : leadingUnderlineLabelSize;
  CGSize rightUnderlineLabelSize = isRTL ? leadingUnderlineLabelSize : trailingUnderlineLabelSize;
  CGRect leftUnderlineLabelFrame = CGRectZero;
  CGRect rightUnderlineLabelFrame = CGRectZero;
  if (!CGSizeEqualToSize(leftUnderlineLabelSize, CGSizeZero)) {
    leftUnderlineLabelFrame = CGRectMake(underlineLabelsCombinedMinX,
                                         underlineLabelsCombinedMinY,
                                         leftUnderlineLabelSize.width,
                                         leftUnderlineLabelSize.height);
  }
  if (!CGSizeEqualToSize(rightUnderlineLabelSize, CGSizeZero)) {
    rightUnderlineLabelFrame = CGRectMake(underlineLabelsCombinedMaxX - rightUnderlineLabelSize.width,
                                          underlineLabelsCombinedMinY,
                                          rightUnderlineLabelSize.width,
                                          rightUnderlineLabelSize.height);
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

- (CGSize)underlineLabelSizeWithLabel:(UILabel *)label
                   constrainedToWidth:(CGFloat)maxWidth {
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

- (CGFloat)leadingUnderlineLabelWidthWithCombinedUnderlineLabelsWidth:(CGFloat)totalUnderlineLabelsWidth
                                                   customDrawPriority:(CGFloat)customDrawPriority {
  return customDrawPriority * totalUnderlineLabelsWidth;
}


- (CGFloat)minXForLeftUnderlineLabel:(UILabel *)label
                               isRTL:(BOOL)isRTL {
  return isRTL ? kTrailingMargin : kLeadingMargin;
}

- (CGFloat)maxXForRightUnderlineLabel:(UILabel *)label
                                isRTL:(BOOL)isRTL {
  return isRTL ? kTrailingMargin : kLeadingMargin;
}


- (CGFloat)minXForLeftView:(UIView *)leftView
                     isRTL:(BOOL)isRTL {
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
                                           isRTL:(BOOL)isRTL {
  CGFloat minX = 0;
  if (isRTL) {
    minX = lowestPossibleMinX;
  } else {
    minX = highestPossibleMaxX - kClearButtonTouchTargetSideLength;
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

- (CGFloat)lowestAllowableTextAreaCenterYWithFloatingPlaceholderMinY:(CGFloat)floatingPlaceholderMinY
                                           floatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight
                                                      textAreaHeight:(CGFloat)textAreaHeight
                                                      textFieldStyle:(TextFieldStyle)textFieldStyle
                                                 placeholderCanFloat:(BOOL)placeholderCanFloat {
  if (placeholderCanFloat) {
    CGFloat spaceBetweenPlaceholderAndTextArea = 0;
    CGFloat floatingPlaceholderMaxY = floatingPlaceholderMinY + floatingPlaceholderHeight;
    CGFloat outlinedTextFieldSpaceHeuristic = floatingPlaceholderHeight * 0.22;
    if (textFieldStyle == TextFieldStyleFilled) {
      spaceBetweenPlaceholderAndTextArea = (0.25 * floatingPlaceholderMaxY);
    } else if (textFieldStyle == TextFieldStyleOutline) {
      spaceBetweenPlaceholderAndTextArea = floatingPlaceholderMaxY + outlinedTextFieldSpaceHeuristic;
    }
    CGFloat lowestAllowableTextAreaMinY = floatingPlaceholderMaxY + spaceBetweenPlaceholderAndTextArea;
    return lowestAllowableTextAreaMinY + (0.5 * textAreaHeight);
  } else {
    CGFloat lowestAllowableTextAreaMinY = kTopRowSubviewVerticalPadding;
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
    case TextFieldStyleFilled:
      floatingPlaceholderMinY = filledPlaceholderTopPaddingScaleHeuristic * floatingPlaceholderHeight;
      break;
    case TextFieldStyleOutline:
      floatingPlaceholderMinY = 0 - (0.5 * floatingPlaceholderHeight);
      break;
    default:
      floatingPlaceholderMinY = kTopMargin;
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
  CGFloat sideViewMaxHeight = MAX(CGRectGetHeight(leftView.bounds), CGRectGetHeight(rightView.bounds));
  CGFloat lowestAllowableSideViewCenterY = kTopMargin + (0.5 * sideViewMaxHeight);
  CGFloat sharedCenterY = MAX(lowestAllowableTextAreaCenterY, lowestAllowableSideViewCenterY);
  return sharedCenterY;
}

- (CGSize)placeholderSizeWithPlaceholder:(NSString *)placeholder
                           textAreaWidth:(CGFloat)textAreaWidth
                                    font:(UIFont *)font {
  if (!font) {
    return CGSizeZero;
  }
  CGSize fittingSize = CGSizeMake(textAreaWidth, CGFLOAT_MAX);
  NSDictionary *attributes = @{NSFontAttributeName: font};
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
                             textAreaRect:(CGRect)textAreaRect {
  CGFloat textAreaWidth = CGRectGetWidth(textAreaRect);
  CGFloat textAreaMinX = CGRectGetMinX(textAreaRect);
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
                                    textAreaWidth:textAreaWidth
                                             font:floatingPlaceholderFont];
      originY = floatingPlaceholderMinY;
      originX = textAreaMinX;
      if (textFieldStyle == TextFieldStyleOutline) {
        originX += kFloatingPlaceholderXOffsetFromTextArea;
      }
      rect = CGRectMake(originX, originY, size.width, size.height);
      break;
    case PlaceholderStateNormal:
      size = [self placeholderSizeWithPlaceholder:placeholder
                                    textAreaWidth:textAreaWidth
                                             font:font];
      originY = textAreaMidY - (0.5 * size.height);
      originX = textAreaMinX;
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
