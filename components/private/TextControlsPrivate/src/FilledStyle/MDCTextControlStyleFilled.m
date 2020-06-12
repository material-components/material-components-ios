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

#import "MDCTextControlStyleFilled.h"

#import <Foundation/Foundation.h>

#import "MDCTextControl.h"
#import "MDCTextControlVerticalPositioningReferenceFilled.h"
#include "MaterialAvailability.h"
#import "UIBezierPath+MDCTextControlStyle.h"

static const CGFloat kFilledContainerStyleTopCornerRadius = (CGFloat)4.0;

@interface MDCTextControlStyleFilled () <CAAnimationDelegate>

@property(strong, nonatomic) CAShapeLayer *filledSublayer;
@property(strong, nonatomic) NSMutableDictionary<NSNumber *, UIColor *> *filledBackgroundColors;

@end

@implementation MDCTextControlStyleFilled

#pragma mark Object Lifecycle

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCTextControlStyleFilledInit];
  }
  return self;
}

#pragma mark Setup

- (void)commonMDCTextControlStyleFilledInit {
  [self setUpFilledBackgroundColors];
  [self setUpFilledBackgroundSublayer];
}

- (void)setUpFilledBackgroundColors {
  self.filledBackgroundColors = [NSMutableDictionary new];
  UIColor *filledBackgroundColor = [UIColor blackColor];
  filledBackgroundColor = [filledBackgroundColor colorWithAlphaComponent:(CGFloat)0.05];
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    filledBackgroundColor = [UIColor secondarySystemBackgroundColor];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

  self.filledBackgroundColors[@(MDCTextControlStateNormal)] = filledBackgroundColor;
  self.filledBackgroundColors[@(MDCTextControlStateEditing)] = filledBackgroundColor;
  self.filledBackgroundColors[@(MDCTextControlStateDisabled)] = filledBackgroundColor;
}

- (void)setUpFilledBackgroundSublayer {
  self.filledSublayer = [[CAShapeLayer alloc] init];
  self.filledSublayer.lineWidth = 0.0;
}

#pragma mark Accessors

- (UIColor *)filledBackgroundColorForState:(MDCTextControlState)state {
  return self.filledBackgroundColors[@(state)];
}

- (void)setFilledBackgroundColor:(nonnull UIColor *)filledBackgroundColor
                        forState:(MDCTextControlState)state {
  self.filledBackgroundColors[@(state)] = filledBackgroundColor;
}

#pragma mark MDCTextControl

- (void)applyStyleToTextControl:(UIView<MDCTextControl> *)textControl
              animationDuration:(NSTimeInterval)animationDuration {
  [super applyStyleToTextControl:textControl animationDuration:animationDuration];
  [self applyFilledStyleToView:textControl
                         state:textControl.textControlState
                containerFrame:textControl.containerFrame
             animationDuration:animationDuration];
}

- (void)removeStyleFrom:(id<MDCTextControl>)textControl {
  [super removeStyleFrom:textControl];
  [self.filledSublayer removeFromSuperlayer];
}

- (id<MDCTextControlVerticalPositioningReference>)
    positioningReferenceWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                              normalFontLineHeight:(CGFloat)normalFontLineHeight
                                     textRowHeight:(CGFloat)textRowHeight
                                  numberOfTextRows:(CGFloat)numberOfTextRows
                                           density:(CGFloat)density
                          preferredContainerHeight:(CGFloat)preferredContainerHeight {
  return [[MDCTextControlVerticalPositioningReferenceFilled alloc]
      initWithFloatingFontLineHeight:floatingLabelHeight
                normalFontLineHeight:normalFontLineHeight
                       textRowHeight:textRowHeight
                    numberOfTextRows:numberOfTextRows
                             density:density
            preferredContainerHeight:preferredContainerHeight];
}

- (nonnull MDCTextControlHorizontalPositioningReference *)horizontalPositioningReference {
  MDCTextControlHorizontalPositioningReference *positioningReference =
      [[MDCTextControlHorizontalPositioningReference alloc] init];
  return positioningReference;
}

#pragma mark Custom Styling

- (void)applyFilledStyleToView:(UIView *)view
                         state:(MDCTextControlState)state
                containerFrame:(CGRect)containerFrame
             animationDuration:(NSTimeInterval)animationDuration {
  self.filledSublayer.fillColor = [self.filledBackgroundColors[@(state)] CGColor];
  CGFloat containerHeight = CGRectGetMaxY(containerFrame);
  UIBezierPath *filledSublayerBezier = [self filledSublayerPathWithTextFieldBounds:view.bounds
                                                                   containerHeight:containerHeight];
  self.filledSublayer.path = filledSublayerBezier.CGPath;
  if (self.filledSublayer.superlayer != view.layer) {
    [view.layer insertSublayer:self.filledSublayer atIndex:0];
  }
}

#pragma mark Path Drawing

- (UIBezierPath *)filledSublayerPathWithTextFieldBounds:(CGRect)viewBounds
                                        containerHeight:(CGFloat)containerHeight {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat topRadius = kFilledContainerStyleTopCornerRadius;
  CGFloat bottomRadius = 0;
  CGFloat textFieldWidth = CGRectGetWidth(viewBounds);
  CGFloat sublayerMinY = 0;
  CGFloat sublayerMaxY = containerHeight;

  CGPoint startingPoint = CGPointMake(topRadius, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - topRadius, sublayerMinY);
  [path moveToPoint:startingPoint];
  [path addLineToPoint:topRightCornerPoint1];

  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + topRadius);
  [path mdc_addTopRightCornerFromPoint:topRightCornerPoint1
                               toPoint:topRightCornerPoint2
                            withRadius:topRadius];

  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - bottomRadius);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - bottomRadius, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [path mdc_addBottomRightCornerFromPoint:bottomRightCornerPoint1
                                  toPoint:bottomRightCornerPoint2
                               withRadius:bottomRadius];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(bottomRadius, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - bottomRadius);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [path mdc_addBottomLeftCornerFromPoint:bottomLeftCornerPoint1
                                 toPoint:bottomLeftCornerPoint2
                              withRadius:bottomRadius];

  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + topRadius);
  CGPoint topLeftCornerPoint2 = CGPointMake(topRadius, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [path mdc_addTopLeftCornerFromPoint:topLeftCornerPoint1
                              toPoint:topLeftCornerPoint2
                           withRadius:topRadius];

  return path;
}


@end
