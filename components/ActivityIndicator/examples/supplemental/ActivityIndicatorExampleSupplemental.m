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

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "ActivityIndicatorExampleSupplemental.h"
#import "MaterialTypography.h"

@implementation ActivityIndicatorExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Activity Indicator", @"Activity Indicator" ];
}

+ (NSString *)catalogDescription {
  return @"Activity Indicator is a visual indication of an app loading content. It can display how "
         @"long an operation will take or visualize an unspecified wait time.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation ActivityIndicatorExample (Supplemental)

- (void)setupExampleViews {

  self.onSwitch = [[UISwitch alloc] init];
  self.onSwitch.onTintColor = [UIColor colorWithWhite:0.1 alpha:1.0];
  
  [self.onSwitch setOn:YES];
  [self.onSwitch addTarget:self
                    action:@selector(didChangeOnSwitch:)
          forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.onSwitch];

  self.onSwitchLabel = [[UILabel alloc] init];
  self.onSwitchLabel.text = @"Indicator Active";
  self.onSwitchLabel.font = [MDCTypography captionFont];
  self.onSwitchLabel.alpha = [MDCTypography captionFontOpacity];
  [self.onSwitchLabel sizeToFit];
  [self.view addSubview:self.onSwitchLabel];

  self.determinateSwitch = [[UISwitch alloc] init];
  self.determinateSwitch.onTintColor = [UIColor colorWithWhite:0.1 alpha:1.0];
  [self.determinateSwitch setOn:YES];
  [self.determinateSwitch addTarget:self
                             action:@selector(didChangeDeterminateSwitch:)
                   forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.determinateSwitch];

  self.determinateSwitchLabel = [[UILabel alloc] init];
  self.determinateSwitchLabel.text = @"Determinate Mode";
  self.determinateSwitchLabel.font = [MDCTypography captionFont];
  self.determinateSwitchLabel.alpha = [MDCTypography captionFontOpacity];
  [self.determinateSwitchLabel sizeToFit];
  [self.view addSubview:self.determinateSwitchLabel];

  CGRect sliderFrame = CGRectMake(0, 0, 240, 27);
  self.slider = [[UISlider alloc] initWithFrame:sliderFrame];
  self.slider.tintColor = [UIColor colorWithWhite:0.1 alpha:1.0];
  self.slider.value = kActivityInitialProgress;
  [self.slider addTarget:self
                  action:@selector(didChangeSliderValue:)
        forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.slider];

  self.progressLabel = [[UILabel alloc] init];
  self.progressLabel.text = @"Progress";
  self.progressLabel.font = [MDCTypography captionFont];
  self.progressLabel.alpha = [MDCTypography captionFontOpacity];
  [self.progressLabel sizeToFit];
  [self.view addSubview:self.progressLabel];

  self.progressPercentLabel = [[UILabel alloc] init];
  self.progressPercentLabel.text =
      [NSString stringWithFormat:@"%.00f%%", kActivityInitialProgress * 100];
  self.progressPercentLabel.font = [MDCTypography captionFont];
  self.progressPercentLabel.alpha = [MDCTypography captionFontOpacity];
  self.progressPercentLabel.frame = CGRectMake(0, 0, 100, 16);
  self.progressPercentLabel.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:self.progressPercentLabel];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
  if (self.view.frame.size.height > self.view.frame.size.width) {
    self.activityIndicator.center =
        CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) - navHeight * 2);
    self.slider.center = CGPointMake(CGRectGetMidX(self.view.frame), 80);
    self.progressLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), 110);
    self.onSwitch.center =
        CGPointMake(CGRectGetMidX(self.view.frame) - 50, self.view.frame.size.height - 140);
    self.onSwitchLabel.center =
        CGPointMake(CGRectGetMidX(self.view.frame) + 32, self.view.frame.size.height - 140);
    self.determinateSwitch.center =
        CGPointMake(CGRectGetMidX(self.view.frame) - 50, self.view.frame.size.height - 90);
    self.determinateSwitchLabel.center =
        CGPointMake(CGRectGetMidX(self.view.frame) + 38, self.view.frame.size.height - 90);
  } else {
    self.activityIndicator.center =
        CGPointMake(CGRectGetMidX(self.view.frame) - 150, CGRectGetMidY(self.view.frame) - 100);
    self.slider.center = CGPointMake(CGRectGetMidX(self.view.frame) + 150, 20);
    self.progressLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) + 150, 50);
    self.onSwitch.center =
        CGPointMake(CGRectGetMidX(self.view.frame) + 90, self.view.frame.size.height - 140);
    self.onSwitchLabel.center =
        CGPointMake(CGRectGetMidX(self.view.frame) + 172, self.view.frame.size.height - 140);
    self.determinateSwitch.center =
        CGPointMake(CGRectGetMidX(self.view.frame) + 90, self.view.frame.size.height - 90);
    self.determinateSwitchLabel.center =
        CGPointMake(CGRectGetMidX(self.view.frame) + 178, self.view.frame.size.height - 90);
  }
  self.progressPercentLabel.center = self.activityIndicator.center;
}

- (void)didChangeDeterminateSwitch:(UISwitch *)determinateSwitch {
  if (determinateSwitch.on) {
    self.activityIndicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  } else {
    self.activityIndicator.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  }
}

- (void)didChangeOnSwitch:(UISwitch *)onSwitch {
  if (onSwitch.on) {
    [self.activityIndicator startAnimating];
  } else {
    [self.activityIndicator stopAnimating];
  }
}

- (void)didChangeSliderValue:(UISlider *)slider {
  self.activityIndicator.progress = slider.value;
  self.progressPercentLabel.text = [NSString stringWithFormat:@"%.00f%%", slider.value * 100];
}

@end
