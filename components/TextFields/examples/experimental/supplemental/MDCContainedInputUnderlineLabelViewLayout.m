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

#import "MDCContainedInputUnderlineLabelViewLayout.h"

@interface MDCContainedInputUnderlineLabelViewLayout ()

@property(nonatomic, assign) CGRect leftUnderlineLabelFrame;
@property(nonatomic, assign) CGRect rightUnderlineLabelFrame;
@property(nonatomic, assign) CGFloat calculatedHeight;

@end

@implementation MDCContainedInputUnderlineLabelViewLayout

#pragma mark Object Lifecycle

- (instancetype)initWithSuperviewWidth:(CGFloat)superviewWidth
                    leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                   rightUnderlineLabel:(UILabel *)rightUnderlineLabel
            underlineLabelDrawPriority:
                (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
      customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
                     horizontalPadding:(CGFloat)horizontalPadding
                       verticalPadding:(CGFloat)verticalPadding
                                 isRTL:(BOOL)isRTL {
  self = [super init];
  if (self) {
    [self calculateLayoutWithSuperviewWidth:superviewWidth
                         leftUnderlineLabel:leftUnderlineLabel
                        rightUnderlineLabel:rightUnderlineLabel
                 underlineLabelDrawPriority:underlineLabelDrawPriority
           customUnderlineLabelDrawPriority:customUnderlineLabelDrawPriority
                          horizontalPadding:horizontalPadding
                            verticalPadding:verticalPadding
                                      isRTL:isRTL];
    return self;
  }
  return nil;
}

#pragma mark Layout Calculation
- (void)calculateLayoutWithSuperviewWidth:(CGFloat)superviewWidth
                       leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                      rightUnderlineLabel:(UILabel *)rightUnderlineLabel
               underlineLabelDrawPriority:
                   (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
         customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
                        horizontalPadding:(CGFloat)horizontalPadding
                          verticalPadding:(CGFloat)verticalPadding
                                    isRTL:(BOOL)isRTL {
  CGFloat underlineLabelsCombinedMinX = horizontalPadding;
  CGFloat underlineLabelsCombinedMaxX = superviewWidth - horizontalPadding;
  CGFloat underlineLabelsCombinedMaxWidth =
      underlineLabelsCombinedMaxX - underlineLabelsCombinedMinX;

  CGFloat underlineLabelsCombinedMinY = verticalPadding;
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
      if ([self isLabelMultilineWithLabel:leadingUnderlineLabel size:leadingUnderlineLabelSize]) {
        trailingUnderlineLabelSize = CGSizeZero;
      } else {
        trailingUnderlineLabelSize =
            [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                           constrainedToWidth:underlineLabelsCombinedMaxWidth -
                                              leadingUnderlineLabelSize.width];
      }
      break;
    case MDCContainedInputViewUnderlineLabelDrawPriorityTrailing:
      trailingUnderlineLabelSize =
          [self underlineLabelSizeWithLabel:trailingUnderlineLabel
                         constrainedToWidth:underlineLabelsCombinedMaxWidth];
      if ([self isLabelMultilineWithLabel:trailingUnderlineLabel size:trailingUnderlineLabelSize]) {
        leadingUnderlineLabelSize = CGSizeZero;
      } else {
        leadingUnderlineLabelSize =
            [self underlineLabelSizeWithLabel:leadingUnderlineLabel
                           constrainedToWidth:underlineLabelsCombinedMaxWidth -
                                              trailingUnderlineLabelSize.width];
      }
      break;
    default:
      break;
  }

  BOOL leadingUnderlineLabelIsVisible = !CGSizeEqualToSize(leadingUnderlineLabelSize, CGSizeZero);
  BOOL trailingUnderlineLabelIsVisible = !CGSizeEqualToSize(trailingUnderlineLabelSize, CGSizeZero);
  if (!leadingUnderlineLabelIsVisible && !trailingUnderlineLabelIsVisible) {
    self.leftUnderlineLabelFrame = CGRectZero;
    self.rightUnderlineLabelFrame = CGRectZero;
    self.calculatedHeight = 0;
    return;
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

  CGFloat maxUnderlineLabelHeight =
      MAX(CGRectGetMaxY(leftUnderlineLabelFrame), CGRectGetMaxY(rightUnderlineLabelFrame));
  self.leftUnderlineLabelFrame = leftUnderlineLabelFrame;
  self.rightUnderlineLabelFrame = rightUnderlineLabelFrame;
  self.calculatedHeight = maxUnderlineLabelHeight + verticalPadding;
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

- (BOOL)isLabelMultilineWithLabel:(UILabel *)label size:(CGSize)size {
  CGFloat lineHeight = label.font.lineHeight;
  return round((double)(size.height / lineHeight)) > 1;
}

@end
