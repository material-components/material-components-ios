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

#import "MDCButton+MaterialTheming+Dictionary.h"
#import "private/MDCButton+MaterialTheming+Private.h"

const MDCSchemeName _Nonnull MDCSchemeNameColor = @"color";
const MDCSchemeName _Nonnull MDCSchemeNameShape = @"shape";
const MDCSchemeName _Nonnull MDCSchemeNameTypography = @"typography";
const MDCSchemeName _Nonnull MDCSchemeNameMotion = @"motion";

@implementation MDCButton (MaterialTheming)

- (void)applyContainedThemeWithSchemeMap:(nonnull NSDictionary<MDCSchemeName, id<MDCScheming>> *)schemes {

#pragma mark - Today

  id<MDCColorScheming> colorScheme = (id<MDCColorScheming>)schemes[MDCSchemeNameColor];
  if ([colorScheme conformsToProtocol:@protocol(MDCColorScheming)]) {
    [self _applyContainedThemeWithColorScheme:colorScheme];
  }
  id<MDCShapeScheming> shapeScheme = (id<MDCShapeScheming>)schemes[MDCSchemeNameShape];
  if ([shapeScheme conformsToProtocol:@protocol(MDCShapeScheming)]) {
    [self _applyContainedThemeWithShapeScheme:shapeScheme];
  }
  id<MDCTypographyScheming> typographyScheme = (id<MDCTypographyScheming>)schemes[MDCSchemeNameTypography];
  if ([typographyScheme conformsToProtocol:@protocol(MDCTypographyScheming)]) {
    [self _applyContainedThemeWithTypographyScheme:typographyScheme];
  }

#pragma mark - With a new subsystem

  id<MDCMotionScheming> motionScheme = (id<MDCMotionScheming>)schemes[MDCSchemeNameMotion];
  if ([motionScheme conformsToProtocol:@protocol(MDCMotionScheming)]) {
    [self _applyContainedThemeWithMotionScheme:motionScheme];
  }

}

- (void)applyTextThemeWithSchemeMap:(nonnull NSDictionary<MDCSchemeName, id<MDCScheming>> *)schemes {

#pragma mark - Today

  id<MDCColorScheming> colorScheme = (id<MDCColorScheming>)schemes[MDCSchemeNameColor];
  if ([colorScheme conformsToProtocol:@protocol(MDCColorScheming)]) {
    [self _applyContainedThemeWithColorScheme:colorScheme];
  }
  id<MDCShapeScheming> shapeScheme = (id<MDCShapeScheming>)schemes[MDCSchemeNameShape];
  if ([shapeScheme conformsToProtocol:@protocol(MDCShapeScheming)]) {
    [self _applyContainedThemeWithShapeScheme:shapeScheme];
  }
  id<MDCTypographyScheming> typographyScheme = (id<MDCTypographyScheming>)schemes[MDCSchemeNameTypography];
  if ([typographyScheme conformsToProtocol:@protocol(MDCTypographyScheming)]) {
    [self _applyContainedThemeWithTypographyScheme:typographyScheme];
  }

#pragma mark - With a new subsystem

  id<MDCMotionScheming> motionScheme = (id<MDCMotionScheming>)schemes[MDCSchemeNameMotion];
  if ([motionScheme conformsToProtocol:@protocol(MDCMotionScheming)]) {
    [self _applyContainedThemeWithMotionScheme:motionScheme];
  }

}

@end
