// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialActivityIndicator.h"

@interface MDCActivityIndicator (Subclassing)

/**
 The current color count for the spinner. Subclasses can change this value to start the spinner at
 a different color.
 */
@property(nonatomic, assign) NSUInteger cycleColorsIndex;

/**
 The current cycle count.
 */
@property(nonatomic, assign, readonly) NSInteger cycleCount;

/**
 The outer layer that handles cycle rotations and houses the stroke layer. Subclasses can add
 additional layers to this view to augment the spinner.
 */
@property(nonatomic, strong, readonly, nullable) CALayer *outerRotationLayer;

/**
 The shape layer that handles the animating stroke. Subclasses can use this layer to set initial
 and resting stroke positions.
 */
@property(nonatomic, strong, readonly, nullable) CAShapeLayer *strokeLayer;

/**
 The shape layer that shows a faint, circular track along the path of the stroke layer. Enabled
 via the showTrack property.
 */
@property(nonatomic, strong, readonly, nullable) CAShapeLayer *trackLayer;

/**
 The minimum stroke difference to use when collapsing the stroke to a dot. Based on current
 radius and stroke width.
 */
@property(nonatomic, assign, readonly) CGFloat minStrokeDifference;

/**
 The cycle index at which to start the activity spinner animation. Default is 0, which corresponds
 to the top of the spinner (12 o'clock position). Spinner cycle indices are based on a 5-point
 star.
 */
@property(nonatomic, assign) NSInteger cycleStartIndex;

/**
 Default height of the QTMActivityIndicator.
 */
+ (CGFloat)defaultHeight;

/**
 Stops the animated spinner immediately without waiting for the animation to finish cleanly. Does
 nothing if the spinner is not animating.
 */
- (void)stopAnimatingImmediately;

/**
 Resets stroke color to the first polychrome color if qtmStrokeColor is not set. Does nothing if
 qtmStrokeColor is set or the spinner is currently animating.
 */
- (void)resetStrokeColor;

/**
 Updates the stroke color.
 */
- (void)setStrokeColor:(UIColor * _Nonnull)strokeColor;

@end
