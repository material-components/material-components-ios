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

#import "MDCContainedInputViewStyleOutlined.h"

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"
#import "MDCContainedInputViewStylePathDrawingUtils.h"
#import "MDCContainedInputViewVerticalPositioningGuideOutlined.h"

static const CGFloat kOutlinedContainerStyleCornerRadius = (CGFloat)4.0;
static const CGFloat kFloatingLabelOutlineSidePadding = (CGFloat)5.0;
static const CGFloat kFilledFloatingLabelScaleFactor = 0.75;

@interface MDCContainedInputViewStyleOutlined ()

@property(strong, nonatomic) CAShapeLayer *outlinedSublayer;
@property(strong, nonatomic) NSMutableDictionary<NSNumber *, UIColor *> *outlineColors;
@property(strong, nonatomic) NSMutableDictionary<NSNumber *, NSNumber *> *outlineLineWidths;

@end

@implementation MDCContainedInputViewStyleOutlined
@synthesize animationDuration = _animationDuration;

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCContainedInputViewStyleOutlinedInit];
  }
  return self;
}

- (void)commonMDCContainedInputViewStyleOutlinedInit {
  [self setUpOutlineColors];
  [self setUpOutlineLineWidths];
  [self setUpOutlineSublayer];
}

- (void)setUpOutlineColors {
  self.outlineColors = [NSMutableDictionary new];
  self.outlineColors[@(MDCContainedInputViewStateNormal)] = [UIColor blackColor];
  self.outlineColors[@(MDCContainedInputViewStateFocused)] = [UIColor blackColor];
  self.outlineColors[@(MDCContainedInputViewStateDisabled)] =
      [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
}

- (void)setUpOutlineLineWidths {
  self.outlineLineWidths = [NSMutableDictionary new];
  self.outlineLineWidths[@(MDCContainedInputViewStateNormal)] = @(1);
  self.outlineLineWidths[@(MDCContainedInputViewStateFocused)] = @(2);
  self.outlineLineWidths[@(MDCContainedInputViewStateDisabled)] = @(1);
}

- (void)setUpOutlineSublayer {
  self.outlinedSublayer = [[CAShapeLayer alloc] init];
  self.outlinedSublayer.fillColor = [UIColor clearColor].CGColor;
  self.outlinedSublayer.lineWidth =
      (CGFloat)[self.outlineLineWidths[@(MDCContainedInputViewStateNormal)] doubleValue];
}

#pragma mark Accessors

- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
  _animationDuration = animationDuration;
}

- (NSTimeInterval)animationDuration {
  return _animationDuration;
}

- (UIColor *)outlineColorForState:(MDCContainedInputViewState)state {
  return self.outlineColors[@(state)];
}

- (void)setOutlineColor:(nonnull UIColor *)outlineColor forState:(MDCContainedInputViewState)state {
  self.outlineColors[@(state)] = outlineColor;
}

- (void)applyStyleToContainedInputView:(id<MDCContainedInputView>)containedInputView {
  if (![containedInputView isKindOfClass:[UIView class]]) {
    [self removeStyleFrom:containedInputView];
    return;
  }
  CGRect labelFrame = containedInputView.label.frame;
  BOOL isFloatingLabelFloating =
      containedInputView.labelState == MDCContainedInputViewLabelStateFloating;
  CGFloat containerHeight = CGRectGetMaxY(containedInputView.containerFrame);
  CGFloat lineWidth =
      (CGFloat)self.outlineLineWidths[@(containedInputView.containedInputViewState)].doubleValue;
  UIView *uiView = (UIView *)containedInputView;
  [self applyStyleTo:uiView
                   labelFrame:labelFrame
              containerHeight:containerHeight
      isFloatingLabelFloating:isFloatingLabelFloating
             outlineLineWidth:lineWidth];
  self.outlinedSublayer.strokeColor =
      ((UIColor *)self.outlineColors[@(containedInputView.containedInputViewState)]).CGColor;
}

- (UIFont *)floatingFontWithFont:(UIFont *)font {
  CGFloat scaleFactor = kFilledFloatingLabelScaleFactor;
  CGFloat floatingFontSize = font.pointSize * scaleFactor;
  return [font fontWithSize:floatingFontSize];
}

- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView {
  [self.outlinedSublayer removeFromSuperlayer];
}

- (void)applyStyleTo:(UIView *)view
                 labelFrame:(CGRect)labelFrame
            containerHeight:(CGFloat)containerHeight
    isFloatingLabelFloating:(BOOL)isFloatingLabelFloating
           outlineLineWidth:(CGFloat)outlineLineWidth {
  UIBezierPath *path = [self outlinePathWithViewBounds:view.bounds
                                            labelFrame:labelFrame
                                       containerHeight:containerHeight
                                             lineWidth:outlineLineWidth
                               isFloatingLabelFloating:isFloatingLabelFloating];
  self.outlinedSublayer.path = path.CGPath;
  self.outlinedSublayer.lineWidth = outlineLineWidth;
  if (self.outlinedSublayer.superlayer != view.layer) {
    [view.layer insertSublayer:self.outlinedSublayer atIndex:0];
  }
}

- (UIBezierPath *)outlinePathWithViewBounds:(CGRect)viewBounds
                                 labelFrame:(CGRect)labelFrame
                            containerHeight:(CGFloat)containerHeight
                                  lineWidth:(CGFloat)lineWidth
                    isFloatingLabelFloating:(BOOL)isFloatingLabelFloating {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat radius = kOutlinedContainerStyleCornerRadius;
  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
  CGFloat sublayerMinY = 0;
  CGFloat sublayerMaxY = containerHeight;

  CGPoint startingPoint = CGPointMake(radius, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - radius, sublayerMinY);
  [path moveToPoint:startingPoint];
  if (isFloatingLabelFloating) {
    CGFloat leftLineBreak = CGRectGetMinX(labelFrame) - kFloatingLabelOutlineSidePadding;
    CGFloat rightLineBreak = CGRectGetMaxX(labelFrame) + kFloatingLabelOutlineSidePadding;
    [path addLineToPoint:CGPointMake(leftLineBreak, sublayerMinY)];
    [path moveToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
    [path addLineToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
  } else {
    [path addLineToPoint:topRightCornerPoint1];
  }

  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + radius);
  [MDCContainedInputViewStylePathDrawingUtils addTopRightCornerToPath:path
                                                            fromPoint:topRightCornerPoint1
                                                              toPoint:topRightCornerPoint2
                                                           withRadius:radius];

  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - radius);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - radius, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [MDCContainedInputViewStylePathDrawingUtils addBottomRightCornerToPath:path
                                                               fromPoint:bottomRightCornerPoint1
                                                                 toPoint:bottomRightCornerPoint2
                                                              withRadius:radius];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(radius, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - radius);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [MDCContainedInputViewStylePathDrawingUtils addBottomLeftCornerToPath:path
                                                              fromPoint:bottomLeftCornerPoint1
                                                                toPoint:bottomLeftCornerPoint2
                                                             withRadius:radius];

  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + radius);
  CGPoint topLeftCornerPoint2 = CGPointMake(radius, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [MDCContainedInputViewStylePathDrawingUtils addTopLeftCornerToPath:path
                                                           fromPoint:topLeftCornerPoint1
                                                             toPoint:topLeftCornerPoint2
                                                          withRadius:radius];

  return path;
}

- (id<MDCContainerStyleVerticalPositioningReference>)
    positioningReferenceWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                              normalFontLineHeight:(CGFloat)normalFontLineHeight
                                     textRowHeight:(CGFloat)textRowHeight
                                  numberOfTextRows:(CGFloat)numberOfTextRows
                                           density:(CGFloat)density
                          preferredContainerHeight:(CGFloat)preferredContainerHeight {
  return [[MDCContainedInputViewVerticalPositioningGuideOutlined alloc]
      initWithFloatingFontLineHeight:floatingLabelHeight
                normalFontLineHeight:normalFontLineHeight
                       textRowHeight:textRowHeight
                    numberOfTextRows:numberOfTextRows
                             density:density
            preferredContainerHeight:preferredContainerHeight];
}

@end
