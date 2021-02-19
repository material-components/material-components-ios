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

#import "MDCCurvedRectShapeGenerator.h"

#import "MDCCurvedCornerTreatment.h"
#import "MaterialShapes.h"

@implementation MDCCurvedRectShapeGenerator {
  MDCRectangleShapeGenerator *_rectGenerator;
  MDCCurvedCornerTreatment *_widthHeightCorner;
  MDCCurvedCornerTreatment *_heightWidthCorner;
}

- (instancetype)init {
  return [self initWithCornerSize:CGSizeMake(0, 0)];
}

- (instancetype)initWithCornerSize:(CGSize)cornerSize {
  if (self = [super init]) {
    [self commonInit];

    self.cornerSize = cornerSize;
  }
  return self;
}

- (void)commonInit {
  _rectGenerator = [[MDCRectangleShapeGenerator alloc] init];

  _widthHeightCorner = [[MDCCurvedCornerTreatment alloc] init];
  _heightWidthCorner = [[MDCCurvedCornerTreatment alloc] init];

  _rectGenerator.topLeftCorner = _widthHeightCorner;
  _rectGenerator.topRightCorner = _heightWidthCorner;
  _rectGenerator.bottomRightCorner = _widthHeightCorner;
  _rectGenerator.bottomLeftCorner = _heightWidthCorner;
}

- (void)setCornerSize:(CGSize)cornerSize {
  _cornerSize = cornerSize;

  _widthHeightCorner.size = _cornerSize;
  _heightWidthCorner.size = CGSizeMake(cornerSize.height, cornerSize.width);
}

- (id)copyWithZone:(nullable NSZone *)__unused zone {
  MDCCurvedRectShapeGenerator *copy = [[[self class] alloc] init];
  copy.cornerSize = self.cornerSize;
  return copy;
}

- (CGPathRef)pathForSize:(CGSize)size {
  return [_rectGenerator pathForSize:size];
}

@end
