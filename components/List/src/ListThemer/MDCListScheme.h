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

#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"

#import <Foundation/Foundation.h>

/**
 Objects conforming to MDCListScheming provide themers for each subsystem relevant to List Items.
 */
@protocol MDCListScheming

/**
 The color scheme to be applied to a list cell.
 */
@property(nonnull, readonly, nonatomic) id<MDCColorScheming> colorScheme;

/**
 The typography scheme to be applied to a list cell.
 */
@property(nonnull, readonly, nonatomic) id<MDCTypographyScheming> typographyScheme;

@end

/**
 MDCListScheme is a concrete implementation of MDCListScheming.
 */
@interface MDCListScheme : NSObject <MDCListScheming>

/**
 A mutable representation of a color scheme.
 By default, this is initialized with the latest color scheme defaults.
 */
@property(nonnull, readwrite, nonatomic) id<MDCColorScheming> colorScheme;

/**
 A mutable representation of a typography scheme.
 By default, this is initialized with the latest typography scheme defaults.
 */
@property(nonnull, readwrite, nonatomic) id<MDCTypographyScheming> typographyScheme;

@end
