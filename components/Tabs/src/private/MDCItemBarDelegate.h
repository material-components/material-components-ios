// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

@class MDCItemBar;

/**
 Delegate protocol for MDCItemBar. Clients may implement this protocol to receive notifications of
 selection changes.
 */
@protocol MDCItemBarDelegate <NSObject>
/**
 Called before the selected item changes by user action. This method is not called for programmatic
 changes to the bar's selected item. Return YES to allow the selection.
 */
- (BOOL)itemBar:(nonnull MDCItemBar *)itemBar shouldSelectItem:(nonnull UITabBarItem *)item;

/**
 Called when the selected item changes by user action. This method is not called for programmatic
 changes to the bar's selected item.
 */
- (void)itemBar:(nonnull MDCItemBar *)itemBar didSelectItem:(nonnull UITabBarItem *)item;

@end
