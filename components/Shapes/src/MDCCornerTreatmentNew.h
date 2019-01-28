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

#import <UIKit/UIKit.h>

@class MDCPathGenerator;

/**
 This enum consists of the different types of shape values that can be provided.

 - MDCCornerTreatmentValueTypeAbsolute: If an absolute corner value is provided.
 - MDCCornerTreatmentValueTypePercentage: If a relative corner value is provided.

 See MDCShapeCorner's @c size property for additional details.
 */
typedef NS_ENUM(NSInteger, MDCCornerTreatmentValueType) {
  MDCCornerTreatmentValueTypeAbsolute,
  MDCCornerTreatmentValueTypePercentage,
};

/**
 MDCCornerTreatment is a factory for creating MDCPathGenerators that represent
 the path of a corner.

 MDCCornerTreatments should only generate corners in the top-left quadrant (i.e.
 the top-left corner of a rectangle). MDCShapeModel will translate the generated
 MDCPathGenerator to the expected position and rotation.
 */
@interface MDCCornerTreatment : NSObject <NSCopying>

/**
 The value type of our corner treatment.

 When MDCCornerTreatmentValueType is MDCCornerTreatmentValueTypeAbsolute, then the accepted corner
 values are an absolute size.
 When MDCShapeSizeType is MDCCornerTreatmentValueTypePercentage, values are expected to be in the
 range of 0 to 1 (0% - 100%). These values are percentages based on the height of the surface.
 */
@property(assign, nonatomic) MDCCornerTreatmentValueType valueType;

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 Creates an MDCPathGenerator object for a corner with the provided angle.

 @param angle The internal angle of the corner in radians. Typically M_PI/2.
 */
- (nonnull MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle;

/**
 Creates an MDCPathGenerator object for a corner with the provided angle.
 Given that the provided valueType is MDCCornerTreatmentValueTypePercentage, we also need
 the size of the view to calculate the corner size percentage relative to the view height.

 @param angle the internal angle of the corner in radius. Typically M_PI/2.
 @param size the size of the view.
 @return returns an MDCPathGenerator.
 */
- (nonnull MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle
                                                  forViewSize:(CGSize)size;

@end
