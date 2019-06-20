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
  NSParameterAssert(items);

  if (_items != items && ![_items isEqual:items]) {
    _items = [items copy];

    // Determine new selected item, defaulting to nil.
    UITabBarItem *newSelectedItem = nil;
    if (_selectedItem && [_items containsObject:_selectedItem]) {
      // Previously-selected item still around: Preserve selection.
      newSelectedItem = _selectedItem;
    }

    _selectedItem = newSelectedItem;
  }
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
  if (_selectedItem == selectedItem) {
    return;
  }
  NSUInteger itemIndex = [_items indexOfObject:selectedItem];
  if (selectedItem && (itemIndex == NSNotFound)) {
    NSString *itemTitle = selectedItem.title;
    NSString *exceptionMessage =
    [NSString stringWithFormat:@"%@ is not a member of the tab bar's `items`.", itemTitle];
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:exceptionMessage
                           userInfo:nil] raise];
  }

  _selectedItem = selectedItem;
}

@end
