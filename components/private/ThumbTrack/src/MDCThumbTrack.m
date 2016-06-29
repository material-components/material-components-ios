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

#import "MDCThumbTrack.h"

#import "MDCThumbView.h"
#import "MaterialInk.h"
#import "UIColor+MDC.h"

static const CGFloat kAnimationDuration = 0.25f;
static const CGFloat kThumbChangeAnimationDuration = 0.12f;
static const CGFloat kDefaultThumbBorderWidth = 2.0f;
static const CGFloat kDefaultThumbRadius = 6.0f;
static const CGFloat kDefaultTrackHeight = 2.0f;
static const CGFloat kDefaultFilledTrackAnchorValue = -CGFLOAT_MAX;
static const CGFloat kTrackOnAlpha = 0.5f;
static const CGFloat kMinTouchSize = 48.0f;
static const CGFloat kThumbSlopFactor = 3.5f;

// TODO(iangordon): Properly handle broken tgmath
static inline CGFloat CGFabs(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return fabs(value);
#else
  return fabsf(value);
#endif
}
static inline CGFloat CGRound(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return round(value);
#else
  return roundf(value);
#endif
}

static inline CGFloat CGHypot(CGFloat x, CGFloat y) {
#if CGFLOAT_IS_DOUBLE
  return hypot(x, y);
#else
  return hypotf(x, y);
#endif
}

static inline bool CGFloatEqual(CGFloat a, CGFloat b) {
  const CGFloat constantK = 3;
#if CGFLOAT_IS_DOUBLE
  const CGFloat epsilon = DBL_EPSILON;
  const CGFloat min = DBL_MIN;
#else
  const CGFloat epsilon = FLT_EPSILON;
  const CGFloat min = FLT_MIN;
#endif
  return (CGFabs(a - b) < constantK * epsilon * CGFabs(a + b) || CGFabs(a - b) < min);
}

/**
 Returns the distance between two points.

 @param point1 a CGPoint to measure from.
 @param point2 a CGPoint to meature to.

 @return Absolute straight line distance.
 */
static inline CGFloat DistanceFromPointToPoint(CGPoint point1, CGPoint point2) {
  return CGHypot(point1.x - point2.x, point1.y - point2.y);
}

@interface MDCThumbTrack () <MDCInkTouchControllerDelegate>
@end

@implementation MDCThumbTrack {
  CGFloat _panThumbGrabPosition;
  CGFloat _lastDispatchedValue;
  UIColor *_thumbOnColor;
  UIColor *_trackOnColor;
  UIColor *_clearColor;
  MDCInkTouchController *_touchController;
  UIView *_trackView;
  CAShapeLayer *_trackMaskLayer;
  CALayer *_trackOnLayer;
  BOOL _isTouchDown;
  BOOL _isDraggingThumb;
  CGPoint _lastTouchPoint;
  BOOL _didChangeValueDuringPan;
  BOOL _shouldDisplayInk;
}

// TODO(iangordon): ThumbView is not respecting the bounds of ThumbTrack
- (instancetype)initWithFrame:(CGRect)frame {
  return [self initWithFrame:frame onTintColor:nil];
}

- (instancetype)initWithFrame:(CGRect)frame onTintColor:(UIColor *)onTintColor {
  self = [super initWithFrame:frame];
  if (self) {
    self.userInteractionEnabled = YES;
    [super setMultipleTouchEnabled:NO];  // We only want one touch event at a time
    _continuousUpdateEvents = YES;
    _lastDispatchedValue = _value;
    _maximumValue = 1;
    _trackHeight = kDefaultTrackHeight;
    _thumbRadius = kDefaultThumbRadius;
    _filledTrackAnchorValue = kDefaultFilledTrackAnchorValue;
    _shouldDisplayInk = YES;

    // Default thumb view.
    CGRect thumbFrame = CGRectMake(0, 0, self.thumbRadius * 2, self.thumbRadius * 2);
    _thumbView = [[MDCThumbView alloc] initWithFrame:thumbFrame];
    _thumbView.borderWidth = kDefaultThumbBorderWidth;
    _thumbView.cornerRadius = self.thumbRadius;
    _thumbView.layer.zPosition = 1;
    [self addSubview:_thumbView];

    _trackView = [[UIView alloc] init];
    _trackView.userInteractionEnabled = NO;
    _trackMaskLayer = [CAShapeLayer layer];
    _trackMaskLayer.fillRule = kCAFillRuleEvenOdd;
    _trackView.layer.mask = _trackMaskLayer;
    _trackOnLayer = [CALayer layer];
    [_trackView.layer addSublayer:_trackOnLayer];
    [self addSubview:_trackView];

    // Set up ink layer.
    _touchController = [[MDCInkTouchController alloc] initWithView:_thumbView];
    _touchController.delegate = self;

    [_touchController addInkView];

    _touchController.defaultInkView.inkStyle = MDCInkStyleUnbounded;

    // Set colors.
    if (onTintColor == nil) {
      onTintColor = [UIColor blueColor];
    }
    self.primaryColor = onTintColor;
    _clearColor = [UIColor colorWithWhite:1.0f alpha:0.0f];

    [self setValue:_minimumValue animated:NO];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self updateTrackMask];
  [self updateThumbTrackAnimated:NO animateThumbAfterMove:NO previousValue:_value completion:nil];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  CGFloat dx = MIN(0, (self.bounds.size.height - kMinTouchSize) / 2);
  CGRect rect = CGRectInset(self.bounds, dx, dx);
  return CGRectContainsPoint(rect, point);
}

- (void)setPrimaryColor:(UIColor *)primaryColor {
  if (primaryColor == nil) {
    primaryColor = [UIColor blueColor];  // YSNBH
  }
  _primaryColor = primaryColor;
  _thumbOnColor = primaryColor;
  _trackOnColor =
      _interpolateOnOffColors ? [primaryColor colorWithAlphaComponent:kTrackOnAlpha] : primaryColor;

  _touchController.defaultInkView.inkColor = [primaryColor colorWithAlphaComponent:kTrackOnAlpha];
  [self updateThumbTrackAnimated:NO animateThumbAfterMove:NO previousValue:_value completion:nil];
}

- (void)setThumbOffColor:(UIColor *)thumbOffColor {
  _thumbOffColor = thumbOffColor;
}

- (void)setThumbDisabledColor:(UIColor *)thumbDisabledColor {
  _thumbDisabledColor = thumbDisabledColor;
  [self updateThumbTrackAnimated:NO animateThumbAfterMove:NO previousValue:_value completion:nil];
}

- (void)setTrackOffColor:(UIColor *)trackOffColor {
  _trackOffColor = trackOffColor;
  [self updateThumbTrackAnimated:NO animateThumbAfterMove:NO previousValue:_value completion:nil];
}

- (void)setTrackDisabledColor:(UIColor *)trackDisabledColor {
  _trackDisabledColor = trackDisabledColor;
  [self updateThumbTrackAnimated:NO animateThumbAfterMove:NO previousValue:_value completion:nil];
}

- (void)setInterpolateOnOffColors:(BOOL)interpolateOnOffColors {
  _interpolateOnOffColors = interpolateOnOffColors;

  // TODO(iangordon): Remove ColorGroup support
  //  if (_colorGroup) {
  //    [self setColorGroup:_colorGroup];
  //  }

  // TODO(iangordon): Refactor setPrimaryColor so this call isn't required
  [self setPrimaryColor:_primaryColor];
}

- (void)setMinimumValue:(CGFloat)minimumValue {
  _minimumValue = MIN(_maximumValue, minimumValue);
  CGFloat previousValue = _value;
  if (_value < _minimumValue) {
    _value = _minimumValue;
  }
  [self updateThumbTrackAnimated:NO
           animateThumbAfterMove:NO
                   previousValue:previousValue
                      completion:NULL];
}

- (void)setMaximumValue:(CGFloat)maximumValue {
  _maximumValue = MAX(_minimumValue, maximumValue);
  CGFloat previousValue = _value;
  if (_value > _maximumValue) {
    _value = _maximumValue;
  }
  [self updateThumbTrackAnimated:NO
           animateThumbAfterMove:NO
                   previousValue:previousValue
                      completion:NULL];
}

- (void)setTrackEndsAreRounded:(BOOL)trackEndsAreRounded {
  _trackEndsAreRounded = trackEndsAreRounded;

  if (_trackEndsAreRounded) {
    _trackView.layer.cornerRadius = _trackHeight / 2;
  } else {
    _trackView.layer.cornerRadius = 0;
  }
}

- (void)setFilledTrackAnchorValue:(CGFloat)filledTrackAnchorValue {
  _filledTrackAnchorValue = MAX(_minimumValue, MIN(filledTrackAnchorValue, _maximumValue));
  [self updateThumbTrackAnimated:NO animateThumbAfterMove:NO previousValue:_value completion:NULL];
}

- (void)setValue:(CGFloat)value {
  [self setValue:value animated:NO];
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
  [self setValue:value
                   animated:animated
      animateThumbAfterMove:animated
              userGenerated:NO
                 completion:NULL];
}

- (void)setValue:(CGFloat)value
                 animated:(BOOL)animated
    animateThumbAfterMove:(BOOL)animateThumbAfterMove
            userGenerated:(BOOL)userGenerated
               completion:(void (^)())completion {
  CGFloat previousValue = _value;
  CGFloat newValue = MAX(_minimumValue, MIN(value, _maximumValue));
  newValue = [self closestValueToTargetValue:newValue];
  if (newValue != previousValue &&
      [_delegate respondsToSelector:@selector(thumbTrack:willJumpToValue:)]) {
    [self.delegate thumbTrack:self willJumpToValue:newValue];
  }
  _value = newValue;

  if (!userGenerated) {
    _lastDispatchedValue = _value;
  }

  [self updateThumbTrackAnimated:animated
           animateThumbAfterMove:animateThumbAfterMove
                   previousValue:previousValue
                      completion:completion];
}

- (void)setNumDiscreteValues:(NSUInteger)numDiscreteValues {
  _numDiscreteValues = numDiscreteValues;
  [self setValue:_value];
}

- (void)setThumbRadius:(CGFloat)thumbRadius {
  _thumbRadius = thumbRadius;
  [self setDisplayThumbRadius:_thumbRadius];
}

- (void)setDisplayThumbRadius:(CGFloat)thumbRadius {
  _thumbView.cornerRadius = thumbRadius;
  CGPoint thumbCenter = _thumbView.center;
  _thumbView.frame = CGRectMake(thumbCenter.x - thumbRadius, thumbCenter.y - thumbRadius,
                                2 * thumbRadius, 2 * thumbRadius);
}

- (CGFloat)thumbMaxRippleRadius {
  return _touchController.defaultInkView.maxRippleRadius;
}

- (void)setThumbMaxRippleRadius:(CGFloat)thumbMaxRippleRadius {
  _touchController.defaultInkView.maxRippleRadius = thumbMaxRippleRadius;
}

- (CGPoint)thumbPosition {
  return _thumbView.center;
}

- (CGPoint)thumbPositionForValue:(CGFloat)value {
  CGFloat relValue = [self relativeValueForValue:value];
  CGPoint position =
      CGPointMake(_thumbRadius + self.thumbPanRange * relValue, self.frame.size.height / 2);
  return position;
}

- (CGFloat)valueForThumbPosition:(CGPoint)position {
  CGFloat relValue = (position.x - _thumbRadius) / self.thumbPanRange;
  relValue = MAX(0, MIN(relValue, 1));
  return (1 - relValue) * _minimumValue + relValue * _maximumValue;
}

// Describes where on the track the specified value would fall. Differs from
// -thumbPositionForValue: because it varies by whether or not the track ends are inset. Note that
// if the edges are inset, the two values are equivalent, but if not, this point's x value can
// differ from the thumb's x value by at most _thumbRadius.
- (CGPoint)trackPositionForValue:(CGFloat)value {
  if (_trackEndsAreInset) {
    return [self thumbPositionForValue:value];
  }

  CGFloat xValue = [self relativeValueForValue:value] * self.bounds.size.width;
  return CGPointMake(xValue, self.frame.size.height / 2);
}

- (void)setIcon:(nullable UIImage *)icon {
  [_thumbView setIcon:icon];
}

#pragma mark - Enabled state

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  if (enabled) {
    [self setPrimaryColor:_primaryColor];
  }
  [self updateThumbTrackAnimated:NO animateThumbAfterMove:NO previousValue:_value completion:nil];
}

#pragma mark - MDCInkTouchControllerDelegate

- (BOOL)inkTouchController:(nonnull MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
  return _shouldDisplayInk;
}

#pragma mark - Private

- (BOOL)isValueAtMinimum {
  return _value == _minimumValue;
}

- (CAMediaTimingFunction *)timingFunctionFromUIViewAnimationOptions:
        (UIViewAnimationOptions)options {
  NSString *name;

  // It's important to check these in this order, due to their actual values specified in UIView.h:
  // UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
  // UIViewAnimationOptionCurveEaseIn               = 1 << 16,
  // UIViewAnimationOptionCurveEaseOut              = 2 << 16,
  // UIViewAnimationOptionCurveLinear               = 3 << 16,
  if ((options & UIViewAnimationOptionCurveLinear) == UIViewAnimationOptionCurveLinear) {
    name = kCAMediaTimingFunctionEaseIn;
  } else if ((options & UIViewAnimationOptionCurveEaseIn) == UIViewAnimationOptionCurveEaseIn) {
    name = kCAMediaTimingFunctionEaseIn;
  } else if ((options & UIViewAnimationOptionCurveEaseOut) == UIViewAnimationOptionCurveEaseOut) {
    name = kCAMediaTimingFunctionEaseOut;
  } else {
    name = kCAMediaTimingFunctionEaseInEaseOut;
  }

  return [CAMediaTimingFunction functionWithName:name];
}

- (CGFloat)thumbPanOffset {
  return _thumbView.frame.origin.x / self.thumbPanRange;
}

- (CGFloat)thumbPanRange {
  return self.bounds.size.width - (self.thumbRadius * 2);
}

/**
 Updates the state of the thumb track. First updates the views with properties that should change
 before the animation. Then performs the main update block, which is animated or not as specified by
 the `animated` parameter. After this completes, the secondary animation kicks in, again
 animated or not as specified by `animateThumbAfterMove`. After this completes, the `completion`
 handler is run.
 */
- (void)updateThumbTrackAnimated:(BOOL)animated
           animateThumbAfterMove:(BOOL)animateThumbAfterMove
                   previousValue:(CGFloat)previousValue
                      completion:(void (^)())completion {
  [self updateViewsNoAnimation];

  UIViewAnimationOptions baseAnimationOptions =
      UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction;
  // Note that UIViewAnimationOptionCurveEaseInOut == 0, so by not specifying it, these options
  // default to animating with Ease in / Ease out

  if (animated) {
    // UIView animateWithDuration:delay:options:animations: takes a different block signature.
    void (^animationCompletion)(BOOL) = ^void(BOOL finished) {
      if (!finished) {
        // If we were interrupted, we shoudldn't complete the second animation.
        return;
      }

      // Do secondary animation and return.
      [self updateThumbAfterMoveAnimated:animateThumbAfterMove
                                 options:baseAnimationOptions
                              completion:completion];
    };

    BOOL crossesAnchor =
        (previousValue < _filledTrackAnchorValue && _filledTrackAnchorValue < _value) ||
        (_value < _filledTrackAnchorValue && _filledTrackAnchorValue < previousValue);
    if (crossesAnchor) {
      CGFloat currentValue = _value;
      CGFloat animationDurationToAnchor =
          (CGFabs(previousValue - _filledTrackAnchorValue) / CGFabs(previousValue - currentValue)) *
          kAnimationDuration;
      void (^afterCrossingAnchorAnimation)(BOOL) = ^void(BOOL finished) {
        UIViewAnimationOptions options = baseAnimationOptions | UIViewAnimationOptionCurveEaseOut;
        [UIView animateWithDuration:(kAnimationDuration - animationDurationToAnchor)
                              delay:0.0f
                            options:options
                         animations:^{
                           [self updateViewsMainIsAnimated:animated
                                              withDuration:(kAnimationDuration -
                                                            animationDurationToAnchor)
                                          animationOptions:options];
                         }
                         completion:animationCompletion];
      };
      UIViewAnimationOptions options = baseAnimationOptions | UIViewAnimationOptionCurveEaseIn;
      [UIView animateWithDuration:animationDurationToAnchor
                            delay:0.0f
                          options:options
                       animations:^{
                         _value = _filledTrackAnchorValue;
                         [self updateViewsMainIsAnimated:animated
                                            withDuration:animationDurationToAnchor
                                        animationOptions:options];
                         _value = currentValue;
                       }
                       completion:afterCrossingAnchorAnimation];
    } else {
      [UIView animateWithDuration:kAnimationDuration
                            delay:0.0f
                          options:baseAnimationOptions
                       animations:^{
                         [self updateViewsMainIsAnimated:animated
                                            withDuration:kAnimationDuration
                                        animationOptions:baseAnimationOptions];
                       }
                       completion:animationCompletion];
    }
  } else {
    [self updateViewsMainIsAnimated:animated
                       withDuration:0.0f
                   animationOptions:baseAnimationOptions];
    [self updateThumbAfterMoveAnimated:animateThumbAfterMove
                               options:baseAnimationOptions
                            completion:completion];
  }
}

- (void)updateThumbAfterMoveAnimated:(BOOL)animated
                             options:(UIViewAnimationOptions)animationOptions
                          completion:(void (^)())completion {
  if (animated) {
    [UIView animateWithDuration:kThumbChangeAnimationDuration
        delay:0.0f
        options:animationOptions
        animations:^{
          [self updateViewsForThumbAfterMoveIsAnimated:animated
                                          withDuration:kThumbChangeAnimationDuration];
        }
        completion:^void(BOOL _) {
          if (completion) {
            completion();
          }
        }];
  } else {
    [self updateViewsForThumbAfterMoveIsAnimated:animated withDuration:0.0f];

    if (completion) {
      completion();
    }
  }
}

/**
 Updates the display of the ThumbTrack with properties we want to appear instantly, before the
 animated properties are animated.
 */
- (void)updateViewsNoAnimation {
  // If not enabled, adjust thumbView accordingly
  if (self.enabled) {
    // Set thumb color if needed. Note that setting color to hollow start state happes in secondary
    // animation block (-updateViewsSecondaryAnimated:withDuration:).
    if (_interpolateOnOffColors) {
      // Set background/border colors based on interpolated percent.
      CGFloat percent = [self relativeValueForValue:_value];
      _thumbView.layer.backgroundColor = [UIColor mdc_colorInterpolatedFromColor:_thumbOffColor
                                                                         toColor:_thumbOnColor
                                                                         percent:percent]
                                             .CGColor;
      _thumbView.layer.borderColor = [UIColor mdc_colorInterpolatedFromColor:_thumbOffColor
                                                                     toColor:_thumbOnColor
                                                                     percent:percent]
                                         .CGColor;
      _trackView.backgroundColor = [UIColor mdc_colorInterpolatedFromColor:_trackOffColor
                                                                   toColor:_trackOnColor
                                                                   percent:percent];
      _trackOnLayer.backgroundColor = _clearColor.CGColor;
    } else if (!_thumbIsHollowAtStart || ![self isValueAtMinimum]) {
      [self updateTrackMask];

      _thumbView.backgroundColor = _thumbOnColor;
      _thumbView.layer.borderColor = _thumbOnColor.CGColor;
    }
  } else {
    _thumbView.backgroundColor = _thumbDisabledColor;
    _thumbView.layer.borderColor = _clearColor.CGColor;

    if (_thumbIsSmallerWhenDisabled) {
      [self setDisplayThumbRadius:_thumbRadius - _trackHeight];
    }
  }
}

/**
 Updates the properties of the ThumbTrack that are animated in the main animation body. May be
 called from within a UIView animation block.
 */
- (void)updateViewsMainIsAnimated:(BOOL)animated
                     withDuration:(NSTimeInterval)duration
                 animationOptions:(UIViewAnimationOptions)animationOptions {
  // Move thumb position.
  CGPoint point = [self thumbPositionForValue:_value];
  _thumbView.center = point;

  // Re-draw track position
  if (_trackEndsAreInset) {
    _trackView.frame = CGRectMake(_thumbRadius, CGRectGetMidY(self.bounds) - (_trackHeight / 2),
                                  CGRectGetWidth(self.bounds) - (_thumbRadius * 2), _trackHeight);
  } else {
    _trackView.frame = CGRectMake(0, CGRectGetMidY(self.bounds) - (_trackHeight / 2),
                                  CGRectGetWidth(self.bounds), _trackHeight);
  }

  // Update colors, etc.
  if (self.enabled) {
    if (_thumbIsSmallerWhenDisabled) {
      _thumbView.layer.transform = CATransform3DIdentity;
    }

    if (!_interpolateOnOffColors) {
      _trackView.layer.backgroundColor = _trackOffColor.CGColor;
      _trackOnLayer.backgroundColor = _trackOnColor.CGColor;

      CGFloat anchorXValue = [self trackPositionForValue:_filledTrackAnchorValue].x;
      CGFloat currentXValue = [self trackPositionForValue:_value].x;

      CGFloat trackOnXValue = MIN(currentXValue, anchorXValue);
      if (_trackEndsAreInset) {
        // Account for the fact that the layer's coords are relative to the frame of the track.
        trackOnXValue -= _thumbRadius;
      }

      // We have to use a CATransaction here because CALayer.frame is only animatable using this
      // method, not the UIVIew block-based animation that the rest of this method uses. We use
      // the timing function and duration passed in in order to match with the other animations.
      [CATransaction begin];
      [CATransaction setAnimationTimingFunction:
                         [self timingFunctionFromUIViewAnimationOptions:animationOptions]];
      [CATransaction setAnimationDuration:duration];
      _trackOnLayer.frame =
          CGRectMake(trackOnXValue, 0, CGFabs(currentXValue - anchorXValue), _trackHeight);
      [CATransaction commit];
    }
  } else {
    // Set background colors for disabled state.
    _trackView.backgroundColor = _trackDisabledColor;
    _trackOnLayer.backgroundColor = _clearColor.CGColor;

    // Update mask again, since thumb may have moved
    [self updateTrackMask];
  }
}

/**
 Updates the properties of the ThumbTrack that animate after the thumb move has finished, i.e. after
 the main animation block completes. May be called from within a UIView animation block.
 */
- (void)updateViewsForThumbAfterMoveIsAnimated:(BOOL)animated
                                  withDuration:(NSTimeInterval)duration {
  if (!self.enabled) {
    // The following changes only matter if the track is enabled.
    return;
  }

  if ([self isValueAtMinimum] && _thumbIsHollowAtStart) {
    [self updateTrackMask];

    _thumbView.backgroundColor = _clearColor;
    _thumbView.layer.borderColor = _trackOffColor.CGColor;
  }

  CGFloat radius;
  if (_isDraggingThumb) {
    radius = _thumbRadius + _trackHeight;
  } else {
    radius = _thumbRadius;
  }

  if (radius == _thumbView.layer.cornerRadius || !_thumbGrowsWhenDragging) {
    // No need to change anything
    return;
  }

  if (animated) {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    anim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = [NSNumber numberWithDouble:_thumbView.layer.cornerRadius];
    anim.toValue = [NSNumber numberWithDouble:radius];
    anim.duration = duration;
    anim.delegate = self;
    anim.removedOnCompletion = NO;  // We'll remove it ourselves as the delegate
    [_thumbView.layer addAnimation:anim forKey:anim.keyPath];
  }
  [self setDisplayThumbRadius:radius];  // Updates frame and corner radius

  [self updateTrackMask];
}

// Used to make sure we update the mask after animating the thumb growing or shrinking. Specifically
// in the case where the thumb is at the start and hollow, forgetting to update could leave the mask
// in a strange visual state.
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  if (anim == [_thumbView.layer animationForKey:@"cornerRadius"]) {
    [_thumbView.layer removeAllAnimations];
    [self updateTrackMask];
  }
}

- (void)updateTrackMask {
  // Adding 1pt to the top and bottom is necessary to account for the behavior of CAShapeLayer,
  // which according Apple's documentation "may favor speed over accuracy" when rasterizing.
  // https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CAShapeLayer_class
  // This means that its rasterization sometimes doesn't line up with the UIView that it's masking,
  // particularly when that view's edges fall on a subpixel. Adding the extra pt on the top and
  // bottom accounts for this case here, and ensures that none of the _trackView appears where it
  // isn't supposed to.
  // This fixes https://github.com/google/material-components-ios/issues/566 for all orientations.
  CGRect maskFrame = CGRectMake(0, -1, CGRectGetWidth(self.bounds), _trackHeight + 2);

  CGMutablePathRef path = CGPathCreateMutable();
  CGPathAddRect(path, NULL, maskFrame);

  CGFloat radius = _thumbView.layer.cornerRadius;
  if (_thumbView.layer.presentationLayer != NULL) {
    // If we're animating (growing or shrinking) lean on the side of the smaller radius, to prevent
    // a gap from appearing between the thumb and the track in the intermediate frames.
    radius = MIN(((CALayer *)_thumbView.layer.presentationLayer).cornerRadius, radius);
  }
  radius = MAX(radius, _thumbRadius);

  if ((!self.enabled && _disabledTrackHasThumbGaps) ||
      ([self isValueAtMinimum] && _thumbIsHollowAtStart)) {
    // The reason we calculate this explicitly instead of just using _thumbView.frame is because
    // the thumb view might not be have the exact radius of _thumbRadius, depending on if the track
    // is disabled or if a user is dragging the thumb.
    CGRect gapMaskFrame = CGRectMake(_thumbView.center.x - radius, _thumbView.center.y - radius,
                                     radius * 2, radius * 2);
    gapMaskFrame = [self convertRect:gapMaskFrame toView:_trackView];
    CGPathAddRect(path, NULL, gapMaskFrame);
  }

  _trackMaskLayer.path = path;
  CGPathRelease(path);
}

- (CGFloat)relativeValueForValue:(CGFloat)value {
  value = MAX(_minimumValue, MIN(value, _maximumValue));
  if (CGFloatEqual(_minimumValue, _maximumValue)) {
    return _minimumValue;
  }
  return (value - _minimumValue) / CGFabs(_minimumValue - _maximumValue);
}

- (CGFloat)closestValueToTargetValue:(CGFloat)targetValue {
  if (_numDiscreteValues < 2) {
    return targetValue;
  }
  if (CGFloatEqual(_minimumValue, _maximumValue)) {
    return _minimumValue;
  }

  CGFloat scaledTargetValue = (targetValue - _minimumValue) / (_maximumValue - _minimumValue);
  CGFloat snappedValue =
      CGRound((_numDiscreteValues - 1) * scaledTargetValue) / (_numDiscreteValues - 1.0f);
  return (1 - snappedValue) * _minimumValue + snappedValue * _maximumValue;
}

#pragma mark - UIResponder Events

/**
 We implement our own touch handling here instead of using gesture recognizers. This allows more
 fine grained control over how the thumb track behaves, including more specific logic over what
 counts as a tap vs. a drag.

 Note that we must use -touchesBegan:, -touchesMoves:, etc here, rather than the UIControl methods
 -beginDraggingWithTouch:withEvent:, -continueDraggingWithTouch:withEvent:, etc. This is because
 with those events, we are forced to disable user interaction on our subviews else the events could
 be swallowed up by their event handlers and not ours. We can't do this because the we have an ink
 controller attached to the thumb view for MDCSwitch, and that needs to receive touch events in
 order to know when to display ink.

 Using -touchesBegan:, etc. solves this problem because we can handle touches ourselves as well as
 continue to have them pass through to the contained thumb view. So we get our custom event handling
 without disabling the ink display, hurray!

 Because we set `multipleTouchEnabled = NO`, the sets of touches in these methods will always be of
 size 1. For this reason, we can simply call `-anyObject` on the set instead of iterating through
 every touch.
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (!self.enabled || _isTouchDown) {
    return;
  }

  CGPoint touchLoc = [[touches anyObject] locationInView:self];

  _isTouchDown = YES;
  _lastTouchPoint = touchLoc;
  _didChangeValueDuringPan = NO;

  _isDraggingThumb = _panningAllowedOnEntireControl || [self isPointOnThumb:touchLoc];

  if (_isDraggingThumb) {
    // Start panning
    _panThumbGrabPosition = touchLoc.x - self.thumbPosition.x;

    // Grow the thumb
    [self updateThumbTrackAnimated:NO
             animateThumbAfterMove:YES
                     previousValue:_value
                        completion:nil];
  }

  [self sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (!self.enabled || ![self isTouchRelevant:touch]) {
    return;
  }

  CGPoint touchLoc = [touch locationInView:self];
  _lastTouchPoint = touchLoc;

  if (!_isDraggingThumb) {
    // The rest is dragging logic
    return;
  }

  CGFloat thumbPosition = touchLoc.x - _panThumbGrabPosition;
  CGFloat previousValue = _value;
  CGFloat value = [self valueForThumbPosition:CGPointMake(thumbPosition, 0)];

  [self setValue:value animated:NO animateThumbAfterMove:YES userGenerated:YES completion:NULL];
  [self sendContinuousChangeAction];

  if (value != previousValue) {
    // We made a move, now this action can't later count as a tap
    _didChangeValueDuringPan = YES;
  }

  if ([self pointInside:touchLoc withEvent:nil]) {
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
  } else {
    [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if ([self isTouchRelevant:touch]) {
    _isTouchDown = _isDraggingThumb = NO;

    [self sendActionsForControlEvents:UIControlEventTouchCancel];
  }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (!self.enabled || ![self isTouchRelevant:touch]) {
    return;
  }

  BOOL wasDragging = _isDraggingThumb;
  _isTouchDown = _isDraggingThumb = NO;

  if (wasDragging) {
    // Shrink the thumb
    [self updateThumbTrackAnimated:NO
             animateThumbAfterMove:YES
                     previousValue:_value
                        completion:nil];
  }

  CGPoint touchLoc = [touch locationInView:self];
  if ([self pointInside:touchLoc withEvent:nil]) {
    if (!_didChangeValueDuringPan && (_tapsAllowedOnThumb || ![self isPointOnThumb:touchLoc])) {
      // Treat it like a tap
      if (![_delegate respondsToSelector:@selector(thumbTrack:shouldJumpToValue:)] ||
          [self.delegate thumbTrack:self shouldJumpToValue:[self valueForThumbPosition:touchLoc]]) {
        [self interruptAnimation];
        [self setValueFromThumbPosition:touchLoc isTap:YES];
      }
    }

    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
  } else {
    [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
  }
}

- (BOOL)isTouchRelevant:(UITouch *)touch {
  // We compare the previous position vs. current position rather than saving and comparing UITouch
  // objects per Apple's documentation in UITouch, which says: "Never retain a touch object when
  // handling an event. If you need to keep information about a touch from one touch phase to
  // another, copy that information from the touch."
  // https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITouch_Class/
  return CGPointEqualToPoint([touch previousLocationInView:self], _lastTouchPoint);
}

- (BOOL)isPointOnThumb:(CGPoint)point {
  // Note that we let the thumb's draggable area extend beyond its actual view to account for
  // the imprecise nature of hit targets on device.
  return DistanceFromPointToPoint(point, _thumbView.center) <= (_thumbRadius * kThumbSlopFactor);
}

- (void)setValueFromThumbPosition:(CGPoint)position isTap:(BOOL)isTap {
  // Having two discrete values is a special case (e.g. the switch) in which any tap just flips the
  // value between the two discrete values, irrespective of the tap location.
  CGFloat value;
  if (isTap && _numDiscreteValues == 2) {
    // If we are at the maximum then make it the minimum:
    // For switch like thumb tracks where there is only 2 values we ignore the position of the tap
    // and toggle between the minimum and maximum values.
    value = _value < CGFloatEqual(_value, _minimumValue) ? _maximumValue : _minimumValue;
  } else {
    value = [self valueForThumbPosition:position];
  }
  __weak MDCThumbTrack *weakSelf = self;
  if ([_delegate respondsToSelector:@selector(thumbTrack:willAnimateToValue:)]) {
    [_delegate thumbTrack:self willAnimateToValue:value];
  }
  [self setValue:value
                   animated:YES
      animateThumbAfterMove:YES
              userGenerated:YES
                 completion:^{
                   MDCThumbTrack *strongSelf = weakSelf;
                   [strongSelf sendDiscreteChangeAction];
                   if (strongSelf &&
                       [strongSelf->_delegate
                           respondsToSelector:@selector(thumbTrack:didAnimateToValue:)]) {
                     [strongSelf->_delegate thumbTrack:weakSelf didAnimateToValue:value];
                   }
                 }];
}

- (void)sendContinuousChangeAction {
  if (_continuousUpdateEvents && _value != _lastDispatchedValue) {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    _lastDispatchedValue = _value;
  }
}

- (void)sendDiscreteChangeAction {
  if (_value != _lastDispatchedValue) {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    _lastDispatchedValue = _value;
  }
}

#pragma mark - Private

- (void)interruptAnimation {
  if (_thumbView.layer.presentationLayer) {
    _thumbView.layer.position = [(CALayer *)_thumbView.layer.presentationLayer position];
  }
  [_thumbView.layer removeAllAnimations];
  [_trackView.layer removeAllAnimations];
  [_trackOnLayer removeAllAnimations];
}

@end
