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

@interface MDCButton (MaterialThemingWithExplicit)

#pragma mark - Today

- (nonnull instancetype)applyContainedThemeWithColorScheme:(nonnull id<MDCColorScheming>)scheme;
- (nonnull instancetype)applyContainedThemeWithShapeScheme:(nonnull id<MDCShapeScheming>)scheme;
- (nonnull instancetype)applyContainedThemeWithTypographyScheme:
    (nonnull id<MDCTypographyScheming>)scheme;

- (nonnull instancetype)applyTextThemeWithColorScheme:(nonnull id<MDCColorScheming>)scheme;
- (nonnull instancetype)applyTextThemeWithShapeScheme:(nonnull id<MDCShapeScheming>)scheme;
- (nonnull instancetype)applyTextThemeWithTypographyScheme:
    (nonnull id<MDCTypographyScheming>)scheme;

#pragma mark - With a new subsystem

- (nonnull instancetype)applyContainedThemeWithMotionScheme:(nonnull id<MDCMotionScheming>)scheme;

- (nonnull instancetype)applyTextThemeWithMotionScheme:(nonnull id<MDCMotionScheming>)scheme;

#pragma mark - When a subsystem mapping is implemented

// We will not expose an API until the mapping is implemented, so implementing a themer is not a
// breaking change.

@end
