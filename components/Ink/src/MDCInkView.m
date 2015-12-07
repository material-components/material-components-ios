/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MDCInkView.h"

#import "private/MDCInkLayer.h"

@interface MDCInkView ()
@property(nonatomic, readonly) MDCInkLayer *inkLayer;
@end

@implementation MDCInkView

+ (Class)layerClass {
  return [MDCInkLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  self.userInteractionEnabled = NO;
  self.backgroundColor = [UIColor clearColor];
  self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)setGravitatesInk:(BOOL)gravitatesInk {
  self.inkLayer.gravitatesInk = gravitatesInk;
}

- (BOOL)gravitatesInk {
  return self.inkLayer.gravitatesInk;
}

- (void)setFillsBackgroundOnSpread:(BOOL)shouldFill {
  self.inkLayer.shouldFillBackgroundOnSpread = shouldFill;
}

- (BOOL)fillsBackgroundOnSpread {
  return self.inkLayer.shouldFillBackgroundOnSpread;
}

- (void)setClipsRippleToBounds:(BOOL)clipsRippleToBounds {
  self.inkLayer.masksToBounds = clipsRippleToBounds;
}

- (BOOL)clipsRippleToBounds {
  return self.inkLayer.masksToBounds;
}

- (void)setInkColor:(UIColor *)inkColor {
  self.inkLayer.inkColor = inkColor;
}

- (UIColor *)inkColor {
  return self.inkLayer.inkColor;
}

- (CGFloat)maxRippleRadius {
  return self.inkLayer.maxRippleRadius;
}

- (void)setMaxRippleRadius:(CGFloat)radius {
  self.inkLayer.maxRippleRadius = radius;
}

- (BOOL)usesCustomInkCenter {
  return self.inkLayer.useCustomInkCenter;
}

- (void)setUsesCustomInkCenter:(BOOL)usesCustomInkCenter {
  self.inkLayer.useCustomInkCenter = usesCustomInkCenter;
}

- (CGPoint)customInkCenter {
  return self.inkLayer.customInkCenter;
}

- (void)setCustomInkCenter:(CGPoint)customInkCenter {
  self.inkLayer.customInkCenter = customInkCenter;
}

- (MDCInkLayer *)inkLayer {
  return (MDCInkLayer *)self.layer;
}

- (void)reset {
  [self.inkLayer reset];
}

- (void)spreadFromPoint:(CGPoint)point completion:(nullable MDCInkCompletionBlock)completionBlock {
  [self.inkLayer spreadFromPoint:point completion:completionBlock];
}

- (void)evaporateWithCompletion:(MDCInkCompletionBlock)completionBlock {
  [self.inkLayer evaporateWithCompletion:completionBlock];
}

- (void)evaporateToPoint:(CGPoint)point completion:(MDCInkCompletionBlock)completionBlock {
  [self.inkLayer evaporateToPoint:point completion:completionBlock];
}

@end
