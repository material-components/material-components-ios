// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCNavigationBarColorThemer.h"

@implementation MDCNavigationBarColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                 toNavigationBar:(nonnull MDCNavigationBar *)navigationBar {
  navigationBar.backgroundColor = colorScheme.primaryColor;
  navigationBar.titleTextColor = colorScheme.onPrimaryColor;
  navigationBar.tintColor = colorScheme.onPrimaryColor;
}

+ (void)applySurfaceVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                           toNavigationBar:(nonnull MDCNavigationBar *)navigationBar {
  [self resetUIControlStatesForNavigationBar:navigationBar];

  navigationBar.backgroundColor = colorScheme.surfaceColor;
  // Note that we must set the tint color before setting the buttons title color. Otherwise the
  // button title colors will be set with the tint color.
  navigationBar.tintColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54];
  navigationBar.titleTextColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  [navigationBar setButtonsTitleColor:navigationBar.titleTextColor forState:UIControlStateNormal];
}

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
         toNavigationBar:(MDCNavigationBar *)navigationBar {
  navigationBar.backgroundColor = colorScheme.primaryColor;
}

+ (void)resetUIControlStatesForNavigationBar:(nonnull MDCNavigationBar *)navigationBar {
  NSUInteger maximumStateValue = (UIControlStateNormal | UIControlStateSelected |
                                  UIControlStateHighlighted | UIControlStateDisabled);
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [navigationBar setButtonsTitleColor:nil forState:state];
  }
}

@end
