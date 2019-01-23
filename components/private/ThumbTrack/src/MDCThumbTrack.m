// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCThumbTrack.h"
#import "private/MDCThumbTrack+Private.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCNumericValueLabel.h"
#import "MDCThumbView.h"
#import "MaterialInk.h"
#import "MaterialMath.h"

#pragma mark - ThumbTrack constants

static const CGFloat kAnimationDuration = (CGFloat)0.25;
static const CGFloat kThumbChangeAnimationDuration = (CGFloat)0.12;
static const CGFloat kDefaultThumbBorderWidth = 2;
static const CGFloat kDefaultThumbRadius = 6;
static const CGFloat kDefaultTrackHeight = 2;
static const CGFloat kDefaultFilledTrackAnchorValue = -CGFLOAT_MAX;
static const CGFloat kTrackOnAlpha = (CGFloat)0.5;
static const CGFloat kMinTouchSize = 48;
static const CGFloat kThumbSlopFactor = (CGFloat)3.5;
static const CGFloat kValueLabelHeight = 48;
static const CGFloat kValueLabelWidth = (CGFloat)0.81 * kValueLabelHeight;
static const CGFloat kValueLabelFontSize = 12;

static UIColor *ValueLabelTextColorDefault() {
  return UIColor.whiteColor;
}

static UIColor *ValueLabelBackgroundColorDefault() {
  return UIColor.blueColor;
}

static UIColor *TrackOnColorDefault() {
  return UIColor.blueColor;
}

static UIColor *ThumbEnabledColorDefault() {
  return UIColor.blueColor;
}

static UIColor *InkColorDefault() {
  return [UIColor.blueColor colorWithAlphaComponent:kTrackOnAlpha];
}

@implementation MDCDiscreteDotView

- (instancetype)init {
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    _inactiveDotColor = UIColor.blackColor;
    _activeDotColor = UIColor.blackColor;
    _activeDotsSegment = CGRectMake(CGFLOAT_MIN, 0, 0, 0);
  }
  return self;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  [self setNeedsDisplay];
}

- (void)setActiveDotColor:(UIColor *)activeDotColor {
  _activeDotColor = activeDotColor;
  [self setNeedsDisplay];
}

- (void)setInactiveDotColor:(UIColor *)inactiveDotColor {
  _inactiveDotColor = inactiveDotColor;
  [self setNeedsDisplay];
}

- (void)setActiveDotsSegment:(CGRect)activeDotsSegment {
  CGFloat newMinX = MAX(0, MIN(1, CGRectGetMinX(activeDotsSegment)));
  CGFloat newMaxX = MIN(1, MAX(0, CGRectGetMaxX(activeDotsSegment)));

  _activeDotsSegment = CGRectMake(newMinX, 0, (newMaxX - newMinX), 0);
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];

  if (_numDiscreteDots >= 2) {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    CGRect circleRect = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    // Increment within the bounds
    CGFloat absoluteIncrement =
        (self.bounds.size.width - self.bounds.size.height) / (_numDiscreteDots - 1);
    // Increment within 0..1
    CGFloat relativeIncrement = (CGFloat)1.0 / (_numDiscreteDots - 1);

    // Allow an extra 10% of the increment to guard against rounding errors excluding dots that
    // should genuinely be within the active segment.
    CGFloat minActiveX = CGRectGetMinX(self.activeDotsSegment) - relativeIncrement * (CGFloat)0.1;
    CGFloat maxActiveX = CGRectGetMaxX(self.activeDotsSegment) + relativeIncrement * (CGFloat)0.1;
    for (NSUInteger i = 0; i < _numDiscreteDots; i++) {
      CGFloat relativePosition = i * relativeIncrement;
      if (minActiveX <= relativePosition && maxActiveX >= relativePosition) {
        [self.activeDotColor setFill];
      } else {
        [self.inactiveDotColor setFill];
      }
      circleRect.origin.x = (i * absoluteIncrement);
      CGContextFillEllipseInRect(contextRef, circleRect);
    }
  }
}

- (void)setNumDiscreteDots:(NSUInteger)numDiscreteDots {
  _numDiscreteDots = numDiscreteDots;
  [self setNeedsDisplay];
}

@end

// TODO(iangordon): Properly handle broken tgmath

/**
 Returns the distance between two points.

 @param point1 a CGPoint to measure from.
 @param point2 a CGPoint to meature to.

 @return Absolute straight line distance.
 */
static inline CGFloat DistanceFromPointToPoint(CGPoint point1, CGPoint point2) {
  return MDCHypot(point1.x - point2.x, point1.y - point2.y);
}

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface MDCThumbTrack () <CAAnimationDelegate>
@end
#endif

@interface MDCThumbTrack () <MDCInkTouchControllerDelegate>
@end

@implementation MDCThumbTrack {
  CGFloat _lastDispatchedValue;
  UIColor *_clearColor;
  MDCInkTouchController *_touchController;
  UIView *_trackView;
  CAShapeLayer *_trackMaskLayer;
  CALayer *_trackOnLayer;
  MDCDiscreteDotView *_discreteDots;
  BOOL _shouldDisplayInk;
  MDCNumericValueLabel *_valueLabel;
  UIPanGestureRecognizer *_dummyPanRecognizer;

  // Attributes to handle interaction. To associate touches to previous touches, we keep a reference
  // to the current touch, since the system reuses the same memory address when sending subsequent
  // touches for the same gesture. If _currentTouch == nil, then there's no interaction going on.
  UITouch *_currentTouch;
  BOOL _isDraggingThumb;
  BOOL _didChangeValueDuringPan;
  CGFloat _panThumbGrabPosition;
}

@synthesize thumbEnabledColor = _thumbEnabledColor;
@synthesize trackOnColor = _trackOnColor;

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

    _primaryColor = onTintColor ?: TrackOnColorDefault();
    _thumbEnabledColor = onTintColor ?: ThumbEnabledColorDefault();
    _trackOnColor = onTintColor ?: TrackOnColorDefault();
    _valueLabelBackgroundColor = onTintColor ?: ValueLabelBackgroundColorDefault();
    _touchController.defaultInkView.inkColor =
        onTintColor ? [onTintColor colorWithAlphaComponent:kTrackOnAlpha] : InkColorDefault();
    _clearColor = UIColor.clearColor;
    _valueLabelTextColor = ValueLabelTextColorDefault();
    _trackOnTickColor = UIColor.blackColor;
    _trackOffTickColor = UIColor.blackColor;
    [self setNeedsLayout];

    // We add this UIPanGestureRecognizer to our view so that any superviews of the thumb track know
    // when we are dragging the thumb track, and can treat it accordingly. Specifically, without
    // this if a ThumbTrack is contained within a UIScrollView, the scroll view will cancel any
    // touch events sent to the thumb track whenever the view is scrolling, regardless of whether or
    // not we're in the middle of dragging the thumb. Adding a dummy gesture recognizer lets the
    // scroll view know that we are in the middle of dragging, so those touch events shouldn't be
    // cancelled.
    //
    // Note that an alternative to this would be to set canCancelContentTouches = NO on the
    // UIScrollView, but because we can't guarantee that the thumb track will always be contained in
    // scroll views configured like that, we have to handle it within the thumb track.
    _dummyPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
    _dummyPanRecognizer.cancelsTouchesInView = NO;
    [self updateDummyPanRecognizerTarget];

    [self setValue:_minimumValue animated:NO];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self updateTrackMask];
  [self updateThumbTrackAnimated:NO animateThumbAfterMove:NO previousValue:_value completion:nil];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(__unused UIEvent *)event {
  CGFloat dx = MIN(0, kDefaultThumbRadius - kMinTouchSize / 2);
  CGFloat dy = MIN(0, (self.bounds.size.height - kMinTouchSize) / 2);
  CGRect rect = CGRectInset(self.bounds, dx, dy);
  return CGRectContainsPoint(rect, point);
}

#pragma mark - Properties

- (void)setPrimaryColor:(UIColor *)primaryColor {
  _primaryColor = primaryColor ?: TrackOnColorDefault();

  _thumbEnabledColor = self.primaryColor;
  _trackOnColor = self.primaryColor;

  _touchController.defaultInkView.inkColor =
      [self.primaryColor colorWithAlphaComponent:kTrackOnAlpha];
  _valueLabelBackgroundColor = self.primaryColor;
  [self setNeedsLayout];
}

- (void)setInkColor:(UIColor *)inkColor {
  _touchController.defaultInkView.inkColor = inkColor;
  [self setNeedsLayout];
}

- (UIColor *)inkColor {
  return _touchController.defaultInkView.inkColor;
}

- (void)setThumbEnabledColor:(UIColor *)thumbEnabledColor {
  _thumbEnabledColor = thumbEnabledColor ?: ThumbEnabledColorDefault();
  [self setNeedsLayout];
}

- (void)setTrackOnColor:(UIColor *)trackOnColor {
  _trackOnColor = trackOnColor ?: TrackOnColorDefault();
  [self setNeedsLayout];
}

- (void)setThumbDisabledColor:(UIColor *)thumbDisabledColor {
  _thumbDisabledColor = thumbDisabledColor;
  [self setNeedsLayout];
}

- (void)setTrackOffColor:(UIColor *)trackOffColor {
  _trackOffColor = trackOffColor;
  [self setNeedsLayout];
}

- (void)setTrackDisabledColor:(UIColor *)trackDisabledColor {
  _trackDisabledColor = trackDisabledColor;
  [self setNeedsLayout];
}

- (void)setValueLabelTextColor:(UIColor *)valueLabelTextColor {
  _valueLabelTextColor = valueLabelTextColor ?: ValueLabelTextColorDefault();
  [self setNeedsLayout];
}

- (void)setValueLabelBackgroundColor:(UIColor *)valueLabelBackgroundColor {
  _valueLabelBackgroundColor = valueLabelBackgroundColor ?: ValueLabelBackgroundColorDefault();
  [self setNeedsLayout];
}

- (void)setTrackOnTickColor:(UIColor *)trackOnTickColor {
  _trackOnTickColor = trackOnTickColor;
  if (_discreteDots) {
    _discreteDots.activeDotColor = trackOnTickColor;
    [self setNeedsLayout];
  }
}

- (void)setTrackOffTickColor:(UIColor *)trackOffTickColor {
  _trackOffTickColor = trackOffTickColor;
  if (_discreteDots) {
    _discreteDots.inactiveDotColor = trackOffTickColor;
    [self setNeedsLayout];
  }
}

- (void)setThumbElevation:(MDCShadowElevation)thumbElevation {
  _thumbView.elevation = thumbElevation;
}

- (MDCShadowElevation)thumbElevation {
  return _thumbView.elevation;
}

- (void)setShouldDisplayDiscreteDots:(BOOL)shouldDisplayDiscreteDots {
  if (_shouldDisplayDiscreteDots != shouldDisplayDiscreteDots) {
    if (shouldDisplayDiscreteDots) {
      _discreteDots = [[MDCDiscreteDotView alloc] init];
      _discreteDots.alpha = 0.0;
      _discreteDots.activeDotColor = self.trackOnTickColor;
      _discreteDots.inactiveDotColor = self.trackOffTickColor;
      [_trackView addSubview:_discreteDots];
    } else {
      [_discreteDots removeFromSuperview];
      _discreteDots = nil;
    }
    _shouldDisplayDiscreteDots = shouldDisplayDiscreteDots;
  }
}

- (void)setShouldDisplayDiscreteValueLabel:(BOOL)shouldDisplayDiscreteValueLabel {
  if (_shouldDisplayDiscreteValueLabel == shouldDisplayDiscreteValueLabel) {
    return;
  }

  _shouldDisplayDiscreteValueLabel = shouldDisplayDiscreteValueLabel;

  if (shouldDisplayDiscreteValueLabel) {
    _valueLabel = [[MDCNumericValueLabel alloc]
        initWithFrame:CGRectMake(0, 0, kValueLabelWidth, kValueLabelHeight)];
    // Effectively 0, but setting it to 0 results in animation not happening
    _valueLabel.transform = CGAffineTransformMakeScale((CGFloat)0.001, (CGFloat)0.001);
    _valueLabel.fontSize = kValueLabelFontSize;
    [self addSubview:_valueLabel];
  } else {
    [_valueLabel removeFromSuperview];
    _valueLabel = nil;
  }
}

- (BOOL)shouldDisplayFilledTrack {
  return [_trackOnLayer superlayer] != nil;
}

- (void)setShouldDisplayFilledTrack:(BOOL)shouldDisplayFilledTrack {
  if (shouldDisplayFilledTrack) {
    if ([_trackOnLayer superlayer] == nil) {
      [_trackView.layer addSublayer:_trackOnLayer];
    }
  } else {
    [_trackOnLayer removeFromSuperlayer];
  }
}

- (void)setMinimumValue:(CGFloat)minimumValue {
  _minimumValue = minimumValue;
  CGFloat previousValue = _value;
  if (_value < _minimumValue) {
    _value = _minimumValue;
  }
  if (_maximumValue < _minimumValue) {
    _maximumValue = _minimumValue;
  }
  [self updateThumbTrackAnimated:NO
           animateThumbAfterMove:NO
                   previousValue:previousValue
                      completion:NULL];
}

- (void)setMaximumValue:(CGFloat)maximumValue {
  _maximumValue = maximumValue;
  CGFloat previousValue = _value;
  if (_value > _maximumValue) {
    _value = _maximumValue;
  }
  if (_minimumValue > _maximumValue) {
    _minimumValue = _maximumValue;
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

- (void)setPanningAllowedOnEntireControl:(BOOL)panningAllowedOnEntireControl {
  if (_panningAllowedOnEntireControl != panningAllowedOnEntireControl) {
    _panningAllowedOnEntireControl = panningAllowedOnEntireControl;
    [self updateDummyPanRecognizerTarget];
  }
}

- (void)setFilledTrackAnchorValue:(CGFloat)filledTrackAnchorValue {
  _filledTrackAnchorValue = MAX(_minimumValue, MIN(filledTrackAnchorValue, _maximumValue));
  [self setNeedsLayout];
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
               completion:(void (^)(void))completion {
  CGFloat previousValue = _value;
  CGFloat newValue = MAX(_minimumValue, MIN(value, _maximumValue));
  newValue = [self closestValueToTargetValue:newValue];
  if (newValue != previousValue && [_delegate respondsToSelector:@selector(thumbTrack:
                                                                      willJumpToValue:)]) {
    [self.delegate thumbTrack:self willJumpToValue:newValue];
  }
  _value = newValue;

  if (!userGenerated) {
    _lastDispatchedValue = _value;
  }

  if (_value != previousValue) {
    [self interruptAnimation];
    [self updateThumbTrackAnimated:animated
             animateThumbAfterMove:animateThumbAfterMove
                     previousValue:previousValue
                        completion:completion];
  }
}

- (void)setNumDiscreteValues:(NSUInteger)numDiscreteValues {
  _numDiscreteValues = numDiscreteValues;
  _discreteDots.numDiscreteDots = numDiscreteValues;
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

- (void)setIcon:(nullable UIImage *)icon {
  [_thumbView setIcon:icon];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  if (enabled) {
    [self setPrimaryColor:_primaryColor];
  }
  [self setNeedsLayout];
}

#pragma mark - MDCInkTouchControllerDelegate

- (BOOL)inkTouchController:(nonnull __unused MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(__unused CGPoint)location {
  return _shouldDisplayInk;
}

#pragma mark - Animation helpers

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

- (void)interruptAnimation {
  if (_thumbView.layer.presentationLayer) {
    _thumbView.layer.position = [(CALayer *)_thumbView.layer.presentationLayer position];
    _valueLabel.layer.position = [(CALayer *)_valueLabel.layer.presentationLayer position];
  }
  [_thumbView.layer removeAllAnimations];
  [_trackView.layer removeAllAnimations];
  [_valueLabel.layer removeAllAnimations];
  [_trackOnLayer removeAllAnimations];
}

#pragma mark - Layout and animation

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
                      completion:(void (^)(void))completion {
  [self updateViewsNoAnimation];

  BOOL activeSegmentShrinking = MDCFabs(self.value - self.filledTrackAnchorValue) <
                                MDCFabs(previousValue - self.filledTrackAnchorValue);

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

      // If the active segment is shrinking, we will update the dot colors immediately. If it's
      // growing, update the colors here in the completion block.
      if (!activeSegmentShrinking) {
        [self updateDotsViewActiveSegment];
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
      CGFloat animationDurationToAnchor = (MDCFabs(previousValue - _filledTrackAnchorValue) /
                                           MDCFabs(previousValue - currentValue)) *
                                          kAnimationDuration;
      void (^afterCrossingAnchorAnimation)(BOOL) = ^void(__unused BOOL finished) {
        UIViewAnimationOptions options = baseAnimationOptions | UIViewAnimationOptionCurveEaseOut;
        [UIView animateWithDuration:(kAnimationDuration - animationDurationToAnchor)
                              delay:0
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
                            delay:0
                          options:options
                       animations:^{
                         self.value = self.filledTrackAnchorValue;
                         [self updateViewsMainIsAnimated:animated
                                            withDuration:animationDurationToAnchor
                                        animationOptions:options];
                         self.value = currentValue;
                       }
                       completion:afterCrossingAnchorAnimation];
    } else {
      [UIView animateWithDuration:kAnimationDuration
                            delay:0
                          options:baseAnimationOptions
                       animations:^{
                         if (activeSegmentShrinking) {
                           [self updateDotsViewActiveSegment];
                         }
                         [self updateViewsMainIsAnimated:animated
                                            withDuration:kAnimationDuration
                                        animationOptions:baseAnimationOptions];
                       }
                       completion:animationCompletion];
    }
  } else {
    [self updateViewsMainIsAnimated:animated withDuration:0 animationOptions:baseAnimationOptions];
    [self updateDotsViewActiveSegment];
    [self updateThumbAfterMoveAnimated:animateThumbAfterMove
                               options:baseAnimationOptions
                            completion:completion];
  }
}

- (void)updateThumbAfterMoveAnimated:(BOOL)animated
                             options:(UIViewAnimationOptions)animationOptions
                          completion:(void (^)(void))completion {
  if (animated) {
    [UIView animateWithDuration:kThumbChangeAnimationDuration
        delay:0
        options:animationOptions
        animations:^{
          [self updateViewsForThumbAfterMoveIsAnimated:animated
                                          withDuration:kThumbChangeAnimationDuration];
        }
        completion:^void(__unused BOOL _) {
          if (completion) {
            completion();
          }
        }];
  } else {
    [self updateViewsForThumbAfterMoveIsAnimated:animated withDuration:0];

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
    if (!_thumbIsHollowAtStart || ![self isValueAtMinimum]) {
      [self updateTrackMask];

      _thumbView.backgroundColor = _thumbEnabledColor;
      _thumbView.layer.borderColor = _thumbEnabledColor.CGColor;
    }
  } else {
    _thumbView.backgroundColor = _thumbDisabledColor;
    _thumbView.layer.borderColor = _clearColor.CGColor;

    if (_thumbIsSmallerWhenDisabled) {
      [self setDisplayThumbRadius:_thumbRadius - _trackHeight];
    }
  }
}

- (void)updateDotsViewActiveSegment {
  if (!MDCCGFloatEqual(self.maximumValue, self.minimumValue)) {
    CGFloat relativeAnchorPoint =
        (self.filledTrackAnchorValue - self.minimumValue) / (self.maximumValue - self.minimumValue);
    CGFloat relativeValuePoint =
        (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue);
    CGFloat activeSegmentWidth = MDCFabs(relativeAnchorPoint - relativeValuePoint);
    CGFloat activeSegmentOriginX = MIN(relativeAnchorPoint, relativeValuePoint);
    _discreteDots.activeDotsSegment = CGRectMake(activeSegmentOriginX, 0, activeSegmentWidth, 0);
  }
}

/**
 Updates the properties of the ThumbTrack that are animated in the main animation body. May be
 called from within a UIView animation block.
 */
- (void)updateViewsMainIsAnimated:(__unused BOOL)animated
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

  // Make sure discrete dots match up
  _discreteDots.frame = [_trackView bounds];

  // Make sure Numeric Value Label matches up
  if (_shouldDisplayDiscreteValueLabel && _numDiscreteValues > 1) {
    // Note that "center" here doesn't refer to the actual center, but rather the anchor point,
    // which is re-defined to be slightly below the bottom of the label
    _valueLabel.center = [self numericValueLabelPositionForValue:_value];
    _valueLabel.backgroundColor = self.valueLabelBackgroundColor;
    _valueLabel.textColor = self.valueLabelTextColor;
    if ([_delegate respondsToSelector:@selector(thumbTrack:stringForValue:)]) {
      _valueLabel.text = [_delegate thumbTrack:self stringForValue:_value];
      if (CGRectGetWidth(_valueLabel.frame) > 1) {
        // Reset the size prior to pixel alignement since previous alignement likely increased it
        CGRect valueLabelFrame = CGRectMake(_valueLabel.frame.origin.x, _valueLabel.frame.origin.y,
                                            kValueLabelWidth, kValueLabelHeight);
        // TODO(https://github.com/material-components/material-components-ios/issues/3326 ):
        //   Don't assign the frame AND the center (above). Do it only once to avoid extra layout
        //   passes. This is the cause of the visual glitch seen when coloring the "active" tick
        //   marks in the _discreteDots view.
        _valueLabel.frame = MDCRectAlignToScale(valueLabelFrame, [UIScreen mainScreen].scale);
      }
    }
  }

  // Update colors, etc.
  if (self.enabled) {
    _trackView.backgroundColor = _trackOffColor;
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
    [CATransaction
        setAnimationTimingFunction:[self
                                       timingFunctionFromUIViewAnimationOptions:animationOptions]];
    [CATransaction setAnimationDuration:duration];
    _trackOnLayer.frame =
        CGRectMake(trackOnXValue, 0, MDCFabs(currentXValue - anchorXValue), _trackHeight);
    [CATransaction commit];
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
  if (_shouldDisplayDiscreteDots) {
    if (self.enabled && _isDraggingThumb) {
      _discreteDots.alpha = 1.0;
    } else {
      _discreteDots.alpha = 0.0;
    }
  }

  if (_shouldDisplayDiscreteValueLabel && _numDiscreteValues > 1) {
    if (self.enabled && _isDraggingThumb) {
      _valueLabel.transform = CGAffineTransformIdentity;
    } else {
      _valueLabel.transform = CGAffineTransformMakeScale((CGFloat)0.001, (CGFloat)0.001);
    }
  }

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
    if (_shouldDisplayDiscreteValueLabel && _numDiscreteValues > 1) {
      radius = 0;
    } else {
      radius = _thumbRadius + _trackHeight;
    }
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
- (void)animationDidStop:(CAAnimation *)anim finished:(__unused BOOL)flag {
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
  // This fixes https://github.com/material-components/material-components-ios/issues/566 for all
  // orientations.
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
      ([self isValueAtMinimum] && _thumbIsHollowAtStart &&
       !(_shouldDisplayDiscreteValueLabel && _numDiscreteValues > 0 && _isDraggingThumb))) {
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

#pragma mark - Interaction Helpers

- (CGPoint)thumbPosition {
  return _thumbView.center;
}

- (CGPoint)thumbPositionForValue:(CGFloat)value {
  CGFloat relValue = [self relativeValueForValue:value];
  return CGPointMake(_thumbRadius + self.thumbPanRange * relValue, self.frame.size.height / 2);
}

/**
 Gives the point on the thumb track that we should set as the "center" of the numeric value label.
 Keep in mind that this doesn't actually correspond to the geometric center of the label, but rather
 the anchor point which falls to the bottom of the label. So by setting this point to be on the
 track we automatically get the property of the numeric value label hovering slightly above the
 track.
 */
- (CGPoint)numericValueLabelPositionForValue:(CGFloat)value {
  CGFloat relValue = [self relativeValueForValue:value];

  // To account for the discrete dots on the left and right sides
  CGFloat range = self.thumbPanRange - _trackHeight;
  return CGPointMake(_thumbRadius + (_trackHeight / 2) + range * relValue,
                     self.frame.size.height / 2);
}

- (CGFloat)valueForThumbPosition:(CGPoint)position {
  CGFloat relValue = (position.x - _thumbRadius) / self.thumbPanRange;
  relValue = MAX(0, MIN(relValue, 1));
  // For RTL we invert the value
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    relValue = 1 - relValue;
  }
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

- (BOOL)isPointOnThumb:(CGPoint)point {
  // Note that we let the thumb's draggable area extend beyond its actual view to account for
  // the imprecise nature of hit targets on device.
  return DistanceFromPointToPoint(point, _thumbView.center) <= (_thumbRadius * kThumbSlopFactor);
}

- (BOOL)isValueAtMinimum {
  return _value == _minimumValue;
}

- (CGFloat)thumbPanOffset {
  return _thumbView.frame.origin.x / self.thumbPanRange;
}

- (CGFloat)thumbPanRange {
  return self.bounds.size.width - (self.thumbRadius * 2);
}

- (CGFloat)relativeValueForValue:(CGFloat)value {
  value = MAX(_minimumValue, MIN(value, _maximumValue));
  if (MDCCGFloatEqual(_minimumValue, _maximumValue)) {
    return _minimumValue;
  }
  CGFloat relValue = (value - _minimumValue) / MDCFabs(_minimumValue - _maximumValue);
  // For RTL we invert the value
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    relValue = 1 - relValue;
  }
  return relValue;
}

- (CGFloat)closestValueToTargetValue:(CGFloat)targetValue {
  if (_numDiscreteValues < 2) {
    return targetValue;
  }
  if (MDCCGFloatEqual(_minimumValue, _maximumValue)) {
    return _minimumValue;
  }

  CGFloat scaledTargetValue = (targetValue - _minimumValue) / (_maximumValue - _minimumValue);
  CGFloat snappedValue =
      MDCRound((_numDiscreteValues - 1) * scaledTargetValue) / (_numDiscreteValues - 1);
  return (1 - snappedValue) * _minimumValue + snappedValue * _maximumValue;
}

- (void)updateDummyPanRecognizerTarget {
  [_dummyPanRecognizer.view removeGestureRecognizer:_dummyPanRecognizer];
  UIView *panTarget = _panningAllowedOnEntireControl ? self : _thumbView;
  [panTarget addGestureRecognizer:_dummyPanRecognizer];
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
 controller attached to the thumb view, and that needs to receive touch events in order to know when
 to display ink.

 Using -touchesBegan:, etc. solves this problem because we can handle touches ourselves as well as
 continue to have them pass through to the contained thumb view. So we get our custom event handling
 without disabling the ink display, hurray!

 Because we set `multipleTouchEnabled = NO`, the sets of touches in these methods will always be of
 size 1. For this reason, we can simply call `-anyObject` on the set instead of iterating through
 every touch.
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(__unused UIEvent *)event {
  if (!self.enabled || _currentTouch != nil) {
    return;
  }

  UITouch *touch = [touches anyObject];
  CGPoint touchLoc = [[touches anyObject] locationInView:self];

  _currentTouch = touch;
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

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(__unused UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (!self.enabled || touch != _currentTouch) {
    return;
  }

  if (!_isDraggingThumb) {
    // The rest is dragging logic
    return;
  }

  CGPoint touchLoc = [touch locationInView:self];
  CGFloat thumbPosition = touchLoc.x - _panThumbGrabPosition;
  CGFloat previousValue = _value;
  CGFloat value = [self valueForThumbPosition:CGPointMake(thumbPosition, 0)];

  BOOL shouldAnimate = _numDiscreteValues > 1;
  [self setValue:value
                   animated:shouldAnimate
      animateThumbAfterMove:YES
              userGenerated:YES
                 completion:NULL];
  [self sendContinuousChangeAction];

  if (_value != previousValue) {
    // We made a move, now this action can't later count as a tap
    _didChangeValueDuringPan = YES;
  }

  if ([self pointInside:touchLoc withEvent:nil]) {
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
  } else {
    [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(__unused UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (touch == _currentTouch) {
    BOOL wasDragging = _isDraggingThumb;
    _isDraggingThumb = NO;
    _currentTouch = nil;

    if (wasDragging) {
      // Shrink the thumb
      [self updateThumbTrackAnimated:NO
               animateThumbAfterMove:YES
                       previousValue:_value
                          completion:nil];
    }

    [self sendActionsForControlEvents:UIControlEventTouchCancel];

    if (!_continuousUpdateEvents && wasDragging) {
      [self sendDiscreteChangeAction];
    }
  }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(__unused UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (!self.enabled || touch != _currentTouch) {
    return;
  }

  BOOL wasDragging = _isDraggingThumb;
  _isDraggingThumb = NO;
  _currentTouch = nil;

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
        [self setValueFromThumbPosition:touchLoc isTap:YES];
      }
    }

    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
  } else {
    [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
  }

  if (!_continuousUpdateEvents && wasDragging) {
    [self sendDiscreteChangeAction];
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
    value = _value < MDCCGFloatEqual(_value, _minimumValue) ? _maximumValue : _minimumValue;
  } else {
    value = [self valueForThumbPosition:position];
  }
  __weak MDCThumbTrack *weakSelf = self;
  if ([_delegate respondsToSelector:@selector(thumbTrack:willAnimateToValue:)]) {
    [_delegate thumbTrack:self willAnimateToValue:value];
  }

  if (isTap && _numDiscreteValues > 1 && _shouldDisplayDiscreteDots) {
    _discreteDots.alpha = 1.0;
  }

  [self setValue:value
                   animated:YES
      animateThumbAfterMove:YES
              userGenerated:YES
                 completion:^{
                   MDCThumbTrack *strongSelf = weakSelf;
                   [strongSelf sendDiscreteChangeAction];
                   if (strongSelf && [strongSelf->_delegate respondsToSelector:@selector
                                                            (thumbTrack:didAnimateToValue:)]) {
                     [strongSelf->_delegate thumbTrack:weakSelf didAnimateToValue:value];
                   }
                 }];
}

#pragma mark - Events

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

#pragma mark - UIControl methods

- (BOOL)isTracking {
  return _isDraggingThumb;
}

@end

@implementation MDCThumbTrack (Private)

- (MDCNumericValueLabel *)numericValueLabel {
  return _valueLabel;
}

- (MDCInkTouchController *)touchController {
  return _touchController;
}

- (MDCDiscreteDotView *)discreteDotView {
  return _discreteDots;
}

@end
