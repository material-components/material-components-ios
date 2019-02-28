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

#import <CoreGraphics/CoreGraphics.h>

#import "MDCPillShapeGenerator.h"

#import "MDCRoundedCornerTreatment.h"
#import "MaterialMath.h"

@implementation MDCPillShapeGenerator {
  MDCRectangleShapeGenerator *_rectangleGenerator;
  MDCRoundedCornerTreatment *_cornerShape;
}

- (instancetype)init {
  if (self = [super init]) {
    [self commonInit];
  }
  return self;
}

- (id)copyWithZone:(NSZone *)__unused zone {
  return [[[self class] alloc] init];
}

- (void)commonInit {
  _cornerShape = [[MDCRoundedCornerTreatment alloc] init];
  _rectangleGenerator = [[MDCRectangleShapeGenerator alloc] init];
  [_rectangleGenerator setCorners:_cornerShape];
}

- (CGPathRef)pathForSize:(CGSize)size {
  CGFloat radius = (CGFloat)0.5 * MIN(MDCFabs(size.width), MDCFabs(size.height));
  if (radius > 0) {
    [_rectangleGenerator setCorners:[[MDCRoundedCornerTreatment alloc] initWithRadius:radius]];
  }
  return [_rectangleGenerator pathForSize:size];
}

@end
