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

#import "TextFieldInterfaceBuilderExampleSupplemental.h"

@implementation TextFieldInterfaceBuilderExample (Supplemental)

- (void)setupExampleViews {
  self.title = @"Text Fields";
}

@end

@implementation TextFieldInterfaceBuilderExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"Storyboard (Objective C)" ];
}

+ (NSString *)catalogStoryboardName {
  return @"TextFieldInterfaceBuilderExample";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end

@implementation TextFieldInterfaceBuilderLegacyExample (Supplemental)

- (void)setupExampleViews {
  self.title = @"Legacy Text Fields";
}

@end

@implementation TextFieldInterfaceBuilderLegacyExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Text Field", @"[Legacy] Storyboard (Objective C)" ];
}

+ (NSString *)catalogStoryboardName {
  return @"TextFieldInterfaceBuilderLegacyExample";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
