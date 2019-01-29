// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

//#import <MDFInternationalization/MDFInternationalization.h>
//#import <MaterialComponents/MDCMath.h>

#import "MDCContainedInputView.h"

#import <Foundation/Foundation.h>
#import "SimpleTextFieldColorScheme.h"

static const CGFloat kFilledContainerStyleTopCornerRadius = (CGFloat)4.0;
static const CGFloat kOutlinedContainerStyleCornerRadius = (CGFloat)4.0;

static const CGFloat kFloatingPlaceholderOutlineSidePadding = (CGFloat)5.0;

@implementation MDCContainerStylePathDrawingUtils

+ (void)addTopRightCornerToPath:(UIBezierPath *)path
                      fromPoint:(CGPoint)point1
                        toPoint:(CGPoint)point2
                     withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)(M_PI / 2);
  CGFloat endAngle = 0;
  CGPoint center = CGPointMake(point1.x, point2.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

+ (void)addBottomRightCornerToPath:(UIBezierPath *)path
                         fromPoint:(CGPoint)point1
                           toPoint:(CGPoint)point2
                        withRadius:(CGFloat)radius {
  CGFloat startAngle = 0;
  CGFloat endAngle = -(CGFloat)((M_PI * 3) / 2);
  CGPoint center = CGPointMake(point2.x, point1.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

+ (void)addBottomLeftCornerToPath:(UIBezierPath *)path
                        fromPoint:(CGPoint)point1
                          toPoint:(CGPoint)point2
                       withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)((M_PI * 3) / 2);
  CGFloat endAngle = -(CGFloat)M_PI;
  CGPoint center = CGPointMake(point1.x, point2.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

+ (void)addTopLeftCornerToPath:(UIBezierPath *)path
                     fromPoint:(CGPoint)point1
                       toPoint:(CGPoint)point2
                    withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)M_PI;
  CGFloat endAngle = -(CGFloat)(M_PI / 2);
  CGPoint center = CGPointMake(point1.x + radius, point2.y + radius);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}


@end

@implementation MDCContainerStyle

+(Class)colorSchemeClass {
  return [SimpleTextFieldColorScheme class];
}

- (id<SimpleTextFieldColorScheming>)defaultColorSchemeForState:(MDCContainedInputViewState)state {
  SimpleTextFieldColorScheme *colorScheme = [[SimpleTextFieldColorScheme alloc] init];
  //TODO: Implement
  return colorScheme;
}

- (id<SimpleTextFieldColorScheming>)defaultColorScheme {
  return [self defaultColorSchemeForState:MDCContainedInputViewStateNormal];
}

- (void)applyStyleTo:(id<MDCContainedInputView>)containedInputView { }
- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView { }

@end

@interface MDCContainerStyleFilled ()
@property(strong, nonatomic) CAShapeLayer *filledSublayer;
@property(strong, nonatomic) CAShapeLayer *filledSublayerUnderline;
@end

@implementation MDCContainerStyleFilled

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUpFilledSublayer];
  }
  return self;
}

- (void)setUpFilledSublayer {
  self.filledSublayer = [[CAShapeLayer alloc] init];
  self.filledSublayer.lineWidth = 0.0;
  self.filledSublayerUnderline = [[CAShapeLayer alloc] init];
  [self.filledSublayer addSublayer:self.filledSublayerUnderline];
}

- (void)applyStyleTo:(id<MDCContainedInputView>)containedInputView {
  if (![containedInputView isKindOfClass:[UIView class]]) {
    [self removeStyleFrom:containedInputView];
    return;
  }
  UIView *uiView = (UIView *)containedInputView;
  CGFloat underlineThickness =
      [self underlineThicknessWithMDCContainedInputViewState:containedInputView.containedInputViewState];
  CGFloat topRowBottomRowDividerY = containedInputView.leadingUnderlineLabel.frame.origin.y - 10;
  [self applyStyleToView:uiView
 topRowBottomRowDividerY:topRowBottomRowDividerY
      underlineThickness:underlineThickness];
  
}

-(void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView {
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

- (CGFloat)underlineThicknessWithMDCContainedInputViewState:(MDCContainedInputViewState)containedInputViewState {
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


@end

@interface MDCContainerStyleOutlined ()
@property(strong, nonatomic) CAShapeLayer *outlinedSublayer;
@end

@implementation MDCContainerStyleOutlined

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
  self.outlinedSublayer.lineWidth = [self outlineLineWidthForState:MDCContainedInputViewStateNormal];
}

- (void)applyStyleTo:(id<MDCContainedInputView>)containedInputView {
  UIView *uiView = nil;
  if (![containedInputView isKindOfClass:[UIView class]]) {
    [self removeStyleFrom:containedInputView];
    return;
  }
  uiView = (UIView *)containedInputView;
  CGRect placeholderFrame = containedInputView.placeholderLabel.frame;
  BOOL isFloatingPlaceholder = [self isPlaceholderFloatingWithFrame:placeholderFrame];
  CGFloat topRowBottomRowDividerY = containedInputView.leadingUnderlineLabel.frame.origin.y - 10;
  CGFloat lineWidth = [self outlineLineWidthForState:containedInputView.containedInputViewState];
  [self applyStyleTo:uiView
    placeholderFrame:placeholderFrame
topRowBottomRowDividerY:topRowBottomRowDividerY
isFloatingPlaceholder:isFloatingPlaceholder
    outlineLineWidth:lineWidth];
}

- (BOOL)isPlaceholderFloatingWithFrame:(CGRect)frame {
  // TODO: Implement
  return NO;
}

- (void)applyStyleTo:(UIView *)view
  placeholderFrame:(CGRect)placeholderFrame
   topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
     isFloatingPlaceholder:(BOOL)isFloatingPlaceholder
          outlineLineWidth:(CGFloat)outlineLineWidth {
  UIBezierPath *path = [self outlinePathWithViewBounds:view.bounds
                              placeholderFrame:placeholderFrame
                               topRowBottomRowDividerY:topRowBottomRowDividerY
                                             lineWidth:outlineLineWidth
                                 isFloatingPlaceholder:isFloatingPlaceholder];
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
                      isFloatingPlaceholder:(BOOL)isFloatingPlaceholder {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat radius = kOutlinedContainerStyleCornerRadius;
  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
  CGFloat sublayerMinY = 0;
  CGFloat sublayerMaxY = topRowBottomRowDividerY;
  
  CGPoint startingPoint = CGPointMake(radius, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - radius, sublayerMinY);
  [path moveToPoint:startingPoint];
  if (isFloatingPlaceholder) {
    CGFloat leftLineBreak =
    CGRectGetMinX(placeholderFrame) - kFloatingPlaceholderOutlineSidePadding;
    CGFloat rightLineBreak =
    CGRectGetMaxX(placeholderFrame) + kFloatingPlaceholderOutlineSidePadding;
    [path addLineToPoint:CGPointMake(leftLineBreak, sublayerMinY)];
    [path moveToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
    [path addLineToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
  } else {
    [path addLineToPoint:topRightCornerPoint1];
  }
  
  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + radius);
  [MDCContainerStylePathDrawingUtils addTopRightCornerToPath:path
                      fromPoint:topRightCornerPoint1
                        toPoint:topRightCornerPoint2
                     withRadius:radius];
  
  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - radius);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - radius, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [MDCContainerStylePathDrawingUtils addBottomRightCornerToPath:path
                         fromPoint:bottomRightCornerPoint1
                           toPoint:bottomRightCornerPoint2
                        withRadius:radius];
  
  CGPoint bottomLeftCornerPoint1 = CGPointMake(radius, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - radius);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [MDCContainerStylePathDrawingUtils addBottomLeftCornerToPath:path
                        fromPoint:bottomLeftCornerPoint1
                          toPoint:bottomLeftCornerPoint2
                       withRadius:radius];
  
  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + radius);
  CGPoint topLeftCornerPoint2 = CGPointMake(radius, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [MDCContainerStylePathDrawingUtils addTopLeftCornerToPath:path
                     fromPoint:topLeftCornerPoint1
                       toPoint:topLeftCornerPoint2
                    withRadius:radius];
  
  return path;
}

- (CGFloat)outlineLineWidthForState:(MDCContainedInputViewState)containedInputViewState {
  CGFloat defaultLineWidth = 1;
  switch (containedInputViewState) {
    case MDCContainedInputViewStateActivated:
    case MDCContainedInputViewStateErrored:
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



@end






//@interface MDCInputViewContainerStyler ()
//
//@end

//@implementation MDCInputViewContainerStyler
//
//- (instancetype)init {
//  self = [super init];
//  if (self) {
//    [self setUpOutlineSublayer];
//    [self setUpFilledSublayer];
//  }
//  return self;
//}
//
//- (void)setUpOutlineSublayer {
//  self.outlinedSublayer = [[CAShapeLayer alloc] init];
//  self.outlinedSublayer.fillColor = [UIColor clearColor].CGColor;
//  //  self.outlinedSublayer.lineWidth = [self outlineLineWidthForState:self.containedInputViewState];
//}
//
//- (void)setUpFilledSublayer {
//  self.filledSublayer = [[CAShapeLayer alloc] init];
//  self.filledSublayer.lineWidth = 0.0;
//  self.filledSublayerUnderline = [[CAShapeLayer alloc] init];
//  [self.filledSublayer addSublayer:self.filledSublayerUnderline];
//}
//
//- (void)applyOutlinedStyle:(BOOL)isOutlined
//                      view:(UIView *)view
//  floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
//   topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
//     isFloatingPlaceholder:(BOOL)isFloatingPlaceholder
//          outlineLineWidth:(CGFloat)outlineLineWidth {
//  if (!isOutlined) {
//    [self.outlinedSublayer removeFromSuperlayer];
//    return;
//  }
//  UIBezierPath *path = [self outlinePathWithViewBounds:view.bounds
//                              floatingPlaceholderFrame:floatingPlaceholderFrame
//                               topRowBottomRowDividerY:topRowBottomRowDividerY
//                                             lineWidth:outlineLineWidth
//                                 isFloatingPlaceholder:isFloatingPlaceholder];
//  self.outlinedSublayer.path = path.CGPath;
//  self.outlinedSublayer.lineWidth = outlineLineWidth;
//  if (self.outlinedSublayer.superlayer != view.layer) {
//    [view.layer insertSublayer:self.outlinedSublayer atIndex:0];
//  }
//}
//
//- (void)applyFilledStyle:(BOOL)isFilled
//                    view:(UIView *)view
// topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
//      underlineThickness:(CGFloat)underlineThickness {
//  if (!isFilled) {
//    [self.filledSublayer removeFromSuperlayer];
//    return;
//  }
//
//  UIBezierPath *filledSublayerPath =
//      [self filledSublayerPathWithTextFieldBounds:view.bounds
//                          topRowBottomRowDividerY:topRowBottomRowDividerY];
//  UIBezierPath *filledSublayerUnderlinePath =
//      [self filledSublayerUnderlinePathWithTextFieldBounds:view.bounds
//                                   topRowBottomRowDividerY:topRowBottomRowDividerY
//                                        underlineThickness:underlineThickness];
//  self.filledSublayer.path = filledSublayerPath.CGPath;
//  self.filledSublayerUnderline.path = filledSublayerUnderlinePath.CGPath;
//  if (self.filledSublayer.superlayer != view.layer) {
//    [view.layer insertSublayer:self.filledSublayer atIndex:0];
//  }
//}
//
//#pragma mark Path Drawing
//
//- (UIBezierPath *)outlinePathWithViewBounds:(CGRect)viewBounds
//                   floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
//                    topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
//                                  lineWidth:(CGFloat)lineWidth
//                      isFloatingPlaceholder:(BOOL)isFloatingPlaceholder {
//  UIBezierPath *path = [[UIBezierPath alloc] init];
//  CGFloat radius = kOutlinedContainerStyleCornerRadius;
//  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
//  CGFloat sublayerMinY = 0;
//  CGFloat sublayerMaxY = topRowBottomRowDividerY;
//
//  CGPoint startingPoint = CGPointMake(radius, sublayerMinY);
//  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - radius, sublayerMinY);
//  [path moveToPoint:startingPoint];
//  if (isFloatingPlaceholder) {
//    CGFloat leftLineBreak =
//        CGRectGetMinX(floatingPlaceholderFrame) - kFloatingPlaceholderOutlineSidePadding;
//    CGFloat rightLineBreak =
//        CGRectGetMaxX(floatingPlaceholderFrame) + kFloatingPlaceholderOutlineSidePadding;
//    [path addLineToPoint:CGPointMake(leftLineBreak, sublayerMinY)];
//    [path moveToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
//    [path addLineToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
//  } else {
//    [path addLineToPoint:topRightCornerPoint1];
//  }
//
//  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + radius);
//  [self addTopRightCornerToPath:path
//                      fromPoint:topRightCornerPoint1
//                        toPoint:topRightCornerPoint2
//                     withRadius:radius];
//
//  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - radius);
//  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - radius, sublayerMaxY);
//  [path addLineToPoint:bottomRightCornerPoint1];
//  [self addBottomRightCornerToPath:path
//                         fromPoint:bottomRightCornerPoint1
//                           toPoint:bottomRightCornerPoint2
//                        withRadius:radius];
//
//  CGPoint bottomLeftCornerPoint1 = CGPointMake(radius, sublayerMaxY);
//  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - radius);
//  [path addLineToPoint:bottomLeftCornerPoint1];
//  [self addBottomLeftCornerToPath:path
//                        fromPoint:bottomLeftCornerPoint1
//                          toPoint:bottomLeftCornerPoint2
//                       withRadius:radius];
//
//  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + radius);
//  CGPoint topLeftCornerPoint2 = CGPointMake(radius, sublayerMinY);
//  [path addLineToPoint:topLeftCornerPoint1];
//  [self addTopLeftCornerToPath:path
//                     fromPoint:topLeftCornerPoint1
//                       toPoint:topLeftCornerPoint2
//                    withRadius:radius];
//
//  return path;
//}
//
//- (UIBezierPath *)filledSublayerPathWithTextFieldBounds:(CGRect)viewBounds
//                                topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY {
//  UIBezierPath *path = [[UIBezierPath alloc] init];
//  CGFloat topRadius = kFilledContainerStyleTopCornerRadius;
//  CGFloat bottomRadius = 0;
//  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
//  CGFloat sublayerMinY = 0;
//  CGFloat sublayerMaxY = topRowBottomRowDividerY;
//
//  CGPoint startingPoint = CGPointMake(topRadius, sublayerMinY);
//  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - topRadius, sublayerMinY);
//  [path moveToPoint:startingPoint];
//  [path addLineToPoint:topRightCornerPoint1];
//
//  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + topRadius);
//  [self addTopRightCornerToPath:path
//                      fromPoint:topRightCornerPoint1
//                        toPoint:topRightCornerPoint2
//                     withRadius:topRadius];
//
//  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - bottomRadius);
//  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - bottomRadius, sublayerMaxY);
//  [path addLineToPoint:bottomRightCornerPoint1];
//  [self addBottomRightCornerToPath:path
//                         fromPoint:bottomRightCornerPoint1
//                           toPoint:bottomRightCornerPoint2
//                        withRadius:bottomRadius];
//
//  CGPoint bottomLeftCornerPoint1 = CGPointMake(bottomRadius, sublayerMaxY);
//  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - bottomRadius);
//  [path addLineToPoint:bottomLeftCornerPoint1];
//  [self addBottomLeftCornerToPath:path
//                        fromPoint:bottomLeftCornerPoint1
//                          toPoint:bottomLeftCornerPoint2
//                       withRadius:bottomRadius];
//
//  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + topRadius);
//  CGPoint topLeftCornerPoint2 = CGPointMake(topRadius, sublayerMinY);
//  [path addLineToPoint:topLeftCornerPoint1];
//  [self addTopLeftCornerToPath:path
//                     fromPoint:topLeftCornerPoint1
//                       toPoint:topLeftCornerPoint2
//                    withRadius:topRadius];
//
//  return path;
//}
//
//- (UIBezierPath *)filledSublayerUnderlinePathWithTextFieldBounds:(CGRect)viewBounds
//                                         topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
//                                              underlineThickness:(CGFloat)underlineThickness {
//  UIBezierPath *path = [[UIBezierPath alloc] init];
//  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
//  CGFloat sublayerMaxY = topRowBottomRowDividerY;
//  CGFloat sublayerMinY = sublayerMaxY - underlineThickness;
//
//  CGPoint startingPoint = CGPointMake(0, sublayerMinY);
//  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMinY);
//  [path moveToPoint:startingPoint];
//  [path addLineToPoint:topRightCornerPoint1];
//
//  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY);
//  [self addTopRightCornerToPath:path
//                      fromPoint:topRightCornerPoint1
//                        toPoint:topRightCornerPoint2
//                     withRadius:0];
//
//  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY);
//  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMaxY);
//  [path addLineToPoint:bottomRightCornerPoint1];
//  [self addBottomRightCornerToPath:path
//                         fromPoint:bottomRightCornerPoint1
//                           toPoint:bottomRightCornerPoint2
//                        withRadius:0];
//
//  CGPoint bottomLeftCornerPoint1 = CGPointMake(0, sublayerMaxY);
//  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY);
//  [path addLineToPoint:bottomLeftCornerPoint1];
//  [self addBottomLeftCornerToPath:path
//                        fromPoint:bottomLeftCornerPoint1
//                          toPoint:bottomLeftCornerPoint2
//                       withRadius:0];
//
//  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY);
//  CGPoint topLeftCornerPoint2 = CGPointMake(0, sublayerMinY);
//  [path addLineToPoint:topLeftCornerPoint1];
//  [self addTopLeftCornerToPath:path
//                     fromPoint:topLeftCornerPoint1
//                       toPoint:topLeftCornerPoint2
//                    withRadius:0];
//
//  return path;
//}
//
//- (void)addTopRightCornerToPath:(UIBezierPath *)path
//                      fromPoint:(CGPoint)point1
//                        toPoint:(CGPoint)point2
//                     withRadius:(CGFloat)radius {
//  CGFloat startAngle = -(CGFloat)(M_PI / 2);
//  CGFloat endAngle = 0;
//  CGPoint center = CGPointMake(point1.x, point2.y);
//  [path addArcWithCenter:center
//                  radius:radius
//              startAngle:startAngle
//                endAngle:endAngle
//               clockwise:YES];
//}
//
//- (void)addBottomRightCornerToPath:(UIBezierPath *)path
//                         fromPoint:(CGPoint)point1
//                           toPoint:(CGPoint)point2
//                        withRadius:(CGFloat)radius {
//  CGFloat startAngle = 0;
//  CGFloat endAngle = -(CGFloat)((M_PI * 3) / 2);
//  CGPoint center = CGPointMake(point2.x, point1.y);
//  [path addArcWithCenter:center
//                  radius:radius
//              startAngle:startAngle
//                endAngle:endAngle
//               clockwise:YES];
//}
//
//- (void)addBottomLeftCornerToPath:(UIBezierPath *)path
//                        fromPoint:(CGPoint)point1
//                          toPoint:(CGPoint)point2
//                       withRadius:(CGFloat)radius {
//  CGFloat startAngle = -(CGFloat)((M_PI * 3) / 2);
//  CGFloat endAngle = -(CGFloat)M_PI;
//  CGPoint center = CGPointMake(point1.x, point2.y);
//  [path addArcWithCenter:center
//                  radius:radius
//              startAngle:startAngle
//                endAngle:endAngle
//               clockwise:YES];
//}
//
//- (void)addTopLeftCornerToPath:(UIBezierPath *)path
//                     fromPoint:(CGPoint)point1
//                       toPoint:(CGPoint)point2
//                    withRadius:(CGFloat)radius {
//  CGFloat startAngle = -(CGFloat)M_PI;
//  CGFloat endAngle = -(CGFloat)(M_PI / 2);
//  CGPoint center = CGPointMake(point1.x + radius, point2.y + radius);
//  [path addArcWithCenter:center
//                  radius:radius
//              startAngle:startAngle
//                endAngle:endAngle
//               clockwise:YES];
//}
//
//@end
