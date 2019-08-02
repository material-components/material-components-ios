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

#import "MDCBaseTextAreaLayout.h"

#import <MDFInternationalization/MDFInternationalization.h>
#import "MDCBaseInputChipView.h"
#import "MaterialMath.h"

static const CGFloat kEstimatedCursorWidth = (CGFloat)2.0;

static const CGFloat kLeadingMargin = (CGFloat)8.0;
static const CGFloat kTrailingMargin = (CGFloat)8.0;

static const CGFloat kFloatingLabelXOffset = (CGFloat)3.0;

static const CGFloat kGradientBlurLength = 6;

@interface MDCBaseTextAreaLayout ()

@property(nonatomic, assign) CGFloat calculatedHeight;
@property(nonatomic, assign) CGFloat minimumHeight;
@property(nonatomic, assign) CGFloat contentAreaMaxY;

@end

@implementation MDCBaseTextAreaLayout

- (instancetype)initWithSize:(CGSize)size
                     containerStyler:(id<MDCContainedInputViewStyler>)containerStyler
                                text:(NSString *)text
                                font:(UIFont *)font
                        floatingFont:(UIFont *)floatingFont
                               label:(UILabel *)label
                          labelState:(MDCContainedInputViewLabelState)labelState
                  leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                 rightAssistiveLabel:(UILabel *)rightAssistiveLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)normalizedCustomAssistiveLabelDrawPriority
            preferredContainerHeight:(CGFloat)preferredContainerHeight
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithSize:size
                         containerStyler:containerStyler
                                    text:text
                                    font:font
                            floatingFont:floatingFont
                                   label:label
                              labelState:labelState
                      leftAssistiveLabel:leftAssistiveLabel
                     rightAssistiveLabel:rightAssistiveLabel
              underlineLabelDrawPriority:underlineLabelDrawPriority
        customAssistiveLabelDrawPriority:normalizedCustomAssistiveLabelDrawPriority
                preferredContainerHeight:preferredContainerHeight
                                   isRTL:isRTL
                               isEditing:isEditing];
  }
  return self;
}

- (void)calculateLayoutWithSize:(CGSize)size
                     containerStyler:(id<MDCContainedInputViewStyler>)containerStyler
                                text:(NSString *)text
                                font:(UIFont *)font
                        floatingFont:(UIFont *)floatingFont
                               label:(UILabel *)label
                          labelState:(MDCContainedInputViewLabelState)labelState
                  leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                 rightAssistiveLabel:(UILabel *)rightAssistiveLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)normalizedCustomAssistiveLabelDrawPriority
            preferredContainerHeight:(CGFloat)preferredContainerHeight
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing {
  CGFloat globalTextMinX = isRTL ? kTrailingMargin : kLeadingMargin;
  CGFloat globalTextMaxX = isRTL ? size.width - kLeadingMargin : size.width - kTrailingMargin;
  CGRect floatingLabelFrame = [self floatingLabelFrameWithText:label.text
                                                          font:font
                                                  floatingFont:floatingFont
                                                globalTextMinX:globalTextMinX
                                                globalTextMaxX:globalTextMaxX
                                      preferredContainerHeight:preferredContainerHeight
                                               containerStyler:containerStyler
                                                         isRTL:isRTL];
  CGFloat floatingLabelMaxY = CGRectGetMaxY(floatingLabelFrame);
  CGFloat heightToCalculateNormalLabelMinY =
      [containerStyler.positioningDelegate defaultContainerHeightWithTextHeight:font.lineHeight];
  CGFloat textViewMinYWithFloatingLabel = [containerStyler.positioningDelegate
      textMinYWithFloatingLabelWithTextHeight:font.lineHeight
                          floatingLabelHeight:floatingFont.lineHeight
                     preferredContainerHeight:heightToCalculateNormalLabelMinY];
  CGFloat textViewFirstLineMaxYWithFloatingLabel = textViewMinYWithFloatingLabel + font.lineHeight;

  CGFloat bottomPadding = 0;
  CGFloat contentAreaMaxY = 0;
  CGFloat defaultContainerHeight =
      [containerStyler.positioningDelegate defaultContainerHeightWithTextHeight:font.lineHeight];
  if (preferredContainerHeight > 0) {
    contentAreaMaxY = preferredContainerHeight;
  } else {
    contentAreaMaxY = defaultContainerHeight;
  }
  bottomPadding = defaultContainerHeight - textViewFirstLineMaxYWithFloatingLabel;

  CGRect normalLabelFrame = [self normalLabelFrameWithFloatingLabelFrame:floatingLabelFrame
                                                             placeholder:label.text
                                                                    font:font
                                                            floatingFont:floatingFont
                                                          globalTextMinX:globalTextMinX
                                                          globalTextMaxX:globalTextMaxX
                                                           chipRowHeight:font.lineHeight
                                                preferredContainerHeight:preferredContainerHeight
                                                       contentAreaHeight:contentAreaMaxY
                                                         containerStyler:containerStyler
                                                                   isRTL:isRTL];

  CGFloat textViewMinYNormal = CGRectGetMidY(normalLabelFrame) - ((CGFloat)0.5 * font.lineHeight);
  CGFloat textViewMinY = textViewMinYNormal;
  if (labelState == MDCContainedInputViewLabelStateFloating) {
    textViewMinY = textViewMinYWithFloatingLabel;
  }

  CGSize scrollViewSize = CGSizeMake(size.width, contentAreaMaxY);

  CGFloat textViewHeight = contentAreaMaxY - bottomPadding - textViewMinYWithFloatingLabel;
  CGRect textViewFrame = CGRectMake(globalTextMinX, textViewMinYWithFloatingLabel,
                                    globalTextMaxX - globalTextMinX, textViewHeight);

  CGPoint contentOffset = [self scrollViewContentOffsetWithSize:scrollViewSize
                                                  textViewFrame:textViewFrame
                                                   textViewMinY:textViewMinY
                                                 globalTextMinX:globalTextMinX
                                                 globalTextMaxX:globalTextMaxX
                                                  bottomPadding:bottomPadding
                                                          isRTL:isRTL];
  CGSize contentSize = [self scrollViewContentSizeWithSize:scrollViewSize
                                             contentOffset:contentOffset
                                             textViewFrame:textViewFrame];

  self.contentAreaMaxY = contentAreaMaxY;
  self.textViewFrame = textViewFrame;
  self.scrollViewContentOffset = contentOffset;
  self.scrollViewContentSize = contentSize;
  self.scrollViewContentViewTouchForwardingViewFrame =
      CGRectMake(0, 0, contentSize.width, contentSize.height);
  self.floatingLabelFrame = floatingLabelFrame;
  self.normalLabelFrame = normalLabelFrame;
  self.globalTextMinX = globalTextMinX;
  self.globalTextMaxX = globalTextMaxX;
  CGRect scrollViewRect = CGRectMake(0, 0, size.width, contentAreaMaxY);
  self.maskedScrollViewContainerViewFrame = scrollViewRect;
  self.scrollViewFrame = scrollViewRect;

  self.horizontalGradientLocations =
      [self determineHorizontalGradientLocationsWithGlobalTextMinX:globalTextMinX
                                                    globalTextMaxX:globalTextMaxX
                                                         viewWidth:size.width
                                                        viewHeight:contentAreaMaxY];
  self.verticalGradientLocations = [self
      determineVerticalGradientLocationsWithGlobalTextMinX:globalTextMinX
                                            globalTextMaxX:globalTextMaxX
                                                 viewWidth:size.width
                                                viewHeight:contentAreaMaxY
                                         floatingLabelMaxY:floatingLabelMaxY
                                             bottomPadding:bottomPadding
                                       positioningDelegate:containerStyler.positioningDelegate];
  return;
}

- (CGFloat)calculatedHeight {
  CGFloat maxY = 0;
  CGFloat floatingLabelFrameMaxY = CGRectGetMaxY(self.floatingLabelFrame);
  if (floatingLabelFrameMaxY > maxY) {
    maxY = floatingLabelFrameMaxY;
  }
  CGFloat normalLabelFrameMaxY = CGRectGetMaxY(self.normalLabelFrame);
  if (floatingLabelFrameMaxY > maxY) {
    maxY = normalLabelFrameMaxY;
  }
  CGFloat textRectMaxY = self.contentAreaMaxY;
  if (textRectMaxY > maxY) {
    maxY = textRectMaxY;
  }
  CGFloat leftAssistiveLabelFrameMaxY = CGRectGetMaxY(self.leftAssistiveLabelFrame);
  if (leftAssistiveLabelFrameMaxY > maxY) {
    maxY = leftAssistiveLabelFrameMaxY;
  }
  CGFloat rightAssistiveLabelFrameMaxY = CGRectGetMaxY(self.rightAssistiveLabelFrame);
  if (rightAssistiveLabelFrameMaxY > maxY) {
    maxY = rightAssistiveLabelFrameMaxY;
  }
  return maxY;
}

- (CGRect)normalLabelFrameWithFloatingLabelFrame:(CGRect)floatingLabelFrame
                                     placeholder:(NSString *)placeholder
                                            font:(UIFont *)font
                                    floatingFont:(UIFont *)floatingFont
                                  globalTextMinX:(CGFloat)globalTextMinX
                                  globalTextMaxX:(CGFloat)globalTextMaxX
                                   chipRowHeight:(CGFloat)chipRowHeight
                        preferredContainerHeight:(CGFloat)preferredContainerHeight
                               contentAreaHeight:(CGFloat)contentAreaHeight
                                 containerStyler:(id<MDCContainedInputViewStyler>)containerStyler
                                           isRTL:(BOOL)isRTL {
  CGFloat maxTextWidth = globalTextMaxX - globalTextMinX;
  CGSize placeholderSize = [self textSizeWithText:placeholder font:font maxWidth:maxTextWidth];
  CGFloat placeholderMinX = globalTextMinX;
  if (isRTL) {
    placeholderMinX = globalTextMaxX - placeholderSize.width;
  }
  CGFloat placeholderMinY = 0;
  CGFloat heightToCalculateNormalLabelMinY =
      [containerStyler.positioningDelegate defaultContainerHeightWithTextHeight:chipRowHeight];
  if (preferredContainerHeight < heightToCalculateNormalLabelMinY) {
    heightToCalculateNormalLabelMinY = preferredContainerHeight;
  }
  placeholderMinY = [containerStyler.positioningDelegate
      textMinYWithFloatingLabelWithTextHeight:chipRowHeight
                          floatingLabelHeight:floatingFont.lineHeight
                     preferredContainerHeight:heightToCalculateNormalLabelMinY];
  return CGRectMake(placeholderMinX, placeholderMinY, placeholderSize.width,
                    placeholderSize.height);
}

- (CGRect)floatingLabelFrameWithText:(NSString *)text
                                font:(UIFont *)font
                        floatingFont:(UIFont *)floatingFont
                      globalTextMinX:(CGFloat)globalTextMinX
                      globalTextMaxX:(CGFloat)globalTextMaxX
            preferredContainerHeight:(CGFloat)preferredContainerHeight
                     containerStyler:(id<MDCContainedInputViewStyler>)containerStyler
                               isRTL:(BOOL)isRTL {
  CGFloat maxTextWidth = globalTextMaxX - globalTextMinX - kFloatingLabelXOffset;
  CGSize floatingLabelSize = [self textSizeWithText:text font:floatingFont maxWidth:maxTextWidth];
  CGFloat heightToCalculateFloatingLabelMinY =
      [containerStyler.positioningDelegate defaultContainerHeightWithTextHeight:font.lineHeight];
  if (preferredContainerHeight < heightToCalculateFloatingLabelMinY) {
    heightToCalculateFloatingLabelMinY = preferredContainerHeight;
  }
  CGFloat textMinY = [containerStyler.positioningDelegate
      floatingLabelMinYWithTextHeight:font.lineHeight
                  floatingLabelHeight:floatingFont.lineHeight
             preferredContainerHeight:heightToCalculateFloatingLabelMinY];

  CGFloat textMinX = globalTextMinX + kFloatingLabelXOffset;
  if (isRTL) {
    textMinX = globalTextMaxX - kFloatingLabelXOffset - floatingLabelSize.width;
  }
  return CGRectMake(textMinX, textMinY, floatingLabelSize.width, floatingLabelSize.height);
}

- (CGFloat)textHeightWithFont:(UIFont *)font {
  return (CGFloat)ceil((double)font.lineHeight);
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
                          textViewFrame:(CGRect)textViewFrame {
  if (contentOffset.y > 0) {
    size.height += contentOffset.y;
  }
  return size;
}

- (CGPoint)scrollViewContentOffsetWithSize:(CGSize)size
                             textViewFrame:(CGRect)textViewFrame
                              textViewMinY:(CGFloat)textViewMinY
                            globalTextMinX:(CGFloat)globalTextMinX
                            globalTextMaxX:(CGFloat)globalTextMaxX
                             bottomPadding:(CGFloat)bottomPadding
                                     isRTL:(BOOL)isRTL {
  CGPoint contentOffset = CGPointZero;
  if (isRTL) {
  } else {
    CGFloat textViewMaxY = CGRectGetMaxY(textViewFrame);
    CGFloat boundsMaxY = size.height;
    if (textViewMaxY > boundsMaxY) {
      CGFloat difference = textViewMaxY - boundsMaxY;
      contentOffset = CGPointMake(0, (difference + bottomPadding));
    }
  }
  return contentOffset;
}

- (NSInteger)chipRowWithRect:(CGRect)rect
                textViewMinY:(CGFloat)textViewMinY
               chipRowHeight:(CGFloat)chipRowHeight
            interChipSpacing:(CGFloat)interChipSpacing {
  CGFloat viewMidY = CGRectGetMidY(rect);
  CGFloat midYAdjustedForContentInset = MDCRound(viewMidY - textViewMinY);
  NSInteger row =
      (NSInteger)midYAdjustedForContentInset / (NSInteger)(chipRowHeight + interChipSpacing);
  return row;
}

- (NSArray<NSNumber *> *)
    determineHorizontalGradientLocationsWithGlobalTextMinX:(CGFloat)globalTextMinX
                                            globalTextMaxX:(CGFloat)globalTextMaxX
                                                 viewWidth:(CGFloat)viewWidth
                                                viewHeight:(CGFloat)viewHeight {
  CGFloat leftFadeStart = (globalTextMinX - kGradientBlurLength) / viewWidth;
  if (leftFadeStart < 0) {
    leftFadeStart = 0;
  }
  CGFloat leftFadeEnd = globalTextMinX / viewWidth;
  if (leftFadeEnd < 0) {
    leftFadeEnd = 0;
  }
  CGFloat rightFadeStart = (globalTextMaxX) / viewWidth;
  if (rightFadeStart >= 1) {
    rightFadeStart = 1;
  }
  CGFloat rightFadeEnd = (globalTextMaxX + kGradientBlurLength) / viewWidth;
  if (rightFadeEnd >= 1) {
    rightFadeEnd = 1;
  }

  return @[
    @(0),
    @(leftFadeStart),
    @(leftFadeEnd),
    @(rightFadeStart),
    @(rightFadeEnd),
    @(1),
  ];
}

- (NSArray<NSNumber *> *)
    determineVerticalGradientLocationsWithGlobalTextMinX:(CGFloat)globalTextMinX
                                          globalTextMaxX:(CGFloat)globalTextMaxX
                                               viewWidth:(CGFloat)viewWidth
                                              viewHeight:(CGFloat)viewHeight
                                       floatingLabelMaxY:(CGFloat)floatingLabelMaxY
                                           bottomPadding:(CGFloat)bottomPadding
                                     positioningDelegate:
                                         (id<MDCContainedInputViewStylerPositioningDelegate>)
                                             positioningDelegate {
  CGFloat topFadeStart = floatingLabelMaxY / viewHeight;
  if (topFadeStart <= 0) {
    topFadeStart = 0;
  }
  CGFloat topFadeEnd = (floatingLabelMaxY + kGradientBlurLength) / viewHeight;
  if (topFadeEnd <= 0) {
    topFadeEnd = 0;
  }
  CGFloat bottomFadeStart = (viewHeight - bottomPadding) / viewHeight;
  if (bottomFadeStart >= 1) {
    bottomFadeStart = 1;
  }
  CGFloat bottomFadeEnd = (viewHeight - kGradientBlurLength) / viewHeight;
  if (bottomFadeEnd >= 1) {
    bottomFadeEnd = 1;
  }

  return @[
    @(0),
    @(topFadeStart),
    @(topFadeEnd),
    @(bottomFadeStart),
    @(bottomFadeEnd),
    @(1),
  ];
}

@end
