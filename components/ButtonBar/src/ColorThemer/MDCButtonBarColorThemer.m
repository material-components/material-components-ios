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

#import "MDCButtonBarColorThemer.h"

#import "MaterialNavigationBar.h"

@implementation MDCButtonBarColorThemer

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
             toButtonBar:(MDCButtonBar *)buttonBar {
  buttonBar.backgroundColor = colorScheme.primaryColor;

  // When a button bar is contained in a navigation bar do not color the button bar. This is useful
  // for when an app bar with imagery in the flexible header has a button bar. If the button bar has
  // a color then the imagery is obstucted by the solid color of the button bar.
#if defined(__IPHONE_9_0) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
  [MDCButtonBar appearanceWhenContainedInInstancesOfClasses:@[[MDCNavigationBar class]]]
      .backgroundColor = nil;
#else
  [MDCButtonBar appearanceWhenContainedIn:[MDCNavigationBar class], nil].backgroundColor = nil;
#endif
}

@end
