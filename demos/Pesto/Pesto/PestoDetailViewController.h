#import <UIKit/UIKit.h>

@interface PestoDetailViewController : UIViewController

@property(nonatomic) UIImage *image;
@property(nonatomic, copy) NSString *iconImageName;
@property(nonatomic, copy) NSString *descText;

- (void)loadImage;

@end
