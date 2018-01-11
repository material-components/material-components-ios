//
//  MDCCards.h
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/8/18.
//

#import <UIKit/UIKit.h>
#import "MaterialShadowLayer.h"
#import "MaterialInk.h"

typedef NS_ENUM(NSInteger, MDCCardsState) {
  MDCCardsStateDefault,
  MDCCardsStatePressed,
  MDCCardsStateSelected
};

@interface MDCCard : UIControl

- (nonnull instancetype)initWithFrame:(CGRect)frame withIsUsingCollectionViewCell:(BOOL)isUsingCell;

- (void)setCornerRadius:(CGFloat)cornerRadius;
- (CGFloat)cornerRadius;

- (void)setShadowElevation:(CGFloat)elevation;
- (CGFloat)shadowElevation;

- (void)styleForState:(MDCCardsState)state withLocation:(CGPoint)location;

@property(nonatomic, strong, nullable) MDCInkView *inkView;
@property(nonatomic, assign) BOOL longPress;
@property(nonatomic, strong, nonnull) UIImageView *selectedImageView;
@property(nonatomic, assign) BOOL editMode;

@end
