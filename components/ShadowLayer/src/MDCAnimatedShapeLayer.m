/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCAnimatedShapeLayer.h"

@interface MDCPendingAnimation : NSObject <CAAction>
@property(nonatomic, strong) NSString *keyPath;
@property(nonatomic, strong) CAAnimation *animation;
@end

@implementation MDCAnimatedShapeLayer

- (id<CAAction>)actionForKey:(NSString *)key {
  if ([key isEqualToString:@"path"]) {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
    animation.fromValue = CFBridgingRelease(CGPathCreateCopy(self.presentationLayer.path));

    MDCPendingAnimation *pendingAnim = [[MDCPendingAnimation alloc] init];
    pendingAnim.animation = animation;

    return pendingAnim;
  } else if ([key isEqualToString:@"shadowPath"]) {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
    animation.fromValue = CFBridgingRelease(CGPathCreateCopy(self.presentationLayer.shadowPath));

    MDCPendingAnimation *pendingAnim = [[MDCPendingAnimation alloc] init];
    pendingAnim.animation = animation;

    return pendingAnim;
  }
  return [super actionForKey:key];
}

@end

@implementation MDCPendingAnimation

- (void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict {
  if ([anObject isKindOfClass:[MDCAnimatedShapeLayer class]]) {
    MDCAnimatedShapeLayer *layer = (MDCAnimatedShapeLayer *)anObject;

    CALayer *animatedLayer = layer.animationParentLayer;
    CAAnimation *boundsAction = [animatedLayer animationForKey:@"bounds.size"];
    if ([boundsAction isKindOfClass:[CABasicAnimation class]]) {
      [self configureAnimation:(CABasicAnimation *)boundsAction];
    }

    [layer addAnimation:self.animation forKey:event];
  }
}

- (void)configureAnimation:(CAAnimation *)template {
  self.animation.autoreverses = template.autoreverses;
  self.animation.beginTime = template.beginTime;
  self.animation.delegate = template.delegate;
  self.animation.duration = template.duration;
  self.animation.fillMode = template.fillMode;
  self.animation.repeatCount = template.repeatCount;
  self.animation.repeatDuration = template.repeatDuration;
  self.animation.speed = template.speed;
  self.animation.timingFunction = template.timingFunction;
  self.animation.timeOffset = template.timeOffset;
}

@end
