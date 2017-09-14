/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
 
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

#import "MDCCatalogStyle.h"

static inline BOOL isRunningiOS9OrGreater() {
   static NSOperatingSystemVersion iOS9Version = {9, 0, 0};
   NSProcessInfo *processInfo = [NSProcessInfo processInfo];
   return [processInfo isOperatingSystemAtLeastVersion:iOS9Version];
}

@implementation MDCCatalogStyle

+ (UIFont *)headerFont {
   if (isRunningiOS9OrGreater()) {
      return [UIFont monospacedDigitSystemFontOfSize:16 weight:UIFontWeightRegular];
   } else {
      UIFont* font = [UIFont systemFontOfSize:16];
      UIFontDescriptor *descriptor =
          [[font fontDescriptor] fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitMonoSpace];
      return [UIFont fontWithDescriptor:descriptor size:0.0];
   }
}
+ (UIColor *)mdcBlack {
  return [UIColor colorWithWhite:0.1f alpha:1];
}
+ (UIColor *)mdcGrey {
  return [UIColor colorWithWhite:0.9f alpha:1];
}
+ (UIColor *)mdcGreen {
  // #B2FF59 ? TODO
  return [UIColor colorWithRed:11/255.0f green:232/255.0f blue:94/255.0f alpha:1];
}

+ (NSArray *)shadesOfGrey:(int)numberOfGreys {
  NSMutableArray *shades = [NSMutableArray array];
  for (int i = 0; i < numberOfGreys; i++) {
    [shades addObject:[UIColor colorWithWhite:(CGFloat)(0.9 - i * 0.1) alpha:1]];
  }
  return shades;
}


@end
