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

#import "MDCSwitch.h"

#import "MaterialThumbTrack.h"

static const CGSize MDCSwitchIntrinsicSize = {.width = 36.0f, .height = 27.0f};

static const CGFloat kMDCSwitchThumbRadius = 10.0f;
static const CGFloat kMDCSwitchTrackHeight = 14.0f;
static const CGFloat kMDCSwitchMinTouchSize = 48.0f;

@interface MDCSwitch () <MDCThumbTrackDelegate>
@end

@implementation MDCSwitch {
  MDCThumbTrack *_thumbTrack;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInitWithColor:nil];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // TODO(iangordon): Get color from Storyboard / XIB
    [self commonInitWithColor:nil];
  }
  return self;
}

- (void)commonInitWithColor:(UIColor *)color {
  if (color == nil) {
    color = [MDCSwitch defaultOnTintColor];
  }
  _thumbTrack = [[MDCThumbTrack alloc] initWithFrame:self.bounds onTintColor:color];
  [_thumbTrack addTarget:self
                  action:@selector(thumbTrackValueChanged:)
        forControlEvents:UIControlEventValueChanged];
  _thumbTrack.continuousUpdateEvents = NO;
  _thumbTrack.trackHeight = kMDCSwitchTrackHeight;
  _thumbTrack.thumbRadius = kMDCSwitchThumbRadius;
  _thumbTrack.trackEndsAreRounded = YES;
  _thumbTrack.interpolateOnOffColors = YES;
  _thumbTrack.numDiscreteValues = 2;
  _thumbTrack.thumbView.borderWidth = 0;
  _thumbTrack.thumbView.hasShadow = YES;
  _thumbTrack.panningAllowedOnEntireControl = YES;
  _thumbTrack.tapsAllowedOnThumb = YES;
  _thumbTrack.shouldDisplayInk = NO;
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

  // TODO(iangordon): Handle BiDi layouts
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
  CGFloat dx = MIN(0, (self.bounds.size.height - kMDCSwitchMinTouchSize) / 2);
  CGRect rect = CGRectInset(self.bounds, dx, dx);
  return CGRectContainsPoint(rect, point);
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
  [_thumbTrack setValue:value animated:animated userGenerated:NO completion:NULL];

  [self updateAccessibilityValues];
}

#pragma mark - Private Methods

#pragma mark MDCThumbTrackDelegate

- (void)thumbTrack:(MDCThumbTrack *)thumbTrack willJumpToValue:(CGFloat)value {
  [self toggleStateFromThumbTrack:thumbTrack withValue:value];
  [self updateAccessibilityValues];
}

/**
 * Updates the accessibility value of the switch given a toggle state.
 * @param toggleState A value for the state of the switch.
 */
- (void)updateAccessibilityValues {
  // Set accessibility value similar to native UISwitch.
  if (self.on) {
    self.accessibilityValue = [[self class] a11yLabelOnString];
  } else {
    self.accessibilityValue = [[self class] a11yLabelOffString];
  }

  if (self.enabled) {
    self.accessibilityTraits &= ~UIAccessibilityTraitNotEnabled;
    self.accessibilityHint = [[self class] a11yHintString];
  } else {
    self.accessibilityTraits |= UIAccessibilityTraitNotEnabled;
    self.accessibilityHint = nil;
  }
}

/**
 * Returns the toggle state of the switch given a possible slider @c value on the @c thumbTrack.
 * @param thumbTrack The contained @c MDCThumbTrack object.
 * @param value The value of the slider in @c thumbTrack.
 */
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

+ (NSString *)a11yStringForKey:(NSString *)key {
  NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"MaterialSwitch" ofType:@"bundle"];
  NSBundle *componentBundle = [NSBundle bundleWithPath:bundlePath];
  NSString *localizedString =
      NSLocalizedStringFromTableInBundle(key, @"MaterialSwitch", componentBundle, nil);

  return localizedString;
}

+ (NSString *)a11yLabelOnString {
  return [[self class] a11yStringForKey:@"MDCSwitchAccessibilityLabelOn"];
}

+ (NSString *)a11yLabelOffString {
  return [[self class] a11yStringForKey:@"MDCSwitchAccessibilityLabelOff"];
}

+ (NSString *)a11yHintString {
  return [[self class] a11yStringForKey:@"MDCSwitchAccessibilityHint"];
}

#pragma mark - Default Colors

// TODO(iangordon): Document source of these values after Theme decision
static const CGFloat kMDCSwitchLightThemeTrackOffAlpha = 0.26f;
static const CGFloat kMDCSwitchLightThemeTrackDisabledAlpha = 0.12f;

+ (UIColor *)defaultOnTintColor {
  return [UIColor greenColor];
}

+ (UIColor *)defaultOffThumbColor {
  // Original MDCSwitchStyleLight Color
  return [UIColor colorWithWhite:0.980f alpha:1];
}

+ (UIColor *)defaultOffTrackColor {
  return [[UIColor blackColor] colorWithAlphaComponent:kMDCSwitchLightThemeTrackOffAlpha];
}

+ (UIColor *)defaultDisabledThumbColor {
  // Original MDCSwitchStyleLight Color
  return [UIColor colorWithWhite:0.741f alpha:1];
}

+ (UIColor *)defaultDisabledTrackColor {
  return [[UIColor blackColor] colorWithAlphaComponent:kMDCSwitchLightThemeTrackDisabledAlpha];
}

@end
