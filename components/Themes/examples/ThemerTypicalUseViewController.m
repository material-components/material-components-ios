/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "ThemerTypicalUseSupplemental.h"

#import "MaterialFlexibleHeader.h"
#import "MaterialPalettes.h"
#import "MaterialProgressView.h"
#import "MaterialThemes.h"

@interface ThemerTypicalUseViewController ()

@end

@implementation ThemerTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Apply color scheme to components for theming.
  [MDCActivityIndicatorColorThemer applyColorScheme:self.colorScheme
                                toActivityIndicator:[MDCActivityIndicator appearance]];
  [MDCAlertColorThemer applyColorScheme:self.colorScheme];
  [MDCButtonColorThemer applyColorScheme:self.colorScheme toButton:[MDCButton appearance]];
  [MDCFeatureHighlightColorThemer applyColorScheme:self.colorScheme
                            toFeatureHighlightView:[MDCFeatureHighlightView appearance]];
  [MDCFlexibleHeaderColorThemer applyColorScheme:self.colorScheme
                            toFlexibleHeaderView:[MDCFlexibleHeaderView appearance]];
  [MDCSliderColorThemer applyColorScheme:self.colorScheme toSlider:[MDCSlider appearance]];
  [MDCProgressViewColorThemer applyColorScheme:self.colorScheme
                                toProgressView:[MDCProgressView appearance]];

  [self setupExampleViews];
}

@end
