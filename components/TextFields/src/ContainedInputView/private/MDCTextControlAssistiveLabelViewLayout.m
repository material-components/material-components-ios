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

#import "MDCTextControlAssistiveLabelViewLayout.h"

@interface MDCTextControlAssistiveLabelViewLayout ()

@property(nonatomic, assign) CGRect leftAssistiveLabelFrame;
@property(nonatomic, assign) CGRect rightAssistiveLabelFrame;
@property(nonatomic, assign) CGFloat calculatedHeight;

@end

@implementation MDCTextControlAssistiveLabelViewLayout

#pragma mark Object Lifecycle

- (instancetype)initWithWidth:(CGFloat)superviewWidth
                  leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                 rightAssistiveLabel:(UILabel *)rightAssistiveLabel
          assistiveLabelDrawPriority:
              (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                   horizontalPadding:(CGFloat)horizontalPadding
         paddingAboveAssistiveLabels:(CGFloat)paddingAboveAssistiveLabels
         paddingBelowAssistiveLabels:(CGFloat)paddingBelowAssistiveLabels
                               isRTL:(BOOL)isRTL {
  self = [super init];
  if (self) {
    [self calculateLayoutWithSuperviewWidth:superviewWidth
                         leftAssistiveLabel:leftAssistiveLabel
                        rightAssistiveLabel:rightAssistiveLabel
                 assistiveLabelDrawPriority:assistiveLabelDrawPriority
           customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                          horizontalPadding:horizontalPadding
                paddingAboveAssistiveLabels:(CGFloat)paddingAboveAssistiveLabels
                paddingBelowAssistiveLabels:(CGFloat)paddingBelowAssistiveLabels
                                      isRTL:isRTL];
    return self;
  }
  return nil;
}

#pragma mark Layout Calculation

- (void)calculateLayoutWithSuperviewWidth:(CGFloat)superviewWidth
                       leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                      rightAssistiveLabel:(UILabel *)rightAssistiveLabel
               assistiveLabelDrawPriority:
                   (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
         customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                        horizontalPadding:(CGFloat)horizontalPadding
              paddingAboveAssistiveLabels:(CGFloat)paddingAboveAssistiveLabels
              paddingBelowAssistiveLabels:(CGFloat)paddingBelowAssistiveLabels
                                    isRTL:(BOOL)isRTL {
  CGFloat assistiveLabelsCombinedMinX = horizontalPadding;
  CGFloat assistiveLabelsCombinedMaxX = superviewWidth - horizontalPadding;
  CGFloat assistiveLabelsCombinedMaxWidth =
      assistiveLabelsCombinedMaxX - assistiveLabelsCombinedMinX;

  CGFloat assistiveLabelsCombinedMinY = paddingAboveAssistiveLabels;
  CGFloat leadingAssistiveLabelWidth = 0;
  CGFloat trailingAssistiveLabelWidth = 0;
  CGSize leadingAssistiveLabelSize = CGSizeZero;
  CGSize trailingAssistiveLabelSize = CGSizeZero;
  UILabel *leadingAssistiveLabel = isRTL ? rightAssistiveLabel : leftAssistiveLabel;
  UILabel *trailingAssistiveLabel = isRTL ? leftAssistiveLabel : rightAssistiveLabel;
  switch (assistiveLabelDrawPriority) {
    case MDCTextControlAssistiveLabelDrawPriorityCustom:
      leadingAssistiveLabelWidth = [self
          leadingAssistiveLabelWidthWithCombinedAssistiveLabelsWidth:assistiveLabelsCombinedMaxWidth
                                                  customDrawPriority:
                                                      customAssistiveLabelDrawPriority];
      trailingAssistiveLabelWidth = assistiveLabelsCombinedMaxWidth - leadingAssistiveLabelWidth;
      leadingAssistiveLabelSize = [self assistiveLabelSizeWithLabel:leadingAssistiveLabel
                                                 constrainedToWidth:leadingAssistiveLabelWidth];
      trailingAssistiveLabelSize = [self assistiveLabelSizeWithLabel:trailingAssistiveLabel
                                                  constrainedToWidth:trailingAssistiveLabelWidth];
      break;
    case MDCTextControlAssistiveLabelDrawPriorityLeading:
      leadingAssistiveLabelSize =
          [self assistiveLabelSizeWithLabel:leadingAssistiveLabel
                         constrainedToWidth:assistiveLabelsCombinedMaxWidth];
      if ([self isLabelMultilineWithLabel:leadingAssistiveLabel size:leadingAssistiveLabelSize]) {
        trailingAssistiveLabelSize = CGSizeZero;
      } else {
        trailingAssistiveLabelSize =
            [self assistiveLabelSizeWithLabel:trailingAssistiveLabel
                           constrainedToWidth:assistiveLabelsCombinedMaxWidth -
                                              leadingAssistiveLabelSize.width];
      }
      break;
    case MDCTextControlAssistiveLabelDrawPriorityTrailing:
      // Pass through (.trailing is the default priority)
    default:
      trailingAssistiveLabelSize =
          [self assistiveLabelSizeWithLabel:trailingAssistiveLabel
                         constrainedToWidth:assistiveLabelsCombinedMaxWidth];
      if ([self isLabelMultilineWithLabel:trailingAssistiveLabel size:trailingAssistiveLabelSize]) {
        leadingAssistiveLabelSize = CGSizeZero;
      } else {
        leadingAssistiveLabelSize =
            [self assistiveLabelSizeWithLabel:leadingAssistiveLabel
                           constrainedToWidth:assistiveLabelsCombinedMaxWidth -
                                              trailingAssistiveLabelSize.width];
      }
      break;
  }

  BOOL leadingAssistiveLabelIsVisible = !CGSizeEqualToSize(leadingAssistiveLabelSize, CGSizeZero);
  BOOL trailingAssistiveLabelIsVisible = !CGSizeEqualToSize(trailingAssistiveLabelSize, CGSizeZero);
  if (!leadingAssistiveLabelIsVisible && !trailingAssistiveLabelIsVisible) {
    self.leftAssistiveLabelFrame = CGRectZero;
    self.rightAssistiveLabelFrame = CGRectZero;
    self.calculatedHeight = 0;
    return;
  }

  CGSize leftAssistiveLabelSize = isRTL ? trailingAssistiveLabelSize : leadingAssistiveLabelSize;
  CGSize rightAssistiveLabelSize = isRTL ? leadingAssistiveLabelSize : trailingAssistiveLabelSize;
  CGRect leftAssistiveLabelFrame = CGRectZero;
  CGRect rightAssistiveLabelFrame = CGRectZero;
  if (!CGSizeEqualToSize(leftAssistiveLabelSize, CGSizeZero)) {
    leftAssistiveLabelFrame =
        CGRectMake(assistiveLabelsCombinedMinX, assistiveLabelsCombinedMinY,
                   leftAssistiveLabelSize.width, leftAssistiveLabelSize.height);
  }
  if (!CGSizeEqualToSize(rightAssistiveLabelSize, CGSizeZero)) {
    rightAssistiveLabelFrame = CGRectMake(
        assistiveLabelsCombinedMaxX - rightAssistiveLabelSize.width, assistiveLabelsCombinedMinY,
        rightAssistiveLabelSize.width, rightAssistiveLabelSize.height);
  }

  CGFloat maxAssistiveLabelHeight =
      MAX(CGRectGetMaxY(leftAssistiveLabelFrame), CGRectGetMaxY(rightAssistiveLabelFrame));
  self.leftAssistiveLabelFrame = leftAssistiveLabelFrame;
  self.rightAssistiveLabelFrame = rightAssistiveLabelFrame;
  self.calculatedHeight = maxAssistiveLabelHeight + paddingBelowAssistiveLabels;
}

- (CGSize)assistiveLabelSizeWithLabel:(UILabel *)label constrainedToWidth:(CGFloat)maxWidth {
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

- (BOOL)isLabelMultilineWithLabel:(UILabel *)label size:(CGSize)size {
  CGFloat lineHeight = label.font.lineHeight;
  return round((double)(size.height / lineHeight)) > 1;
}

@end
