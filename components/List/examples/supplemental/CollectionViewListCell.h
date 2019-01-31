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
#import "MaterialTypographyScheme.h"

@interface CollectionViewListCell : UICollectionViewCell

/**
 A text label. Typically this will be the first line of text in the cell.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *titleLabel;

/**
 A detail text label. Typically this will be the second line of text in the cell.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *detailsTextLabel;

/**
 An image view on the leading side of cell. Default leading padding is 16.
 */
@property(nonatomic, readonly, strong, nullable) UIImageView *imageView;

/**
 The font for the title label of the list cell.
 */
@property(nonatomic, strong, nullable) UIFont *titleFont;

/**
 The font for the details label of the list cell.
 */
@property(nonatomic, strong, nullable) UIFont *detailsFont;

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
 Sets the cell width for the self-sizing cell.
 Note: The self-sizing is only applied to the height, and the width is set using this method.

 @param width The width to set the cell.
 */
- (void)setCellWidth:(CGFloat)width;

/**
 Sets the image that is seen on the left side of the cell.

 @param image The image to set to.
 */
- (void)setImage:(nullable UIImage *)image;

/**
 Apply the typography scheme on the cell instance.

 @param typographyScheme the typography scheme to apply.
 */
- (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme;

@end
