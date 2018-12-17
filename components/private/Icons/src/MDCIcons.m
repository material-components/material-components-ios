// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCIcons.h"

#import "MDCIcons+BundleLoader.h"

@implementation MDCIcons

+ (nullable NSBundle *)bundleNamed:(nonnull NSString *)bundleName {
  static NSCache *bundleCache;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundleCache = [[NSCache alloc] init];
  });

  NSBundle *bundle = [bundleCache objectForKey:bundleName];
  if (!bundle) {
    NSBundle *baseBundle = [NSBundle bundleForClass:[MDCIcons class]];
    NSString *bundlePath = [baseBundle pathForResource:bundleName ofType:@"bundle"];
    bundle = [NSBundle bundleWithPath:bundlePath];
    if (bundle) {
      [bundleCache setObject:bundle forKey:bundleName];
    }
  }
  return bundle;
}

+ (nonnull NSString *)pathForIconName:(nonnull NSString *)iconName
                       withBundleName:(nonnull NSString *)bundleName {
  NSBundle *bundle = [self bundleNamed:bundleName];
  NSAssert(bundle, @"Missing bundle %@ containing icon %@.", bundleName, iconName);
  return [bundle pathForResource:iconName ofType:@"png"];
}

@end
