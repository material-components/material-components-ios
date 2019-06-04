// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialShadowElevations.h"

@interface MDCBaseCell : UICollectionViewCell

/**
 The current elevation of the cell.
 */
@property(nonatomic, assign) MDCShadowElevation elevation;

/**
 The color of the cell’s underlying Ripple.
 */
@property(nonatomic, strong, nonnull) UIColor *inkColor;

/*
 This property determines if an @c MDCBaseCell should use the @c MDCRippleView behavior
 or not. By setting this property to @c YES, @c MDCRippleView is used to provide the user visual
 touch feedback, instead of the legacy @c MDCInkView.
 @note Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 The color of the cell’s underlying Ripple.
 */
@property(nonatomic, strong, nullable) UIColor *rippleColor;

@end
