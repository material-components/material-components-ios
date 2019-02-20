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

#import "MDCCardCollectionCell.h"

@protocol MDCCardCollectionCellRippleDelegate;

@interface MDCCardCollectionCell (Private)

/**
 To turn on the beta behavior for cards that includes the ripple integration and the state support
 please set this runtime flag to YES.

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableBetaBehavior;

/**
 This is used to integrate the Ripple Beta component into the card collection cell.

 Warning: Please do not conform to this as this is used to integrate the Beta Ripple component.
 */
@property(nonatomic, weak, nullable) id<MDCCardCollectionCellRippleDelegate> rippleDelegate;

// These properties matches the same properties in MDCCardCollectionCell.m
@property(nonatomic, strong, nonnull) UIView *rippleView;
@property(nonatomic, getter=isDragged) BOOL dragged;
@property(nonatomic, strong, nullable) UIImageView *selectedImageView;

- (void)updateShadowElevation;
- (void)updateBorderColor;
- (void)updateBorderWidth;
- (void)updateShadowColor;
- (void)updateImage;
- (void)updateImageAlignment;
- (void)updateImageTintColor;
- (nullable UIImage *)imageForState:(MDCCardCellState)state;
- (nullable UIColor *)imageTintColorForState:(MDCCardCellState)state;

@end

/**
 This protocol is used to integrate the Ripple Beta component into Cards. Please do not conform
 to this protocol.
 */
__deprecated_msg("This protocol is temporarily used to incorporate the Ripple Beta component into "
                 "Cards. This is deprecated, please do not conform to this protocol.")
    @protocol MDCCardCollectionCellRippleDelegate<NSObject>

- (void)cardCellRippleDelegateSetSelected:(BOOL)selected;
- (void)cardCellRippleDelegateSetHighlighted:(BOOL)highlighted;
- (void)cardCellRippleDelegateSetSelectable:(BOOL)selectable;
- (void)cardCellRippleDelegateSetDragged:(BOOL)dragged;
- (nullable UIImage *)cardCellRippleDelegateUpdateImage:(nullable UIImage *)image;
- (nullable UIColor *)cardCellRippleDelegateUpdateImageTintColor:(nullable UIColor *)imageTintColor;
- (MDCCardCellState)cardCellRippleDelegateState;
- (void)cardCellRippleDelegateTouchesBegan:(nullable NSSet<UITouch *> *)touches
                                 withEvent:(nullable UIEvent *)event;
- (void)cardCellRippleDelegateTouchesEnded:(nullable NSSet<UITouch *> *)touches
                                 withEvent:(nullable UIEvent *)event;
- (void)cardCellRippleDelegateTouchesCancelled:(nullable NSSet<UITouch *> *)touches
                                     withEvent:(nullable UIEvent *)event;
- (void)cardCellRippleDelegateTouchesMoved:(nullable NSSet<UITouch *> *)touches
                                 withEvent:(nullable UIEvent *)event;

@end
