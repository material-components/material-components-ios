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

#import <CoreGraphics/CoreGraphics.h>

#import "MaterialShapes.h"

/**
 A cut corner treatment subclassing MDCCornerTreatment.
 This can be used to set corners in MDCRectangleShapeGenerator.
 */
@interface MDCCutCornerTreatment : MDCCornerTreatment

/**
 The cut of the corner.

 The value of the cut defines by how many UI points starting from the edge of the corner and going
 equal distance on the X axis and the Y axis will the corner be cut.

 As an example if the shape is a square with a size of 100x100, and we have all its corners set
 with MDCCutCornerTreatment and a cut value of 50 then the final result will be a diamond with a
 size of 50x50.
 +--------------+                     /\
 |              |                   /    \ 50
 |              |                 /        \
 |              | 100   --->    /            \
 |              |               \            /
 |              |                 \        /
 |              |                   \    / 50
 +--------------+                     \/
 100

 */
@property(nonatomic, assign) CGFloat cut;

/**
 Initializes an MDCCutCornerTreatment instance with a given cut.
 */
- (nonnull instancetype)initWithCut:(CGFloat)cut NS_DESIGNATED_INITIALIZER;

/**
 Initializes an MDCCutCornerTreatment instance with a cut of zero.
 */
- (nonnull instancetype)init;

@end
