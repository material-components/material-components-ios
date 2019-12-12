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

#import "MDCCutCornerTreatment.h"

static NSString *const MDCCutCornerTreatmentCutKey = @"MDCCutCornerTreatmentCutKey";

@implementation MDCCutCornerTreatment

- (instancetype)init {
  return [self initWithCut:0];
}

- (instancetype)initWithCut:(CGFloat)cut {
  if (self = [super init]) {
    _cut = cut;
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  MDCCutCornerTreatment *copy = [super copyWithZone:zone];
  copy.cut = _cut;
  return copy;
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle {
  return [self pathGeneratorForCornerWithAngle:angle andCut:_cut];
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle forViewSize:(CGSize)viewSize {
  CGFloat normalizedCut = _cut * viewSize.height;
  return [self pathGeneratorForCornerWithAngle:angle andCut:normalizedCut];
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle andCut:(CGFloat)cut {
  MDCPathGenerator *path = [MDCPathGenerator pathGeneratorWithStartPoint:CGPointMake(0, cut)];
  [path addLineToPoint:CGPointMake(cut, 0)];
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
  MDCCutCornerTreatment *otherCutCorner = (MDCCutCornerTreatment *)object;
  return self.cut == otherCutCorner.cut;
}

- (NSUInteger)hash {
  return @(self.cut).hash ^ (NSUInteger)self.valueType;
}

@end
