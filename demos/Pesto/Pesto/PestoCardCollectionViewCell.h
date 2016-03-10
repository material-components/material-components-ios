#import <UIKit/UIKit.h>

#import "MaterialInk.h"

@interface PestoCardCollectionViewCell : UICollectionViewCell <MDCInkTouchControllerDelegate>

@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) NSString *title;
@property(nonatomic) UIImage *image;

- (void)populateContentWithTitle:(NSString *)title
                          author:(NSString *)author
                        imageURL:(NSURL *)imageURL
                        iconName:(NSString *)iconName;

@end
