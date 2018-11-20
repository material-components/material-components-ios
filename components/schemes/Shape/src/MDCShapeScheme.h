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
#import <UIKit/UIKit.h>
#import "MDCShapeCategory.h"

/**
 A simple shape scheme that provides semantic meaning.
 Each MDCShapeCategory is mapped to a component.
 The mapping is based on the component's surface size.
 There are no optional properties and all shapes must be provided,
 supporting more reliable shape theming.
 */
@protocol MDCShapeScheming

/**
 The shape defining small sized components.
 */
@property(nonnull, readonly, nonatomic) MDCShapeCategory *smallComponentShape;

/**
 The shape defining medium sized components.
 */
@property(nonnull, readonly, nonatomic) MDCShapeCategory *mediumComponentShape;

/**
 The shape defining large sized components.
 */
@property(nonnull, readonly, nonatomic) MDCShapeCategory *largeComponentShape;

@end

/**
 An enum of default shape schemes that are supported.
 */
typedef NS_ENUM(NSInteger, MDCShapeSchemeDefaults) {
  /**
   The Material defaults, circa September 2018.
   */
  MDCShapeSchemeDefaultsMaterial201809
};

/**
 A simple implementation of @c MDCShapeScheming that provides Material default shape values from
 which basic customizations can be made.
 */
@interface MDCShapeScheme : NSObject <MDCShapeScheming>

// Redeclare protocol properties as readwrite
@property(nonnull, readwrite, nonatomic) MDCShapeCategory *smallComponentShape;
@property(nonnull, readwrite, nonatomic) MDCShapeCategory *mediumComponentShape;
@property(nonnull, readwrite, nonatomic) MDCShapeCategory *largeComponentShape;

/**
 Initializes the shape scheme with the latest material defaults.
 */
- (nonnull instancetype)init;

/**
 Initializes the shape scheme with the shapes associated with the given defaults.
 */
- (nonnull instancetype)initWithDefaults:(MDCShapeSchemeDefaults)defaults;

@end
