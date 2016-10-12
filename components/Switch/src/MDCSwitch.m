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

#import "MDCSwitch.h"

#import "MaterialInk.h"
#import "MaterialRTL.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"

static const CGSize MDCSwitchIntrinsicSize = {.width = 36.0f, .height = 27.0f};

static const CGFloat kSwitchThumbRadius = 10.0f;
static const CGFloat kSwitchTrackHeight = 14.0f;
static const CGFloat kSwitchMinTouchSize = 48.0f;
static const CGFloat kSwitchTrackOnAlpha = 0.5f;
static const CGFloat kInkMaxRippleRadiusFactor = 2.375f;

@interface MDCSwitch () <MDCInkTouchControllerDelegate>

@property(nonatomic, readonly) CGFloat thumbPanRange;
@property(nonatomic, readonly) UIColor *thumbColor;
@property(nonatomic, readonly) UIColor *trackColor;

- (void)setIcon:(nullable UIImage *)icon;

@end

@implementation MDCSwitch {
  UIImageView *_iconView;
  UIImageView *_thumbView;
  UIImageView *_trackView;
  UIView *_thumbShadowView;
  MDCInkTouchController *_inkController;
  BOOL _didChangeValueDuringPan;
  BOOL _isTouching;
  CGFloat _thumbTrackPanValue;
  CGFloat _panThumbGrabPosition;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCSwitchInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // TODO(iangordon): Get color from Storyboard / XIB
    [self commonMDCSwitchInit];
  }
  return self;
}

- (void)commonMDCSwitchInit {
  // TODO(iangordon): Set a sane default in the UIAppearance Proxy
  UIColor *color = [MDCSwitch defaultOnTintColor];

  self.multipleTouchEnabled = NO;

  self.onTintColor = color;

  // From the original MDCSwitchStyleLight
  self.offThumbColor = [[self class] defaultOffThumbColor];
  self.disabledThumbColor = [[self class] defaultDisabledThumbColor];
  self.offTrackColor = [[self class] defaultOffTrackColor];
  self.disabledTrackColor = [[self class] defaultDisabledTrackColor];

  // Set initial state to off.
  [self setOn:NO];

  // Setup accessibility.
  self.isAccessibilityElement = YES;
  self.accessibilityTraits = [super accessibilityTraits] | UIAccessibilityTraitButton;
  [self updateAccessibilityValues];

  [self setNeedsLayout];

  _thumbShadowView = [[UIView alloc] initWithFrame:CGRectZero];
  [_thumbShadowView.layer addSublayer:[[self class] thumbShadowLayer]];
  [self addSubview:_thumbShadowView];

  _trackView = [[UIImageView alloc] initWithImage:[[self class] trackImage]];
  _trackView.tintColor = self.trackColor;
  [self addSubview:_trackView];

  _thumbView = [[UIImageView alloc] initWithImage:[[self class] thumbImage]];
  _thumbView.tintColor = self.thumbColor;
  _thumbView.userInteractionEnabled = YES;
  [self addSubview:_thumbView];

  _inkController = [[MDCInkTouchController alloc] initWithView:_thumbView];
  _inkController.delegate = self;
  [_inkController addInkView];
  _inkController.defaultInkView.inkStyle = MDCInkStyleUnbounded;
  _inkController.defaultInkView.maxRippleRadius = kInkMaxRippleRadiusFactor * kSwitchThumbRadius;
  _inkController.defaultInkView.inkColor =
      [self.onTintColor colorWithAlphaComponent:kSwitchTrackOnAlpha];
}

// TODO(iangordon): Remove/Re-enable setSwitchStyle after Theme decision

- (void)layoutSubviews {
  [super layoutSubviews];

  CGPoint trackPosition = [self trackPositionForState:self.on];
  _thumbShadowView.center = trackPosition;
  _thumbView.center = trackPosition;

  // If necessary, flip for RTL.
  if (self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    [self.layer setAffineTransform:CGAffineTransformMakeScale(-1, 1)];
  }
}

- (void)setOnTintColor:(UIColor *)onTintColor {
  if (onTintColor == nil) {
    onTintColor = [[self class] defaultOnTintColor];
  }
  _onTintColor = onTintColor;

  _inkController.defaultInkView.inkColor =
      [_onTintColor colorWithAlphaComponent:kSwitchTrackOnAlpha];
}

- (void)setOffThumbColor:(UIColor *)offThumbColor {
  if (offThumbColor == nil) {
    offThumbColor = [[self class] defaultOffThumbColor];
  }
  _offThumbColor = offThumbColor;
}

- (void)setDisabledThumbColor:(UIColor *)disabledThumbColor {
  if (disabledThumbColor == nil) {
    disabledThumbColor = [MDCSwitch defaultDisabledThumbColor];
  }
  _disabledThumbColor = disabledThumbColor;
}

- (void)setOffTrackColor:(UIColor *)offTrackColor {
  if (offTrackColor == nil) {
    offTrackColor = [MDCSwitch defaultOffTrackColor];
  }
  _offTrackColor = offTrackColor;
}

- (void)setDisabledTrackColor:(UIColor *)disabledTrackColor {
  if (disabledTrackColor == nil) {
    disabledTrackColor = [MDCSwitch defaultDisabledTrackColor];
  }
  _disabledTrackColor = disabledTrackColor;
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [self intrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
  return MDCSwitchIntrinsicSize;
}

// Override setFrame to ensure that the size can't change
- (void)setFrame:(CGRect)frame {
  if (frame.size.width != MDCSwitchIntrinsicSize.width ||
      frame.size.height != MDCSwitchIntrinsicSize.height) {
    frame.size = MDCSwitchIntrinsicSize;
  }
  [super setFrame:frame];
}

// Override setBounds to ensure that the size can't change
- (void)setBounds:(CGRect)bounds {
  if (bounds.size.width != MDCSwitchIntrinsicSize.width ||
      bounds.size.height != MDCSwitchIntrinsicSize.height) {
    bounds.size = MDCSwitchIntrinsicSize;
  }
  [super setBounds:bounds];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  CGFloat dx = MIN(0, (self.bounds.size.height - kSwitchMinTouchSize) / 2);
  CGRect rect = CGRectInset(self.bounds, dx, dx);
  return CGRectContainsPoint(rect, point);
}

- (void)setOnImage:(UIImage *)onImage {
  _onImage = onImage;
  if (self.on) {
    [self setIcon:onImage];
  }
}

- (void)setOffImage:(UIImage *)offImage {
  _offImage = offImage;
  if (!self.on) {
    [self setIcon:offImage];
  }
}

#pragma mark - Enabled state

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];

  [self updateColors];
  [self updateAccessibilityValues];
}

#pragma mark - Update Switch

- (void)setOn:(BOOL)on {
  [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
  [self setOn:on animated:animated userGenerated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated userGenerated:(BOOL)userGenerated {
  _on = on;
  _thumbTrackPanValue = _on ? 1.0 : 0.0;

  // TODO(iangordon): Find a nicer way to smoothly animate between the on/off image.
  if (_on) {
    [self setIcon:_onImage];
  } else {
    [self setIcon:_offImage];
  }

  [self setNeedsLayout];

  void (^updateBlock)() = ^{
    [self layoutIfNeeded];
    [self updateColors];
  };

  if (animated) {
    UIViewAnimationOptions options =
        UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:0.25 delay:0 options:options animations:updateBlock completion:nil];
  } else {
    updateBlock();
  }

  if (userGenerated) {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self fireHapticFeedback];
  }

  [self updateAccessibilityValues];
}

#pragma mark - Private Methods

- (void)fireHapticFeedback {
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
  if ([UIImpactFeedbackGenerator class]) {
    // This matches the feedback used on UISwitch.
    UIImpactFeedbackGenerator *generator =
        [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [generator impactOccurred];
  }
#endif
}

- (void)updateColors {
  _trackView.tintColor = self.trackColor;
  _thumbView.tintColor = self.thumbColor;
}

- (UIColor *)thumbColor {
  if (!self.enabled) {
    return self.disabledThumbColor;
  } else if (self.isOn) {
    return self.onTintColor;
  } else {
    return self.offThumbColor;
  }
}

- (UIColor *)trackColor {
  if (!self.enabled) {
    return self.disabledTrackColor;
  } else if (self.isOn) {
    return [self.onTintColor colorWithAlphaComponent:kSwitchTrackOnAlpha];
  } else {
    return self.offTrackColor;
  }
}

- (void)setIcon:(nullable UIImage *)icon {
  if (icon == _iconView.image || [icon isEqual:_iconView.image])
    return;

  if (_iconView) {
    [_iconView removeFromSuperview];
    _iconView = nil;
  }
  if (icon) {
    _iconView = [[UIImageView alloc] initWithImage:icon];
    [_thumbView addSubview:_iconView];
    // Calculate the inner square of the thumbs circle.
    CGFloat sideLength = (CGFloat)sin(45.0 / 180.0 * M_PI) * kSwitchThumbRadius * 2;
    CGSize thumbSize = _thumbView.image.size;
    _iconView.frame = CGRectMake(thumbSize.width / 2 - sideLength / 2,
                                 thumbSize.height / 2 - sideLength / 2, sideLength, sideLength);
  }
}

- (void)updateAccessibilityValues {
  // Accessibility value handled in -accessibilityValue method
  if (self.enabled) {
    self.accessibilityTraits &= ~UIAccessibilityTraitNotEnabled;
    self.accessibilityHint = [[self class] defaultA11yHintString];
  } else {
    self.accessibilityTraits |= UIAccessibilityTraitNotEnabled;
    self.accessibilityHint = nil;
  }
}

#pragma mark - MDCInkTouchControllerDelegate

- (BOOL)inkTouchController:(nonnull MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
  return YES;
}

#pragma mark Thumb Tracking Helpers

- (BOOL)stateForPanValue:(CGFloat)value {
  return value >= 0.5;
}

- (CGPoint)thumbPosition {
  return _thumbView.center;
}

- (CGFloat)valueForThumbPosition:(CGPoint)position {
  CGFloat value = (position.x - kSwitchThumbRadius) / self.thumbPanRange;
  return MAX(0, MIN(value, 1));
}

// Describes where on the track the specified state would fall.
- (CGPoint)trackPositionForState:(BOOL)on {
  return CGPointMake(kSwitchThumbRadius + (on ? self.thumbPanRange : 0),
                     self.frame.size.height / 2);
}

- (CGFloat)thumbPanRange {
  return MDCSwitchIntrinsicSize.width - 2 * kSwitchThumbRadius;
}

#pragma mark - UIResponder Events

/*
 Much of this code is based off of MDCThumbTrack as a means to optimize and simplify MDCSwitch.

 Like MDCThumbTrack, we implement our own touch handling here instead of using gesture recognizers.
 This allows more fine grained control over how the thumb view behaves, including more specific
 logic over what counts as a tap vs. a drag.

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (!self.enabled || _isTouching) {
    return;
  }

  CGPoint touchLoc = [[touches anyObject] locationInView:self];
  _isTouching = YES;
  _didChangeValueDuringPan = NO;
  _panThumbGrabPosition = touchLoc.x - self.thumbPosition.x;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (!self.enabled || !_isTouching) {
    return;
  }

  UITouch *touch = [touches anyObject];
  CGPoint touchLoc = [touch locationInView:self];
  CGFloat thumbPosition = touchLoc.x - _panThumbGrabPosition;
  CGFloat previousPanValue = _thumbTrackPanValue;
  _thumbTrackPanValue = [self valueForThumbPosition:CGPointMake(thumbPosition, 0)];

  if (_thumbTrackPanValue != previousPanValue) {
    // We made a move, now this action can't later count as a tap
    _didChangeValueDuringPan = YES;
  }

  BOOL state = [self stateForPanValue:_thumbTrackPanValue];
  if (state != _on) {
    [self setOn:state animated:YES userGenerated:YES];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  _isTouching = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (!self.enabled || !_isTouching) {
    return;
  }

  _isTouching = NO;

  CGPoint touchLoc = [touch locationInView:self];
  if ([self pointInside:touchLoc withEvent:nil]) {
    if (!_didChangeValueDuringPan) {
      // Treat it like a tap
      [self setOn:!self.on animated:YES userGenerated:YES];
    }
  }
}

#pragma mark - UIControl Methods

- (BOOL)isTracking {
  return _isTouching;
}

#pragma mark - Appearance Generation

+ (UIImage *)trackImage {
  static UIImage *trackImage;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    CGRect trackRect = CGRectMake(0, MDCSwitchIntrinsicSize.height / 2 - kSwitchTrackHeight / 2,
                                  MDCSwitchIntrinsicSize.width, kSwitchTrackHeight);
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;

    // Local variable used here to avoid analyzer warnings about a potential leak on XCode 7.
    CGPathRef path = CGPathCreateWithRoundedRect(trackRect, kSwitchTrackHeight / 2,
                                                 kSwitchTrackHeight / 2, NULL);
    layer.path = path;
    CGPathRelease(path);

    UIGraphicsBeginImageContextWithOptions(MDCSwitchIntrinsicSize, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    trackImage = [UIGraphicsGetImageFromCurrentImageContext()
        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    UIGraphicsEndImageContext();
  });

  return trackImage;
}

+ (MDCShadowLayer *)thumbShadowLayer {
  CGRect thumbRect = CGRectMake(-kSwitchThumbRadius, -kSwitchThumbRadius, kSwitchThumbRadius * 2,
                                kSwitchThumbRadius * 2);
  MDCShadowLayer *layer = [[MDCShadowLayer alloc] init];
  layer.shouldRasterize = YES;
  layer.rasterizationScale = [UIScreen mainScreen].scale;
  layer.shadowMaskEnabled = NO;
  [layer setElevation:MDCShadowElevationCardResting];

  // Local variable used here to avoid analyzer warnings about a potential leak on XCode 7.
  CGPathRef path = CGPathCreateWithEllipseInRect(thumbRect, NULL);
  layer.shadowPath = path;
  CGPathRelease(path);

  // Unfortunately we can't cache the MDCShadowLayer as an image as CALayer:renderInContext doesn't
  // support rendering a layer that consists only of a shadowPath. Rasterizing the layer is a
  // reasonable compromise.

  return layer;
}

+ (UIImage *)thumbImage {
  static UIImage *thumbImage;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    CGFloat edgeLength = MIN(MDCSwitchIntrinsicSize.width, MDCSwitchIntrinsicSize.height);
    CGSize size = CGSizeMake(edgeLength, edgeLength);
    CGRect thumbRect =
        CGRectMake(edgeLength / 2 - kSwitchThumbRadius, edgeLength / 2 - kSwitchThumbRadius,
                   kSwitchThumbRadius * 2, kSwitchThumbRadius * 2);
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor whiteColor].CGColor;

    // Local variable used here to avoid analyzer warnings about a potential leak on XCode 7.
    CGPathRef path = CGPathCreateWithEllipseInRect(thumbRect, NULL);
    layer.path = path;
    CGPathRelease(path);

    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    thumbImage = [UIGraphicsGetImageFromCurrentImageContext()
        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    UIGraphicsEndImageContext();
  });

  return thumbImage;
}

#pragma mark - Accessibility Strings

- (NSString *)accessibilityValue {
  if (self.on) {
    return self.onAccessibilityValue ?: [[self class] defaultA11yValueOnString];
  } else {
    return self.offAccessibilityValue ?: [[self class] defaultA11yValueOffString];
  }
}

+ (NSString *)a11yStringForKey:(NSString *)key {
  NSString *bundlePath =
      [[NSBundle bundleForClass:[self class]] pathForResource:@"MaterialSwitch" ofType:@"bundle"];
  NSBundle *componentBundle = [NSBundle bundleWithPath:bundlePath];
  NSString *localizedString =
      NSLocalizedStringFromTableInBundle(key, @"MaterialSwitch", componentBundle, nil);

  return localizedString;
}

+ (NSString *)defaultA11yValueOnString {
  return [[self class] a11yStringForKey:@"MDCSwitchAccessibilityValueOn"];
}

+ (NSString *)defaultA11yValueOffString {
  return [[self class] a11yStringForKey:@"MDCSwitchAccessibilityValueOff"];
}

+ (NSString *)defaultA11yHintString {
  return [[self class] a11yStringForKey:@"MDCSwitchAccessibilityHint"];
}

#pragma mark - Default Colors

// TODO(iangordon): Document source of these values after Theme decision
static const CGFloat kSwitchLightThemeTrackOffAlpha = 0.26f;
static const CGFloat kSwitchLightThemeTrackDisabledAlpha = 0.12f;

+ (UIColor *)defaultOnTintColor {
  return [UIColor colorWithRed:0.32f green:0.87f blue:0 alpha:1];
}

+ (UIColor *)defaultOffThumbColor {
  // Original MDCSwitchStyleLight Color
  return [UIColor colorWithWhite:0.980f alpha:1];
}

+ (UIColor *)defaultOffTrackColor {
  return [[UIColor blackColor] colorWithAlphaComponent:kSwitchLightThemeTrackOffAlpha];
}

+ (UIColor *)defaultDisabledThumbColor {
  // Original MDCSwitchStyleLight Color
  return [UIColor colorWithWhite:0.741f alpha:1];
}

+ (UIColor *)defaultDisabledTrackColor {
  return [[UIColor blackColor] colorWithAlphaComponent:kSwitchLightThemeTrackDisabledAlpha];
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
  return YES;
}

@end
