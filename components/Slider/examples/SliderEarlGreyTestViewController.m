// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSlider.h"

@interface SliderEarlGreyTestViewController : UIViewController
@property(nonatomic, strong, nullable) UILabel *valueLabel;
@property(nonatomic, strong, nullable) MDCSlider *slider;
@end

@implementation SliderEarlGreyTestViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.whiteColor;

  self.slider = [[MDCSlider alloc] init];
  [self.slider addTarget:self
                  action:@selector(sliderValueChanged)
        forControlEvents:UIControlEventValueChanged];
  self.slider.minimumValue = 0;
  self.slider.maximumValue = 10;
  self.slider.filledTrackAnchorValue = 5;
  self.slider.value = 5;
  self.slider.accessibilityIdentifier = @"slider";

  self.valueLabel = [[UILabel alloc] init];
  self.valueLabel.text = @"5";
  self.valueLabel.textAlignment = NSTextAlignmentCenter;
  self.valueLabel.textColor = UIColor.blackColor;
  self.valueLabel.accessibilityIdentifier = @"slider_value_label";

  UIStackView *stackView = [[UIStackView alloc] init];
  stackView.axis = UILayoutConstraintAxisVertical;
  stackView.spacing = 10;
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  [stackView addArrangedSubview:self.valueLabel];
  [stackView addArrangedSubview:self.slider];

  [self.view addSubview:stackView];
  [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
  [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
  [stackView.widthAnchor constraintEqualToConstant:300].active = YES;
}

- (void)sliderValueChanged {
  self.valueLabel.text = [NSString stringWithFormat:@"%.f", self.slider.value];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Slider", @"Earl Grey Testbed" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
