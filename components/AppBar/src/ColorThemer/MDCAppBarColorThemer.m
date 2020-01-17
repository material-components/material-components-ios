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

#import "MDCAppBarColorThemer.h"

#import "MaterialNavigationBar+ColorThemer.h"

@implementation MDCAppBarColorThemer

+ (void)applyColorScheme:(nonnull id<MDCColorScheming>)colorScheme
    toAppBarViewController:(nonnull MDCAppBarViewController *)appBarViewController {
  appBarViewController.headerView.backgroundColor = colorScheme.primaryColor;
  [MDCNavigationBarColorThemer applySemanticColorScheme:colorScheme
                                        toNavigationBar:appBarViewController.navigationBar];
}

+ (void)applySurfaceVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                    toAppBarViewController:(nonnull MDCAppBarViewController *)appBarViewController {
  appBarViewController.headerView.backgroundColor = colorScheme.surfaceColor;
  [MDCNavigationBarColorThemer
      applySurfaceVariantWithColorScheme:colorScheme
                         toNavigationBar:appBarViewController.navigationBar];
}

#pragma mark - To be deprecated

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme toAppBar:(MDCAppBar *)appBar {
  appBar.headerViewController.headerView.backgroundColor = colorScheme.primaryColor;
  [MDCNavigationBarColorThemer applySemanticColorScheme:colorScheme
                                        toNavigationBar:appBar.navigationBar];
}

+ (void)applySurfaceVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                  toAppBar:(nonnull MDCAppBar *)appBar {
  appBar.headerViewController.headerView.backgroundColor = colorScheme.surfaceColor;
  [MDCNavigationBarColorThemer applySurfaceVariantWithColorScheme:colorScheme
                                                  toNavigationBar:appBar.navigationBar];
}

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme toAppBar:(MDCAppBar *)appBar {
  appBar.headerViewController.headerView.backgroundColor = colorScheme.primaryColor;
  [MDCNavigationBarColorThemer applyColorScheme:colorScheme toNavigationBar:appBar.navigationBar];
}

@end
