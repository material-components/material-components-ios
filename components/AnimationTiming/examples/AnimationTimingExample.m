/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "AnimationTimingExampleSupplemental.h"
#import "MaterialAnimationTiming.h"

const NSTimeInterval kAnimationTimeInterval = 1.0f;
const NSTimeInterval kAnimationTimeDelay = 0.5f;

@interface AnimationTimingExample ()

@end

@implementation AnimationTimingExample

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupExampleViews];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  NSTimeInterval timeInterval = 2 * (kAnimationTimeInterval + kAnimationTimeDelay);
  [_animationLoop invalidate];
  _animationLoop = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                    target:self
                                                  selector:@selector(playAnimations:)
                                                  userInfo:nil
                                                   repeats:YES];
  [self playAnimations:nil];
}

- (void)playAnimations:(NSTimer *)timer {
  CAMediaTimingFunction *linearTimingCurve =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  [self applyAnimationToView:_linearView withTimingFunction:linearTimingCurve];

  CAMediaTimingFunction *materialEaseInOutCurve =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
  [self applyAnimationToView:_materialEaseInOutView withTimingFunction:materialEaseInOutCurve];

  CAMediaTimingFunction *materialEaseOutCurve =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseOut];
  [self applyAnimationToView:_materialEaseOutView withTimingFunction:materialEaseOutCurve];

  CAMediaTimingFunction *materialEaseInCurve =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseIn];
  [self applyAnimationToView:_materialEaseInView withTimingFunction:materialEaseInCurve];
}

- (void)applyAnimationToView:(UIView *)view
          withTimingFunction:(CAMediaTimingFunction *)timingFunction {
  CGFloat animWidth = self.view.frame.size.width - view.frame.size.width - 32.f;
  CGAffineTransform transform = CGAffineTransformMakeTranslation(animWidth, 0);
  [UIView mdc_animateWithTimingFunction:timingFunction
      duration:kAnimationTimeInterval
      delay:kAnimationTimeDelay
      options:0
      animations:^{
        view.transform = transform;
      }
      completion:^(BOOL finished) {
        [UIView mdc_animateWithTimingFunction:timingFunction
                                     duration:kAnimationTimeInterval
                                        delay:kAnimationTimeDelay
                                      options:0
                                   animations:^{
                                     view.transform = CGAffineTransformIdentity;
                                   }
                                   completion:nil];
      }];
}

@end
