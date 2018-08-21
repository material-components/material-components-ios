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

#import "MDCChipViewBaselineShapeThemer.h"

static const CGFloat kChipBaselineShapeValuePercentage = 0.5f;

@implementation MDCChipViewBaselineShapeThemer

+ (void)applyShapeBaselineToChipView:(MDCChipView *)chipView {
  CGFloat chipHeight = chipView.bounds.size.height;
  CGFloat cornerValue = chipHeight * kChipBaselineShapeValuePercentage;
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  MDCCornerTreatment *cornerTreatment =
      [[MDCRoundedCornerTreatment alloc] initWithRadius:cornerValue];
  [rectangleShape setCorners:cornerTreatment];
  chipView.shapeGenerator = rectangleShape;
}

@end
