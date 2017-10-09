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

#import "MDCBottomNavigationView.h"

@interface MDCBottomNavigationCell : UIView

@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) MDCBottomNavigationViewTitleHideState titleHideState;

@property(nonatomic, copy) NSString *badgeValue;
@property(nonatomic, copy) NSString *title;

@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) UIColor *badgeColor;
@property(nonatomic, strong) UIColor *selectedColor;
@property(nonatomic, strong) UIColor *unselectedColor;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
