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
static const CGFloat kInterChipPadding = (CGFloat)8.0;

@interface InputChipViewLayout ()
@end

@implementation InputChipViewLayout

- (instancetype)initWithSize:(CGSize)size
                      containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                                text:(NSString *)text
                         placeholder:(NSString *)placeholder
                                font:(UIFont *)font
             floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                 canPlaceholderFloat:(BOOL)canPlaceholderFloat
                               chips:(NSArray<UIView *> *)chips
                      staleChipViews:(NSArray<UIView *> *)staleChipViews
                        canChipsWrap:(BOOL)canChipsWrap
                       chipRowHeight:(CGFloat)chipRowHeight
                       contentInsets:(UIEdgeInsets)contentInsets
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
                     canPlaceholderFloat:canPlaceholderFloat
                                   chips:chips
                          staleChipViews:staleChipViews
                            canChipsWrap:canChipsWrap
                           chipRowHeight:chipRowHeight
                           contentInsets:contentInsets
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
                 canPlaceholderFloat:(BOOL)canPlaceholderFloat
                               chips:(NSArray<UIView *> *)chips
                      staleChipViews:(NSArray<UIView *> *)staleChipViews
                        canChipsWrap:(BOOL)canChipsWrap
                       chipRowHeight:(CGFloat)chipRowHeight
                       contentInsets:(UIEdgeInsets)contentInsets
                         clearButton:(UIButton *)clearButton
                 clearButtonViewMode:(UITextFieldViewMode)clearButtonViewMode
                  leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                 rightUnderlineLabel:(UILabel *)rightUnderlineLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewUnderlineLabelDrawPriority)underlineLabelDrawPriority
    customUnderlineLabelDrawPriority:(CGFloat)normalizedCustomUnderlineLabelDrawPriority
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing {
//  CGFloat floatingPlaceholderHeight =
//      canPlaceholderFloat ? [self textHeightWithFont:floatingPlaceholderFont] : 0;
//  CGFloat floatingPlaceholderMinY = [containerStyle.densityInformer floatingPlaceholderMinYWithFloatingPlaceholderHeight:floatingPlaceholderHeight];
//  CGFloat textRectHeight = [self textHeightWithFont:font];

  CGSize textFieldSize = [self textSizeWithViewSize:size
                                      contentInsets:contentInsets
                                               text:text
                                      textFieldFont:font
                                       canChipsWrap:canChipsWrap
                                      chipRowHeight:chipRowHeight];
//  CGSize placeholderLabelSize = [self textSizeWithViewSize:size
//                                             contentInsets:contentInsets
//                                                      text:placeholder
//                                             textFieldFont:font
//                                              canChipsWrap:canChipsWrap
//                                             chipRowHeight:chipRowHeight];
  if (canChipsWrap) {
    if (isRTL) {
    } else {
      NSArray<NSValue *> *chipFrames = [self determineChipFramesWithSize:size
                                                                   chips:chips
                                                            canChipsWrap:canChipsWrap
                                                           chipRowHeight:chipRowHeight
                                                           contentInsets:contentInsets
                                                                   isRTL:isRTL];
      CGRect textFieldFrame = [self textFieldFrameWithSize:size
                                                chipFrames:chipFrames
                                              canChipsWrap:canChipsWrap
                                             chipRowHeight:chipRowHeight
                                             textFieldSize:textFieldSize
                                             contentInsets:contentInsets
                                                     isRTL:isRTL];

      CGPoint contentOffset = [self scrollViewContentOffsetWithSize:size
                                                       canChipsWrap:canChipsWrap
                                                      chipRowHeight:chipRowHeight
                                                     textFieldFrame:textFieldFrame
                                                      contentInsets:contentInsets
                                                              isRTL:isRTL];
      CGSize contentSize = [self scrollViewContentSizeWithSize:size
                                                 contentOffset:contentOffset
                                                    chipFrames:chipFrames
                                                  canChipsWrap:canChipsWrap
                                                textFieldFrame:textFieldFrame];

      //      NSLog(@"content offset: %@ contentSize:
      //      %@",NSStringFromCGPoint(contentOffset),NSStringFromCGSize(contentSize));

      self.chipFrames = chipFrames;
      self.textFieldFrame = textFieldFrame;
      self.scrollViewContentOffset = contentOffset;
      self.scrollViewContentSize = contentSize;
      self.scrollViewContentViewTouchForwardingView =
          CGRectMake(0, 0, contentSize.width, contentSize.height);

      // lay out all the chips starting from 0
      // lay out the text field after
      // determine a content offset that will make it so the text field is visible
      // i.e. it's highest possible maxX is less than the bounds.width of input chip view.
    }
  } else {
    if (isRTL) {
    } else {
      NSArray<NSValue *> *chipFrames = [self determineChipFramesWithSize:size
                                                                   chips:chips
                                                            canChipsWrap:canChipsWrap
                                                           chipRowHeight:chipRowHeight
                                                           contentInsets:contentInsets
                                                                   isRTL:isRTL];
      CGRect textFieldFrame = [self textFieldFrameWithSize:size
                                                chipFrames:chipFrames
                                              canChipsWrap:canChipsWrap
                                             chipRowHeight:chipRowHeight
                                             textFieldSize:textFieldSize
                                             contentInsets:contentInsets
                                                     isRTL:isRTL];
      CGPoint contentOffset = [self scrollViewContentOffsetWithSize:size
                                                       canChipsWrap:canChipsWrap
                                                      chipRowHeight:chipRowHeight
                                                     textFieldFrame:textFieldFrame
                                                      contentInsets:contentInsets
                                                              isRTL:isRTL];
      CGSize contentSize = [self scrollViewContentSizeWithSize:size
                                                 contentOffset:contentOffset
                                                    chipFrames:chipFrames
                                                  canChipsWrap:canChipsWrap
                                                textFieldFrame:textFieldFrame];

      //      NSLog(@"content offset: %@ contentSize:
      //      %@",NSStringFromCGPoint(contentOffset),NSStringFromCGSize(contentSize));

      self.chipFrames = chipFrames;
      self.textFieldFrame = textFieldFrame;
      self.scrollViewContentOffset = contentOffset;
      self.scrollViewContentSize = contentSize;
      self.scrollViewContentViewTouchForwardingView =
          CGRectMake(0, 0, contentSize.width, contentSize.height);

      // lay out all the chips starting from 0
      // lay out the text field after
      // determine a content offset that will make it so the text field is visible
      // i.e. it's highest possible maxX is less than the bounds.width of input chip view.
    }
  }
  //  NSLog(@"size: %@",NSStringFromCGSize(self.scrollViewContentSize));
}

- (CGFloat)textHeightWithFont:(UIFont *)font {
  return (CGFloat)ceil((double)font.lineHeight);
}


- (NSArray<NSValue *> *)determineChipFramesWithSize:(CGSize)size
                                              chips:(NSArray<UIView *> *)chips
                                       canChipsWrap:(BOOL)canChipsWrap
                                      chipRowHeight:(CGFloat)chipRowHeight
                                      contentInsets:(UIEdgeInsets)contentInsets
                                              isRTL:(BOOL)isRTL {
  NSMutableArray<NSValue *> *frames = [[NSMutableArray alloc] initWithCapacity:chips.count];
  if (canChipsWrap) {
    if (isRTL) {
    } else {
      CGFloat highestDesirableSubviewMaxX = size.width - contentInsets.right;
      CGFloat chipMinX = contentInsets.left;
      CGFloat chipMidY = contentInsets.top + (0.5 * chipRowHeight);
      CGFloat chipMinY = 0;
      CGRect chipFrame = CGRectZero;
      NSInteger row = 0;
      for (MDCChipView *chip in chips) {
        CGFloat chipWidth = CGRectGetWidth(chip.frame);
        CGFloat chipHeight = CGRectGetHeight(chip.frame);
        CGFloat chipMaxX = chipMinX + chipWidth;
        BOOL chipIsTooLong = chipMaxX > highestDesirableSubviewMaxX;
        BOOL firstChipInRow = chipMinX == contentInsets.left;
        BOOL isNewRow = chipIsTooLong && !firstChipInRow;
        if (isNewRow) {
          row++;
          chipMinX = contentInsets.left;
          chipMidY = contentInsets.top + (row * chipRowHeight) + (0.5 * chipRowHeight);
          chipMinY = chipMidY - (0.5 * chipHeight);
          chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
          chipMaxX = CGRectGetMaxX(chipFrame);
        } else {
          chipMinY = chipMidY - (0.5 * chipHeight);
          chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
        }
        chipMinX = chipMaxX + kInterChipPadding;
        NSValue *chipFrameValue = [NSValue valueWithCGRect:chipFrame];
        [frames addObject:chipFrameValue];
      }
    }
  } else {
    if (isRTL) {
    } else {
      CGFloat chipMinX = contentInsets.left;
      CGFloat chipCenterY = size.height * 0.5;
      for (MDCChipView *chip in chips) {
        CGFloat chipWidth = CGRectGetWidth(chip.frame);
        CGFloat chipHeight = CGRectGetHeight(chip.frame);
        CGFloat chipMinY = chipCenterY - (0.5 * chipHeight);
        CGRect chipFrame = CGRectMake(chipMinX, chipMinY, chipWidth, chipHeight);
        NSValue *chipFrameValue = [NSValue valueWithCGRect:chipFrame];
        [frames addObject:chipFrameValue];
        CGFloat chipMaxX = MDCCeil(CGRectGetMaxX(chipFrame));
        chipMinX = chipMaxX + kInterChipPadding;
      }
    }
  }
  return [frames copy];
}

- (CGSize)textSizeWithViewSize:(CGSize)size
                  contentInsets:(UIEdgeInsets)contentInsets
                           text:(NSString *)text
                  textFieldFont:(UIFont *)textFieldFont
                   canChipsWrap:(BOOL)canChipsWrap
                  chipRowHeight:(CGFloat)chipRowHeight {
  CGSize fittingSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
  NSDictionary *attributes = @{NSFontAttributeName : textFieldFont};

  CGRect rect = [text boundingRectWithSize:fittingSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:attributes
                                   context:nil];
  CGFloat maxTextFieldWidth = size.width - contentInsets.left - contentInsets.right;
  CGFloat maxTextFieldHeight = size.height;
  if (canChipsWrap) {
    if (chipRowHeight > 0) {
      maxTextFieldHeight = chipRowHeight;
    } else {
      maxTextFieldHeight = textFieldFont.lineHeight * 2;
    }
  }
  CGFloat textFieldWidth = MDCCeil(CGRectGetWidth(rect)) + kEstimatedCursorWidth;
  CGFloat textFieldHeight = MDCCeil(CGRectGetHeight(rect));
  if (textFieldWidth > maxTextFieldWidth) {
    textFieldWidth = maxTextFieldWidth;
  }
  if (textFieldHeight > maxTextFieldHeight) {
    textFieldHeight = chipRowHeight;
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
                   textFieldSize:(CGSize)textFieldSize
                   contentInsets:(UIEdgeInsets)contentInsets
                           isRTL:(BOOL)isRTL {
  if (canChipsWrap) {
    if (isRTL) {
    } else {
      CGFloat textFieldMinX = 0;
      CGFloat textFieldMaxX = 0;
      CGFloat textFieldMinY = 0;
      CGFloat textFieldMidY = 0;
      if (chipFrames.count > 0) {
        CGFloat highestPossibleTextFieldMaxX = size.width - contentInsets.right;
        CGRect lastChipFrame = [[chipFrames lastObject] CGRectValue];
        CGFloat lastChipMidY = CGRectGetMidY(lastChipFrame);
        textFieldMidY = lastChipMidY;
        textFieldMinY = textFieldMidY - (0.5 * textFieldSize.height);
        textFieldMinX = CGRectGetMaxX(lastChipFrame) + kInterChipPadding;
        textFieldMaxX = textFieldMinX + textFieldSize.width;
        BOOL textFieldShouldMoveToNextRow = textFieldMaxX > highestPossibleTextFieldMaxX;
        if (textFieldShouldMoveToNextRow) {
          NSInteger row = [self chipRowWithRect:lastChipFrame
                                  contentInsets:contentInsets
                                  chipRowHeight:chipRowHeight];
          textFieldMidY =
              contentInsets.top + ((CGFloat)(row + 1) * chipRowHeight) + (0.5 * chipRowHeight);
          textFieldMinY = textFieldMidY - (0.5 * textFieldSize.height);
          textFieldMinX = contentInsets.left;
          textFieldMaxX = textFieldMinX + textFieldSize.width;
          BOOL textFieldIsStillTooBig = textFieldMaxX > highestPossibleTextFieldMaxX;
          if (textFieldIsStillTooBig) {
            CGFloat difference = textFieldMaxX - highestPossibleTextFieldMaxX;
            textFieldSize.width = textFieldSize.width - difference;
          }
        }
        return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
      } else {
        textFieldMinX = contentInsets.left;
        textFieldMidY = contentInsets.top + (0.5 * chipRowHeight);
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
        textFieldMinX = MDCCeil(CGRectGetMaxX(lastFrame)) + kInterChipPadding;
      } else {
        textFieldMinX = contentInsets.left;
      }
      CGFloat textFieldCenterY = size.height * 0.5;
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
                             contentInsets:(UIEdgeInsets)contentInsets
                                     isRTL:(BOOL)isRTL {
  CGPoint contentOffset = CGPointZero;
  if (canChipsWrap) {
    if (isRTL) {
    } else {
      NSInteger row = [self chipRowWithRect:textFieldFrame
                              contentInsets:contentInsets
                              chipRowHeight:chipRowHeight];
      CGFloat lastRowMaxY = contentInsets.top + ((row + 1) * chipRowHeight);
      CGFloat boundsMaxY = size.height;
      if (lastRowMaxY > boundsMaxY) {
        CGFloat difference = lastRowMaxY - boundsMaxY;
        contentOffset = CGPointMake(0, (difference + contentInsets.bottom));
      }
    }
  } else {
    if (isRTL) {
    } else {
      CGFloat textFieldMinX = CGRectGetMinX(textFieldFrame);
      CGFloat textFieldMaxX = CGRectGetMaxX(textFieldFrame);

      CGFloat lowestPossibleTextFieldMinX = contentInsets.left;
      CGFloat highestPossibleTextFieldMaxX = size.width - contentInsets.right;
      if (textFieldMaxX > highestPossibleTextFieldMaxX) {
        CGFloat difference = textFieldMaxX - highestPossibleTextFieldMaxX;
        contentOffset = CGPointMake(difference, 0);
      } else if (textFieldMinX < lowestPossibleTextFieldMinX) {
        CGFloat difference = lowestPossibleTextFieldMinX - textFieldMinX;
        contentOffset = CGPointMake((-1 * difference), 0);
      }
    }
  }
  return contentOffset;
}

- (NSInteger)chipRowWithRect:(CGRect)rect
               contentInsets:(UIEdgeInsets)contentInsets
               chipRowHeight:(CGFloat)chipRowHeight {
  CGFloat viewMidY = CGRectGetMidY(rect);
  CGFloat midYAdjustedForContentInset = MDCRound(viewMidY - contentInsets.top);
  NSInteger row = (NSInteger)midYAdjustedForContentInset / (NSInteger)chipRowHeight;
  return row;
}

@end
