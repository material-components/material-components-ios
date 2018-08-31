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

#import "MDCLegacyColorScheme.h"

@interface MDCBasicColorScheme ()

@property (nonatomic, strong, nonnull) UIColor *primaryColor;
@property (nonatomic, strong, nonnull) UIColor *primaryLightColor;
@property (nonatomic, strong, nonnull) UIColor *primaryDarkColor;
@property (nonatomic, strong, nonnull) UIColor *secondaryColor;
@property (nonatomic, strong, nonnull) UIColor *secondaryLightColor;
@property (nonatomic, strong, nonnull) UIColor *secondaryDarkColor;

@end

@implementation MDCBasicColorScheme

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

- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor {
  UIColor *primaryLightColor = [self lighterColorForColor:primaryColor];
  UIColor *primaryDarkColor = [self darkerColorForColor:primaryColor];
  return [self initWithPrimaryColor:primaryColor
                  primaryLightColor:primaryLightColor
                   primaryDarkColor:primaryDarkColor
                     secondaryColor:primaryColor
                secondaryLightColor:primaryLightColor
                 secondaryDarkColor:primaryDarkColor];
}

- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                           primaryLightColor:(nonnull UIColor *)primaryLightColor
                            primaryDarkColor:(nonnull UIColor *)primaryDarkColor {
  return [self initWithPrimaryColor:primaryColor
                  primaryLightColor:primaryLightColor
                   primaryDarkColor:primaryDarkColor
                     secondaryColor:primaryColor
                secondaryLightColor:primaryLightColor
                 secondaryDarkColor:primaryDarkColor];
}

- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                              secondaryColor:(nonnull UIColor *)secondaryColor {
  return [self initWithPrimaryColor:primaryColor
                  primaryLightColor:[self lighterColorForColor:primaryColor]
                   primaryDarkColor:[self darkerColorForColor:primaryColor]
                     secondaryColor:secondaryColor
                secondaryLightColor:[self lighterColorForColor:secondaryColor]
                 secondaryDarkColor:[self darkerColorForColor:secondaryColor]];
}

- (UIColor *)lighterColorForColor:(UIColor *)color {
  CGFloat hue, saturation, brightness, alpha;
  if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
    return [UIColor colorWithHue:hue
                      saturation:saturation
                      brightness:(CGFloat)fminf((float)brightness + 0.2f, 1.0f)
                           alpha:alpha];
  }
  return nil;
}

- (UIColor *)darkerColorForColor:(UIColor *)color {
  CGFloat hue, saturation, brightness, alpha;
  if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
    return [UIColor colorWithHue:hue
                      saturation:saturation
                      brightness:(CGFloat)fmaxf((float)brightness - 0.2f, 0.0f)
                           alpha:alpha];
  }
  return nil;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  MDCBasicColorScheme *copy = [[[self class] allocWithZone:zone] init];
  if (copy) {
    copy.primaryColor = [self primaryColor];
    copy.primaryLightColor = [self primaryLightColor];
    copy.primaryDarkColor = [self primaryDarkColor];
    copy.secondaryColor = [self secondaryColor];
    copy.secondaryLightColor = [self secondaryLightColor];
    copy.secondaryDarkColor = [self secondaryDarkColor];
  }
  return copy;
}

@end
