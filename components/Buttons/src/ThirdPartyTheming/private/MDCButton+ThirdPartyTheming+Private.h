// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"

#import "MaterialColorScheme.h"
#import "MaterialMotionScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

@interface MDCButton (ThirdPartyThemingPrivate)

// Only override what we need to
- (void)_thirdparty_applyContainedThemeWithColorScheme:(nonnull id<ThirdPartyColorScheming>)scheme;

// We need to provide methods for everything
- (void)_thirdparty_applyFancyThemeWithColorScheme:(nonnull id<ThirdPartyColorScheming>)scheme;
- (void)_thirdparty_applyFancyThemeWithShapeScheme:(nonnull id<MDCShapeScheming>)scheme;
- (void)_thirdparty_applyFancyThemeWithTypographyScheme:(nonnull id<MDCTypographyScheming>)scheme;

#pragma mark - With a new subsystem

- (void)_thirdparty_applyFancyThemeWithMotionScheme:(nonnull id<MDCMotionScheming>)scheme;

@end
