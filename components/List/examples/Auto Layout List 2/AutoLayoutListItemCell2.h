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

#import "AutoLayoutListBaseCell2.h"

#import <UIKit/UIKit.h>

#import "MaterialTypographyScheme.h"

@interface AutoLayoutListItemCell2 : AutoLayoutListBaseCell2

/**
 A text label. Typically this will be the first line of text in the cell.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *titleLabel;

/**
 Convenience accessor for the text in titleLabel.
 */
@property(nonatomic, copy, nullable) NSString *titleText;

/**
 The font for the title label of the list cell.
 */
@property(nonatomic, strong, nullable) UIFont *titleFont;

/**
 A detail text label. Typically this will be the second line of text in the cell.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *detailLabel;

/**
 Convenience accessor for the text in detailLabel.
 */
@property(nonatomic, copy, nullable) NSString *detailText;

/**
 The font for the details label of the list cell.
 */
@property(nonatomic, strong, nullable) UIFont *detailFont;

/**
 An image view on the leading side of cell. Default leading padding is 16.0f.
 */
@property(nonatomic, readonly, strong, nonnull) UIImageView *leadingImageView;

/**
 Convenience accessor for the image in leadingImageView.
 */
@property(nonatomic, strong, nullable) UIImage *leadingImage;

/**
 An image view on the trailing side of cell. Default leading padding is 16.0f.
 */
@property(nonatomic, readonly, strong, nonnull) UIImageView *trailingImageView;

/**
 Convenience accessor for the image in trailingImageView.
 */
@property(nonatomic, strong, nullable) UIImage *trailingImage;


/*
 Indicates whether the view's contents should automatically update their font when the device’s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory;

/**
 The typography scheme of the cell.
 */
@property (strong, nonatomic) id<MDCTypographyScheming> typographyScheme;

@end
