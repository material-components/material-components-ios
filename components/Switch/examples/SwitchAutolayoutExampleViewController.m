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

#import "SwitchAutolayoutExampleViewController.h"

#import "MDCSwitch.h"

@interface SwitchAutolayoutExampleViewController ()

@property(weak, nonatomic) IBOutlet MDCSwitch *materialSwitch;
@property(weak, nonatomic) IBOutlet UISwitch *vanillaSwitch;
@property(weak, nonatomic) IBOutlet UIButton *enableButton;

@end

@implementation SwitchAutolayoutExampleViewController

- (IBAction)disableEnableToggle:(id)sender {
  BOOL controlsAreEnabled = _materialSwitch.enabled;
  _materialSwitch.enabled = !controlsAreEnabled;
  _vanillaSwitch.enabled = !controlsAreEnabled;
  if (_materialSwitch.enabled) {
    [_enableButton setTitle:@"Disable Switches" forState:UIControlStateNormal];
    NSLog(@".enabled = YES");
  } else {
    [_enableButton setTitle:@"Enable Switches" forState:UIControlStateNormal];
    NSLog(@".enabled = NO");
  }
}

#pragma mark catalg by convention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Switch", @"Switch Autolayout" ];
}

+ (NSString *)catalogStoryboardName {
  return @"SwitchAutolayoutExample";
}

@end
