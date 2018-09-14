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

#import "MDCFloatingActionButtonThemer.h"

#import "MaterialButtons+ColorThemer.h"
#import "MaterialButtons+ShapeThemer.h"
#import "MaterialButtons+TypographyThemer.h"

@implementation MDCFloatingActionButtonThemer

+ (void)applyScheme:(nonnull id<MDCButtonScheming>)scheme
           toButton:(nonnull MDCFloatingButton *)button {
  [MDCFloatingButtonColorThemer applySemanticColorScheme:scheme.colorScheme toButton:button];
  [MDCFloatingButtonShapeThemer applyShapeScheme:scheme.shapeScheme toButton:button];
  [MDCButtonTypographyThemer applyTypographyScheme:scheme.typographyScheme toButton:button];
  [button setElevation:(CGFloat)6 forState:UIControlStateNormal];
  [button setElevation:(CGFloat)12 forState:UIControlStateHighlighted];
  [button setElevation:(CGFloat)0 forState:UIControlStateDisabled];
}

@end
