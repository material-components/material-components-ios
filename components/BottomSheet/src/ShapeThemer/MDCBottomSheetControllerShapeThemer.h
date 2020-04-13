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

#import <UIKit/UIKit.h>

#import "MaterialBottomSheet.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapeScheme.h"
#import "MaterialShapes.h"

/**
 The Material Design shape system's themer for instances of MDCBottomSheetController.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
__deprecated_msg("There is no replacement for this API yet.")
    @interface MDCBottomSheetControllerShapeThemer : NSObject

/**
 Applies a shape scheme's properties to an MDCBottomSheetController.

 @param shapeScheme The shape scheme to apply to the component instance.
 @param bottomSheetController A component instance to which the shape scheme should be applied.

 @warning This API will eventually be deprecated. There is no replacement yet.
 Track progress here: https://github.com/material-components/material-components-ios/issues/7172
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applyShapeScheme:(nonnull id<MDCShapeScheming>)shapeScheme
    toBottomSheetController:(nonnull MDCBottomSheetController *)bottomSheetController
    __deprecated_msg("There is no replacement for this API yet.");

@end
