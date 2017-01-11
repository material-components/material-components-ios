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

#import "MDCFeatureHighlightView.h"

#import "MDCFeatureHighlightLayer.h"
#import "MDFTextAccessibility.h"
#import "MaterialTypography.h"

const CGFloat kMDCFeatureHighlightMinimumInnerRadius = 44.0f;
const CGFloat kMDCFeatureHighlightInnerContentPadding = 10.0f;
const CGFloat kMDCFeatureHighlightInnerPadding = 20.0f;
const CGFloat kMDCFeatureHighlightTextPadding = 40.0f;
const CGFloat kMDCFeatureHighlightTextMaxWidth = 300.0f;
const CGFloat kMDCFeatureHighlightConcentricBound = 88.0f;
const CGFloat kMDCFeatureHighlightNonconcentricOffset = 20.0f;
const CGFloat kMDCFeatureHighlightMaxTextHeight = 1000.0f;
const CGFloat kMDCFeatureHighlightTitleFontSize = 20.0f;

// Animation consts
const CGFloat kMDCFeatureHighlightInnerRadiusFactor = 1.1f;
const CGFloat kMDCFeatureHighlightOuterRadiusFactor = 1.125f;
const CGFloat kMDCFeatureHighlightPulseRadiusFactor = 2.0f;
const CGFloat kMDCFeatureHighlightPulseStartAlpha = 0.54f;
const CGFloat kMDCFeatureHighlightInnerRadiusBloomAmount =
    (kMDCFeatureHighlightInnerRadiusFactor - 1) * kMDCFeatureHighlightMinimumInnerRadius;
const CGFloat kMDCFeatureHighlightPulseRadiusBloomAmount =
    (kMDCFeatureHighlightPulseRadiusFactor - 1) * kMDCFeatureHighlightMinimumInnerRadius;

@implementation MDCFeatureHighlightView {
  BOOL _forceConcentricLayout;
  UIView *_highlightView;
  CGPoint _highlightPoint;
  CGPoint _highlightCenter;
  CGFloat _innerRadius;
  CGPoint _outerCenter;
  CGFloat _outerRadius;
  MDCFeatureHighlightLayer *_outerLayer;
  MDCFeatureHighlightLayer *_pulseLayer;
  MDCFeatureHighlightLayer *_innerLayer;
  MDCFeatureHighlightLayer *_displayMaskLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor clearColor];

    _outerLayer = [[MDCFeatureHighlightLayer alloc] init];
    [self.layer addSublayer:_outerLayer];

    _pulseLayer = [[MDCFeatureHighlightLayer alloc] init];
    [self.layer addSublayer:_pulseLayer];

    _innerLayer = [[MDCFeatureHighlightLayer alloc] init];
    [self.layer addSublayer:_innerLayer];

    _displayMaskLayer = [[MDCFeatureHighlightLayer alloc] init];
    _displayMaskLayer.fillColor = [UIColor whiteColor].CGColor;

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font =
        [[MDCTypography fontLoader] regularFontOfSize:kMDCFeatureHighlightTitleFontSize];
    _titleLabel.textAlignment = NSTextAlignmentNatural;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];

    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _bodyLabel.font = [MDCTypography subheadFont];
    _bodyLabel.shadowColor = nil;
    _bodyLabel.shadowOffset = CGSizeZero;
    _bodyLabel.textAlignment = NSTextAlignmentNatural;
    _bodyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _bodyLabel.numberOfLines = 0;
    [self addSubview:_bodyLabel];

    UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [self addGestureRecognizer:tapRecognizer];

    self.outerHighlightColor = [UIColor blueColor];
    self.innerHighlightColor = [UIColor whiteColor];

    // We want the inner and outer highlights to animate from the same origin so we start them from
    // a concentric position.
    _forceConcentricLayout = YES;
  }
  return self;
}

- (void)layoutAppearing {
  // TODO: Mask the labels during the presentation and dismissal animations.
  _titleLabel.alpha = 1;
  _bodyLabel.alpha = 1;
}

- (void)layoutDisappearing {
  _titleLabel.alpha = 0;
  _bodyLabel.alpha = 0;
}

- (void)setOuterHighlightColor:(UIColor *)outerHighlightColor {
  _outerHighlightColor = outerHighlightColor;
  _outerLayer.fillColor = _outerHighlightColor.CGColor;

  MDFTextAccessibilityOptions options = MDFTextAccessibilityOptionsPreferLighter;
  if ([MDFTextAccessibility isLargeForContrastRatios:_bodyLabel.font]) {
    options |= MDFTextAccessibilityOptionsLargeFont;
  }

  UIColor *outerColor = [_outerHighlightColor colorWithAlphaComponent:1.0];
  _bodyLabel.textColor =
      [MDFTextAccessibility textColorOnBackgroundColor:outerColor
                                       targetTextAlpha:[MDCTypography captionFontOpacity]
                                               options:options];

  options = MDFTextAccessibilityOptionsPreferLighter;
  if ([MDFTextAccessibility isLargeForContrastRatios:_titleLabel.font]) {
    options |= MDFTextAccessibilityOptionsLargeFont;
  }
  // Since MDFTextAccessibility can return either a dark value or light value color we want to
  // guarantee that the title and body have the same value.
  CGFloat titleAlpha = [MDFTextAccessibility minAlphaOfTextColor:_bodyLabel.textColor
                                               onBackgroundColor:outerColor
                                                         options:options];
  titleAlpha = MAX([MDCTypography titleFontOpacity], titleAlpha);
  _titleLabel.textColor = [_bodyLabel.textColor colorWithAlphaComponent:titleAlpha];
}

- (void)setInnerHighlightColor:(UIColor *)innerHighlightColor {
  _innerHighlightColor = innerHighlightColor;

  _pulseLayer.fillColor = _innerHighlightColor.CGColor;
  _innerLayer.fillColor = _innerHighlightColor.CGColor;
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
  [self layoutIfNeeded];
}

- (void)animateDiscover:(NSTimeInterval)duration {
  [_innerLayer setFillColor:[_innerHighlightColor colorWithAlphaComponent:0].CGColor];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor];

  CGPoint displayMaskCenter =
      CGPointMake(_displayedView.frame.size.width / 2, _displayedView.frame.size.height / 2);

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction
                                                functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:duration];
  [_displayMaskLayer setCenter:displayMaskCenter radius:_innerRadius animated:YES];
  [_innerLayer setFillColor:[_innerHighlightColor colorWithAlphaComponent:1].CGColor animated:YES];
  [_innerLayer setCenter:_highlightPoint radius:_innerRadius animated:YES];
  [_outerLayer setFillColor:_outerHighlightColor.CGColor animated:YES];
  [_outerLayer setCenter:_highlightCenter radius:_outerRadius animated:YES];
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
  [_innerLayer animateRadiusOverKeyframes:innerKeyframes keyTimes:keyTimes center:_highlightPoint];
  NSArray *pulseKeyframes = @[ @(radius), @(radius), @(pulseBloomRadius) ];
  [_pulseLayer animateRadiusOverKeyframes:pulseKeyframes keyTimes:keyTimes center:_highlightPoint];
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
  [_displayMaskLayer setCenter:displayMaskCenter radius:0.0 animated:YES];
  [_innerLayer setCenter:_highlightPoint radius:0 animated:YES];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor animated:YES];
  [_outerLayer setCenter:_highlightCenter
                  radius:kMDCFeatureHighlightOuterRadiusFactor * _outerRadius
                animated:YES];
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
  [_displayMaskLayer setCenter:displayMaskCenter radius:0 animated:YES];
  [_innerLayer setCenter:_highlightPoint radius:0 animated:YES];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor animated:YES];
  [_outerLayer setCenter:_highlightPoint radius:0 animated:YES];
  [CATransaction commit];

  _forceConcentricLayout = NO;
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
  titleSize.width = MAX(titleSize.width, detailSize.width);
  detailSize.width = titleSize.width;

  CGFloat textHeight = titleSize.height + detailSize.height;

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

  _displayedView.center = _highlightPoint;
  _innerLayer.center = _highlightPoint;
  _pulseLayer.center = _highlightPoint;

  if (_forceConcentricLayout) {
    _outerLayer.center = _highlightPoint;
  } else {
    _outerLayer.center = _highlightCenter;
  }

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

  CGRect titleFrame = (CGRect){titlePos, titleSize};
  _titleLabel.frame = titleFrame;

  CGRect detailFrame = (CGRect){CGPointMake(titlePos.x, CGRectGetMaxY(titleFrame)), detailSize};
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
  CGFloat dist =
      (float)(sqrt(pow(pos.x - _highlightPoint.x, 2) + pow(pos.y - _highlightPoint.y, 2)));
  BOOL accepted = dist <= _innerRadius;

  if (self.interactionBlock) {
    self.interactionBlock(accepted);
  }
}

@end
