//
//  MDCListItemCell.h
//  Pods
//
//  Created by andrewoverton on 5/22/18.
//

#import <UIKit/UIKit.h>
#import "MDCListBaseCell.h"

@protocol MDCTypographyScheming;

@interface MDCListItemCell : MDCListBaseCell

@property (strong, nonatomic, readonly, nonnull) UILabel *overlineLabel;
@property (strong, nonatomic, readonly, nonnull) UILabel *titleLabel;
@property (strong, nonatomic, readonly, nonnull) UILabel *detailLabel;

@property (nonatomic, copy, nullable) NSString *overlineText;
@property (nonatomic, copy, nullable) NSString *titleText;
@property (nonatomic, copy, nullable) NSString *detailText;

@property (nonatomic, assign) CGFloat textOffset;
@property (nonatomic, assign) BOOL automaticallySetTextOffset;

@property (strong, nonatomic, nullable) UIView *leadingView;
@property (nonatomic, assign) NSInteger leadingViewSizingMode;
@property (nonatomic, assign) BOOL centerLeadingViewVertically;

@property (strong, nonatomic, nullable) UIView *trailingView;
@property (nonatomic, assign) BOOL centerTrailingViewVertically;

@property (strong, nonatomic) id<MDCTypographyScheming> typographyScheme;

/*
 Indicates whether the view's contents should automatically update their font when the device’s
 UIContentSizeCategory changes.
 
 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.
 
 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory;


//- (void)applyTypographyScheme:(id<MDCTypographyScheming>)typographyScheme;




/*
 @property (strong, nonatomic, nullable) UIImage *secondaryImage;
 @property (strong, nonatomic, nullable) UIImage *secondaryPlaceholderImage;
 ^ If nil image occupies no space. Should this be static?
 */



@end
