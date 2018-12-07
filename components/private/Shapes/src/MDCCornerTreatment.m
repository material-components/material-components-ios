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

#import "MDCCornerTreatment.h"

#import "MDCPathGenerator.h"

@implementation MDCCornerTreatment

- (instancetype)init {
  _valueType = MDCCornerTreatmentValueTypeAbsolute;
  return [super init];
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)__unused angle {
  return [MDCPathGenerator pathGeneratorWithStartPoint:CGPointZero];
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)__unused angle
                                          forViewSize:(CGSize)__unused viewSize {
  return [MDCPathGenerator pathGeneratorWithStartPoint:CGPointZero];
}

- (id)copyWithZone:(nullable NSZone *)__unused zone {
  MDCCornerTreatment *copy = [[[self class] alloc] init];
  copy.valueType = _valueType;
  return copy;
}

- (BOOL)isEqual:(id)object {
  if (object == self) {
    return YES;
  }
  if (!object || ![[object class] isEqual:[self class]]) {
    return NO;
  }
  MDCCornerTreatment *otherCorner = (MDCCornerTreatment *)object;
  return self.valueType == otherCorner.valueType;
}

@end
