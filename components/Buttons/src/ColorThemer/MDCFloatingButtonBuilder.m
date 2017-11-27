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

#import "MDCFloatingButtonBuilder.h"

#import "MDCFloatingButtonColorThemer.h"

@implementation MDCFloatingButtonBuilder
+ (MDCFloatingButton *)floatingButtonWithScheme:(id<MDCColorScheme>)colorScheme {
  MDCFloatingButton *button
      = [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];

  if (colorScheme) {
    [MDCFloatingButtonColorThemer applyColorScheme:colorScheme toButton:button];
  }

  [button setElevation:3 forState:UIControlStateNormal];
  [button setElevation:6 forState:UIControlStateHighlighted];

  return button;
}

+ (MDCFloatingButton *)extendedFloatingButtonWithScheme:(id<MDCColorScheme>)colorScheme {
  MDCFloatingButton *button
      = [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];

  if (colorScheme) {
    [MDCFloatingButtonColorThemer applyColorScheme:colorScheme toButton:button];
  }

  [button setElevation:3 forState:UIControlStateNormal];
  [button setElevation:6 forState:UIControlStateHighlighted];

  button.mode = MDCFloatingButtonModeExpanded;
  return button;
}

@end
