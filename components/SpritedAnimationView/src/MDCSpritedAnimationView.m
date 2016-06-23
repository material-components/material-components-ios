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

#import "MDCSpritedAnimationView.h"

#import <QuartzCore/QuartzCore.h>

static NSString *const kSpriteAnimationKey = @"spriteAnimate";
static const NSInteger kSpriteFrameRateDefault = 60;

@interface MDCSpritedAnimationView ()
@property(nonatomic, assign) NSInteger numberOfFrames;
@property(nonatomic, assign) CGFloat singleFrameWidthInPercent;  // 1 / numberOfFrames
@property(nonatomic, strong) CALayer *spriteLayer;
@end

@implementation MDCSpritedAnimationView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [self initWithSpriteSheetImage:nil];
  if (self) {
    self.frame = frame;
  }
  return self;
}

- (instancetype)initWithSpriteSheetImage:(UIImage *)spriteSheetImage {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.userInteractionEnabled = NO;

    _spriteLayer = [CALayer layer];
    _spriteLayer.bounds = self.layer.bounds;
    [self.layer addSublayer:_spriteLayer];

    _frameRate = kSpriteFrameRateDefault;
    _singleFrameWidthInPercent = 1;
    _animationRepeatCount = 1;
    [self setSpriteSheetImage:spriteSheetImage];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect bounds = self.bounds;
  self.spriteLayer.position = CGPointMake(bounds.size.width / 2.f, bounds.size.height / 2.f);
  self.spriteLayer.bounds = self.bounds;
}

- (void)startAnimatingWithCompletion:(void (^)())completion {
  [CATransaction begin];
  [CATransaction setCompletionBlock:completion];

  NSMutableArray <NSValue *> *linearValues = [NSMutableArray array];
  NSMutableArray <NSNumber *> *keyTimes = [NSMutableArray array];
  for (NSInteger i = 0; i < _numberOfFrames; i++) {
    CGRect contentsRect =
        CGRectMake(0, i * _singleFrameWidthInPercent, 1, _singleFrameWidthInPercent);
    [linearValues addObject:[NSValue valueWithCGRect:contentsRect]];
    [keyTimes addObject:@(i * _singleFrameWidthInPercent)];
  }

  CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
  animation.duration = (NSTimeInterval)_numberOfFrames / (NSTimeInterval)_frameRate;
  animation.values = linearValues;
  animation.keyTimes = keyTimes;
  animation.keyPath = NSStringFromSelector(@selector(contentsRect));
  animation.calculationMode = kCAAnimationDiscrete;
  animation.repeatCount = (_animationRepeatCount == 0) ? HUGE_VALF : _animationRepeatCount;
  if (_animationRepeatCount == 1) {
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
  }

  [self.spriteLayer addAnimation:animation forKey:kSpriteAnimationKey];
  [CATransaction commit];
}

- (void)stop {
  // Removing the animation will cause the completion block to be also called.
  [self.spriteLayer removeAnimationForKey:kSpriteAnimationKey];
}

- (void)seekToBeginning {
  self.spriteLayer.contentsRect = CGRectMake(0, 0, 1, _singleFrameWidthInPercent);
  [self.spriteLayer setNeedsDisplay];
}

- (void)seekToEnd {
  self.spriteLayer.contentsRect =
      CGRectMake(0, 1.0f - _singleFrameWidthInPercent, 1, _singleFrameWidthInPercent);
  [self.layer setNeedsDisplay];
}

- (BOOL)isAnimating {
  return ([self.spriteLayer animationForKey:kSpriteAnimationKey] != nil);
}

#pragma mark - Mask Color Handling

- (UIImage *)colorizedSpriteSheet:(UIImage *)spriteSheet {
  if (!_tintColor) {
    return spriteSheet;
  }

  if (!spriteSheet) {
    return spriteSheet;
  }

  CGSize spritesSize = [spriteSheet size];

  UIGraphicsBeginImageContextWithOptions(spritesSize, NO, 0);
  CGContextRef context = UIGraphicsGetCurrentContext();

  // Flip context for CGImageRef drawing.
  CGContextTranslateCTM(context, 0, spritesSize.height);
  CGContextScaleCTM(context, 1.0, -1.0);

  CGRect rect = CGRectMake(0, 0, spritesSize.width, spritesSize.height);

  // Draw original image.
  CGContextSetBlendMode(context, kCGBlendModeNormal);
  CGContextDrawImage(context, rect, spriteSheet.CGImage);

  // Overlay the foreground color based on the alpha of the pixels in the context.
  CGContextSetBlendMode(context, kCGBlendModeSourceIn);
  [_tintColor setFill];
  CGContextFillRect(context, rect);

  UIImage *colorizedSpriteSheet = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return colorizedSpriteSheet;
}

- (void)updateSpriteAnimationLayer {
  CGSize spriteSheetSize = [_spriteSheetImage size];
  CGFloat singleFrameWidth = spriteSheetSize.width;

  CALayer *layer = self.spriteLayer;
  layer.contents = (id)_spriteSheetImage.CGImage;
  layer.bounds = CGRectMake(0, 0, singleFrameWidth, singleFrameWidth);
  layer.contentsRect = CGRectMake(0, 0, 1, _singleFrameWidthInPercent);
}

#pragma mark Setters

- (void)setTintColor:(UIColor *)tintColor {
  if (_tintColor == tintColor) {
    return;
  }

  _tintColor = tintColor;
  _spriteSheetImage = [self colorizedSpriteSheet:_spriteSheetImage];

  [self updateSpriteAnimationLayer];
}

- (void)setSpriteSheetImage:(UIImage *)spriteSheetImage {
  if (!spriteSheetImage) {
    _spriteSheetImage = spriteSheetImage;
    return;
  }

  CGSize spriteSheetSize = [spriteSheetImage size];
  CGFloat singleFrameWidth = spriteSheetSize.width;
  _numberOfFrames = (NSInteger)floor(spriteSheetSize.height / singleFrameWidth);
  _singleFrameWidthInPercent = 1.0f / _numberOfFrames;
  _spriteSheetImage = [self colorizedSpriteSheet:spriteSheetImage];

  [self updateSpriteAnimationLayer];
  [self.spriteLayer removeAllAnimations];
}

@end
