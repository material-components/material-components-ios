// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "MDCMaskedTransition.h"

#import <MotionAnimator/MotionAnimator.h>

#import "MDCMaskedPresentationController.h"
#import "MDCMaskedTransitionMotionForContext.h"
#import "MDCMaskedTransitionMotionSpecs.h"

// Math utilities

static inline CGPoint CenterOfFrame(CGRect frame) {
  return CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
}

static inline CGPoint AnchorPointFromPosition(CGPoint position, CGRect bounds) {
  return CGPointMake(position.x / CGRectGetWidth(bounds), position.y / CGRectGetHeight(bounds));
}

static inline CGRect FrameCenteredAround(CGPoint position, CGSize size) {
  return CGRectMake(position.x - size.width / 2,
                    position.y - size.height / 2,
                    size.width,
                    size.height);
}

static inline CGFloat LengthOfVector(CGVector vector) {
  return (CGFloat)hypot(vector.dx, vector.dy);
}

// TODO: Pull this out to MotionTransitioning.
static void
PrepareTransitionWithContext(id<UIViewControllerContextTransitioning> transitionContext,
                             MDMTransitionDirection direction) {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  if (fromView == nil) {
    fromView = fromViewController.view;
  }
  if (fromView != nil && fromView == fromViewController.view) {
    CGRect finalFrame = [transitionContext finalFrameForViewController:fromViewController];
    if (!CGRectIsEmpty(finalFrame)) {
      fromView.frame = finalFrame;
    }
  }

  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  if (toView == nil) {
    toView = toViewController.view;
  }
  if (toView != nil && toView == toViewController.view) {
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    if (!CGRectIsEmpty(finalFrame)) {
      toView.frame = finalFrame;
    }

    if (toView.superview == nil) {
      switch (direction) {
        case MDMTransitionDirectionForward:
          [transitionContext.containerView addSubview:toView];
          break;

        case MDMTransitionDirectionBackward:
          [transitionContext.containerView insertSubview:toView atIndex:0];
          break;
      }
    }
  }
}

// TODO: Pull this out to MotionTransitioning.
static NSArray <UIViewController *> *
OrderedViewControllersWithTransitionContext(id<UIViewControllerContextTransitioning> transitionContext,
                                            MDMTransitionDirection direction) {
  
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

  if (direction == MDMTransitionDirectionForward) {
    return @[fromViewController, toViewController];
  } else {
    return @[toViewController, fromViewController];
  }
}

@implementation MDCMaskedTransition {
  UIView *_sourceView;
  CGFloat _initialSourceViewAlpha;
  MDMTransitionDirection _direction;
}

- (instancetype)initWithSourceView:(UIView *)sourceView
                         direction:(MDMTransitionDirection)direction {
  self = [super init];
  if (self) {
    _sourceView = sourceView;
    _direction = direction;
  }
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  NSArray<UIViewController *> *viewControllers =
      OrderedViewControllersWithTransitionContext(transitionContext, _direction);
  NSAssert([viewControllers count] == 2,
           @"Expected two view controllers to be involved in a transition.");
  if ([viewControllers count] != 2) {
    return 0;
  }
  UIViewController *presentedViewController = viewControllers[1];
  MDCMaskedTransitionMotionSpec motionSpecification =
      MDCMaskedTransitionMotionSpecForContext(transitionContext.containerView,
                                              presentedViewController);

  MDCMaskedTransitionMotionTiming motion = ((_direction == MDMTransitionDirectionForward)
                                            ? motionSpecification.expansion
                                            : motionSpecification.collapse);

  return motion.overallDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  PrepareTransitionWithContext(transitionContext, _direction);
  NSArray<UIViewController *> *viewControllers =
      OrderedViewControllersWithTransitionContext(transitionContext, _direction);
  NSAssert([viewControllers count] == 2,
           @"Expected two view controllers to be involved in a transition.");
  if ([viewControllers count] != 2) {
    [transitionContext completeTransition:YES];
    return;
  }
  UIViewController *presentedViewController = viewControllers[1];

  MDCMaskedTransitionMotionSpec motionSpecification =
      MDCMaskedTransitionMotionSpecForContext(transitionContext.containerView,
                                              presentedViewController);

  // Cache original state.
  // We're going to reparent the fore view, so keep this information for later.
  UIView *originalSuperview = presentedViewController.view.superview;
  const CGRect originalFrame = presentedViewController.view.frame;
  UIView *originalSourceSuperview = _sourceView.superview;
  const CGRect originalSourceFrame = _sourceView.frame;
  UIColor *originalSourceBackgroundColor = _sourceView.backgroundColor;

  // Reparent the fore view into a masked view.
  UIView *maskedView = [[UIView alloc] initWithFrame:presentedViewController.view.frame];
  {
    CGRect reparentedFrame = presentedViewController.view.frame;
    reparentedFrame.origin = CGPointZero;
    presentedViewController.view.frame = reparentedFrame;

    maskedView.layer.cornerRadius = presentedViewController.view.layer.cornerRadius;
    maskedView.clipsToBounds = presentedViewController.view.clipsToBounds;
  }
  [transitionContext.containerView addSubview:maskedView];

  UIView *floodFillView = [[UIView alloc] initWithFrame:presentedViewController.view.bounds];
  floodFillView.backgroundColor = _sourceView.backgroundColor;

  // TODO(featherless): Profile whether it's more performant to fade the flood fill out or to
  // fade the fore view in (what we're currently doing).
  [maskedView addSubview:floodFillView];
  [maskedView addSubview:presentedViewController.view];

  // All frames are assumed to be relative to the container view unless named otherwise.
  const CGRect initialSourceFrame = [_sourceView convertRect:_sourceView.bounds
                                                      toView:transitionContext.containerView];
  const CGRect finalMaskedFrame = originalFrame;
  CGRect initialMaskedFrame;
  CGPoint corner;
  const CGPoint initialSourceCenter = CenterOfFrame(initialSourceFrame);
  if (motionSpecification.isCentered) {
    initialMaskedFrame = FrameCenteredAround(initialSourceCenter, originalFrame.size);
    // Bottom right
    corner = CGPointMake(CGRectGetMaxX(initialMaskedFrame), CGRectGetMaxY(initialMaskedFrame));

  } else {
    initialMaskedFrame = CGRectMake(CGRectGetMinX(transitionContext.containerView.bounds),
                                    CGRectGetMinY(initialSourceFrame) - 20,
                                    CGRectGetWidth(originalFrame),
                                    CGRectGetHeight(originalFrame));
    if (CGRectGetMidX(initialSourceFrame) < CGRectGetMidX(initialMaskedFrame)) {
      // Middle-right
      corner = CGPointMake(CGRectGetMaxX(initialMaskedFrame), CGRectGetMidY(initialMaskedFrame));
    } else {
      // Middle-left
      corner = CGPointMake(CGRectGetMinX(initialMaskedFrame), CGRectGetMidY(initialMaskedFrame));
    }
  }

  maskedView.frame = initialMaskedFrame;
  const CGRect initialSourceFrameInMask = [maskedView convertRect:initialSourceFrame
                                                         fromView:transitionContext.containerView];

  const CGFloat initialRadius = CGRectGetWidth(_sourceView.bounds) / 2;
  const CGFloat finalRadius = LengthOfVector(CGVectorMake(initialSourceCenter.x - corner.x,
                                                          initialSourceCenter.y - corner.y));
  const CGFloat finalScale = finalRadius / initialRadius;

  CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
  {
    // Ensures that we transform from the center of the source view's frame.
    shapeLayer.anchorPoint = AnchorPointFromPosition(CenterOfFrame(initialSourceFrameInMask),
                                                     maskedView.layer.bounds);
    shapeLayer.frame = maskedView.layer.bounds;
    shapeLayer.path = [[UIBezierPath bezierPathWithOvalInRect:initialSourceFrameInMask] CGPath];
  }
  maskedView.layer.mask = shapeLayer;

  _sourceView.frame = initialSourceFrameInMask;
  _sourceView.backgroundColor = nil;
  [maskedView addSubview:_sourceView];

  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    presentedViewController.view.frame = originalFrame;
    [originalSuperview addSubview:presentedViewController.view];

    self->_sourceView.frame = originalSourceFrame;
    self->_sourceView.backgroundColor = originalSourceBackgroundColor;
    if (motionSpecification.shouldSlideWhenCollapsed
        && transitionContext.presentationStyle != UIModalPresentationCustom) {
      // If we're going to slide when collapsed then this transition won't be invoked. If we also
      // don't have a presentation controller (because of the presentation style) then we need to
      // restore the source view's visibility somehow. This is the only place I could think of to
      // do so, but it unfortunately means if the presented view controller is somehow presented
      // such that the source view is still visible then the source view will appear to flash back
      // into existence at the end of the transition, breaking the illusion of continuity.
      self->_sourceView.alpha = 1;
    }
    [originalSourceSuperview addSubview:self->_sourceView];

    [maskedView removeFromSuperview];

    [transitionContext completeTransition:YES]; // Hand off back to UIKit
  }];

  MDCMaskedTransitionMotionTiming motion = ((_direction == MDMTransitionDirectionForward)
                                            ? motionSpecification.expansion
                                            : motionSpecification.collapse);

  MDMMotionAnimator *animator = [[MDMMotionAnimator alloc] init];
  animator.shouldReverseValues = _direction == MDMTransitionDirectionBackward;

  if (_direction == MDMTransitionDirectionForward) {
    _initialSourceViewAlpha = _sourceView.alpha;
  }

  [animator animateWithTiming:motion.iconFade
                      toLayer:_sourceView.layer
                   withValues:@[ @(_initialSourceViewAlpha), @0 ]
                      keyPath:MDMKeyPathOpacity];

  [animator animateWithTiming:motion.contentFade
                      toLayer:presentedViewController.view.layer
                   withValues:@[ @0, @1 ]
                      keyPath:MDMKeyPathOpacity];

  // TODO(featherless): Support shadow + elevation changes. May need companion transition for this?

  {
    UIColor *initialColor = floodFillView.backgroundColor;
    if (!initialColor) {
      initialColor = [UIColor clearColor];
    }
    UIColor *finalColor = presentedViewController.view.backgroundColor;
    if (!finalColor) {
      finalColor = [UIColor whiteColor];
    }
    [animator animateWithTiming:motion.floodBackgroundColor
                        toLayer:floodFillView.layer
                     withValues:@[ initialColor, finalColor ]
                        keyPath:MDMKeyPathBackgroundColor];
  }

  {
    void (^completion)(void) = nil;
    if (_direction == MDMTransitionDirectionForward) {
      completion = ^{
        // Upon completion of the animation we want all of the content to be visible, so we jump
        // to a full bounds mask.
        shapeLayer.transform = CATransform3DIdentity;
        shapeLayer.path = [[UIBezierPath bezierPathWithRect:presentedViewController.view.bounds]
                           CGPath];
      };
    }
    [animator animateWithTiming:motion.maskTransformation
                        toLayer:shapeLayer
                     withValues:@[ @1, @(finalScale) ]
                        keyPath:MDMKeyPathScale
                     completion:completion];
  }

  [animator animateWithTiming:motion.horizontalMovement
                      toLayer:maskedView.layer
                   withValues:@[ @(CGRectGetMidX(initialMaskedFrame)),
                                 @(CGRectGetMidX(finalMaskedFrame)) ]
                      keyPath:MDMKeyPathX];

  [animator animateWithTiming:motion.verticalMovement
                      toLayer:maskedView.layer
                   withValues:@[ @(CGRectGetMidY(initialMaskedFrame)),
                                 @(CGRectGetMidY(finalMaskedFrame)) ]
                      keyPath:MDMKeyPathY];

  [CATransaction commit];
}

@end
