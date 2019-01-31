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

#import <UIKit/UIKit.h>

//#import "SimpleTextFieldLayoutUtils.h"
//#import "MaterialColorScheme.h"
//#import "MaterialContainerScheme.h"
//#import "SimpleTextFieldColorScheme.h"
//#import "MDCContainedInputViewState.h"

@protocol MDCContainedInputViewColorScheming;
/**
 MDCInputViewContainerStyle dictates what type of text field it will be from a cosmetic standpoint.
 The values are derived from the styles outlined in the Material Guidelines for Text Fields.
 */
typedef NS_ENUM(NSUInteger, MDCContainedInputViewState) {
  MDCContainedInputViewStateNormal,
  MDCContainedInputViewStateFocused,
  MDCContainedInputViewStateActivated,
  MDCContainedInputViewStateErrored,
  MDCContainedInputViewStateDisabled,
};

@protocol MDCContainedInputView <NSObject>
@property (nonatomic, assign, readonly) MDCContainedInputViewState containedInputViewState;
@optional
@property (strong, nonatomic, readonly) UILabel *placeholderLabel;
@property (strong, nonatomic, readonly) UILabel *leadingUnderlineLabel;
@property (strong, nonatomic, readonly) UILabel *trailingUnderlineLabel;
@end

@interface MDCContainerStyle : NSObject
- (id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:(MDCContainedInputViewState)state;
//- (void)applyStyleTo:(id<MDCContainedInputView>)containedInputView;
- (void)applyStyleTo:(id<MDCContainedInputView>)containedInputView
withContainedInputViewColorScheming:(id<MDCContainedInputViewColorScheming>)colorScheme;
- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView;
@end

@interface MDCContainerStyleFilled : MDCContainerStyle
@end

@interface MDCContainerStyleOutlined : MDCContainerStyle
@end


@interface MDCContainerStylePathDrawingUtils : NSObject

+ (void)addTopRightCornerToPath:(UIBezierPath *)path
                      fromPoint:(CGPoint)point1
                        toPoint:(CGPoint)point2
                     withRadius:(CGFloat)radius;
+ (void)addBottomRightCornerToPath:(UIBezierPath *)path
                         fromPoint:(CGPoint)point1
                           toPoint:(CGPoint)point2
                        withRadius:(CGFloat)radius;
+ (void)addBottomLeftCornerToPath:(UIBezierPath *)path
                        fromPoint:(CGPoint)point1
                          toPoint:(CGPoint)point2
                       withRadius:(CGFloat)radius;
+ (void)addTopLeftCornerToPath:(UIBezierPath *)path
                     fromPoint:(CGPoint)point1
                       toPoint:(CGPoint)point2
                    withRadius:(CGFloat)radius;
@end


//typedef NS_ENUM(NSUInteger, MDCInputViewContainerStyle) {
//  MDCInputViewContainerStyleNone,
//  MDCInputViewContainerStyleFilled,
//  MDCInputViewContainerStyleOutline,
//};

//@interface MDCInputViewContainerStyler : NSObject
//
//@property(strong, nonatomic) CAShapeLayer *outlinedSublayer;
//@property(strong, nonatomic) CAShapeLayer *filledSublayer;
//@property(strong, nonatomic) CAShapeLayer *filledSublayerUnderline;
//
//- (void)applyOutlinedStyle:(BOOL)isOutlined
//                      view:(UIView *)view
//  floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
//   topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
//     isFloatingPlaceholder:(BOOL)isFloatingPlaceholder
//          outlineLineWidth:(CGFloat)outlineLineWidth;
//
//- (void)applyFilledStyle:(BOOL)isFilled
//                    view:(UIView *)view
// topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
//      underlineThickness:(CGFloat)underlineThickness;

//@end
