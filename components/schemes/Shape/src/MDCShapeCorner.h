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
#import "MaterialShapeLibrary.h"

/**
 This enum consists of the different types of shape corners.

 - MDCShapeCornerFamilyRounded: A rounded corner.
 - MDCShapeCornerFamilyAngled: An angled/cut corner.
 */
typedef NS_ENUM(NSInteger, MDCShapeCornerFamily) {
  MDCShapeCornerFamilyRounded,
  MDCShapeCornerFamilyAngled,
};

/**
 This enum consists of the different types of shape values that can be provided.

 - MDCShapeCornerSizeTypeAbsolute: If an absolute shape size is provided.
 - MDCShapeCornerSizeTypePercentage: If a relative shape size is provided.
 */
typedef NS_ENUM(NSInteger, MDCShapeCornerSizeType) {
  MDCShapeCornerSizeTypeAbsolute,
  MDCShapeCornerSizeTypePercentage,
};

/**
 An MDCShapeCorner is the shape value of a corner. It takes a family, a size type, and a size.
 */
@interface MDCShapeCorner : NSObject

/**
 The shape family of our corner.
 */
@property(assign, nonatomic) MDCShapeCornerFamily family;

/**
 The size type of our shape.
 */
@property(assign, nonatomic) MDCShapeCornerSizeType sizeType;

/**
 The size of our shape.

 When MDCShapeSizeType is MDCShapeCornerSizeTypeAbsolute, this accepts absolute values
 that are positive.

 When MDCShapeSizeType is MDCShapeCornerSizeTypePercentage, this accepts percentage values
 from 0 to 1 (0% - 100%). These values are percentages based on the height of the surface.
 */
@property(assign, nonatomic) CGFloat size;

/**
 This initializer takes in a shape family and size, and returns a shape corner.

 @param cornerFamily The shape family.
 @param cornerSize The shape size.
 @return an MDCShapeCorner.
 */
- (instancetype)initWithFamily:(MDCShapeCornerFamily)cornerFamily andSize:(CGFloat)cornerSize;

/**
 This method returns an MDCCornerTreament representation of the MDCShapeCorner.

 @return an MDCCornerTreatment.
 */
- (MDCCornerTreatment *)cornerTreatmentValue;

/**
 This method returns an MDCCornerTreatment representation of the MDCShapeCorner.
 It receives the bounds of the shape when a percentage or relative value is given.

 @param bounds The bounds of the shape.
 @return an MDCCornerTreatment.
 */
- (MDCCornerTreatment *)cornerTreatmentValueWithViewBounds:(CGRect)bounds;
@end
