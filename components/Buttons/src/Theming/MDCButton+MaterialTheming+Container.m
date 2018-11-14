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

#import "MDCButton+MaterialTheming+Container.h"
#import "private/MDCButton+MaterialTheming+Private.h"

@implementation MDCButton (MaterialThemingWithContainer)

- (void)applyContainedThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
#pragma mark - Today

  [self _applyContainedThemeWithColorScheme:containerScheme.colorScheme];
  [self _applyContainedThemeWithTypographyScheme:containerScheme.typographyScheme];

  if (containerScheme.shapeScheme) {
    [self _applyContainedThemeWithShapeScheme:containerScheme.shapeScheme];
  } else {
    // Reasonable defaults.
    self.layer.cornerRadius = 4;
  }

#pragma mark - With a new subsystem

  if (containerScheme.motionScheme) {
    [self _applyContainedThemeWithMotionScheme:containerScheme.motionScheme];
  }

  self.minimumSize = CGSizeMake(0, 36);
  [self setElevation:(CGFloat)2 forState:UIControlStateNormal];
  [self setElevation:(CGFloat)8 forState:UIControlStateHighlighted];
  [self setElevation:(CGFloat)0 forState:UIControlStateDisabled];
}

- (void)applyTextThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
#pragma mark - Today

  if (containerScheme.colorScheme) {
    [self _applyTextThemeWithColorScheme:containerScheme.colorScheme];
  }
  if (containerScheme.shapeScheme) {
    [self _applyTextThemeWithShapeScheme:containerScheme.shapeScheme];
  }
  if (containerScheme.typographyScheme) {
    [self _applyTextThemeWithTypographyScheme:containerScheme.typographyScheme];
  }

#pragma mark - With a new subsystem

  if (containerScheme.motionScheme) {
    [self _applyTextThemeWithMotionScheme:containerScheme.motionScheme];
  }
}

@end
