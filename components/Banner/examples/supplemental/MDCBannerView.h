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

__attribute__((objc_subclassing_restricted)) @interface MDCBannerView : UIView

/**
 A view that displays the text on a @c MDCBannerView.
 @discussion These properties of @c textLabel can be used to configure the text shown on @c MDCBannerView.
 */
@property(nonatomic, readonly, strong, nonnull) UILabel *textLabel;

/**
 A view that displays the image on a @c MDCBannerView.
 @discussion These properties of @c imageView can be used to configure the image shown on @c MDCBannerView.
 If @c imageView 's own property @c image is @c nil, this view won't show on the @c MDCBannerView.
 */
@property(nonatomic, readonly, strong, nonnull) UIImageView *imageView;

/**
 A leading button that displays on a @c MDCBannerView.
 @discussion This @c leadingButton displays on the leading edge of the view. If it can't occupy on the same line with @c trailingButton, it always shows above it.
 */
@property(nonatomic, readonly, strong, nonnull) MDCButton *leadingButton;

/**
 A trailing button that displays on a @c MDCBannerView.
 @discussion This @c trailingButton displays on the trailing edge of the view. If it can't occupy on the same line with @c leadingButton, it always shows below it.
 */
@property(nonatomic, readonly, strong, nonnull) MDCButton *trailingButton;

@end
