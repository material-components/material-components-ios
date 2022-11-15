// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCProgressLayerView.h"

NS_ASSUME_NONNULL_BEGIN

/** The duration of each individual layer animation. */
static const CGFloat kProgressIntervalDuration = 0.667;

/** The delay between each individual layer animation. */
static const CGFloat kProgressIntervalDelay = 0.333;

@interface MDCProgressLayerView () <CAAnimationDelegate>

@property(nonatomic, readwrite) BOOL isAnimating;
@property(nonatomic, readwrite) NSUInteger sequenceCounter;
@property(nonatomic, readwrite) NSMutableArray<CALayer *> *animatableLayers;
@end

@implementation MDCProgressLayerView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCMulticoloredProgressViewInit];
  }
  return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCMulticoloredProgressViewInit];
  }
  return self;
}

- (void)commonMDCMulticoloredProgressViewInit {
  _animatableLayers = [[NSMutableArray alloc] init];

  self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  self.layer.backgroundColor = UIColor.clearColor.CGColor;
  self.clipsToBounds = YES;
}

#pragma mark - Public

- (void)startAnimating {
  if (_isAnimating) {
    [self stopAnimating];
    return;
  }

  // Animate the first layer, if there is one.
  // The first layer animation will begin a chain of subsequent repeating animations.
  if (_animatableLayers.firstObject != nil) {
    [self buildAnimationGroupForLayer:_animatableLayers[0] delay:0];
    _isAnimating = YES;
  }
}

- (void)stopAnimating {
  if (!_isAnimating) {
    return;
  }

  [self resetAllAnimations];
  _isAnimating = NO;
}

- (void)createSublayers {
  [self resetAllAnimations];

  [_colors enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger index, BOOL *_Nonnull stop) {
    CALayer *layer = [[CALayer alloc] init];

    // The anchor point determines the direction of the progress indicator animations.
    // (0, 1) animates left to right.
    // (1, 0) animates right to left.
    layer.anchorPoint = CGPointMake(0, 1);

    layer.frame = CGRectMake(self.layer.bounds.origin.x, self.layer.bounds.origin.y, 0,
                             self.layer.bounds.size.height);

    NSString *layerName = [NSString stringWithFormat:@"kColoredProgressLayer%lu", index];
    layer.name = layerName;
    layer.backgroundColor = color.CGColor;

    [_animatableLayers addObject:layer];
    [self.layer addSublayer:layer];
  }];
}

- (void)configureSublayerFrames {
  for (CALayer *sublayer in self.layer.sublayers) {
    sublayer.frame = CGRectMake(self.layer.bounds.origin.x, self.layer.bounds.origin.y,
                                sublayer.bounds.size.width, self.layer.bounds.size.height);
  }
}

#pragma mark - layoutSubviews

- (void)layoutSubviews {
  [super layoutSubviews];

  [self configureSublayerFrames];
}

#pragma mark - Setters

- (void)setColors:(nullable NSArray<UIColor *> *)colors {
  _colors = colors;
  [self createSublayers];
}

#pragma mark - Private

- (void)resetAllAnimations {
  for (CALayer *layer in [self.layer.sublayers copy]) {
    [layer removeFromSuperlayer];
  }

  _sequenceCounter = 0;
  _animatableLayers = [[NSMutableArray alloc] init];
}

- (void)buildAnimationGroupForLayer:(CALayer *)animatableLayer delay:(CGFloat)delay {
  [CATransaction begin];

  CABasicAnimation *growAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
  growAnimation.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:
                                                                                 0.40:0.0:0.20:1.0];

  growAnimation.duration = kProgressIntervalDuration;

  CGFloat beginTime = CACurrentMediaTime() + delay;
  growAnimation.beginTime = beginTime;

  growAnimation.fromValue = 0;
  growAnimation.toValue = @(self.bounds.size.width);

  growAnimation.removedOnCompletion = NO;
  growAnimation.fillMode = kCAFillModeForwards;

  growAnimation.delegate = self;

  [animatableLayer addAnimation:growAnimation forKey:@"kGrowAnimation"];

  // An animation group is used to provide a delay between each layer's animation.
  // The delay is the total duration of the sequence.
  CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
  animationGroup.animations = @[ growAnimation ];
  animationGroup.duration = kProgressIntervalDuration * _colors.count;
  [animatableLayer addAnimation:animationGroup forKey:nil];

  [CATransaction commit];
}

- (void)bringSublayerToFront:(CALayer *)sublayer {
  [sublayer removeFromSuperlayer];
  [self.layer addSublayer:sublayer];
}

/**
 * Determines the next layer in a sequence following the given layer.
 * The next layer is identified based on the given layer's position.
 * The given layer is brought to the front, and an animation group is prepared for the next layer.
 */
- (void)processLayer:(nullable CALayer *)givenLayer {
  if (_animatableLayers.firstObject == nil) {
    return;
  }

  if (givenLayer == nil || !_isAnimating) {
    return;
  }

  _sequenceCounter = (_sequenceCounter + 1) % _colors.count;

  [self bringSublayerToFront:givenLayer];

  [self buildAnimationGroupForLayer:_animatableLayers[_sequenceCounter]
                              delay:kProgressIntervalDelay];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)animation {
  if (_sequenceCounter < _animatableLayers.count) {
    [self processLayer:_animatableLayers[_sequenceCounter]];
  }
}

@end

NS_ASSUME_NONNULL_END
