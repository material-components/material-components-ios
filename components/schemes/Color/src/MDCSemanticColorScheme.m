/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCSemanticColorScheme.h"

static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [UIColor colorWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                         green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                          blue:(CGFloat)((colorValue & 0xFF) / 255.0) alpha:1];
}

@implementation MDCSemanticColorScheme

- (instancetype)init {
  return [self initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
}

- (instancetype)initWithDefaults:(MDCColorSchemeDefaults)defaults {
  self = [super init];
  if (self) {
    switch (defaults) {
      case MDCColorSchemeDefaultsMaterial201804:
        _primaryColor = ColorFromRGB(0x6200EE);
        _primaryColorVariant = ColorFromRGB(0x3700B3);
        _secondaryColor = ColorFromRGB(0x03DAC6);
        _errorColor = ColorFromRGB(0xFF1744);
        _surfaceColor = ColorFromRGB(0xFFFFFF);
        _backgroundColor = ColorFromRGB(0xFFFFFF);
        _onPrimaryColor = ColorFromRGB(0xFFFFFF);
        _onSecondaryColor = ColorFromRGB(0x000000);
        _onSurfaceColor = ColorFromRGB(0x000000);
        _onBackgroundColor = ColorFromRGB(0x000000);
        break;
    }
  }
  return self;
}

@end

