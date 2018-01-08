//
//  MDCCards.h
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/8/18.
//

#import <UIKit/UIKit.h>
#import "MaterialShadowLayer.h"
#import "MaterialInk.h"

@interface MDCCard : UIView

- (nonnull instancetype)initWithFrame:(CGRect)frame withIsUsingCollectionViewCell:(BOOL)isUsingCell;

- (void)setCornerRadius:(CGFloat)cornerRadius;
- (CGFloat)cornerRadius;

- (void)setShadowElevation:(CGFloat)elevation;
- (CGFloat)shadowElevation;

@property(nonatomic, strong, nullable) MDCInkView *inkView;

@end
