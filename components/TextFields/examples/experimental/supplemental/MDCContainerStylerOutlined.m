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

#import "MDCContainerStylerPathDrawingUtils.h"

#import "MDCContainerStylerOutlined.h"

#import <Foundation/Foundation.h>

static const CGFloat kOutlinedContainerStylerCornerRadius = (CGFloat)4.0;
static const CGFloat kFloatingLabelOutlineSidePadding = (CGFloat)5.0;

static const CGFloat kMinPaddingBetweenTopAndFloatingLabel = (CGFloat)6.0;
static const CGFloat kMaxPaddingBetweenTopAndFloatingLabel = (CGFloat)10.0;
static const CGFloat kMinPaddingBetweenFloatingLabelAndText = (CGFloat)4.0;
static const CGFloat kMaxPaddingBetweenFloatingLabelAndText = (CGFloat)8.0;
static const CGFloat kMinPaddingBetweenTextAndBottom = (CGFloat)6.0;
static const CGFloat kMaxPaddingBetweenTextAndBottom = (CGFloat)10.0;

@implementation MDCContainerStylerOutlinedPositioningDelegate
@synthesize paddingBetweenTopAndFloatingLabel = _paddingBetweenTopAndFloatingLabel;
@synthesize paddingBetweenTopAndNormalLabel = _paddingBetweenTopAndNormalLabel;
@synthesize paddingBetweenFloatingLabelAndText = _paddingBetweenFloatingLabelAndText;
@synthesize paddingBetweenTextAndBottom = _paddingBetweenTextAndBottom;
@synthesize containerHeight = _containerHeight;
@synthesize paddingAroundAssistiveLabels = _paddingAroundAssistiveLabels;

- (instancetype)initWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                          normalFontLineHeight:(CGFloat)normalFontLineHeight
                                 textRowHeight:(CGFloat)textRowHeight
                              numberOfTextRows:(CGFloat)numberOfTextRows
                                       density:(CGFloat)density
                      preferredContainerHeight:(CGFloat)preferredContainerHeight {
  self = [super init];
  if (self) {
    [self updatePaddingValuesWithFoatingFontLineHeight:(CGFloat)floatingLabelHeight
                                  normalFontLineHeight:(CGFloat)normalFontLineHeight
                                         textRowHeight:(CGFloat)textRowHeight
                                      numberOfTextRows:(CGFloat)numberOfTextRows
                                               density:(CGFloat)density
                              preferredContainerHeight:(CGFloat)preferredContainerHeight];
  }
  return self;
}

- (void)updatePaddingValuesWithFoatingFontLineHeight:(CGFloat)floatingLabelHeight
                                normalFontLineHeight:(CGFloat)normalFontLineHeight
                                       textRowHeight:(CGFloat)textRowHeight
                                    numberOfTextRows:(CGFloat)numberOfTextRows
                                             density:(CGFloat)density
                            preferredContainerHeight:(CGFloat)preferredContainerHeight {
  if (preferredContainerHeight > 0) {
    CGFloat minimumHeight =
        [self calculateHeightWithFoatingLabelHeight:floatingLabelHeight
                                      textRowHeight:textRowHeight
                                   numberOfTextRows:numberOfTextRows
                  paddingBetweenTopAndFloatingLabel:kMinPaddingBetweenTopAndFloatingLabel
                 paddingBetweenFloatingLabelAndText:kMinPaddingBetweenFloatingLabelAndText
                        paddingBetweenTextAndBottom:kMinPaddingBetweenTextAndBottom];
    if (preferredContainerHeight > minimumHeight) {
      CGFloat difference = preferredContainerHeight - minimumHeight;
      CGFloat sumOfMinimumPaddingValues = kMinPaddingBetweenTopAndFloatingLabel +
                                          kMinPaddingBetweenFloatingLabelAndText +
                                          kMinPaddingBetweenTextAndBottom;
      _paddingBetweenTopAndFloatingLabel =
          kMinPaddingBetweenTopAndFloatingLabel +
          ((kMinPaddingBetweenTopAndFloatingLabel / sumOfMinimumPaddingValues) * difference);
      _paddingBetweenFloatingLabelAndText =
          kMinPaddingBetweenFloatingLabelAndText +
          ((kMinPaddingBetweenFloatingLabelAndText / sumOfMinimumPaddingValues) * difference);
      _paddingBetweenTextAndBottom =
          kMinPaddingBetweenTextAndBottom +
          ((kMinPaddingBetweenTextAndBottom / sumOfMinimumPaddingValues) * difference);
    } else {
      _paddingBetweenTopAndFloatingLabel = kMinPaddingBetweenTopAndFloatingLabel;
      _paddingBetweenFloatingLabelAndText = kMinPaddingBetweenFloatingLabelAndText;
      _paddingBetweenTextAndBottom = kMinPaddingBetweenTextAndBottom;
    }
  } else {
    CGFloat standardizedDensity = [self standardizeDensity:density];
    CGFloat paddingBetweenTopAndFloatingLabelRange =
        kMaxPaddingBetweenTopAndFloatingLabel - kMinPaddingBetweenTopAndFloatingLabel;
    CGFloat paddingBetweenFloatingLabelAndTextRange =
        kMaxPaddingBetweenFloatingLabelAndText - kMinPaddingBetweenFloatingLabelAndText;
    CGFloat paddingBetweenTextAndBottomRange =
        kMaxPaddingBetweenTextAndBottom - kMinPaddingBetweenTextAndBottom;
    CGFloat paddingBetweenTopAndFloatingLabelAddition =
        paddingBetweenTopAndFloatingLabelRange * (1 - standardizedDensity);
    CGFloat paddingBetweenFloatingLabelAndTextAddition =
        paddingBetweenFloatingLabelAndTextRange * (1 - standardizedDensity);
    CGFloat paddingBetweenTextAndBottomAddition =
        paddingBetweenTextAndBottomRange * (1 - standardizedDensity);
    _paddingBetweenTopAndFloatingLabel =
        kMinPaddingBetweenTopAndFloatingLabel + paddingBetweenTopAndFloatingLabelAddition;
    _paddingBetweenFloatingLabelAndText =
        kMinPaddingBetweenFloatingLabelAndText + paddingBetweenFloatingLabelAndTextAddition;
    _paddingBetweenTextAndBottom =
        kMinPaddingBetweenTextAndBottom + paddingBetweenTextAndBottomAddition;
  }

  _containerHeight = [self calculateHeightWithFoatingLabelHeight:floatingLabelHeight
                                                   textRowHeight:textRowHeight
                                                numberOfTextRows:numberOfTextRows
                               paddingBetweenTopAndFloatingLabel:_paddingBetweenTopAndFloatingLabel
                              paddingBetweenFloatingLabelAndText:_paddingBetweenFloatingLabelAndText
                                     paddingBetweenTextAndBottom:_paddingBetweenTextAndBottom];
  CGFloat halfOfNormalFontLineHeight = (CGFloat)0.5 * normalFontLineHeight;
  if (numberOfTextRows > 1) {
    CGFloat heightWithOneRow =
        [self calculateHeightWithFoatingLabelHeight:floatingLabelHeight
                                      textRowHeight:textRowHeight
                                   numberOfTextRows:1
                  paddingBetweenTopAndFloatingLabel:_paddingBetweenTopAndFloatingLabel
                 paddingBetweenFloatingLabelAndText:_paddingBetweenFloatingLabelAndText
                        paddingBetweenTextAndBottom:_paddingBetweenTextAndBottom];
    CGFloat halfOfHeightWithOneRow = (CGFloat)0.5 * heightWithOneRow;
    _paddingBetweenTopAndNormalLabel = halfOfHeightWithOneRow - halfOfNormalFontLineHeight;
  } else {
    CGFloat halfOfContainerHeight = (CGFloat)0.5 * _containerHeight;
    _paddingBetweenTopAndNormalLabel = halfOfContainerHeight - halfOfNormalFontLineHeight;
  }
}

- (CGFloat)standardizeDensity:(CGFloat)density {
  CGFloat standardizedDensity = density;
  if (standardizedDensity < 0) {
    standardizedDensity = 0;
  } else if (standardizedDensity > 1) {
    standardizedDensity = 1;
  }
  return standardizedDensity;
}

- (CGFloat)calculateHeightWithFoatingLabelHeight:(CGFloat)floatingLabelHeight
                                   textRowHeight:(CGFloat)textRowHeight
                                numberOfTextRows:(CGFloat)numberOfTextRows
               paddingBetweenTopAndFloatingLabel:(CGFloat)paddingBetweenTopAndFloatingLabel
              paddingBetweenFloatingLabelAndText:(CGFloat)paddingBetweenFloatingLabelAndText
                     paddingBetweenTextAndBottom:(CGFloat)paddingBetweenTextAndBottom {
  CGFloat totalTextHeight = numberOfTextRows * textRowHeight;
  return paddingBetweenTopAndFloatingLabel + floatingLabelHeight +
         paddingBetweenFloatingLabelAndText + totalTextHeight + paddingBetweenTextAndBottom;
}

- (CGFloat)paddingBetweenTopAndFloatingLabel {
  return _paddingBetweenTopAndFloatingLabel;
}

- (CGFloat)paddingBetweenTopAndNormalLabel {
  return _paddingBetweenTopAndNormalLabel;
}

- (CGFloat)paddingBetweenFloatingLabelAndText {
  return _paddingBetweenFloatingLabelAndText;
}

- (CGFloat)paddingBetweenTextAndBottom {
  return _paddingBetweenTextAndBottom;
}

- (CGFloat)paddingAroundAssistiveLabels {
  return _paddingAroundAssistiveLabels;
}

- (CGFloat)containerHeight {
  return _containerHeight;
}

@end

@implementation MDCContainedInputViewColorSchemeOutlined
@end

@interface MDCContainerStylerOutlined ()

@property(strong, nonatomic) CAShapeLayer *outlinedSublayer;

@end

@implementation MDCContainerStylerOutlined
@synthesize positioningDelegate = _positioningDelegate;

- (instancetype)initWithPositioningDelegate:
    (id<MDCContainedInputViewStylerPositioningDelegate>)positioningDelegate {
  self = [super initWithPositioningDelegate:positioningDelegate];
  if (self) {
    _positioningDelegate = positioningDelegate;
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
      containedInputView.floatingLabelState == MDCContainedInputViewLabelStateFloating;
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

- (id<NewPositioningDelegate>)
    positioningDelegateWithFoatingFontLineHeight:(CGFloat)floatingFontLineHeight
                            normalFontLineHeight:(CGFloat)normalFontLineHeight
                                   textRowHeight:(CGFloat)textRowHeight
                                numberOfTextRows:(CGFloat)numberOfTextRows
                                         density:(CGFloat)density
                        preferredContainerHeight:(CGFloat)preferredContainerHeight {
  return [[MDCContainerStylerOutlinedPositioningDelegate alloc]
      initWithFloatingFontLineHeight:floatingFontLineHeight
                normalFontLineHeight:normalFontLineHeight
                       textRowHeight:textRowHeight
                    numberOfTextRows:numberOfTextRows
                             density:density
            preferredContainerHeight:preferredContainerHeight];
}

@end
