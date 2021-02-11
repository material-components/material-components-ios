// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCDialogPresentationController+MaterialTheming.h"

#import "MaterialDialogs.h"

#import "MaterialShadowElevations.h"

#import "MaterialColorScheme.h"

#import "MaterialContainerScheme.h"

static const CGFloat kCornerRadius = 4;

@implementation MDCDialogPresentationController (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  // Color
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  self.scrimColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.32];

  // Corner Radius
  self.dialogCornerRadius = kCornerRadius;

  // Elevation
  self.dialogElevation = MDCShadowElevationDialog;
}

@end
