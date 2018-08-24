/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "MaterialColorScheme.h"
#import "MaterialMath.h"
#import "MaterialSlider.h"
#import "MaterialSlider+ColorThemer.h"

@interface SliderCompareExampleViewController : UIViewController
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation SliderCompareExampleViewController {
  MDCSlider *_slider;
  UILabel *_label;
  UISlider *_uiSlider;
  UILabel *_uiSliderLabel;
}

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = self.colorScheme.backgroundColor;

  // Load your Material Component here.
  _slider = [[MDCSlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  _slider.statefulAPIEnabled = YES;
  [MDCSliderColorThemer applySemanticColorScheme:self.colorScheme toSlider:_slider];
  [_slider addTarget:self
                action:@selector(didChangeMDCSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_slider];

  _label = [[UILabel alloc] init];
  _label.text = @"MDCSlider";
  
  [_label sizeToFit];
  [self.view addSubview:_label];

  // Vanilla  UISlider for comparison.
  _uiSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  [_uiSlider addTarget:self
                action:@selector(didChangeUISliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_uiSlider];

  _uiSliderLabel = [[UILabel alloc] init];
  _uiSliderLabel.text = @"UISlider";
  [_uiSliderLabel sizeToFit];
  [self.view addSubview:_uiSliderLabel];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  _slider.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                              CGRectGetMidY(self.view.bounds) - 50);
  _label.center = CGPointMake(_slider.center.x, _slider.center.y + 2 * _label.frame.size.height);
  _label.frame = MDCRectAlignToScale(_label.frame, [UIScreen mainScreen].scale);

  _uiSlider.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                 CGRectGetMidY(self.view.bounds) + 50);
  _uiSliderLabel.center = CGPointMake(_uiSlider.center.x,
                                      _uiSlider.center.y + 2 * _uiSliderLabel.frame.size.height);
  _uiSliderLabel.frame = MDCRectAlignToScale(_uiSliderLabel.frame, [UIScreen mainScreen].scale);
}

- (void)didChangeMDCSliderValue:(MDCSlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}

- (void)didChangeUISliderValue:(UISlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Slider", @"MDCSlider and UISlider Compared" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

@end
