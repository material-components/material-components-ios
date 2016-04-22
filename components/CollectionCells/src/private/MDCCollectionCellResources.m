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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCCollectionCellResources.h"

// The Bundle for string and icon resources.
static NSString *const kBundleName = @"MaterialCollectionCells.bundle";

static NSString *const kCellCheckImageName = @"mdc_cell_check";
static NSString *const kCellChevronRightImageName = @"mdc_cell_chevron_right";
static NSString *const kCellInfoImageName = @"mdc_cell_info";
static NSString *const kCellDeleteImageName = @"mdc_cell_delete";
static NSString *const kCellReorderImageName = @"mdc_cell_reorder";
static NSString *const kCellSelectedImageName = @"mdc_cell_selected";
static NSString *const kCellUnselectedImageName = @"mdc_cell_unselected";

@implementation MDCCollectionCellResources

+ (instancetype)sharedInstance {
  static MDCCollectionCellResources *sharedInstance;
  @synchronized(self) {
    if (sharedInstance == nil) {
      sharedInstance = [[MDCCollectionCellResources alloc] init];
    }
  }
  return sharedInstance;
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
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle)resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

- (UIImage *)loadImageWithName:(NSString *)imageName {
  NSBundle *bundle = [[self class] bundle];
  return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

#pragma mark - Images

- (UIImage *)imageForCellAccessoryCheck {
  return [self loadImageWithName:kCellCheckImageName];
}

- (UIImage *)imageForCellAccessoryChevronRight {
  return [self loadImageWithName:kCellChevronRightImageName];
}

- (UIImage *)imageForCellAccessoryInfo {
  return [self loadImageWithName:kCellInfoImageName];
}

- (UIImage *)imageForCellEditingDelete {
  return [self loadImageWithName:kCellDeleteImageName];
}

- (UIImage *)imageForCellEditingReorder {
  return [self loadImageWithName:kCellReorderImageName];
}

- (UIImage *)imageForCellEditingSelected {
  return [self loadImageWithName:kCellSelectedImageName];
}

- (UIImage *)imageForCellEditingUnselected {
  return [self loadImageWithName:kCellUnselectedImageName];
}

@end
