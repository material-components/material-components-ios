/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "MDCMaskedTransition.h"

#import <MotionAnimator/MotionAnimator.h>

#import "private/MDCMaskedPresentationController.h"
#import "private/MDCMaskedTransitionMotionForContext.h"
#import "private/MDCMaskedTransitionMotionSpec.h"

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

@interface MDCMaskedTransition () <MDMTransitionWithPresentation, MDMTransitionWithFeasibility>
@end

@implementation MDCMaskedTransition {
  UIView *_sourceView;
  BOOL _shouldSlideWhenCollapsed;
}

- (instancetype)initWithSourceView:(UIView *)sourceView {
  self = [super init];
  if (self) {
    _sourceView = sourceView;
  }
  return self;
}

- (BOOL)canPerformTransitionWithContext:(__unused id<MDMTransitionContext>)context {
  return _shouldSlideWhenCollapsed ? NO : YES;
}

#pragma mark - MDMTransitionWithPresentation

- (UIModalPresentationStyle)defaultModalPresentationStyle {
  return UIModalPresentationCustom;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(__unused UIViewController *)source {
  MDCMaskedPresentationController *presentationController =
      [[MDCMaskedPresentationController alloc] initWithPresentedViewController:presented
                                                      presentingViewController:presenting
                                                 calculateFrameOfPresentedView:_calculateFrameOfPresentedView];
  presentationController.sourceView = _sourceView;
  return presentationController;
}

- (void)startWithContext:(NSObject<MDMTransitionContext> *)context {
  MDCMaskedTransitionMotionSpecContext spec = MDCMaskedTransitionMotionSpecForContext(context);
  if (context.direction == MDMTransitionDirectionForward) {
    _shouldSlideWhenCollapsed = spec.shouldSlideWhenCollapsed;
  }

  MDMMotionAnimator *animator = [[MDMMotionAnimator alloc] init];
  animator.shouldReverseValues = context.direction == MDMTransitionDirectionBackward;

  // Cache original state.
  // We're going to reparent the fore view, so keep this information for later.
  UIView *originalSuperview = context.foreViewController.view.superview;
  const CGRect originalFrame = context.foreViewController.view.frame;
  UIView *originalSourceSuperview = _sourceView.superview;
  const CGRect originalSourceFrame = _sourceView.frame;
  UIColor *originalSourceBackgroundColor = _sourceView.backgroundColor;

  // Reparent the fore view into a masked view.
  UIView *maskedView = [[UIView alloc] initWithFrame:context.foreViewController.view.frame];
  {
    CGRect reparentedFrame = context.foreViewController.view.frame;
    reparentedFrame.origin = CGPointZero;
    context.foreViewController.view.frame = reparentedFrame;

    maskedView.layer.cornerRadius = context.foreViewController.view.layer.cornerRadius;
    maskedView.clipsToBounds = context.foreViewController.view.clipsToBounds;
  }
  [context.containerView addSubview:maskedView];

  UIView *floodFillView = [[UIView alloc] initWithFrame:context.foreViewController.view.bounds];
  floodFillView.backgroundColor = _sourceView.backgroundColor;

  // TODO(featherless): Profile whether it's more performant to fade the flood fill out or to
  // fade the fore view in (what we're currently doing).
  [maskedView addSubview:floodFillView];
  [maskedView addSubview:context.foreViewController.view];

  // All frames are assumed to be relative to the container view unless named otherwise.
  const CGRect initialSourceFrame = [_sourceView convertRect:_sourceView.bounds
                                                      toView:context.containerView];
  const CGRect finalMaskedFrame = originalFrame;
  CGRect initialMaskedFrame;
  CGPoint corner;
  const CGPoint initialSourceCenter = CenterOfFrame(initialSourceFrame);
  if (spec.isCentered) {
    initialMaskedFrame = FrameCenteredAround(initialSourceCenter, originalFrame.size);
    // Bottom right
    corner = CGPointMake(CGRectGetMaxX(initialMaskedFrame), CGRectGetMaxY(initialMaskedFrame));

  } else {
    initialMaskedFrame = CGRectMake(CGRectGetMinX(context.containerView.bounds),
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
                                                         fromView:context.containerView];

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
    context.foreViewController.view.frame = originalFrame;
    [originalSuperview addSubview:context.foreViewController.view];

    self->_sourceView.frame = originalSourceFrame;
    self->_sourceView.backgroundColor = originalSourceBackgroundColor;
    [originalSourceSuperview addSubview:self->_sourceView];

    [maskedView removeFromSuperview];

    [context transitionDidEnd]; // Hand off back to UIKit
  }];

  MDCMaskedTransitionMotionTiming motion = (context.direction == MDMTransitionDirectionForward) ? spec.expansion : spec.collapse;

  [animator animateWithTiming:motion.iconFade
                      toLayer:_sourceView.layer
                   withValues:@[ @1, @0 ]
                      keyPath:MDMKeyPathOpacity];

  [animator animateWithTiming:motion.contentFade
                      toLayer:context.foreViewController.view.layer
                   withValues:@[ @0, @1 ]
                      keyPath:MDMKeyPathOpacity];

  // TODO(featherless): Support shadow + elevation changes. May need companion transition for this?

  {
    UIColor *initialColor = floodFillView.backgroundColor;
    if (!initialColor) {
      initialColor = [UIColor clearColor];
    }
    UIColor *finalColor = context.foreViewController.view.backgroundColor;
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
    if (context.direction == MDMTransitionDirectionForward) {
      completion = ^{
        // Upon completion of the animation we want all of the content to be visible, so we jump
        // to a full bounds mask.
        shapeLayer.transform = CATransform3DIdentity;
        shapeLayer.path = [[UIBezierPath bezierPathWithRect:context.foreViewController.view.bounds]
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
