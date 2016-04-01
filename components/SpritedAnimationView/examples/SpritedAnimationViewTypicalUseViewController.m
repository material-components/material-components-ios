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

#import "SpritedAnimationViewTypicalUseViewController.h"

#import "MaterialSpritedAnimationView.h"

static NSString *const kSpriteList = @"mdc_sprite_list__grid";
static NSString *const kSpriteGrid = @"mdc_sprite_grid__list";

@implementation SpritedAnimationViewTypicalUseViewController {
  MDCSpritedAnimationView *_animationView;
  BOOL _toggle;
}

// TODO: Support other categorizational methods.
+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Sprited Animation View", @"Typical use" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  UIImage *spriteImage = [UIImage imageNamed:kSpriteList
                                    inBundle:bundle
               compatibleWithTraitCollection:nil];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(0, 0, 30, 30);
  _animationView.center = self.view.center;
  UIColor *blueColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  _animationView.tintColor = blueColor;
  [self.view addSubview:_animationView];

  // Add label with tap instructions.
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectOffset(self.view.bounds, 0, 30)];
  label.text = @"Tap anywhere to animate icon.";
  label.textColor = [UIColor colorWithWhite:0 alpha:0.8];
  label.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:label];

  // Add tap gesture to view.
  UITapGestureRecognizer *tapGesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(didTap:)];
  [self.view addGestureRecognizer:tapGesture];
}

- (void)didTap:(UITapGestureRecognizer *)recognizer {
  recognizer.enabled = NO;

  // Animate the sprited view.
  [_animationView startAnimatingWithCompletion:^{

    // When animation completes, toggle image.
    _toggle = !_toggle;
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *spriteImage = [UIImage imageNamed:_toggle ? kSpriteGrid : kSpriteList
                                      inBundle:bundle
                 compatibleWithTraitCollection:nil];
    _animationView.spriteSheetImage = spriteImage;

    recognizer.enabled = YES;
  }];
}

@end
