//
//  MDCCollectionViewCardCell.h
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/8/18.
//

#import <UIKit/UIKit.h>
#import "MDCCard.h"

typedef NS_ENUM(NSInteger, MDCCardCellSelectionState) {
  MDCCardCellSelectionStateSelect,
  MDCCardCellSelectionStateSelected,
  MDCCardCellSelectionStateUnselect,
  MDCCardCellSelectionStateUnselected
};

@interface MDCCollectionViewCardCell : UICollectionViewCell

@property(nonatomic, strong, nullable) MDCCard *cardView;
@property(nonatomic, assign) BOOL editMode;

- (void)setBackgroundColor:(nullable UIColor *)backgroundColor;
- (nullable UIColor *)backgroundColor;

- (void)setCornerRadius:(CGFloat)cornerRadius;
- (CGFloat)cornerRadius;

- (void)setShadowElevation:(CGFloat)elevation;
- (CGFloat)shadowElevation;

- (void)selectionState:(MDCCardCellSelectionState)state;

@end
