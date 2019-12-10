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

#include <tgmath.h>

#import <MDFInternationalization/MDFInternationalization.h>
#import "MaterialMath.h"
#import "MaterialPalettes.h"

static inline UIColor *MDCProgressViewDefaultTintColor(void) {
  return MDCPalette.bluePalette.tint500;
}

// The ratio by which to desaturate the progress tint color to obtain the default track tint color.
static const CGFloat MDCProgressViewTrackColorDesaturation = (CGFloat)0.3;

static const NSTimeInterval MDCProgressViewAnimationDuration = 0.25;

static const NSTimeInterval kAnimationDuration = 1.8;

static const CGFloat MDCProgressViewBarWidthPercentage + (CGFloat)0.52;

@interface MDCProgressView ()
@property(nonatomic, strong) UIView *progressView;
@property(nonatomic, strong) UIView *trackView;
@property(nonatomic, strong) UIView *transitionView;
@property(nonatomic) BOOL animatingHide;
// A UIProgressView to return the same format for the accessibility value. For example, when
// progress is 0.497, it reports "fifty per cent".
@property(nonatomic, readonly) UIProgressView *accessibilityProgressView;
@property(nonatomic) CFTimeInterval indeterminateAnimationStartTime;

@property(nonatomic) CFTimeInterval indeterminateAnimationStartTime;
@end

@implementation MDCProgressView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCProgressViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
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

  _transitionView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGRectGetHeight(self.bounds))];
  _transitionView.backgroundColor = MDCProgressViewDefaultTintColor();
  [self addSubview:_transitionView];

  float barWidth = [self indeterminateLoadingBarWidth];
  CGRect progressBarFrame = CGRectMake(-barWidth, 0, barWidth, CGRectGetHeight(self.bounds));
  _progressView = [[UIView alloc] initWithFrame:progressBarFrame];
  [self addSubview:_progressView];

  _progressView.backgroundColor = MDCProgressViewDefaultTintColor();
  _trackView.backgroundColor =
      [[self class] defaultTrackTintColorForProgressTintColor:_progressView.backgroundColor];
}

- (void)willMoveToSuperview:(UIView *)superview {
  [super willMoveToSuperview:superview];
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // Don't update the views when the hide animation is in progress.
  if (!self.animatingHide) {
    [self updateProgressView];
    [self updateTrackView];
  }

  if (_mode == MDCProgressViewModeIndeterminate && _animating) {
    [self stopAnimating];
    [self startAnimating];
  }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (UIColor *)progressTintColor {
  return self.progressView.backgroundColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
  if (progressTintColor == nil) {
    progressTintColor = MDCProgressViewDefaultTintColor();
  }
  self.progressView.backgroundColor = progressTintColor;
  self.transitionView.backgroundColor = progressTintColor;
}

- (UIColor *)trackTintColor {
  return self.trackView.backgroundColor;
}

- (void)setMode:(MDCProgressViewMode)mode {
  if (_mode == mode) {
    return;
  }
  _mode = mode;

  // If the progress bar was animating in indeterminate mode before, restart the animation.
  if (_animating && _mode == MDCProgressViewModeIndeterminate) {
    [self.progressView.layer removeAllAnimations];
    _animating = false;
    [self startAnimating];
  }
}

- (void)setMode:(MDCProgressViewMode)mode
       animated:(BOOL)animated
     completion:(void (^__nullable)(BOOL finished))completion {
  if (_mode == mode) {
    if(completion) {
      completion(YES);
    }
    return;
  }
  _mode = mode;

  if (!animated) {
    if (_mode == MDCProgressViewModeIndeterminate) {
      self.progressView.frame = CGRectMake(0, 0, 0, CGRectGetHeight(self.bounds));
    }
    // Update the transition without an animation.
    [self updateProgressView];
    if(completion) {
      completion(YES);
    }
  }

  // Change from indeterminate to determinate.
  if (_mode == MDCProgressViewModeDeterminate) {
    // If the indeterminate view wasn't animating, just animate the determinate bar in.
    if (!_animating) {
      [self setProgress:_progress animated:animated completion:completion];
      if(completion) {
        completion(YES);
      }
      return;
    }

    // Transition from the indeterminate to the determinate bar.
    CFTimeInterval stopTime = [self.progressView.layer convertTime:CACurrentMediaTime()
                                                         fromLayer:nil];
    CFTimeInterval timeDiff = stopTime - _indeterminateAnimationStartTime;

    CGFloat percentage = timeDiff / kAnimationDuration - floor(timeDiff / kAnimationDuration);
    CGFloat xPosition =
    (CGRectGetWidth(self.bounds) + [self indeterminateLoadingBarWidth]) * percentage -
    [self indeterminateLoadingBarWidth];

    [self.progressView.layer removeAllAnimations];
    CGRect progressBarStartFrame =
    CGRectMake(xPosition, 0, [self indeterminateLoadingBarWidth], CGRectGetHeight(self.bounds));
    self.progressView.frame = progressBarStartFrame;

    [UIView animateWithDuration:[[self class] animationDuration]
                          delay:0
                        options:[[self class] animationOptions]
                     animations:^{
                       [self updateProgressView];
                     }
                     completion:completion];
  } else {
    // Change from determinate to indeterminate.
    CGRect zeroFrame = CGRectMake(0, 0, 0, CGRectGetHeight(self.bounds));
    // Animate the transition from progress to indeterminate.
    CGRect transitionViewFrame =
    CGRectMake(0, 0, CGRectGetWidth(self.bounds) * _progress, CGRectGetHeight(self.bounds));
    self.transitionView.frame = transitionViewFrame;
    [self layoutIfNeeded];

    [UIView animateWithDuration:[[self class] animationDuration]
                          delay:0
                        options:[[self class] animationOptions]
                     animations:^{
                       self.transitionView.frame = zeroFrame;
                     }
                     completion:completion];

  }
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
  if (trackTintColor == nil) {
    trackTintColor =
        [[self class] defaultTrackTintColorForProgressTintColor:self.progressTintColor];
  }
  self.trackView.backgroundColor = trackTintColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  _cornerRadius = cornerRadius;

  _progressView.layer.cornerRadius = cornerRadius;
  _trackView.layer.cornerRadius = cornerRadius;

  BOOL hasNonZeroCornerRadius = !MDCCGFloatIsExactlyZero(cornerRadius);
  _progressView.clipsToBounds = hasNonZeroCornerRadius;
  _trackView.clipsToBounds = hasNonZeroCornerRadius;
}

- (void)setProgress:(float)progress {
  if (progress > 1)
    progress = 1;
  if (progress < 0)
    progress = 0;
  _progress = progress;
  [self accessibilityValueDidChange];
  [self setNeedsLayout];
}

- (void)setProgress:(float)progress
           animated:(BOOL)animated
         completion:(void (^__nullable)(BOOL finished))userCompletion {
  // Indeterminate mode ignores the progress.
  if (_mode == MDCProgressViewModeIndeterminate) {
    self.progress = progress;
    if(userCompletion) {
      userCompletion(NO);
    }
    return;
  }

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

- (void)setHidden:(BOOL)hidden {
  [super setHidden:hidden];
  UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, hidden ? nil : self);
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

- (NSString *)accessibilityValue {
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

- (NSString *)accessibilityLabel {
  return self.accessibilityProgressView.accessibilityLabel;
}

- (void)startAnimating {
  [self startAnimatingBar];
  _animating = YES;
}

- (void)stopAnimating {
  _animating = NO;
  [self.progressView.layer removeAllAnimations];
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
  if (_mode == MDCProgressViewModeIndeterminate) {
    return;
  }
  // Update progressView with the current progress value.
  CGFloat progressWidth = MDCCeil(self.progress * CGRectGetWidth(self.bounds));
  CGRect progressFrame = CGRectMake(0, 0, progressWidth, CGRectGetHeight(self.bounds));
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    progressFrame = MDFRectFlippedHorizontally(progressFrame, CGRectGetWidth(self.bounds));
  }
  self.progressView.frame = progressFrame;
}

- (void)updateTrackView {
  const CGSize size = self.bounds.size;
  self.trackView.frame = self.hidden ? CGRectMake(0.0, size.height, size.width, 0.0) : self.bounds;
}

- (void)startAnimatingBar {
  // If the bar isn't indeterminate or the bar is already animating, don't add the animation again.
  if (_mode == MDCProgressViewModeDeterminate || _animating) {
    return;
  }

  float barWidth = [self indeterminateLoadingBarWidth];
  CGRect progressBarStartFrame = CGRectMake(-barWidth, 0, barWidth, CGRectGetHeight(self.bounds));
  self.progressView.frame = progressBarStartFrame;

  CGPoint progressBarEndPoint =
      CGPointMake(self.progressView.layer.position.x + CGRectGetWidth(self.bounds) + barWidth,
                  CGRectGetHeight(self.bounds) / 2);
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
  animation.fromValue = [NSValue valueWithCGPoint:self.progressView.layer.position];
  animation.toValue = [NSValue valueWithCGPoint:progressBarEndPoint];
  animation.duration = kAnimationDuration;
  animation.repeatCount = HUGE_VALF;
  [self.progressView.layer addAnimation:animation forKey:@"position"];
  _indeterminateAnimationStartTime = [self.progressView.layer convertTime:CACurrentMediaTime()
                                                                fromLayer:nil];
}

- (float)indeterminateLoadingBarWidth {
  return CGRectGetWidth(self.bounds) * MDCProgressViewBarWidthPercentage;
}

@end
