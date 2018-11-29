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

/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to use Material Components for iOS.
 */

#import <UIKit/UIKit.h>

#import "MaterialActivityIndicator.h"
#import "MaterialCollections.h"

static const CGFloat kActivityIndicatorRadius = 72;
static const CGFloat kActivityInitialProgress = (CGFloat)0.6;

@class ActivityIndicatorExampleViewController;
@class MDCActivityIndicator;

@interface ActivityIndicatorExampleViewController
    : UITableViewController <MDCActivityIndicatorDelegate>

@property(nonatomic, strong) MDCActivityIndicator *activityIndicator1;
@property(nonatomic, strong) MDCActivityIndicator *activityIndicator2;
@property(nonatomic, strong) MDCActivityIndicator *activityIndicator3;
@property(nonatomic, strong) UIView *indicators;

@property(nonatomic, strong) UISlider *slider;
@property(nonatomic, strong) UISwitch *onSwitch;
@property(nonatomic, strong) UISwitch *modeSwitch;

@end

@interface ActivityIndicatorExampleViewController (Supplemental)

- (void)setupExampleViews;

@end
