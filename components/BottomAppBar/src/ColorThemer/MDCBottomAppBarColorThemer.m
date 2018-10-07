// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBottomAppBarColorThemer.h"

#import "MaterialBottomAppBar.h"
#import "MaterialThemes.h"

@implementation MDCBottomAppBarColorThemer

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
      toBottomAppBarView:(MDCBottomAppBarView *)bottomAppBarView {
  bottomAppBarView.barTintColor = colorScheme.primaryColor;
}

+ (void)applySurfaceVariantWithSemanticColorScheme:(id<MDCColorScheming>)colorScheme
                                toBottomAppBarView:(MDCBottomAppBarView *)bottomAppBarView {
  [self resetUIStatesForTheming:bottomAppBarView.floatingButton];

  bottomAppBarView.barTintColor = colorScheme.surfaceColor;
  UIColor *barItemTintColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6];
  bottomAppBarView.leadingBarItemsTintColor = barItemTintColor;
  bottomAppBarView.trailingBarItemsTintColor = barItemTintColor;
  [bottomAppBarView.floatingButton setBackgroundColor:colorScheme.primaryColor
                                             forState:UIControlStateNormal];
  [bottomAppBarView.floatingButton setTitleColor:colorScheme.onPrimaryColor
                                        forState:UIControlStateNormal];
  [bottomAppBarView.floatingButton setImageTintColor:colorScheme.onPrimaryColor
                                            forState:UIControlStateNormal];
}

#pragma mark - Utility methods

+ (void)resetUIStatesForTheming:(MDCButton *)button {
  UIControlState maxState = UIControlStateNormal | UIControlStateHighlighted |
                            UIControlStateDisabled | UIControlStateSelected;
  for (UIControlState state = 0; state <= maxState; ++state) {
    [button setImageTintColor:nil forState:state];
    [button setTitleColor:nil forState:state];
    [button setBackgroundColor:nil forState:state];
  }
}

@end
