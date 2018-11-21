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

#import "MDCRoundedCornerTreatment.h"

#import "MaterialMath.h"

@implementation MDCRoundedCornerTreatment

- (instancetype)init {
  return [self initWithRadius:0];
}

- (instancetype)initWithRadius:(CGFloat)radius {
  if (self = [super init]) {
    _radius = radius;
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  MDCRoundedCornerTreatment *copy = [super copyWithZone:zone];
  copy.radius = _radius;
  return copy;
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle {
  return [self pathGeneratorForCornerWithAngle:angle andRadius:_radius];
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle forViewSize:(CGSize)viewSize {
  CGFloat normalizedRadius = _radius * viewSize.height;
  return [self pathGeneratorForCornerWithAngle:angle andRadius:normalizedRadius];
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle andRadius:(CGFloat)radius {
  MDCPathGenerator *path = [MDCPathGenerator pathGeneratorWithStartPoint:CGPointMake(0, radius)];
  [path addArcWithTangentPoint:CGPointZero
                       toPoint:CGPointMake(MDCSin(angle) * radius, MDCCos(angle) * radius)
                        radius:radius];
  return path;
}

- (BOOL)isEqual:(id)object {
  if (object == self) {
    return YES;
  } else if (![super isEqual:object]) {
    return NO;
  }
  if (!object || ![[object class] isEqual:[self class]]) {
    return NO;
  }
  MDCRoundedCornerTreatment *otherRoundedCorner = (MDCRoundedCornerTreatment *)object;
  return self.radius == otherRoundedCorner.radius;
}

@end
