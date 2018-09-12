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

#import "MDCCornerTreatment+CornerTypeInitalizer.h"

@implementation MDCCornerTreatment (CornerTypeInitalizer)

+ (MDCRoundedCornerTreatment *)cornerWithRadius:(CGFloat)value {
  return [[MDCRoundedCornerTreatment alloc] initWithRadius:value];
}

+ (MDCRoundedCornerTreatment *)cornerWithRadius:(CGFloat)value
                                      valueType:(MDCCornerTreatmentValueType)valueType {
  MDCRoundedCornerTreatment *roundedCornerTreatment =
      [MDCRoundedCornerTreatment cornerWithRadius:value];
  roundedCornerTreatment.valueType = valueType;
  return roundedCornerTreatment;
}

+ (MDCCutCornerTreatment *)cornerWithCut:(CGFloat)value {
  return [[MDCCutCornerTreatment alloc] initWithCut:value];
}

+ (MDCCutCornerTreatment *)cornerWithCut:(CGFloat)value
                               valueType:(MDCCornerTreatmentValueType)valueType {
  MDCCutCornerTreatment *cutCornerTreatment = [MDCCutCornerTreatment cornerWithCut:value];
  cutCornerTreatment.valueType = valueType;
  return cutCornerTreatment;
}

+ (MDCCurvedCornerTreatment *)cornerWithCurve:(CGSize)value {
  return [[MDCCurvedCornerTreatment alloc] initWithSize:value];
}

+ (MDCCurvedCornerTreatment *)cornerWithCurve:(CGSize)value
                                    valueType:(MDCCornerTreatmentValueType)valueType {
  MDCCurvedCornerTreatment *curvedCornerTreatment =
      [MDCCurvedCornerTreatment cornerWithCurve:value];
  curvedCornerTreatment.valueType = valueType;
  return curvedCornerTreatment;
}

@end
