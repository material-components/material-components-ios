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

#import "MDCStateExampleColorScheme.h"
#import "MaterialPalettes.h"

#pragma mark - MDCStateExampleColorScheme

@implementation MDCStateExampleColorScheme

- (instancetype)init {
  return [self initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
}

- (instancetype)initWithDefaults:(MDCColorSchemeDefaults)defaults {
  self = [super init];
  if (self) {
    switch (defaults) {
      case MDCColorSchemeDefaultsMaterial201804:

        self.MDCColorScheme =
            [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

        _primaryColor = self.MDCColorScheme.primaryColor;
        _primaryColorVariant = self.MDCColorScheme.primaryColorVariant;
        _secondaryColor = self.MDCColorScheme.secondaryColor;
        _errorColor = self.MDCColorScheme.errorColor;
        _surfaceColor = self.MDCColorScheme.surfaceColor;
        _backgroundColor = self.MDCColorScheme.backgroundColor;
        _onPrimaryColor = self.MDCColorScheme.onPrimaryColor;
        _onSecondaryColor = self.MDCColorScheme.onSecondaryColor;
        _onSurfaceColor = self.MDCColorScheme.onSurfaceColor;
        _onBackgroundColor = self.MDCColorScheme.onBackgroundColor;

        // Setting the Example's colors
        _overlayColor = MDCPalette.greyPalette.tint800;
        _outlineColor = MDCPalette.greyPalette.tint300;

        break;
    }
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  MDCStateExampleColorScheme *copy = [[MDCStateExampleColorScheme alloc] init];
  copy.primaryColor = self.primaryColor;
  copy.primaryColorVariant = self.primaryColorVariant;
  copy.secondaryColor = self.secondaryColor;
  copy.surfaceColor = self.surfaceColor;
  copy.backgroundColor = self.backgroundColor;
  copy.errorColor = self.errorColor;
  copy.onPrimaryColor = self.onPrimaryColor;
  copy.onSecondaryColor = self.onSecondaryColor;
  copy.onSurfaceColor = self.onSurfaceColor;
  copy.onBackgroundColor = self.onBackgroundColor;

  copy.overlayColor = self.overlayColor;
  copy.outlineColor = self.outlineColor;

  return copy;
}

@end
