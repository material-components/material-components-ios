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

#import "CAMediaTimingFunction+MDCAnimationTiming.h"
#import "supplemental/AnimationTimingExampleViewControllerSupplemental.h"
#import "UIView+MDCTimingFunction.h"

const NSTimeInterval kAnimationTimeInterval = 1;
const NSTimeInterval kAnimationTimeDelay = 0.5;

@interface AnimationTimingExampleViewController ()

@end

@implementation AnimationTimingExampleViewController

- (void)didTapAnimateButton:(UIButton *)sender {
  sender.enabled = NO;
  [self playAnimations:^(BOOL ignored) {
    sender.enabled = YES;
  }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupExampleViews];

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Animate"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapAnimateButton:)];
}

- (void)playAnimations:(void (^)(BOOL))completion {
  CAMediaTimingFunction *linearTimingCurve =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  [self applyAnimationToView:_linearView withTimingFunction:linearTimingCurve completion:nil];

  CAMediaTimingFunction *materialStandardCurve =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  [self applyAnimationToView:_materialStandardView
          withTimingFunction:materialStandardCurve
                  completion:nil];

  CAMediaTimingFunction *materialDecelerationCurve =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionDeceleration];
  [self applyAnimationToView:_materialDecelerationView
          withTimingFunction:materialDecelerationCurve
                  completion:nil];

  CAMediaTimingFunction *materialAccelerationCurve =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionAcceleration];
  [self applyAnimationToView:_materialAccelerationView
          withTimingFunction:materialAccelerationCurve
                  completion:nil];

  CAMediaTimingFunction *materialSharpCurve =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionSharp];
  [self applyAnimationToView:_materialSharpView
          withTimingFunction:materialSharpCurve
                  completion:completion];
}

- (void)applyAnimationToView:(UIView *)view
          withTimingFunction:(CAMediaTimingFunction *)timingFunction
                  completion:(void (^)(BOOL))completion {
  CGFloat animWidth = self.view.frame.size.width - view.frame.size.width - 32;
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
                                   completion:completion];
      }];
}

@end
