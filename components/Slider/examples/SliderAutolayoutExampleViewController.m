/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "SliderAutolayoutExampleViewController.h"

#import "MDCSlider.h"

@interface SliderAutolayoutExampleViewController ()
@property(weak, nonatomic) IBOutlet MDCSlider *materialSlider;
@property(weak, nonatomic) IBOutlet UISlider *vanillaSlider;
@property(weak, nonatomic) IBOutlet UISwitch *enabledSwitch;

@end

@implementation SliderAutolayoutExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  // Ensure a consistent starting state
  _materialSlider.enabled = YES;
  _vanillaSlider.enabled = _materialSlider.enabled;
  _enabledSwitch.on = _materialSlider.enabled;
  _materialSlider.value = _vanillaSlider.value;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)materialSliderDidChange:(id)sender {
  NSLog(@"Material Slider : %.2f", self.materialSlider.value);

  self.vanillaSlider.value = self.materialSlider.value;
}

- (IBAction)vanillaSliderDidChange:(id)sender {
  NSLog(@"Vanilla Slider : %.2f", self.vanillaSlider.value);

  self.materialSlider.value = self.vanillaSlider.value;
}

- (IBAction)toggleSwitchesEnabled:(id)sender {
  BOOL newEnabledState = !self.materialSlider.enabled;
  self.materialSlider.enabled = newEnabledState;
  self.vanillaSlider.enabled = newEnabledState;
}

#pragma mark catalg by convention

+ (NSArray *)catalogHierarchy {
  return @[ @"Slider", @"MDCSlider vs UISlider with autolayout" ];
}

+ (NSString *)catalogStoryboardName {
  return @"SliderAutolayoutExample";
}

@end
