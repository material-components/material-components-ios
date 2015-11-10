/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "ViewController.h"

#import "MaterialSpritedAnimationView.h"

static NSString *const kSpriteChecked = @"mdc_sprite_check__hide";
static NSString *const kSpriteUnchecked = @"mdc_sprite_check__show";

@implementation ViewController {
  MDCSpritedAnimationView *_animationView;
  BOOL _checked;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _checked = YES;

  // Sprited animation view.
  UIImage *spriteImage = [UIImage imageNamed:kSpriteChecked];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(0, 0, 30, 30);
  _animationView.center = self.view.center;
  _animationView.tintColor = [UIColor blueColor];
  _animationView.userInteractionEnabled = YES;
  [self.view addSubview:_animationView];

  // Add label with tap instructions.
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectOffset(self.view.bounds, 0, 30)];
  label.text = @"Tap anywhere to animate checkmark.";
  label.textColor = [UIColor colorWithWhite:0 alpha:0.8];
  label.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:label];

  // Add tap gesture to view.
  UITapGestureRecognizer *tapGesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
  [self.view addGestureRecognizer:tapGesture];
}

- (void)didTap:(UITapGestureRecognizer *)recognizer {
  // Animate the sprited view.
  [_animationView startAnimatingWithCompletion:^{

    // When animation completes, toggle image.
    _checked = !_checked;
    UIImage *spriteImage = [UIImage imageNamed:_checked ? kSpriteChecked : kSpriteUnchecked];
    _animationView.spriteSheetImage = spriteImage;

  }];
}

@end
