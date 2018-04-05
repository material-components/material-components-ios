/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    _cut = (CGFloat)[aDecoder decodeDoubleForKey:MDCCutCornerTreatmentCutKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeDouble:_cut forKey:MDCCutCornerTreatmentCutKey];
}

- (id)copyWithZone:(NSZone *)__unused zone {
  return [[[self class] alloc] initWithCut:_cut];
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)angle {
  MDCPathGenerator *path = [MDCPathGenerator pathGeneratorWithStartPoint:CGPointMake(0, _cut)];
  [path addLineToPoint:CGPointMake(_cut, 0)];
  return path;
}

@end

