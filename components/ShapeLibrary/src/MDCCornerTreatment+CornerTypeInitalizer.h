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

#import "MaterialShapes.h"

#import "MDCCurvedCornerTreatment.h"
#import "MDCCutCornerTreatment.h"
#import "MDCRoundedCornerTreatment.h"

@interface MDCCornerTreatment (CornerTypeInitalizer)

/**
 Initialize and return an MDCCornerTreatment as an MDCRoundedCornerTreatment.

 @param value The radius to set the rounded corner to.
 @return an MDCRoundedCornerTreatment.
 */
+ (MDCRoundedCornerTreatment *)cornerWithRadius:(CGFloat)value;

/**
 Initialize and return an MDCCornerTreatment as an MDCRoundedCornerTreatment.

 @param value The radius to set the rounded corner to.
 @param valueType The value type in which the value is set as. It can be sent either as an
 absolute value, or a percentage value (0.0 - 1.0) of the height of the surface.
 @return an MDCRoundedCornerTreatment.
 */
+ (MDCRoundedCornerTreatment *)cornerWithRadius:(CGFloat)value
                                      valueType:(MDCCornerTreatmentValueType)valueType;

/**
 Initialize and return an MDCCornerTreatment as an MDCCutCornerTreatment.

 @param value The cut to set the cut corner to.
 @return an MDCCutCornerTreatment.
 */
+ (MDCCutCornerTreatment *)cornerWithCut:(CGFloat)value;

/**
 Initialize and return an MDCCornerTreatment as an MDCRoundedCornerTreatment.

 @param value The cut to set the cut corner to.
 @param valueType The value type in which the value is set as. It can be sent either as an
 absolute value, or a percentage value (0.0 - 1.0) of the height of the surface.
 @return an MDCCutCornerTreatment.
 */
+ (MDCCutCornerTreatment *)cornerWithCut:(CGFloat)value
                               valueType:(MDCCornerTreatmentValueType)valueType;

/**
 Initialize and return an MDCCornerTreatment as an MDCCurvedCornerTreatment.

 @param value The size to set the curved corner to.
 @return an MDCCurvedCornerTreatment.
 */
+ (MDCCurvedCornerTreatment *)cornerWithCurve:(CGSize)value;

/**
 Initialize and return an MDCCornerTreatment as an MDCCurvedCornerTreatment.

 @param value The curve to set the curved corner to.
 @param valueType The value type in which the value is set as. It can be sent either as an
 absolute value, or a percentage value (0.0 - 1.0) of the height of the surface.
 @return an MDCCurvedCornerTreatment.
 */
+ (MDCCurvedCornerTreatment *)cornerWithCurve:(CGSize)value
                                    valueType:(MDCCornerTreatmentValueType)valueType;

@end
