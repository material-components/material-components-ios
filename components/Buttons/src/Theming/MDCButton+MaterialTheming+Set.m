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

#import "MDCButton+MaterialTheming+Set.h"
#import "private/MDCButton+MaterialTheming+Private.h"

@implementation MDCButton (MaterialTheming)

- (void)applyContainedThemeWithSchemes:(nonnull NSSet<id<MDCScheming>> *)schemes {

  for (id<MDCScheming> scheme in schemes) {

#pragma mark - Today

    if ([scheme conformsToProtocol:@protocol(MDCColorScheming)]) {
      id<MDCColorScheming> colorScheme = (id<MDCColorScheming>)scheme;
      [self _applyContainedThemeWithColorScheme:colorScheme];

    } else if ([scheme conformsToProtocol:@protocol(MDCShapeScheming)]) {
      id<MDCShapeScheming> shapeScheme = (id<MDCShapeScheming>)scheme;
      [self _applyContainedThemeWithShapeScheme:shapeScheme];

    } else if ([scheme conformsToProtocol:@protocol(MDCTypographyScheming)]) {
      id<MDCTypographyScheming> typographyScheme = (id<MDCTypographyScheming>)scheme;
      [self _applyContainedThemeWithTypographyScheme:typographyScheme];
    }

#pragma mark - With a new subsystem
    
    else if ([scheme conformsToProtocol:@protocol(MDCMotionScheming)]) {
      id<MDCMotionScheming> motionScheme = (id<MDCMotionScheming>)scheme;
      [self _applyContainedThemeWithMotionScheme:motionScheme];
    }
  }
}

- (void)applyTextThemeWithSchemes:(nonnull NSSet<id<MDCScheming>> *)schemes {
  for (id<MDCScheming> scheme in schemes) {

#pragma mark - Today

    if ([scheme conformsToProtocol:@protocol(MDCColorScheming)]) {
      id<MDCColorScheming> colorScheme = (id<MDCColorScheming>)scheme;
      [self _applyContainedThemeWithColorScheme:colorScheme];

    } else if ([scheme conformsToProtocol:@protocol(MDCShapeScheming)]) {
      id<MDCShapeScheming> shapeScheme = (id<MDCShapeScheming>)scheme;
      [self _applyContainedThemeWithShapeScheme:shapeScheme];

    } else if ([scheme conformsToProtocol:@protocol(MDCTypographyScheming)]) {
      id<MDCTypographyScheming> typographyScheme = (id<MDCTypographyScheming>)scheme;
      [self _applyContainedThemeWithTypographyScheme:typographyScheme];
    }

#pragma mark - With a new subsystem

    else if ([scheme conformsToProtocol:@protocol(MDCMotionScheming)]) {
      id<MDCMotionScheming> motionScheme = (id<MDCMotionScheming>)scheme;
      [self _applyContainedThemeWithMotionScheme:motionScheme];
    }
  }
}

@end
