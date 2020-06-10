// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

static const CGFloat kHorizontalPadding = (CGFloat)12.0;

static const CGFloat kGradientBlurLength = (CGFloat)4.0;

@interface MDCBaseTextAreaLayout ()

@property(nonatomic, assign) CGRect labelFrameFloating;
@property(nonatomic, assign) CGRect labelFrameNormal;

@property(nonatomic, assign) CGRect textViewFrame;

@property(nonatomic, assign) CGRect assistiveLabelViewFrame;
@property(nonatomic, strong, nonnull)
    MDCTextControlAssistiveLabelViewLayout *assistiveLabelViewLayout;

@property(nonatomic) CGFloat containerHeight;

@property(nonatomic, strong, nonnull) NSArray<NSNumber *> *verticalGradientLocations;
@property(nonatomic, strong, nonnull) NSArray<NSNumber *> *horizontalGradientLocations;

@end

@implementation MDCBaseTextAreaLayout

- (nonnull instancetype)initWithSize:(CGSize)size
                positioningReference:
                    (nonnull id<MDCTextControlVerticalPositioningReference>)positioningReference
                                text:(nullable NSString *)text
                                font:(nonnull UIFont *)font
                        floatingFont:(nonnull UIFont *)floatingFont
                               label:(nonnull UILabel *)label
                       labelPosition:(MDCTextControlLabelPosition)labelPosition
                       labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
               leadingAssistiveLabel:(UILabel *)leadingAssistiveLabel
              trailingAssistiveLabel:(UILabel *)trailingAssistiveLabel
          assistiveLabelDrawPriority:
              (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)normalizedCustomAssistiveLabelDrawPriority
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing {
  self = [super init];
  if (self) {
    [self calculateLayoutWithSize:size
                    positioningReference:positioningReference
                                    text:text
                                    font:font
                            floatingFont:floatingFont
                                   label:label
                           labelPosition:labelPosition
                           labelBehavior:labelBehavior
                   leadingAssistiveLabel:leadingAssistiveLabel
                  trailingAssistiveLabel:trailingAssistiveLabel
              assistiveLabelDrawPriority:assistiveLabelDrawPriority
        customAssistiveLabelDrawPriority:normalizedCustomAssistiveLabelDrawPriority
                                   isRTL:isRTL
                               isEditing:isEditing];
  }
  return self;
}

- (void)calculateLayoutWithSize:(CGSize)size
                positioningReference:
                    (id<MDCTextControlVerticalPositioningReference>)positioningReference
                                text:(NSString *)text
                                font:(UIFont *)font
                        floatingFont:(UIFont *)floatingFont
                               label:(UILabel *)label
                       labelPosition:(MDCTextControlLabelPosition)labelPosition
                       labelBehavior:(MDCTextControlLabelBehavior)labelBehavior
               leadingAssistiveLabel:(UILabel *)leadingAssistiveLabel
              trailingAssistiveLabel:(UILabel *)trailingAssistiveLabel
          assistiveLabelDrawPriority:
              (MDCTextControlAssistiveLabelDrawPriority)assistiveLabelDrawPriority
    customAssistiveLabelDrawPriority:(CGFloat)customAssistiveLabelDrawPriority
                               isRTL:(BOOL)isRTL
                           isEditing:(BOOL)isEditing {
  CGFloat globalTextMinX = isRTL ? kHorizontalPadding : kHorizontalPadding;
  CGFloat globalTextMaxX =
      isRTL ? size.width - kHorizontalPadding : size.width - kHorizontalPadding;
  CGRect floatingLabelFrame =
      [self floatingLabelFrameWithText:label.text
                                        floatingFont:floatingFont
                                      globalTextMinX:globalTextMinX
                                      globalTextMaxX:globalTextMaxX
          paddingBetweenContainerTopAndFloatingLabel:positioningReference
                                                         .paddingBetweenContainerTopAndFloatingLabel
                                               isRTL:isRTL];
  CGFloat floatingLabelMaxY = CGRectGetMaxY(floatingLabelFrame);

  CGRect normalLabelFrame =
      [self normalLabelFrameWithLabelText:label.text
                                              font:font
                                    globalTextMinX:globalTextMinX
                                    globalTextMaxX:globalTextMaxX
          paddingBetweenContainerTopAndNormalLabel:positioningReference
                                                       .paddingBetweenContainerTopAndNormalLabel
                                             isRTL:isRTL];

  CGFloat halfOfNormalLineHeight = (CGFloat)0.5 * font.lineHeight;
  CGFloat textViewMinYNormal = CGRectGetMidY(normalLabelFrame) - halfOfNormalLineHeight;
  CGFloat textViewMinY = textViewMinYNormal;
  if (labelPosition == MDCTextControlLabelPositionFloating) {
    textViewMinY =
        floatingLabelMaxY + positioningReference.paddingBetweenFloatingLabelAndEditingText;
  }

  CGFloat bottomPadding = positioningReference.paddingBetweenEditingTextAndContainerBottom;
  CGFloat textViewHeight = positioningReference.containerHeight - bottomPadding - textViewMinY;
  CGRect textViewFrame =
      CGRectMake(globalTextMinX, textViewMinY, globalTextMaxX - globalTextMinX, textViewHeight);

  self.assistiveLabelViewLayout = [[MDCTextControlAssistiveLabelViewLayout alloc]
                         initWithWidth:size.width
                 leadingAssistiveLabel:leadingAssistiveLabel
                trailingAssistiveLabel:trailingAssistiveLabel
            assistiveLabelDrawPriority:assistiveLabelDrawPriority
      customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                 horizontalEdgePadding:kHorizontalPadding
           paddingAboveAssistiveLabels:positioningReference.paddingAboveAssistiveLabels
           paddingBelowAssistiveLabels:positioningReference.paddingBelowAssistiveLabels
                                 isRTL:isRTL];
  self.assistiveLabelViewFrame = CGRectMake(0, positioningReference.containerHeight, size.width,
                                            self.assistiveLabelViewLayout.calculatedHeight);

  self.containerHeight = positioningReference.containerHeight;
  self.textViewFrame = textViewFrame;
  self.labelFrameFloating = floatingLabelFrame;
  self.labelFrameNormal = normalLabelFrame;

  self.horizontalGradientLocations = [self
      determineHorizontalGradientLocationsWithLeftFadeStart:globalTextMinX - kGradientBlurLength
                                                leftFadeEnd:globalTextMinX
                                             rightFadeStart:globalTextMaxX
                                               rightFadeEnd:globalTextMaxX + kGradientBlurLength
                                                  viewWidth:size.width];

  CGFloat topFadeStart = floatingLabelMaxY;
  CGFloat topFadeEnd = floatingLabelMaxY + kGradientBlurLength;
  CGFloat bottomFadeStart = positioningReference.containerHeight - bottomPadding;
  CGFloat bottomFadeEnd = bottomFadeStart + kGradientBlurLength;
  if (labelBehavior == MDCTextControlLabelBehaviorDisappears) {
    topFadeStart = textViewMinY - kGradientBlurLength;
    topFadeEnd = textViewMinY;
    bottomFadeStart = textViewMinY + textViewHeight;
    bottomFadeEnd = bottomFadeStart + kGradientBlurLength;
  }

  self.verticalGradientLocations = [self
      determineVerticalGradientLocationsWithTopFadeStart:topFadeStart
                                              topFadeEnd:topFadeEnd
                                         bottomFadeStart:bottomFadeStart
                                           bottomFadeEnd:bottomFadeEnd
                                         containerHeight:positioningReference.containerHeight];

  return;
}

- (CGFloat)calculatedHeight {
  CGFloat maxY = self.containerHeight;
  CGFloat assistiveLabelViewMaxY = CGRectGetMaxY(self.assistiveLabelViewFrame);
  if (assistiveLabelViewMaxY > maxY) {
    maxY = assistiveLabelViewMaxY;
  }
  return maxY;
}

- (CGRect)normalLabelFrameWithLabelText:(NSString *)labelText
                                        font:(UIFont *)font
                              globalTextMinX:(CGFloat)globalTextMinX
                              globalTextMaxX:(CGFloat)globalTextMaxX
    paddingBetweenContainerTopAndNormalLabel:(CGFloat)paddingBetweenContainerTopAndNormalLabel
                                       isRTL:(BOOL)isRTL {
  CGFloat maxTextWidth = globalTextMaxX - globalTextMinX;
  CGSize normalLabelSize = [self textSizeWithText:labelText font:font maxWidth:maxTextWidth];
  CGFloat normalLabelMinX = globalTextMinX;
  if (isRTL) {
    normalLabelMinX = globalTextMaxX - normalLabelSize.width;
  }
  CGFloat normalLabelMinY = paddingBetweenContainerTopAndNormalLabel;
  return CGRectMake(normalLabelMinX, normalLabelMinY, normalLabelSize.width,
                    normalLabelSize.height);
}

- (CGRect)floatingLabelFrameWithText:(NSString *)text
                                  floatingFont:(UIFont *)floatingFont
                                globalTextMinX:(CGFloat)globalTextMinX
                                globalTextMaxX:(CGFloat)globalTextMaxX
    paddingBetweenContainerTopAndFloatingLabel:(CGFloat)paddingBetweenContainerTopAndFloatingLabel
                                         isRTL:(BOOL)isRTL {
  CGFloat maxTextWidth = globalTextMaxX - globalTextMinX;
  CGSize floatingLabelSize = [self textSizeWithText:text font:floatingFont maxWidth:maxTextWidth];
  CGFloat textMinY = paddingBetweenContainerTopAndFloatingLabel;
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
  CGFloat textFieldWidth = CGRectGetWidth(rect);
  CGFloat textFieldHeight = CGRectGetHeight(rect);
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

- (NSArray<NSNumber *> *)
    determineHorizontalGradientLocationsWithLeftFadeStart:(CGFloat)leftFadeStart
                                              leftFadeEnd:(CGFloat)leftFadeEnd
                                           rightFadeStart:(CGFloat)rightFadeStart
                                             rightFadeEnd:(CGFloat)rightFadeEnd
                                                viewWidth:(CGFloat)viewWidth {
  CGFloat leftFadeStartLocation = leftFadeStart / viewWidth;
  if (leftFadeStartLocation < 0) {
    leftFadeStartLocation = 0;
  }
  CGFloat leftFadeEndLocation = leftFadeEnd / viewWidth;
  if (leftFadeEndLocation < 0) {
    leftFadeEndLocation = 0;
  }
  CGFloat rightFadeStartLocation = rightFadeStart / viewWidth;
  if (rightFadeStartLocation >= 1) {
    rightFadeStartLocation = 1;
  }
  CGFloat rightFadeEndLocation = rightFadeEnd / viewWidth;
  if (rightFadeEndLocation >= 1) {
    rightFadeEndLocation = 1;
  }

  return @[
    @(0),
    @(leftFadeStartLocation),
    @(leftFadeEndLocation),
    @(rightFadeStartLocation),
    @(rightFadeEndLocation),
    @(1),
  ];
}

- (NSArray<NSNumber *> *)determineVerticalGradientLocationsWithTopFadeStart:(CGFloat)topFadeStart
                                                                 topFadeEnd:(CGFloat)topFadeEnd
                                                            bottomFadeStart:(CGFloat)bottomFadeStart
                                                              bottomFadeEnd:(CGFloat)bottomFadeEnd
                                                            containerHeight:
                                                                (CGFloat)containerHeight {
  CGFloat topFadeStartLocation = topFadeStart / containerHeight;
  if (topFadeStartLocation <= 0) {
    topFadeStartLocation = 0;
  }
  CGFloat topFadeEndLocation = topFadeEnd / containerHeight;
  if (topFadeEndLocation <= 0) {
    topFadeEndLocation = 0;
  }
  CGFloat bottomFadeStartLocation = bottomFadeStart / containerHeight;
  if (bottomFadeStartLocation >= 1) {
    bottomFadeStartLocation = 1;
  }
  CGFloat bottomFadeEndLocation = bottomFadeEnd / containerHeight;
  if (bottomFadeEndLocation >= 1) {
    bottomFadeEndLocation = 1;
  }

  return @[
    @(0),
    @(topFadeStartLocation),
    @(topFadeEndLocation),
    @(bottomFadeStartLocation),
    @(bottomFadeEndLocation),
    @(1),
  ];
}

- (CGRect)labelFrameWithLabelPosition:(MDCTextControlLabelPosition)labelPosition {
  if (labelPosition == MDCTextControlLabelPositionFloating) {
    return self.labelFrameFloating;
  } else if (labelPosition == MDCTextControlLabelPositionNormal) {
    return self.labelFrameNormal;
  } else {
    return CGRectZero;
  }
}

@end
