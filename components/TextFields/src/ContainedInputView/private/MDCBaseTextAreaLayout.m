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

static const CGFloat kGradientBlurLength = 6;

@interface MDCBaseTextAreaLayout ()

@property(nonatomic, assign) CGFloat calculatedHeight;
@property(nonatomic, assign) CGFloat minimumHeight;
@property(nonatomic, assign) CGFloat containerHeight;

@end

@implementation MDCBaseTextAreaLayout

- (instancetype)initWithSize:(CGSize)size
                      containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                                text:(NSString *)text
                                font:(UIFont *)font
                        floatingFont:(UIFont *)floatingFont
                               label:(UILabel *)label
                          labelState:(MDCContainedInputViewLabelState)labelState
                       labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
                  leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                 rightAssistiveLabel:(UILabel *)rightAssistiveLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)normalizedCustomAssistiveLabelDrawPriority
            preferredContainerHeight:(CGFloat)preferredContainerHeight
        preferredNumberOfVisibleRows:(CGFloat)preferredNumberOfVisibleRows
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithSize:size
                          containerStyle:containerStyle
                                    text:text
                                    font:font
                            floatingFont:floatingFont
                                   label:label
                              labelState:labelState
                           labelBehavior:labelBehavior
                      leftAssistiveLabel:leftAssistiveLabel
                     rightAssistiveLabel:rightAssistiveLabel
              underlineLabelDrawPriority:underlineLabelDrawPriority
        customAssistiveLabelDrawPriority:normalizedCustomAssistiveLabelDrawPriority
                preferredContainerHeight:preferredContainerHeight
            preferredNumberOfVisibleRows:preferredNumberOfVisibleRows
                                   isRTL:isRTL
                               isEditing:isEditing];
  }
  return self;
}

- (void)calculateLayoutWithSize:(CGSize)size
                      containerStyle:(id<MDCContainedInputViewStyle>)containerStyle
                                text:(NSString *)text
                                font:(UIFont *)font
                        floatingFont:(UIFont *)floatingFont
                               label:(UILabel *)label
                          labelState:(MDCContainedInputViewLabelState)labelState
                       labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
                  leftAssistiveLabel:(UILabel *)leftAssistiveLabel
                 rightAssistiveLabel:(UILabel *)rightAssistiveLabel
          underlineLabelDrawPriority:
              (MDCContainedInputViewAssistiveLabelDrawPriority)underlineLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)normalizedCustomAssistiveLabelDrawPriority
            preferredContainerHeight:(CGFloat)preferredContainerHeight
        preferredNumberOfVisibleRows:(CGFloat)preferredNumberOfVisibleRows
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing {
  id<MDCContainerStyleVerticalPositioningReference> positioningReference =
      [containerStyle positioningReferenceWithFloatingFontLineHeight:floatingFont.lineHeight
                                                normalFontLineHeight:font.lineHeight
                                                       textRowHeight:font.lineHeight
                                                    numberOfTextRows:preferredNumberOfVisibleRows
                                                             density:0
                                            preferredContainerHeight:preferredContainerHeight];

  CGFloat globalTextMinX = isRTL ? kTrailingMargin : kLeadingMargin;
  CGFloat globalTextMaxX = isRTL ? size.width - kLeadingMargin : size.width - kTrailingMargin;
  CGRect floatingLabelFrame =
      [self floatingLabelFrameWithText:label.text
                               floatingFont:floatingFont
                             globalTextMinX:globalTextMinX
                             globalTextMaxX:globalTextMaxX
          paddingBetweenTopAndFloatingLabel:positioningReference.paddingBetweenTopAndFloatingLabel
                                      isRTL:isRTL];
  CGFloat floatingLabelMaxY = CGRectGetMaxY(floatingLabelFrame);

  CGFloat bottomPadding = positioningReference.paddingBetweenTextAndBottom;
  CGFloat contentAreaMaxY = positioningReference.containerHeight;

  CGRect normalLabelFrame =
      [self normalLabelFrameWithLabelText:label.text
                                     font:font
                           globalTextMinX:globalTextMinX
                           globalTextMaxX:globalTextMaxX
          paddingBetweenTopAndNormalLabel:positioningReference.paddingBetweenTopAndNormalLabel
                                    isRTL:isRTL];

  CGFloat halfOfNormalLineHeight = (CGFloat)0.5 * font.lineHeight;
  CGFloat textViewMinYNormal = CGRectGetMidY(normalLabelFrame) - halfOfNormalLineHeight;
  CGFloat textViewMinY = textViewMinYNormal;
  CGFloat textViewMinYWithFloatingLabel =
      floatingLabelMaxY + positioningReference.paddingBetweenFloatingLabelAndText;
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

  self.containerHeight = contentAreaMaxY;
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
  self.verticalGradientLocations =
      [self determineVerticalGradientLocationsWithGlobalTextMinX:globalTextMinX
                                                  globalTextMaxX:globalTextMaxX
                                                       viewWidth:size.width
                                                      viewHeight:contentAreaMaxY
                                               floatingLabelMaxY:floatingLabelMaxY
                                                   bottomPadding:bottomPadding
                                            positioningReference:positioningReference];
  return;
}

- (CGFloat)calculatedHeight {
  CGFloat maxY = self.containerHeight;
  //  CGFloat underlineLabelViewMaxY = CGRectGetMaxY(self.assistiveLabelViewFrame);
  //  if (underlineLabelViewMaxY > maxY) {
  //    maxY = underlineLabelViewMaxY;
  //  }
  return maxY;
}

- (CGRect)normalLabelFrameWithLabelText:(NSString *)labelText
                                   font:(UIFont *)font
                         globalTextMinX:(CGFloat)globalTextMinX
                         globalTextMaxX:(CGFloat)globalTextMaxX
        paddingBetweenTopAndNormalLabel:(CGFloat)paddingBetweenTopAndNormalLabel
                                  isRTL:(BOOL)isRTL {
  CGFloat maxTextWidth = globalTextMaxX - globalTextMinX;
  CGSize normalLabelSize = [self textSizeWithText:labelText font:font maxWidth:maxTextWidth];
  CGFloat normalLabelMinX = globalTextMinX;
  if (isRTL) {
    normalLabelMinX = globalTextMaxX - normalLabelSize.width;
  }
  CGFloat normalLabelMinY = paddingBetweenTopAndNormalLabel;
  return CGRectMake(normalLabelMinX, normalLabelMinY, normalLabelSize.width,
                    normalLabelSize.height);
}

- (CGRect)floatingLabelFrameWithText:(NSString *)text
                         floatingFont:(UIFont *)floatingFont
                       globalTextMinX:(CGFloat)globalTextMinX
                       globalTextMaxX:(CGFloat)globalTextMaxX
    paddingBetweenTopAndFloatingLabel:(CGFloat)paddingBetweenTopAndFloatingLabel
                                isRTL:(BOOL)isRTL {
  CGFloat maxTextWidth = globalTextMaxX - globalTextMinX;
  CGSize floatingLabelSize = [self textSizeWithText:text font:floatingFont maxWidth:maxTextWidth];
  CGFloat textMinY = paddingBetweenTopAndFloatingLabel;
  CGFloat textMinX = globalTextMinX;
  if (isRTL) {
    textMinX = globalTextMaxX - floatingLabelSize.width;
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
                                    positioningReference:
                                        (id<MDCContainerStyleVerticalPositioningReference>)
                                            positioningReference {
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
