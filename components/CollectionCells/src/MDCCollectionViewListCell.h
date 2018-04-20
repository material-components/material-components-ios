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
@property(nonatomic, readonly, strong, nullable) UILabel *textLabel;

/**
 A detail text label. Typically this will be the second line of text in the cell.
 */
@property(nonatomic, readonly, strong, nullable) UILabel *detailTextLabel;

/**
 An image view on the leading side of cell. Default leading padding is 16.0f.
 */
@property(nonatomic, readonly, strong, nullable) UIImageView *imageView;

@end
