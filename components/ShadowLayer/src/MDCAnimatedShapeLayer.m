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

#if TARGET_IPHONE_SIMULATOR
UIKIT_EXTERN float UIAnimationDragCoefficient(void); // UIKit private drag coefficient.
#endif

static inline float MDCSimulatorAnimationDragCoefficient(void) {
#if TARGET_IPHONE_SIMULATOR
  return UIAnimationDragCoefficient();
#else
  return 1.0f;
#endif
}

@interface MDCPendingAnimation : NSObject <CAAction>
@property(nonatomic, strong) NSString *keyPath;
@property(nonatomic, strong) CAAnimation *animation;
@end

static CGFloat MDCAnimatedShapeLayerDuration = 0;

@implementation MDCAnimatedShapeLayer

+ (CGFloat)duration {
  return MDCAnimatedShapeLayerDuration;
}

+ (void)setDuration:(CFTimeInterval)duration {
  MDCAnimatedShapeLayerDuration = duration;
}

- (id<CAAction>)actionForKey:(NSString *)key {
  if ([key isEqualToString:@"path"]) {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
    animation.fromValue = CFBridgingRelease(CGPathCreateCopy(self.presentationLayer.path));

//    id<CAAction, NSObject> boundsAction = (id<CAAction, NSObject>)[super actionForKey:@"bounds"];


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
  self.animation.speed = template.speed / MDCSimulatorAnimationDragCoefficient();
  self.animation.timingFunction = template.timingFunction;
  self.animation.timeOffset = template.timeOffset;
}

@end
