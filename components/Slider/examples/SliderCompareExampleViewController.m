// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialColorScheme.h"
#import "MaterialMath.h"
#import "MaterialSlider+ColorThemer.h"
#import "MaterialSlider.h"
#import "MaterialTypographyScheme.h"

@interface SliderCompareExampleViewController : UIViewController
@property(nonatomic, strong, nullable) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong, nullable) MDCTypographyScheme *typographyScheme;
@property(nonatomic, strong, nullable) MDCSlider *slider;
@property(nonatomic, strong, nullable) UILabel *label;
@property(nonatomic, strong, nullable) UISlider *uiSlider;
@property(nonatomic, strong, nullable) UILabel *uiSliderLabel;
@end

@implementation SliderCompareExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = self.colorScheme.backgroundColor;

  // Load your Material Component here.
  self.slider = [[MDCSlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  self.slider.statefulAPIEnabled = YES;
  [MDCSliderColorThemer applySemanticColorScheme:self.colorScheme toSlider:self.slider];
  [self.slider addTarget:self
                  action:@selector(didChangeMDCSliderValue:)
        forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.slider];
  self.label = [[UILabel alloc] init];
  self.label.text = @"MDCSlider";
  self.label.font = self.typographyScheme.body1;

  [self.label sizeToFit];
  [self.view addSubview:self.label];

  // Vanilla  UISlider for comparison.
  self.uiSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  [self.uiSlider addTarget:self
                    action:@selector(didChangeUISliderValue:)
          forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.uiSlider];

  self.uiSliderLabel = [[UILabel alloc] init];
  self.uiSliderLabel.text = @"UISlider";
  self.uiSliderLabel.font = self.typographyScheme.body1;
  [self.uiSliderLabel sizeToFit];
  [self.view addSubview:self.uiSliderLabel];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  self.slider.center =
      CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 50);
  CGFloat labelHeight = CGRectGetHeight(self.label.bounds);
  self.label.center = CGPointMake(self.slider.center.x, self.slider.center.y + 2 * labelHeight);
  self.label.frame = MDCRectAlignToScale(self.label.frame, [UIScreen mainScreen].scale);

  self.uiSlider.center =
      CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + 50);
  CGFloat uiLabelHeight = CGRectGetHeight(self.uiSliderLabel.bounds);
  self.uiSliderLabel.center =
      CGPointMake(self.uiSlider.center.x, self.uiSlider.center.y + 2 * uiLabelHeight);
  self.uiSliderLabel.frame =
      MDCRectAlignToScale(self.uiSliderLabel.frame, [UIScreen mainScreen].scale);
}

- (void)didChangeMDCSliderValue:(MDCSlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}

- (void)didChangeUISliderValue:(UISlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Slider", @"MDCSlider and UISlider Compared" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
