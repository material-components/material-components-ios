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

#import "ExampleFloatingButtonThemer.h"
#import "MDCButtonColorThemer.h"

@implementation ExampleFloatingButtonThemer

+ (void)applyToButton:(nonnull MDCFloatingButton *)button
      withColorScheme:(nullable NSObject<MDCColorScheme> *)colorScheme {
  if (colorScheme) {
    [MDCButtonColorThemer applyColorScheme:colorScheme toButton:button];
  }
  UIEdgeInsets expandedLeadingInsets = UIEdgeInsetsMake(4, 6, 4, 12);

  UIEdgeInsets hitAreaCompactDefault = UIEdgeInsetsMake(-8, -8, -8, -8);
  UIEdgeInsets hitAreaCompactMini = UIEdgeInsetsMake(-16, -16, -16, -16);


  CGSize sizeCompactDefault = CGSizeMake(40, 40);
  CGSize sizeExtendedMinimum = CGSizeMake(100, 40);

  [button setContentEdgeInsets:expandedLeadingInsets
                       forType:MDCFloatingButtonTypeDefault
                          mode:MDCFloatingButtonModeExtended];

  [button setHitAreaInsets:hitAreaCompactMini
                   forType:MDCFloatingButtonTypeMini
                      mode:MDCFloatingButtonModeNormal];
  [button setHitAreaInsets:hitAreaCompactDefault
                   forType:MDCFloatingButtonTypeDefault
                      mode:MDCFloatingButtonModeNormal];

  [button setMinimumSize:sizeCompactDefault
                 forType:MDCFloatingButtonTypeDefault
                    mode:MDCFloatingButtonModeNormal];
  [button setMaximumSize:sizeCompactDefault
                 forType:MDCFloatingButtonTypeDefault
                    mode:MDCFloatingButtonModeNormal];

  [button setMinimumSize:sizeExtendedMinimum
                 forType:MDCFloatingButtonTypeDefault
                    mode:MDCFloatingButtonModeExtended];
  [button setMaximumSize:sizeExtendedMinimum
                 forType:MDCFloatingButtonTypeDefault
                    mode:MDCFloatingButtonModeExtended];

  [button setElevation:3 forState:UIControlStateNormal];
  [button setElevation:6 forState:UIControlStateHighlighted];

  [button setImageTitlePadding:4];
}

@end
