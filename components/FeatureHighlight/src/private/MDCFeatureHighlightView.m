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

const CGFloat kMDCFeatureHighlightInnerRadius = 44.0;
const CGFloat kMDCFeatureHighlightInnerPadding = 20.0;
const CGFloat kMDCFeatureHighlightTextPadding = 40.0;

@implementation MDCFeatureHighlightView {
  UIView *_highlightView;
  CGPoint _highlightPoint;
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
    _outerLayer.fillColor = [self.tintColor colorWithAlphaComponent:0.96].CGColor;
    [self.layer addSublayer:_outerLayer];

    _pulseLayer = [[MDCFeatureHighlightLayer alloc] init];
    _pulseLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_pulseLayer];

    _innerLayer = [[MDCFeatureHighlightLayer alloc] init];
    _innerLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_innerLayer];

    _displayMaskLayer = [[MDCFeatureHighlightLayer alloc] init];
    _displayMaskLayer.fillColor = [UIColor whiteColor].CGColor;

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [[MDCTypography fontLoader] regularFontOfSize:20.0];
    _titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:[MDCTypography titleFontOpacity]];
    _titleLabel.textAlignment = NSTextAlignmentNatural;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];

    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _bodyLabel.font = [MDCTypography subheadFont];
    _bodyLabel.textColor = [UIColor colorWithWhite:1.0 alpha:[MDCTypography captionFontOpacity]];
    _bodyLabel.shadowColor = nil;
    _bodyLabel.shadowOffset = CGSizeZero;
    _bodyLabel.textAlignment = NSTextAlignmentNatural;
    _bodyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _bodyLabel.numberOfLines = 0;
    [self addSubview:_bodyLabel];
  }
  return self;
}

- (void)setDisplayedView:(UIView *)displayedView {
  _displayedView.layer.mask = nil;
  [_displayedView removeFromSuperview];
  _displayedView = displayedView;
  [self addSubview:_displayedView];
  _displayedView.layer.mask = _displayMaskLayer;
}

- (void)animateDiscover:(CGPoint)center {
  _highlightPoint = center;
  [self setNeedsLayout];
  [self layoutIfNeeded];

  [_displayMaskLayer setFillColor:[UIColor colorWithWhite:1.0 alpha:0.0].CGColor];
  [_innerLayer setFillColor:[UIColor colorWithWhite:1.0 alpha:0.0].CGColor];
  [_outerLayer setFillColor:[self.tintColor colorWithAlphaComponent:0.0].CGColor];


  CGPoint displayMaskCenter = CGPointMake(_displayedView.frame.size.width/2,
                                          _displayedView.frame.size.height/2);

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:0.35];
  [_displayMaskLayer setFillColor:[UIColor colorWithWhite:1.0 alpha:1.0].CGColor animated:YES];
  [_displayMaskLayer setCenter:displayMaskCenter radius:kMDCFeatureHighlightInnerRadius animated:YES];
  [_innerLayer setFillColor:[UIColor colorWithWhite:1.0 alpha:1.0].CGColor animated:YES];
  [_innerLayer setCenter:_highlightPoint radius:kMDCFeatureHighlightInnerRadius animated:YES];
  [_outerLayer setFillColor:[self.tintColor colorWithAlphaComponent:0.96].CGColor animated:YES];
  [_outerLayer setCenter:_highlightPoint radius:_outerRadius animated:YES];
  [CATransaction commit];
}

- (void)animatePulse {
  NSArray *keyTimes = @[@0, @0.5, @1];
  id pulseColorStart = (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.54].CGColor;
  id pulseColorEnd = (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor;
  CGFloat radius = kMDCFeatureHighlightInnerRadius;

  [CATransaction begin];
  [CATransaction setAnimationDuration:1.0f];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  [_innerLayer animateRadiusOverKeyframes:@[@(radius), @(radius * 1.1), @(radius)] keyTimes:keyTimes center:_highlightPoint];
  [_pulseLayer animateRadiusOverKeyframes:@[@(radius), @(radius), @(radius * 2.0)] keyTimes:keyTimes center:_highlightPoint];
  [_pulseLayer animateFillColorOverKeyframes:@[pulseColorStart, pulseColorStart, pulseColorEnd]
                                    keyTimes:keyTimes];
  [CATransaction commit];
}

- (void)animateDismiss {
  CGPoint displayMaskCenter = CGPointMake(_displayedView.frame.size.width/2,
                                          _displayedView.frame.size.height/2);

  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  [CATransaction setAnimationDuration:0.2];
  [_displayMaskLayer setFillColor:[UIColor colorWithWhite:1.0 alpha:0.0].CGColor animated:YES];
  [_displayMaskLayer setCenter:displayMaskCenter radius:0.0 animated:YES];
  [_innerLayer setFillColor:[UIColor colorWithWhite:1.0 alpha:0.0].CGColor animated:YES];
  [_innerLayer setCenter:_highlightPoint radius:0.0 animated:YES];
  [_outerLayer setFillColor:[self.tintColor colorWithAlphaComponent:0.0].CGColor animated:YES];
  [_outerLayer setCenter:_highlightPoint radius:1.125 * _outerRadius animated:YES];
  [CATransaction commit];
}

- (void)layoutSubviews {
  CGFloat textWidth = self.frame.size.width - 2 * kMDCFeatureHighlightTextPadding;
  CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(textWidth, 1000.0)];
  CGRect titleFrame = (CGRect) {
    CGPointMake(kMDCFeatureHighlightTextPadding, _highlightPoint.y + kMDCFeatureHighlightInnerPadding + kMDCFeatureHighlightInnerRadius),
    titleSize
  };
  _titleLabel.frame = titleFrame;

  CGSize detailSize = [_bodyLabel sizeThatFits:CGSizeMake(textWidth, 1000.0)];
  CGRect detailFrame = (CGRect) {
    CGPointMake(kMDCFeatureHighlightTextPadding, CGRectGetMaxY(titleFrame)),
    detailSize
  };
  _bodyLabel.frame = detailFrame;

  // calculating the distance between center and the corner of the titleLabel furthest from the center
  CGRect textFrames = CGRectUnion(_titleLabel.frame, _bodyLabel.frame);
  CGFloat distX = MAX(ABS(CGRectGetMaxX(textFrames) - _highlightPoint.x), ABS(CGRectGetMinX(textFrames) - _highlightPoint.x));
  CGFloat distY = MAX(ABS(CGRectGetMaxY(textFrames) - _highlightPoint.y), ABS(CGRectGetMinY(textFrames) - _highlightPoint.y));
  _outerRadius = sqrt(distX * distX + distY * distY) + kMDCFeatureHighlightTextPadding;
}

@end
