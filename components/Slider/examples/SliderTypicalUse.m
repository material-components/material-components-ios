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

#import <UIKit/UIKit.h>

#import "MaterialSlider.h"

#import "SliderTypicalUseSupplemental.h"

@implementation SliderTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // Slider

  CGRect sliderFrame = CGRectMake(0, 0, 100, 27);
  self.slider = [[MDCSlider alloc] initWithFrame:sliderFrame];
  [self.slider addTarget:self
                  action:@selector(didChangeSliderValue:)
        forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.slider];

  // Discrete slider

  self.discreteSlider = [[MDCSlider alloc] initWithFrame:sliderFrame];
  self.discreteSlider.numberOfDiscreteValues = 7;
  [self.discreteSlider addTarget:self
                          action:@selector(didChangeSliderValue:)
                forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.discreteSlider];

  // Slider disabled

  self.disabledSlider = [[MDCSlider alloc] initWithFrame:sliderFrame];
  [self.disabledSlider addTarget:self
                          action:@selector(didChangeSliderValue:)
                forControlEvents:UIControlEventValueChanged];
  self.disabledSlider.enabled = NO;
  self.disabledSlider.value = 0.5f;
  [self.view addSubview:self.disabledSlider];

  self.slider.translatesAutoresizingMaskIntoConstraints = NO;
  self.discreteSlider.translatesAutoresizingMaskIntoConstraints = NO;
  self.disabledSlider.translatesAutoresizingMaskIntoConstraints = NO;

  [self setupExampleViews];
}

- (void)didChangeSliderValue:(MDCSlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}

@end
