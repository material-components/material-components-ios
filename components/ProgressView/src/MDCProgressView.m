// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCProgressView.h"

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#include <tgmath.h>

#import "MDCPalettes.h"
#import "MaterialPalettes.h"
#import "MDCProgressGradientView.h"
#import "MDCProgressLayerView.h"

#import "MaterialProgressViewStrings.h"
#import "MaterialProgressViewStrings_table.h"
#import "MaterialMath.h"
#import <MDFInternationalization/MDFInternationalization.h>

NS_ASSUME_NONNULL_BEGIN

static inline UIColor *MDCProgressViewDefaultTintColor(void) {
  return MDCPalette.bluePalette.tint500;
}

// The ratio by which to desaturate the progress tint color to obtain the default track tint color.
static const CGFloat MDCProgressViewTrackColorDesaturation = (CGFloat)0.3;

static const NSTimeInterval MDCProgressViewAnimationDuration = 0.25;

// Used by the NTC Determinate branch.
static const CGFloat MDCProgressViewGapWidth = 4.0;

// This is the total duration from 0 to 1. A proportional amount of this duration is calculated
// based on the difference between two progress intervals. Used by the NTC Determinate branch.
static const CGFloat MDCProgressViewDeterminateDuration = 1.6;

static NSString *const kProgressViewLayerAnimationKey = @"kProgressViewLayerAnimation";
static NSString *const kProgressViewGapAnimationKey = @"kProgressViewGapAnimation";

// The Bundle for string resources.
static NSString *const kBundle = @"MaterialProgressView.bundle";

@interface MDCProgressView () <CAAnimationDelegate>
// `progressView` and `indeterminateProgressView` are both used to create animations for
// Indeterminate mode. `progressView` is used for the first animation in the sequence, and
// `indeterminateProgressView` is used for the second animation.
// When `progressLayerView` is enabled, it is the only view used for Indeterminate animation.
@property(nonatomic, strong) MDCProgressGradientView *progressView;
@property(nonatomic, strong) MDCProgressGradientView *indeterminateProgressView;
@property(nonatomic, strong) MDCProgressLayerView *progressLayerView;
@property(nonatomic, strong) UIView *trackView;
@property(nonatomic) BOOL animatingHide;

// These properties are used for the NTC Determinate branch of the Progress view.
// The NTC Determinate branch is gated by the `enableDeterminateStopMark` property.
// In this branch, `progressView`, `indeterminateProgressView`, and `progressLayerView` are hidden
// when in Determinate mode.
@property(nonatomic, strong) UIView *determinateProgressView;
@property(nonatomic, strong) UIView *determinateStopMark;
@property(nonatomic, strong, nullable) CAShapeLayer *determinateProgressBarLayer;
@property(nonatomic, strong, nullable) CAShapeLayer *determinateProgressViewGapLayer;
@property(nonatomic, copy, nullable) void (^userCompletion)(BOOL finished);

// `queuedProgress` represents a unary queue that stores the most recent value from `setProgress`.
// In Determinate mode, when a new `progress` value is set while the Determinate progress view is
// animating, this value is used for a follow-up animation.
// This is a nullable NSNumber instead of a CGFloat so that its unset state can be differentiated
// from a value of 0.
@property(nonatomic, strong, nullable) NSNumber *queuedProgress;

// A UIProgressView to return the same format for the accessibility value. For example, when
// progress is 0.497, it reports "fifty per cent".
@property(nonatomic, readonly) UIProgressView *accessibilityProgressView;

@end

@implementation MDCProgressView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCProgressViewInit];
  }
  return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCProgressViewInit];
  }
  return self;
}

- (void)commonMDCProgressViewInit {
  self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  self.backgroundColor = [UIColor clearColor];
  self.clipsToBounds = YES;
  self.isAccessibilityElement = YES;

  _mode = MDCProgressViewModeDeterminate;
  _animating = NO;

  _backwardProgressAnimationMode = MDCProgressViewBackwardAnimationModeReset;

  _trackView = [[UIView alloc] initWithFrame:self.frame];
  _trackView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self addSubview:_trackView];

  _progressView = [[MDCProgressGradientView alloc] initWithFrame:CGRectZero];
  [self addSubview:_progressView];

  _indeterminateProgressView = [[MDCProgressGradientView alloc] initWithFrame:CGRectZero];
  _indeterminateProgressView.hidden = YES;
  [self addSubview:_indeterminateProgressView];

  _progressLayerView = [[MDCProgressLayerView alloc] initWithFrame:CGRectZero];
  _progressLayerView.hidden = YES;
  [self addSubview:_progressLayerView];

  _progressView.colors = @[ MDCProgressViewDefaultTintColor(), MDCProgressViewDefaultTintColor() ];
  _indeterminateProgressView.colors =
      @[ MDCProgressViewDefaultTintColor(), MDCProgressViewDefaultTintColor() ];
  _trackView.backgroundColor =
      [[self class] defaultTrackTintColorForProgressTintColor:MDCProgressViewDefaultTintColor()];
}

- (void)willMoveToSuperview:(nullable UIView *)superview {
  [super willMoveToSuperview:superview];
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // NTC Determinate Branch
  if (_enableDeterminateStopMark && _mode == MDCProgressViewModeDeterminate) {
    // Set an initial width and height so that the stopmark can be drawn.
    if (_determinateProgressView == nil) {
      _determinateProgressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
      _determinateProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
      _determinateProgressView.backgroundColor = _trackTintColor;
      _determinateProgressView.translatesAutoresizingMaskIntoConstraints = NO;
      _determinateProgressView.clipsToBounds = YES;

      if (self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        _determinateProgressView.transform = CGAffineTransformMakeScale(-1, 1);
      }

      [self addSubview:_determinateProgressView];

      [NSLayoutConstraint activateConstraints:@[
        [_determinateProgressView.heightAnchor constraintEqualToAnchor:self.heightAnchor],
        [_determinateProgressView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [_determinateProgressView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [_determinateProgressView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
      ]];
    }
    if (_determinateProgressBarLayer == nil) {
      _determinateProgressBarLayer = [self makeDeterminateProgressBarLayer];

      if (self.cornerRadius > 0) {
        _determinateProgressBarLayer.lineCap = kCALineCapButt;
        _determinateProgressView.layer.cornerRadius = _cornerRadius;
        _determinateProgressBarLayer.cornerRadius = _cornerRadius;
      }

      [_determinateProgressView.layer addSublayer:_determinateProgressBarLayer];
    }

    if (_determinateProgressViewGapLayer == nil) {
      [self configureDeterminateProgressGapLayer];
    }

    // StopMark must be configured after DeterminateProgressBar.
    // StopMark is DeterminateProgressBar's subview, and is constrained against it.
    if (_determinateStopMark == nil) {
      _determinateStopMark = [self makeCircularStopMarkView];
      [_determinateStopMark.layer addSublayer:[self makeCircularStopMarkLayer]];
      _determinateStopMark.hidden = (_mode == MDCProgressViewModeIndeterminate);
    }

    // Hide determinate progress view when in indeterminate mode.
    _determinateProgressView.hidden = NO;

    // Hide non-determinate progress views when in determinate mode.
    _progressView.hidden = YES;
    _indeterminateProgressView.hidden = YES;
    _progressLayerView.hidden = YES;

    if (!self.animatingHide) {
      _determinateProgressView.frame = self.bounds;
    }
  } else {
    _determinateProgressView.hidden = YES;
    // Don't update the views when the hide animation is in progress.
    if (!self.animatingHide) {
      [self updateProgressView];
      [self updateIndeterminateProgressView];
      [self updateTrackView];
      [self updateProgressLayerView];
    }
  }
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.progressTintColor) {
    self.progressView.colors = @[ self.progressTintColor, self.progressTintColor ];
    self.indeterminateProgressView.colors = @[ self.progressTintColor, self.progressTintColor ];
  }

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }

  // Reconfigure layers when trait collection changes in order to get the correct color.
  if ([self.traitCollection
          hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
    if (_enableDeterminateStopMark && _mode == MDCProgressViewModeDeterminate) {
      if (_determinateProgressBarLayer) {
        [_determinateProgressBarLayer removeFromSuperlayer];
        _determinateProgressBarLayer = nil;
        _determinateProgressBarLayer = [self makeDeterminateProgressBarLayer];
        [_determinateProgressView.layer addSublayer:_determinateProgressBarLayer];
      }

      if (_determinateProgressViewGapLayer) {
        [_determinateProgressViewGapLayer removeFromSuperlayer];
        _determinateProgressViewGapLayer = nil;
        [self configureDeterminateProgressGapLayer];
      }

      if (_determinateStopMark) {
        _determinateStopMark.layer.sublayers = nil;
        [_determinateStopMark.layer addSublayer:[self makeCircularStopMarkLayer]];
      }
    }
  }
}

- (void)setProgressTintColor:(nullable UIColor *)progressTintColor {
  _progressTintColor = progressTintColor;
  _progressTintColors = nil;
  if (progressTintColor != nil) {
    self.progressView.colors = @[ progressTintColor, progressTintColor ];
    self.indeterminateProgressView.colors = @[ progressTintColor, progressTintColor ];
    _determinateProgressBarLayer.fillColor = progressTintColor.CGColor;
  } else {
    self.progressView.colors = nil;
    self.indeterminateProgressView.colors = nil;
    _determinateProgressBarLayer.fillColor = nil;
  }
}

- (void)setProgressTintColors:(nullable NSArray<UIColor *> *)progressTintColors {
  _progressTintColors = [progressTintColors copy];

  self.progressView.colors = _progressTintColors;
  self.indeterminateProgressView.colors = _progressTintColors;

  self.progressLayerView.frame = self.bounds;
  self.progressLayerView.colors = _progressTintColors;

  // progressTintColors is not used in NTC Determinate branch.
  // Since some clients set the tint color with this setter, use the first value if there is one
  // for Determinate mode.
  if (_enableDeterminateStopMark) {
    if (_mode == MDCProgressViewModeDeterminate && progressTintColors.count > 0) {
      _progressTintColor = progressTintColors[0];
      _determinateProgressBarLayer.fillColor = _progressTintColor.CGColor;
    }
  } else {
    _progressTintColor = nil;
  }
}


- (void)setMode:(MDCProgressViewMode)mode {
  if (_mode == mode) {
    return;
  }
  _mode = mode;

  self.indeterminateProgressView.hidden = (mode == MDCProgressViewModeDeterminate);
  self.determinateStopMark.hidden =
      (_mode == MDCProgressViewModeIndeterminate || !_enableDeterminateStopMark);
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  _cornerRadius = cornerRadius;

  _progressView.layer.cornerRadius = cornerRadius;
  _indeterminateProgressView.layer.cornerRadius = cornerRadius;
  _trackView.layer.cornerRadius = cornerRadius;
  _determinateProgressView.layer.cornerRadius = cornerRadius;
  _determinateProgressBarLayer.cornerRadius = cornerRadius;

  BOOL hasNonZeroCornerRadius = !MDCCGFloatIsExactlyZero(cornerRadius);
  _progressView.clipsToBounds = hasNonZeroCornerRadius;
  _indeterminateProgressView.clipsToBounds = hasNonZeroCornerRadius;
  _trackView.clipsToBounds = hasNonZeroCornerRadius;
  _determinateProgressView.clipsToBounds = hasNonZeroCornerRadius;
}

- (void)setEnableDeterminateStopMark:(BOOL)enableDeterminateStopMark {
  _enableDeterminateStopMark = enableDeterminateStopMark;
  _determinateStopMark.hidden =
      (_mode == MDCProgressViewModeIndeterminate || !enableDeterminateStopMark);
  [self setNeedsLayout];
}

- (void)setProgress:(float)progress {
  if (progress > 1)
    progress = 1;
  if (progress < 0)
    progress = 0;
  if (!_enableDeterminateStopMark) {
    _progress = progress;
  }

  // Indeterminate mode ignores the progress property.
  if (_mode == MDCProgressViewModeIndeterminate) {
    return;
  }

  if (_enableDeterminateStopMark) {
    [self setProgress:progress animated:NO completion:nil];
  }
  [self accessibilityValueDidChange];
  [self setNeedsLayout];
}

- (void)setProgress:(float)progress
           animated:(BOOL)animated
         completion:(void (^__nullable)(BOOL finished))userCompletion {
  // Indeterminate progress animation branch, with an early return.
  // Indeterminate animation is handled in `startAnimatingBar`.
  if (_mode == MDCProgressViewModeIndeterminate) {
    self.progress = progress;
    if (userCompletion) {
      userCompletion(NO);
    }
    return;
  }

  // NTC Determinate Branch - setProgress Animation
  if (_enableDeterminateStopMark && _mode == MDCProgressViewModeDeterminate) {
    // Completion block is called in `animationDidStop`.
    _userCompletion = userCompletion;

    if (animated) {
      if ([_determinateProgressBarLayer animationForKey:kProgressViewLayerAnimationKey]) {
        _queuedProgress = @(progress);
        return;
      }
      [self configureDeterminateAnimationsForProgress:progress];
    } else {
      _queuedProgress = nil;
      UIBezierPath *toPathForProgressLayer = [self makeToPathForBarWithProgress:progress];
      UIBezierPath *toPathForProgressGapLayer = [self makeToPathForGapWithProgress:progress];

      [CATransaction begin];
      [CATransaction setDisableActions:YES];
      // Use `setDisableActions` to disable implicit animations.
      _determinateProgressBarLayer.path = toPathForProgressLayer.CGPath;
      _determinateProgressViewGapLayer.path = toPathForProgressGapLayer.CGPath;
      [CATransaction commit];
    }

    _progress = progress;
  } else {
    if (progress < self.progress &&
        self.backwardProgressAnimationMode == MDCProgressViewBackwardAnimationModeReset) {
      self.progress = 0;
      [self updateProgressView];
    }

    self.progress = progress;
    [UIView animateWithDuration:animated ? [[self class] animationDuration] : 0
                          delay:0
                        options:[[self class] animationOptions]
                     animations:^{
                       [self updateProgressView];
                     }
                     completion:userCompletion];
  }
}

- (void)setHidden:(BOOL)hidden
         animated:(BOOL)animated
       completion:(void (^__nullable)(BOOL finished))userCompletion {
  if (hidden == self.hidden) {
    if (userCompletion) {
      userCompletion(YES);
    }
    return;
  }

  void (^animations)(void);

  if (hidden) {
    self.animatingHide = YES;
    animations = ^{
      CGFloat y = CGRectGetHeight(self.bounds);

      CGRect trackViewFrame = self.trackView.frame;
      trackViewFrame.origin.y = y;
      trackViewFrame.size.height = 0;
      self.trackView.frame = trackViewFrame;

      CGRect progressViewFrame = self.progressView.frame;
      progressViewFrame.origin.y = y;
      progressViewFrame.size.height = 0;
      self.progressView.frame = progressViewFrame;
    };
  } else {
    self.hidden = NO;
    animations = ^{
      self.trackView.frame = self.bounds;

      CGRect progressViewFrame = self.progressView.frame;
      progressViewFrame.origin.y = 0;
      progressViewFrame.size.height = CGRectGetHeight(self.bounds);
      self.progressView.frame = progressViewFrame;
    };
  }

  [UIView animateWithDuration:animated ? [[self class] animationDuration] : 0
                        delay:0
                      options:[[self class] animationOptions]
                   animations:animations
                   completion:^(BOOL finished) {
                     if (hidden) {
                       self.animatingHide = NO;
                       self.hidden = YES;
                     }
                     if (userCompletion) {
                       userCompletion(finished);
                     }
                   }];
}

#pragma mark Accessibility

- (UIProgressView *)accessibilityProgressView {
  // Accessibility values are determined by querying a UIProgressView set to the same value as our
  // MDCProgressView.
  static UIProgressView *accessibilityProgressView;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    accessibilityProgressView = [[UIProgressView alloc] init];
  });

  return accessibilityProgressView;
}

- (nullable NSString *)accessibilityValue {
  self.accessibilityProgressView.progress = self.progress;
  return self.accessibilityProgressView.accessibilityValue;
}

- (void)accessibilityValueDidChange {
  // Store a strong reference to self until the end of the method. Indeed,
  // a previous -performSelector:withObject:afterDelay: might be the last thing
  // to retain self, so calling +cancelPreviousPerformRequestsWithTarget: might
  // deallocate self.
  MDCProgressView *strongSelf = self;
  // Cancel unprocessed announcements and replace them with the most up-to-date
  // value. That way, they don't overlap and don't spam the user.
  [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf
                                           selector:@selector(announceAccessibilityValueChange)
                                             object:nil];
  // Schedule a new announcement.
  [strongSelf performSelector:@selector(announceAccessibilityValueChange)
                   withObject:nil
                   afterDelay:1];
}

- (void)announceAccessibilityValueChange {
  if ([self accessibilityElementIsFocused]) {
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,
                                    [self accessibilityValue]);
  }
}

- (nullable NSString *)accessibilityLabel {
  return self.accessibilityProgressView.accessibilityLabel ?: [self defaultAccessibilityLabel];
}

- (NSString *)defaultAccessibilityLabel {
  MaterialProgressViewStringId keyIndex = kStr_MaterialProgressViewAccessibilityLabel;
  NSString *key = kMaterialProgressViewStringTable[keyIndex];
  return NSLocalizedStringFromTableInBundle(key, kMaterialProgressViewStringsTableName,
                                            [[self class] bundle], @"Progress View");
}

- (void)startAnimating {
  [self startAnimatingBar];
  _animating = YES;

  [self setNeedsLayout];
}

- (void)stopAnimating {
  _animating = NO;
  [self.progressView.shapeLayer removeAllAnimations];
  [self.indeterminateProgressView.shapeLayer removeAllAnimations];
  [_progressLayerView stopAnimating];

  [self setNeedsLayout];
}

#pragma mark - Resource Bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kBundle]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCProgressView class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

#pragma mark Private

+ (NSTimeInterval)animationDuration {
  return MDCProgressViewAnimationDuration;
}

+ (UIViewAnimationOptions)animationOptions {
  // Since the animation is fake, using a linear interpolation avoids the speeding up and slowing
  // down that repeated easing in and out causes.
  return UIViewAnimationOptionCurveLinear;
}

+ (UIColor *)defaultTrackTintColorForProgressTintColor:(UIColor *)progressTintColor {
  CGFloat hue, saturation, brightness, alpha;
  if ([progressTintColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
    CGFloat newSaturation = MIN(saturation * MDCProgressViewTrackColorDesaturation, 1);
    return [UIColor colorWithHue:hue saturation:newSaturation brightness:brightness alpha:alpha];
  }
  return [UIColor clearColor];
}

- (void)updateProgressView {
  CGRect progressFrame = self.bounds;
  if (_mode == MDCProgressViewModeDeterminate) {
    // Update progressView with the current progress value.
#if defined(TARGET_OS_VISION) && TARGET_OS_VISION
    // For code review, use the review queue listed in go/material-visionos-review.
    UITraitCollection *current = [UITraitCollection currentTraitCollection];
    CGFloat scale = current ? [current displayScale] : 1.0;
    if (scale <= 0) {
      scale = 1.0;
    }
#else
    CGFloat scale = self.window.screen.scale > 0 ? self.window.screen.scale : 1;
#endif
    CGFloat pointWidth = self.progress * CGRectGetWidth(self.bounds);
    CGFloat pixelAlignedWidth = round(pointWidth * scale) / scale;
    progressFrame = CGRectMake(0, 0, pixelAlignedWidth, CGRectGetHeight(self.bounds));
  } else {
    if (!self.animating) {
      progressFrame = CGRectZero;
    }
  }
  if (self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    progressFrame = MDFRectFlippedHorizontally(progressFrame, CGRectGetWidth(self.bounds));
  }
  self.progressView.frame = progressFrame;
}

- (void)updateIndeterminateProgressView {
  self.indeterminateProgressView.frame = self.animating ? self.bounds : CGRectZero;
}

- (void)updateTrackView {
  const CGSize size = self.bounds.size;
  self.trackView.frame = self.hidden ? CGRectMake(0.0, size.height, size.width, 0.0) : self.bounds;
}

- (BOOL)isIndeterminateAndMultichromatic {
  BOOL isIndeterminate = (_mode == MDCProgressViewModeIndeterminate);
  BOOL isMultichromatic = (_progressTintColor == nil && _progressTintColors != nil);

  return isIndeterminate && isMultichromatic;
}

- (void)updateProgressLayerView {
  self.progressLayerView.frame = self.animating ? self.bounds : CGRectZero;
}

- (void)startAnimatingBar {
  // Use the new MDCProgressLayerView only for indeterminate multichromatic.
  // Determinate Monochromatic, Determinate Multichromatic, and Indeterminate Monochromatic
  // will continue to use MDCProgressGradientView.

  // NTC Determinate branch is handled in `setProgress`, which uses `determinateProgressView`.
  // The code path for indeterminate animations uses `progressView` and `indeterminateProgressView`,
  // which are MDCProgressGradientViews.
  // Note that this code path is for the Indeterminate animation, but it uses both `_progressView`
  // and `_indeterminateProgressView` to create the Indeterminate animations.
  if (_mode == MDCProgressViewModeDeterminate && _enableDeterminateStopMark) {
    return;
  }

  if ([self isIndeterminateAndMultichromatic]) {
    _progressView.hidden = YES;
    [_progressView.shapeLayer removeAllAnimations];

    _indeterminateProgressView.hidden = YES;
    [self.indeterminateProgressView.shapeLayer removeAllAnimations];

    _progressLayerView.frame = self.bounds;
    _progressLayerView.hidden = NO;

    [_progressLayerView startAnimating];
    return;
  } else {
    _progressLayerView.hidden = YES;
    [_progressLayerView stopAnimating];

    _indeterminateProgressView.hidden = NO;
    _progressView.hidden = NO;
  }

  // If the bar isn't indeterminate or the bar is already animating, don't add the animation again.
  if (_mode == MDCProgressViewModeDeterminate || _animating) {
    return;
  }

  [self.progressView.shapeLayer removeAllAnimations];
  [self.indeterminateProgressView.shapeLayer removeAllAnimations];

  // The numeric values used here conform to https://material.io/components/progress-indicators.
  CABasicAnimation *progressViewHead = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  progressViewHead.fromValue = @0;
  progressViewHead.toValue = @1;
  progressViewHead.duration = 0.75;
  progressViewHead.timingFunction =
      [[CAMediaTimingFunction alloc] initWithControlPoints:0.20f:0.00f:0.80f:1.00f];
  progressViewHead.fillMode = kCAFillModeBackwards;

  CABasicAnimation *progressViewTail = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
  progressViewTail.beginTime = 0.333;
  progressViewTail.fromValue = @0;
  progressViewTail.toValue = @1;
  progressViewTail.duration = 0.85;
  progressViewTail.timingFunction =
      [[CAMediaTimingFunction alloc] initWithControlPoints:0.40f:0.00f:1.00f:1.00f];
  progressViewTail.fillMode = kCAFillModeForwards;

  CAAnimationGroup *progressViewAnimationGroup = [[CAAnimationGroup alloc] init];
  progressViewAnimationGroup.animations = @[ progressViewHead, progressViewTail ];
  progressViewAnimationGroup.duration = 1.8;
  progressViewAnimationGroup.removedOnCompletion = NO;
  progressViewAnimationGroup.repeatCount = HUGE_VALF;

  [self.progressView.shapeLayer addAnimation:progressViewAnimationGroup
                                      forKey:@"kProgressViewAnimation"];

  CABasicAnimation *indeterminateProgressViewHead =
      [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  indeterminateProgressViewHead.fromValue = @0;
  indeterminateProgressViewHead.toValue = @1;
  indeterminateProgressViewHead.duration = 0.567;
  indeterminateProgressViewHead.beginTime = 1;
  indeterminateProgressViewHead.timingFunction =
      [[CAMediaTimingFunction alloc] initWithControlPoints:0.00f:0.00f:0.65f:1.00f];
  indeterminateProgressViewHead.fillMode = kCAFillModeBackwards;

  CABasicAnimation *indeterminateProgressViewTail =
      [CABasicAnimation animationWithKeyPath:@"strokeStart"];
  indeterminateProgressViewTail.beginTime = 1.267;
  indeterminateProgressViewTail.fromValue = @0;
  indeterminateProgressViewTail.toValue = @1;
  indeterminateProgressViewTail.duration = 0.533;
  indeterminateProgressViewTail.timingFunction =
      [[CAMediaTimingFunction alloc] initWithControlPoints:0.10f:0.00f:0.45f:1.00f];
  indeterminateProgressViewTail.fillMode = kCAFillModeBackwards;

  CAAnimationGroup *indeterminateProgressViewAnimationGroup = [[CAAnimationGroup alloc] init];
  indeterminateProgressViewAnimationGroup.animations =
      @[ indeterminateProgressViewHead, indeterminateProgressViewTail ];
  indeterminateProgressViewAnimationGroup.duration = 1.8;
  indeterminateProgressViewAnimationGroup.removedOnCompletion = NO;
  indeterminateProgressViewAnimationGroup.repeatCount = HUGE_VALF;

  [self.indeterminateProgressView.shapeLayer addAnimation:indeterminateProgressViewAnimationGroup
                                                   forKey:@"kIndeterminateProgressViewAnimation"];
}

#pragma mark - NTC Determinate Branch

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
  if (!_enableDeterminateStopMark) {
    return;
  }

  // `animationDidStop` is necessary because, without a delegate call, we can only tell when a
  // CAAnimation has completed successfully. `animationDidStop` notifies when an animation is
  // stopped early or fails.
  if (_userCompletion) {
    _userCompletion(flag);
    _userCompletion = nil;
  }

  if (_queuedProgress != nil) {
    [self configureDeterminateAnimationsForProgress:_queuedProgress.floatValue];
    _progress = _queuedProgress.floatValue;
    _queuedProgress = nil;
  }
}

- (void)setTrackTintColor:(nullable UIColor *)trackTintColor {
  _trackTintColor = trackTintColor;
  _trackView.backgroundColor = trackTintColor;
  _determinateProgressView.backgroundColor = trackTintColor;
}

- (void)setGapColor:(nullable UIColor *)gapColor {
  _gapColor = gapColor;
  _determinateProgressViewGapLayer.fillColor = gapColor.CGColor;
}

- (UIView *)makeCircularStopMarkView {
  UIView *determinateStopMark = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
  determinateStopMark.translatesAutoresizingMaskIntoConstraints = NO;

  [_determinateProgressView addSubview:determinateStopMark];

  NSLayoutConstraint *xAnchor =
      (self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft
           ? [_determinateProgressView.leadingAnchor
                 constraintEqualToAnchor:determinateStopMark.leadingAnchor]
           : [_determinateProgressView.trailingAnchor
                 constraintEqualToAnchor:determinateStopMark.trailingAnchor]);

  [NSLayoutConstraint activateConstraints:@[
    [determinateStopMark.heightAnchor constraintEqualToConstant:self.bounds.size.height],
    [determinateStopMark.widthAnchor constraintEqualToConstant:self.bounds.size.height],
    xAnchor,
    [determinateStopMark.centerYAnchor
        constraintEqualToAnchor:_determinateProgressView.centerYAnchor],
  ]];

  return determinateStopMark;
}

- (CAShapeLayer *)makeCircularStopMarkLayer {
  CGFloat circleDimension = self.bounds.size.height;
  CAShapeLayer *circleLayer = [[CAShapeLayer alloc] init];
  circleLayer.frame = CGRectMake(0, 0, circleDimension, circleDimension);
  circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:circleLayer.bounds].CGPath;
  circleLayer.fillColor = self.progressTintColor.CGColor;
  return circleLayer;
}

- (CAShapeLayer *)makeDeterminateProgressBarLayer {
  CAShapeLayer *determinateProgressBarLayer = [CAShapeLayer layer];
  determinateProgressBarLayer.cornerRadius = _cornerRadius;
  determinateProgressBarLayer.lineCap = kCALineCapButt;
  determinateProgressBarLayer.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
  determinateProgressBarLayer.fillColor = _progressTintColor.CGColor;

  CGRect pathRect = CGRectMake(0, 0, 0, self.bounds.size.height);

  if (determinateProgressBarLayer.cornerRadius > 0) {
    determinateProgressBarLayer.path =
        [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:_cornerRadius].CGPath;
  } else {
    determinateProgressBarLayer.path = [UIBezierPath bezierPathWithRect:pathRect].CGPath;
  }

  return determinateProgressBarLayer;
}

- (UIBezierPath *)makeToPathForGapWithProgress:(CGFloat)progress {
  CGRect rect = CGRectMake(self.bounds.size.width * progress + progress, 0, MDCProgressViewGapWidth,
                           self.bounds.size.height);

  CGFloat x = (progress == 0) ? rect.origin.x - MDCProgressViewGapWidth - 3 : rect.origin.x - 3;
  CGFloat y = rect.origin.y - 1;

  // Draws a square shape with concave sides that looks like this:
  //    ---
  //  )     (
  //    ---
  // The sides are to account for rounded corners.
  // This shape is used for the progress gap.
  // It is based on a bar height of 4, and a corner radius of 2.
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(x + 8, y)];
  [path addLineToPoint:CGPointMake(x, y)];
  [path addLineToPoint:CGPointMake(x, y + 1)];
  [path addCurveToPoint:CGPointMake(x + 2, y + 3)
          controlPoint1:CGPointMake(x + 1, y + 1)
          controlPoint2:CGPointMake(x + 2, y + 2)];
  [path addCurveToPoint:CGPointMake(x, y + 5)
          controlPoint1:CGPointMake(x + 2, y + 4)
          controlPoint2:CGPointMake(x + 1, y + 5)];
  [path addLineToPoint:CGPointMake(x, y + 6)];
  [path addLineToPoint:CGPointMake(x + 8, y + 6)];
  [path addLineToPoint:CGPointMake(x + 8, y + 5)];
  [path addCurveToPoint:CGPointMake(x + 6, y + 3)
          controlPoint1:CGPointMake(x + 7, y + 5)
          controlPoint2:CGPointMake(x + 6, y + 4)];
  [path addCurveToPoint:CGPointMake(x + 8, y + 1)
          controlPoint1:CGPointMake(x + 6, y + 2)
          controlPoint2:CGPointMake(x + 7, y + 1)];
  [path addLineToPoint:CGPointMake(x + 8, y)];
  [path closePath];
  return path;
}

- (UIBezierPath *)makeToPathForBarWithProgress:(CGFloat)progress {
  CGFloat cornerRadiusOffset = (_cornerRadius > 0 ? _cornerRadius / 2 : 0);
  CGRect rect = CGRectMake(0, 0, self.bounds.size.width * progress - cornerRadiusOffset,
                           self.bounds.size.height);
  UIBezierPath *path;

  if (_cornerRadius > 0) {
    path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:_cornerRadius];
  } else {
    path = [UIBezierPath bezierPathWithRect:rect];
  }
  return path;
}

- (void)configureDeterminateProgressGapLayer {
  CAShapeLayer *determinateProgressViewGapLayer = [CAShapeLayer layer];
  determinateProgressViewGapLayer.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
  determinateProgressViewGapLayer.fillColor = _gapColor.CGColor;
  [_determinateProgressView.layer addSublayer:determinateProgressViewGapLayer];

  UIBezierPath *path = [self makeToPathForGapWithProgress:_progress];
  determinateProgressViewGapLayer.path = path.CGPath;
  _determinateProgressViewGapLayer = determinateProgressViewGapLayer;
}

- (CGFloat)calculateProportionalDeterminateAnimationDurationFrom:(CGFloat)fromProgressPercent
                                                              to:(CGFloat)toProgressPercent {
  CGFloat difference = ABS(toProgressPercent - fromProgressPercent);
  CGFloat duration = difference * MDCProgressViewDeterminateDuration;
  return duration;
}

- (void)configureDeterminateAnimationsForProgress:(CGFloat)progress {
  UIBezierPath *toPathForProgressLayer = [self makeToPathForBarWithProgress:progress];
  UIBezierPath *toPathForProgressGapLayer = [self makeToPathForGapWithProgress:progress];

  CGPathRef originalProgressBarPath = _determinateProgressBarLayer.path;
  NSValue *originalProgressBarPathValue = [NSValue valueWithPointer:originalProgressBarPath];

  CGPathRef originalProgressGapPath = _determinateProgressViewGapLayer.path;
  NSValue *originalProgressGapPathValue = [NSValue valueWithPointer:originalProgressGapPath];

  CGFloat duration = [self calculateProportionalDeterminateAnimationDurationFrom:_progress
                                                                              to:progress];

  _determinateProgressBarLayer.path = toPathForProgressLayer.CGPath;

  CABasicAnimation *progressBarLayerPathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
  progressBarLayerPathAnimation.duration = duration;
  progressBarLayerPathAnimation.delegate = self;
  progressBarLayerPathAnimation.fromValue = (id)([originalProgressBarPathValue pointerValue]);
  progressBarLayerPathAnimation.fillMode = kCAFillModeBoth;
  progressBarLayerPathAnimation.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  [_determinateProgressBarLayer addAnimation:progressBarLayerPathAnimation
                                      forKey:kProgressViewLayerAnimationKey];

  _determinateProgressViewGapLayer.path = toPathForProgressGapLayer.CGPath;

  CABasicAnimation *progressGapLayerPathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
  // Add a slight duration increase to account for track bar overhang near animation end.
  progressGapLayerPathAnimation.duration = duration + 0.01;
  progressGapLayerPathAnimation.fromValue = (id)([originalProgressGapPathValue pointerValue]);
  progressGapLayerPathAnimation.fillMode = kCAFillModeBoth;
  progressGapLayerPathAnimation.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  [_determinateProgressViewGapLayer addAnimation:progressGapLayerPathAnimation
                                          forKey:kProgressViewGapAnimationKey];
}

@end

NS_ASSUME_NONNULL_END
