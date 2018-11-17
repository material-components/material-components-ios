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

#import "MDCCardsShapeThemer.h"

@implementation MDCCardsShapeThemer

+ (void)applyShapeScheme:(id<MDCShapeScheming>)shapeScheme toCard:(MDCCard *)card {
  card.shapeGenerator = [self cardShapeGeneratorFromScheme:shapeScheme];
}

+ (void)applyShapeScheme:(id<MDCShapeScheming>)shapeScheme
              toCardCell:(MDCCardCollectionCell *)cardCell {
  cardCell.shapeGenerator = [self cardShapeGeneratorFromScheme:shapeScheme];
}

+ (id<MDCShapeGenerating>)cardShapeGeneratorFromScheme:(id<MDCShapeScheming>)shapeScheme {
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  rectangleShape.topLeftCorner = shapeScheme.mediumComponentShape.topLeftCorner;
  rectangleShape.topRightCorner = shapeScheme.mediumComponentShape.topRightCorner;
  rectangleShape.bottomLeftCorner = shapeScheme.mediumComponentShape.bottomLeftCorner;
  rectangleShape.bottomRightCorner = shapeScheme.mediumComponentShape.bottomRightCorner;
  return rectangleShape;
}

@end
