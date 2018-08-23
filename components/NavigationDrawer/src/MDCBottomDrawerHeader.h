#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A protocol view controllers should conform to for enabling the view controller to be
 * used as a drawer header view controller.
 */
@protocol MDCBottomDrawerHeader

/**
 * The drawer header transition to top ratio: zero represents the drawer being
 * fully displayed as part of the content, one represents the drawer being fully
 * displayed as a top header.
 */
- (void)updateDrawerHeaderTransitionRatio:(CGFloat)transitionToTopRatio;

@end

NS_ASSUME_NONNULL_END
