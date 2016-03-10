#import <UIKit/UIKit.h>

#import "MaterialInk.h"

@interface PestoCardCollectionViewCell : UICollectionViewCell <MDCInkTouchControllerDelegate>

@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) NSString *author;
@property(nonatomic) NSString *icon;
@property(nonatomic) NSString *imageURL;
@property(nonatomic) NSString *title;
@property(nonatomic) UIImage *image;
@property(nonatomic) UIImageView *imageView;

@end
