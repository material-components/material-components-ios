#import <UIKit/UIKit.h>

/**
 A simple subclass of UIImageView that can enforce a specific size.

 For iOS 13+ use UIImageSymbolConfiguration instead to create a image with the correct point size
 and weight.
 */
API_DEPRECATED("Use UIImageSymbolConfiguration on iOS 13+", ios(12.0, 13.0))
__attribute__((objc_subclassing_restricted))
@interface MDCChipViewAccessoryView : UIImageView

/**
 The desired size of the UIImageView. Used for @c sizeThatFits: and @c intrinsicContentSize . Has
 no effect if set to @c CGSizeZero .
 */
// NOLINTNEXTLINE
@property(nonatomic, assign) CGSize preferredsize;

@end
