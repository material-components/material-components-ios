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

#import "MaterialMath.h"
#import "MaterialSlider.h"

@interface SliderCompareExampleViewController : UIViewController

@end

@implementation SliderCompareExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // Load your Material Component here.
  MDCSlider *slider = [[MDCSlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  [slider addTarget:self
                action:@selector(didChangeMDCSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:slider];
  slider.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                              CGRectGetMidY(self.view.bounds) - 2 * slider.frame.size.height);

  UILabel *label = [[UILabel alloc] init];
  label.text = @"MDCSlider";
  [label sizeToFit];
  [self.view addSubview:label];
  label.center = CGPointMake(slider.center.x, slider.center.y + 2 * label.frame.size.height);
  label.frame = MDCRectAlignToScale(label.frame, [UIScreen mainScreen].scale);

  // Vanilla  UISlider for comparison.
  UISlider *uiSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  [uiSlider addTarget:self
                action:@selector(didChangeUISliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:uiSlider];
  uiSlider.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                CGRectGetMidY(self.view.bounds) + 4 * uiSlider.frame.size.height);

  UILabel *uiSliderLabel = [[UILabel alloc] init];
  uiSliderLabel.text = @"UISlider";
  [uiSliderLabel sizeToFit];
  [self.view addSubview:uiSliderLabel];
  uiSliderLabel.center =
      CGPointMake(uiSlider.center.x, uiSlider.center.y + 2 * uiSliderLabel.frame.size.height);
  uiSliderLabel.frame = MDCRectAlignToScale(uiSliderLabel.frame, [UIScreen mainScreen].scale);
}

- (void)didChangeMDCSliderValue:(MDCSlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}

- (void)didChangeUISliderValue:(UISlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}

#pragma mark catalg by convention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Slider", @"MDCSlider and UISlider Compared" ];
}

@end
