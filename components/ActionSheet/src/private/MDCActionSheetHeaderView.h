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

#import "MDCMinimumOS.h"  // IWYU pragma: keep

#import <UIKit/UIKit.h>

@interface MDCActionSheetHeaderView : UIView <UIContentSizeCategoryAdjusting>

- (nonnull instancetype)initWithFrame:(CGRect)frame;

/** Header must be created with initWithFrame */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@property(nonatomic, nullable, copy) NSString *title;

@property(nonatomic, nullable, copy) NSString *message;

@property(nonatomic, strong, nonnull) UIFont *titleFont;

@property(nonatomic, strong, nonnull) UIFont *messageFont;

@property(nonatomic, strong, nullable) UIColor *titleTextColor;

@property(nonatomic, strong, nullable) UIColor *messageTextColor;

@end
