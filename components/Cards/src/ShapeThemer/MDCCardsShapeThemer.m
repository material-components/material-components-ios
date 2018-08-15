/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCardsShapeThemer.h"
#import "MaterialShapes.h"
#import "MaterialShapeLibrary.h"

@implementation MDCCardsShapeThemer

+ (void)applySemanticShapeScheme:(nonnull id<MDCShapeScheming>)shapeScheme
                          toCard:(nonnull MDCCard *)card {
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  MDCCornerTreatment *cornerTreatment =
      [shapeScheme.mediumSurfaceShape.topLeftCorner cornerTreatmentValue];
  [rectangleShape setCorners:cornerTreatment];
  card.shapeGenerator = rectangleShape;
}

+ (void)applySemanticShapeScheme:(nonnull id<MDCShapeScheming>)shapeScheme
                      toCardCell:(nonnull MDCCardCollectionCell *)cardCell {
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  MDCCornerTreatment *cornerTreatment =
      [shapeScheme.mediumSurfaceShape.topLeftCorner cornerTreatmentValue];
  [rectangleShape setCorners:cornerTreatment];
  cardCell.shapeGenerator = rectangleShape;}

@end
