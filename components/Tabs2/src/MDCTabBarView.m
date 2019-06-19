// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTabBarView.h"

@implementation MDCTabBarView

#pragma mark - Properties

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  NSAssert([NSThread isMainThread], @"Item array may only be set on the main thread");
  NSParameterAssert(items != nil);

  if (_items != items && ![_items isEqual:items]) {
    _items = [items copy];

    // Determine new selected item, defaulting to the first item.
    UITabBarItem *newSelectedItem = _items.firstObject;
    if (_selectedItem && [_items containsObject:_selectedItem]) {
      // Previously-selected item still around: Preserve selection.
      newSelectedItem = _selectedItem;
    }

    // Update _selectedItem directly so it's available for -reload.
    _selectedItem = newSelectedItem;
  }
}

- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem {
  [self setSelectedItem:selectedItem animated:NO];
}

- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem animated:(BOOL)animated {
  if (_selectedItem != selectedItem) {
    NSUInteger itemIndex = [self indexForItem:selectedItem];
    if (selectedItem && (itemIndex == NSNotFound)) {
      [[NSException exceptionWithName:NSInvalidArgumentException
                               reason:@"Invalid item"
                             userInfo:nil] raise];
    }

    _selectedItem = selectedItem;
  }
}

#pragma mark - Private

- (NSInteger)indexForItem:(nullable UITabBarItem *)item {
  if (item) {
    return [_items indexOfObject:item];
  }
  return NSNotFound;
}

@end
