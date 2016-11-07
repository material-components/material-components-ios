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

#import "MaterialSwitch.h"

#import "SwitchTypicalUseSupplemental.h"

@implementation SwitchTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // Switch

  self.switchComponent = [[MDCSwitch alloc] init];
  [self.switchComponent setOn:YES];
  [self.switchComponent addTarget:self
                           action:@selector(didChangeSwitchValue:)
                 forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.switchComponent];

  // Switch custom color

  self.colorSwitchComponent = [[MDCSwitch alloc] init];
  [self.colorSwitchComponent setOn:YES];
  self.colorSwitchComponent.onTintColor = [UIColor colorWithRed:0 green:0.47f blue:0.9f alpha:1];
  [self.colorSwitchComponent addTarget:self
                                action:@selector(didChangeSwitchValue:)
                      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.colorSwitchComponent];

  // Switch disabled

  self.disabledSwitchComponent = [[MDCSwitch alloc] init];
  [self.disabledSwitchComponent addTarget:self
                                   action:@selector(didChangeSwitchValue:)
                         forControlEvents:UIControlEventValueChanged];
  self.disabledSwitchComponent.enabled = NO;
  [self.view addSubview:self.disabledSwitchComponent];

  self.switchComponent.translatesAutoresizingMaskIntoConstraints = NO;
  self.colorSwitchComponent.translatesAutoresizingMaskIntoConstraints = NO;
  self.disabledSwitchComponent.translatesAutoresizingMaskIntoConstraints = NO;

  [self setupExampleViews];
}

- (void)didChangeSwitchValue:(MDCSwitch *)sender {
  NSLog(@"did change %@ value: %d", NSStringFromClass([sender class]), sender.isOn);
}

@end
