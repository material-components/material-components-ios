//
//  MDCCollectionViewListCell.h
//  MaterialComponents
//
//  Created by yar on 4/9/18.
//

#import <UIKit/UIKit.h>
#import "MDCCollectionViewTextCell.h"
#import "MaterialShadowLayer.h"

@interface MDCCollectionViewListCell : MDCCollectionViewCell

/**
 A text label. Typically this will be the first line of text in the cell.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *titleLabel;

/**
 A detail text label. Typically this will be the second line of text in the cell.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *detailsTextLabel;

/**
 An image view on the leading side of cell. Default leading padding is 16.0f.
 */
@property(nonatomic, readonly, strong, nullable) UIImageView *imageView;

/*
 Indicates whether the view's contents should automatically update their font when the device’s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory;

@property(nonatomic, strong, nullable) UIFont *titleFont;
@property(nonatomic, strong, nullable) UIFont *detailsFont;

- (void)setCellWidth:(CGFloat)width;

- (void)setImage:(nullable UIImage *)image;

@end
