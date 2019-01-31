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

#import "MDCChipViewScheme.h"

#import "MaterialChips.h"

#import <Foundation/Foundation.h>

/**
 The Material Design themer for instances of MDCChipView.
 */
@interface MDCChipViewThemer : NSObject

/**
 Applies a chip view scheme's properties to an MDCChipView.

 @param scheme The chip view scheme to apply to the component instance.
 @param chip A component instance to which the scheme should be applied.
 */
+ (void)applyScheme:(nonnull id<MDCChipViewScheming>)scheme toChipView:(nonnull MDCChipView *)chip;

/**
 Applies a chip view scheme's properties to an MDCChipView using the outlined style.

 @param scheme The chip view scheme to apply to the component instance.
 @param chip A component instance to which the scheme should be applied.
 */
+ (void)applyOutlinedVariantWithScheme:(nonnull id<MDCChipViewScheming>)scheme
                            toChipView:(nonnull MDCChipView *)chip;

@end
