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
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to use Material Components for iOS.
 */

#import <UIKit/UIKit.h>

#import "MaterialActivityIndicator.h"

static const CGFloat kActivityIndicatorRadius = 72.f;
static const CGFloat kActivityInitialProgress = 0.6f;

@class ActivityIndicatorExample;
@class MDCActivityIndicator;

@interface ActivityIndicatorExample : UIViewController <MDCActivityIndicatorDelegate>

@property(nonatomic, strong) MDCActivityIndicator *activityIndicator;
@property(nonatomic, strong) UILabel *determinateSwitchLabel;
@property(nonatomic, strong) UILabel *onSwitchLabel;
@property(nonatomic, strong) UILabel *progressLabel;
@property(nonatomic, strong) UILabel *progressPercentLabel;
@property(nonatomic, strong) UISlider *slider;
@property(nonatomic, strong) UISwitch *onSwitch;
@property(nonatomic, strong) UISwitch *determinateSwitch;

@end

@interface ActivityIndicatorExample (Supplemental)

- (void)setupExampleViews;

@end
