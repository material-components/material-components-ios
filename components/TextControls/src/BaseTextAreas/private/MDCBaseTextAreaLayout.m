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

#import "MDCTextControlAssistiveLabelViewLayout.h"
#import "MDCTextControlLabelPosition.h"
#import "MDCTextControlVerticalPositioningReference.h"

#import <MDFInternationalization/MDFInternationalization.h>

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
        verticalPositioningReference:
            (nonnull id<MDCTextControlVerticalPositioningReference>)verticalPositioningReference
      horizontalPositioningReference:
          (nonnull id<MDCTextControlHorizontalPositioning>)horizontalPositioningReference
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
            verticalPositioningReference:verticalPositioningReference
          horizontalPositioningReference:horizontalPositioningReference
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
        verticalPositioningReference:
            (nonnull id<MDCTextControlVerticalPositioningReference>)verticalPositioningReference
      horizontalPositioningReference:
          (nonnull id<MDCTextControlHorizontalPositioning>)horizontalPositioningReference
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
  CGFloat leadingEdgePadding = horizontalPositioningReference.leadingEdgePadding;
  CGFloat trailingEdgePadding = horizontalPositioningReference.trailingEdgePadding;
  CGFloat leftEdgePadding = isRTL ? trailingEdgePadding : leadingEdgePadding;
  CGFloat rightEdgePadding = isRTL ? leadingEdgePadding : trailingEdgePadding;

  CGFloat globalTextMinX = leftEdgePadding;
  CGFloat globalTextMaxX = size.width - rightEdgePadding;

  CGRect floatingLabelFrame =
      [self floatingLabelFrameWithText:label.text
                                        floatingFont:floatingFont
                                      globalTextMinX:globalTextMinX
                                      globalTextMaxX:globalTextMaxX
          paddingBetweenContainerTopAndFloatingLabel:verticalPositioningReference
                                                         .paddingBetweenContainerTopAndFloatingLabel
                                               isRTL:isRTL];
  CGFloat floatingLabelMaxY = CGRectGetMaxY(floatingLabelFrame);

  CGRect normalLabelFrame =
      [self normalLabelFrameWithLabelText:label.text
                                              font:font
                                    globalTextMinX:globalTextMinX
                                    globalTextMaxX:globalTextMaxX
          paddingBetweenContainerTopAndNormalLabel:verticalPositioningReference
                                                       .paddingBetweenContainerTopAndNormalLabel
                                             isRTL:isRTL];

  CGFloat halfOfNormalLineHeight = (CGFloat)0.5 * font.lineHeight;

  CGFloat textViewMinY = 0;
  CGFloat bottomPadding = 0;
  CGFloat textViewHeight = 0;
  CGRect textViewFrame = CGRectZero;
  CGFloat containerHeight = 0;
  BOOL shouldLayoutForFloatingLabel = MDCTextControlShouldLayoutForFloatingLabelWithLabelPosition(
      labelPosition, labelBehavior, label.text);
  if (shouldLayoutForFloatingLabel) {
    CGFloat textViewMinYNormal = CGRectGetMidY(normalLabelFrame) - halfOfNormalLineHeight;
    if (labelPosition == MDCTextControlLabelPositionFloating) {
      textViewMinY = floatingLabelMaxY +
                     verticalPositioningReference.paddingBetweenFloatingLabelAndEditingText;
    } else {
      textViewMinY = textViewMinYNormal;
    }
    bottomPadding = verticalPositioningReference.paddingBetweenEditingTextAndContainerBottom;
    containerHeight = verticalPositioningReference.containerHeightWithFloatingLabel;
    textViewHeight = containerHeight - bottomPadding - textViewMinY;
    textViewFrame =
        CGRectMake(globalTextMinX, textViewMinY, globalTextMaxX - globalTextMinX, textViewHeight);
  } else {
    textViewMinY = verticalPositioningReference.paddingAroundTextWhenNoFloatingLabel;
    bottomPadding = verticalPositioningReference.paddingAroundTextWhenNoFloatingLabel;
    containerHeight = verticalPositioningReference.containerHeightWithoutFloatingLabel;
    textViewHeight = containerHeight - bottomPadding - textViewMinY;
    textViewFrame =
        CGRectMake(globalTextMinX, textViewMinY, globalTextMaxX - globalTextMinX, textViewHeight);
    normalLabelFrame.origin.y = textViewMinY;
  }

  self.assistiveLabelViewLayout = [[MDCTextControlAssistiveLabelViewLayout alloc]
                         initWithWidth:size.width
                 leadingAssistiveLabel:leadingAssistiveLabel
                trailingAssistiveLabel:trailingAssistiveLabel
            assistiveLabelDrawPriority:assistiveLabelDrawPriority
      customAssistiveLabelDrawPriority:customAssistiveLabelDrawPriority
                    leadingEdgePadding:leadingEdgePadding
                   trailingEdgePadding:trailingEdgePadding
           paddingAboveAssistiveLabels:verticalPositioningReference.paddingAboveAssistiveLabels
           paddingBelowAssistiveLabels:verticalPositioningReference.paddingBelowAssistiveLabels
                                 isRTL:isRTL];
  self.assistiveLabelViewFrame =
      CGRectMake(0, containerHeight, size.width, self.assistiveLabelViewLayout.calculatedHeight);

  self.containerHeight = containerHeight;
  self.textViewFrame = textViewFrame;
  self.labelFrameFloating = floatingLabelFrame;
  self.labelFrameNormal = normalLabelFrame;

  self.horizontalGradientLocations =
      [self determineHorizontalGradientLocationsWithLeftFadeStart:0
                                                      leftFadeEnd:kGradientBlurLength
                                                   rightFadeStart:size.width - kGradientBlurLength
                                                     rightFadeEnd:size.width
                                                        viewWidth:size.width];
  if (shouldLayoutForFloatingLabel) {
    CGFloat topFadeStart = floatingLabelMaxY;
    CGFloat topFadeEnd = floatingLabelMaxY + kGradientBlurLength;
    CGFloat bottomFadeStart =
        verticalPositioningReference.containerHeightWithFloatingLabel - bottomPadding;
    CGFloat bottomFadeEnd = bottomFadeStart + kGradientBlurLength;
    self.verticalGradientLocations = [self
        determineVerticalGradientLocationsWithTopFadeStart:topFadeStart
                                                topFadeEnd:topFadeEnd
                                           bottomFadeStart:bottomFadeStart
                                             bottomFadeEnd:bottomFadeEnd
                                           containerHeight:verticalPositioningReference
                                                               .containerHeightWithFloatingLabel];
  } else {
    CGFloat topFadeEnd = verticalPositioningReference.paddingAroundTextWhenNoFloatingLabel;
    CGFloat topFadeStart = topFadeEnd - kGradientBlurLength;
    CGFloat bottomFadeStart = verticalPositioningReference.containerHeightWithoutFloatingLabel -
                              verticalPositioningReference.paddingAroundTextWhenNoFloatingLabel;
    CGFloat bottomFadeEnd = bottomFadeStart + kGradientBlurLength;
    self.verticalGradientLocations =
        [self determineVerticalGradientLocationsWithTopFadeStart:topFadeStart
                                                      topFadeEnd:topFadeEnd
                                                 bottomFadeStart:bottomFadeStart
                                                   bottomFadeEnd:bottomFadeEnd
                                                 containerHeight:
                                                     verticalPositioningReference
                                                         .containerHeightWithoutFloatingLabel];
  }
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
