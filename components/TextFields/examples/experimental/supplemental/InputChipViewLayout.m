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

#import "InputChipViewLayout.h"

#import <MDFInternationalization/MDFInternationalization.h>
#import "InputChipView.h"
#import "MaterialMath.h"

static const CGFloat kEstimatedCursorWidth = (CGFloat)2.0;

static const CGFloat kLeadingMargin = (CGFloat)8.0;
static const CGFloat kTrailingMargin = (CGFloat)8.0;

static const CGFloat kFloatingPlaceholderXOffset = (CGFloat)3.0;

@interface InputChipViewLayout ()

@property(nonatomic, assign) CGFloat calculatedHeight;
@property(nonatomic, assign) CGFloat minimumHeight;
@property(nonatomic, assign) CGFloat contentAreaMaxY;

@end

@implementation InputChipViewLayout

- (instancetype)initWithSize:(CGSize)size
                       containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                                 text:(NSString *)text
                          placeholder:(NSString *)placeholder
                                 font:(UIFont *)font
              floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                     placeholderState:(MDCContainedInputViewPlaceholderState)placeholderState
                                chips:(NSArray<UIView *> *)chips
                       staleChipViews:(NSArray<UIView *> *)staleChipViews
                            chipsWrap:(BOOL)chipsWrap
                        chipRowHeight:(CGFloat)chipRowHeight
                     interChipSpacing:(CGFloat)interChipSpacing
                          clearButton:(UIButton *)clearButton
                  clearButtonViewMode:(UITextFieldViewMode)clearButtonViewMode
                   leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                  rightUnderlineLabel:(UILabel *)rightUnderlineLabel
           underlineLabelDrawPriority:
               (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
     customUnderlineLabelDrawPriority:(CGFloat)normalizedCustomUnderlineLabelDrawPriority
       preferredMainContentAreaHeight:(CGFloat)preferredMainContentAreaHeight
    preferredUnderlineLabelAreaHeight:(CGFloat)preferredUnderlineLabelAreaHeight
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithSize:size
                           containerStyle:containerStyle
                                     text:text
                              placeholder:placeholder
                                     font:font
                  floatingPlaceholderFont:floatingPlaceholderFont
                         placeholderState:placeholderState
                                    chips:chips
                           staleChipViews:staleChipViews
                                chipsWrap:chipsWrap
                            chipRowHeight:chipRowHeight
                         interChipSpacing:interChipSpacing
                              clearButton:clearButton
                      clearButtonViewMode:clearButtonViewMode
                       leftUnderlineLabel:leftUnderlineLabel
                      rightUnderlineLabel:rightUnderlineLabel
               underlineLabelDrawPriority:underlineLabelDrawPriority
         customUnderlineLabelDrawPriority:normalizedCustomUnderlineLabelDrawPriority
           preferredMainContentAreaHeight:preferredMainContentAreaHeight
        preferredUnderlineLabelAreaHeight:preferredUnderlineLabelAreaHeight
                                    isRTL:isRTL
                                isEditing:isEditing];
  }
  return self;
}

- (void)calculateLayoutWithSize:(CGSize)size
                       containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                                 text:(NSString *)text
                          placeholder:(NSString *)placeholder
                                 font:(UIFont *)font
              floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                     placeholderState:(MDCContainedInputViewPlaceholderState)placeholderState
                                chips:(NSArray<UIView *> *)chips
                       staleChipViews:(NSArray<UIView *> *)staleChipViews
                            chipsWrap:(BOOL)chipsWrap
                        chipRowHeight:(CGFloat)chipRowHeight
                     interChipSpacing:(CGFloat)interChipSpacing
                          clearButton:(UIButton *)clearButton
                  clearButtonViewMode:(UITextFieldViewMode)clearButtonViewMode
                   leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                  rightUnderlineLabel:(UILabel *)rightUnderlineLabel
           underlineLabelDrawPriority:
               (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
     customUnderlineLabelDrawPriority:(CGFloat)normalizedCustomUnderlineLabelDrawPriority
       preferredMainContentAreaHeight:(CGFloat)preferredMainContentAreaHeight
    preferredUnderlineLabelAreaHeight:(CGFloat)preferredUnderlineLabelAreaHeight
                                isRTL:(BOOL)isRTL
                            isEditing:(BOOL)isEditing {
  CGFloat globalChipRowMinX = isRTL ? kTrailingMargin : kLeadingMargin;
  CGFloat globalChipRowMaxX = isRTL ? size.width - kLeadingMargin : size.width - kTrailingMargin;
  CGFloat maxTextWidth = globalChipRowMaxX - globalChipRowMinX;
  CGRect placeholderFrameFloating =
      [self floatingPlaceholderFrameWithPlaceholder:placeholder
                                               font:floatingPlaceholderFont
                                  globalChipRowMinX:globalChipRowMinX
                                  globalChipRowMaxX:globalChipRowMaxX
                                     containerStyle:containerStyle
                                              isRTL:isRTL];

  CGFloat initialChipRowMinYWithFloatingPlaceholder = [containerStyle.densityInformer
      contentAreaTopPaddingWithFloatingPlaceholderMaxY:CGRectGetMaxY(placeholderFrameFloating)];
  CGFloat highestPossibleInitialChipRowMaxY =
      initialChipRowMinYWithFloatingPlaceholder + chipRowHeight;
  CGFloat bottomPadding = [containerStyle.densityInformer normalContentAreaBottomPadding];
  CGFloat intrinsicMainContentAreaHeight = highestPossibleInitialChipRowMaxY + bottomPadding;
  CGFloat contentAreaMaxY = 0;
  if (preferredMainContentAreaHeight > intrinsicMainContentAreaHeight) {
    contentAreaMaxY = preferredMainContentAreaHeight;
  } else {
    contentAreaMaxY = intrinsicMainContentAreaHeight;
  }

  CGRect placeholderFrameNormal = [self normalPlaceholderFrameWithPlaceholder:placeholder
                                                                         font:font
                                                            globalChipRowMinX:globalChipRowMinX
                                                            globalChipRowMaxX:globalChipRowMaxX
                                                                    chipsWrap:chipsWrap
                                                            contentAreaHeight:contentAreaMaxY
                                                               containerStyle:containerStyle
                                                                        isRTL:isRTL];

  CGFloat initialChipRowMinYNormal =
      CGRectGetMidY(placeholderFrameNormal) - ((CGFloat)0.5 * chipRowHeight);
  if (chipsWrap) {
  } else {
    CGFloat center = contentAreaMaxY * (CGFloat)0.5;
    initialChipRowMinYNormal = center - (chipRowHeight * (CGFloat)0.5);
  }
  CGFloat initialChipRowMinY = initialChipRowMinYNormal;
  if (placeholderState == MDCContainedInputViewPlaceholderStateFloating) {
    initialChipRowMinY = initialChipRowMinYWithFloatingPlaceholder;
  }

  CGSize textFieldSize = [self textSizeWithText:text font:font maxWidth:maxTextWidth];

  NSArray<NSValue *> *chipFrames = [self determineChipFramesWithChips:chips
                                                            chipsWrap:chipsWrap
                                                        chipRowHeight:chipRowHeight
                                                     interChipSpacing:interChipSpacing
                                                   initialChipRowMinY:initialChipRowMinY
                                                    globalChipRowMinX:globalChipRowMinX
                                                    globalChipRowMaxX:globalChipRowMaxX
                                                                isRTL:isRTL];

  CGSize scrollViewSize = CGSizeMake(size.width, contentAreaMaxY);

  CGRect textFieldFrame = [self textFieldFrameWithSize:scrollViewSize
                                            chipFrames:chipFrames
                                             chipsWrap:chipsWrap
                                         chipRowHeight:chipRowHeight
                                      interChipSpacing:interChipSpacing
                                    initialChipRowMinY:initialChipRowMinY
                                     globalChipRowMinX:globalChipRowMinX
                                     globalChipRowMaxX:globalChipRowMaxX
                                         textFieldSize:textFieldSize
                                                 isRTL:isRTL];

  CGPoint contentOffset = [self scrollViewContentOffsetWithSize:scrollViewSize
                                                      chipsWrap:chipsWrap
                                                  chipRowHeight:chipRowHeight
                                               interChipSpacing:interChipSpacing
                                                 textFieldFrame:textFieldFrame
                                             initialChipRowMinY:initialChipRowMinY
                                              globalChipRowMinX:globalChipRowMinX
                                              globalChipRowMaxX:globalChipRowMaxX
                                                  bottomPadding:bottomPadding
                                                          isRTL:isRTL];
  CGSize contentSize = [self scrollViewContentSizeWithSize:scrollViewSize
                                             contentOffset:contentOffset
                                                chipFrames:chipFrames
                                                 chipsWrap:chipsWrap
                                            textFieldFrame:textFieldFrame];

  self.contentAreaMaxY = contentAreaMaxY;
  self.chipFrames = chipFrames;
  self.textFieldFrame = textFieldFrame;
  self.scrollViewContentOffset = contentOffset;
  self.scrollViewContentSize = contentSize;
  self.scrollViewContentViewTouchForwardingViewFrame =
      CGRectMake(0, 0, contentSize.width, contentSize.height);
  self.placeholderFrameFloating = placeholderFrameFloating;
  self.placeholderFrameNormal = placeholderFrameNormal;
  self.initialChipRowMinY = initialChipRowMinY;
  self.globalChipRowMinX = globalChipRowMinX;
  self.globalChipRowMaxX = globalChipRowMaxX;
  CGRect scrollViewRect = CGRectMake(0, 0, size.width, contentAreaMaxY);
  self.maskedScrollViewContainerViewFrame = scrollViewRect;
  self.scrollViewFrame = scrollViewRect;

  //  if (isRTL) {
  //    NSMutableArray<NSValue *> *rtlChips =
  //        [[NSMutableArray alloc] initWithCapacity:chipFrames.count];
  //    for (NSValue *chipFrame in chipFrames) {
  //      CGRect frame = [chipFrame CGRectValue];
  //      frame = MDFRectFlippedHorizontally(frame, size.width);
  //      [rtlChips addObject:[NSValue valueWithCGRect:frame]];
  //    }
  //    self.chipFrames = [rtlChips copy];
  //    self.textFieldFrame = MDFRectFlippedHorizontally(textFieldFrame, size.width);
  //    self.scrollViewContentViewTouchForwardingViewFrame =
  //        MDFRectFlippedHorizontally(self.scrollViewContentViewTouchForwardingViewFrame,
  //        size.width);
  //    self.placeholderFrameFloating = MDFRectFlippedHorizontally(placeholderFrameFloating,
  //    size.width); self.placeholderFrameNormal =
  //    MDFRectFlippedHorizontally(placeholderFrameNormal, size.width);
  //    self.maskedScrollViewContainerViewFrame =
  //        MDFRectFlippedHorizontally(self.maskedScrollViewContainerViewFrame, size.width);
  //    self.scrollViewFrame = MDFRectFlippedHorizontally(scrollViewRect, size.width);
  //  }

  return;
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
  CGFloat textRectMaxY = self.contentAreaMaxY;
  if (textRectMaxY > maxY) {
    maxY = textRectMaxY;
  }
  //  CGFloat clearButtonFrameMaxY = CGRectGetMaxY(self.clearButtonFrame);
  //  if (clearButtonFrameMaxY > maxY) {
  //    maxY = clearButtonFrameMaxY;
  //  }
  CGFloat leftUnderlineLabelFrameMaxY = CGRectGetMaxY(self.leftUnderlineLabelFrame);
  if (leftUnderlineLabelFrameMaxY > maxY) {
    maxY = leftUnderlineLabelFrameMaxY;
  }
  CGFloat rightUnderlineLabelFrameMaxY = CGRectGetMaxY(self.rightUnderlineLabelFrame);
  if (rightUnderlineLabelFrameMaxY > maxY) {
    maxY = rightUnderlineLabelFrameMaxY;
  }
  return maxY;
}

- (CGRect)normalPlaceholderFrameWithPlaceholder:(NSString *)placeholder
                                           font:(UIFont *)font
                              globalChipRowMinX:(CGFloat)globalChipRowMinX
                              globalChipRowMaxX:(CGFloat)globalChipRowMaxX
                                      chipsWrap:(BOOL)chipsWrap
                              contentAreaHeight:(CGFloat)contentAreaHeight
                                 containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                                          isRTL:(BOOL)isRTL {
  CGFloat maxTextWidth = globalChipRowMaxX - globalChipRowMinX;
  CGSize placeholderSize = [self textSizeWithText:placeholder font:font maxWidth:maxTextWidth];
  CGFloat placeholderMinX = globalChipRowMinX;
  if (isRTL) {
    placeholderMinX = globalChipRowMaxX - placeholderSize.width;
  }
  CGFloat placeholderMinY = 0;
  if (chipsWrap) {
    placeholderMinY = [containerStyle.densityInformer normalContentAreaTopPadding];
  } else {
    CGFloat center = contentAreaHeight * (CGFloat)0.5;
    placeholderMinY = center - (placeholderSize.height * (CGFloat)0.5);
  }
  return CGRectMake(placeholderMinX, placeholderMinY, placeholderSize.width,
                    placeholderSize.height);
}

- (CGRect)floatingPlaceholderFrameWithPlaceholder:(NSString *)placeholder
                                             font:(UIFont *)font
                                globalChipRowMinX:(CGFloat)globalChipRowMinX
                                globalChipRowMaxX:(CGFloat)globalChipRowMaxX
                                   containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                                            isRTL:(BOOL)isRTL {
  CGFloat maxTextWidth = globalChipRowMaxX - globalChipRowMinX - kFloatingPlaceholderXOffset;
  CGSize placeholderSize = [self textSizeWithText:placeholder font:font maxWidth:maxTextWidth];
  CGFloat placeholderMinY = [containerStyle.densityInformer
      floatingPlaceholderMinYWithFloatingPlaceholderHeight:placeholderSize.height];
  CGFloat placeholderMinX = globalChipRowMinX + kFloatingPlaceholderXOffset;
  if (isRTL) {
    placeholderMinX = globalChipRowMaxX - kFloatingPlaceholderXOffset - placeholderSize.width;
  }
  return CGRectMake(placeholderMinX, placeholderMinY, placeholderSize.width,
                    placeholderSize.height);
}

- (CGFloat)textHeightWithFont:(UIFont *)font {
  return (CGFloat)ceil((double)font.lineHeight);
}

- (NSArray<NSValue *> *)determineChipFramesWithChips:(NSArray<UIView *> *)chips
                                           chipsWrap:(BOOL)chipsWrap
                                       chipRowHeight:(CGFloat)chipRowHeight
                                    interChipSpacing:(CGFloat)interChipSpacing
                                  initialChipRowMinY:(CGFloat)initialChipRowMinY
                                   globalChipRowMinX:(CGFloat)globalChipRowMinX
                                   globalChipRowMaxX:(CGFloat)globalChipRowMaxX
                                               isRTL:(BOOL)isRTL {
  NSMutableArray<NSValue *> *frames = [[NSMutableArray alloc] initWithCapacity:chips.count];

  if (isRTL) {
    NSArray<UIView *> *rtlChips = [[chips reverseObjectEnumerator] allObjects];
    if (chipsWrap) {
      //      CGFloat chipMinX = globalChipRowMinX;
      //      CGFloat chipMidY = initialChipRowMinY + (0.5 * chipRowHeight);
      //      CGFloat chipMinY = 0;
      //      CGRect chipFrame = CGRectZero;
      //      NSInteger row = 0;
      //      for (MDCChipView *chip in chips) {
      //        CGFloat chipWidth = CGRectGetWidth(chip.frame);
      //        CGFloat chipHeight = CGRectGetHeight(chip.frame);
      //        CGFloat chipMaxX = chipMinX + chipWidth;
      //        BOOL chipIsTooLong = chipMaxX > globalChipRowMaxX;
      //        BOOL firstChipInRow = chipMinX == globalChipRowMinX;
      //        BOOL isNewRow = chipIsTooLong && !firstChipInRow;
      //        if (isNewRow) {
      //          row++;
      //          chipMinX = globalChipRowMinX;
      //          chipMidY = initialChipRowMinY + (row * (chipRowHeight + interChipSpacing)) +
      //          (0.5 * chipRowHeight);
      //          chipMinY = chipMidY - (0.5 * chipHeight);
      //          chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
      //          chipMaxX = CGRectGetMaxX(chipFrame);
      //        } else {
      //          chipMinY = chipMidY - (0.5 * chipHeight);
      //          chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
      //        }
      //        chipMinX = chipMaxX + interChipSpacing;
      //        NSValue *chipFrameValue = [NSValue valueWithCGRect:chipFrame];
      //        [frames addObject:chipFrameValue];
      //      }
    } else {
      CGFloat chipMinX = globalChipRowMinX;
      CGFloat chipCenterY = initialChipRowMinY + (chipRowHeight * (CGFloat)0.5);
      for (MDCChipView *chip in rtlChips) {
        CGFloat chipWidth = CGRectGetWidth(chip.frame);
        CGFloat chipHeight = CGRectGetHeight(chip.frame);
        CGFloat chipMinY = chipCenterY - ((CGFloat)0.5 * chipHeight);
        CGRect chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
        NSValue *chipFrameValue = [NSValue valueWithCGRect:chipFrame];
        [frames addObject:chipFrameValue];
        CGFloat chipMaxX = MDCCeil(CGRectGetMaxX(chipFrame));
        chipMinX = chipMaxX + interChipSpacing;
      }
    }
  } else {
    if (chipsWrap) {
      CGFloat chipMinX = globalChipRowMinX;
      CGFloat chipMidY = initialChipRowMinY + ((CGFloat)0.5 * chipRowHeight);
      CGFloat chipMinY = 0;
      CGRect chipFrame = CGRectZero;
      CGFloat row = 0;
      for (MDCChipView *chip in chips) {
        CGFloat chipWidth = CGRectGetWidth(chip.frame);
        CGFloat chipHeight = CGRectGetHeight(chip.frame);
        CGFloat chipMaxX = chipMinX + chipWidth;
        BOOL chipIsTooLong = chipMaxX > globalChipRowMaxX;
        BOOL firstChipInRow = chipMinX == globalChipRowMinX;
        BOOL isNewRow = chipIsTooLong && !firstChipInRow;
        if (isNewRow) {
          row++;
          chipMinX = globalChipRowMinX;
          chipMidY = initialChipRowMinY + (row * (chipRowHeight + interChipSpacing)) +
                     ((CGFloat)0.5 * chipRowHeight);
          chipMinY = chipMidY - ((CGFloat)0.5 * chipHeight);
          chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
          chipMaxX = CGRectGetMaxX(chipFrame);
        } else {
          chipMinY = chipMidY - ((CGFloat)0.5 * chipHeight);
          chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
        }
        chipMinX = chipMaxX + interChipSpacing;
        NSValue *chipFrameValue = [NSValue valueWithCGRect:chipFrame];
        [frames addObject:chipFrameValue];
      }
    } else {
      CGFloat chipMinX = globalChipRowMinX;
      CGFloat chipCenterY = initialChipRowMinY + (chipRowHeight * (CGFloat)0.5);
      for (MDCChipView *chip in chips) {
        CGFloat chipWidth = CGRectGetWidth(chip.frame);
        CGFloat chipHeight = CGRectGetHeight(chip.frame);
        CGFloat chipMinY = chipCenterY - ((CGFloat)0.5 * chipHeight);
        CGRect chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
        NSValue *chipFrameValue = [NSValue valueWithCGRect:chipFrame];
        [frames addObject:chipFrameValue];
        CGFloat chipMaxX = MDCCeil(CGRectGetMaxX(chipFrame));
        chipMinX = chipMaxX + interChipSpacing;
      }
    }
  }
  return [frames copy];
}

- (CGSize)textSizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
  CGSize fittingSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
  NSDictionary *attributes = @{NSFontAttributeName : font};
  CGRect rect = [text boundingRectWithSize:fittingSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:attributes
                                   context:nil];
  CGFloat maxTextFieldHeight = font.lineHeight;
  CGFloat textFieldWidth = MDCCeil(CGRectGetWidth(rect)) + kEstimatedCursorWidth;
  CGFloat textFieldHeight = MDCCeil(CGRectGetHeight(rect));
  if (textFieldWidth > maxWidth) {
    textFieldWidth = maxWidth;
  }
  if (textFieldHeight > maxTextFieldHeight) {
    textFieldHeight = maxTextFieldHeight;
  }
  rect.size.width = textFieldWidth;
  rect.size.height = textFieldHeight;
  return rect.size;
}

- (CGSize)scrollViewContentSizeWithSize:(CGSize)size
                          contentOffset:(CGPoint)contentOffset
                             chipFrames:(NSArray<NSValue *> *)chipFrames
                              chipsWrap:(BOOL)chipsWrap
                         textFieldFrame:(CGRect)textFieldFrame {
  if (chipsWrap) {
    if (contentOffset.y > 0) {
      size.height += contentOffset.y;
    }
    return size;
  } else {
    if (contentOffset.x > 0) {
      size.width += contentOffset.x;
    }
    return size;
  }
  //  CGFloat totalMinX = 0;
  //  CGFloat totalMaxX = 0;
  //  CGFloat totalMinY = 0;
  //  CGFloat totalMaxY = 0;
  //  NSValue *textFieldFrameValue = [NSValue valueWithCGRect:textFieldFrame];
  //  NSArray *allFrames = [chipFrames arrayByAddingObject:textFieldFrameValue];
  //  for (NSUInteger index = 0; index < allFrames.count; index++) {
  //    NSValue *frameValue = allFrames[index];
  //    CGRect frame = frameValue.CGRectValue;
  //    if (index == 0) {
  //      totalMinX = CGRectGetMinX(frame);
  //      totalMaxX = CGRectGetMaxX(frame);
  //      totalMinY = CGRectGetMinY(frame);
  //      totalMaxY = CGRectGetMaxY(frame);
  //    } else {
  //      CGFloat minX = CGRectGetMinX(frame);
  //      CGFloat maxX = CGRectGetMaxX(frame);
  //      CGFloat minY = CGRectGetMinY(frame);
  //      CGFloat maxY = CGRectGetMaxY(frame);
  //      if (minX < totalMinX) {
  //        totalMinX = minX;
  //      }
  //      if (minY < totalMinY) {
  //        totalMinY = minY;
  //      }
  //      if (maxX > totalMaxX) {
  //        totalMaxX = maxX;
  //      }
  //      if (maxY > totalMaxY) {
  //        totalMaxY = maxY;
  //      }
  //    }
  //  }
  //  CGFloat width = totalMaxX - totalMinX;
  //  CGFloat height = totalMaxY - totalMinY;
  //  return CGSizeMake(width, height);
}

- (CGRect)textFieldFrameWithSize:(CGSize)size
                      chipFrames:(NSArray<NSValue *> *)chipFrames
                       chipsWrap:(BOOL)chipsWrap
                   chipRowHeight:(CGFloat)chipRowHeight
                interChipSpacing:(CGFloat)interChipSpacing
              initialChipRowMinY:(CGFloat)initialChipRowMinY
               globalChipRowMinX:(CGFloat)globalChipRowMinX
               globalChipRowMaxX:(CGFloat)globalChipRowMaxX
                   textFieldSize:(CGSize)textFieldSize
                           isRTL:(BOOL)isRTL {
  if (isRTL) {
    if (chipsWrap) {
    } else {
    }
  } else {
    if (chipsWrap) {
      CGFloat textFieldMinX = 0;
      CGFloat textFieldMaxX = 0;
      CGFloat textFieldMinY = 0;
      CGFloat textFieldMidY = 0;
      if (chipFrames.count > 0) {
        CGRect lastChipFrame = [[chipFrames lastObject] CGRectValue];
        CGFloat lastChipMidY = CGRectGetMidY(lastChipFrame);
        textFieldMidY = lastChipMidY;
        textFieldMinY = textFieldMidY - ((CGFloat)0.5 * textFieldSize.height);
        textFieldMinX = CGRectGetMaxX(lastChipFrame) + interChipSpacing;
        textFieldMaxX = textFieldMinX + textFieldSize.width;
        BOOL textFieldShouldMoveToNextRow = textFieldMaxX > globalChipRowMaxX;
        if (textFieldShouldMoveToNextRow) {
          NSInteger currentRow = [self chipRowWithRect:lastChipFrame
                                    initialChipRowMinY:initialChipRowMinY
                                         chipRowHeight:chipRowHeight
                                      interChipSpacing:interChipSpacing];
          NSInteger nextRow = currentRow + 1;
          CGFloat nextRowMinY =
              initialChipRowMinY + ((CGFloat)(nextRow) * (chipRowHeight + interChipSpacing));
          textFieldMidY = nextRowMinY + ((CGFloat)0.5 * chipRowHeight);
          textFieldMinY = textFieldMidY - ((CGFloat)0.5 * textFieldSize.height);
          textFieldMinX = globalChipRowMinX;
          textFieldMaxX = textFieldMinX + textFieldSize.width;
          BOOL textFieldIsStillTooBig = textFieldMaxX > globalChipRowMaxX;
          if (textFieldIsStillTooBig) {
            CGFloat difference = textFieldMaxX - globalChipRowMaxX;
            textFieldSize.width = textFieldSize.width - difference;
          }
        }
        return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
      } else {
        textFieldMinX = globalChipRowMinX;
        textFieldMidY = initialChipRowMinY + ((CGFloat)0.5 * chipRowHeight);
        textFieldMinY = textFieldMidY - ((CGFloat)0.5 * textFieldSize.height);
        return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
      }
      return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
    } else {
      CGFloat textFieldMinX = 0;
      if (chipFrames.count > 0) {
        CGRect lastFrame = [[chipFrames lastObject] CGRectValue];
        textFieldMinX = MDCCeil(CGRectGetMaxX(lastFrame)) + interChipSpacing;
      } else {
        textFieldMinX = globalChipRowMinX;
      }
      CGFloat textFieldCenterY = initialChipRowMinY + ((CGFloat)0.5 * chipRowHeight);
      CGFloat textFieldMinY = textFieldCenterY - ((CGFloat)0.5 * textFieldSize.height);
      return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
    }
  }
  return CGRectZero;
}

- (CGPoint)scrollViewContentOffsetWithSize:(CGSize)size
                                 chipsWrap:(BOOL)chipsWrap
                             chipRowHeight:(CGFloat)chipRowHeight
                          interChipSpacing:(CGFloat)interChipSpacing
                            textFieldFrame:(CGRect)textFieldFrame
                        initialChipRowMinY:(CGFloat)initialChipRowMinY
                         globalChipRowMinX:(CGFloat)globalChipRowMinX
                         globalChipRowMaxX:(CGFloat)globalChipRowMaxX
                             bottomPadding:(CGFloat)bottomPadding
                                     isRTL:(BOOL)isRTL {
  CGPoint contentOffset = CGPointZero;
  if (isRTL) {
    if (chipsWrap) {
    } else {
    }
  } else {
    if (chipsWrap) {
      NSInteger row = [self chipRowWithRect:textFieldFrame
                         initialChipRowMinY:initialChipRowMinY
                              chipRowHeight:chipRowHeight
                           interChipSpacing:interChipSpacing];
      CGFloat lastRowMaxY = initialChipRowMinY + ((row + 1) * (chipRowHeight + interChipSpacing));
      CGFloat boundsMaxY = size.height;
      if (lastRowMaxY > boundsMaxY) {
        CGFloat difference = lastRowMaxY - boundsMaxY;
        contentOffset = CGPointMake(0, (difference + bottomPadding));
      }
    } else {
      CGFloat textFieldMinX = CGRectGetMinX(textFieldFrame);
      CGFloat textFieldMaxX = CGRectGetMaxX(textFieldFrame);

      if (textFieldMaxX > globalChipRowMaxX) {
        CGFloat difference = textFieldMaxX - globalChipRowMaxX;
        contentOffset = CGPointMake(difference, 0);
      } else if (textFieldMinX < globalChipRowMinX) {
        CGFloat difference = globalChipRowMinX - textFieldMinX;
        contentOffset = CGPointMake((-1 * difference), 0);
      }
    }
  }
  return contentOffset;
}

- (NSInteger)chipRowWithRect:(CGRect)rect
          initialChipRowMinY:(CGFloat)initialChipRowMinY
               chipRowHeight:(CGFloat)chipRowHeight
            interChipSpacing:(CGFloat)interChipSpacing {
  CGFloat viewMidY = CGRectGetMidY(rect);
  CGFloat midYAdjustedForContentInset = MDCRound(viewMidY - initialChipRowMinY);
  NSInteger row =
      (NSInteger)midYAdjustedForContentInset / (NSInteger)(chipRowHeight + interChipSpacing);
  return row;
}

@end
