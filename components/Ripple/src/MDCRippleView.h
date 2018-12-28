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

@protocol MDCRippleViewDelegate;

typedef void (^MDCRippleCompletionBlock)(void);

typedef NS_ENUM(NSInteger, MDCRippleStyle) {
  MDCRippleStyleBounded = 0,
  MDCRippleStyleUnbounded,
};

@interface MDCRippleView : UIView

@property (nonatomic, weak, nullable) id<MDCRippleViewDelegate> rippleViewDelegate;
@property (nonatomic, assign) MDCRippleStyle rippleStyle;

@property(nonatomic, strong, nonnull) UIColor *rippleColor;
- (void)setActiveRippleColor:(UIColor *)rippleColor;

- (void)cancelAllRipplesAnimated:(BOOL)animated;
- (void)fadeInRippleAnimated:(BOOL)animated
                  completion:(nullable MDCRippleCompletionBlock)completion;
- (void)fadeOutRippleAnimated:(BOOL)animated
                   completion:(nullable MDCRippleCompletionBlock)completion;

- (void)BeginRipplePressDownAtPoint:(CGPoint)point
                           animated:(BOOL)animated
                         completion:(nullable MDCRippleCompletionBlock)completion;

- (void)BeginRipplePressUpAnimated:(BOOL)animated
                        completion:(nullable MDCRippleCompletionBlock)completion;

@end

@protocol MDCRippleViewDelegate <NSObject>

@optional

- (void)ripplePressDownAnimationDidBegin:(nonnull MDCRippleView *)rippleView;
- (void)ripplePressDownAnimationDidEnd:(nonnull MDCRippleView *)rippleView;
- (void)ripplePressUpAnimationDidBegin:(nonnull MDCRippleView *)rippleView;
- (void)ripplePressUpAnimationDidEnd:(nonnull MDCRippleView *)rippleView;

@end
