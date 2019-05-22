// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBottomNavigationBar.h"
#import "MaterialInk.h"

@interface MDCBottomNavigationItemView : UIView

@property(nonatomic, assign) BOOL titleBelowIcon;
@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) MDCBottomNavigationBarTitleVisibility titleVisibility;
@property(nonatomic, strong) MDCInkView *inkView;
@property(nonatomic, assign) UIOffset titlePositionAdjustment;

@property(nonatomic, copy) NSString *badgeValue;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIFont *itemTitleFont UI_APPEARANCE_SELECTOR;

/**
 The number of lines available for rendering the title of this item.  Defaults to 1.

 @note This property is only used when @c titleBelowIcon is @c true.
 */
@property(nonatomic, assign) NSInteger titleNumberOfLines;
// Default = YES
@property(nonatomic, assign) BOOL truncatesTitle;

@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *selectedImage;

@property(nonatomic, strong) UIColor *badgeColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *selectedItemTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *unselectedItemTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *selectedItemTitleColor;

@property(nonatomic, assign) CGFloat contentVerticalMargin;
@property(nonatomic, assign) CGFloat contentHorizontalMargin;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
