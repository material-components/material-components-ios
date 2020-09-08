// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

// TODO(b/151929968): Delete import of delegate headers when client code has been migrated to no
// longer import delegates as transitive dependencies.
#import "MDCInkViewDelegate.h"

@protocol MDCInkViewDelegate;

/** Completion block signature for all ink animations. */
typedef void (^MDCInkCompletionBlock)(void);

/** Ink styles. */
typedef NS_ENUM(NSInteger, MDCInkStyle) {
  /** Ink is clipped to the view's bounds. */
  MDCInkStyleBounded,
  /** Ink is not clipped to the view's bounds. */
  MDCInkStyleUnbounded
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
__deprecated_msg("Please use MDCRippleView instead.") @interface MDCInkView : UIView

/**
 Ink view animation delegate. Clients set this delegate to receive updates when ink animations
 start and end.
 */
@property(nonatomic, weak, nullable) id<MDCInkViewDelegate> animationDelegate;

/**
 The style of ink for this view. Defaults to MDCInkStyleBounded.

 Changes only affect subsequent animations, not animations in progress.
 */
@property(nonatomic, assign) MDCInkStyle inkStyle;

/** The foreground color of the ink. The default value is defaultInkColor. */
@property(nonatomic, strong, null_resettable) UIColor *inkColor UI_APPEARANCE_SELECTOR;

/** Default color used for ink if no color is specified. */
@property(nonatomic, strong, readonly, nonnull) UIColor *defaultInkColor;

/**
 Maximum radius of the ink. If the radius <= 0 then half the length of the diagonal of self.bounds
 is used. This value is ignored if @c inkStyle is set to MDCInkStyleBounded and @c
 usesLegacyInkLayer is set to NO.
 */
@property(nonatomic, assign) CGFloat maxRippleRadius;

/**
 Use the older legacy version of the ink ripple. Default is YES.
 */
@property(nonatomic, assign) BOOL usesLegacyInkRipple;

/**
 Use a custom center for the ink splash. If YES, then customInkCenter is used, otherwise the
 center of self.bounds is used. Default is NO.

 Affects behavior only if usesLegacyInkRipple is enabled.
 */
@property(nonatomic, assign) BOOL usesCustomInkCenter;

/**
 Custom center for the ink splash in the view’s coordinate system.

 Affects behavior only if both usesCustomInkCenter and usesLegacyInkRipple are enabled.
 */
@property(nonatomic, assign) CGPoint customInkCenter;

/**
 A block that is invoked when the @c MDCInkView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCInkView *_Nonnull ink, UITraitCollection *_Nullable previousTraitCollection);

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

/**
 Start the first part of spreading the ink at a particular point.

 This begins by fading in the ink ripple when this method is called.

 @param point The user interaction position in the view’s coordinate system.
 @param animated to add the ink sublayer with animation or not.
 @param completionBlock Block called after the completion of the animation.
 */
- (void)startTouchBeganAtPoint:(CGPoint)point
                      animated:(BOOL)animated
                withCompletion:(nullable MDCInkCompletionBlock)completionBlock;

/**
 Start the second part of evaporating the ink at a particular point.

 This ends by completing the ink ripple expansion while fading out when
 this method is called.

 @param point The user interaction position in the view’s coordinate system.
 @param animated to remove the ink sublayer with animation or not.
 @param completionBlock Block called after the completion of the animation.
 */
- (void)startTouchEndAtPoint:(CGPoint)point
                    animated:(BOOL)animated
              withCompletion:(nullable MDCInkCompletionBlock)completionBlock;

/**
 Enumerates the given view's subviews for an instance of MDCInkView and returns it if found, or
 creates and adds a new instance of MDCInkView if not.

 This method is a convenience method for adding ink to an arbitrary view without needing to subclass
 the target view. Use this method in situations where you expect there to be many distinct ink views
 in existence for a single ink touch controller. Example scenarios include:

 - Adding ink to individual collection view/table view cells

 This method can be used in your MDCInkTouchController delegate's
 -inkTouchController:inkViewAtTouchLocation; implementation.
 */
+ (nonnull MDCInkView *)injectedInkViewForView:(nonnull UIView *)view;

@end
