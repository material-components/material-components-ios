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

#import "MDCShapeCorner.h"

@implementation MDCShapeCorner

- (instancetype)init
{
  _isPercentage = NO;
  return [self initWithShapeFamily:MDCShapeFamilyRoundedCorner andValue:0];
}

- (instancetype)initWithShapeFamily:(MDCShapeFamily)shapeFamily andValue:(CGFloat)shapeValue
{
  if (self = [super init]) {
    _isPercentage = NO;
    _shapeFamily = shapeFamily;
    _shapeValue = shapeValue;
  }
  return self;
}

- (instancetype)initWithShapeFamily:(MDCShapeFamily)shapeFamily
                 andPercentageValue:(NSUInteger)shapeValue
{
  if (self = [super init]) {
    _isPercentage = YES;
    _shapeFamily = shapeFamily;
    _shapeValue = shapeValue;
  }
  return self;
}

- (MDCCornerTreatment *)cornerTreatmentValue {
  return [self cornerTreatmentValueWithNormalizedShapeValue:_shapeValue];
}

- (MDCCornerTreatment *)cornerTreatmentValueWithViewBounds:(CGRect)bounds {
  MDCCornerTreatment *cornerTreatment;
  if (_isPercentage && _shapeValue <= 1) {
    CGFloat normalizedShapeValue = bounds.size.height * _shapeValue;
    cornerTreatment = [self cornerTreatmentValueWithNormalizedShapeValue:normalizedShapeValue];
  } else {
    cornerTreatment = [self cornerTreatmentValue];
  }
  return cornerTreatment;
}

- (MDCCornerTreatment *)cornerTreatmentValueWithNormalizedShapeValue:(CGFloat)shapeValue {
  MDCCornerTreatment *cornerTreatment;
  NSNumber *value = @(shapeValue);
  switch (_shapeFamily) {
    case MDCShapeFamilyAngledCorner:
      cornerTreatment =
          [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeCut
                                                andValue:value];
      break;
    case MDCShapeFamilyRoundedCorner:
      cornerTreatment =
          [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeRounded
                                                andValue:value];
      break;
  }
  return cornerTreatment;
}
@end
