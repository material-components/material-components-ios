/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "Reflection.h"

@protocol CatalogNode <NSObject>
- (NSArray<NSString *> *)catalogBreadcrumbs;
@end

@protocol CatalogStoryboardViewController <NSObject>
- (NSString *)catalogStoryboardName;
@end

NSArray<NSString *> *CatalogBreadcrumbsFromClass(Class aClass) {
  return [aClass performSelector:@selector(catalogBreadcrumbs)];
}

UIViewController *ViewControllerFromClass(Class aClass) {
  if ([aClass respondsToSelector:@selector(catalogStoryboardName)]) {
    NSString *storyboardName = [aClass catalogStoryboardName];
    NSBundle *bundle = [NSBundle bundleForClass:aClass];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
    return [storyboard instantiateInitialViewController];
  }
  return [[aClass alloc] initWithNibName:nil bundle:nil];
}
