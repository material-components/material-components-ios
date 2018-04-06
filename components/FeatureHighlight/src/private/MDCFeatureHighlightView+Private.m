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

#import "MDCFeatureHighlightView+Private.h"

#import "MDCFeatureHighlightDismissGestureRecognizer.h"
#import "MDCFeatureHighlightLayer.h"
#import <MDFTextAccessibility/MDFTextAccessibility.h>

#import "MaterialFeatureHighlightStrings.h"
#import "MaterialFeatureHighlightStrings_table.h"
#import "MaterialMath.h"
#import "MaterialTypography.h"

static inline CGFloat CGPointDistanceToPoint(CGPoint a, CGPoint b) {
  return MDCHypot(a.x - b.x, a.y - b.y);
}

// The Bundle for string resources.
static NSString *const kMaterialFeatureHighlightBundle = @"MaterialFeatureHighlight.bundle";

const CGFloat kMDCFeatureHighlightMinimumInnerRadius = 44.0f;
const CGFloat kMDCFeatureHighlightInnerContentPadding = 10.0f;
const CGFloat kMDCFeatureHighlightInnerPadding = 20.0f;
const CGFloat kMDCFeatureHighlightTextPadding = 40.0f;
const CGFloat kMDCFeatureHighlightTextMaxWidth = 300.0f;
const CGFloat kMDCFeatureHighlightConcentricBound = 88.0f;
const CGFloat kMDCFeatureHighlightNonconcentricOffset = 20.0f;
const CGFloat kMDCFeatureHighlightMaxTextHeight = 1000.0f;
const CGFloat kMDCFeatureHighlightTitleBodyBaselineOffset = 32.0f;
const CGFloat kMDCFeatureHighlightOuterHighlightAlpha = 0.96f;

const CGFloat kMDCFeatureHighlightGestureDisappearThresh = 0.9f;
const CGFloat kMDCFeatureHighlightGestureAppearThresh = 0.95f;
const CGFloat kMDCFeatureHighlightGestureDismissThresh = 0.85f;
const CGFloat kMDCFeatureHighlightGestureAnimationDuration = 0.2f;

const CGFloat kMDCFeatureHighlightDismissAnimationDuration = 0.25f;

// Animation consts
const CGFloat kMDCFeatureHighlightInnerRadiusFactor = 1.1f;
const CGFloat kMDCFeatureHighlightOuterRadiusFactor = 1.125f;
const CGFloat kMDCFeatureHighlightPulseRadiusFactor = 2.0f;
const CGFloat kMDCFeatureHighlightPulseStartAlpha = 0.54f;
const CGFloat kMDCFeatureHighlightInnerRadiusBloomAmount =
    (kMDCFeatureHighlightInnerRadiusFactor - 1) * kMDCFeatureHighlightMinimumInnerRadius;
const CGFloat kMDCFeatureHighlightPulseRadiusBloomAmount =
    (kMDCFeatureHighlightPulseRadiusFactor - 1) * kMDCFeatureHighlightMinimumInnerRadius;

static const MDCFontTextStyle kTitleTextStyle = MDCFontTextStyleTitle;
static const MDCFontTextStyle kBodyTextStyle = MDCFontTextStyleSubheadline;

static inline CGPoint CGPointAddedToPoint(CGPoint a, CGPoint b) {
  return CGPointMake(a.x + b.x, a.y + b.y);
}

@implementation MDCFeatureHighlightView {
  BOOL _forceConcentricLayout;
  UIView *_highlightView;
  CGPoint _highlightPoint;
  CGFloat _innerRadius;
  CGPoint _outerCenter;
  CGFloat _outerRadius;
  CGFloat _outerRadiusScale;
  BOOL _isLayedOutAppearing;
  MDCFeatureHighlightLayer *_outerLayer;
  MDCFeatureHighlightLayer *_pulseLayer;
  MDCFeatureHighlightLayer *_innerLayer;
  MDCFeatureHighlightLayer *_displayMaskLayer;

  BOOL _mdc_adjustsFontForContentSizeCategory;

  // This view is a hack to work around UIKit calling our animation completion blocks immediately if
  // there is no UIKit content being animated. Since our appearance and disappearance animations are
  // mostly CAAnimations, we need to guarantee there will be a UIKit animation occuring in order to
  // ensure we always see the full CAAnimations before the completion blocks are called.
  UIView *_dummyAnimatedView;
}

@synthesize highlightRadius = _outerRadius;

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor clearColor];

    _dummyAnimatedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _dummyAnimatedView.backgroundColor = [UIColor clearColor];
    [self addSubview:_dummyAnimatedView];

    _outerLayer = [[MDCFeatureHighlightLayer alloc] init];
    [self.layer addSublayer:_outerLayer];

    _pulseLayer = [[MDCFeatureHighlightLayer alloc] init];
    [self.layer addSublayer:_pulseLayer];

    _innerLayer = [[MDCFeatureHighlightLayer alloc] init];
    [self.layer addSublayer:_innerLayer];

    _displayMaskLayer = [[MDCFeatureHighlightLayer alloc] init];
    _displayMaskLayer.fillColor = [UIColor whiteColor].CGColor;

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    // TODO(#2709): Migrate to a single source of truth for fonts
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
      _titleLabel.font = [UIFont mdc_standardFontForMaterialTextStyle:kTitleTextStyle];
    } else {
      // There is a custom font loader, retrieve the font from it.
      _titleLabel.font = [MDCTypography titleFont];
    }
    _titleLabel.textAlignment = NSTextAlignmentNatural;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.numberOfLines = 0;
    _titleLabel.accessibilityHint = [[self class] dismissAccessibilityHint];
    [self addSubview:_titleLabel];

    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    // TODO(#2709): Migrate to a single source of truth for fonts
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
      _bodyLabel.font = [UIFont mdc_standardFontForMaterialTextStyle:kBodyTextStyle];
    } else {
      // There is a custom font loader, retrieve the font from it.
      _bodyLabel.font = [MDCTypography body1Font];
    }
    _bodyLabel.shadowColor = nil;
    _bodyLabel.shadowOffset = CGSizeZero;
    _bodyLabel.textAlignment = NSTextAlignmentNatural;
    _bodyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _bodyLabel.numberOfLines = 0;
    [self addSubview:_bodyLabel];

    UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];

    MDCFeatureHighlightDismissGestureRecognizer *panRecognizer =
        [[MDCFeatureHighlightDismissGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(didGestureDismiss:)];
    panRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:panRecognizer];

    // We want the inner and outer highlights to animate from the same origin so we start them from
    // a concentric position.
    _forceConcentricLayout = YES;
    [self applyMDCFeatureHighlightViewDefaults];

    _outerRadiusScale = 1.0;
  }
  return self;
}

- (void)dealloc {
  //TODO(#2651): Remove once we move to iOS8
  // Remove Dynamic Type contentSizeCategoryDidChangeNotification
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}

- (void)applyMDCFeatureHighlightViewDefaults {
  _outerHighlightColor = [self MDCFeatureHighlightDefaultOuterHighlightColor];
  _innerHighlightColor = [self MDCFeatureHighlightDefaultInnerHighlightColor];
}

- (UIColor *)MDCFeatureHighlightDefaultOuterHighlightColor {
  return [[UIColor blueColor] colorWithAlphaComponent:kMDCFeatureHighlightOuterHighlightAlpha];
}

- (UIColor *)MDCFeatureHighlightDefaultInnerHighlightColor {
  return [UIColor whiteColor];
}

- (void)setOuterHighlightColor:(UIColor *)outerHighlightColor {
  if (!outerHighlightColor) {
    outerHighlightColor = [self MDCFeatureHighlightDefaultOuterHighlightColor];
  }
  _outerHighlightColor = outerHighlightColor;
  _outerLayer.fillColor = _outerHighlightColor.CGColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
  _titleFont = titleFont;

  [self updateTitleFont];
}

- (void)updateTitleFont {
  if (!_titleFont) {
    _titleFont = [MDCFeatureHighlightView defaultTitleFont];
  }
  if (_mdc_adjustsFontForContentSizeCategory) {
    _titleLabel.font =
        [_titleFont mdc_fontSizedForMaterialTextStyle:kTitleTextStyle
                                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  } else {
    _titleLabel.font = _titleFont;
  }

  [self setNeedsLayout];
}

- (void)setTitleColor:(UIColor *)titleColor {
  _titleColor = titleColor;

  _titleLabel.textColor = titleColor;
}

- (void)setBodyFont:(UIFont *)bodyFont {
  _bodyFont = bodyFont;

  [self updateBodyFont];
}

- (void)updateBodyFont {
  if (!_bodyFont) {
    _bodyFont = [MDCFeatureHighlightView defaultBodyFont];
  }
  if (_mdc_adjustsFontForContentSizeCategory) {
    _bodyLabel.font =
        [_bodyFont mdc_fontSizedForMaterialTextStyle:kBodyTextStyle
                                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  } else {
    _bodyLabel.font = _bodyFont;
  }
  [self setNeedsLayout];
}

- (void)setBodyColor:(UIColor *)bodyColor {
  _bodyColor = bodyColor;

  _bodyLabel.textColor = bodyColor;
}

+ (UIFont *)defaultBodyFont {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:kBodyTextStyle];
  }
  return [MDCTypography body1Font];
}

+ (UIFont *)defaultTitleFont {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:kTitleTextStyle];
  }
  return [MDCTypography titleFont];
}

- (void)setInnerHighlightColor:(UIColor *)innerHighlightColor {
  if (!innerHighlightColor) {
    innerHighlightColor = [self MDCFeatureHighlightDefaultInnerHighlightColor];
  }
  _innerHighlightColor = innerHighlightColor;

  _pulseLayer.fillColor = _innerHighlightColor.CGColor;
  _innerLayer.fillColor = _innerHighlightColor.CGColor;
}

- (void)layoutAppearing {
  _isLayedOutAppearing = YES;

  // TODO: Mask the labels during the presentation and dismissal animations.
  _titleLabel.alpha = 1;
  _bodyLabel.alpha = 1;

  // Guarantee something changes in case the label alphas are already 1.0
  _dummyAnimatedView.frame = CGRectOffset(_dummyAnimatedView.frame, 1, 0);
}

- (void)layoutDisappearing {
  _isLayedOutAppearing = NO;

  _titleLabel.alpha = 0;
  _bodyLabel.alpha = 0;

  // Guarantee something changes in case the label alphas are already 0.0
  _dummyAnimatedView.frame = CGRectOffset(_dummyAnimatedView.frame, 1, 0);
}

- (void)setDisplayedView:(UIView *)displayedView {
  CGSize displayedSize = displayedView.frame.size;
  CGFloat viewRadius =
      (CGFloat)sqrt(pow(displayedSize.width / 2, 2) + pow(displayedSize.height / 2, 2));
  viewRadius += kMDCFeatureHighlightInnerContentPadding;
  _innerRadius = MAX(viewRadius, kMDCFeatureHighlightMinimumInnerRadius);

  _displayedView.layer.mask = nil;
  [_displayedView removeFromSuperview];
  _displayedView = displayedView;
  [self addSubview:_displayedView];
  _displayedView.layer.mask = _displayMaskLayer;
}

- (void)setHighlightPoint:(CGPoint)highlightPoint {
  _highlightPoint = highlightPoint;

  [self setNeedsLayout];
}

- (void)layoutSubviews {
  [_innerLayer removeAllAnimations];
  [_outerLayer removeAllAnimations];
  [_pulseLayer removeAllAnimations];

  BOOL leftHalf = _highlightPoint.x < self.frame.size.width / 2;
  BOOL topHalf = _highlightPoint.y < self.frame.size.height / 2;

  CGFloat textWidth = MIN(self.frame.size.width - 2 * kMDCFeatureHighlightTextPadding,
                          kMDCFeatureHighlightTextMaxWidth);
  CGSize titleSize =
      [_titleLabel sizeThatFits:CGSizeMake(textWidth, kMDCFeatureHighlightMaxTextHeight)];
  CGSize detailSize =
      [_bodyLabel sizeThatFits:CGSizeMake(textWidth, kMDCFeatureHighlightMaxTextHeight)];
  titleSize.width = (CGFloat)ceil(MAX(titleSize.width, detailSize.width));
  detailSize.width = titleSize.width;

  CGFloat textVerticalPadding = 0;
  CGFloat textPaddingAbove = _titleLabel.font.descender;
  CGFloat textPaddingBelow = _bodyLabel.font.ascender - textPaddingAbove;
  if (titleSize.height > 0 && detailSize.height > 0) {
    textVerticalPadding = kMDCFeatureHighlightTitleBodyBaselineOffset - textPaddingBelow;
  }

  CGFloat textHeight = titleSize.height + detailSize.height + textVerticalPadding;

  if ((_highlightPoint.y <= kMDCFeatureHighlightConcentricBound) ||
      (_highlightPoint.y >= self.frame.size.height - kMDCFeatureHighlightConcentricBound)) {
    _highlightCenter = _highlightPoint;
  } else {
    if (topHalf) {
      _highlightCenter.y = _highlightPoint.y + _innerRadius + textHeight / 2;
    } else {
      _highlightCenter.y = _highlightPoint.y - _innerRadius - textHeight / 2;
    }
    if (leftHalf) {
      _highlightCenter.x = _highlightPoint.x + kMDCFeatureHighlightNonconcentricOffset;
    } else {
      _highlightCenter.x = _highlightPoint.x - kMDCFeatureHighlightNonconcentricOffset;
    }
  }

  CGPoint outerCenter = _forceConcentricLayout ? _highlightPoint : _highlightCenter;
  if (self.layer.animationKeys) {
    // If our layer has an animationKeys array then we must be inside an animation (because we're
    // resizing or rotating), so we want to use the current animation's properties for our various
    // layers' CAAnimations.
    CAAnimation *animation = [self.layer animationForKey:self.layer.animationKeys.firstObject];
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:animation.timingFunction];
    [CATransaction setAnimationDuration:animation.duration];
    [_innerLayer setPosition:_highlightPoint animated:YES];
    [_pulseLayer setPosition:_highlightPoint animated:YES];
    [_outerLayer setPosition:outerCenter animated:YES];
    [CATransaction commit];
  } else {
    _innerLayer.position = _highlightPoint;
    _pulseLayer.position = _highlightPoint;
    _outerLayer.position = outerCenter;
  }
  _displayedView.center = _highlightPoint;

  CGFloat leftTextBound = kMDCFeatureHighlightTextPadding;
  CGFloat rightTextBound = self.frame.size.width - MAX(titleSize.width, detailSize.width) -
      kMDCFeatureHighlightTextPadding;
  CGPoint titlePos = CGPointMake(0, 0);
  titlePos.x = MIN(MAX(_highlightCenter.x - textWidth / 2, leftTextBound), rightTextBound);
  if (topHalf) {
    titlePos.y = _highlightPoint.y + kMDCFeatureHighlightInnerPadding + _innerRadius;
  } else {
    titlePos.y = _highlightPoint.y - kMDCFeatureHighlightInnerPadding - _innerRadius - textHeight;
  }

  CGRect titleFrame =
      MDCRectAlignToScale((CGRect){titlePos, titleSize}, [UIScreen mainScreen].scale);
  _titleLabel.frame = titleFrame;

  CGFloat detailPositionY = (CGFloat)ceil(CGRectGetMaxY(titleFrame) + textVerticalPadding);
  CGRect detailFrame = (CGRect){CGPointMake(titlePos.x, detailPositionY), detailSize};
  _bodyLabel.frame = detailFrame;

  // Calculating the radius required for a circle centered at _highlightCenter that fully encircles
  // both labels.
  CGRect textFrames = CGRectUnion(_titleLabel.frame, _bodyLabel.frame);
  CGFloat distX = ABS(CGRectGetMidX(textFrames) - _highlightCenter.x) + textFrames.size.width / 2;
  CGFloat distY = ABS(CGRectGetMidY(textFrames) - _highlightCenter.y) + textFrames.size.height / 2;
  CGFloat minTextRadius =
      (CGFloat)(sqrt(pow(distX, 2) + pow(distY, 2)) + kMDCFeatureHighlightTextPadding);

  // Calculating the radius required for a circle centered at _highlightCenter that fully encircles
  // the inner highlight.
  distX = ABS(_highlightCenter.x - _highlightPoint.x);
  distY = ABS(_highlightCenter.y - _highlightPoint.y);
  CGFloat minInnerHighlightRadius = (CGFloat)(sqrt(pow(distX, 2) + pow(distY, 2)) + _innerRadius +
                                              kMDCFeatureHighlightInnerPadding);

  // Use the larger of the two radii to ensure everything is encircled.
  _outerRadius = MAX(minTextRadius, minInnerHighlightRadius);
}

- (void)didTapView:(UITapGestureRecognizer *)tapGestureRecognizer {
  CGPoint pos = [tapGestureRecognizer locationInView:self];
  CGFloat pointDist = CGPointDistanceToPoint(_highlightPoint, pos);
  CGFloat centerDist = CGPointDistanceToPoint(_highlightCenter, pos);

  if (self.interactionBlock) {
    if (centerDist > _outerRadius * _outerRadiusScale) {
      // For taps outside the outer highlight, dismiss as not accepted
      self.interactionBlock(NO);
    } else if (pointDist < _innerRadius) {
      // For taps inside the inner highlight, dismiss as accepted
      self.interactionBlock(YES);
    }
  }
}

- (void)didGestureDismiss:(MDCFeatureHighlightDismissGestureRecognizer *)dismissRecognizer {
  CGFloat progress = dismissRecognizer.progress;
  switch (dismissRecognizer.state) {
    case UIGestureRecognizerStateChanged:
      [self layoutInProgressDismissal:progress];
      break;

    case UIGestureRecognizerStateEnded:
      if (progress > kMDCFeatureHighlightGestureDismissThresh) {
        [self animateDismissalCancelled];
      } else {
        if (self.interactionBlock) {
          self.interactionBlock(NO);
        }
      }
      break;

    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed:
      [self animateDismissalCancelled];
      break;

    case UIGestureRecognizerStatePossible:
      break;

    case UIGestureRecognizerStateBegan:
      break;
  }
}

- (void)layoutInProgressDismissal:(CGFloat)progress {
  _outerRadiusScale = progress;
  [self updateOuterHighlight];

  // Square progress to ease-in the translation
  CGFloat translationProgress = (1 - progress * progress);
  CGPoint pointOffset = CGPointMake((_highlightPoint.x - _highlightCenter.x) * translationProgress,
                                    (_highlightPoint.y - _highlightCenter.y) * translationProgress);
  CGPoint center = CGPointAddedToPoint(_highlightCenter, pointOffset);
  [_outerLayer setPosition:center animated:NO];
  [_outerLayer removeAllAnimations];

  if (_isLayedOutAppearing) {
    if (progress < kMDCFeatureHighlightGestureDisappearThresh) {
      [UIView animateWithDuration:kMDCFeatureHighlightGestureAnimationDuration
                       animations:^{
                         [self layoutDisappearing];
                       }];
    }
  } else if (progress > kMDCFeatureHighlightGestureAppearThresh) {
    [UIView animateWithDuration:kMDCFeatureHighlightGestureAnimationDuration
                     animations:^{
                       [self layoutAppearing];
                     }];
  }
}

- (void)animateDismissalCancelled {
  [UIView animateWithDuration:kMDCFeatureHighlightGestureAnimationDuration
                   animations:^{
                     [self layoutAppearing];
                   }];

  _outerRadiusScale = 1;
  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction
                                                functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:kMDCFeatureHighlightDismissAnimationDuration];
  [_outerLayer setRadius:_outerRadius * _outerRadiusScale animated:YES];
  [_outerLayer setPosition:_highlightCenter animated:YES];
  [CATransaction commit];
}

- (void)animateDiscover:(NSTimeInterval)duration {
  [_innerLayer setFillColor:[_innerHighlightColor colorWithAlphaComponent:0].CGColor];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor];

  CGPoint displayMaskCenter =
      CGPointMake(_displayedView.frame.size.width / 2, _displayedView.frame.size.height / 2);

  [_displayMaskLayer setPosition:displayMaskCenter];
  [_innerLayer setPosition:_highlightPoint];
  [_pulseLayer setPosition:_highlightPoint];
  [_outerLayer setPosition:_highlightPoint];
  [_outerLayer setRadius:0.0 animated:NO];

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction
                                                functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:duration];
  [_displayMaskLayer setRadius:_innerRadius animated:YES];
  [_innerLayer setFillColor:[_innerHighlightColor colorWithAlphaComponent:1].CGColor animated:YES];
  [_innerLayer setRadius:_innerRadius animated:YES];
  [_outerLayer setFillColor:_outerHighlightColor.CGColor animated:YES];
  [_outerLayer setPosition:_highlightCenter animated:YES];
  [_outerLayer setRadius:_outerRadius animated:YES];
  [CATransaction commit];

  _forceConcentricLayout = NO;
}

- (void)animatePulse {
  NSArray *keyTimes = @[ @0, @0.5, @1 ];
  id pulseColorStart =
      (__bridge id)
          [_innerHighlightColor colorWithAlphaComponent:kMDCFeatureHighlightPulseStartAlpha]
              .CGColor;
  id pulseColorEnd = (__bridge id)[_innerHighlightColor colorWithAlphaComponent:0].CGColor;
  CGFloat radius = _innerRadius;

  [CATransaction begin];
  [CATransaction setAnimationDuration:1.0f];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction
                                                functionWithName:kCAMediaTimingFunctionEaseOut]];
  CGFloat innerBloomRadius = radius + kMDCFeatureHighlightInnerRadiusBloomAmount;
  CGFloat pulseBloomRadius = radius + kMDCFeatureHighlightPulseRadiusBloomAmount;
  NSArray *innerKeyframes = @[ @(radius), @(innerBloomRadius), @(radius) ];
  [_innerLayer animateRadiusOverKeyframes:innerKeyframes keyTimes:keyTimes];
  NSArray *pulseKeyframes = @[ @(radius), @(radius), @(pulseBloomRadius) ];
  [_pulseLayer animateRadiusOverKeyframes:pulseKeyframes keyTimes:keyTimes];
  [_pulseLayer animateFillColorOverKeyframes:@[ pulseColorStart, pulseColorStart, pulseColorEnd ]
                                    keyTimes:keyTimes];
  [CATransaction commit];
}

- (void)animateAccepted:(NSTimeInterval)duration {
  CGPoint displayMaskCenter =
      CGPointMake(_displayedView.frame.size.width / 2, _displayedView.frame.size.height / 2);

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction
                                                functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:duration];
  [_displayMaskLayer setPosition:displayMaskCenter animated:YES];
  [_displayMaskLayer setRadius:0.0 animated:YES];
  [_innerLayer setPosition:_highlightPoint animated:YES];
  [_innerLayer setRadius:0.0 animated:YES];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor animated:YES];
  [_outerLayer setPosition:_highlightCenter animated:YES];
  [_outerLayer setRadius:kMDCFeatureHighlightOuterRadiusFactor * _outerRadius animated:YES];
  [CATransaction commit];

  _forceConcentricLayout = YES;
}

- (void)animateRejected:(NSTimeInterval)duration {
  CGPoint displayMaskCenter =
      CGPointMake(_displayedView.frame.size.width / 2, _displayedView.frame.size.height / 2);

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction
                                                functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:duration];
  [_displayMaskLayer setPosition:displayMaskCenter animated:YES];
  [_displayMaskLayer setRadius:0 animated:YES];
  [_innerLayer setPosition:_highlightPoint animated:YES];
  [_innerLayer setRadius:0 animated:YES];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor animated:YES];
  [_outerLayer setPosition:_highlightPoint animated:YES];
  [_outerLayer setRadius:0 animated:YES];
  [CATransaction commit];

  _forceConcentricLayout = NO;
}

- (void)updateOuterHighlight {
  CGFloat scaledRadius = _outerRadius * _outerRadiusScale;
  if (self.layer.animationKeys) {
    CAAnimation *animation = [self.layer animationForKey:self.layer.animationKeys.firstObject];
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:animation.timingFunction];
    [CATransaction setAnimationDuration:animation.duration];
    [_outerLayer setRadius:scaledRadius animated:YES];
    [CATransaction commit];
  } else {
    [_outerLayer setRadius:scaledRadius animated:NO];
  }
}

+ (NSString *)dismissAccessibilityHint {
  NSString *key =
      kMaterialFeatureHighlightStringTable[kStr_MaterialFeatureHighlightDismissAccessibilityHint];
  NSString *localizedString = NSLocalizedStringFromTableInBundle(
      key, kMaterialFeatureHighlightStringsTableName, [self bundle], @"Double-tap to dismiss.");
  return localizedString;
}

#pragma mark - Dynamic Type Support

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (_mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }

  [self updateTitleFont];
  [self updateBodyFont];
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateTitleFont];
  [self updateBodyFont];
}

#pragma mark - UIGestureRecognizerDelegate (Tap)

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:
        (__unused UIGestureRecognizer *)otherGestureRecognizer
{
  return YES;
}

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kMaterialFeatureHighlightBundle]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCFeatureHighlightView class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

@end
