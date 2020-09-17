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

#import "MaterialPalettes.h"
#import "MDCProgressGradientView.h"
#import "MaterialProgressViewStrings.h"
#import "MaterialProgressViewStrings_table.h"
#import "MaterialMath.h"
#import <MDFInternationalization/MDFInternationalization.h>

static inline UIColor *MDCProgressViewDefaultTintColor(void) {
  return MDCPalette.bluePalette.tint500;
}

// The ratio by which to desaturate the progress tint color to obtain the default track tint color.
static const CGFloat MDCProgressViewTrackColorDesaturation = (CGFloat)0.3;

static const NSTimeInterval MDCProgressViewAnimationDuration = 0.25;

// The Bundle for string resources.
static NSString *const kBundle = @"MaterialProgressView.bundle";

@interface MDCProgressView ()
@property(nonatomic, strong) MDCProgressGradientView *progressView;
@property(nonatomic, strong) MDCProgressGradientView *indeterminateProgressView;
@property(nonatomic, strong) UIView *trackView;
@property(nonatomic) BOOL animatingHide;
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

  _progressView = [[MDCProgressGradientView alloc] initWithFrame:CGRectZero];
  [self addSubview:_progressView];

  _indeterminateProgressView = [[MDCProgressGradientView alloc] initWithFrame:CGRectZero];
  _indeterminateProgressView.hidden = YES;
  [self addSubview:_indeterminateProgressView];

  _progressView.colors = @[
    (id)MDCProgressViewDefaultTintColor().CGColor, (id)MDCProgressViewDefaultTintColor().CGColor
  ];
  _indeterminateProgressView.colors = @[
    (id)MDCProgressViewDefaultTintColor().CGColor, (id)MDCProgressViewDefaultTintColor().CGColor
  ];
  _trackView.backgroundColor =
      [[self class] defaultTrackTintColorForProgressTintColor:MDCProgressViewDefaultTintColor()];
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
    [self updateIndeterminateProgressView];
    [self updateTrackView];
  }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.progressTintColor) {
    self.progressView.colors =
        @[ (id)self.progressTintColor.CGColor, (id)self.progressTintColor.CGColor ];
    self.indeterminateProgressView.colors =
        @[ (id)self.progressTintColor.CGColor, (id)self.progressTintColor.CGColor ];
  }

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
  _progressTintColor = progressTintColor;
  _progressTintColors = nil;
  if (progressTintColor != nil) {
    self.progressView.colors = @[ (id)progressTintColor.CGColor, (id)progressTintColor.CGColor ];
    self.indeterminateProgressView.colors =
        @[ (id)progressTintColor.CGColor, (id)progressTintColor.CGColor ];
  } else {
    self.progressView.colors = nil;
    self.indeterminateProgressView.colors = nil;
  }
}

- (void)setProgressTintColors:(NSArray *)progressTintColors {
  _progressTintColors = [progressTintColors copy];
  _progressTintColor = nil;
  self.progressView.colors = _progressTintColors;
  self.indeterminateProgressView.colors = _progressTintColors;
}

- (UIColor *)trackTintColor {
  return self.trackView.backgroundColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
  self.trackView.backgroundColor = trackTintColor;
}

- (void)setMode:(MDCProgressViewMode)mode {
  if (_mode == mode) {
    return;
  }
  _mode = mode;

  self.indeterminateProgressView.hidden = (mode == MDCProgressViewModeDeterminate);
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  _cornerRadius = cornerRadius;

  _progressView.layer.cornerRadius = cornerRadius;
  _indeterminateProgressView.layer.cornerRadius = cornerRadius;
  _trackView.layer.cornerRadius = cornerRadius;

  BOOL hasNonZeroCornerRadius = !MDCCGFloatIsExactlyZero(cornerRadius);
  _progressView.clipsToBounds = hasNonZeroCornerRadius;
  _indeterminateProgressView.clipsToBounds = hasNonZeroCornerRadius;
  _trackView.clipsToBounds = hasNonZeroCornerRadius;
}

- (void)setProgress:(float)progress {
  if (progress > 1)
    progress = 1;
  if (progress < 0)
    progress = 0;
  _progress = progress;
  // Indeterminate mode ignores the progress.
  if (_mode == MDCProgressViewModeIndeterminate) {
    return;
  }
  [self accessibilityValueDidChange];
  [self setNeedsLayout];
}

- (void)setProgress:(float)progress
           animated:(BOOL)animated
         completion:(void (^__nullable)(BOOL finished))userCompletion {
  if (_mode == MDCProgressViewModeIndeterminate) {
    self.progress = progress;
    if (userCompletion) {
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
    CGFloat scale = self.window.screen.scale > 0 ? self.window.screen.scale : 1;
    CGFloat pointWidth = self.progress * CGRectGetWidth(self.bounds);
    CGFloat pixelAlignedWidth = round(pointWidth * scale) / scale;
    progressFrame = CGRectMake(0, 0, pixelAlignedWidth, CGRectGetHeight(self.bounds));
  } else {
    if (!self.animating) {
      progressFrame = CGRectZero;
    }
  }
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
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

- (void)startAnimatingBar {
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

@end
