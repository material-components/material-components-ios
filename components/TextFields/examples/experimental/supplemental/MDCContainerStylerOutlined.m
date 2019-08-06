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

#import "MDCContainerStylerOutlined.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCContainerStylerOutlinedPositioningDelegate.h"
#import "MDCContainerStylerPathDrawingUtils.h"

static const CGFloat kOutlinedContainerStylerCornerRadius = (CGFloat)4.0;
static const CGFloat kFloatingLabelOutlineSidePadding = (CGFloat)5.0;

@implementation MDCContainedInputViewColorSchemeOutlined
@end

@interface MDCContainerStylerOutlined ()

@property(strong, nonatomic) CAShapeLayer *outlinedSublayer;

@end

@implementation MDCContainerStylerOutlined

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUpOutlineSublayer];
  }
  return self;
}

- (void)setUpOutlineSublayer {
  self.outlinedSublayer = [[CAShapeLayer alloc] init];
  self.outlinedSublayer.fillColor = [UIColor clearColor].CGColor;
  self.outlinedSublayer.lineWidth =
      [self outlineLineWidthForState:MDCContainedInputViewStateNormal];
}

- (id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:
    (MDCContainedInputViewState)state {
  MDCContainedInputViewColorSchemeOutlined *colorScheme =
      [[MDCContainedInputViewColorSchemeOutlined alloc] init];
  UIColor *outlineColor = [UIColor blackColor];
  switch (state) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateDisabled:
      break;
    case MDCContainedInputViewStateFocused:
      //      outlineColor = [UIColor blackColor]//colorScheme.primaryColor;
      break;
    default:
      break;
  }
  colorScheme.outlineColor = outlineColor;
  return (id<MDCContainedInputViewColorScheming>)colorScheme;
}

- (void)applyStyleToContainedInputView:(id<MDCContainedInputView>)containedInputView
    withContainedInputViewColorScheming:(id<MDCContainedInputViewColorScheming>)colorScheme {
  UIView *uiView = nil;
  if (![containedInputView isKindOfClass:[UIView class]]) {
    [self removeStyleFrom:containedInputView];
    return;
  }
  uiView = (UIView *)containedInputView;
  CGRect placeholderFrame = containedInputView.label.frame;
  BOOL isFloatingLabelFloating =
      containedInputView.labelState == MDCContainedInputViewLabelStateFloating;
  CGFloat topRowBottomRowDividerY = CGRectGetMaxY(containedInputView.containerFrame);
  CGFloat lineWidth = [self outlineLineWidthForState:containedInputView.containedInputViewState];
  [self applyStyleTo:uiView
             placeholderFrame:placeholderFrame
      topRowBottomRowDividerY:topRowBottomRowDividerY
      isFloatingLabelFloating:isFloatingLabelFloating
             outlineLineWidth:lineWidth];
  if ([colorScheme isKindOfClass:[MDCContainedInputViewColorSchemeOutlined class]]) {
    MDCContainedInputViewColorSchemeOutlined *outlinedScheme =
        (MDCContainedInputViewColorSchemeOutlined *)colorScheme;
    self.outlinedSublayer.strokeColor = outlinedScheme.outlineColor.CGColor;
  }
}

//- (BOOL)isPlaceholderFloatingWithFrame:(CGRect)frame {
//  return CGRectGetMinY(frame) <= 0 && CGRectGetMaxY(frame) >= 0;
//}

- (void)applyStyleTo:(UIView *)view
           placeholderFrame:(CGRect)placeholderFrame
    topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
    isFloatingLabelFloating:(BOOL)isFloatingLabelFloating
           outlineLineWidth:(CGFloat)outlineLineWidth {
  UIBezierPath *path = [self outlinePathWithViewBounds:view.bounds
                                      placeholderFrame:placeholderFrame
                               topRowBottomRowDividerY:topRowBottomRowDividerY
                                             lineWidth:outlineLineWidth
                               isFloatingLabelFloating:isFloatingLabelFloating];
  self.outlinedSublayer.path = path.CGPath;
  self.outlinedSublayer.lineWidth = outlineLineWidth;
  if (self.outlinedSublayer.superlayer != view.layer) {
    [view.layer insertSublayer:self.outlinedSublayer atIndex:0];
  }
}

- (UIBezierPath *)outlinePathWithViewBounds:(CGRect)viewBounds
                           placeholderFrame:(CGRect)placeholderFrame
                    topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
                                  lineWidth:(CGFloat)lineWidth
                    isFloatingLabelFloating:(BOOL)isFloatingLabelFloating {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat radius = kOutlinedContainerStylerCornerRadius;
  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
  CGFloat sublayerMinY = 0;
  CGFloat sublayerMaxY = topRowBottomRowDividerY;

  CGPoint startingPoint = CGPointMake(radius, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - radius, sublayerMinY);
  [path moveToPoint:startingPoint];
  if (isFloatingLabelFloating) {
    CGFloat leftLineBreak = CGRectGetMinX(placeholderFrame) - kFloatingLabelOutlineSidePadding;
    CGFloat rightLineBreak = CGRectGetMaxX(placeholderFrame) + kFloatingLabelOutlineSidePadding;
    [path addLineToPoint:CGPointMake(leftLineBreak, sublayerMinY)];
    [path moveToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
    [path addLineToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
  } else {
    [path addLineToPoint:topRightCornerPoint1];
  }

  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + radius);
  [MDCContainerStylerPathDrawingUtils addTopRightCornerToPath:path
                                                    fromPoint:topRightCornerPoint1
                                                      toPoint:topRightCornerPoint2
                                                   withRadius:radius];

  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - radius);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - radius, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [MDCContainerStylerPathDrawingUtils addBottomRightCornerToPath:path
                                                       fromPoint:bottomRightCornerPoint1
                                                         toPoint:bottomRightCornerPoint2
                                                      withRadius:radius];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(radius, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - radius);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [MDCContainerStylerPathDrawingUtils addBottomLeftCornerToPath:path
                                                      fromPoint:bottomLeftCornerPoint1
                                                        toPoint:bottomLeftCornerPoint2
                                                     withRadius:radius];

  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + radius);
  CGPoint topLeftCornerPoint2 = CGPointMake(radius, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [MDCContainerStylerPathDrawingUtils addTopLeftCornerToPath:path
                                                   fromPoint:topLeftCornerPoint1
                                                     toPoint:topLeftCornerPoint2
                                                  withRadius:radius];

  return path;
}

- (CGFloat)outlineLineWidthForState:(MDCContainedInputViewState)containedInputViewState {
  CGFloat defaultLineWidth = 1;
  switch (containedInputViewState) {
    case MDCContainedInputViewStateFocused:
      defaultLineWidth = 2;
      break;
    case MDCContainedInputViewStateNormal:
    case MDCContainedInputViewStateDisabled:
    default:
      break;
  }
  return defaultLineWidth;
}

- (id<MDCContainerStylerPositioningDelegate>)
    positioningDelegateWithFoatingFontLineHeight:(CGFloat)floatingFontLineHeight
                            normalFontLineHeight:(CGFloat)normalFontLineHeight
                                   textRowHeight:(CGFloat)textRowHeight
                                numberOfTextRows:(CGFloat)numberOfTextRows
                                         density:(CGFloat)density
                        preferredContainerHeight:(CGFloat)preferredContainerHeight
                                      labelState:(MDCContainedInputViewLabelState)labelState
                                   labelBehavior:(MDCTextControlLabelBehavior)labelBehavior {
  return [[MDCContainerStylerOutlinedPositioningDelegate alloc]
      initWithFloatingFontLineHeight:floatingFontLineHeight
                normalFontLineHeight:normalFontLineHeight
                       textRowHeight:textRowHeight
                    numberOfTextRows:numberOfTextRows
                             density:density
            preferredContainerHeight:preferredContainerHeight
                          labelState:labelState
                       labelBehavior:labelBehavior];
}

@end
