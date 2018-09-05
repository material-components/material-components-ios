// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialAppBar.h"
#import "MaterialTypographyScheme.h"

/**
 The Material Design typography system's themer for instances of MDCAppBar.
 */
@interface MDCAppBarTypographyThemer : NSObject

/**
 Applies a typography scheme's properties to an MDCAppBar.

 @param typographyScheme The typography scheme to apply to the component instance.
 @param appBarViewController A component instance to which the typography scheme should be applied.
 */
+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
       toAppBarViewController:(nonnull MDCAppBarViewController *)appBarViewController;

#pragma mark - To be deprecated

/**
 Applies a typography scheme's properties to an MDCAppBar.

 @param typographyScheme The typography scheme to apply to the component instance.
 @param appBar A component instance to which the typography scheme should be applied.
 */
+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
                     toAppBar:(nonnull MDCAppBar *)appBar;

@end
