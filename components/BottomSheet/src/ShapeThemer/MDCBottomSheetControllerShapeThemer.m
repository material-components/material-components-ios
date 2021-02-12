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

#import "MDCBottomSheetControllerShapeThemer.h"

#import "MDCSheetState.h"

#import "MaterialBottomSheet.h"

#import "MaterialShapes.h"

#import "MaterialShapeScheme.h"

@implementation MDCBottomSheetControllerShapeThemer

+ (void)applyShapeScheme:(id<MDCShapeScheming>)shapeScheme
    toBottomSheetController:(MDCBottomSheetController *)bottomSheetController {
  // Shape Generator for the Extended state of the Bottom Sheet.
  MDCRectangleShapeGenerator *rectangleShapePreferred = [[MDCRectangleShapeGenerator alloc] init];
  // For a Bottom Sheet the corner values that can be set are the top corners.
  rectangleShapePreferred.topLeftCorner = shapeScheme.largeComponentShape.topLeftCorner;
  rectangleShapePreferred.topRightCorner = shapeScheme.largeComponentShape.topRightCorner;
  [bottomSheetController setShapeGenerator:rectangleShapePreferred forState:MDCSheetStatePreferred];
}

@end
