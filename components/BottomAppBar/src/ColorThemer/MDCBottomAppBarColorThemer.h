/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialBottomAppBar.h"
#import "MaterialColorScheme.h"

#import <Foundation/Foundation.h>

/**
 A color themer for MDCBottomAppBarView. This API does not yet implement the Material Design color
 system.

 @seealso https://www.pivotaltracker.com/story/show/157095394
 */
@interface MDCBottomAppBarColorThemer : NSObject

#pragma mark - Soon to be deprecated

/**
 Applies a color scheme to theme a MDCBottomAppBarView.

 @warning This method will soon be deprecated. There is no replacement yet.
 @seealso https://www.pivotaltracker.com/story/show/157095394

 @param colorScheme The color scheme to apply to the component instance.
 @param bottomAppBarView A component instance to which the color scheme should be applied.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
      toBottomAppBarView:(nonnull MDCBottomAppBarView *)bottomAppBarView;

@end
