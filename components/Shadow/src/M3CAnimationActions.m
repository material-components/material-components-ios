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

#import "M3CAnimationActions.h"

NS_ASSUME_NONNULL_BEGIN

NSString *_Nonnull const M3CAnySourceLayerAnimationKey = @"*";

@implementation M3CPendingBasicAnimationAction

#pragma mark - CAAction

- (void)runActionForKey:(nonnull NSString *)key
                 object:(nonnull id)object
              arguments:(nullable NSDictionary<id, id> *)dict {
  if (![object isKindOfClass:[CALayer class]]) {
    return;
  }

  CALayer *layer = (CALayer *)object;
  CALayer *sourceLayer = _sourceLayer ?: layer;
  NSArray<NSString *> *sourceLayerAnimationKeys = sourceLayer.animationKeys;
  NSArray<NSString *> *sourceAnimationKeys;

  if (_sourceAnimationKeys.count > 0) {
    sourceAnimationKeys = _sourceAnimationKeys;
  } else {
    sourceAnimationKeys = @[ key ];
  }

  CAAnimation *sourceAnimation = nil;

  for (NSString *sourceAnimationKey in sourceAnimationKeys) {
    if ([sourceAnimationKey isEqualToString:M3CAnySourceLayerAnimationKey]) {
      sourceAnimation = [sourceLayer animationForKey:sourceLayerAnimationKeys.firstObject];
      break;
    }

    sourceAnimation = [sourceLayer animationForKey:sourceAnimationKey];

    if (!sourceAnimation) {
      // Check for an animation decomposition (e.g., bounds -> bounds.size/bounds.position).
      for (NSString *animationKey in sourceLayerAnimationKeys) {
        if ([animationKey hasPrefix:sourceAnimationKey]) {
          sourceAnimation = [sourceLayer animationForKey:animationKey];
          break;
        }
      }
    }

    if (sourceAnimation) {
      break;
    }
  }

  id toValue = _toValueBlock ? _toValueBlock() : nil;
  // If a source layer or animation key is explicitly given, a source animation must be found for
  // this action to create and add an animation.
  BOOL shouldHaveSourceAnimation = (_sourceLayer || _sourceAnimationKeys.firstObject);
  // `fromValue` and `toValue` default to the current property value when nil.
  BOOL areEqualOrBothNil = _fromValue == toValue || (_fromValue == nil && toValue == nil);

  if (areEqualOrBothNil || (shouldHaveSourceAnimation && !sourceAnimation)) {
    // If the value isn't changing or the given source animation couldn't be found, remove any old
    // one and do nothing.
    [layer removeAnimationForKey:key];
    return;
  }

  CABasicAnimation *basicAnimation = [CABasicAnimation animation];
  basicAnimation.keyPath = key;
  basicAnimation.fromValue = _fromValue;
  basicAnimation.toValue = toValue;

  if (_duration > 0.0) {
    basicAnimation.duration = _duration;
  } else if (sourceAnimation) {
    basicAnimation.duration = sourceAnimation.duration;
  }

  if (_timingFunction) {
    basicAnimation.timingFunction = _timingFunction;
  } else if (sourceAnimation) {
    basicAnimation.timingFunction = sourceAnimation.timingFunction;
  }

  [layer addAnimation:basicAnimation forKey:key];
}

@end

/** The CALayer keys for bounds, cornerRadius, and shadowPath. */
static NSString *const kBoundsAnimationKey = @"bounds";
static NSString *const kCornerRadiusAnimationKey = @"cornerRadius";
static NSString *const kShadowPathKey = @"shadowPath";

BOOL M3CIsMDCShadowPathKey(NSString *_Nullable key) { return [key isEqualToString:kShadowPathKey]; }

M3CPendingBasicAnimationAction *_Nonnull M3CShadowPathActionForLayer(CALayer *_Nonnull layer) {
  M3CPendingBasicAnimationAction *action = [[M3CPendingBasicAnimationAction alloc] init];
  action.key = kShadowPathKey;
  action.fromValue = [layer.presentationLayer valueForKey:kShadowPathKey];
  action.toValueBlock = ^{
    return [layer valueForKey:kShadowPathKey];
  };

  // Link the shadow path animation to animations of properties that affect it.
  action.sourceAnimationKeys = @[ kBoundsAnimationKey, kCornerRadiusAnimationKey ];
  return action;
}

NS_ASSUME_NONNULL_END
