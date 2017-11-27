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

  UIEdgeInsets defaultExtendedInsets = UIEdgeInsetsMake(4, 8, 4, 12);
  CGSize defaultExtendedMinimumSize = CGSizeMake(132, 40);
  CGSize defaultExtendedMaximumSize = CGSizeZero;

  UIEdgeInsets miniExtendedInsets = UIEdgeInsetsMake(4, 8, 4, 8);
  CGSize miniExtendedMinimumSize = CGSizeMake(112, 32);
  CGSize miniExtendedMaximumSize = CGSizeMake(280, 32);

  [button setContentEdgeInsets:defaultExtendedInsets
                      forShape:MDCFloatingButtonShapeDefault
                          mode:MDCFloatingButtonModeExpanded];
  [button setContentEdgeInsets:miniExtendedInsets
                      forShape:MDCFloatingButtonShapeMini
                          mode:MDCFloatingButtonModeExpanded];

  [button setMinimumSize:defaultExtendedMinimumSize
                forShape:MDCFloatingButtonShapeDefault
                    mode:MDCFloatingButtonModeExpanded];
  [button setMaximumSize:defaultExtendedMaximumSize
                forShape:MDCFloatingButtonShapeDefault
                    mode:MDCFloatingButtonModeExpanded];
  [button setMinimumSize:miniExtendedMinimumSize
                forShape:MDCFloatingButtonShapeMini
                    mode:MDCFloatingButtonModeExpanded];
  [button setMaximumSize:miniExtendedMaximumSize
                forShape:MDCFloatingButtonShapeMini
                    mode:MDCFloatingButtonModeExpanded];

  [button setImageTitlePadding:4];
}

@end
