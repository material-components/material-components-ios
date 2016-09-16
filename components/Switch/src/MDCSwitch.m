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

#import "MaterialRTL.h"
#import "MaterialThumbTrack.h"

static const CGSize MDCSwitchIntrinsicSize = {.width = 36.0f, .height = 27.0f};

static const CGFloat kSwitchThumbRadius = 10.0f;
static const CGFloat kSwitchTrackHeight = 14.0f;
static const CGFloat kSwitchMinTouchSize = 48.0f;
static const CGFloat kInkMaxRippleRadiusFactor = 2.375f;

@interface MDCSwitch () <MDCThumbTrackDelegate>
@end

@implementation MDCSwitch {
  MDCThumbTrack *_thumbTrack;
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
  _thumbTrack = [[MDCThumbTrack alloc] initWithFrame:self.bounds onTintColor:color];
  [_thumbTrack addTarget:self
                  action:@selector(thumbTrackValueChanged:)
        forControlEvents:UIControlEventValueChanged];
  _thumbTrack.continuousUpdateEvents = NO;
  _thumbTrack.trackHeight = kSwitchTrackHeight;
  _thumbTrack.thumbRadius = kSwitchThumbRadius;
  _thumbTrack.thumbMaxRippleRadius = kInkMaxRippleRadiusFactor * kSwitchThumbRadius;
  _thumbTrack.trackEndsAreRounded = YES;
  _thumbTrack.interpolateOnOffColors = YES;
  _thumbTrack.numDiscreteValues = 2;
  _thumbTrack.thumbView.borderWidth = 0;
  _thumbTrack.thumbView.hasShadow = YES;
  _thumbTrack.panningAllowedOnEntireControl = YES;
  _thumbTrack.tapsAllowedOnThumb = YES;
  _thumbTrack.delegate = self;
  [self addSubview:_thumbTrack];

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
}

// TODO(iangordon): Remove/Re-enable setSwitchStyle after Theme decision

- (void)layoutSubviews {
  [super layoutSubviews];
  _thumbTrack.frame = self.bounds;

  // If necessary, flip for RTL.
  if (self.mdc_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    [self.layer setAffineTransform:CGAffineTransformMakeScale(-1, 1)];
  }
}

- (UIColor *)onTintColor {
  return _thumbTrack.primaryColor;
}

- (void)setOnTintColor:(UIColor *)onTintColor {
  if (onTintColor == nil) {
    onTintColor = [[self class] defaultOnTintColor];
  }
  _thumbTrack.primaryColor = onTintColor;
}

- (UIColor *)offThumbColor {
  return _thumbTrack.thumbOffColor;
}

- (void)setOffThumbColor:(UIColor *)offThumbColor {
  if (offThumbColor == nil) {
    offThumbColor = [[self class] defaultOffThumbColor];
  }
  _thumbTrack.thumbOffColor = offThumbColor;
}

- (UIColor *)disabledThumbColor {
  return _thumbTrack.thumbDisabledColor;
}

- (void)setDisabledThumbColor:(UIColor *)disabledThumbColor {
  if (disabledThumbColor == nil) {
    disabledThumbColor = [MDCSwitch defaultDisabledThumbColor];
  }
  _thumbTrack.thumbDisabledColor = disabledThumbColor;
}

- (UIColor *)offTrackColor {
  return _thumbTrack.trackOffColor;
}

- (void)setOffTrackColor:(UIColor *)offTrackColor {
  if (offTrackColor == nil) {
    offTrackColor = [MDCSwitch defaultOffTrackColor];
  }
  _thumbTrack.trackOffColor = offTrackColor;
}

- (UIColor *)disabledTrackColor {
  return _thumbTrack.trackDisabledColor;
}

- (void)setDisabledTrackColor:(UIColor *)disabledTrackColor {
  if (disabledTrackColor == nil) {
    disabledTrackColor = [MDCSwitch defaultDisabledTrackColor];
  }
  _thumbTrack.trackDisabledColor = disabledTrackColor;
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
    [_thumbTrack setIcon:onImage];
  }
}

- (void)setOffImage:(UIImage *)offImage {
  _offImage = offImage;
  if (!self.on) {
    [_thumbTrack setIcon:offImage];
  }
}

#pragma mark - Enabled state

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  _thumbTrack.enabled = enabled;

  [self updateAccessibilityValues];
}

#pragma mark - Update Switch

- (void)setOn:(BOOL)on {
  [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
  _on = on;

  CGFloat value = _on ? _thumbTrack.maximumValue : _thumbTrack.minimumValue;
  [_thumbTrack setValue:value
                   animated:animated
      animateThumbAfterMove:animated
              userGenerated:NO
                 completion:NULL];

  [self updateAccessibilityValues];
}

#pragma mark - Private Methods

#pragma mark MDCThumbTrackDelegate

- (void)thumbTrack:(MDCThumbTrack *)thumbTrack willJumpToValue:(CGFloat)value {
  // TODO(iangordon): Find a nicer way to smoothly animate between the on/off image.
  if (0.5 < value) {
    [_thumbTrack setIcon:_onImage];
  } else {
    [_thumbTrack setIcon:_offImage];
  }

  [self toggleStateFromThumbTrack:thumbTrack withValue:value];
  [self updateAccessibilityValues];
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

- (BOOL)toggleStateFromThumbTrack:(MDCThumbTrack *)thumbTrack withValue:(CGFloat)value {
  // TODO(ajsecord): When the track supports multiple discrete locations, get the location directly.
  BOOL allSignsPointToYes = value >= (thumbTrack.minimumValue + thumbTrack.maximumValue) / 2;
  return allSignsPointToYes;
}

#pragma mark - Handle gestures

- (void)thumbTrackValueChanged:(MDCThumbTrack *)thumbTrack {
  BOOL toggleState = [self toggleStateFromThumbTrack:thumbTrack withValue:thumbTrack.value];
  if (_on != toggleState) {
    _on = toggleState;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
  [self updateAccessibilityValues];
}

- (BOOL)isTracking {
  return _thumbTrack.isTracking;
}

#pragma mark - Animation tracking

- (void)thumbTrack:(MDCThumbTrack *)thumbTrack willAnimateToValue:(CGFloat)value {
  // While the thumb animates VO announces "the old value", telling it we update "frequently"
  // prevents that
  self.accessibilityTraits |= UIAccessibilityTraitUpdatesFrequently;
}

- (void)thumbTrack:(MDCThumbTrack *)thumbTrack didAnimateToValue:(CGFloat)value {
  // After the thumb is done animating we want the NEW value to get announced, so we give up
  // on this "frequently" stuff
  self.accessibilityTraits &= ~UIAccessibilityTraitUpdatesFrequently;
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

@end
