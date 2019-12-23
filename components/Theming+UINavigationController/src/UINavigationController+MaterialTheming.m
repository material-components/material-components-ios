// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "UINavigationController+MaterialTheming.h"

@implementation UINavigationController (MaterialTheming)

- (void)mdc_applyPrimaryThemeWithScheme:(id<MDCContainerScheming>)scheme {
  self.navigationBar.translucent = NO;

  if (@available(iOS 11.0, *)) {
    self.navigationBar.prefersLargeTitles = YES;
    self.navigationBar.largeTitleTextAttributes = @{
      NSForegroundColorAttributeName : scheme.colorScheme.onPrimaryColor,
      NSFontAttributeName : scheme.typographyScheme.headline5
    };
  }

  // Make content behind the navigation bar matche the background color of child view controllers.
  self.view.backgroundColor = scheme.colorScheme.backgroundColor;

  // Icon color
  self.navigationBar.tintColor = scheme.colorScheme.onPrimaryColor;

  if (@available(iOS 13.0, *)) {
    UINavigationBarAppearance *appearance = [self.navigationBar.standardAppearance copy];

    // Bar background
    appearance.backgroundColor = scheme.colorScheme.primaryColor;

    // Bar shadow
    appearance.shadowColor = scheme.colorScheme.onPrimaryColor;

    // Title when collapsed
    appearance.titleTextAttributes = @{
      NSForegroundColorAttributeName : scheme.colorScheme.onPrimaryColor,
      NSFontAttributeName : scheme.typographyScheme.headline6
    };
    // Title when expanded
    appearance.largeTitleTextAttributes = @{
      NSForegroundColorAttributeName : scheme.colorScheme.onPrimaryColor,
      NSFontAttributeName : scheme.typographyScheme.headline5
    };

    self.navigationBar.standardAppearance = appearance;
    self.navigationBar.scrollEdgeAppearance = appearance;

  } else {
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.barTintColor = scheme.colorScheme.primaryColor;
  }
}

@end
