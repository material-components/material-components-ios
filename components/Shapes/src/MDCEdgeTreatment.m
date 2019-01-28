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

#import "MDCEdgeTreatment.h"

#import "MDCPathGenerator.h"

@implementation MDCEdgeTreatment

- (instancetype)init {
  return [super init];
}

- (MDCPathGenerator *)pathGeneratorForEdgeWithLength:(CGFloat)length {
  MDCPathGenerator *path = [MDCPathGenerator pathGeneratorWithStartPoint:CGPointZero];
  [path addLineToPoint:CGPointMake(length, 0)];
  return path;
}

- (id)copyWithZone:(nullable NSZone *)__unused zone {
  return [[[self class] alloc] init];
}

@end
