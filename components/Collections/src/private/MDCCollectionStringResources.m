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

#import "MDCCollectionStringResources.h"

#import "MaterialCollectionsStrings.h"
#import "MaterialCollectionsStrings_table.h"

// The Bundle for string resources.
static NSString *const kBundleName = @"MaterialCollections.bundle";

@implementation MDCCollectionStringResources

+ (instancetype)sharedInstance {
  static MDCCollectionStringResources *sharedInstance;
  @synchronized(self) {
    if (sharedInstance == nil) {
      sharedInstance = [[MDCCollectionStringResources alloc] init];
    }
  }
  return sharedInstance;
}

- (NSString *)stringForId:(MaterialCollectionsStringId)stringID {
  NSString *stringKey = kMaterialCollectionsStringTable[stringID];
  NSBundle *bundle = [[self class] bundle];
  NSString *tableName = [kBundleName stringByDeletingPathExtension];
  return [bundle localizedStringForKey:stringKey value:nil table:tableName];
}

- (NSString *)deleteButtonString {
  return [self stringForId:kStr_MaterialCollectionsDeleteButton];
}

- (NSString *)infoBarGestureHintString {
  return [self stringForId:kStr_MaterialCollectionsInfoBarGestureHint];
}

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kBundleName]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCCollectionStringResources class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle)resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}
@end
