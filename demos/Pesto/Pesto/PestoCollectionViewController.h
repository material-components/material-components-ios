#import <UIKit/UIKit.h>

#import "MaterialFlexibleHeader.h"
#import "PestoCardCollectionViewCell.h"

@protocol PestoCollectionViewControllerDelegate <NSObject>

@optional

- (void)didSelectCell:(PestoCardCollectionViewCell *)cell completion:(void (^)())completionBlock;

@end

@interface PestoCollectionViewController : UICollectionViewController

@property(weak, nonatomic) id<PestoCollectionViewControllerDelegate> delegate;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) MDCFlexibleHeaderContainerViewController *flexHeaderContainerVC;

@end
