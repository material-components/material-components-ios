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

#import <Foundation/Foundation.h>

#import "AnimationTimingExampleSupplemental.h"
#import "MaterialTypography.h"

const CGFloat kTopMargin = 16.f;
const CGFloat kLeftGutter = 16.f;
const CGFloat kTextOffset = 24.f;

// Size of the circle we animate.
static const CGSize kAnimationCircleSize = {48.f, 48.f};

@implementation AnimationTimingExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Animation Timing", @"Animation Timing" ];
}

+ (NSString *)catalogDescription {
  return @"Animation timing easing curves create smooth and consistent motion. Easing curves allow"
          " elements to move between positions or states.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation AnimationTimingExample (Supplemental)

- (void)setupExampleViews {
  self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
  self.title = @"Animation Timing";

  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  self.scrollView.contentSize = self.view.frame.size;
  self.scrollView.clipsToBounds = YES;
  [self.view addSubview:self.scrollView];

  CGFloat lineSpace = (self.view.frame.size.height - 50.f) / 4.f;
  UILabel *linearLabel = [AnimationTimingExample curveLabelWithTitle:@"Linear"];
  linearLabel.frame =
      CGRectMake(kLeftGutter, kTopMargin, linearLabel.frame.size.width, linearLabel.frame.size.height);
  [self.scrollView addSubview:linearLabel];

  CGRect linearViewFrame =
      CGRectMake(kLeftGutter, kTextOffset + kTopMargin, kAnimationCircleSize.width, kAnimationCircleSize.height);
  self.linearView = [[UIView alloc] initWithFrame:linearViewFrame];
  self.linearView.backgroundColor = [AnimationTimingExample defaultColors][0];
  self.linearView.layer.cornerRadius = kAnimationCircleSize.width / 2.f;
  [self.scrollView addSubview:self.linearView];

  UILabel *materialEaseInOutLabel =
      [AnimationTimingExample curveLabelWithTitle:@"MDCAnimationTimingFunctionEaseInOut"];
  materialEaseInOutLabel.frame =
      CGRectMake(kLeftGutter, lineSpace, materialEaseInOutLabel.frame.size.width,
                 materialEaseInOutLabel.frame.size.height);
  [self.scrollView addSubview:materialEaseInOutLabel];

  CGRect materialEaseInOutViewFrame =
      CGRectMake(kLeftGutter, lineSpace + kTextOffset, kAnimationCircleSize.width,
                 kAnimationCircleSize.height);
  self.materialEaseInOutView = [[UIView alloc] initWithFrame:materialEaseInOutViewFrame];
  self.materialEaseInOutView.backgroundColor = [AnimationTimingExample defaultColors][1];
  self.materialEaseInOutView.layer.cornerRadius = kAnimationCircleSize.width / 2.f;
  [self.scrollView addSubview:self.materialEaseInOutView];

  UILabel *materialEaseOutLabel =
      [AnimationTimingExample curveLabelWithTitle:@"MDCAnimationTimingFunctionEaseOut"];
  materialEaseOutLabel.frame =
      CGRectMake(kLeftGutter, lineSpace * 2.f, materialEaseOutLabel.frame.size.width,
                 materialEaseOutLabel.frame.size.height);
  [self.scrollView addSubview:materialEaseOutLabel];

  CGRect materialEaseOutViewFrame =
      CGRectMake(kLeftGutter, lineSpace * 2.f + kTextOffset, kAnimationCircleSize.width,
                 kAnimationCircleSize.height);
  self.materialEaseOutView = [[UIView alloc] initWithFrame:materialEaseOutViewFrame];
  self.materialEaseOutView.backgroundColor = [AnimationTimingExample defaultColors][2];
  self.materialEaseOutView.layer.cornerRadius = kAnimationCircleSize.width / 2.f;
  [self.scrollView addSubview:self.materialEaseOutView];

  UILabel *materialEaseInLabel =
      [AnimationTimingExample curveLabelWithTitle:@"MDCAnimationTimingFunctionEaseIn"];
  materialEaseInLabel.frame =
      CGRectMake(kLeftGutter, lineSpace * 3.f, materialEaseInLabel.frame.size.width,
                 materialEaseInLabel.frame.size.height);
  [self.scrollView addSubview:materialEaseInLabel];

  CGRect materialEaseInViewFrame =
      CGRectMake(kLeftGutter, lineSpace * 3.f + kTextOffset, kAnimationCircleSize.width,
                 kAnimationCircleSize.height);
  self.materialEaseInView = [[UIView alloc] initWithFrame:materialEaseInViewFrame];
  self.materialEaseInView.backgroundColor = [AnimationTimingExample defaultColors][3];
  self.materialEaseInView.layer.cornerRadius = kAnimationCircleSize.width / 2.f;
  [self.scrollView addSubview:self.materialEaseInView];
}

+ (UILabel *)curveLabelWithTitle:(NSString *)text {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.font = [MDCTypography captionFont];
  label.textColor = [UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]];
  label.text = text;
  [label sizeToFit];
  return label;
}

+ (NSArray<UIColor *> *)defaultColors {
  static NSArray *defaultColors;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    defaultColors = @[
      [UIColor colorWithWhite:0.1 alpha:1.0],
      [UIColor colorWithWhite:0.2 alpha:1.0],
      [UIColor colorWithWhite:0.3 alpha:1.0],
      [UIColor colorWithWhite:0.4 alpha:1.0]
    ];
  });
  return defaultColors;
}

@end
