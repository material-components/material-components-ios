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

#import "MaterialColorScheme.h"
#import "MaterialMotionScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

@protocol MDCContainerScheming

#pragma mark - Today

@property(nonatomic, strong, nonnull, readonly) id<MDCColorScheming> colorScheme;
@property(nonatomic, strong, nonnull, readonly) id<MDCTypographyScheming> typographyScheme;

@property(nonatomic, strong, nullable, readonly) id<MDCShapeScheming> shapeScheme;

#pragma mark - With a new subsystem

@property(nonatomic, strong, nullable) id<MDCMotionScheming> motionScheme;

@end

typedef NS_ENUM(NSInteger, MDCContainerSchemeDefaults) { MDCContainerSchemeDefaults201811 };

__attribute__((objc_subclassing_restricted)) @interface MDCContainerScheme
    : NSObject<MDCContainerScheming>

- (nonnull instancetype)initWithDefaults:(MDCContainerSchemeDefaults)defaults;
- (nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark - Today

@property(nonatomic, strong, nonnull) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong, nonnull) MDCTypographyScheme *typographyScheme;

@property(nonatomic, strong, nullable) MDCShapeScheme *shapeScheme;

#pragma mark - With a new subsystem

@property(nonatomic, strong, nullable) MDCMotionScheme *motionScheme;

@end
