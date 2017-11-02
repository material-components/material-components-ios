/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "MDCBottomNavigationBar.h"

@interface MDCBottomNavigationItemView : UIView

@property(nonatomic, assign) BOOL circleHighlightHidden;
@property(nonatomic, assign) BOOL titleBelowIcon;
@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) MDCBottomNavigationBarTitleVisibility titleVisibility;

@property(nonatomic, copy) NSString *badgeValue;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIFont *itemTitleFont UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) UIColor *badgeColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *selectedItemTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *unselectedItemTintColor UI_APPEARANCE_SELECTOR;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
