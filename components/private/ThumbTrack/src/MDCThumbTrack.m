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

#import "MaterialInk.h"
#import "MDCThumbView.h"
#import "UIColor+MDC.h"

static const CGFloat kAnimationDuration = 0.25f;
static const CGFloat kDefaultThumbBorderWidth = 2.0f;
static const CGFloat kDefaultThumbRadius = 6.0f;
static const CGFloat kDefaultTrackHeight = 2.0f;
static const CGFloat kDefaultFilledTrackAnchorValue = -CGFLOAT_MAX;
static const CGFloat kEpsilon = 2.0f;  // Points.
static const CGFloat kTrackOnAlpha = 0.5f;
static const CGFloat kMinTouchSize = 48.0f;

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
  UIPanGestureRecognizer *_panRecognizer;
  CGFloat _panThumbGrabPosition;
  UITapGestureRecognizer *_tapRecognizer;
  CGFloat _lastDispatchedValue;
  UIColor *_thumbOnColor;
  UIColor *_trackOnColor;
  UIColor *_clearColor;
  MDCInkTouchController *_touchController;
  UIView *_trackView;
  CAShapeLayer *_trackMaskLayer;
  CALayer *_trackOnLayer;
  BOOL _isTrackingTouches;
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

    UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGestureRecognizer];

    _panRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handlePanGesture:)];
    _panRecognizer.cancelsTouchesInView = NO;
    [self updatePanRecognizerTarget];

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
  [self updateViewsAnimated:NO withDuration:0.0f];
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
      _interpolateOnOffColors
          ? [primaryColor colorWithAlphaComponent:kTrackOnAlpha]
          : primaryColor;

  _touchController.defaultInkView.inkColor = [primaryColor colorWithAlphaComponent:kTrackOnAlpha];
  [self updateColorsAnimated:NO withDuration:0.0f];
}

- (void)setThumbOffColor:(UIColor *)thumbOffColor {
  _thumbOffColor = thumbOffColor;
  [self updateColorsAnimated:NO withDuration:0.0f];
}

- (void)setThumbDisabledColor:(UIColor *)thumbDisabledColor {
  _thumbDisabledColor = thumbDisabledColor;
  [self updateColorsAnimated:NO withDuration:0.0f];
}

- (void)setTrackOffColor:(UIColor *)trackOffColor {
  _trackOffColor = trackOffColor;
  [self updateColorsAnimated:NO withDuration:0.0f];
}

- (void)setTrackDisabledColor:(UIColor *)trackDisabledColor {
  _trackDisabledColor = trackDisabledColor;
  [self updateColorsAnimated:NO withDuration:0.0f];
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
  [self updateThumbTrackAnimated:NO previousValue:previousValue completion:NULL];
}

- (void)setMaximumValue:(CGFloat)maximumValue {
  _maximumValue = MAX(_minimumValue, maximumValue);
  CGFloat previousValue = _value;
  if (_value > _maximumValue) {
    _value = _maximumValue;
  }
  [self updateThumbTrackAnimated:NO previousValue:previousValue completion:NULL];
}

- (void)setFilledTrackAnchorValue:(CGFloat)filledTrackAnchorValue {
  _filledTrackAnchorValue = MAX(_minimumValue, MIN(filledTrackAnchorValue, _maximumValue));
  [self updateThumbTrackAnimated:NO previousValue:_value completion:NULL];
}

- (void)setValue:(CGFloat)value {
  [self setValue:value animated:NO];
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
  [self setValue:value animated:animated userGenerated:NO completion:NULL];
}

- (void)setValue:(CGFloat)value
        animated:(BOOL)animated
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
  [self updateThumbTrackAnimated:animated previousValue:previousValue completion:completion];
}

- (void)setNumDiscreteValues:(NSUInteger)numDiscreteValues {
  _numDiscreteValues = numDiscreteValues;
  [self setValue:_value];
}

- (void)setThumbRadius:(CGFloat)thumbRadius {
  _thumbRadius = thumbRadius;
  _thumbView.cornerRadius = thumbRadius;
  CGPoint thumbCenter = _thumbView.center;
  _thumbView.frame = CGRectMake(thumbCenter.x - thumbRadius, thumbCenter.y - thumbRadius,
                                2 * thumbRadius, 2 * thumbRadius);
  [self setNeedsLayout];
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

- (void)setPanningAllowedOnEntireControl:(BOOL)panningAllowedOnEntireControl {
  if (_panningAllowedOnEntireControl != panningAllowedOnEntireControl) {
    _panningAllowedOnEntireControl = panningAllowedOnEntireControl;
    [self updatePanRecognizerTarget];
  }
}

- (CGPoint)thumbPositionForValue:(CGFloat)value {
  CGFloat relValue = [self relativeValueForValue:value];
  CGPoint position = CGPointMake(_thumbRadius + self.thumbPanRange * relValue, self.frame.size.height / 2);
  return position;
}

- (CGFloat)valueForThumbPosition:(CGPoint)position {
  CGFloat relValue = (position.x - _thumbRadius) / self.thumbPanRange;
  relValue = MAX(0, MIN(relValue, 1));
  return (1 - relValue) * _minimumValue + relValue * _maximumValue;
}

#pragma mark - Enabled state

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  if (enabled) {
    [self setPrimaryColor:_primaryColor];
  }
  [self updateTrackMask];
  [self updateColorsAnimated:NO withDuration:0.0f];
}

#pragma mark - MDCInkTouchControllerDelegate

- (BOOL)inkTouchController:(nonnull MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
  return _shouldDisplayInk;
}

#pragma mark - Private

- (BOOL)isThumbAtStart {
  CGPoint thumbLocation = _thumbView.center;
  CGPoint start = [self thumbPositionForValue:_minimumValue];
  return fabs(thumbLocation.x - start.x) < kEpsilon;
}

- (CGFloat)thumbPanOffset {
  return _thumbView.frame.origin.x / self.thumbPanRange;
}

- (CGFloat)thumbPanRange {
  return self.bounds.size.width - (self.thumbRadius * 2);
}

- (void)updateThumbTrackAnimated:(BOOL)animated
                   previousValue:(CGFloat)previousValue
                      completion:(void (^)())completion {
  // UIView animateWithDuration:delay:options:animations: takes a different block signature.
  void (^animationCompletion)(BOOL);
  if (completion) {
    animationCompletion = ^void(BOOL finished) {
      completion();
    };
  }
  CGFloat animationDuration = animated ? kAnimationDuration : 0.0f;
  BOOL crossesAnchor =
      (previousValue < _filledTrackAnchorValue && _filledTrackAnchorValue < _value) ||
      (_value < _filledTrackAnchorValue && _filledTrackAnchorValue < previousValue);
  UIViewAnimationOptions animationOptions =
      UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction;
  if (crossesAnchor) {
    CGFloat currentValue = _value;
    _value = _filledTrackAnchorValue;
    CGFloat animationDurationToAnchor = CGFabs(previousValue) /
                                        (CGFabs(previousValue) + CGFabs(currentValue)) *
                                        animationDuration;
    void (^secondAnimation)(BOOL) = ^void(BOOL finished) {
      _value = currentValue;
      [UIView animateWithDuration:(animationDuration - animationDurationToAnchor)
                            delay:0.0f
                          options:animationOptions
                       animations:^{
                         [self updateViewsAnimated:animated
                                      withDuration:(animationDuration - animationDurationToAnchor)];
                       }
                       completion:animationCompletion];
    };
    [UIView animateWithDuration:animationDurationToAnchor
                          delay:0.0f
                        options:animationOptions
                     animations:^{
                       [self updateViewsAnimated:animated withDuration:animationDurationToAnchor];
                     }
                     completion:secondAnimation];
  } else {
    void (^updateViews)() = ^() {
      [self updateViewsAnimated:animated withDuration:animationDuration];
    };
    if (animated) {
      [UIView animateWithDuration:animationDuration
                            delay:0.0f
                          options:animationOptions
                       animations:updateViews
                       completion:animationCompletion];
    } else {
      updateViews();
      if (animationCompletion) {
        animationCompletion(YES);
      }
    }
  }
}

- (void)updateColorsAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration {
  if (self.enabled) {
    CGFloat percent = [self relativeValueForValue:_value];
    if (_interpolateOnOffColors) {
      // Set background/border colors based on interpolated percent.
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
    } else {
      _thumbView.layer.backgroundColor = _thumbOnColor.CGColor;
      _thumbView.layer.borderColor = _thumbOnColor.CGColor;
      _trackView.layer.backgroundColor = _trackOffColor.CGColor;
      _trackOnLayer.backgroundColor = _trackOnColor.CGColor;

      CGFloat anchor = [self thumbPositionForValue:_filledTrackAnchorValue].x;
      if (!_trackEndsAreInset) {
        if (_filledTrackAnchorValue <= _minimumValue) {
          anchor -= _thumbRadius;
        }
        if (_filledTrackAnchorValue >= _maximumValue) {
          anchor += _thumbRadius;
        }
      }
      CGFloat current = [self thumbPositionForValue:_value].x;

      [CATransaction begin];
      [CATransaction
          setAnimationTimingFunction:[CAMediaTimingFunction
                                         functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
      [CATransaction setAnimationDuration:duration];
      _trackOnLayer.frame =
          CGRectMake(MIN(current, anchor), 0, CGFabs(current - anchor), _trackHeight);
      [CATransaction commit];
    }
  } else {
    // Set background/border colors for disabled state.
    BOOL start = [self isThumbAtStart];
    _thumbView.layer.backgroundColor = _thumbDisabledColor.CGColor;
    _thumbView.layer.borderColor = start ? _thumbDisabledColor.CGColor : _clearColor.CGColor;
    _trackView.backgroundColor = _trackDisabledColor;
    _trackOnLayer.backgroundColor = _clearColor.CGColor;
  }
}

- (void)updateViewsAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration {
  // Move thumb position.
  CGPoint point = [self thumbPositionForValue:_value];
  _thumbView.center = point;
  _trackView.frame =
      CGRectMake(0, self.center.y - (_trackHeight / 2), CGRectGetWidth(self.bounds), _trackHeight);

  [self updateColorsAnimated:animated withDuration:duration];
}

- (void)updateTrackMask {
  CGRect maskFrame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), _trackHeight);
  if (_trackEndsAreInset) {
    maskFrame = CGRectInset(maskFrame, _thumbView.cornerRadius, 0);
  }

  CGMutablePathRef path = CGPathCreateMutable();
  CGFloat cornerRadius = _trackHeight / 2;
  // If _trackEndsAreRounded, maskFrame width and height must be at least 2 * cornerRadius to avoid
  // a GPathAddRoundedRect() assert.  Fallback to CGPathAddRect if maskFrame is too small.
  if (_trackEndsAreRounded &&
      2 * cornerRadius <= CGRectGetWidth(maskFrame) &&
      2 * cornerRadius <= CGRectGetHeight(maskFrame)) {
    CGPathAddRoundedRect(path, NULL, maskFrame, cornerRadius, cornerRadius);
  } else {
    CGPathAddRect(path, NULL, maskFrame);
  }

  if (!self.enabled && _disabledTrackHasThumbGaps) {
    CGRect gapMaskFrame = [_thumbView convertRect:_thumbView.bounds toView:_trackView];
    gapMaskFrame = CGRectInset(gapMaskFrame, -_trackHeight, 0);
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

#pragma mark - Gestures and touches

- (void)updatePanRecognizerTarget {
  [_panRecognizer.view removeGestureRecognizer:_panRecognizer];
  UIView *panTarget = _panningAllowedOnEntireControl ? self : _thumbView;
  [panTarget addGestureRecognizer:_panRecognizer];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer {
  if (!self.enabled) {
    return;
  }
  [self interruptAnimation];

  CGPoint thumbLocation = [recognizer locationInView:self];

  if ([_delegate respondsToSelector:@selector(thumbTrack:shouldJumpToValue:)]) {
    if (![self.delegate thumbTrack:self
                 shouldJumpToValue:[self valueForThumbPosition:thumbLocation]]) {
      return;
    }
  }

  if (!_tapsAllowedOnThumb) {
    // TODO(iangordon): Compare distance^2 to cornerRadius^2 to remove a sqrt calculation
    if (DistanceFromPointToPoint(thumbLocation, _thumbView.center) < _thumbView.cornerRadius) {
      return;
    }
  }

  [self setValueFromThumbPosition:thumbLocation isTap:YES];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
  if (!self.enabled) {
    return;
  }
  [self interruptAnimation];

  if (recognizer.state == UIGestureRecognizerStateBegan) {
    CGPoint touchPosition = [recognizer locationInView:self];
    CGPoint thumbPosition = self.thumbPosition;
    _panThumbGrabPosition = touchPosition.x - thumbPosition.x;
    _isTrackingTouches = YES;
    [self sendActionsForControlEvents:UIControlEventTouchDown];
  }

  if (recognizer.state == UIGestureRecognizerStateBegan ||
      recognizer.state == UIGestureRecognizerStateChanged) {
    CGPoint touchPosition = [recognizer locationInView:self];
    CGFloat thumbPosition = touchPosition.x - _panThumbGrabPosition;
    CGFloat value = [self valueForThumbPosition:CGPointMake(thumbPosition, 0)];
    [self setValue:value animated:NO userGenerated:YES completion:NULL];
  }

  if (recognizer.state == UIGestureRecognizerStateChanged) {
    [self sendContinuousChangeAction];
  }

  if (recognizer.state == UIGestureRecognizerStateEnded) {
    [self setValueFromThumbPosition:self.thumbPosition isTap:NO];
    _isTrackingTouches = NO;
    CGPoint touchPoint = [recognizer locationInView:self];
    if ([self pointInside:touchPoint withEvent:nil]) {
      [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
      [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
    }
  } else if (recognizer.state == UIGestureRecognizerStateCancelled) {
    [self setValueFromThumbPosition:self.thumbPosition isTap:NO];
    _isTrackingTouches = NO;
    [self sendActionsForControlEvents:UIControlEventTouchCancel];
  }
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
      userGenerated:YES
         completion:^{
           MDCThumbTrack *strongSelf = weakSelf;
           [strongSelf sendDiscreteChangeAction];
           if (strongSelf && [strongSelf->_delegate
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

- (BOOL)isTracking {
  return _isTrackingTouches;
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
