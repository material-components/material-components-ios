#import <UIKit/UIKit.h>

@class PestoSideView;

@protocol PestoSideViewDelegate <NSObject>

@optional

- (void)sideViewDidSelectSettings:(PestoSideView *)sideView;

@end

@interface PestoSideView : UIView

@property(weak, nonatomic) id<PestoSideViewDelegate> delegate;

- (void)showSideView;

- (void)hideSideView;

@end
