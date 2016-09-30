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

#import "SwitchSimpleExampleViewController.h"

#import "MaterialSwitch.h"

@implementation SwitchSimpleExampleViewController {
  MDCSwitch *_materialSwitch;
  UISwitch *_vanillaSwitch;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  // Load your Material Component here.
  _materialSwitch = [[MDCSwitch alloc] init];
  [_materialSwitch addTarget:self
                      action:@selector(didChangeSliderValue:)
            forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_materialSwitch];
  CGFloat xOffset = CGRectGetMidX(self.view.bounds);
  CGFloat yOffset = CGRectGetMidY(self.view.bounds) - 2 * _materialSwitch.frame.size.height;
  _materialSwitch.center = CGPointMake(xOffset, yOffset);

  UILabel *label = [[UILabel alloc] init];
  label.text = @"MDCSwitch";
  [label sizeToFit];
  [self.view addSubview:label];
  label.center =
      CGPointMake(_materialSwitch.center.x, _materialSwitch.center.y + 2 * label.frame.size.height);

  // Vanilla  UISlider for comparison.
  _vanillaSwitch = [[UISwitch alloc] init];
  [_vanillaSwitch addTarget:self
                     action:@selector(didChangeSliderValue:)
           forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_vanillaSwitch];
  xOffset = CGRectGetMidX(self.view.bounds);
  yOffset = CGRectGetMidY(self.view.bounds) + 4 * _vanillaSwitch.frame.size.height;
  _vanillaSwitch.center = CGPointMake(xOffset, yOffset);

  UILabel *uiSliderLabel = [[UILabel alloc] init];
  uiSliderLabel.text = @"UISwitch";
  [uiSliderLabel sizeToFit];
  [self.view addSubview:uiSliderLabel];
  xOffset = _vanillaSwitch.center.x;
  yOffset = _vanillaSwitch.center.y + 2 * uiSliderLabel.frame.size.height;
  uiSliderLabel.center = CGPointMake(xOffset, yOffset);
}

- (void)didChangeSliderValue:(id)sender {
  UISwitch *slider = sender;
  NSLog(@"did change %@ value: %d", NSStringFromClass([sender class]), slider.isOn);
}

#pragma mark catalg by convention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Switch", @"MDCSwitch and UISwitch Compared" ];
}

@end
