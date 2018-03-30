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
#import <UIKit/UIKit.h>

static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [UIColor colorWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                         green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                          blue:(CGFloat)((colorValue & 0xFF) / 255.0) alpha:1];
}

static NSString *const kMDCSemanticColorSchemePrimaryColorKey =
    @"kMDCSemanticColorSchemePrimaryColorKey";
static NSString *const kMDCSemanticColorSchemePrimaryColorVariantKey =
    @"kMDCSemanticColorSchemePrimaryColorVariantKey";
static NSString *const kMDCSemanticColorSchemeSecondaryColorKey =
    @"kMDCSemanticColorSchemeSecondaryColorKey";
static NSString *const kMDCSemanticColorSchemeErrorColorKey =
    @"kMDCSemanticColorSchemeErrorColorKey";
static NSString *const kMDCSemanticColorSchemeSurfaceColorKey =
    @"kMDCSemanticColorSchemeSurfaceColorKey";
static NSString *const kMDCSemanticColorSchemeBackgroundColorKey =
    @"kMDCSemanticColorSchemeBackgroundColorKey";
static NSString *const kMDCSemanticColorSchemeOnPrimaryColorKey =
    @"kMDCSemanticColorSchemeOnPrimaryColorKey";
static NSString *const kMDCSemanticColorSchemeOnSecondaryColorKey =
    @"kMDCSemanticColorSchemeOnSecondaryColorKey";
static NSString *const kMDCSemanticColorSchemeOnSurfaceColorKey =
    @"kMDCSemanticColorSchemeOnSurfaceColorKey";
static NSString *const kMDCSemanticColorSchemeOnBackgroundColorKey =
    @"kMDCSemanticColorSchemeOnBackgroundColorKey";

@implementation MDCSemanticColorScheme

- (instancetype)init {
  return [self initWithMaterialDefaults];
}

- (instancetype)initWithMaterialDefaults {
  return [self initWithPrimaryColor:ColorFromRGB(0x6200EE)
                primaryColorVariant:ColorFromRGB(0x3700B3)
                      secondaryColor:ColorFromRGB(0x03DAC6)
                         errorColor:ColorFromRGB(0xFF1744)
                       surfaceColor:ColorFromRGB(0xFFFFFF)
                    backgroundColor:ColorFromRGB(0xFFFFFF)
                     onPrimaryColor:ColorFromRGB(0xFFFFFF)
                   onSecondaryColor:ColorFromRGB(0x000000)
                     onSurfaceColor:ColorFromRGB(0x000000)
                  onBackgroundColor:ColorFromRGB(0x000000)];
}

- (instancetype)initWithPrimaryColor:(UIColor *)primaryColor
                 primaryColorVariant:(UIColor *)primaryColorVariant
                      secondaryColor:(UIColor *)secondaryColor
                          errorColor:(UIColor *)errorColor
                        surfaceColor:(UIColor *)surfaceColor
                     backgroundColor:(UIColor *)backgroundColor
                      onPrimaryColor:(UIColor *)onPrimaryColor
                    onSecondaryColor:(UIColor *)onSecondaryColor
                      onSurfaceColor:(UIColor *)onSurfaceColor
                   onBackgroundColor:(UIColor *)onBackgroundColor {
  NSParameterAssert(primaryColor);
  NSParameterAssert(primaryColorVariant);
  NSParameterAssert(secondaryColor);
  NSParameterAssert(errorColor);
  NSParameterAssert(surfaceColor);
  NSParameterAssert(backgroundColor);
  NSParameterAssert(onPrimaryColor);
  NSParameterAssert(onSecondaryColor);
  NSParameterAssert(onSurfaceColor);
  NSParameterAssert(onBackgroundColor);

  self = [super init];
  if (self) {
    _primaryColor = primaryColor;
    _primaryColorVariant = primaryColorVariant;
    _secondaryColor = secondaryColor;
    _errorColor = errorColor;
    _surfaceColor = surfaceColor;
    _backgroundColor = backgroundColor;
    _onPrimaryColor = onPrimaryColor;
    _onSecondaryColor = onSecondaryColor;
    _onSurfaceColor = onSurfaceColor;
    _onBackgroundColor = onBackgroundColor;
  }
  return self;
}

@end

@implementation MDCSemanticColorScheme (NSSecureCoding)

+ (BOOL)supportsSecureCoding {
  return YES;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  UIColor *primaryColor;
  UIColor *primaryColorVariant;
  UIColor *secondaryColor;
  UIColor *errorColor;
  UIColor *surfaceColor;
  UIColor *backgroundColor;
  UIColor *onPrimaryColor;
  UIColor *onSecondaryColor;
  UIColor *onSurfaceColor;
  UIColor *onBackgroundColor;

  primaryColor = [aDecoder decodeObjectOfClass:UIColor.class
                                        forKey:kMDCSemanticColorSchemePrimaryColorKey];
  primaryColorVariant =
      [aDecoder decodeObjectOfClass:UIColor.class
                             forKey:kMDCSemanticColorSchemePrimaryColorVariantKey];
  secondaryColor = [aDecoder decodeObjectOfClass:UIColor.class
                                          forKey:kMDCSemanticColorSchemeSecondaryColorKey];
  errorColor = [aDecoder decodeObjectOfClass:UIColor.class
                                      forKey:kMDCSemanticColorSchemeErrorColorKey];
  surfaceColor = [aDecoder decodeObjectOfClass:UIColor.class
                                        forKey:kMDCSemanticColorSchemeSurfaceColorKey];
  backgroundColor = [aDecoder decodeObjectOfClass:UIColor.class
                                           forKey:kMDCSemanticColorSchemeBackgroundColorKey];
  onPrimaryColor = [aDecoder decodeObjectOfClass:UIColor.class
                                          forKey:kMDCSemanticColorSchemeOnPrimaryColorKey];
  onSecondaryColor = [aDecoder decodeObjectOfClass:UIColor.class
                                            forKey:kMDCSemanticColorSchemeOnSecondaryColorKey];
  onSurfaceColor = [aDecoder decodeObjectOfClass:UIColor.class
                                          forKey:kMDCSemanticColorSchemeOnSurfaceColorKey];
  onBackgroundColor = [aDecoder decodeObjectOfClass:UIColor.class
                                             forKey:kMDCSemanticColorSchemeOnBackgroundColorKey];

  return [self initWithPrimaryColor:primaryColor
           primaryColorVariant:primaryColorVariant
                     secondaryColor:secondaryColor
                         errorColor:errorColor
                       surfaceColor:surfaceColor
                    backgroundColor:backgroundColor
                     onPrimaryColor:onPrimaryColor
                   onSecondaryColor:onSecondaryColor
                     onSurfaceColor:onSurfaceColor
                    onBackgroundColor:onBackgroundColor];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.primaryColor forKey:kMDCSemanticColorSchemePrimaryColorKey];
  [aCoder encodeObject:self.primaryColorVariant
                forKey:kMDCSemanticColorSchemePrimaryColorVariantKey];
  [aCoder encodeObject:self.secondaryColor forKey:kMDCSemanticColorSchemeSecondaryColorKey];
  [aCoder encodeObject:self.errorColor forKey:kMDCSemanticColorSchemeErrorColorKey];
  [aCoder encodeObject:self.surfaceColor forKey:kMDCSemanticColorSchemeSurfaceColorKey];
  [aCoder encodeObject:self.backgroundColor forKey:kMDCSemanticColorSchemeBackgroundColorKey];
  [aCoder encodeObject:self.onPrimaryColor forKey:kMDCSemanticColorSchemeOnPrimaryColorKey];
  [aCoder encodeObject:self.onSecondaryColor forKey:kMDCSemanticColorSchemeOnSecondaryColorKey];
  [aCoder encodeObject:self.onSurfaceColor forKey:kMDCSemanticColorSchemeOnSurfaceColorKey];
  [aCoder encodeObject:self.onBackgroundColor forKey:kMDCSemanticColorSchemeOnBackgroundColorKey];
}

@end
