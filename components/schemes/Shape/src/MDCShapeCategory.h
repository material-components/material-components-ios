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
#import "MaterialShapes.h"

/**
 This enum consists of the different types of shape corners.

 - MDCShapeCornerFamilyRounded: A rounded corner.
 - MDCShapeCornerFamilyCut: A cut corner.
 */
typedef NS_ENUM(NSInteger, MDCShapeCornerFamily) {
  MDCShapeCornerFamilyRounded,
  MDCShapeCornerFamilyCut,
};

/**
 The MDCShapeCategory is the class containing the shape value as part of our shape scheme,
 MDCShapeScheme.

 MDCShapeCategory is built from 4 corners, that can be set to alter the shape value.
 */
@interface MDCShapeCategory : NSObject <NSCopying>

/**
 This property represents the shape of the top left corner of the shape.
 */
@property(nonatomic, copy) MDCCornerTreatment *topLeftCorner;

/**
 This property represents the shape of the top right corner of the shape.
 */
@property(nonatomic, copy) MDCCornerTreatment *topRightCorner;

/**
 This property represents the shape of the bottom left corner of the shape.
 */
@property(nonatomic, copy) MDCCornerTreatment *bottomLeftCorner;

/**
 This property represents the shape of the bottom right corner of the shape.
 */
@property(nonatomic, copy) MDCCornerTreatment *bottomRightCorner;

/**
 The default init of the class. It sets all 4 corners with a corner family of
 MDCShapeCornerFamilyRounded and size of 0. This is equivalent to a "sharp" corner, or in terms of
 Apple's API it is the same as setting the cornerRadius to 0.

 @return returns an initialized MDCShapeCategory instance.
 */
- (instancetype)init;

/**
 This method is a convenience initializer of setting the shape value of all our corners at once
 to the provided cornerFamily and cornerSize.

 The outcome is a symmetrical shape that has the same values for all its corners.

 @param cornerFamily The family of our corner (rounded or angled).
 @param cornerSize The shape value of the corner.
 @return returns an MDCShapeCategory with the initialized values.
 */
- (instancetype)initCornersWithFamily:(MDCShapeCornerFamily)cornerFamily
                              andSize:(CGFloat)cornerSize;

@end
