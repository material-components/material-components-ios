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
#import "MDCShapeCorner.h"

/**
 The MDCShapeCategory is the class containing the shape value as part of our shape scheme,
 MDCShapeScheme.

 MDCShapeCategory is built from 4 corners, that can be set to alter the shape value.

 This takes on the assumption that our settable shapes are made of 4 corners.
 */
@interface MDCShapeCategory : NSObject

/**
 This property represents the shape of the top left corner of the shape.
 */
@property(strong, nonatomic) MDCShapeCorner *topLeftCorner;

/**
 This property represents the shape of the top right corner of the shape.
 */
@property(strong, nonatomic) MDCShapeCorner *topRightCorner;

/**
 This property represents the shape of the bottom left corner of the shape.
 */
@property(strong, nonatomic) MDCShapeCorner *bottomLeftCorner;

/**
 This property represents the shape of the bottom right corner of the shape.
 */
@property(strong, nonatomic) MDCShapeCorner *bottomRightCorner;


/**
 This method is a convenience method of setting the shape value of all our corners at once to the
 provided cornerFamily and cornerSize.

 The outcome is a symmetrical shape that has the same values for all its corners.

 @param cornerFamily The family of our corner (rounded or angled).
 @param cornerSize The shape value of the corner.
 @return returns an MDCShapeCategory with the initialized values.
 */
- (instancetype)initCornersWithFamily:(MDCShapeCornerFamily)cornerFamily
                              andSize:(CGFloat)cornerSize;

@end
