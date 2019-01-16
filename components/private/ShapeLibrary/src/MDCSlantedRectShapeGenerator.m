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

#import "MDCSlantedRectShapeGenerator.h"

@implementation MDCSlantedRectShapeGenerator {
  MDCRectangleShapeGenerator *_rectangleGenerator;
}

- (instancetype)init {
  if (self = [super init]) {
    [self commonMDCSlantedRectShapeGeneratorInit];
  }
  return self;
}

- (void)commonMDCSlantedRectShapeGeneratorInit {
  _rectangleGenerator = [[MDCRectangleShapeGenerator alloc] init];
}

- (id)copyWithZone:(NSZone *)__unused zone {
  MDCSlantedRectShapeGenerator *copy = [[[self class] alloc] init];
  copy.slant = self.slant;
  return copy;
}

- (void)setSlant:(CGFloat)slant {
  _slant = slant;

  _rectangleGenerator.topLeftCornerOffset = CGPointMake(slant, 0);
  _rectangleGenerator.topRightCornerOffset = CGPointMake(slant, 0);
  _rectangleGenerator.bottomLeftCornerOffset = CGPointMake(-slant, 0);
  _rectangleGenerator.bottomRightCornerOffset = CGPointMake(-slant, 0);
}

- (CGPathRef)pathForSize:(CGSize)size {
  return [_rectangleGenerator pathForSize:size];
}

@end
