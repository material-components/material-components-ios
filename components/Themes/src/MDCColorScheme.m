/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCColorScheme.h"

@implementation MDCBasicColorScheme

- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor {
  self = [super init];
  if (self) {
    _primaryColor = primaryColor;

    // Primary light and dark colors are automatically generated if not specified.
    _primaryLightColor = [self lighterColorForColor:primaryColor];
    _primaryDarkColor = [self darkerColorForColor:primaryColor];

    // When secondary colors are not specificed, it is assumed they are the same as the primary
    // colors.
    _secondaryColor = primaryColor;
    _secondaryLightColor = _primaryLightColor;
    _secondaryDarkColor = _primaryDarkColor;
  }
  return self;
}

- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                           primaryLightColor:(nonnull UIColor *)primaryLightColor
                            primaryDarkColor:(nonnull UIColor *)primaryDarkColor {
  self = [super init];
  if (self) {
    _primaryColor = primaryColor;
    _primaryLightColor = primaryLightColor;
    _primaryDarkColor = primaryDarkColor;

    // When secondary colors are not specificed, it is assumed they are the same as the primary
    // colors.
    _secondaryColor = primaryColor;
    _secondaryLightColor = primaryLightColor;
    _secondaryDarkColor = primaryDarkColor;
  }
  return self;
}

- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                              secondaryColor:(nonnull UIColor *)secondaryColor {
  self = [super init];
  if (self) {
    _primaryColor = primaryColor;

    // Primary light and dark colors are automatically generated if not specified.
    _primaryLightColor = [self lighterColorForColor:primaryColor];
    _primaryDarkColor = [self darkerColorForColor:primaryColor];

    _secondaryColor = secondaryColor;

    // Secondary light and dark colors are automatically generated if not specified.
    _secondaryLightColor = [self lighterColorForColor:secondaryColor];
    _secondaryDarkColor = [self darkerColorForColor:secondaryColor];
    
  }
  return self;
}

- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                           primaryLightColor:(nonnull UIColor *)primaryLightColor
                            primaryDarkColor:(nonnull UIColor *)primaryDarkColor
                              secondaryColor:(nonnull UIColor *)secondaryColor
                         secondaryLightColor:(nonnull UIColor *)secondaryLightColor
                          secondaryDarkColor:(nonnull UIColor *)secondaryDarkColor {
  self = [super init];
  if (self) {
    _primaryColor = primaryColor;
    _primaryLightColor = primaryLightColor;
    _primaryDarkColor = primaryDarkColor;
    _secondaryColor = secondaryColor;
    _secondaryLightColor = secondaryLightColor;
    _secondaryDarkColor = secondaryDarkColor;
  }
  return self;
}

- (UIColor *)lighterColorForColor:(UIColor *)color {
  CGFloat r, g, b, a;
  if ([color getRed:&r green:&g blue:&b alpha:&a])
    return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                           green:MIN(g + 0.2, 1.0)
                            blue:MIN(b + 0.2, 1.0)
                           alpha:a];
  return nil;
}

- (UIColor *)darkerColorForColor:(UIColor *)color {
  CGFloat r, g, b, a;
  if ([color getRed:&r green:&g blue:&b alpha:&a])
    return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                           green:MAX(g - 0.2, 0.0)
                            blue:MAX(b - 0.2, 0.0)
                           alpha:a];
  return nil;
}

@end
