#import <UIKit/UIKit.h>

@class MDCSnackbarMessageView;

/** The identifier reported for the snackbar. */
OBJC_EXTERN NSString *const MDCSnackbarOverlayIdentifier;

/**
 Custom overlay view for displaying snackbars.
 */
@interface MDCSnackbarOverlayView : UIView

/**
 Designated initializer.

 Creates an overlay view which utilizes @c watcher to get its keyboard position information.
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 Shows the snackbar view with the most appropriate animation.

 @param snackbarView The snackbar view to display.
 @param animated Whether or not the show should be animated.
 @param completion A block to execute when the presentation is finished.
 */
- (void)showSnackbarView:(MDCSnackbarMessageView *)snackbarView
                animated:(BOOL)animated
              completion:(void (^)(void))completion;

/**
 Dismisses the currently showing snackbar view.

 @param animated Whether or not the dismiss should be animated.
 @param completion A block to execute when the dismissal is finished.
 */
- (void)dismissSnackbarViewAnimated:(BOOL)animated completion:(void (^)(void))completion;

/**
 How far from the bottom of the screen should snackbars be presented.

 If set inside of an animation block, the change will animate.
 */
@property(nonatomic) CGFloat bottomOffset;

@end
