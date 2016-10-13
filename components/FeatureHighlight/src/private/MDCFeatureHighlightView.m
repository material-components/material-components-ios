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

#import "MaterialTypography.h"

#import "MDCFeatureHighlightLayer.h"
#import "MDFTextAccessibility.h"

const CGFloat kMDCFeatureHighlightInnerRadius = 44.0;
const CGFloat kMDCFeatureHighlightInnerPadding = 20.0;
const CGFloat kMDCFeatureHighlightTextPadding = 40.0;
const CGFloat kMDCFeatureHighlightTextMaxWidth = 300.0;
const CGFloat kMDCFeatureHighlightConcentricBound = 88.0;
const CGFloat kMDCFeatureHighlightOuterAlpha = 0.96;

@implementation MDCFeatureHighlightView {
  BOOL _highlighting;
  UIView *_highlightView;
  CGPoint _highlightPoint;
  CGPoint _highlightCenter;
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
    _titleLabel.font = [[MDCTypography fontLoader] regularFontOfSize:20.0];
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
  }
  return self;
}

- (void)layoutAppearing {
  _titleLabel.alpha = 1;
  _bodyLabel.alpha = 1;
}

- (void)layoutDisappearing {
  _titleLabel.alpha = 0;
  _bodyLabel.alpha = 0;
}

- (void)setOuterHighlightColor:(UIColor *)outerHighlightColor {
  _outerHighlightColor =
      [outerHighlightColor colorWithAlphaComponent:kMDCFeatureHighlightOuterAlpha];

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
  _innerHighlightColor = [UIColor whiteColor];

  _pulseLayer.fillColor = _innerHighlightColor.CGColor;
  _innerLayer.fillColor = _innerHighlightColor.CGColor;
}

- (void)setDisplayedView:(UIView *)displayedView {
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

- (void)animateDiscover:(CGFloat)duration {
  [_innerLayer setFillColor:[_innerHighlightColor colorWithAlphaComponent:0].CGColor];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor];

  CGPoint displayMaskCenter = CGPointMake(_displayedView.frame.size.width/2,
                                          _displayedView.frame.size.height/2);

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:duration];
  [_displayMaskLayer setCenter:displayMaskCenter radius:kMDCFeatureHighlightInnerRadius
                      animated:YES];
  [_innerLayer setFillColor:[_innerHighlightColor colorWithAlphaComponent:1].CGColor animated:YES];
  [_innerLayer setCenter:_highlightPoint radius:kMDCFeatureHighlightInnerRadius animated:YES];
  [_outerLayer setFillColor:_outerHighlightColor.CGColor animated:YES];
  [_outerLayer setCenter:_highlightCenter radius:_outerRadius animated:YES];
  [CATransaction commit];

  _highlighting = YES;
}

- (void)animatePulse {
  NSArray *keyTimes = @[@0, @0.5, @1];
  id pulseColorStart = (__bridge id)[_innerHighlightColor colorWithAlphaComponent:0.54].CGColor;
  id pulseColorEnd = (__bridge id)[_innerHighlightColor colorWithAlphaComponent:0].CGColor;
  CGFloat radius = kMDCFeatureHighlightInnerRadius;

  [CATransaction begin];
  [CATransaction setAnimationDuration:1.0f];
  [CATransaction setAnimationTimingFunction:
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  [_innerLayer animateRadiusOverKeyframes:@[@(radius), @(radius * 1.1), @(radius)]
                                 keyTimes:keyTimes
                                   center:_highlightPoint];
  [_pulseLayer animateRadiusOverKeyframes:@[@(radius), @(radius), @(radius * 2.0)]
                                 keyTimes:keyTimes
                                   center:_highlightPoint];
  [_pulseLayer animateFillColorOverKeyframes:@[pulseColorStart, pulseColorStart, pulseColorEnd]
                                    keyTimes:keyTimes];
  [CATransaction commit];
}

- (void)animateAccepted:(CGFloat)duration {
  CGPoint displayMaskCenter = CGPointMake(_displayedView.frame.size.width/2,
                                          _displayedView.frame.size.height/2);

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:duration];
  [_displayMaskLayer setCenter:displayMaskCenter radius:0.0 animated:YES];
  [_innerLayer setFillColor:[_innerHighlightColor colorWithAlphaComponent:0].CGColor animated:YES];
  [_innerLayer setCenter:_highlightPoint radius:0.0 animated:YES];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor animated:YES];
  [_outerLayer setCenter:_highlightCenter radius:1.125 * _outerRadius animated:YES];
  [CATransaction commit];

  _highlighting = NO;
}

- (void)animateRejected:(CGFloat)duration {
  CGPoint displayMaskCenter = CGPointMake(_displayedView.frame.size.width/2,
                                          _displayedView.frame.size.height/2);

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:duration];
  [_displayMaskLayer setCenter:displayMaskCenter radius:0.0 animated:YES];
  [_innerLayer setFillColor:[_innerHighlightColor colorWithAlphaComponent:0].CGColor animated:YES];
  [_innerLayer setCenter:_highlightPoint radius:0.0 animated:YES];
  [_outerLayer setFillColor:[_outerHighlightColor colorWithAlphaComponent:0].CGColor animated:YES];
  [_outerLayer setCenter:_highlightPoint radius:0.0 animated:YES];
  [CATransaction commit];

  _highlighting = NO;
}

- (void)layoutSubviews {
  [_innerLayer removeAllAnimations];
  [_outerLayer removeAllAnimations];
  [_pulseLayer removeAllAnimations];

  BOOL leftHalf = _highlightPoint.x < self.frame.size.width/2;
  BOOL topHalf = _highlightPoint.y < self.frame.size.height/2;

  CGFloat textWidth = MIN(self.frame.size.width - 2 * kMDCFeatureHighlightTextPadding,
                          kMDCFeatureHighlightTextMaxWidth);
  CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(textWidth, 1000.0)];
  CGSize detailSize = [_bodyLabel sizeThatFits:CGSizeMake(textWidth, 1000.0)];
  CGFloat textHeight = titleSize.height + detailSize.height;

  BOOL centered = YES;
  if (_highlightPoint.y <= kMDCFeatureHighlightConcentricBound) {
    _highlightCenter = _highlightPoint;
  } else if (_highlightPoint.y >= self.frame.size.height - kMDCFeatureHighlightConcentricBound) {
    _highlightCenter = _highlightPoint;
  } else {
    centered = NO;
    if (topHalf) {
      _highlightCenter.y = _highlightPoint.y + kMDCFeatureHighlightInnerRadius + textHeight/2;
    } else {
      _highlightCenter.y = _highlightPoint.y - kMDCFeatureHighlightInnerRadius - textHeight/2;
    }
    if (leftHalf) {
      _highlightCenter.x = _highlightPoint.x + 20;
    } else {
      _highlightCenter.x = _highlightPoint.x - 20;
    }
  }

  _displayedView.center = _highlightPoint;
  _innerLayer.center = _highlightPoint;
  _pulseLayer.center = _highlightPoint;

  if (_highlighting) {
    _outerLayer.center = _highlightCenter;
  } else {
    _outerLayer.center = _highlightPoint;
  }

  CGFloat leftTextBound = kMDCFeatureHighlightTextPadding;
  CGFloat rightTextBound = self.frame.size.width - MAX(titleSize.width, detailSize.width) -
      kMDCFeatureHighlightTextPadding;
  CGPoint titlePos = CGPointMake(0, 0);
  titlePos.x = MIN(MAX(_highlightCenter.x - textWidth/2, leftTextBound), rightTextBound);
  if (topHalf) {
    titlePos.y = _highlightPoint.y + kMDCFeatureHighlightInnerPadding +
        kMDCFeatureHighlightInnerRadius;
  } else {
    titlePos.y = _highlightPoint.y - kMDCFeatureHighlightInnerPadding -
        kMDCFeatureHighlightInnerRadius - textHeight;
  }

  CGRect titleFrame = (CGRect) {
    titlePos,
    titleSize
  };
  _titleLabel.frame = titleFrame;

  CGRect detailFrame = (CGRect) {
    CGPointMake(titlePos.x, CGRectGetMaxY(titleFrame)),
    detailSize
  };
  _bodyLabel.frame = detailFrame;

  // Calculating the distance between center of the highlight and the corner of the titleLabel
  // furthest from the center.
  CGRect textFrames = CGRectUnion(_titleLabel.frame, _bodyLabel.frame);
  CGFloat distX = MAX(ABS(CGRectGetMaxX(textFrames) - _highlightCenter.x),
                      ABS(CGRectGetMinX(textFrames) - _highlightCenter.x));
  CGFloat distY = MAX(ABS(CGRectGetMaxY(textFrames) - _highlightCenter.y),
                      ABS(CGRectGetMinY(textFrames) - _highlightCenter.y));
  _outerRadius = sqrt(distX * distX + distY * distY) + kMDCFeatureHighlightTextPadding;
}

- (void)didTapView:(UITapGestureRecognizer *)tapGestureRecognizer {
  CGPoint pos = [tapGestureRecognizer locationInView:self];
  CGFloat dist = sqrt(pow(pos.x - _highlightPoint.x, 2) + pow(pos.y - _highlightPoint.y, 2));
  BOOL accepted = dist <= kMDCFeatureHighlightInnerRadius;

  if (self.interactionBlock) {
    self.interactionBlock(accepted);
  }
}

@end
