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

#import "MaterialButtons.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapeScheme.h"

/**
 The Material Design shape system's themer for instances of MDCFloatingButton.
 */
@interface MDCFloatingButtonShapeThemer : NSObject

/**
 Applies a rounded rectangular shape to an MDCFloatingButton instance. Each corner has a radius of
 50% the FAB's height.

 @param shapeScheme This parameter is ignored.
 @param button A component instance to which the shape scheme should be applied.
 */
+ (void)applyShapeScheme:(nonnull id<MDCShapeScheming> __unused)shapeScheme
                toButton:(nonnull MDCFloatingButton *)button;

@end
