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

#import "MDCTabBar.h"

/**
 Provides methods for overriding the size class properties of an MDCTabBar.

 @note This protocol may be removed in a future version and should be used with that understanding.
 */
@protocol MDCTabBarSizeClassDelegate

@optional

/**
 Determines the horizontal size class for the UITraitEnvironment provided. This method can be useful
 if the view hierarchy's size class is inaccurate or if overriding through child view controllers
 is not practical.

 @param object The trait environment that can have its horizontal size class overridden.

 @return The overridden horizontal size class for the trait environment.

 @note This method may be removed in a future version and should be used with that understanding.
 */
- (UIUserInterfaceSizeClass)horizontalSizeClassForObject:(nonnull id<UITraitEnvironment>)object;

@end

@interface MDCTabBar (MDCTabBarSizeClassDelegate)

/**
 A delegate that allows implementers to override size class attributes for the tab bar.

 @note This property may be removed in a future version and should be used with that understanding.
 */
@property(nonatomic, weak, nullable) NSObject<MDCTabBarSizeClassDelegate> *sizeClassDelegate;

@end
