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

@interface MDCAlertControllerView : UIView

@property(nonatomic, strong, nullable) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *titleColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, assign) NSTextAlignment titleAlignment;
@property(nonatomic, strong, nullable) UIImage *titleIcon;
@property(nonatomic, strong, nullable) UIColor *titleIconTintColor;

/**
 An optional custom icon view above the title of the alert.

 @note This property is intended to be used to provide a custom implementation of the title icon
 view. If the intention is to just display a `UIImage`, use `setTitleIcon:` API instead. If
 'titleIcon' is set, 'titleIconView' is ignored.
 */
@property(nonatomic, strong, nullable) UIView *titleIconView;

@property(nonatomic, strong, nullable) UIFont *messageFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *messageColor UI_APPEARANCE_SELECTOR;

// b/117717380: Will be deprecated (x3)
@property(nonatomic, strong, nullable) UIFont *buttonFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *buttonColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *buttonInkColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, assign) CGFloat cornerRadius;

/*
 Indicates whether the view's contents should automatically update their font when the device’s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory UI_APPEARANCE_SELECTOR;

/**
 By setting this property to @c YES, the Ripple component will be used instead of Ink
 to display visual feedback to the user.

 @note This property will eventually be enabled by default, deprecated, and then deleted as part
 of our migration to Ripple. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

@end
