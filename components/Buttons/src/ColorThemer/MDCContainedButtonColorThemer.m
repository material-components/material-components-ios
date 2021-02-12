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

#import "MDCContainedButtonColorThemer.h"

#import "MaterialButtons.h"

#import "MaterialColorScheme.h"

@implementation MDCContainedButtonColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toButton:(nonnull MDCButton *)button {
  [self resetUIControlStatesForButtonTheming:button];
  [button setBackgroundColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [button setBackgroundColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12]
                    forState:UIControlStateDisabled];
  [button setTitleColor:colorScheme.onPrimaryColor forState:UIControlStateNormal];
  [button setTitleColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]
               forState:UIControlStateDisabled];
  [button setImageTintColor:colorScheme.onPrimaryColor forState:UIControlStateNormal];
  [button setImageTintColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]
                   forState:UIControlStateDisabled];
  button.disabledAlpha = 1;
  button.inkColor = [colorScheme.onPrimaryColor colorWithAlphaComponent:(CGFloat)0.32];
}

+ (void)resetUIControlStatesForButtonTheming:(nonnull MDCButton *)button {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [button setBackgroundColor:nil forState:state];
    [button setTitleColor:nil forState:state];
    [button setImageTintColor:nil forState:state];
  }
}

@end
