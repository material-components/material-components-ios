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

#import <CoreGraphics/CoreGraphics.h>

#import "MaterialShapes.h"

/**
 A curved corner treatment. Distinct from MDCRoundedCornerTreatment in that MDCurvedCornerTreatment
 also supports asymmetric curved corners.
 */
@interface MDCCurvedCornerTreatment : MDCCornerTreatment

/**
 The size of the curve.
 */
@property(nonatomic, assign) CGSize size;

/**
 Initializes an MDCCurvedCornerTreatment instance with a given corner size.
 */
- (nonnull instancetype)initWithSize:(CGSize)size NS_DESIGNATED_INITIALIZER;

/**
 Initializes an MDCCurvedCornerTreatment instance with a corner size of zero.
 */
- (nonnull instancetype)init;

@end
