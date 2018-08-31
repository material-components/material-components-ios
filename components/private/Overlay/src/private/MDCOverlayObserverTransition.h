// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCOverlayTransitioning.h"

/**
 Object representing the a transition between overlays on screen.
 */
@interface MDCOverlayObserverTransition : NSObject <MDCOverlayTransitioning>

/**
 If animated, the timing function of the transition animation.
 */
@property(nonatomic) CAMediaTimingFunction *customTimingFunction;

/**
 If animated, the curve of the transition animation.
 */
@property(nonatomic) UIViewAnimationCurve animationCurve;

/**
 If animated, the duration of the transition animation.
 */
@property(nonatomic) NSTimeInterval duration;

/**
 The overlays represented by this transition.
 */
@property(nonatomic, copy) NSArray *overlays;

/**
 Sets up an animation block (or none) and executes all of the animation blocks registered as part
 of the MDCOverlayTransitioning protocol.
 */
- (void)runAnimation;

@end
