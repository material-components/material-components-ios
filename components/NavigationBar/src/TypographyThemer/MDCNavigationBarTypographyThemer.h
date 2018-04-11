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

#import "MaterialNavigationBar.h"
#import "MaterialTypographyScheme.h"

/**
 Used to apply a typography scheme to theme MDCNavigationBar.
 */
@interface MDCNavigationBarTypographyThemer : NSObject

/**
 Applies a typography scheme to theme a MDCNavigationBar.

 @param typographyScheme The typography scheme to apply to MDCNavigationBar.
 @param navigationBar A MDCNavigationBar instance to apply a typography scheme.
 */
+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
              toNavigationBar:(nonnull MDCNavigationBar *)navigationBar;

@end
