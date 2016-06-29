#import <UIKit/UIKit.h>

#import "MDCOverlayTransitioning.h"

/**
 Object representing a single overlay being displayed on screen.
 */
@interface MDCOverlayObserverOverlay : NSObject <MDCOverlay>

/**
 The unique identifier for the given overlay.
 */
@property(nonatomic, copy) NSString *identifier;

/**
 The frame of the overlay, in screen coordinates.
 */
@property(nonatomic) CGRect frame;

@end
