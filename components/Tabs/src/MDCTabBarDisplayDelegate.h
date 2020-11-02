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

#import <Foundation/Foundation.h>
#import "MDCTabBar.h"

/**
 An additional delegate protocol for MDCTabBar that provides information about when UITabBarItems
 are about to be displayed and when they stop being displayed.
 */
__deprecated_msg(
    "Use MDCTabBarViewDelegate instead. See go/material-ios-tabbar-migration for more details.")
    @protocol MDCTabBarDisplayDelegate

/**
 This method is called sometime before the tab's view is displayed.
 */
- (void)tabBar:(nonnull MDCTabBar *)tabBar willDisplayItem:(nonnull UITabBarItem *)item;

/**
 This method is called sometime after the tab's view has stopped being displayed.
 */
- (void)tabBar:(nonnull MDCTabBar *)tabBar didEndDisplayingItem:(nonnull UITabBarItem *)item;

@end

@interface MDCTabBar (MDCTabBarDisplayDelegate)

/**
 A delegate that allows implementers to receive updates on when UITabBarItems are about to be
 displayed and when they stop being displayed.

 @note This property may be removed in a future version and should be used with that understanding.
 */
@property(nonatomic, weak, nullable) NSObject<MDCTabBarDisplayDelegate> *displayDelegate;

@end
