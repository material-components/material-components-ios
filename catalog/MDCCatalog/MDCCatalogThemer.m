/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
#import <Foundation/Foundation.h>

#import "MDCCatalogThemer.h"
#import "MDCActivityIndicatorColorThemer.h"
#import "MDCAlertColorThemer.h"
#import "MDCButtonBarColorThemer.h"
#import "MDCButtonColorThemer.h"
#import "MDCFeatureHighlightColorThemer.h"
#import "MDCFlexibleHeaderColorThemer.h"
#import "MDCHeaderStackViewColorThemer.h"
#import "MDCNavigationBarColorThemer.h"
#import "MDCPageControlColorThemer.h"
#import "MDCProgressViewColorThemer.h"
#import "MDCSliderColorThemer.h"
#import "MDCTabBarColorThemer.h"
#import "MDCTextFieldColorThemer.h"
#import "MaterialTextFields.h"

@implementation MDCCatalogThemer

+ (void)applyColorScheme:(NSObject<MDCColorScheme> *)colorScheme {
  // Apply color scheme to material design components using component themers.
  [MDCActivityIndicatorColorThemer applyColorScheme:colorScheme
                                toActivityIndicator:MDCActivityIndicator.appearance];
  [MDCAlertColorThemer applyColorScheme:colorScheme];
  [MDCButtonBarColorThemer applyColorScheme:colorScheme toButtonBar:MDCButtonBar.appearance];

  [MDCButtonColorThemer applyColorScheme:colorScheme toButton:MDCButton.appearance];
  MDCBasicColorScheme *clearScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:UIColor.clearColor];
  [MDCButtonColorThemer applyColorScheme:clearScheme toButton:MDCFlatButton.appearance];
  [MDCFeatureHighlightColorThemer applyColorScheme:colorScheme
                            toFeatureHighlightView:MDCFeatureHighlightView.appearance];
  [MDCFlexibleHeaderColorThemer applyColorScheme:colorScheme
                            toFlexibleHeaderView:MDCFlexibleHeaderView.appearance];
  [MDCHeaderStackViewColorThemer applyColorScheme:colorScheme
                                toHeaderStackView:MDCHeaderStackView.appearance];
  [MDCNavigationBarColorThemer applyColorScheme:colorScheme
                                toNavigationBar:MDCNavigationBar.appearance];
  [MDCPageControlColorThemer applyColorScheme:colorScheme toPageControl:MDCPageControl.appearance];
  [MDCProgressViewColorThemer applyColorScheme:colorScheme
                                toProgressView:MDCProgressView.appearance];
  [MDCSliderColorThemer applyColorScheme:colorScheme toSlider:MDCSlider.appearance];
  [MDCTabBarColorThemer applyColorScheme:colorScheme toTabBar:MDCTabBar.appearance];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:MDCTextInputControllerUnderline.class];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:MDCTextInputControllerLegacyDefault.class];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:MDCTextInputControllerFilled.class];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:MDCTextInputControllerOutlined.class];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:MDCTextInputControllerOutlinedTextArea.class];

  // Apply color scheme to UIKit components.
  UISlider.appearance.tintColor = colorScheme.primaryColor;
  UISwitch.appearance.onTintColor = colorScheme.primaryColor;
}
@end
