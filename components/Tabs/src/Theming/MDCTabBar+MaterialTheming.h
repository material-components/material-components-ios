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

#import "MaterialContainerScheme.h"
#import "MaterialTabs.h"

/**
 This category is used to style MDCTabBar instances to a specific Material style which can be found
 within the [Material Guidelines](https://material.io/design/components/tabs.html).
 */
@interface MDCTabBar (MaterialTheming)

/**
 Applies the Material Primary Theme to the receiver.

 @param scheme A container scheme used for theming.
 */
- (void)applyPrimaryThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme;

/**
 Applies the Material Surface Theme to the receiver.

 @param scheme A container scheme used for theming.
 */
- (void)applySurfaceThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme;

@end
