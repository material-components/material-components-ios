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
#import <UIKit/UIKit.h>

@class MDCTabBarView;

/**
 Methods for notification and control of selection events for @c MDCTabBarView.
 */
@protocol MDCTabBarViewDelegate <NSObject>

@optional

/**
 Determines if a UITabBarItem should be selected. Can be used to allow clients to activate (tap) a
 tab in the bar, but not have a selection event take place.

 @param tabBarView The view receiving the activation event.
 @param item The item being selected.
 @return @c YES if the item should be selected.
 */
- (BOOL)tabBarView:(nonnull MDCTabBarView *)tabBarView
    shouldSelectItem:(nonnull UITabBarItem *)item;

/**
 Called when a new item is selected by the user.

 @param tabBarView The view receiving the selection.
 @param item The selected item.

 @note This method is not called for programmatic selection events.
 */
- (void)tabBarView:(nonnull MDCTabBarView *)tabBarView didSelectItem:(nonnull UITabBarItem *)item;

@end
