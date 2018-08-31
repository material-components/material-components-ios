/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

@class MDCPathGenerator;

/**
 MDCCornerTreatment is a factory for creating MDCPathGenerators that represent
 the path of a corner.

 MDCCornerTreatments should only generate corners in the top-left quadrant (i.e.
 the top-left corner of a rectangle). MDCShapeModel will translate the generated
 MDCPathGenerator to the expected position and rotation.
 */
@interface MDCCornerTreatment : NSObject <NSCopying, NSSecureCoding>

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 Generates an MDCPathGenerator object for a corner with the provided angle.

 @param angle The internal angle of the corner in radians. Typically M_PI/2.
 */
- (nonnull MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle;

@end
