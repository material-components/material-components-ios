#import <UIKit/UIKit.h>

@interface PestoRecipeCardView : UIScrollView

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *iconImageName;
@property(nonatomic, copy) NSString *descText;
@property(nonatomic) UILabel *titleLabel;

@end
