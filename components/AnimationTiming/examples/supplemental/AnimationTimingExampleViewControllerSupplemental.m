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

#import "AnimationTimingExampleViewControllerSupplemental.h"

#import "MaterialTypography.h"

const CGFloat kTopMargin = 16;
const CGFloat kLeftGutter = 16;
const CGFloat kTextOffset = 16;

// Size of the circle we animate.
static const CGSize kAnimationCircleSize = {48, 48};

@implementation AnimationTimingExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Animation Timing", @"Animation Timing" ],
    @"description" : @"Animation timing easing curves create smooth and consistent motion. "
                     @"Easing curves allow elements to move between positions or states.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES
  };
}

@end

@implementation AnimationTimingExampleViewController (Supplemental)

- (void)setupExampleViews {
  self.view.backgroundColor = UIColor.whiteColor;
  self.title = @"Animation Timing";

  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

  self.scrollView.contentSize =
      CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + kTopMargin);
  self.scrollView.clipsToBounds = YES;
  [self.view addSubview:self.scrollView];

  if (@available(iOS 11.0, *)) {
    // No need to do anything - additionalSafeAreaInsets will inset our content.
    self.scrollView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  } else {
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
      [NSLayoutConstraint constraintWithItem:self.scrollView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.topLayoutGuide
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                    constant:0],
      [NSLayoutConstraint constraintWithItem:self.scrollView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                    constant:0],
      [NSLayoutConstraint constraintWithItem:self.scrollView
                                   attribute:NSLayoutAttributeLeft
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeLeft
                                  multiplier:1.0
                                    constant:0],
      [NSLayoutConstraint constraintWithItem:self.scrollView
                                   attribute:NSLayoutAttributeRight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeRight
                                  multiplier:1.0
                                    constant:0]
    ]];
  }

  CGFloat lineSpace = (CGRectGetHeight(self.view.frame) - 50) / 5;
  UILabel *linearLabel = [AnimationTimingExampleViewController curveLabelWithTitle:@"Linear"];
  linearLabel.frame = CGRectMake(kLeftGutter, kTopMargin, linearLabel.frame.size.width,
                                 linearLabel.frame.size.height);
  [self.scrollView addSubview:linearLabel];

  CGRect linearViewFrame = CGRectMake(kLeftGutter, kTextOffset + kTopMargin,
                                      kAnimationCircleSize.width, kAnimationCircleSize.height);
  self.linearView = [[UIView alloc] initWithFrame:linearViewFrame];
  self.linearView.backgroundColor = [AnimationTimingExampleViewController defaultColors][0];
  self.linearView.layer.cornerRadius = kAnimationCircleSize.width / 2;
  [self.scrollView addSubview:self.linearView];

  UILabel *materialEaseInOutLabel = [AnimationTimingExampleViewController
      curveLabelWithTitle:@"MDCAnimationTimingFunctionStandard"];
  materialEaseInOutLabel.frame =
      CGRectMake(kLeftGutter, lineSpace, materialEaseInOutLabel.frame.size.width,
                 materialEaseInOutLabel.frame.size.height);
  [self.scrollView addSubview:materialEaseInOutLabel];

  CGRect materialEaseInOutViewFrame =
      CGRectMake(kLeftGutter, lineSpace + kTextOffset, kAnimationCircleSize.width,
                 kAnimationCircleSize.height);
  self.materialStandardView = [[UIView alloc] initWithFrame:materialEaseInOutViewFrame];
  self.materialStandardView.backgroundColor =
      [AnimationTimingExampleViewController defaultColors][1];
  self.materialStandardView.layer.cornerRadius = kAnimationCircleSize.width / 2;
  [self.scrollView addSubview:self.materialStandardView];

  UILabel *materialEaseOutLabel = [AnimationTimingExampleViewController
      curveLabelWithTitle:@"MDCAnimationTimingFunctionDeceleration"];
  materialEaseOutLabel.frame =
      CGRectMake(kLeftGutter, lineSpace * 2, materialEaseOutLabel.frame.size.width,
                 materialEaseOutLabel.frame.size.height);
  [self.scrollView addSubview:materialEaseOutLabel];

  CGRect materialDecelerationViewFrame =
      CGRectMake(kLeftGutter, lineSpace * 2 + kTextOffset, kAnimationCircleSize.width,
                 kAnimationCircleSize.height);
  self.materialDecelerationView = [[UIView alloc] initWithFrame:materialDecelerationViewFrame];
  self.materialDecelerationView.backgroundColor =
      [AnimationTimingExampleViewController defaultColors][2];
  self.materialDecelerationView.layer.cornerRadius = kAnimationCircleSize.width / 2;
  [self.scrollView addSubview:self.materialDecelerationView];

  UILabel *materialEaseInLabel = [AnimationTimingExampleViewController
      curveLabelWithTitle:@"MDCAnimationTimingFunctionAcceleration"];
  materialEaseInLabel.frame =
      CGRectMake(kLeftGutter, lineSpace * 3, materialEaseInLabel.frame.size.width,
                 materialEaseInLabel.frame.size.height);
  [self.scrollView addSubview:materialEaseInLabel];

  CGRect materialAccelerationViewFrame =
      CGRectMake(kLeftGutter, lineSpace * 3 + kTextOffset, kAnimationCircleSize.width,
                 kAnimationCircleSize.height);
  self.materialAccelerationView = [[UIView alloc] initWithFrame:materialAccelerationViewFrame];
  self.materialAccelerationView.backgroundColor =
      [AnimationTimingExampleViewController defaultColors][3];
  self.materialAccelerationView.layer.cornerRadius = kAnimationCircleSize.width / 2;
  [self.scrollView addSubview:self.materialAccelerationView];

  UILabel *materialSharpLabel =
      [AnimationTimingExampleViewController curveLabelWithTitle:@"MDCAnimationTimingFunctionSharp"];
  materialSharpLabel.frame =
      CGRectMake(kLeftGutter, lineSpace * 4, CGRectGetWidth(materialSharpLabel.frame),
                 CGRectGetHeight(materialSharpLabel.frame));
  [self.scrollView addSubview:materialSharpLabel];

  CGRect materialSharpViewFrame =
      CGRectMake(kLeftGutter, lineSpace * 4 + kTextOffset, kAnimationCircleSize.width,
                 kAnimationCircleSize.height);
  self.materialSharpView = [[UIView alloc] initWithFrame:materialSharpViewFrame];
  self.materialSharpView.backgroundColor = [AnimationTimingExampleViewController defaultColors][4];
  self.materialSharpView.layer.cornerRadius = kAnimationCircleSize.width / 2;
  [self.scrollView addSubview:self.materialSharpView];
}

+ (UILabel *)curveLabelWithTitle:(NSString *)text {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.font = [MDCTypography captionFont];
  label.textColor = [UIColor colorWithWhite:0 alpha:[MDCTypography body2FontOpacity]];
  label.text = text;
  [label sizeToFit];
  return label;
}

+ (NSArray<UIColor *> *)defaultColors {
  static NSArray *defaultColors;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    UIColor *primaryColor = [UIColor darkGrayColor];
    defaultColors = @[
      [primaryColor colorWithAlphaComponent:(CGFloat)0.95],
      [primaryColor colorWithAlphaComponent:(CGFloat)0.90],
      [primaryColor colorWithAlphaComponent:(CGFloat)0.85],
      [primaryColor colorWithAlphaComponent:(CGFloat)0.80],
      [primaryColor colorWithAlphaComponent:(CGFloat)0.75]
    ];
  });
  return defaultColors;
}

@end
