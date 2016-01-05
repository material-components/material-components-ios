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

#import "MaterialSwitch.h"

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  // Load your Material Component here.
  MDCSwitch *mdcSwitch = [[MDCSwitch alloc] init];
  [mdcSwitch addTarget:self
                action:@selector(didChangeSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:mdcSwitch];
  CGFloat xOffset = CGRectGetMidX(self.view.bounds);
  CGFloat yOffset = CGRectGetMidY(self.view.bounds) - 2 * mdcSwitch.frame.size.height;
  mdcSwitch.center = CGPointMake(xOffset, yOffset);

  UILabel *label = [[UILabel alloc] init];
  label.text = @"MDCSwitch";
  [label sizeToFit];
  [self.view addSubview:label];
  label.center = CGPointMake(mdcSwitch.center.x, mdcSwitch.center.y + 2 * label.frame.size.height);

  // Vanilla  UISlider for comparison.
  UISwitch *uiSwitch = [[UISwitch alloc] init];
  [uiSwitch addTarget:self
                action:@selector(didChangeSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:uiSwitch];
  xOffset = CGRectGetMidX(self.view.bounds);
  yOffset = CGRectGetMidY(self.view.bounds) + 4 * uiSwitch.frame.size.height;
  uiSwitch.center = CGPointMake(xOffset, yOffset);

  UILabel *uiSliderLabel = [[UILabel alloc] init];
  uiSliderLabel.text = @"UISwitch";
  [uiSliderLabel sizeToFit];
  [self.view addSubview:uiSliderLabel];
  xOffset = uiSwitch.center.x;
  yOffset = uiSwitch.center.y + 2 * uiSliderLabel.frame.size.height;
  uiSliderLabel.center = CGPointMake(xOffset, yOffset);
}

- (void)didChangeSliderValue:(id)sender {
  UISwitch *slider = sender;
  NSLog(@"did change %@ value: %d", NSStringFromClass([sender class]), slider.isOn);
}

@end
