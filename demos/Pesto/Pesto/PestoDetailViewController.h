#import <UIKit/UIKit.h>

@interface PestoDetailViewController : UIViewController

@property (nonatomic) NSString *imageURL;
@property (nonatomic) UIImage *image;

- (void)loadImage;

@end
