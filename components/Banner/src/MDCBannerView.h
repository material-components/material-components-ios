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
#import "MaterialButtons.h"  // ComponentImport
#import "MaterialElevation.h"  // ComponentImport
#import "M3CButton.h"

NS_ASSUME_NONNULL_BEGIN

/**
 @c MDCBannerViewLayoutStyle specifies the layout style of an MDCBannerView.
 */
typedef NS_ENUM(NSInteger, MDCBannerViewLayoutStyle) {
  MDCBannerViewLayoutStyleAutomatic,  // Layout is set automatically based on how elements are
                                      // configured on banner view. One of three other layouts will
                                      // be used internally.
  MDCBannerViewLayoutStyleSingleRow,  // All elements on the same row.
  MDCBannerViewLayoutStyleMultiRowStackedButton,  // Multilple rows with stacked button layout
  MDCBannerViewLayoutStyleMultiRowAlignedButton,  // Multiple rows with aligned buttons horizontally
};

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 The MDCBannerView class creates and configures a view to represent a Material Banner.

 The [Material Guideline](https://material.io/design/components/banners.html) has more details on
 component usage.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCBannerView
    : UIView<MDCElevatable, MDCElevationOverriding>
#pragma clang diagnostic pop

/**
 The layout style of a @c MDCBannerView.

 The default value is MDCBannerViewLayoutStyleAutomatic.
 */
@property(nonatomic, readwrite, assign) MDCBannerViewLayoutStyle bannerViewLayoutStyle;

/**
 A view that displays the text on a @c MDCBannerView
 The properties of @c textView can be used to configure the text shown on @c MDCBannerView.
 */
@property(nonatomic, readonly, strong, nonnull) UITextView *textView;

/**
 A view that displays the image on a @c MDCBannerView.
 The properties of @c imageView can be used to configure the image shown on @c MDCBannerView.
 */
@property(nonatomic, readonly, strong, nonnull) UIImageView *imageView;

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 A leading button that displays on a @c MDCBannerView.
 This @c leadingButton is displayed on the leading edge of the view. If it does not fit on the same
 row as @c trailingButton, it will be placed above @c trailingButton.
 */
@property(nonatomic, readonly, strong, nonnull) MDCButton *leadingButton;
#pragma clang diagnostic pop

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 A trailing button that displays on a @c MDCBannerView.
 This @c trailingButton is displayed on the trailing edge of the view. If it does not fit on the
 same row as @c leadingButton, it will be placed shows below @c leadingButton.

 Set @c hidden to @c YES on @c trailingButton if only one button is desired on @c MDCBannerView.
 */
@property(nonatomic, readonly, strong, nonnull) MDCButton *trailingButton;
#pragma clang diagnostic pop

/**
 A leading button that displays on a @c MDCBannerView.
 This @c leadingButton is displayed on the leading edge of the view. If it does
 not fit on the same row as @c trailingButton, it will be placed above
 @c trailingButton. While nonnull, these buttons are only added to the view when
 you use 'initForM3'.
 */
@property(nonatomic, readonly, strong, nonnull) M3CButton *leadingM3CButton;

/**
 A trailing button that displays on a @c MDCBannerView.
 This @c trailingButton is displayed on the trailing edge of the view. If it
 does not fit on the same row as @c leadingButton, it will be placed shows below
 @c leadingButton.

 Set @c hidden to @c YES on @c trailingButton if only one button is desired on
 @c MDCBannerView. While nonnull, these buttons are only added to the view when
 you use 'initForM3'.
 */
@property(nonatomic, readonly, strong, nonnull) M3CButton *trailingM3CButton;

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

/**
 The insets applied to the banner for all its content.

 The banner uses this property to determine @c intrinsicContentSize and @c sizeThatFits:.

 The default value is @c UIEdgeInsetsZero.
 */
@property(nonatomic, readwrite, assign) UIEdgeInsets contentEdgeInsets;

/**
 A block that is invoked when the @c MDCBannerView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCBannerView *_Nonnull bannerView, UITraitCollection *_Nullable previousTraitCollection);

/**
 This flag is set when `M3CButton` is used instead of `MDCButton`. This flag
 will be eventually removed when `MDCButton` is deleted.

 Defaults to NO.
 */
@property(nonatomic, readonly) BOOL isM3CButtonEnabled;

/** Initializes the @c MDCBannerView to be compatible with M3. This
 * means using @c M3CButton instead of @c MDCButton for @c leadingButton and
 * @c trailingButton.
 * This method should be deleted once MDCButton usage for @c MDCBannerView is
 * removed.
 */
- (instancetype)initForM3;

@end

NS_ASSUME_NONNULL_END
