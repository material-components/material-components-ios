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

#import "MDCSpritedAnimationView.h"

#import <QuartzCore/QuartzCore.h>

static NSString *const kSpriteAnimationKey = @"spriteAnimate";
static const NSInteger kSpriteFrameRateDefault = 60;

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface MDCSpritedAnimationView () <CAAnimationDelegate>
@end
#endif

@interface MDCSpritedAnimationView ()
@property(nonatomic, copy) void (^pendingCompletionBlock)(BOOL finished);
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

- (instancetype)initWithSpriteSheetImage:(UIImage *)spriteSheetImage
                          numberOfFrames:(NSInteger)numberOfFrames {
  MDCSpritedAnimationView *animationView = [self initWithSpriteSheetImage:spriteSheetImage];
  animationView.numberOfFrames = numberOfFrames;
  animationView.singleFrameWidthInPercent = 1.0f / numberOfFrames;
  [animationView updateSpriteAnimationLayer];

  return animationView;
}

- (CGSize)intrinsicContentSize {
  if (_spriteSheetImage) {
    CGFloat width = _spriteSheetImage.size.width;
    return CGSizeMake(width, width);
  }
  return [super intrinsicContentSize];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect bounds = self.bounds;
  self.spriteLayer.position = CGPointMake(bounds.size.width / 2.f, bounds.size.height / 2.f);
  self.spriteLayer.bounds = self.bounds;
}

- (void)startAnimatingWithCompletion:(void (^)(BOOL finished))completion {
  [self stop];

  self.pendingCompletionBlock = completion;

  NSMutableArray<NSValue *> *linearValues = [NSMutableArray array];
  NSMutableArray<NSNumber *> *keyTimes = [NSMutableArray array];
  for (NSInteger i = 0; i < _numberOfFrames; i++) {
    CGRect contentsRect =
        CGRectMake(0, i * _singleFrameWidthInPercent, 1, _singleFrameWidthInPercent);
    [linearValues addObject:[NSValue valueWithCGRect:contentsRect]];
    [keyTimes addObject:@(i * _singleFrameWidthInPercent)];
  }

  CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
  animation.delegate = self;
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
}

- (void)stop {
  // Removing the animation will trigger |animationDidStop| and therefore the completion block, but
  // there is no guarantee it happens atomically so to ensure predictable call-order we manually
  // trigger the completion block here.
  void (^block)(BOOL cancelled) = self.pendingCompletionBlock;
  self.pendingCompletionBlock = nil;

  if (block) {
    block(NO);
  }
  [self.spriteLayer removeAnimationForKey:kSpriteAnimationKey];
}

- (void)seekToBeginning {
  [self stop];
  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  self.spriteLayer.contentsRect = CGRectMake(0, 0, 1, _singleFrameWidthInPercent);
  [CATransaction commit];
  [self.spriteLayer setNeedsDisplay];
}

- (void)seekToEnd {
  [self stop];
  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  self.spriteLayer.contentsRect =
      CGRectMake(0, 1.0f - _singleFrameWidthInPercent, 1, _singleFrameWidthInPercent);
  [CATransaction commit];
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

  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  // Disable implicit animations for these assignments
  CALayer *layer = self.spriteLayer;
  layer.contents = (id)_spriteSheetImage.CGImage;
  layer.bounds = CGRectMake(0, 0, singleFrameWidth, singleFrameWidth);
  layer.contentsRect = CGRectMake(0, 0, 1, _singleFrameWidthInPercent);
  [CATransaction commit];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished {
  if (anim != [self.spriteLayer animationForKey:kSpriteAnimationKey]) {
    return;
  }
  void (^block)(BOOL cancelled) = self.pendingCompletionBlock;
  self.pendingCompletionBlock = nil;

  if (block) {
    block(finished);
  }
}

#pragma mark - Setters

- (void)setTintColor:(UIColor *)tintColor {
  if (_tintColor == tintColor) {
    return;
  }

  _tintColor = tintColor;
  _spriteSheetImage = [self colorizedSpriteSheet:_spriteSheetImage];

  [self updateSpriteAnimationLayer];
}

- (void)setSpriteSheetImage:(UIImage *)spriteSheetImage {
  [self stop];
  if (!spriteSheetImage) {
    _spriteSheetImage = spriteSheetImage;
    return;
  }

  CGSize spriteSheetSize = [spriteSheetImage size];
  CGFloat singleFrameWidth = spriteSheetSize.width;
  _numberOfFrames = (NSInteger)floor(spriteSheetSize.height / singleFrameWidth);
  _singleFrameWidthInPercent = 1.0f / _numberOfFrames;
  _spriteSheetImage = [self colorizedSpriteSheet:spriteSheetImage];
  [self invalidateIntrinsicContentSize];
  [self updateSpriteAnimationLayer];
}

@end
