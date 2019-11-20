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

#import <UIKit/UIKit.h>

@protocol MDCRippleViewDelegate;

/**
 Convenience naming for the completion blocks the ripple animation provides.
 */
typedef void (^MDCRippleCompletionBlock)(void);

/**
 The different possible ripple styles. The ripple can either be bound to the view or not.

 - MDCRippleStyleBounded: The ripple is bound to the view.
 - MDCRippleStyleUnbounded: The ripple is unbounded and ripples to the size of the smallest circle
 that covers the entire rectangular bounds, plus an additional 10 points.
 */
typedef NS_ENUM(NSInteger, MDCRippleStyle) {
  MDCRippleStyleBounded = 0,
  MDCRippleStyleUnbounded,
};

/**
 A UIView that draws and animates the Material Design ripple effect for touch interactions.

 The Ripple is a visual flourish consisting of an animated circle with various scale, opacity and
 position animations applied simultaneously to give the illusion of ink applied to a paper surface.

 Our touch feedback ripple effect is a prominent entity across all our interactable components:
 i.e., buttons, cards, tab bars, list items.

 There can be multiple riples occurring at the same time, each represented by an MDCRippleLayer.
 */
@interface MDCRippleView : UIView

/**
 The ripple view delegate.
 */
@property(nonatomic, weak, nullable) id<MDCRippleViewDelegate> rippleViewDelegate;

/**
 The ripple style indicating if the ripple is bounded or unbounded to the view.
 */
@property(nonatomic, assign) MDCRippleStyle rippleStyle;

/**
 The ripple's color.
 */
@property(nonatomic, strong, nonnull) UIColor *rippleColor;

/**
 The maximum radius the ripple can expand to.

 @note This property is ignored if @c rippleStyle is set to @c MDCRippleStyleBounded.
 */
@property(nonatomic, assign) CGFloat maximumRadius;

/**
 The ripple color of the currently active ripple.
 */
@property(nonatomic, strong, nonnull) UIColor *activeRippleColor;

/**
 When rippleStyle is MDCRippleStyleBounded, this flag affects whether the layer's mask will use
 the super view's layer.shadowPath as the mask path.

 @note This behavior only takes effect if the ripple view's parent view has a non-nil shadowPath.

 @note This behavioral flag will eventually become NO by default and then be deleted. The YES
 behavior is undesired because it assumes that the frame of the ripple view always matches the
 bounds of the superview. When this assumption is false, such as when the ripple's origin is
 non-zero, the ripple's mask tends to be bigger than it should be resulting in an incorrectly
 clipped ripple effect. Consider disabling this behavior and explicitly setting a layer mask
 instead.

 Changing this value to NO does not clear the mask if it was already set.

 Default value is YES.
 */
@property(nonatomic, assign) BOOL usesSuperviewShadowLayerAsMask;

/**
 A block that is invoked when the @c MDCRippleView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCRippleView *_Nonnull ripple, UITraitCollection *_Nullable previousTraitCollection);

/**
 Cancels all the existing ripples.

 @param animated Whether to animate the cancellation of the ripples or not.
 */
- (void)cancelAllRipplesAnimated:(BOOL)animated
                      completion:(nullable MDCRippleCompletionBlock)completion;

/**
 Fades the ripple in by changing its opacity.

 @param animated Whether or not the fade in should be animated or not.
 @param completion A completion block called after the completion of the animation.
 */
- (void)fadeInRippleAnimated:(BOOL)animated
                  completion:(nullable MDCRippleCompletionBlock)completion;

/**
 Fades the ripple out by changing its opacity.

 @param animated Whether or not the fade in should be animated or not.
 @param completion A completion block called after the completion of the animation.
 */
- (void)fadeOutRippleAnimated:(BOOL)animated
                   completion:(nullable MDCRippleCompletionBlock)completion;

/**
 Begins the ripple's touch down animation at the given point. This presents the ripple and leaves it
 on the view. If animated, it animates the expanding ripple circle effect.
 To then remove the ripple, `beginRippleTouchUpAnimated` needs to be called.

 @param point The point to start the ripple animation.
 @param animated Whether or not the ripple should be animated or not.
 @param completion A completion block called after the completion of the animation.
 */
- (void)beginRippleTouchDownAtPoint:(CGPoint)point
                           animated:(BOOL)animated
                         completion:(nullable MDCRippleCompletionBlock)completion;

/**
 Begins the ripple's touch up animation. This remopves the ripple from the view. If animated, the
 ripple dissolves using an animated opacity change.

 @param animated Whether or not the ripple should be animated or not.
 @param completion A completion block called after the completion of the animation.
 */
- (void)beginRippleTouchUpAnimated:(BOOL)animated
                        completion:(nullable MDCRippleCompletionBlock)completion;

@end

/**
 The ripple view delegate protocol. Clients may implement this protocol to receive updates on
 the ripple's animation lifecycle.
 */
@protocol MDCRippleViewDelegate <NSObject>

@optional

/**
 Called when the ripple view began its touch down animation.

 @param rippleView The MDCRippleView.
 */
- (void)rippleTouchDownAnimationDidBegin:(nonnull MDCRippleView *)rippleView;

/**
 Called when the ripple view ended its touch down animation.

 @param rippleView The MDCRippleView.
 */
- (void)rippleTouchDownAnimationDidEnd:(nonnull MDCRippleView *)rippleView;

/**
 Called when the ripple view began its touch up animation.

 @param rippleView The MDCRippleView.
 */
- (void)rippleTouchUpAnimationDidBegin:(nonnull MDCRippleView *)rippleView;

/**
 Called when the ripple view ended its touch up animation.

 @param rippleView The MDCRippleView.
 */
- (void)rippleTouchUpAnimationDidEnd:(nonnull MDCRippleView *)rippleView;

@end
