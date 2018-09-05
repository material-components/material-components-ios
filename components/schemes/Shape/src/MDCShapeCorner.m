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

- (instancetype)init {
  _sizeType = MDCShapeCornerSizeTypeAbsolute;
  return [self initWithFamily:MDCShapeCornerFamilyRounded andSize:0];
}

- (instancetype)initWithFamily:(MDCShapeCornerFamily)cornerFamily andSize:(CGFloat)cornerSize {
  if (self = [super init]) {
    _sizeType = MDCShapeCornerSizeTypeAbsolute;
    _family = cornerFamily;
    _size = cornerSize;
  }
  return self;
}

- (instancetype)initWithFamily:(MDCShapeCornerFamily)cornerFamily
             andPercentageSize:(CGFloat)cornerSize {
  if (self = [super init]) {
    _sizeType = MDCShapeCornerSizeTypePercentage;
    _family = cornerFamily;
    _size = cornerSize;
  }
  return self;
}

- (MDCCornerTreatment *)cornerTreatmentValue {
  return [self cornerTreatmentSizeWithNormalizedShapeSize:_size];
}

- (MDCCornerTreatment *)cornerTreatmentValueWithViewBounds:(CGRect)bounds {
  MDCCornerTreatment *cornerTreatment;
  if (_sizeType == MDCShapeCornerSizeTypePercentage) {
    CGFloat normalizedShapeSize = bounds.size.height * _size;
    cornerTreatment = [self cornerTreatmentSizeWithNormalizedShapeSize:normalizedShapeSize];
  } else {
    cornerTreatment = [self cornerTreatmentValue];
  }
  return cornerTreatment;
}

- (MDCCornerTreatment *)cornerTreatmentSizeWithNormalizedShapeSize:(CGFloat)shapeSize {
  MDCCornerTreatment *cornerTreatment;
  NSNumber *size = @(shapeSize);
  switch (_family) {
    case MDCShapeCornerFamilyAngled:
      cornerTreatment = [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeCut
                                                               andSize:size];
      break;
    case MDCShapeCornerFamilyRounded:
      cornerTreatment = [[MDCCornerTreatment alloc] initWithCornerType:MDCCornerTypeRounded
                                                               andSize:size];
      break;
  }
  return cornerTreatment;
}
@end
