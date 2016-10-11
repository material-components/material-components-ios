//
//  MDCFeatureHighlightAnimationController.h
//  Pods
//
//  Created by Sam Morrison on 10/10/16.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  MDCFeatureHighlightDismissAccepted,
  MDCFeatureHighlightDismissRejected,
} MDCFeatureHighlightDismissStyle;

@interface MDCFeatureHighlightAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) MDCFeatureHighlightDismissStyle dismissStyle;
@property (nonatomic, assign, getter=isPresenting) BOOL presenting;

@end
