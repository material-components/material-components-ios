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

#import "MaterialButtons.h"

/**
 @c MDCBannerViewLayoutMode specifies the layout mode of an MDCBannerView.
 */
typedef NS_ENUM(NSInteger, MDCBannerViewLayoutMode) {
  MDCBannerViewLayoutModeAutomatic,  // Layout is set automatically based on how elements are
                                     // configured on banner view. One of three other layouts will
                                     // be used internally.
  MDCBannerViewLayoutModeSingleRow,  // All elements on the same row, only supports one button
  MDCBannerViewLayoutModeMultiRowStackedButton,  // Multilple rows with stacked button layout
  MDCBannerViewLayoutModeMultiRowAlignedButton,  // Multiple rows with aligned buttons horizontally
};

/**
 The MDCBannerView class creates and configures a view to represent a Material Banner.

 The [Material Guideline](https://material.io/design/components/banners.html) has more details on
 component usage.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCBannerView : UIView

/**
 The layout mode of a @c MDCBannerView.

 The default value is MDCBannerViewLayoutModeAutomatic.
 */
@property(nonatomic, readwrite, assign) MDCBannerViewLayoutMode bannerViewLayoutMode;

/**
 A view that displays the text on a @c MDCBannerView
 The properties of @c textLabel can be used to configure the text shown on @c MDCBannerView.
 */
@property(nonatomic, readonly, strong, nonnull) UILabel *textLabel;

/**
 A view that displays the image on a @c MDCBannerView.
 The properties of @c imageView can be used to configure the image shown on @c MDCBannerView.
 */
@property(nonatomic, readonly, strong, nonnull) UIImageView *imageView;

/**
 A leading button that displays on a @c MDCBannerView.
 This @c leadingButton is displayed on the leading edge of the view. If it does not fit on the same
 row as @c trailingButton, it will be placed above @c trailingButton.
 */
@property(nonatomic, readonly, strong, nonnull) MDCButton *leadingButton;

/**
 A trailing button that displays on a @c MDCBannerView.
 This @c trailingButton is displayed on the trailing edge of the view. If it does not fit on the
 same row as @c leadingButton, it will be placed shows below @c leadingButton.
 */
@property(nonatomic, readonly, strong, nonnull) MDCButton *trailingButton;

/**
 A Boolean value that controls whether the divider of the banner is visible.

 The default value is @c NO.
 */
@property(nonatomic, readwrite, assign) BOOL showsDivider;

/**
 The color applied to the divider of the banner.

 The default value is light grey.
 */
@property(nonatomic, readwrite, strong, nonnull) UIColor *dividerColor;

@end
