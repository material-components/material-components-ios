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

@implementation MDCSemanticColorScheme

@synthesize primaryColor = _primaryColor;
@synthesize primaryColorLightVariant = _primaryColorLightVariant;
@synthesize primaryColorDarkVariant = _primaryColorDarkVariant;
@synthesize secondaryColor = _secondaryColor;
@synthesize errorColor = _errorColor;

- (instancetype)initWithPrimaryColor:(UIColor *)primaryColor
            primaryColorLightVariant:(UIColor *)primaryColorLightVariant
             primaryColorDarkVariant:(UIColor *)primaryColorDarkVariant
                      secondaryColor:(UIColor *)secondaryColor
                          errorColor:(UIColor *)errorColor {
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

- (UIColor *)primaryDarkColor {
  return self.primaryColorDarkVariant;
}

- (UIColor *)primaryLightColor {
  return self.primaryColorLightVariant;
}

@end
