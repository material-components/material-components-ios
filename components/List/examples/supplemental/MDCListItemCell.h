//
//  MDCListItemCell.h
//  Pods
//
//  Created by andrewoverton on 5/22/18.
//

#import <UIKit/UIKit.h>
#import "MDCListBaseCell.h"


/** Avatar Display Mode */
typedef NS_ENUM(NSInteger, MDCListItemCellImageDisplayMode) {
  /** Images are rounded */
  MDCListItemCellImageDisplayModeRound,
  
  /** Images are squares */
  MDCListItemCellImageDisplayModeSquare,
};

@interface MDCListItemCell : MDCListBaseCell

@property (strong, nonatomic, readonly, nonnull) UILabel *overlineLabel;
@property (strong, nonatomic, readonly, nonnull) UILabel *titleLabel;
@property (strong, nonatomic, readonly, nonnull) UILabel *detailLabel;

@property (nonatomic, copy, nullable) NSString *overlineText;
@property (nonatomic, copy, nullable) NSString *titleText;
@property (nonatomic, copy, nullable) NSString *detailsText;
@property (nonatomic, assign) CGFloat textOffset;

@property (strong, nonatomic, nullable) UIView *leadingView;
@property (nonatomic, assign) BOOL centerLeadingViewVertically;

@property (strong, nonatomic, nullable) UIView *trailingView;
@property (nonatomic, assign) BOOL centerTrailingViewVertically;

/*
 @property (strong, nonatomic, nullable) UIImage *secondaryImage;
 @property (strong, nonatomic, nullable) UIImage *secondaryPlaceholderImage;
 ^ If nil image occupies no space. Should this be static?
 */



@end
