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

#import <Foundation/Foundation.h>

#import "MaterialButtons+ButtonThemer.h"
#import "MaterialColorScheme.h"
#import "MaterialShadowElevations.h"
#import "MaterialTypographyScheme.h"

/** Defines a readonly immutable interface for component style data to be applied by a themer. */
__deprecated_msg("Please use MDCContainerScheming") @protocol MDCAlertScheming

/** The color scheme to apply to Dialog. */
@property(nonnull, readonly, nonatomic) id<MDCColorScheming> colorScheme;

/** The typography scheme to apply to Dialog. */
@property(nonnull, readonly, nonatomic) id<MDCTypographyScheming> typographyScheme;

/** The button scheme to apply to Dialog's actions. */
@property(nonnull, readonly, nonatomic) id<MDCButtonScheming> buttonScheme;

/** The corner radius to apply to Dialog. */
@property(readonly, nonatomic) CGFloat cornerRadius;

/** The elevation to apply to the Dialog. */
@property(readonly, nonatomic) CGFloat elevation;

@end

/**  A simple implementation of @c MDCAlertScheming that provides default color,
 typography and shape schemes, from which customizations can be made. */
__deprecated_msg("Please use MDCContainerScheme") @interface MDCAlertScheme
    : NSObject<MDCAlertScheming>

/** The color scheme to apply to Dialog. */
@property(nonnull, readwrite, nonatomic) id<MDCColorScheming> colorScheme;

/** The typography scheme to apply to Dialog. */
@property(nonnull, readwrite, nonatomic) id<MDCTypographyScheming> typographyScheme;

/** The button scheme to apply to Dialog's actions. */
@property(nonnull, readwrite, nonatomic) id<MDCButtonScheming> buttonScheme;

/** The corner radius to apply to Dialog. */
@property(readwrite, nonatomic) CGFloat cornerRadius;

/** The elevation to apply to the Dialog. */
@property(readwrite, nonatomic) MDCShadowElevation elevation;

@end
