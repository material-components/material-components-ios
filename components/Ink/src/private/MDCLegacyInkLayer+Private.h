// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCLegacyInkLayer.h"

@class MDCLegacyInkLayerRipple;

@protocol MDCLegacyInkLayerRippleDelegate <MDCLegacyInkLayerDelegate>

/// Called if MDCLegacyInkLayerRipple did start animating.
- (void)animationDidStart:(nonnull MDCLegacyInkLayerRipple *)layerRipple;

/// Called for every MDCLegacyInkLayerRipple if an animation did end.
- (void)animationDidStop:(nullable CAAnimation *)anim
              shapeLayer:(nullable CAShapeLayer *)layerRipple
                finished:(BOOL)finished;

@end

@interface MDCLegacyInkLayer () <MDCLegacyInkLayerRippleDelegate>

/// A Boolean value indicating whether animations of this layer are in progress.
@property(nonatomic, assign, getter=isAnimating) BOOL animating;

/// Enter any ink applied to the layer. Currently only exposed for testing.
- (void)enterAllInks;

@end

@interface MDCLegacyInkLayerRipple : CAShapeLayer
@end

@interface MDCLegacyInkLayerForegroundRipple : MDCLegacyInkLayerRipple

- (void)exit:(BOOL)animated;

@end

@interface MDCLegacyInkLayerBackgroundRipple : MDCLegacyInkLayerRipple

- (void)exit:(BOOL)animated;

@end
