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
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

/**
 A class conforming to the MDCContainerScheming procotol provides scheme properties for all the
 theming systems (color, typography, shape, etc.) MDC supports.
 */
@protocol MDCContainerScheming

@property(nonatomic, nullable, readonly) id<MDCColorScheming> colorScheme;
@property(nonatomic, nullable, readonly) id<MDCTypographyScheming> typographyScheme;
@property(nonatomic, nullable, readonly) id<MDCShapeScheming> shapeScheme;

@end

/**
 MDCContainerScheme is a class conforming to MDCContainerScheming that contains
 schemes values for theming systems.

 Default schemes value is not provided.
 */
__attribute__((objc_subclassing_restricted))
@interface MDCContainerScheme : NSObject<MDCContainerScheming>

@property(nonatomic, nullable, readwrite) MDCSemanticColorScheme *colorScheme;   // default is nil
@property(nonatomic, nullable, readwrite) MDCTypographyScheme *typographyScheme; // default is nil
@property(nonatomic, nullable, readwrite) MDCShapeScheme *shapeScheme;           // default is nil

@end
