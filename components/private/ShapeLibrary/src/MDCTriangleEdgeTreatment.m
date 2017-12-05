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

#import "MDCTriangleEdgeTreatment.h"

static NSString *const MDCTriangleEdgeTreatmentSizeKey = @"MDCTriangleEdgeTreatmentSizeKey";
static NSString *const MDCTriangleEdgeTreatmentStyleKey = @"MDCTriangleEdgeTreatmentStyleKey";

@implementation MDCTriangleEdgeTreatment

- (instancetype)initWithSize:(CGFloat)size style:(MDCTriangleEdgeStyle)style {
  if (self = [super init]) {
    _size = size;
    _style = style;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    _size = (CGFloat)[aDecoder decodeDoubleForKey:MDCTriangleEdgeTreatmentSizeKey];
    _style = [aDecoder decodeIntegerForKey:MDCTriangleEdgeTreatmentStyleKey];
  }
  return self;
}

- (MDCPathGenerator *)pathGeneratorForEdgeWithLength:(CGFloat)length {
  BOOL isCut = (self.style == MDCTriangleEdgeStyleCut);
  MDCPathGenerator *path = [MDCPathGenerator pathGeneratorWithStartPoint:CGPointZero];
  [path addLineToPoint:CGPointMake(length/2 - _size, 0)];
  [path addLineToPoint:CGPointMake(length/2, isCut ? _size : -_size)];
  [path addLineToPoint:CGPointMake(length/2 + _size, 0)];
  [path addLineToPoint:CGPointMake(length, 0)];
  return path;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeDouble:_size forKey:MDCTriangleEdgeTreatmentSizeKey];
  [aCoder encodeInteger:_style forKey:MDCTriangleEdgeTreatmentStyleKey];
}

- (id)copyWithZone:(NSZone *)__unused zone {
  return [[[self class] alloc] initWithSize:_size style:_style];
}

@end
