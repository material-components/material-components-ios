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

@interface ThemerTypicalUseViewController ()

@end

@implementation ThemerTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Apply color scheme to material design components using component themers.
  [MDCActivityIndicatorColorThemer applyColorScheme:self.colorScheme
                                toActivityIndicator:[MDCActivityIndicator appearance]];
  [MDCAlertColorThemer applyColorScheme:self.colorScheme];
  [MDCButtonBarColorThemer applyColorScheme:self.colorScheme toButtonBar:[MDCButtonBar appearance]];
  [MDCButtonColorThemer applyColorScheme:self.colorScheme toButton:[MDCButton appearance]];
  [MDCFeatureHighlightColorThemer applyColorScheme:self.colorScheme
                            toFeatureHighlightView:[MDCFeatureHighlightView appearance]];
  [MDCFlexibleHeaderColorThemer applyColorScheme:self.colorScheme
                            toFlexibleHeaderView:[MDCFlexibleHeaderView appearance]];
  [MDCHeaderStackViewColorThemer applyColorScheme:self.colorScheme
                                toHeaderStackView:[MDCHeaderStackView appearance]];
  [MDCNavigationBarColorThemer applyColorScheme:self.colorScheme
                                toNavigationBar:[MDCNavigationBar appearance]];
  [MDCPageControlColorThemer applyColorScheme:self.colorScheme
                                toPageControl:[MDCPageControl appearance]];
  [MDCProgressViewColorThemer applyColorScheme:self.colorScheme
                                toProgressView:[MDCProgressView appearance]];
  [MDCSliderColorThemer applyColorScheme:self.colorScheme toSlider:[MDCSlider appearance]];
  [MDCTabBarColorThemer applyColorScheme:self.colorScheme toTabBar:[MDCTabBar appearance]];
  [MDCTextFieldColorThemer
      applyColorSchemeToAllTextInputControllerDefault:self.colorScheme];

  // Apply color scheme to UIKit components.
  [UISlider appearance].tintColor = self.colorScheme.primaryColor;
  [UISwitch appearance].tintColor = self.colorScheme.primaryColor;

  // Send notification that color scheme has changed so existing components can update if necessary.
  NSDictionary *userInfo = @{ @"colorScheme" : self.colorScheme };
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ColorThemeChangeNotification"
                                                      object:self
                                                    userInfo:userInfo];

  [self setupExampleViews];
}

@end
