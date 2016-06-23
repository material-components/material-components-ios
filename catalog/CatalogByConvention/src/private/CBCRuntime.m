/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "CBCRuntime.h"

#import "CBCCatalogExample.h"

#import <objc/runtime.h>

#pragma mark Breadcrumb retrieval

NSArray<NSString *> *CBCCatalogBreadcrumbsFromClass(Class aClass) {
  return [aClass performSelector:@selector(catalogBreadcrumbs)];
}

#pragma mark Primary demo check

BOOL CBCCatalogIsPrimaryDemoFromClass(Class aClass) {
  BOOL isPrimaryDemo = NO;

  if ([aClass respondsToSelector:@selector(catalogIsPrimaryDemo)]) {
    NSMethodSignature *signature =
        [aClass methodSignatureForSelector:@selector(catalogIsPrimaryDemo)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = @selector(catalogIsPrimaryDemo);
    invocation.target = aClass;
    [invocation invoke];
    [invocation getReturnValue:&isPrimaryDemo];
  }

  return isPrimaryDemo;
}

#pragma mark Runtime enumeration

NSArray<Class> *CBCGetAllClasses(void) {
  int numberOfClasses = objc_getClassList(NULL, 0);
  Class *classList = (Class *)malloc(numberOfClasses * sizeof(Class));
  objc_getClassList(classList, numberOfClasses);

  NSMutableArray<Class> *classes = [NSMutableArray array];

  NSSet *ignoredClasses = [NSSet setWithArray:@[
    @"SwiftObject", @"Object", @"FigIrisAutoTrimmerMotionSampleExport", @"NSLeafProxy"
  ]];
  NSArray *ignoredPrefixes = @[ @"Swift.", @"_", @"JS" ];

  for (int ix = 0; ix < numberOfClasses; ++ix) {
    Class aClass = classList[ix];
    NSString *className = NSStringFromClass(aClass);
    if ([ignoredClasses containsObject:className]) {
      continue;
    }
    BOOL hasIgnoredPrefix = NO;
    for (NSString *prefix in ignoredPrefixes) {
      if ([className hasPrefix:prefix]) {
        hasIgnoredPrefix = YES;
        break;
      }
    }
    if (hasIgnoredPrefix) {
      continue;
    }
    [classes addObject:aClass];
  }

  free(classList);

  return classes;
}

NSArray<Class> *CBCClassesRespondingToSelector(NSArray<Class> *classes, SEL selector) {
  NSMutableArray<Class> *filteredClasses = [NSMutableArray array];
  for (Class aClass in classes) {
    if ([aClass respondsToSelector:selector]) {
      [filteredClasses addObject:aClass];
    }
  }
  return filteredClasses;
}

#pragma mark UIViewController instantiation

UIViewController *CBCViewControllerFromClass(Class aClass) {
  if ([aClass respondsToSelector:@selector(catalogStoryboardName)]) {
    NSString *storyboardName = [aClass catalogStoryboardName];
    NSBundle *bundle = [NSBundle bundleForClass:aClass];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
    NSCAssert(storyboard, @"expecting a storyboard to exist at %@", storyboardName);
    UIViewController *vc = [storyboard instantiateInitialViewController];
    NSCAssert(vc, @"expecting a initialViewController in the storyboard %@", storyboardName);
    return vc;
  }
  return [[aClass alloc] init];
}

NSString *CBCDescriptionFromClass(Class aClass) {
  if ([aClass respondsToSelector:@selector(catalogDescription)]) {
    NSString *catalogDescription = [aClass catalogDescription];
    return catalogDescription;
  }
  return nil;
}

#pragma mark Fix View Debugging

void CBCFixViewDebuggingIfNeeded() {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    Method original = class_getInstanceMethod([UIView class], @selector(viewForBaselineLayout));
    class_addMethod([UIView class], @selector(viewForFirstBaselineLayout),
                    method_getImplementation(original), method_getTypeEncoding(original));
    class_addMethod([UIView class], @selector(viewForLastBaselineLayout),
                    method_getImplementation(original), method_getTypeEncoding(original));
  });
}
