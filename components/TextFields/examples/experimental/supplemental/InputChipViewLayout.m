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

#import "InputChipView.h"
#import <MaterialComponents/MaterialMath.h>

static const CGFloat kEstimatedCursorWidth = (CGFloat)2.0;
static const CGFloat kInterChipPadding = (CGFloat)5.0;


@interface InputChipViewLayout ()

@end

@implementation InputChipViewLayout

- (instancetype)initWithBounds:(CGRect)bounds
                         chips:(NSArray<MDCChipView *> *)chips
                  canChipsWrap:(BOOL)canChipsWrap
                 textFieldText:(NSString *)textFieldText
                 textFieldFont:(UIFont *)textFieldFont
                 contentInsets:(UIEdgeInsets)contentInsets
                         isRTL:(BOOL)isRTL
{
  self = [super init];
  if (self) {
    [self calculateLayoutWithBounds:bounds
                              chips:chips
                       canChipsWrap:canChipsWrap
                      TextFieldText:textFieldText
                      textFieldFont:textFieldFont
                      contentInsets:(UIEdgeInsets)contentInsets
                              isRTL:isRTL];
  }
  return self;
}

- (void)calculateLayoutWithBounds:(CGRect)bounds
                            chips:(NSArray<MDCChipView *> *)chips
                     canChipsWrap:(BOOL)canChipsWrap
                    TextFieldText:(NSString *)textFieldText
                    textFieldFont:(UIFont *)textFieldFont
                    contentInsets:(UIEdgeInsets)contentInsets
                            isRTL:(BOOL)isRTL
{
  if (canChipsWrap) {
    if (isRTL) {
    } else {
    }
  } else {
    CGSize textFieldSize = [self textFieldSizeWithTextFieldText:textFieldText
                                                  textFieldFont:textFieldFont
                                                   canChipsWrap:canChipsWrap];
    if (isRTL) {


    } else {
      NSArray<NSValue *> *chipFrames = [self determineChipFramesWithBounds:bounds
                                                                     chips:chips
                                                              canChipsWrap:canChipsWrap
                                                             contentInsets:contentInsets
                                                                     isRTL:isRTL];
      CGRect textFieldFrame = [self textFieldFrameWithBounds:bounds
                                                  chipFrames:chipFrames
                                                canChipsWrap:canChipsWrap
                                               textFieldSize:textFieldSize];
      CGSize contentSize = [self scrollViewContentSizeWithBounds:bounds
                                                      chipFrames:chipFrames
                                                    canChipsWrap:canChipsWrap
                                                  textFieldFrame:textFieldFrame];
      CGPoint contentOffset = [self scrollViewContentOffsetWithBounds:bounds
                                                       textFieldFrame:textFieldFrame
                                                        contentInsets:contentInsets];

      self.chipFrames = chipFrames;
      self.textFieldFrame = textFieldFrame;
      self.scrollViewContentOffset = contentOffset;
      self.scrollViewContentSize = contentSize;
      
      // lay out all the chips starting from 0
      // lay out the text field after
      // determine a content offset that will make it so the text field is visible
      // i.e. it's highest possible maxX is less than the bounds.width of input chip view.
    }


  }
}

- (NSArray<NSValue *> *)determineChipFramesWithBounds:(CGRect)bounds
                                                chips:(NSArray<MDCChipView *> *)chips
                                         canChipsWrap:(BOOL)canChipsWrap
                                        contentInsets:(UIEdgeInsets)contentInsets
                                                isRTL:(BOOL)isRTL {
  NSMutableArray<NSValue *> *frames = [[NSMutableArray alloc] initWithCapacity:chips.count];
  if (canChipsWrap) {
    if (isRTL) {

    } else {

    }
  } else {
    if (isRTL) {

    } else {
      CGFloat chipMinX = contentInsets.left;
      CGFloat chipCenterY = CGRectGetMidY(bounds);
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

- (CGSize)textFieldSizeWithTextFieldText:(NSString *)textFieldText
                           textFieldFont:(UIFont *)textFieldFont
                            canChipsWrap:(BOOL)canChipsWrap {
  if (canChipsWrap) {

  } else {
    if (!textFieldFont) {
      return CGSizeZero;
    }
    CGSize fittingSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    NSDictionary *attributes = @{NSFontAttributeName : textFieldFont};
    CGRect rect = [textFieldText boundingRectWithSize:fittingSize
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    rect.size.width = MDCCeil(CGRectGetWidth(rect)) + kEstimatedCursorWidth;
    rect.size.height = MDCCeil(CGRectGetHeight(rect));
    return rect.size;
  }
  return CGSizeZero;
}

- (CGSize)scrollViewContentSizeWithBounds:(CGRect)bounds
                               chipFrames:(NSArray<NSValue *> *)chipFrames
                             canChipsWrap:(BOOL)canChipsWrap
                            textFieldFrame:(CGRect)textFieldFrame {
  CGFloat totalMinX = 0;
  CGFloat totalMaxX = 0;
  CGFloat totalMinY = 0;
  CGFloat totalMaxY = 0;
  NSValue *textFieldFrameValue = [NSValue valueWithCGRect:textFieldFrame];
  NSArray *allFrames = [chipFrames arrayByAddingObject:textFieldFrameValue];
  for (NSUInteger index = 0; index < allFrames.count; index++) {
    NSValue *frameValue = allFrames[index];
    CGRect frame = frameValue.CGRectValue;
    if (index == 0) {
      totalMinX = CGRectGetMinX(frame);
      totalMaxX = CGRectGetMaxX(frame);
      totalMinY = CGRectGetMinY(frame);
      totalMaxY = CGRectGetMaxY(frame);
    } else {
      CGFloat minX = CGRectGetMinX(frame);
      CGFloat maxX = CGRectGetMaxX(frame);
      CGFloat minY = CGRectGetMinY(frame);
      CGFloat maxY = CGRectGetMaxY(frame);
      if (minX < totalMinX) {
        totalMinX = minX;
      }
      if (minY < totalMinY) {
        totalMinY = minY;
      }
      if (maxX > totalMaxX) {
        totalMaxX = maxX;
      }
      if (maxY > totalMaxY) {
        totalMaxY = maxY;
      }
    }
  }
  CGFloat width = totalMaxX - totalMinX;
  CGFloat height = totalMaxY - totalMinY;
  return CGSizeMake(width, height);
}

- (CGRect)textFieldFrameWithBounds:(CGRect)bounds
                        chipFrames:(NSArray<NSValue *> *)chipFrames
                      canChipsWrap:(BOOL)canChipsWrap
                     textFieldSize:(CGSize)textFieldSize {
  if (canChipsWrap) {
    
  } else {
    CGFloat textFieldMinX = 0;// this should be content inset
    if (chipFrames.count > 0) {
      CGRect lastFrame = [[chipFrames lastObject] CGRectValue];
      textFieldMinX = MDCCeil(CGRectGetMaxX(lastFrame)) + kInterChipPadding;
    }
    CGFloat textFieldCenterY = CGRectGetMidY(bounds);
    CGFloat textFieldMinY = textFieldCenterY - (0.5 * textFieldSize.height);
    return CGRectMake(textFieldMinX, textFieldMinY, textFieldSize.width, textFieldSize.height);
  }
  return CGRectZero;
}

- (CGPoint)scrollViewContentOffsetWithBounds:(CGRect)bounds
                              textFieldFrame:(CGRect)textFieldFrame
                               contentInsets:(UIEdgeInsets)contentInsets {
  CGFloat textFieldMinX = CGRectGetMinX(textFieldFrame);
  CGFloat textFieldMaxX = CGRectGetMaxX(textFieldFrame);
  CGFloat lowestPossibleTextFieldMinX = contentInsets.left;
  CGFloat highestPossibleTextFieldMaxX = CGRectGetWidth(bounds) - contentInsets.right;
  if (textFieldMaxX > highestPossibleTextFieldMaxX) {
    CGFloat difference = textFieldMaxX - highestPossibleTextFieldMaxX;
    return CGPointMake(difference, 0);
  } else if (textFieldMinX < lowestPossibleTextFieldMinX) {
    CGFloat difference = lowestPossibleTextFieldMinX - textFieldMinX;
    return CGPointMake((-1 * difference), 0);
  }
  return CGPointZero;
}

@end
