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

#import "MDCContainedInputAssistiveLabelViewLayout.h"

@interface MDCContainedInputAssistiveLabelViewLayout ()

@property(nonatomic, assign) CGRect leftAssistiveLabelFrame;
@property(nonatomic, assign) CGRect rightAssistiveLabelFrame;
@property(nonatomic, assign) CGFloat calculatedHeight;

@end

@implementation MDCContainedInputAssistiveLabelViewLayout

#pragma mark Object Lifecycle

- (instancetype)initWithWidth:(CGFloat)superviewWidth
                  leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                 rightAssistiveLabel:(UILabel *)rightAssistiveLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                   horizontalPadding:(CGFloat)horizontalPadding
                     verticalPadding:(CGFloat)verticalPadding
                               isRTL:(BOOL)isRTL {
  self = [super init];
  if (self) {
    [self calculateLayoutWithSuperviewWidth:superviewWidth
                         leftAssistiveLabel:leftAssistiveLabel
                        rightAssistiveLabel:rightAssistiveLabel
                 underlineLabelDrawPriority:underlineLabelDrawPriority
           customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                          horizontalPadding:horizontalPadding
                            verticalPadding:verticalPadding
                                      isRTL:isRTL];
    return self;
  }
  return nil;
}

#pragma mark Layout Calculation
- (void)calculateLayoutWithSuperviewWidth:(CGFloat)superviewWidth
                       leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                      rightAssistiveLabel:(UILabel *)rightAssistiveLabel
               underlineLabelDrawPriority:
                   (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
         customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                        horizontalPadding:(CGFloat)horizontalPadding
                          verticalPadding:(CGFloat)verticalPadding
                                    isRTL:(BOOL)isRTL {
  CGFloat underlineLabelsCombinedMinX = horizontalPadding;
  CGFloat underlineLabelsCombinedMaxX = superviewWidth - horizontalPadding;
  CGFloat underlineLabelsCombinedMaxWidth =
      underlineLabelsCombinedMaxX - underlineLabelsCombinedMinX;

  CGFloat underlineLabelsCombinedMinY = verticalPadding;
  CGFloat leadingAssistiveLabelWidth = 0;
  CGFloat trailingAssistiveLabelWidth = 0;
  CGSize leadingAssistiveLabelSize = CGSizeZero;
  CGSize trailingAssistiveLabelSize = CGSizeZero;
  UILabel *leadingAssistiveLabel = isRTL ? rightAssistiveLabel : leftAssistiveLabel;
  UILabel *trailingAssistiveLabel = isRTL ? leftAssistiveLabel : rightAssistiveLabel;
  switch (underlineLabelDrawPriority) {
    case MDCContainedInputViewAssistiveLabelDrawPriorityCustom:
      leadingAssistiveLabelWidth = [self
          leadingAssistiveLabelWidthWithCombinedAssistiveLabelsWidth:underlineLabelsCombinedMaxWidth
                                                  customDrawPriority:
                                                      customAssistiveLabelDrawPriority];
      trailingAssistiveLabelWidth = underlineLabelsCombinedMaxWidth - leadingAssistiveLabelWidth;
      leadingAssistiveLabelSize = [self underlineLabelSizeWithLabel:leadingAssistiveLabel
                                                 constrainedToWidth:leadingAssistiveLabelWidth];
      trailingAssistiveLabelSize = [self underlineLabelSizeWithLabel:trailingAssistiveLabel
                                                  constrainedToWidth:trailingAssistiveLabelWidth];
      break;
    case MDCContainedInputViewAssistiveLabelDrawPriorityLeading:
      leadingAssistiveLabelSize =
          [self underlineLabelSizeWithLabel:leadingAssistiveLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth];
      if ([self isLabelMultilineWithLabel:leadingAssistiveLabel size:leadingAssistiveLabelSize]) {
        trailingAssistiveLabelSize = CGSizeZero;
      } else {
        trailingAssistiveLabelSize =
            [self underlineLabelSizeWithLabel:trailingAssistiveLabel
                           constrainedToWidth:underlineLabelsCombinedMaxWidth -
                                              leadingAssistiveLabelSize.width];
      }
      break;
    case MDCContainedInputViewAssistiveLabelDrawPriorityTrailing:
      trailingAssistiveLabelSize =
          [self underlineLabelSizeWithLabel:trailingAssistiveLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth];
      if ([self isLabelMultilineWithLabel:trailingAssistiveLabel size:trailingAssistiveLabelSize]) {
        leadingAssistiveLabelSize = CGSizeZero;
      } else {
        leadingAssistiveLabelSize =
            [self underlineLabelSizeWithLabel:leadingAssistiveLabel
                           constrainedToWidth:underlineLabelsCombinedMaxWidth -
                                              trailingAssistiveLabelSize.width];
      }
      break;
    default:
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
        CGRectMake(underlineLabelsCombinedMinX, underlineLabelsCombinedMinY,
                   leftAssistiveLabelSize.width, leftAssistiveLabelSize.height);
  }
  if (!CGSizeEqualToSize(rightAssistiveLabelSize, CGSizeZero)) {
    rightAssistiveLabelFrame = CGRectMake(
        underlineLabelsCombinedMaxX - rightAssistiveLabelSize.width, underlineLabelsCombinedMinY,
        rightAssistiveLabelSize.width, rightAssistiveLabelSize.height);
  }

  CGFloat maxAssistiveLabelHeight =
      MAX(CGRectGetMaxY(leftAssistiveLabelFrame), CGRectGetMaxY(rightAssistiveLabelFrame));
  self.leftAssistiveLabelFrame = leftAssistiveLabelFrame;
  self.rightAssistiveLabelFrame = rightAssistiveLabelFrame;
  self.calculatedHeight = maxAssistiveLabelHeight + verticalPadding;
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

- (BOOL)isLabelMultilineWithLabel:(UILabel *)label size:(CGSize)size {
  CGFloat lineHeight = label.font.lineHeight;
  return round((double)(size.height / lineHeight)) > 1;
}

@end
