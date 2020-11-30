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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MDCTabBarViewItemView;

/** The different styles for an @c MDCTabBarViewItemView. */
typedef NS_ENUM(NSUInteger, MDCTabBarViewItemViewStyle) {

  /**
   The item has text only
   */
  MDCTabBarViewItemViewStyleTextOnly = 0,

  /**
   The item has an image only
   */
  MDCTabBarViewItemViewStyleImageOnly = 1,

  /**
   The item has both text and image.
   */
  MDCTabBarViewItemViewStyleTextAndImage = 2,
};

@protocol MDCTabBarViewItemViewDelegate <NSObject>

/* Minimum item width*/
@property(nonatomic) CGFloat minItemWidth;

/**
 The edge insets between for the item when the item has a given style.
 */
- (UIEdgeInsets)contentInsetsForItemViewStyle:(MDCTabBarViewItemViewStyle)itemViewStyle;

@end
