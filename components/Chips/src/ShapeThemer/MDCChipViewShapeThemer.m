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

#import "MDCChipViewShapeThemer.h"

static const CGFloat kChipViewBaselineShapePercentageValue = (CGFloat)0.5;

@implementation MDCChipViewShapeThemer

+ (void)applyShapeScheme:(nonnull id<MDCShapeScheming>)shapeScheme
              toChipView:(nonnull MDCChipView *)chipView {
  // This is an override of the default scheme to fit the baseline values.
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  MDCCornerTreatment *cornerTreatment =
      [MDCCornerTreatment cornerWithRadius:kChipViewBaselineShapePercentageValue
                                 valueType:MDCCornerTreatmentValueTypePercentage];
  [rectangleShape setCorners:cornerTreatment];
  chipView.shapeGenerator = rectangleShape;
}

@end
