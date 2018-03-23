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

static NSString *const kMDCSemanticColorSchemePrimaryColorKey =
    @"kMDCSemanticColorSchemePrimaryColorKey";
static NSString *const kMDCSemanticColorSchemePrimaryColorLightVariantKey =
    @"kMDCSemanticColorSchemePrimaryColorLightVariantKey";
static NSString *const kMDCSemanticColorSchemePrimaryColorDarkVariantKey =
    @"kMDCSemanticColorSchemePrimaryColorDarkVariantKey";
static NSString *const kMDCSemanticColorSchemeSecondaryColorKey =
    @"kMDCSemanticColorSchemeSecondaryColorKey";
static NSString *const kMDCSemanticColorSchemeErrorColorKey =
    @"kMDCSemanticColorSchemeErrorColorKey";

@implementation MDCSemanticColorScheme

@synthesize primaryColor = _primaryColor;
@synthesize primaryColorLightVariant = _primaryColorLightVariant;
@synthesize primaryColorDarkVariant = _primaryColorDarkVariant;
@synthesize secondaryColor = _secondaryColor;
@synthesize errorColor = _errorColor;

- (instancetype)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithPrimaryColor:(UIColor *)primaryColor
            primaryColorLightVariant:(UIColor *)primaryColorLightVariant
             primaryColorDarkVariant:(UIColor *)primaryColorDarkVariant
                      secondaryColor:(UIColor *)secondaryColor
                          errorColor:(UIColor *)errorColor {
  NSParameterAssert(primaryColor);
  NSParameterAssert(primaryColorLightVariant);
  NSParameterAssert(primaryColorDarkVariant);
  NSParameterAssert(secondaryColor);
  NSParameterAssert(errorColor);

  self = [super init];
  if (self) {
    _primaryColor = primaryColor;
    _primaryColorDarkVariant = primaryColorDarkVariant;
    _primaryColorLightVariant = primaryColorLightVariant;
    _errorColor = errorColor;
    _secondaryColor = secondaryColor;
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
  UIColor *primaryColorLightVariant;
  UIColor *primaryColorDarkVariant;
  UIColor *secondaryColor;
  UIColor *errorColor;

  primaryColor = [aDecoder decodeObjectOfClass:UIColor.class
                                        forKey:kMDCSemanticColorSchemePrimaryColorKey];
  primaryColorLightVariant =
      [aDecoder decodeObjectOfClass:UIColor.class
                             forKey:kMDCSemanticColorSchemePrimaryColorLightVariantKey];
  primaryColorDarkVariant =
      [aDecoder decodeObjectOfClass:UIColor.class
                             forKey:kMDCSemanticColorSchemePrimaryColorDarkVariantKey];
  secondaryColor = [aDecoder decodeObjectOfClass:UIColor.class
                                          forKey:kMDCSemanticColorSchemeSecondaryColorKey];
  errorColor = [aDecoder decodeObjectOfClass:UIColor.class
                                      forKey:kMDCSemanticColorSchemeErrorColorKey];

  return [self initWithPrimaryColor:primaryColor
           primaryColorLightVariant:primaryColorLightVariant
            primaryColorDarkVariant:primaryColorDarkVariant
                     secondaryColor:secondaryColor
                         errorColor:errorColor];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.primaryColor forKey:kMDCSemanticColorSchemePrimaryColorKey];
  [aCoder encodeObject:self.primaryColorLightVariant
                forKey:kMDCSemanticColorSchemePrimaryColorLightVariantKey];
  [aCoder encodeObject:self.primaryColorDarkVariant
                forKey:kMDCSemanticColorSchemePrimaryColorDarkVariantKey];
  [aCoder encodeObject:self.secondaryColor forKey:kMDCSemanticColorSchemeSecondaryColorKey];
  [aCoder encodeObject:self.errorColor forKey:kMDCSemanticColorSchemeErrorColorKey];
}

@end

@implementation MDCSemanticColorScheme (MDCColorSchemeCompatibility)

- (UIColor *)primaryDarkColor {
  return self.primaryColorDarkVariant;
}

- (UIColor *)primaryLightColor {
  return self.primaryColorLightVariant;
}

@end
