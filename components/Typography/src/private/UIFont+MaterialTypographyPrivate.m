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

#import "UIFont+MaterialTypographyPrivate.h"

@implementation UIFont (MaterialTypographyPrivate)

/*
 Returns a string indicating the weight of the font.  These weights were added in iOS 8.2.
 */
+ (NSString *)mdc_fontWeightDescription:(CGFloat)weight {
// The UIFontWeight enumeration was added in iOS 8.2
  NSString *description = [NSString stringWithFormat:@"(%.3f)", weight];
#if defined(__IPHONE_8_2)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
#pragma clang diagnostic ignored "-Wtautological-pointer-compare"
  if (&UIFontWeightMedium != NULL) {
    if (weight == UIFontWeightUltraLight) {
      return @"UltraLight";
    } else if (weight == UIFontWeightThin) {
      return @"Thin";
    } else if (weight == UIFontWeightLight) {
      return @"Light";
    } else if (weight == UIFontWeightRegular) {
      return @"Regular";
    } else if (weight == UIFontWeightMedium) {
      return @"Medium";
    } else if (weight == UIFontWeightSemibold) {
      return @"Semibold";
    } else if (weight == UIFontWeightBold) {
      return @"Bold";
    } else if (weight == UIFontWeightHeavy) {
      return @"Heavy";
    } else if (weight == UIFontWeightBlack) {
      return @"Black";
    } else {
      return description;
    }
  } else {
    return description;
  }
#pragma clang diagnostic pop
#else
  return description;
#endif
}

- (CGFloat)mdc_weight {
  // The default font weight is UIFontWeightRegular, which is 0.0.
  CGFloat weight = 0.0;

  NSDictionary *fontTraits = [self.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute];
  if (fontTraits) {
    NSNumber *weightNumber = fontTraits[UIFontWeightTrait];
    if (weightNumber != nil) {
      weight = [weightNumber floatValue];
    }
  }

  return weight;
}

- (CGFloat)mdc_slant {
  CGFloat slant = 0.0;

  NSDictionary *fontTraits = [self.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute];
  if (fontTraits) {
    NSNumber *slantNumber = fontTraits[UIFontSlantTrait];
    if (slantNumber != nil) {
      slant = [slantNumber floatValue];
    }
  }

  return slant;
}

- (NSString *)mdc_weightString {
  CGFloat weight = [self mdc_weight];
  NSString *weightString = [UIFont mdc_fontWeightDescription:weight];

  return weightString;
}

- (NSString *)mdc_extendedDescription {
  NSMutableString *extendedDescription = [[NSMutableString alloc] init];
  [extendedDescription appendFormat:@"%@ : ", self.fontName];
  [extendedDescription appendFormat:@"%@ : ", self.familyName];
  [extendedDescription appendFormat:@"%.1f pt : ", self.pointSize];
  [extendedDescription appendFormat:@"%@", [self mdc_weightString]];

  return extendedDescription;
}

@end
