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

#import "SliderAutolayoutExampleViewController.h"

#import "MaterialSlider+ColorThemer.h"
#import "MaterialSlider.h"

@interface SliderAutolayoutExampleViewController ()
@property(weak, nonatomic) IBOutlet UISlider *vanillaSlider;
@property(weak, nonatomic) IBOutlet UISwitch *enabledSwitch;
@property(weak, nonatomic) IBOutlet UILabel *materialLabel;
@property(weak, nonatomic) IBOutlet UILabel *uiLabel;
@property(weak, nonatomic) IBOutlet MDCSlider *materialSlider;

@end

@implementation SliderAutolayoutExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Ensure a consistent starting state
  _materialSlider.enabled = YES;
  _vanillaSlider.enabled = _materialSlider.enabled;
  _enabledSwitch.on = _materialSlider.enabled;
  _materialSlider.value = _vanillaSlider.value;

  [MDCSliderColorThemer applySemanticColorScheme:self.colorScheme toSlider:self.materialSlider];

  _materialLabel.font = self.typographyScheme.body1;
  _uiLabel.font = self.typographyScheme.body1;
}

- (IBAction)materialSliderDidChange:(id)sender {
  NSLog(@"Material Slider : %.2f", self.materialSlider.value);

  self.vanillaSlider.value = (float)self.materialSlider.value;
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

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Slider", @"Slider Autolayout" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
    @"storyboardName" : @"SliderAutolayoutExample"
  };
}

@end
