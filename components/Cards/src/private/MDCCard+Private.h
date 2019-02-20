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

#import "MDCCard.h"

@protocol MDCCardRippleDelegate;

@interface MDCCard (Private)

// These properties matches the same properties in MDCCard.m
@property(nonatomic, strong, nonnull) UIView *rippleView;

/**
 This is used to integrate the Ripple Beta component into the card collection cell.
 Warning: Please do not conform to this as this is used to integrate the Beta Ripple component.
 */
@property(nonatomic, weak, nullable) id<MDCCardRippleDelegate> rippleDelegate;

@end

/**
 This protocol is used to integrate the Ripple Beta component into Cards. Please do not conform
 to this protocol.
 */
__deprecated_msg("This protocol is temporarily used to incorporate the Ripple Beta component into "
                 "Cards. This is deprecated, please do not conform to this protocol.")
    @protocol MDCCardRippleDelegate<NSObject>

- (void)cardRippleDelegateSetHighlighted:(BOOL)highlighted;
- (void)cardRippleDelegateTouchesBegan:(nullable NSSet<UITouch *> *)touches
                             withEvent:(nullable UIEvent *)event;
- (void)cardRippleDelegateTouchesEnded:(nullable NSSet<UITouch *> *)touches
                             withEvent:(nullable UIEvent *)event;
- (void)cardRippleDelegateTouchesCancelled:(nullable NSSet<UITouch *> *)touches
                                 withEvent:(nullable UIEvent *)event;
- (void)cardRippleDelegateTouchesMoved:(nullable NSSet<UITouch *> *)touches
                             withEvent:(nullable UIEvent *)event;

@end
