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

@property (nonatomic, copy, nullable) NSString *titleText;
@property (nonatomic, assign) NSInteger titleTextNumberOfLines;
@property (nonatomic, copy, nullable) NSString *detailsText;
@property (nonatomic, assign) NSInteger detailTextNumberOfLines;

@property (strong, nonatomic, nullable) UIControl *control;
@property (strong, nonatomic, nullable) UIImage *image;
@property (nonatomic, assign) MDCListItemCellImageDisplayMode imageDisplayMode;

@property (strong, nonatomic, nullable) UIImage *placeholderImage;

/*
 @property (strong, nonatomic, nullable) UIImage *secondaryImage;
 @property (strong, nonatomic, nullable) UIImage *secondaryPlaceholderImage;
 ^ If nil image occupies no space. Should this be static?
 */



@end
