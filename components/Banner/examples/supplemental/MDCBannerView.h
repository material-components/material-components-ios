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

@class MDCButton;

__attribute__((objc_subclassing_restricted)) @interface MDCBannerView : UIView

@property(nonatomic, assign) CGFloat preferredContentWidth;

@property(nonatomic, copy, nonnull) NSString *text;
@property(nonatomic, strong, nonnull) UIColor *textColor;
@property(nonatomic, strong, nonnull) UIFont *textFont;

@property(nonatomic, strong, nullable) UIImage *icon;  // default is nil
@property(nonatomic, strong, nullable) UIColor *iconTintColor;

/**
 The buttons representing the banner's actions.

 Banner supports 1 - 2 buttons.
 */
@property(nonatomic, strong, nonnull) NSMutableArray<MDCButton *> *buttons;

@end
