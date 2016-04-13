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

/** IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import <UIKit/UIKit.h>

@class ExampleConfigurationsView;
@class MDCFlexibleHeaderViewController;

@interface FlexibleHeaderConfiguratorExample : UIViewController

@property(nonatomic) ExampleConfigurationsView *exampleView;
@property(nonatomic) UIScrollView *scrollView;

- (void)sliderDidSlide:(UISwitch *)sender;
- (void)switchDidToggle:(UISwitch *)sender;

@end

@interface FlexibleHeaderConfiguratorExample (Supplemental)

- (void)setupExampleViews:(MDCFlexibleHeaderViewController *)fhvc;

@end

@interface ExampleConfigurationsView : UIView

@property(nonatomic) UISlider *minHeightSlider;
@property(nonatomic) UILabel *minHeightSliderLabel;
@property(nonatomic) UISlider *maxHeightSlider;
@property(nonatomic) UILabel *maxHeightSliderLabel;

@property(nonatomic) UISwitch *overExtendSwitch;
@property(nonatomic) UILabel *overExtendSwitchLabel;
@property(nonatomic) UISwitch *shiftSwitch;
@property(nonatomic) UILabel *shiftSwitchLabel;
@property(nonatomic) UISwitch *shiftStatusBarSwitch;
@property(nonatomic) UILabel *shiftStatusBarSwitchLabel;
@property(nonatomic) UISwitch *infiniteContentSwitch;
@property(nonatomic) UILabel *infiniteContentSwitchLabel;

@end
