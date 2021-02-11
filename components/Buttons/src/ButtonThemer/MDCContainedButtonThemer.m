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

#import "MDCContainedButtonThemer.h"

#import "MDCButtonScheme.h"
#import "MaterialButtons+ColorThemer.h"
#import "MaterialButtons.h"
#import "MaterialButtons+ShapeThemer.h"
#import "MaterialButtons+TypographyThemer.h"

@implementation MDCContainedButtonThemer

+ (void)applyScheme:(nonnull id<MDCButtonScheming>)scheme toButton:(nonnull MDCButton *)button {
  [MDCContainedButtonColorThemer applySemanticColorScheme:scheme.colorScheme toButton:button];
  [MDCButtonShapeThemer applyShapeScheme:scheme.shapeScheme toButton:button];
  [MDCButtonTypographyThemer applyTypographyScheme:scheme.typographyScheme toButton:button];
  button.minimumSize = CGSizeMake(0, scheme.minimumHeight);
  button.layer.cornerRadius = scheme.cornerRadius;
  [button setElevation:(CGFloat)2 forState:UIControlStateNormal];
  [button setElevation:(CGFloat)8 forState:UIControlStateHighlighted];
  [button setElevation:(CGFloat)0 forState:UIControlStateDisabled];
}

@end
