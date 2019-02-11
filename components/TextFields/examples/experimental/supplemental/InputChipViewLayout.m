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

#import <MaterialComponents/MaterialMath.h>
#import "InputChipView.h"

static const CGFloat kEstimatedCursorWidth = (CGFloat)2.0;

static const CGFloat kLeadingMargin = (CGFloat)8.0;
static const CGFloat kTrailingMargin = (CGFloat)8.0;

static const CGFloat kFloatingPlaceholderXOffset = (CGFloat)3.0;

@interface InputChipViewLayout ()
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
                        canChipsWrap:(BOOL)canChipsWrap
                       chipRowHeight:(CGFloat)chipRowHeight
                    interChipSpacing:(CGFloat)interChipSpacing
                         clearButton:(UIButton *)clearButton
                 clearButtonViewMode:(UITextFieldViewMode)clearButtonViewMode
                  leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                 rightUnderlineLabel:(UILabel *)rightUnderlineLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
    customUnderlineLabelDrawPriority:(CGFloat)normalizedCustomUnderlineLabelDrawPriority
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
                            canChipsWrap:canChipsWrap
                           chipRowHeight:chipRowHeight
                        interChipSpacing:interChipSpacing
                             clearButton:clearButton
                     clearButtonViewMode:clearButtonViewMode
                      leftUnderlineLabel:leftUnderlineLabel
                     rightUnderlineLabel:rightUnderlineLabel
              underlineLabelDrawPriority:underlineLabelDrawPriority
        customUnderlineLabelDrawPriority:normalizedCustomUnderlineLabelDrawPriority
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
                        canChipsWrap:(BOOL)canChipsWrap
                       chipRowHeight:(CGFloat)chipRowHeight
                    interChipSpacing:(CGFloat)interChipSpacing
                         clearButton:(UIButton *)clearButton
                 clearButtonViewMode:(UITextFieldViewMode)clearButtonViewMode
                  leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                 rightUnderlineLabel:(UILabel *)rightUnderlineLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
    customUnderlineLabelDrawPriority:(CGFloat)normalizedCustomUnderlineLabelDrawPriority
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing {
  CGFloat globalChipRowMinX = isRTL ? kTrailingMargin : kLeadingMargin;
  CGFloat globalChipRowMaxX = isRTL ? size.width - kLeadingMargin : size.width - kTrailingMargin;
  CGFloat maxTextWidth = globalChipRowMaxX - globalChipRowMinX;
  CGRect placeholderFrameNormal =
      [self placeholderFrameWithPlaceholder:placeholder
                                       font:font
                           placeholderState:MDCContainedInputViewPlaceholderStateNormal
                          globalChipRowMinX:globalChipRowMinX
                               maxTextWidth:maxTextWidth
                             conatinerStyle:containerStyle];
  CGRect placeholderFrameFloating =
      [self placeholderFrameWithPlaceholder:placeholder
                                       font:floatingPlaceholderFont
                           placeholderState:MDCContainedInputViewPlaceholderStateFloating
                          globalChipRowMinX:globalChipRowMinX
                               maxTextWidth:maxTextWidth
                             conatinerStyle:containerStyle];

    CGFloat initialChipRowMinY = [containerStyle.densityInformer normalContentAreaTopPadding];
    if (placeholderState == MDCContainedInputViewPlaceholderStateFloating) {
      initialChipRowMinY = [containerStyle.densityInformer
      contentAreaTopPaddingWithFloatingPlaceholderMaxY:CGRectGetMaxY(placeholderFrameFloating)];
    }

//  CGFloat initialChipRowTextFieldMinY =
//      [containerStyle.densityInformer normalContentAreaTopPadding];
//  if (placeholderState == MDCContainedInputViewPlaceholderStateFloating) {
//    initialChipRowTextFieldMinY = [containerStyle.densityInformer
//        contentAreaTopPaddingWithFloatingPlaceholderMaxY:CGRectGetMaxY(placeholderFrameFloating)];
//  }
//  CGFloat textHeight = [self textHeightWithFont:font];
//  CGFloat initialChipRowTextFieldCenterY = initialChipRowTextFieldMinY + (0.5 * textHeight);
//  CGFloat initialChipRowMinY = initialChipRowTextFieldCenterY - (0.5 * chipRowHeight);

  CGSize textFieldSize = [self textSizeWithText:text font:font maxWidth:maxTextWidth];

  NSArray<NSValue *> *chipFrames = [self determineChipFramesWithChips:chips
                                                         canChipsWrap:canChipsWrap
                                                        chipRowHeight:chipRowHeight
                                                     interChipSpacing:interChipSpacing
                                                   initialChipRowMinY:initialChipRowMinY
                                                    globalChipRowMinX:globalChipRowMinX
                                                    globalChipRowMaxX:globalChipRowMaxX
                                                                isRTL:isRTL];

  CGRect textFieldFrame = [self textFieldFrameWithSize:size
                                            chipFrames:chipFrames
                                          canChipsWrap:canChipsWrap
                                         chipRowHeight:chipRowHeight
                                      interChipSpacing:interChipSpacing
                                    initialChipRowMinY:initialChipRowMinY
                                     globalChipRowMinX:globalChipRowMinX
                                     globalChipRowMaxX:globalChipRowMaxX
                                         textFieldSize:textFieldSize
                                                 isRTL:isRTL];

  CGFloat bottomPadding = [containerStyle.densityInformer normalContentAreaBottomPadding];
  CGPoint contentOffset = [self scrollViewContentOffsetWithSize:size
                                                   canChipsWrap:canChipsWrap
                                                  chipRowHeight:chipRowHeight
                                                 textFieldFrame:textFieldFrame
                                             initialChipRowMinY:initialChipRowMinY
                                              globalChipRowMinX:globalChipRowMinX
                                              globalChipRowMaxX:globalChipRowMaxX
                                                  bottomPadding:bottomPadding
                                                          isRTL:isRTL];
  CGSize contentSize = [self scrollViewContentSizeWithSize:size
                                             contentOffset:contentOffset
                                                chipFrames:chipFrames
                                              canChipsWrap:canChipsWrap
                                            textFieldFrame:textFieldFrame];

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

  return;

  //  if (canChipsWrap) {
  //    if (isRTL) {
  //    } else {
  //      NSArray<NSValue *> *chipFrames = [self determineChipFramesWithChips:chips
  //                                                             canChipsWrap:canChipsWrap
  //                                                            chipRowHeight:chipRowHeight
  //                                                       initialChipRowMinY:initialChipRowMinY
  //                                                        globalChipRowMinX:globalChipRowMinX
  //                                                        globalChipRowMaxX:globalChipRowMaxX
  //                                                                    isRTL:isRTL];
  //      CGRect textFieldFrame = [self textFieldFrameWithSize:size
  //                                                chipFrames:chipFrames
  //                                              canChipsWrap:canChipsWrap
  //                                             chipRowHeight:chipRowHeight
  //                                             textFieldSize:textFieldSize
  //                                                     isRTL:isRTL];
  //
  //      CGPoint contentOffset = [self scrollViewContentOffsetWithSize:size
  //                                                       canChipsWrap:canChipsWrap
  //                                                      chipRowHeight:chipRowHeight
  //                                                     textFieldFrame:textFieldFrame
  //                                                              isRTL:isRTL];
  //      CGSize contentSize = [self scrollViewContentSizeWithSize:size
  //                                                 contentOffset:contentOffset
  //                                                    chipFrames:chipFrames
  //                                                  canChipsWrap:canChipsWrap
  //                                                textFieldFrame:textFieldFrame];
  //
  //      //      NSLog(@"content offset: %@ contentSize:
  //      //      %@",NSStringFromCGPoint(contentOffset),NSStringFromCGSize(contentSize));
  //
  //      self.chipFrames = chipFrames;
  //      self.textFieldFrame = textFieldFrame;
  //      self.scrollViewContentOffset = contentOffset;
  //      self.scrollViewContentSize = contentSize;
  //      self.scrollViewContentViewTouchForwardingViewFrame =
  //          CGRectMake(0, 0, contentSize.width, contentSize.height);
  //
  //      // lay out all the chips starting from 0
  //      // lay out the text field after
  //      // determine a content offset that will make it so the text field is visible
  //      // i.e. it's highest possible maxX is less than the bounds.width of input chip view.
  //    }
  //  } else {
  //    if (isRTL) {
  //    } else {
  //      NSArray<NSValue *> *chipFrames = [self determineChipFramesWithSize:size
  //                                                                   chips:chips
  //                                                            canChipsWrap:canChipsWrap
  //                                                           chipRowHeight:chipRowHeight
  //                                                                   isRTL:isRTL];
  //      CGRect textFieldFrame = [self textFieldFrameWithSize:size
  //                                                chipFrames:chipFrames
  //                                              canChipsWrap:canChipsWrap
  //                                             chipRowHeight:chipRowHeight
  //                                             textFieldSize:textFieldSize
  //                                             contentInsets:contentInsets
  //                                                     isRTL:isRTL];
  //      CGPoint contentOffset = [self scrollViewContentOffsetWithSize:size
  //                                                       canChipsWrap:canChipsWrap
  //                                                      chipRowHeight:chipRowHeight
  //                                                     textFieldFrame:textFieldFrame
  //                                                      contentInsets:contentInsets
  //                                                              isRTL:isRTL];
  //      CGSize contentSize = [self scrollViewContentSizeWithSize:size
  //                                                 contentOffset:contentOffset
  //                                                    chipFrames:chipFrames
  //                                                  canChipsWrap:canChipsWrap
  //                                                textFieldFrame:textFieldFrame];
  //
  //      //      NSLog(@"content offset: %@ contentSize:
  //      //      %@",NSStringFromCGPoint(contentOffset),NSStringFromCGSize(contentSize));
  //
  //      self.chipFrames = chipFrames;
  //      self.textFieldFrame = textFieldFrame;
  //      self.scrollViewContentOffset = contentOffset;
  //      self.scrollViewContentSize = contentSize;
  //      self.scrollViewContentViewTouchForwardingViewFrame =
  //          CGRectMake(0, 0, contentSize.width, contentSize.height);
  //
  //      // lay out all the chips starting from 0
  //      // lay out the text field after
  //      // determine a content offset that will make it so the text field is visible
  //      // i.e. it's highest possible maxX is less than the bounds.width of input chip view.
  //    }
  //  }
  //  //  NSLog(@"size: %@",NSStringFromCGSize(self.scrollViewContentSize));
}

- (CGRect)placeholderFrameWithPlaceholder:(NSString *)placeholder
                                     font:(UIFont *)font
                         placeholderState:(MDCContainedInputViewPlaceholderState)placeholderState
                        globalChipRowMinX:(CGFloat)globalChipRowMinX
                             maxTextWidth:(CGFloat)maxTextWidth
                           conatinerStyle:(id<MDCContainedInputViewStyle>)containerStyle {
  CGFloat placeholderHeight = [self textHeightWithFont:font];
  CGFloat placeholderMinX = globalChipRowMinX;
  CGFloat placeholderMinY = 0;
  CGSize placeholderSize = CGSizeZero;
  switch (placeholderState) {
    case MDCContainedInputViewPlaceholderStateFloating:
      placeholderMinX = placeholderMinX + kFloatingPlaceholderXOffset;
      placeholderMinY = [containerStyle.densityInformer
          floatingPlaceholderMinYWithFloatingPlaceholderHeight:placeholderHeight];
      placeholderSize = [self textSizeWithText:placeholder font:font maxWidth:maxTextWidth];
      break;
    case MDCContainedInputViewPlaceholderStateNormal:
      placeholderMinY = [containerStyle.densityInformer normalContentAreaTopPadding];
      placeholderSize = [self textSizeWithText:placeholder font:font maxWidth:maxTextWidth];
      break;
    case MDCContainedInputViewPlaceholderStateNone:
      break;
    default:
      break;
  }
  return CGRectMake(placeholderMinX, placeholderMinY, placeholderSize.width,
                    placeholderSize.height);
}

- (CGFloat)textHeightWithFont:(UIFont *)font {
  return (CGFloat)ceil((double)font.lineHeight);
}

- (NSArray<NSValue *> *)determineChipFramesWithChips:(NSArray<UIView *> *)chips
                                        canChipsWrap:(BOOL)canChipsWrap
                                       chipRowHeight:(CGFloat)chipRowHeight
                                    interChipSpacing:(CGFloat)interChipSpacing
                                  initialChipRowMinY:(CGFloat)initialChipRowMinY
                                   globalChipRowMinX:(CGFloat)globalChipRowMinX
                                   globalChipRowMaxX:(CGFloat)globalChipRowMaxX
                                               isRTL:(BOOL)isRTL {
  NSMutableArray<NSValue *> *frames = [[NSMutableArray alloc] initWithCapacity:chips.count];
  if (canChipsWrap) {
    if (isRTL) {
    } else {
      CGFloat chipMinX = globalChipRowMinX;
      CGFloat chipMidY = initialChipRowMinY + (0.5 * chipRowHeight);
      CGFloat chipMinY = 0;
      CGRect chipFrame = CGRectZero;
      NSInteger row = 0;
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
                     (0.5 * chipRowHeight);
          chipMinY = chipMidY - (0.5 * chipHeight);
          chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
          chipMaxX = CGRectGetMaxX(chipFrame);
        } else {
          chipMinY = chipMidY - (0.5 * chipHeight);
          chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
        }
        chipMinX = chipMaxX + interChipSpacing;
        NSValue *chipFrameValue = [NSValue valueWithCGRect:chipFrame];
        [frames addObject:chipFrameValue];
      }
    }
  } else {
    if (isRTL) {
    } else {
      CGFloat chipMinX = globalChipRowMinX;
      CGFloat chipCenterY = initialChipRowMinY + (chipRowHeight * 0.5);
      for (MDCChipView *chip in chips) {
        CGFloat chipWidth = CGRectGetWidth(chip.frame);
        CGFloat chipHeight = CGRectGetHeight(chip.frame);
        CGFloat chipMinY = chipCenterY - (0.5 * chipHeight);
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
                           canChipsWrap:(BOOL)canChipsWrap
                         textFieldFrame:(CGRect)textFieldFrame {
  if (canChipsWrap) {
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
                    canChipsWrap:(BOOL)canChipsWrap
                   chipRowHeight:(CGFloat)chipRowHeight
                interChipSpacing:(CGFloat)interChipSpacing
              initialChipRowMinY:(CGFloat)initialChipRowMinY
               globalChipRowMinX:(CGFloat)globalChipRowMinX
               globalChipRowMaxX:(CGFloat)globalChipRowMaxX
                   textFieldSize:(CGSize)textFieldSize
                           isRTL:(BOOL)isRTL {
  if (canChipsWrap) {
    if (isRTL) {
    } else {
      CGFloat textFieldMinX = 0;
      CGFloat textFieldMaxX = 0;
      CGFloat textFieldMinY = 0;
      CGFloat textFieldMidY = 0;
      if (chipFrames.count > 0) {
        CGRect lastChipFrame = [[chipFrames lastObject] CGRectValue];
        CGFloat lastChipMidY = CGRectGetMidY(lastChipFrame);
        textFieldMidY = lastChipMidY;
        textFieldMinY = textFieldMidY - (0.5 * textFieldSize.height);
        textFieldMinX = CGRectGetMaxX(lastChipFrame) + interChipSpacing;
        textFieldMaxX = textFieldMinX + textFieldSize.width;
        BOOL textFieldShouldMoveToNextRow = textFieldMaxX > globalChipRowMaxX;
        if (textFieldShouldMoveToNextRow) {
          NSInteger row = [self chipRowWithRect:lastChipFrame
                             initialChipRowMinY:initialChipRowMinY
                                  chipRowHeight:chipRowHeight];
          textFieldMidY =
              initialChipRowMinY + ((CGFloat)(row + 1) * chipRowHeight) + (0.5 * chipRowHeight);
          textFieldMinY = textFieldMidY - (0.5 * textFieldSize.height);
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
        textFieldMidY = initialChipRowMinY + (0.5 * chipRowHeight);
        textFieldMinY = textFieldMidY - (0.5 * textFieldSize.height);
        return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
      }
      //      CGFloat textFieldCenterY = CGRectGetMidY(bounds);
      //      CGFloat textFieldMinY = textFieldCenterY - (0.5 * textFieldSize.height);
      return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
    }
  } else {
    if (isRTL) {
    } else {
      CGFloat textFieldMinX = 0;
      if (chipFrames.count > 0) {
        CGRect lastFrame = [[chipFrames lastObject] CGRectValue];
        textFieldMinX = MDCCeil(CGRectGetMaxX(lastFrame)) + interChipSpacing;
      } else {
        textFieldMinX = globalChipRowMinX;
      }
      CGFloat textFieldCenterY = initialChipRowMinY + (0.5 * chipRowHeight);
      CGFloat textFieldMinY = textFieldCenterY - (0.5 * textFieldSize.height);
      return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
      //      CGFloat textFieldMaxX = CGRectGetMaxX(bounds) - contentInsets.right;
      //      CGFloat textFieldWidth = textFieldMaxX - textFieldMinX;
      //      return CGRectMake(textFieldMinX, textFieldMinY, textFieldWidth, chipRowHeight);
    }
  }
  return CGRectZero;
}

- (CGPoint)scrollViewContentOffsetWithSize:(CGSize)size
                              canChipsWrap:(BOOL)canChipsWrap
                             chipRowHeight:(CGFloat)chipRowHeight
                            textFieldFrame:(CGRect)textFieldFrame
                        initialChipRowMinY:(CGFloat)initialChipRowMinY
                         globalChipRowMinX:(CGFloat)globalChipRowMinX
                         globalChipRowMaxX:(CGFloat)globalChipRowMaxX
                             bottomPadding:(CGFloat)bottomPadding
                                     isRTL:(BOOL)isRTL {
  CGPoint contentOffset = CGPointZero;
  if (canChipsWrap) {
    if (isRTL) {
    } else {
      NSInteger row = [self chipRowWithRect:textFieldFrame
                         initialChipRowMinY:initialChipRowMinY
                              chipRowHeight:chipRowHeight];
      CGFloat lastRowMaxY = initialChipRowMinY + ((row + 1) * chipRowHeight);
      CGFloat boundsMaxY = size.height;
      if (lastRowMaxY > boundsMaxY) {
        CGFloat difference = lastRowMaxY - boundsMaxY;
        contentOffset = CGPointMake(0, (difference + bottomPadding));
      }
    }
  } else {
    if (isRTL) {
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
               chipRowHeight:(CGFloat)chipRowHeight {
  CGFloat viewMidY = CGRectGetMidY(rect);
  CGFloat midYAdjustedForContentInset = MDCRound(viewMidY - initialChipRowMinY);
  NSInteger row = (NSInteger)midYAdjustedForContentInset / (NSInteger)chipRowHeight;
  return row;
}

@end
