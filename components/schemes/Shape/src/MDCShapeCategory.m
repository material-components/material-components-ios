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

#import "MDCShapeCategory.h"

@implementation MDCShapeCategory

- (instancetype)init
{
  return [self initCornersWithShapeFamily:MDCShapeFamilyRoundedCorner andValue:0];
}

- (instancetype)initCornersWithShapeFamily:(MDCShapeFamily)shapeFamily
                                  andValue:(NSUInteger)shapeValue {
  if (self = [super init]) {
    _topLeftCorner = [[MDCShapeCorner alloc] initWithShapeFamily:shapeFamily andSize:shapeValue];
    _topRightCorner = [[MDCShapeCorner alloc] initWithShapeFamily:shapeFamily andSize:shapeValue];
    _bottomLeftCorner = [[MDCShapeCorner alloc] initWithShapeFamily:shapeFamily andSize:shapeValue];
    _bottomRightCorner = [[MDCShapeCorner alloc] initWithShapeFamily:shapeFamily andSize:shapeValue];
  }
  return self;
}

@end
