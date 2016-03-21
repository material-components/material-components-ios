#import <UIKit/UIKit.h>

@interface PestoDetailViewController : UIViewController

@property(nonatomic) UIImage *image;
@property(nonatomic) NSString *iconImageName;
@property(nonatomic) NSString *descText;

- (void)loadImage;

@end
