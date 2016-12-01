/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCActivityIndicator.h"

#import "MaterialRTL.h"
#import "UIApplication+AppExtensions.h"

static const NSInteger kMDCActivityIndicatorTotalDetentCount = 5;
static const NSTimeInterval kMDCActivityIndicatorAnimateOutDuration = 0.1f;
static const NSTimeInterval kMDCActivityIndicatorPointCycleDuration = 4.0f / 3.0f;
static const NSTimeInterval kMDCActivityIndicatorPointCycleMinimumVariableDuration =
    kMDCActivityIndicatorPointCycleDuration / 8;
static const CGFloat kCycleRotation = 3.0f / 2.0f;
static const CGFloat kOuterRotationIncrement =
    (1.0f / kMDCActivityIndicatorTotalDetentCount) * (CGFloat)M_PI;
static const CGFloat kSpinnerRadius = 12.f;
static const CGFloat kStrokeLength = 0.75f;

/**
 Total rotation (outer rotation + stroke rotation) per _cycleCount. One turn is 2.0f.
 */
static const CGFloat kSingleCycleRotation =
    2 * kStrokeLength + kCycleRotation + 1.0f / kMDCActivityIndicatorTotalDetentCount;

/*
 States for the internal state machine. The states represent the last animation completed.
 It provides information required to select the next animation.
 */
typedef NS_ENUM(NSInteger, MDCActivityIndicatorState) {
  MDCActivityIndicatorStateIndeterminate,
  MDCActivityIndicatorStateTransitionToDeterminate,
  MDCActivityIndicatorStateDeterminate,
  MDCActivityIndicatorStateTransitionToIndeterminate,
};

@interface MDCActivityIndicator ()

/**
 The minimum stroke difference to use when collapsing the stroke to a dot. Based on current
 radius and stroke width.
 */
@property(nonatomic, assign, readonly) CGFloat minStrokeDifference;

/**
 The current color count for the spinner. Subclasses can change this value to start the spinner at
 a different color.
 */
@property(nonatomic, assign) NSUInteger currentColorCount;

/**
 The current cycle count.
 */
@property(nonatomic, assign, readonly) NSInteger cycleCount;

/**
 The cycle index at which to start the activity spinner animation. Default is 0, which corresponds
 to the top of the spinner (12 o'clock position). Spinner cycle indices are based on a 5-point
 star.
 */
@property(nonatomic, assign) NSInteger cycleStartIndex;

/**
 The outer layer that handles cycle rotations and houses the stroke layer.
 */
@property(nonatomic, strong, readonly, nullable) CALayer *outerRotationLayer;

/**
 The shape layer that handles the animating stroke.
 */
@property(nonatomic, strong, readonly, nullable) CAShapeLayer *strokeLayer;

/**
 The shape layer that shows a faint, circular track along the path of the stroke layer. Enabled
 via the trackEnabled property.
 */
@property(nonatomic, strong, readonly, nullable) CAShapeLayer *trackLayer;

@end

@implementation MDCActivityIndicator {
  BOOL _animatingOut;
  BOOL _animationsAdded;
  BOOL _animationInProgress;
  BOOL _backgrounded;
  BOOL _cycleInProgress;
  CGFloat _currentProgress;
  CGFloat _lastProgress;
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCActivityIndicatorInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCActivityIndicatorInit];
  }
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self applyPropertiesWithoutAnimation:^{
    // Resize and recenter rotation layer.
    _outerRotationLayer.bounds = self.bounds;
    _outerRotationLayer.position =
        CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);

    _strokeLayer.bounds = _outerRotationLayer.bounds;
    _strokeLayer.position = _outerRotationLayer.position;

    [self updateStrokePath];
  }];
}

- (void)commonMDCActivityIndicatorInit {
  // Register notifications for foreground and background if needed.
  [self registerForegroundAndBackgroundNotificationObserversIfNeeded];

  // The activity indicator reflects the passage of time (a spatial semantic context) and so
  // will not be mirrored in RTL languages.
  self.mdc_semanticContentAttribute = UISemanticContentAttributeSpatial;

  _cycleStartIndex = 0;
  _indicatorMode = MDCActivityIndicatorModeIndeterminate;

  // Property defaults.
  _radius = kSpinnerRadius;
  _strokeWidth = 2.0f;

  // Colors.
  _cycleColors = [MDCActivityIndicator defaultColors];
  _currentColorCount = 0;

  // Track layer.
  _trackLayer = [CAShapeLayer layer];
  _trackLayer.lineWidth = _strokeWidth;
  _trackLayer.fillColor = [UIColor clearColor].CGColor;
  [self.layer addSublayer:_trackLayer];
  _trackLayer.hidden = YES;

  // Rotation layer.
  _outerRotationLayer = [CALayer layer];
  [self.layer addSublayer:_outerRotationLayer];

  // Stroke layer.
  _strokeLayer = [CAShapeLayer layer];
  _strokeLayer.lineWidth = _strokeWidth;
  _strokeLayer.fillColor = [UIColor clearColor].CGColor;
  _strokeLayer.strokeStart = 0;
  _strokeLayer.strokeEnd = 0;
  [_outerRotationLayer addSublayer:_strokeLayer];
}

#pragma mark - UIView

- (void)willMoveToWindow:(UIWindow *)newWindow {
  // If the activity indicator is removed from the window, we should
  // immediately stop animating, otherwise it will start chewing up CPU.
  if (!newWindow) {
    [self actuallyStopAnimating];
  } else if (_animating && !_backgrounded) {
    [self actuallyStartAnimating];
  }
}

- (CGSize)intrinsicContentSize {
  CGFloat edge = 2 * _radius + _strokeWidth;
  return CGSizeMake(edge, edge);
}

#pragma mark - Public methods

- (void)startAnimating {
  if (_animatingOut) {
    [self removeAnimations];
  }

  if (_animating) {
    return;
  }

  _animating = YES;

  if (self.window && !_backgrounded) {
    [self actuallyStartAnimating];
  }
}

- (void)stopAnimating {
  if (!_animating) {
    return;
  }

  _animating = NO;

  [self animateOut];
}

- (void)stopAnimatingImmediately {
  if (!_animating) {
    return;
  }

  _animating = NO;

  [self actuallyStopAnimating];

  if ([_delegate respondsToSelector:@selector(activityIndicatorAnimationDidFinish:)]) {
    [_delegate activityIndicatorAnimationDidFinish:self];
  }
}

- (void)resetStrokeColor {
  _currentColorCount = 0;

  [self updateStrokeColor];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
  _strokeLayer.strokeColor = strokeColor.CGColor;
  _trackLayer.strokeColor = [strokeColor colorWithAlphaComponent:0.3f].CGColor;
}

- (void)setIndicatorMode:(MDCActivityIndicatorMode)indicatorMode {
  if (_indicatorMode == indicatorMode) {
    return;
  }
  _indicatorMode = indicatorMode;
  if (_animating && !_animationInProgress) {
    switch (indicatorMode) {
      case MDCActivityIndicatorModeDeterminate:
        [self addTransitionToDeterminateCycle];
        break;
      case MDCActivityIndicatorModeIndeterminate:
        [self addTransitionToIndeterminateCycle];
        break;
    }
  }
}

- (void)setIndicatorMode:(MDCActivityIndicatorMode)mode animated:(BOOL)animated {
  [self setIndicatorMode:mode];
}

- (void)setProgress:(float)progress {
  _progress = MAX(0.0f, MIN(progress, 1.0f));
  if (_progress == _currentProgress) {
    return;
  }
  if (_animating && !_animationInProgress) {
    switch (_indicatorMode) {
      case MDCActivityIndicatorModeDeterminate:
        // Currently animating the determinate mode but no animation queued.
        [self addProgressAnimation];
        break;
      case MDCActivityIndicatorModeIndeterminate:
        break;
    }
  }
}

#pragma mark - Properties

- (void)setStrokeWidth:(CGFloat)strokeWidth {
  _strokeWidth = strokeWidth;
  _strokeLayer.lineWidth = _strokeWidth;
  _trackLayer.lineWidth = _strokeWidth;

  [self updateStrokePath];
}

- (void)setRadius:(CGFloat)radius {
  _radius = MIN(MAX(radius, 5.0f), 72.0f);

  [self updateStrokePath];
}

- (void)setTrackEnabled:(BOOL)trackEnabled {
  _trackEnabled = trackEnabled;

  _trackLayer.hidden = !_trackEnabled;
}

#pragma mark - Private methods

/**
 If this class is not being run in an extension, register for foreground changes and initialize
 the app background state in case UI is created when the app is backgrounded. (Extensions always
 return UIApplicationStateBackground for |[UIApplication sharedApplication].applicationState|.)
 */
- (void)registerForegroundAndBackgroundNotificationObserversIfNeeded {
  if ([UIApplication mdc_isAppExtension]) {
    return;
  }

  _backgrounded =
      [UIApplication mdc_safeSharedApplication].applicationState == UIApplicationStateBackground;
  NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
  [notificationCenter addObserver:self
                         selector:@selector(controlAnimatingOnForegroundChange:)
                             name:UIApplicationWillEnterForegroundNotification
                           object:nil];
  [notificationCenter addObserver:self
                         selector:@selector(controlAnimatingOnForegroundChange:)
                             name:UIApplicationDidEnterBackgroundNotification
                           object:nil];
}

- (void)controlAnimatingOnForegroundChange:(NSNotification *)notification {
  // Stop or restart animating if the app has a foreground change.
  _backgrounded = [notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification];
  if (_animating) {
    if (_backgrounded) {
      [self actuallyStopAnimating];
    } else if (self.window) {
      [self actuallyStartAnimating];
    }
  }
}

- (void)actuallyStartAnimating {
  if (_animationsAdded) {
    return;
  }
  _animationsAdded = YES;
  _cycleCount = _cycleStartIndex;

  [self applyPropertiesWithoutAnimation:^{
    _strokeLayer.strokeStart = 0.0f;
    _strokeLayer.strokeEnd = 0.001f;
    _strokeLayer.lineWidth = _strokeWidth;
    _trackLayer.lineWidth = _strokeWidth;

    [self resetStrokeColor];
    [self updateStrokePath];
  }];

  switch (_indicatorMode) {
    case MDCActivityIndicatorModeIndeterminate:
      [self addStrokeRotationCycle];
      break;
    case MDCActivityIndicatorModeDeterminate:
      [self addProgressAnimation];
      break;
  }
}

- (void)actuallyStopAnimating {
  if (!_animationsAdded) {
    return;
  }

  [self removeAnimations];
  [self applyPropertiesWithoutAnimation:^{
    _strokeLayer.strokeStart = 0.0f;
    _strokeLayer.strokeEnd = 0.0f;
  }];
}

- (void)updateStrokePath {
  CGFloat offsetRadius = _radius - _strokeLayer.lineWidth / 2.0f;
  UIBezierPath *strokePath = [UIBezierPath bezierPathWithArcCenter:_strokeLayer.position
                                                            radius:offsetRadius
                                                        startAngle:-1.0f * (CGFloat)M_PI_2
                                                          endAngle:3.0f * (CGFloat)M_PI_2
                                                         clockwise:YES];
  _strokeLayer.path = strokePath.CGPath;
  _trackLayer.path = strokePath.CGPath;

  _minStrokeDifference = _strokeLayer.lineWidth / ((CGFloat)M_PI * 2 * _radius);
}

- (void)updateStrokeColor {
  if (_cycleColors.count > 0) {
    [self setStrokeColor:_cycleColors[_currentColorCount]];
  } else {
    [self setStrokeColor:[MDCActivityIndicator defaultColors][0]];
  }
}

- (void)addStrokeRotationCycle {
  if (_animationInProgress) {
    return;
  }

  [CATransaction begin];
  {
    [CATransaction setCompletionBlock:^{
      [self strokeRotationCycleFinishedFromState:MDCActivityIndicatorStateIndeterminate];
    }];

    // Outer 5-point star detent rotation.
    CABasicAnimation *outerRotationAnimation =
        [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    outerRotationAnimation.duration = kMDCActivityIndicatorPointCycleDuration;
    outerRotationAnimation.fromValue = @(kOuterRotationIncrement * _cycleCount);
    outerRotationAnimation.toValue = @(kOuterRotationIncrement * (_cycleCount + 1));
    outerRotationAnimation.fillMode = kCAFillModeForwards;
    outerRotationAnimation.removedOnCompletion = NO;
    [_outerRotationLayer addAnimation:outerRotationAnimation forKey:@"transform.rotation.z"];

    // Stroke rotation.
    CGFloat startRotation = _cycleCount * (CGFloat)M_PI;
    CGFloat endRotation = startRotation + kCycleRotation * (CGFloat)M_PI;

    CABasicAnimation *strokeRotationAnimation =
        [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    strokeRotationAnimation.duration = kMDCActivityIndicatorPointCycleDuration;
    strokeRotationAnimation.fromValue = @(startRotation);
    strokeRotationAnimation.toValue = @(endRotation);
    strokeRotationAnimation.fillMode = kCAFillModeForwards;
    strokeRotationAnimation.removedOnCompletion = NO;
    [_strokeLayer addAnimation:strokeRotationAnimation forKey:@"transform.rotation.z"];

    // Stroke start.
    CABasicAnimation *strokeStartPathAnimation =
        [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartPathAnimation.duration = kMDCActivityIndicatorPointCycleDuration / 2;
    // It is always critical to convertTime:fromLayer: for animations, since changes to layer.speed
    // on this layer or parent layers will alter the offset of beginTime.
    CFTimeInterval currentTime = [_strokeLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    strokeStartPathAnimation.beginTime = currentTime + kMDCActivityIndicatorPointCycleDuration / 2;
    strokeStartPathAnimation.fromValue = @(0.0f);
    strokeStartPathAnimation.toValue = @(kStrokeLength);
    strokeStartPathAnimation.timingFunction = [self materialEaseInOut];
    strokeStartPathAnimation.fillMode = kCAFillModeBoth;
    strokeStartPathAnimation.removedOnCompletion = NO;
    [_strokeLayer addAnimation:strokeStartPathAnimation forKey:@"strokeStart"];

    // Stroke end.
    CABasicAnimation *strokeEndPathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndPathAnimation.duration =
        kMDCActivityIndicatorPointCycleDuration * ABS(_lastProgress - _currentProgress);
    // Ensure the stroke never completely disappears on start by animating from non-zero start and
    // to a value slightly larger than the strokeStart's final value.
    strokeEndPathAnimation.fromValue = @(_minStrokeDifference);
    strokeEndPathAnimation.toValue = @(kStrokeLength + _minStrokeDifference);
    strokeEndPathAnimation.timingFunction = [self materialEaseInOut];
    strokeEndPathAnimation.fillMode = kCAFillModeBoth;
    strokeEndPathAnimation.removedOnCompletion = NO;
    [_strokeLayer addAnimation:strokeEndPathAnimation forKey:@"strokeEnd"];
  }
  [CATransaction commit];

  _animationInProgress = YES;
}

- (void)addTransitionToIndeterminateCycle {
  if (_animationInProgress) {
    return;
  }
  // Find the nearest cycle to transition through.
  NSInteger nearestCycle = 0;
  CGFloat nearestDistance = CGFLOAT_MAX;
  const CGFloat normalizedProgress = MAX(_lastProgress - _minStrokeDifference, 0.0f);
  for (NSInteger cycle = 0; cycle < kMDCActivityIndicatorTotalDetentCount; cycle++) {
    const CGFloat currentRotation = [self normalizedRotationForCycle:cycle];
    if (currentRotation >= normalizedProgress) {
      if (nearestDistance >= (currentRotation - normalizedProgress)) {
        nearestDistance = currentRotation - normalizedProgress;
        nearestCycle = cycle;
      }
    }
  }

  if (nearestCycle == 0 && _lastProgress <= _minStrokeDifference) {
    // Special case for 0% progress.
    _cycleCount = nearestCycle;
    [self strokeRotationCycleFinishedFromState:MDCActivityIndicatorStateTransitionToIndeterminate];
    return;
  }

  _cycleCount = nearestCycle;

  CGFloat targetRotation = [self normalizedRotationForCycle:nearestCycle];
  if (targetRotation <= 0.001f) {
    targetRotation = 1.0f;
  }
  CGFloat normalizedDuration = 2 * (targetRotation + _currentProgress) / kSingleCycleRotation *
                               (CGFloat)kMDCActivityIndicatorPointCycleDuration;
  CGFloat strokeEndTravelDistance = targetRotation - _currentProgress + _minStrokeDifference;
  CGFloat totalDistance = targetRotation + strokeEndTravelDistance;
  CGFloat strokeStartDuration =
      MAX(normalizedDuration * targetRotation / totalDistance,
          (CGFloat)kMDCActivityIndicatorPointCycleMinimumVariableDuration);
  CGFloat strokeEndDuration = MAX(normalizedDuration * strokeEndTravelDistance / totalDistance,
                                  (CGFloat)kMDCActivityIndicatorPointCycleMinimumVariableDuration);

  [CATransaction begin];
  {
    [CATransaction setCompletionBlock:^{
      [self
          strokeRotationCycleFinishedFromState:MDCActivityIndicatorStateTransitionToIndeterminate];
    }];

    // Stroke start.
    CABasicAnimation *strokeStartPathAnimation =
        [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartPathAnimation.duration = strokeStartDuration;
    CFTimeInterval currentTime = [_strokeLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    strokeStartPathAnimation.beginTime = currentTime + strokeEndDuration;
    strokeStartPathAnimation.fromValue = @(0.0f);
    strokeStartPathAnimation.toValue = @(targetRotation);
    strokeStartPathAnimation.timingFunction = [self materialEaseInOut];
    ;
    strokeStartPathAnimation.fillMode = kCAFillModeBoth;
    strokeStartPathAnimation.removedOnCompletion = NO;
    [_strokeLayer addAnimation:strokeStartPathAnimation forKey:@"strokeStart"];

    // Stroke end.
    CABasicAnimation *strokeEndPathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndPathAnimation.duration = strokeEndDuration;
    // Ensure the stroke never completely disappears on start by animating from non-zero start and
    // to a value slightly larger than the strokeStart's final value.
    strokeEndPathAnimation.fromValue = @(_currentProgress);
    strokeEndPathAnimation.toValue = @(targetRotation + _minStrokeDifference);
    strokeEndPathAnimation.timingFunction = [self materialEaseInOut];
    strokeEndPathAnimation.fillMode = kCAFillModeBoth;
    strokeEndPathAnimation.removedOnCompletion = NO;
    [_strokeLayer addAnimation:strokeEndPathAnimation forKey:@"strokeEnd"];
  }
  [CATransaction commit];

  _animationInProgress = YES;
}

- (void)addTransitionToDeterminateCycle {
  if (_animationInProgress) {
    return;
  }
  if (!_cycleCount) {
    // The animation period is complete: no need for transition.
    [_strokeLayer removeAllAnimations];
    [_outerRotationLayer removeAllAnimations];
    // Necessary for transition from indeterminate to determinate when cycle == 0.
    _currentProgress = 0.0f;
    _lastProgress = _currentProgress;
    [self strokeRotationCycleFinishedFromState:MDCActivityIndicatorStateTransitionToDeterminate];
  } else {
    _currentProgress = MAX(_progress, _minStrokeDifference);

    CGFloat rotationDelta = 1.0f - [self normalizedRotationForCycle:_cycleCount];

    // Change the duration relative to the distance in order to keep same relative speed.
    CGFloat duration = 2.0f * (rotationDelta + _currentProgress) / kSingleCycleRotation *
                       (CGFloat)kMDCActivityIndicatorPointCycleDuration;

    duration = MAX(duration, (CGFloat)kMDCActivityIndicatorPointCycleMinimumVariableDuration);
    [CATransaction begin];
    {
      [CATransaction setCompletionBlock:^{
        [self
            strokeRotationCycleFinishedFromState:MDCActivityIndicatorStateTransitionToDeterminate];
      }];

      // Outer 5-point star detent rotation. Required for passing from transitionToIndeterminate to
      // transitionToDeterminate.
      CABasicAnimation *outerRotationAnimation =
          [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
      outerRotationAnimation.duration = duration;
      outerRotationAnimation.fromValue = @(kOuterRotationIncrement * _cycleCount);
      outerRotationAnimation.toValue = @(kOuterRotationIncrement * _cycleCount);
      outerRotationAnimation.fillMode = kCAFillModeForwards;
      outerRotationAnimation.removedOnCompletion = NO;
      [_outerRotationLayer addAnimation:outerRotationAnimation forKey:@"transform.rotation.z"];

      // Stroke rotation.
      CGFloat startRotation = _cycleCount * (CGFloat)M_PI;
      CGFloat endRotation = startRotation + rotationDelta * 2.0f * (CGFloat)M_PI;

      CABasicAnimation *strokeRotationAnimation =
          [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
      strokeRotationAnimation.duration = duration;
      strokeRotationAnimation.fromValue = @(startRotation);
      strokeRotationAnimation.toValue = @(endRotation);
      strokeRotationAnimation.fillMode = kCAFillModeForwards;
      strokeRotationAnimation.removedOnCompletion = NO;
      [_strokeLayer addAnimation:strokeRotationAnimation forKey:@"transform.rotation.z"];

      // Stroke start.
      CABasicAnimation *strokeStartPathAnimation =
          [CABasicAnimation animationWithKeyPath:@"strokeStart"];
      strokeStartPathAnimation.duration = duration;
      // It is always critical to convertTime:fromLayer: for animations, since changes to
      // layer.speed on this layer or parent layers will alter the offset of beginTime.
      CFTimeInterval currentTime = [_strokeLayer convertTime:CACurrentMediaTime() fromLayer:nil];
      strokeStartPathAnimation.beginTime = currentTime;
      strokeStartPathAnimation.fromValue = @(0.0f);
      strokeStartPathAnimation.toValue = @(0.0f);
      strokeStartPathAnimation.timingFunction = [self materialEaseInOut];
      strokeStartPathAnimation.fillMode = kCAFillModeBoth;
      strokeStartPathAnimation.removedOnCompletion = NO;
      [_strokeLayer addAnimation:strokeStartPathAnimation forKey:@"strokeStart"];

      // Stroke end.
      CABasicAnimation *strokeEndPathAnimation =
          [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
      strokeEndPathAnimation.duration = duration;
      // Ensure the stroke never completely disappears on start by animating from non-zero start and
      // to a value slightly larger than the strokeStart's final value.
      strokeEndPathAnimation.fromValue = @(_minStrokeDifference);
      strokeEndPathAnimation.toValue = @(_currentProgress);
      strokeEndPathAnimation.timingFunction = [self materialEaseInOut];
      strokeEndPathAnimation.fillMode = kCAFillModeBoth;
      strokeEndPathAnimation.removedOnCompletion = NO;
      [_strokeLayer addAnimation:strokeEndPathAnimation forKey:@"strokeEnd"];
    }
    [CATransaction commit];

    _animationInProgress = YES;
    _lastProgress = _currentProgress;
  }
}

- (CAMediaTimingFunction *)materialEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

- (void)addProgressAnimation {
  if (_animationInProgress) {
    return;
  }

  _currentProgress = MAX(_progress, _minStrokeDifference);

  [CATransaction begin];
  {
    [CATransaction setCompletionBlock:^{
      [self strokeRotationCycleFinishedFromState:MDCActivityIndicatorStateDeterminate];
    }];

    // Stroke end.
    CABasicAnimation *strokeEndPathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndPathAnimation.duration = kMDCActivityIndicatorPointCycleDuration / 2;
    strokeEndPathAnimation.fromValue = @(_lastProgress);
    strokeEndPathAnimation.toValue = @(_currentProgress);
    strokeEndPathAnimation.timingFunction = [self materialEaseInOut];
    strokeEndPathAnimation.fillMode = kCAFillModeBoth;
    strokeEndPathAnimation.removedOnCompletion = NO;
    [_strokeLayer addAnimation:strokeEndPathAnimation forKey:@"strokeEnd"];
  }

  [CATransaction commit];

  _lastProgress = _currentProgress;
  _animationInProgress = YES;
}

- (void)strokeRotationCycleFinishedFromState:(MDCActivityIndicatorState)state {
  _animationInProgress = NO;

  if (!_animationsAdded) {
    return;
  }
  if (state == MDCActivityIndicatorStateIndeterminate) {
    if (_cycleColors.count > 0) {
      _currentColorCount = (_currentColorCount + 1) % _cycleColors.count;
      [self updateStrokeColor];
    }
    _cycleCount = (_cycleCount + 1) % kMDCActivityIndicatorTotalDetentCount;
  }

  switch (_indicatorMode) {
    case MDCActivityIndicatorModeDeterminate:
      switch (state) {
        case MDCActivityIndicatorStateDeterminate:
        case MDCActivityIndicatorStateTransitionToDeterminate:
          [self addProgressAnimationIfRequired];
          break;
        case MDCActivityIndicatorStateIndeterminate:
        case MDCActivityIndicatorStateTransitionToIndeterminate:
          [self addTransitionToDeterminateCycle];
          break;
      }
      break;
    case MDCActivityIndicatorModeIndeterminate:
      switch (state) {
        case MDCActivityIndicatorStateDeterminate:
        case MDCActivityIndicatorStateTransitionToDeterminate:
          [self addTransitionToIndeterminateCycle];
          break;
        case MDCActivityIndicatorStateIndeterminate:
        case MDCActivityIndicatorStateTransitionToIndeterminate:
          [self addStrokeRotationCycle];
          break;
      }
      break;
  }
}

- (void)addProgressAnimationIfRequired {
  if (_indicatorMode == MDCActivityIndicatorModeDeterminate) {
    if (MAX(_progress, _minStrokeDifference) != _currentProgress) {
      // The values were changes in the while animating or animation is starting.
      [self addProgressAnimation];
    }
  }
}

/**
 Rotation that a given cycle has. Represented between 0.0f (cycle has no rotation) and 1.0f.
 */
- (CGFloat)normalizedRotationForCycle:(NSInteger)cycle {
  CGFloat cycleRotation = cycle * kSingleCycleRotation / 2.0f;
  return cycleRotation - ((NSInteger)cycleRotation);
}

- (void)animateOut {
  _animatingOut = YES;

  [CATransaction begin];

  [CATransaction setCompletionBlock:^{
    if (_animatingOut) {
      [self removeAnimations];
      if ([_delegate respondsToSelector:@selector(activityIndicatorAnimationDidFinish:)]) {
        [_delegate activityIndicatorAnimationDidFinish:self];
      }
    }
  }];
  [CATransaction setAnimationDuration:kMDCActivityIndicatorAnimateOutDuration];

  _strokeLayer.lineWidth = 0;
  _trackLayer.lineWidth = 0;

  [CATransaction commit];
}

- (void)removeAnimations {
  _animationsAdded = NO;
  _animatingOut = NO;
  [_strokeLayer removeAllAnimations];
  [_outerRotationLayer removeAllAnimations];

  // Reset cycle count to 0 rather than cycleStart to reflect default starting position (top).
  _cycleCount = 0;
  // However _animationInProgress represents the CATransaction that hasn't finished, so we leave it
  // alone here.
}

+ (CGFloat)defaultHeight {
  return kSpinnerRadius * 2.f;
}

- (void)applyPropertiesWithoutAnimation:(void (^)(void))setPropBlock {
  [CATransaction begin];

  // Disable implicit CALayer animations
  [CATransaction setDisableActions:YES];
  setPropBlock();

  [CATransaction commit];
}

+ (NSArray<UIColor *> *)defaultColors {
  static NSArray *defaultColors;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    defaultColors = @[
      [[UIColor alloc] initWithRed:0.129f green:0.588f blue:0.953f alpha:1],
      [[UIColor alloc] initWithRed:0.957f green:0.263f blue:0.212f alpha:1],
      [[UIColor alloc] initWithRed:1.0f green:0.922f blue:0.231f alpha:1],
      [[UIColor alloc] initWithRed:0.298f green:0.686f blue:0.314f alpha:1]
    ];
  });
  return defaultColors;
}

@end
