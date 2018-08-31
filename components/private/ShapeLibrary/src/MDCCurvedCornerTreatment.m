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

#import "MDCCurvedCornerTreatment.h"

static NSString *const MDCCurvedCornerTreatmentSizeKey = @"MDCCurvedCornerTreatmentSizeKey";

@implementation MDCCurvedCornerTreatment

- (instancetype)init {
  return [self initWithSize:CGSizeZero];
}

- (instancetype)initWithSize:(CGSize)size {
  if (self = [super init]) {
    _size = size;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    _size = [aDecoder decodeCGSizeForKey:MDCCurvedCornerTreatmentSizeKey];
  }
  return self;
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)__unused angle {
  MDCPathGenerator *path =
      [MDCPathGenerator pathGeneratorWithStartPoint:CGPointMake(0, self.size.height)];
  [path addQuadCurveWithControlPoint:CGPointZero toPoint:CGPointMake(self.size.width, 0)];
  return path;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeCGSize:_size forKey:MDCCurvedCornerTreatmentSizeKey];
}

- (id)copyWithZone:(nullable NSZone *)__unused zone {
  MDCCurvedCornerTreatment *copy = [[[self class] alloc] init];
  copy.size = self.size;
  return copy;
}

+ (BOOL)supportsSecureCoding {
  return YES;
}

@end
