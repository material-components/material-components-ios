// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFloatingButtonModeAnimator.h"

#import "MDCFloatingButtonModeAnimatorDelegate.h"

#if TARGET_IPHONE_SIMULATOR
UIKIT_EXTERN float UIAnimationDragCoefficient(void);  // UIKit private drag coefficient.
#endif

static CGFloat SimulatorAnimationDragCoefficient(void) {
#if TARGET_IPHONE_SIMULATOR
  return UIAnimationDragCoefficient();
#else
  return 1.0;
#endif
}

typedef struct {
  NSTimeInterval duration;
  NSTimeInterval titleOpacityDelay;
  NSTimeInterval titleOpacityDuration;
} AnimationTiming;

// go/mdc-fab-expansion-animation
static const AnimationTiming kExpandAnimationTiming = (AnimationTiming){
    .duration = 0.200,
    .titleOpacityDelay = 0.083,
    .titleOpacityDuration = 0.067,
};

// go/mdc-fab-collapse-animation
static const AnimationTiming kCollapseAnimationTiming = (AnimationTiming){
    .duration = 0.167,
    .titleOpacityDelay = 0.016,
    .titleOpacityDuration = 0.033,
};

static const UIViewAnimationOptions kTitleOpacityAnimationOptions =
    UIViewAnimationOptionCurveLinear;

static NSString *const kModeVerticalDriftAnimationKey = @"position.y.fix";

@interface MDCFloatingButtonModeAnimator ()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *titleLabelContainerView;
@end

@implementation MDCFloatingButtonModeAnimator

- (instancetype)initWithTitleLabel:(UILabel *)titleLabel
           titleLabelContainerView:(UIView *)titleLabelContainerView {
  self = [super init];
  if (self) {
    self.titleLabel = titleLabel;
    self.titleLabelContainerView = titleLabelContainerView;
  }
  return self;
}

- (void)modeDidChange:(MDCFloatingButtonMode)mode
             animated:(BOOL)animated
     animateAlongside:(nullable void (^)(void))animateAlongside
           completion:(nullable void (^)(BOOL finished))completion {
  if (!animated) {
    self.titleLabelContainerView.clipsToBounds = NO;
    if (animateAlongside) {
      animateAlongside();
    }
    if (completion) {
      completion(YES);
    }
    return;
  }

  // Floating button mode animations are relatively rare, so to avoid having the non-animated steady
  // state pay any compositing costs due to masking we only enable clipsToBounds for the course of
  // the mode animation. The bounds clipping is necessary to achieve the clipped label effect as the
  // button expands / collapses.
  _titleLabelContainerView.clipsToBounds = YES;

  const BOOL expanding = mode == MDCFloatingButtonModeExpanded;

  // ## Prepare the label for animation

  // Because the titleLabel has an empty frame in the collapsed state, we key this entire animation
  // off of the expanded state's frame. When expanding, we can animate the titleLabel directly
  // because the destination frame is non-empty. When collapsing, we need to animate a snapshot
  // because the titleLabel's destination frame is empty.
  UIView *animationTitleLabel;
  void (^titleLabelCleanup)(BOOL);
  if (expanding) {
    animationTitleLabel = self.titleLabel;
    animationTitleLabel.alpha = 0;  // Start off initially transparent.
    titleLabelCleanup = nil;
  } else {
    animationTitleLabel = [self.titleLabel snapshotViewAfterScreenUpdates:NO];
    animationTitleLabel.frame = self.titleLabel.frame;
    [_titleLabelContainerView addSubview:animationTitleLabel];
    titleLabelCleanup = ^(BOOL finished) {
      [animationTitleLabel removeFromSuperview];
    };
  }

  // ## Perform the frame animation

  CGRect priorTitleLabelFrame = self.titleLabel.frame;
  AnimationTiming timing = expanding ? kExpandAnimationTiming : kCollapseAnimationTiming;
  [UIView animateWithDuration:timing.duration
      animations:^{
        NSSet *priorTitleAnimationKeys = [NSSet setWithArray:self.titleLabel.layer.animationKeys];

        // Force the button to adjust its frame in order to generate the default animations. Note
        // that this will also animate the title label and any other subviews within the button.
        [self.delegate floatingButtonModeAnimatorCommitLayoutChanges:self mode:mode];

        // If we allowed the title label to animate as a result of the sizeToFit changes, then we
        // would see the title expand / collapse its frame in a squishy and undesirable manner. To
        // avoid this, we remove any *newly added* animations from the title label before they get
        // committed to the render server. The resulting effect is that the title label's frame is
        // instantly where it needs to be and we can animate its alpha independently and compensate
        // for any vertical drift below.
        NSMutableSet *newTitleAnimationKeys =
            [NSMutableSet setWithArray:self.titleLabel.layer.animationKeys];
        [newTitleAnimationKeys minusSet:priorTitleAnimationKeys];
        for (NSString *animationKey in newTitleAnimationKeys) {
          [self.titleLabel.layer removeAnimationForKey:animationKey];
        }

        if (animateAlongside) {
          animateAlongside();
        }
      }
      completion:^(BOOL finished) {
        if (titleLabelCleanup) {
          titleLabelCleanup(finished);
        }
        self.titleLabelContainerView.clipsToBounds = NO;
        if (completion) {
          completion(finished);
        }
      }];

  // ## Compensate for vertical drift

  // As noted above, the default titleLabel frame animations cause an undesired scaling effect of
  // the label and so the default animations are removed. The titleLabel's frame is now set to the
  // final state of the animation which is generally desired in terms of the titleLabel's size, but
  // if the button's height changes then we need to animate the label's y position, otherwise the
  // label will appear to be pinned to the top - rather than the center - of the button as the
  // button expands / contracts.
  //
  // We compensate for this effect by creating an additive animation below. The purpose of this
  // additive animation is to give the appearance that the label is centered vertically within the
  // button over the course of the animation and without making adjustments to the model layer.

  CGRect newTitleLabelFrame = self.titleLabel.frame;
  CGFloat centerYDelta = CGRectGetMidY(newTitleLabelFrame) - CGRectGetMidY(priorTitleLabelFrame);
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
  animation.additive = YES;
  animation.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  if (expanding) {
    // When expanding, we initially compensate for the vertical shift and then gradually reduce that
    // compensation as the animation progresses. This is because the label's model layer is already
    // shifted relative to the original center position.
    animation.fromValue = @(-centerYDelta);
    animation.toValue = @0;
  } else {
    // When contracting we undo the effect of the expansion by adding the compensation gradually
    // back to the label.
    animation.fromValue = @0;
    animation.toValue = @(centerYDelta);
  }
  animation.duration = timing.duration * SimulatorAnimationDragCoefficient();
  [animationTitleLabel.layer addAnimation:animation forKey:kModeVerticalDriftAnimationKey];

  // ## Animate the title opacity

  [UIView animateWithDuration:timing.titleOpacityDuration
                        delay:timing.titleOpacityDelay
                      options:kTitleOpacityAnimationOptions
                   animations:^{
                     if (mode == MDCFloatingButtonModeExpanded) {
                       animationTitleLabel.alpha = 1;
                     } else {
                       animationTitleLabel.alpha = 0;
                     }
                   }
                   completion:nil];
}

@end
