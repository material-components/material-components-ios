/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

/** Completion block signature for all ink animations. */
typedef void (^MDCInkCompletionBlock)(void);

/** Ink styles. */
typedef NS_ENUM(NSInteger, MDCInkStyle) {
  MDCInkStyleBounded,  /** Ink is clipped to the view's bounds. */
  MDCInkStyleUnbounded /** Ink is not clipped to the view's bounds. */
};

/**
 A UIView that draws and animates the Material Design ink effect for touch interactions.

 There are two kinds of ink:

 Bounded ink: Ink that spreads from a point and is contained in the bounds of a UI element such as a
 button. The ink is visually clipped to the bounds of the UI element. Bounded ink is the most
 commonly-used ink in the system. Examples include basic Material buttons, list menu items, and tile
 grids.

 Unbounded ink: Ink that spreads out from a point "on top" of other UI elements. It typically
 reaches a maximum circle radius and then fades, unclipped by other UI elements. Typically used
 when interacting with small UI elements such as navigation bar icons or slider "thumb" controls.
 Examples include overflow menus, icon toggle buttons, and phone dialer keys.

 Note that the two kinds of ink are designed to have different animation parameters, that is,
 bounded ink isn't just clipped unbounded ink. Whether the ink is bounded or not depends on the kind
 of UI element the user is interacting with.
 */
@interface MDCInkView : UIView

/**
 The style of ink for this view. Defaults to MDCInkStyleBounded.

 Changes only affect subsequent animations, not animations in progress.
 */
@property(nonatomic, assign) MDCInkStyle inkStyle;

/** The foreground color of the ink. The default value is defaultInkColor. */
@property(nonatomic, strong, null_resettable) UIColor *inkColor;

/** Default color used for ink if no color is specified. */
@property(nonatomic, strong, readonly, nonnull) UIColor *defaultInkColor;

/**
 Maximum radius of the ink. If the radius <= 0 then half the length of the diagonal of self.bounds
 is used. This value is ignored if @c inkStyle is set to |MDCInkStyleBounded|.
 */
@property(nonatomic, assign) CGFloat maxRippleRadius;

/**
 Use a custom center for the ink splash. If YES, then customInkCenter is used, otherwise the
 center of self.bounds is used. Default is NO.
 */
@property(nonatomic, assign) BOOL usesCustomInkCenter;

/**
 Custom center for the ink splash in the view’s coordinate system.

 Ignored if usesCustomInkCenter is not set.
 */
@property(nonatomic, assign) CGPoint customInkCenter;

/**
 Start the first part of the "press and release" animation at a particular point.

 The "press and release" animation begins by fading in the ink ripple when this method is called.

 @param point The user interaction position in the view’s coordinate system.
 @param completionBlock Block called after the completion of the animation.
 */
- (void)startTouchBeganAnimationAtPoint:(CGPoint)point
                             completion:(nullable MDCInkCompletionBlock)completionBlock;

/**
 Start the second part of the "press and release" animation at a particular point.

 The "press and release" animation ends by completing the ink ripple expansion while fading out when
 this method is called.

 @param point The user interaction position in the view’s coordinate system.
 @param completionBlock Block called after the completion of the animation.
 */
- (void)startTouchEndedAnimationAtPoint:(CGPoint)point
                             completion:(nullable MDCInkCompletionBlock)completionBlock;

/**
 Cancel all animations.

 @param animated If false, remove the animations immediately.
 */
- (void)cancelAllAnimationsAnimated:(BOOL)animated;

@end
