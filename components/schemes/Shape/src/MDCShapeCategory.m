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
#import "MaterialShapeLibrary.h"

@implementation MDCShapeCategory

- (instancetype)init {
  return [self initCornersWithFamily:MDCShapeCornerFamilyRounded andSize:0];
}

- (instancetype)initCornersWithFamily:(MDCShapeCornerFamily)cornerFamily
                              andSize:(CGFloat)cornerSize {
  if (self = [super init]) {
    MDCCornerTreatment *cornerTreatment;
    switch (cornerFamily) {
      case MDCShapeCornerFamilyCut:
        cornerTreatment = [MDCCornerTreatment cornerWithCut:cornerSize];
        break;
      case MDCShapeCornerFamilyRounded:
        cornerTreatment = [MDCCornerTreatment cornerWithRadius:cornerSize];
        break;
    }
    _topLeftCorner = cornerTreatment;
    _topRightCorner = cornerTreatment;
    _bottomLeftCorner = cornerTreatment;
    _bottomRightCorner = cornerTreatment;
  }
  return self;
}

- (BOOL)isEqual:(id)object {
  if (object == self) {
    return YES;
  }

  if (!object || ![[object class] isEqual:[self class]]) {
    return NO;
  }

  MDCShapeCategory *other = (MDCShapeCategory *)object;
  return [_topLeftCorner isEqual:other.topLeftCorner] &&
         [_topRightCorner isEqual:other.topRightCorner] &&
         [_bottomLeftCorner isEqual:other.bottomLeftCorner] &&
         [_bottomRightCorner isEqual:other.bottomRightCorner];
}

- (id)copyWithZone:(NSZone *)zone {
  MDCShapeCategory *copy = [[MDCShapeCategory alloc] init];
  copy.topLeftCorner = self.topLeftCorner;
  copy.topRightCorner = self.topRightCorner;
  copy.bottomLeftCorner = self.bottomLeftCorner;
  copy.bottomRightCorner = self.bottomRightCorner;
  return copy;
}

- (NSUInteger)hash {
  return (self.topRightCorner.hash ^ self.topLeftCorner.hash ^ self.bottomRightCorner.hash ^
          self.bottomLeftCorner.hash);
}

@end
