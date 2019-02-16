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

#import "MDCContainerStylePathDrawingUtils.h"

#import "MDCContainerStyleOutlined.h"

#import <Foundation/Foundation.h>

static const CGFloat kOutlinedContainerStyleCornerRadius = (CGFloat)4.0;
static const CGFloat kFloatingPlaceholderOutlineSidePadding = (CGFloat)5.0;

@implementation MDCContainedInputViewColorSchemeOutlined
@end

@interface MDCContainerStyleOutlined ()

@property(strong, nonatomic) CAShapeLayer *outlinedSublayer;

@end

@implementation MDCContainerStyleOutlined
@synthesize densityInformer = _densityInformer;

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
    case MDCContainedInputViewStateActivated:
      break;
    case MDCContainedInputViewStateDisabled:
      break;
    case MDCContainedInputViewStateErrored:
      outlineColor = colorScheme.errorColor;
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
  CGRect placeholderFrame = containedInputView.placeholderLabel.frame;
  BOOL isFloatingPlaceholder =
      containedInputView.placeholderState == MDCContainedInputViewPlaceholderStateFloating;
  CGFloat topRowBottomRowDividerY = CGRectGetMaxY(containedInputView.containerRect);
  CGFloat lineWidth = [self outlineLineWidthForState:containedInputView.containedInputViewState];
  [self applyStyleTo:uiView
             placeholderFrame:placeholderFrame
      topRowBottomRowDividerY:topRowBottomRowDividerY
        isFloatingPlaceholder:isFloatingPlaceholder
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

- (id<MDCContainedInputViewStyleDensityInforming>)densityInformer {
  if (_densityInformer) {
    return _densityInformer;
  }
  return [[MDCContainerStyleOutlinedDensityInformer alloc] init];
}

@end

@implementation MDCContainerStyleOutlinedDensityInformer

- (CGFloat)floatingPlaceholderFontSize {
  CGFloat scaleFactor = ((CGFloat)41 / (CGFloat)55);
  return scaleFactor * [UIFont systemFontSize];
}

- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight {
  return (CGFloat)0 - ((CGFloat)0.5 * floatingPlaceholderHeight);
}

- (CGFloat)contentAreaTopPaddingWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY {
  return [self normalContentAreaTopPadding];
}

@end
