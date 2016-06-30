#import <UIKit/UIKit.h>

#import "MDCOverlayTransitioning.h"

/**
 Object representing the a transition between overlays on screen.
 */
@interface MDCOverlayObserverTransition : NSObject <MDCOverlayTransitioning>

/**
 If animated, the timing function of the transition animation.
 */
@property(nonatomic) CAMediaTimingFunction *customTimingFunction;

/**
 If animated, the curve of the transition animation.
 */
@property(nonatomic) UIViewAnimationCurve animationCurve;

/**
 If animated, the duration of the transition animation.
 */
@property(nonatomic) NSTimeInterval duration;

/**
 The overlays represented by this transition.
 */
@property(nonatomic, copy) NSArray *overlays;

/**
 Sets up an animation block (or none) and executes all of the animation blocks registered as part
 of the MDCOverlayTransitioning protocol.
 */
- (void)runAnimation;

@end
