// Copyright 2023-present the Material Components for iOS authors. All Rights Reserved.
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

#ifdef __cplusplus
#define M3C_EXTERN extern "C" __attribute__((visibility("default")))
#else
#define M3C_EXTERN extern __attribute__((visibility("default")))
#endif

NS_ASSUME_NONNULL_BEGIN

/** Special animation key which will match any animation key. */
M3C_EXTERN NSString *_Nonnull const M3CAnySourceLayerAnimationKey;

/** Block which returns a value for the animation. */
typedef id _Nullable (^M3CAnimationValueBlock)(void);

/**
 * An action that will create a CABasicAnimation for the given layer when it is run. The animation
 * is configured using a source animation if it can be found.
 */
@interface M3CPendingBasicAnimationAction : NSObject <CAAction>

/** The animation key. If an animation already existed with this key it will be replaced. */
@property(nonatomic, nonnull) NSString *key;

/** The value the animation should start from. */
@property(nonatomic, nullable) id fromValue;

/** A block executed when the action is run which returns the value the animation should end at. */
@property(nonatomic, nullable) M3CAnimationValueBlock toValueBlock;

/**
 * The animation duration. Defaults to 0.0 which has no effect. The duration should be scaled by
 * M3CScaleAnimationTime to support "Slow animations" in the simulator.
 *
 * @see M3CScaleAnimationTime
 */
@property(nonatomic) NSTimeInterval duration;

/** Optional timing function. Defaults to nil, which has no effect. */
@property(nonatomic, nullable) CAMediaTimingFunction *timingFunction;

/**
 * The layer to read the source animation from. If nil, the layer the action is run on will be used.
 */
@property(nonatomic, nullable) CALayer *sourceLayer;

/**
 * An optional array of source layer animation keys. The keys are searched for in order. Defaults to
 * nil, meaning the `key` will be used as the source animation key. If a source animation is found
 * it is used to set coordinating properties like duration and timing curve on the animation this
 * action creates. If `M3CAnySourceLayerAnimationKey` is supplied in the keys, the first animation
 * of the source layer will be used as the source animation.
 *
 * @see M3CAnySourceLayerAnimationKey
 */
@property(nonatomic, nullable) NSArray<NSString *> *sourceAnimationKeys;

@end

/**
 * Returns whether the given `key` is for a Material-generated shadow path.
 */
M3C_EXTERN BOOL M3CIsMDCShadowPathKey(NSString *_Nullable key);

/**
 * Returns an action which adds an animation to the `layer` for a Material-generated shadow path.
 * The animation created will mimic the properties of the source animation on which the shadow path
 * is based.
 */
M3C_EXTERN M3CPendingBasicAnimationAction *_Nonnull M3CShadowPathActionForLayer(
    CALayer *_Nonnull layer);

NS_ASSUME_NONNULL_END
