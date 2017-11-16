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

#import "MDCRoundedCornerTreatment.h"

#import "MaterialMath.h"

static NSString *const MDCRoundedCornerTreatmentRadiusKey = @"MDCRoundedCornerTreatmentRadiusKey";

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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    _radius = (CGFloat)[aDecoder decodeDoubleForKey:MDCRoundedCornerTreatmentRadiusKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeDouble:_radius forKey:MDCRoundedCornerTreatmentRadiusKey];
}

- (id)copyWithZone:(NSZone *)__unused zone {
  return [[[self class] alloc] initWithRadius:_radius];
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle {
  MDCPathGenerator *path = [MDCPathGenerator pathGeneratorWithStartPoint:CGPointMake(0, _radius)];
  [path addArcWithTangentPoint:CGPointZero
                       toPoint:CGPointMake(MDCSin(angle) * _radius, MDCCos(angle) * _radius)
                        radius:_radius];
  return path;
}

@end
