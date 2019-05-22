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

#import <UIKit/UIKit.h>

#import "MDCBottomNavigationSystemDialogView.h"

/**
 * The transient dialog view that displays a @c UITabBarItem with a larger icon and title font size.
 */
@interface MDCBottomNavigationLargeItemDialogView : MDCBottomNavigationSystemDialogView

/**
 * Updates this view's image and title views with the corresponding properties of the given tab bar
 * item. If the tab bar item's @c largeContentSizeImage is not nil that image will be used otherwise
 * the item's image property may be scaled up.
 */
- (void)updateWithTabBarItem:(nonnull UITabBarItem *)item;

@end
