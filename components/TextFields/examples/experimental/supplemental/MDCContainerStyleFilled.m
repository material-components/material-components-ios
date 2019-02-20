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

#import "MDCContainedInputView.h"

#import <Foundation/Foundation.h>
#import "MDCContainerStyleFilled.h"
#import "MDCContainerStylePathDrawingUtils.h"

static const CGFloat kFilledContainerStyleTopCornerRadius = (CGFloat)4.0;

@implementation MDCContainedInputViewColorSchemeFilled
@end

@interface MDCContainerStyleFilled ()
@property(strong, nonatomic) CAShapeLayer *filledSublayer;
@property(strong, nonatomic) CAShapeLayer *filledSublayerUnderline;
@end

@implementation MDCContainerStyleFilled
@synthesize densityInformer = _densityInformer;

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUp];
  }
  return self;
}

- (void)setUp {
  [self setUpDensityInformer];
  [self setUpFilledSublayers];
}

- (void)setUpDensityInformer {
  self.densityInformer = [[MDCContainerStyleFilledDensityInformer alloc] init];
}

- (void)setUpFilledSublayers {
  self.filledSublayer = [[CAShapeLayer alloc] init];
  self.filledSublayer.lineWidth = 0.0;
  self.filledSublayerUnderline = [[CAShapeLayer alloc] init];
  [self.filledSublayer addSublayer:self.filledSublayerUnderline];
}

- (id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:
    (MDCContainedInputViewState)state {
  MDCContainedInputViewColorSchemeFilled *colorScheme =
      [[MDCContainedInputViewColorSchemeFilled alloc] init];
  UIColor *filledSublayerUnderlineFillColor =
      [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.06];
  UIColor *filledSublayerFillColor = [UIColor colorWithRed:(0xDD / 256)
                                                     green:(0xDD / 256)
                                                      blue:(0xDD / 256)
                                                     alpha:1];

  //      [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.15];

  switch (state) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateActivated:
      break;
    case MDCContainedInputViewStateDisabled:
      break;
    case MDCContainedInputViewStateErrored:
      filledSublayerUnderlineFillColor = colorScheme.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      filledSublayerUnderlineFillColor = [UIColor blackColor];
      break;
    default:
      break;
  }
  colorScheme.filledSublayerFillColor = filledSublayerFillColor;
  colorScheme.filledSublayerUnderlineFillColor = filledSublayerUnderlineFillColor;
  return (id<MDCContainedInputViewColorScheming>)colorScheme;
}

- (void)applyStyleToContainedInputView:(id<MDCContainedInputView>)containedInputView
    withContainedInputViewColorScheming:(id<MDCContainedInputViewColorScheming>)colorScheme {
  if (![containedInputView isKindOfClass:[UIView class]]) {
    [self removeStyleFrom:containedInputView];
    return;
  }
  UIView *uiView = (UIView *)containedInputView;
  CGFloat underlineThickness = [self
      underlineThicknessWithMDCContainedInputViewState:containedInputView.containedInputViewState];
  CGFloat topRowBottomRowDividerY = CGRectGetMaxY(containedInputView.containerRect);
  [self applyStyleToView:uiView
      topRowBottomRowDividerY:topRowBottomRowDividerY
           underlineThickness:underlineThickness];
  if ([colorScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledScheme =
        (MDCContainedInputViewColorSchemeFilled *)colorScheme;
    self.filledSublayer.fillColor = filledScheme.filledSublayerFillColor.CGColor;
    self.filledSublayerUnderline.fillColor = filledScheme.filledSublayerUnderlineFillColor.CGColor;
  }
}

- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView {
  [self.filledSublayer removeFromSuperlayer];
  [self.filledSublayerUnderline removeFromSuperlayer];
}

- (void)applyStyleToView:(UIView *)view
    topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
         underlineThickness:(CGFloat)underlineThickness {
  UIBezierPath *filledSublayerPath =
      [self filledSublayerPathWithTextFieldBounds:view.bounds
                          topRowBottomRowDividerY:topRowBottomRowDividerY];
  UIBezierPath *filledSublayerUnderlinePath =
      [self filledSublayerUnderlinePathWithTextFieldBounds:view.bounds
                                   topRowBottomRowDividerY:topRowBottomRowDividerY
                                        underlineThickness:underlineThickness];
  self.filledSublayer.path = filledSublayerPath.CGPath;
  self.filledSublayerUnderline.path = filledSublayerUnderlinePath.CGPath;
  if (self.filledSublayer.superlayer != view.layer) {
    [view.layer insertSublayer:self.filledSublayer atIndex:0];
  }
}

- (UIBezierPath *)filledSublayerPathWithTextFieldBounds:(CGRect)viewBounds
                                topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat topRadius = kFilledContainerStyleTopCornerRadius;
  CGFloat bottomRadius = 0;
  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
  CGFloat sublayerMinY = 0;
  CGFloat sublayerMaxY = topRowBottomRowDividerY;

  CGPoint startingPoint = CGPointMake(topRadius, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - topRadius, sublayerMinY);
  [path moveToPoint:startingPoint];
  [path addLineToPoint:topRightCornerPoint1];

  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + topRadius);
  [MDCContainerStylePathDrawingUtils addTopRightCornerToPath:path
                                                   fromPoint:topRightCornerPoint1
                                                     toPoint:topRightCornerPoint2
                                                  withRadius:topRadius];

  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - bottomRadius);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - bottomRadius, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [MDCContainerStylePathDrawingUtils addBottomRightCornerToPath:path
                                                      fromPoint:bottomRightCornerPoint1
                                                        toPoint:bottomRightCornerPoint2
                                                     withRadius:bottomRadius];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(bottomRadius, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - bottomRadius);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [MDCContainerStylePathDrawingUtils addBottomLeftCornerToPath:path
                                                     fromPoint:bottomLeftCornerPoint1
                                                       toPoint:bottomLeftCornerPoint2
                                                    withRadius:bottomRadius];

  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + topRadius);
  CGPoint topLeftCornerPoint2 = CGPointMake(topRadius, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [MDCContainerStylePathDrawingUtils addTopLeftCornerToPath:path
                                                  fromPoint:topLeftCornerPoint1
                                                    toPoint:topLeftCornerPoint2
                                                 withRadius:topRadius];

  return path;
}

- (UIBezierPath *)filledSublayerUnderlinePathWithTextFieldBounds:(CGRect)viewBounds
                                         topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
                                              underlineThickness:(CGFloat)underlineThickness {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
  CGFloat sublayerMaxY = topRowBottomRowDividerY;
  CGFloat sublayerMinY = sublayerMaxY - underlineThickness;

  CGPoint startingPoint = CGPointMake(0, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMinY);
  [path moveToPoint:startingPoint];
  [path addLineToPoint:topRightCornerPoint1];

  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY);
  [MDCContainerStylePathDrawingUtils addTopRightCornerToPath:path
                                                   fromPoint:topRightCornerPoint1
                                                     toPoint:topRightCornerPoint2
                                                  withRadius:0];

  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [MDCContainerStylePathDrawingUtils addBottomRightCornerToPath:path
                                                      fromPoint:bottomRightCornerPoint1
                                                        toPoint:bottomRightCornerPoint2
                                                     withRadius:0];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(0, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [MDCContainerStylePathDrawingUtils addBottomLeftCornerToPath:path
                                                     fromPoint:bottomLeftCornerPoint1
                                                       toPoint:bottomLeftCornerPoint2
                                                    withRadius:0];

  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY);
  CGPoint topLeftCornerPoint2 = CGPointMake(0, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [MDCContainerStylePathDrawingUtils addTopLeftCornerToPath:path
                                                  fromPoint:topLeftCornerPoint1
                                                    toPoint:topLeftCornerPoint2
                                                 withRadius:0];

  return path;
}

- (CGFloat)underlineThicknessWithMDCContainedInputViewState:
    (MDCContainedInputViewState)containedInputViewState {
  CGFloat underlineThickness = 1;
  switch (containedInputViewState) {
    case MDCContainedInputViewStateActivated:
    case MDCContainedInputViewStateErrored:
    case MDCContainedInputViewStateFocused:
      underlineThickness = 2;
      break;
    case MDCContainedInputViewStateNormal:
    case MDCContainedInputViewStateDisabled:
    default:
      break;
  }
  return underlineThickness;
}

- (id<MDCContainedInputViewStyleDensityInforming>)densityInformer {
  if (_densityInformer) {
    return _densityInformer;
  }
  return [[MDCContainerStyleFilledDensityInformer alloc] init];
}

@end

@implementation MDCContainerStyleFilledDensityInformer

- (CGFloat)floatingPlaceholderFontSize {
  CGFloat scaleFactor = ((CGFloat)53 / (CGFloat)71);
  return scaleFactor * [UIFont systemFontSize];
}

- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight {
  CGFloat filledPlaceholderTopPaddingScaleHeuristic = ((CGFloat)50.0 / (CGFloat)70.0);
  return filledPlaceholderTopPaddingScaleHeuristic * floatingPlaceholderHeight;
}

- (CGFloat)contentAreaTopPaddingWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY {
  return floatingPlaceholderMaxY + (CGFloat)6.5;
}

- (CGFloat)normalContentAreaBottomPadding {
  return 10;
}

@end
