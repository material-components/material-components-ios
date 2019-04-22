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

#import "MaterialChips.h"
#import "MaterialTypographyScheme.h"

#import <Foundation/Foundation.h>

#pragma mark - Soon to be deprecated

/**
 Themes @c MDCChipView objects to set their text font to the appropriate font trait given a font
 scheme.

 @warning This API will eventually be deprecated. See the individual method documentation for
 details on replacement APIs.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@interface MDCChipViewFontThemer : NSObject
@end

@interface MDCChipViewFontThemer (ToBeDeprecated)

/**
 Applies the provided font scheme to the given Chip.

 @warning This API will eventually be deprecated. The replacement API is any of `MDCCard`'s theming
 extensions.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applyFontScheme:(nonnull id<MDCFontScheme>)fontScheme
             toChipView:(nonnull MDCChipView *)chipView;

@end
