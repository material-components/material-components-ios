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

#import "MDCBottomNavigationBar.h"

#ifdef __IPHONE_13_4
@interface MDCBottomNavigationBar (PointerInteraction) <UIPointerInteractionDelegate>
@end
#endif

@interface MDCBottomNavigationBar ()

/**
 * Returns the tab bar item whose corresponding view contains the given point.
 * @param point CGPoint The point at which to get the corresponding tab bar item. The point must be
 * in the coordinate space of the receiver's bounds.
 */
- (nullable UITabBarItem *)tabBarItemForPoint:(CGPoint)point;

@end
