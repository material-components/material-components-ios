/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
#import "AutoLayoutListBaseCell1.h"

@protocol MDCTypographyScheming;

/**
 An customizable Auto Layout based cell for use in Material Lists.
 */
@interface AutoLayoutListItemCell1 : AutoLayoutListBaseCell1

/**
 The label used to display overline text, which is positioned above the title text.
 */
@property (strong, nonatomic, readonly, nonnull) UILabel *overlineLabel;

/**
 The label used to display title text, which is the most prominent text in the cell.
 */
@property (strong, nonatomic, readonly, nonnull) UILabel *titleLabel;

/**
 The label used to display detail text, below the title text.
 */
@property (strong, nonatomic, readonly, nonnull) UILabel *detailLabel;

/**
 Convenience setter for the overlineLabel's text. Triggers a layout.
 */
@property (nonatomic, copy, nullable) NSString *overlineText;

/**
 Convenience setter for the titleLabel's text. Triggers a layout.
 */
@property (nonatomic, copy, nullable) NSString *titleText;

/**
 Convenience setter for the detailLabel's text. Triggers a layout.
 */
@property (nonatomic, copy, nullable) NSString *detailText;

/**
 Determines the cell's text's leading offset.
 Only takes effect when automaticallySetTextOffset is set to false.
 */
@property (nonatomic, assign) CGFloat textOffset;

/**
 If set to NO, the textOffset property determines the text offset.
 If set to YES, text content is padded along the leadingView, if it exists.
 */
@property (nonatomic, assign) BOOL automaticallySetTextOffset;

/**
 A supporting view on the leading edge of the cell. Can be a UIImageView, a UIControl, or something else.
 */
@property (strong, nonatomic, nullable) UIView *leadingView;

/**
 Determines whether the leadingView is pinned to the top or vertically centered within the cell.
 */
@property (nonatomic, assign) BOOL centerLeadingViewVertically;

/**
 A supporting view on the trailing edge of the cell. Can be a UIImageView, a UIControl, or something else.
 */
@property (strong, nonatomic, nullable) UIView *trailingView;

/**
 Determines whether the trailingView is pinned to the top or vertically centered within the cell.
 */
@property (nonatomic, assign) BOOL centerTrailingViewVertically;

/**
 The typography scheme of the cell.
 */
@property (strong, nonatomic) id<MDCTypographyScheming> typographyScheme;

/**
 Indicates whether the view's contents should automatically update their font when the device’s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory;

@end
