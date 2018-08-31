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

#import "MDCFloatingButtonColorThemer.h"

@implementation MDCFloatingButtonColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toButton:(nonnull MDCFloatingButton *)button {
  [self resetUIControlStatesForButtonTheming:button];
  [button setBackgroundColor:colorScheme.secondaryColor forState:UIControlStateNormal];
  [button setImageTintColor:colorScheme.onSecondaryColor forState:UIControlStateNormal];

  button.disabledAlpha = 1.f;
}

+ (void)resetUIControlStatesForButtonTheming:(nonnull MDCButton *)button {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
  UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [button setBackgroundColor:nil forState:state];
    [button setTitleColor:nil forState:state];
  }
}

@end
