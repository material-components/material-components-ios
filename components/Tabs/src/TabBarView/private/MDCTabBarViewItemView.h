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

#import <UIKit/UIKit.h>

#import "MDCTabBarViewCustomViewable.h"

#import <MaterialComponents/MaterialRipple.h>

/** A basic view that displays a title and image for a tab bar item within MDCTabBarView. */
@interface MDCTabBarViewItemView : UIView <MDCTabBarViewCustomViewable>

/** The image to display when unselected. */
@property(nonatomic, strong) UIImage *image;

/** The image to display when selected. */
@property(nonatomic, strong) UIImage *selectedImage;

/** The image view to display the icon. */
@property(nonatomic, strong) UIImageView *iconImageView;

/** The label to display the title. */
@property(nonatomic, strong) UILabel *titleLabel;

/** The ripple contronller to display the ripple touch effect. */
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;

@end
