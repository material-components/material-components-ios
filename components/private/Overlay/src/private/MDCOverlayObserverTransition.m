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

#import "MDCOverlayObserverTransition.h"

#import "MDCOverlayObserverOverlay.h"
#import "MDCOverlayUtilities.h"

#import <QuartzCore/QuartzCore.h>

@interface MDCOverlayObserverTransition ()

/**
 Blocks to run as part of the transition.
 */
@property(nonatomic) NSMutableArray *animationBlocks;

/**
 Completion blocks to run when the transition animation finishes.
 */
@property(nonatomic) NSMutableArray *completionBlocks;

@end

@implementation MDCOverlayObserverTransition

- (instancetype)init {
  self = [super init];
  if (self != nil) {
    _animationBlocks = [NSMutableArray array];
    _completionBlocks = [NSMutableArray array];
  }
  return self;
}

/**
 Runs the given animation block with the provided animation options, knowing that this method will
 only run as part of @c runAnimation.
 */
- (void)runAnimationWithOptions:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations {
  if (self.duration > 0) {
    UIViewAnimationOptions optionsToUse = options;

    // Don't let the caller override the curve or the duration.
    optionsToUse &= ~UIViewAnimationOptionOverrideInheritedDuration;
    optionsToUse &= ~UIViewAnimationOptionOverrideInheritedOptions;

    // Run a nested animation. We'll use a token animation duration, which will be ignored because
    // this will be a nested animation.
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:optionsToUse
                     animations:animations
                     completion:nil];
  } else {
    // Just execute the animation block if non-animated.
    animations();
  }
}

- (void)animateAlongsideTransitionWithOptions:(UIViewAnimationOptions)options
                                   animations:(void (^)(void))animations
                                   completion:(void (^)(BOOL finished))completion {
  if (animations != nil) {
    // Capture the options and animation block, to be executed later when @c runAnimation is called.
    __weak MDCOverlayObserverTransition *weakSelf = self;
    void (^animationToRun)(void) = ^{
      MDCOverlayObserverTransition *strongSelf = weakSelf;
      [strongSelf runAnimationWithOptions:options animations:animations];
    };

    [self.animationBlocks addObject:[animationToRun copy]];
  }

  if (completion != nil) {
    [self.completionBlocks addObject:[completion copy]];
  }
}

- (void)animateAlongsideTransition:(void (^)(void))animations {
  [self animateAlongsideTransitionWithOptions:0 animations:animations completion:nil];
}

- (void)runAnimation {
  void (^animations)(void) = ^{
    for (void (^animation)(void) in self.animationBlocks) {
      animation();
    }
  };

  void (^completions)(BOOL) = ^(BOOL finished) {
    for (void (^completion)(BOOL) in self.completionBlocks) {
      completion(finished);
    }
  };

  if (self.duration > 0) {
    CAMediaTimingFunction *customTiming = self.customTimingFunction;

    BOOL animationsEnabled = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:YES];

    if (customTiming != nil) {
      [CATransaction begin];
      [CATransaction setAnimationTimingFunction:customTiming];
    }

    [UIView animateWithDuration:self.duration
                          delay:0
                        options:self.animationCurve << 16
                     animations:animations
                     completion:completions];

    if (customTiming != nil) {
      [CATransaction commit];
    }

    [UIView setAnimationsEnabled:animationsEnabled];
  } else {
    animations();
    completions(YES);
  }
}

- (CGRect)compositeFrame {
  CGRect frame = CGRectNull;

  for (MDCOverlayObserverOverlay *overlay in self.overlays) {
    frame = CGRectUnion(frame, overlay.frame);
  }

  return frame;
}

- (CGRect)compositeFrameInView:(UIView *)targetView {
  return MDCOverlayConvertRectToView(self.compositeFrame, targetView);
}

- (void)enumerateOverlays:(void (^)(id<MDCOverlay> overlay, NSUInteger idx, BOOL *stop))handler {
  if (handler == nil) {
    return;
  }

  [self.overlays
      enumerateObjectsUsingBlock:^(MDCOverlayObserverOverlay *overlay, NSUInteger idx, BOOL *stop) {
        handler(overlay, idx, stop);
      }];
}

@end
