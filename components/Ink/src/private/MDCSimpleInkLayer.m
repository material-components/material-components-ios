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

#import "MDCSimpleInkLayer.h"

@implementation MDCSimpleInkLayer

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.initialRadius = (sqrt(frame.size.height * frame.size.height +
                             frame.size.width * frame.size.width) / 2) * 0.6;
  self.finalRadius = sqrt(frame.size.height * frame.size.height +
                          frame.size.width * frame.size.width) / 2 + 10;
}

- (void)start:(CGPoint)point {
  CGFloat radius = self.finalRadius;
  CGRect ovalRect = CGRectMake(self.frame.size.width / 2 - radius,
                               self.frame.size.height / 2 - radius,
                               radius * 2,
                               radius * 2);
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
  self.path = circlePath.CGPath;
  self.fillColor = self.inkColor.CGColor;
  self.opacity = 0;
  self.position = point;
  [self startAnim:point];
}

- (void)end {
  [self endAnim];
}

- (void)startAnim:(CGPoint)point {
  self.startAnimActive = YES;

  CAKeyframeAnimation *scaleAnim = [[CAKeyframeAnimation alloc] init];
  [scaleAnim setKeyPath:@"transform.scale"];
  scaleAnim.keyTimes = @[ @0, @1.0 ];
  scaleAnim.values = @[ @0.6, @1.0 ];
  scaleAnim.duration = 0.333f;
  scaleAnim.beginTime = 0.083f;
  scaleAnim.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.4:0:0.2:1];
  scaleAnim.fillMode = kCAFillModeForwards;
  scaleAnim.removedOnCompletion = NO;
  
  UIBezierPath *centerPath = [UIBezierPath bezierPath];
  CGPoint startPoint = point;
  CGPoint endPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
  [centerPath moveToPoint:startPoint];
  [centerPath addLineToPoint:endPoint];
  [centerPath closePath];

  CAKeyframeAnimation *positionAnim = [[CAKeyframeAnimation alloc] init];
  [positionAnim setKeyPath:@"position"];
  positionAnim.path = centerPath.CGPath;
  positionAnim.keyTimes = @[ @0, @1.0 ];
  positionAnim.values = @[ @0, @1.0 ];
  positionAnim.duration = 0.333f;
  positionAnim.beginTime = 0.083f;
  positionAnim.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.4:0:0.2:1];
  positionAnim.fillMode = kCAFillModeForwards;
  positionAnim.removedOnCompletion = NO;

  CAKeyframeAnimation *fadeInAnim = [[CAKeyframeAnimation alloc] init];
  [fadeInAnim setKeyPath:@"opacity"];
  fadeInAnim.keyTimes = @[ @0, @1.0 ];
  fadeInAnim.values = @[ @0, @1.0 ];
  fadeInAnim.duration = 0.083f;
  fadeInAnim.beginTime = 0.083f;
  fadeInAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeInAnim.fillMode = kCAFillModeForwards;
  fadeInAnim.removedOnCompletion = NO;
  
  CAKeyframeAnimation *fadeHalfAnim = [[CAKeyframeAnimation alloc] init];
  [fadeHalfAnim setKeyPath:@"opacity"];
  fadeHalfAnim.keyTimes = @[ @0, @1.0 ];
  fadeHalfAnim.values = @[ @1.0, @0.5 ];
  fadeHalfAnim.duration = 0.25f;
  fadeHalfAnim.beginTime = 0.167f;
  fadeHalfAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  fadeHalfAnim.fillMode = kCAFillModeForwards;
  fadeHalfAnim.removedOnCompletion = NO;
  
  [CATransaction begin];
  CAAnimationGroup *animGroup = [[CAAnimationGroup alloc] init];
  animGroup.animations = @[ scaleAnim, positionAnim, fadeInAnim, fadeHalfAnim ];
  animGroup.duration = 0.5f;
  animGroup.fillMode = kCAFillModeForwards;
  animGroup.removedOnCompletion = NO;
  [CATransaction setCompletionBlock:^{
    self.startAnimActive = NO;
  }];
  [self addAnimation:animGroup forKey:nil];
  [CATransaction commit];
}

- (void)endAnim {
  if (self.startAnimActive) {
    self.endAnimDelay = 0.25f;
  }
  
//  var currOpacity = (presentation()?.value(forKeyPath: "opacity") as AnyObject).doubleValue
//  if (currOpacity < 0.5) {
//    currOpacity = 0.5
//  } else if (currOpacity == 0.0) {
//    currOpacity = 1.0
//  }
//
//  let fadeOutAnim = CAKeyframeAnimation(keyPath: "opacity")
//  fadeOutAnim.keyTimes = [ 0, 1.0 ]
//  fadeOutAnim.values = [ currOpacity!, 0 ]
//  fadeOutAnim.duration = 0.25
//  fadeOutAnim.beginTime = CACurrentMediaTime() + endAnimDelay
//  fadeOutAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//  fadeOutAnim.fillMode = kCAFillModeForwards
//  fadeOutAnim.isRemovedOnCompletion = false
//  add(fadeOutAnim, forKey: nil)
}

@end
