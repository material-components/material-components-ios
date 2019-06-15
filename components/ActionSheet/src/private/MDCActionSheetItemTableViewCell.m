// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCActionSheetItemTableViewCell.h"

#import <MaterialComponents/MaterialRipple.h>
#import <MaterialComponents/MaterialTypography.h>

static const CGFloat kLabelAlpha = (CGFloat)0.87;
static const CGFloat kImageLeadingPadding = 8;
static const CGFloat kImageTopPadding = 16;
static const CGFloat kImageHeightAndWidth = 24;
static const CGFloat kTitleLeadingPadding = 64;
static const CGFloat kTitleTrailingPadding = 8;
static const CGFloat kActionItemTitleVerticalPadding = 18;

static inline UIColor *RippleColor() {
  return [[UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.14];
}

@interface MDCActionSheetItemTableViewCell ()
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UIImageView *actionImageView;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
@end

@implementation MDCActionSheetItemTableViewCell {
  MDCActionSheetAction *_itemAction;
  NSLayoutConstraint *_titleLeadingConstraint;
  NSLayoutConstraint *_titleTrailingConstraint;
}

@synthesize mdc_adjustsFontForContentSizeCategory = _mdc_adjustsFontForContentSizeCategory;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self commonMDCActionSheetItemViewInit];
  }
  return self;
}

- (void)commonMDCActionSheetItemViewInit {
  self.translatesAutoresizingMaskIntoConstraints = NO;
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.accessibilityTraits = UIAccessibilityTraitButton;
  _actionLabel = [[UILabel alloc] init];
  [self.contentView addSubview:_actionLabel];
  _actionLabel.numberOfLines = 0;
  _actionLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [_actionLabel sizeToFit];
  _actionLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  _actionLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  _actionLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:kLabelAlpha];
  CGFloat leadingConstant;
  if (_itemAction.image || _addLeadingPadding) {
    leadingConstant = kTitleLeadingPadding;
  } else {
    leadingConstant = kImageLeadingPadding;
  }
  [NSLayoutConstraint constraintWithItem:_actionLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:kActionItemTitleVerticalPadding]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:_actionLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:-kActionItemTitleVerticalPadding]
      .active = YES;
  _titleLeadingConstraint = [NSLayoutConstraint constraintWithItem:_actionLabel
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1
                                                          constant:leadingConstant];
  _titleLeadingConstraint.active = YES;
  _titleTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_actionLabel
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1
                                                           constant:kTitleTrailingPadding];
  _titleTrailingConstraint.active = YES;
  if (!_inkTouchController) {
    _inkTouchController = [[MDCInkTouchController alloc] initWithView:self];
    [_inkTouchController addInkView];
  }

  if (!_rippleTouchController) {
    _rippleTouchController = [[MDCRippleTouchController alloc] init];
  }

  _actionImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:_actionImageView];
  _actionImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint constraintWithItem:_actionImageView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:kImageTopPadding]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:_actionImageView
                               attribute:NSLayoutAttributeLeadingMargin
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeadingMargin
                              multiplier:1
                                constant:kImageLeadingPadding]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:_actionImageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:kImageHeightAndWidth]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:_actionImageView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:kImageHeightAndWidth]
      .active = YES;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.actionLabel.accessibilityLabel = _itemAction.accessibilityLabel;
  self.actionLabel.text = _itemAction.title;
  CGFloat leadingConstant;
  if (_itemAction.image || self.addLeadingPadding) {
    leadingConstant = kTitleLeadingPadding;
  } else {
    leadingConstant = kImageLeadingPadding;
  }
  _titleLeadingConstraint.constant = leadingConstant;
  _titleTrailingConstraint.constant = kTitleTrailingPadding;

  self.actionImageView.image = [_itemAction.image imageWithRenderingMode:self.imageRenderingMode];
}

- (void)setAction:(MDCActionSheetAction *)action {
  _itemAction = [action copy];
  self.actionLabel.accessibilityLabel = _itemAction.accessibilityLabel;
  self.actionLabel.text = _itemAction.title;
  self.actionImageView.image = _itemAction.image;
  [self setNeedsLayout];
}

- (MDCActionSheetAction *)action {
  return _itemAction;
}

- (void)setActionFont:(UIFont *)actionFont {
  _actionFont = actionFont;
  [self updateTitleFont];
}

- (void)updateTitleFont {
  UIFont *titleFont =
      _actionFont ?: [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    self.actionLabel.font =
        [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  } else {
    self.actionLabel.font = titleFont;
  }
  [self setNeedsLayout];
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  [self updateTitleFont];
}

- (void)setActionTextColor:(UIColor *)actionTextColor {
  _actionTextColor = actionTextColor;
  _actionLabel.textColor =
      actionTextColor ?: [UIColor.blackColor colorWithAlphaComponent:kLabelAlpha];
}

- (void)setInkColor:(UIColor *)inkColor {
  _inkColor = inkColor;
  // If no ink color then reset to the default ink color
  self.inkTouchController.defaultInkView.inkColor = inkColor ?: RippleColor();
}

- (void)setRippleColor:(UIColor *)rippleColor {
  if (rippleColor != nil && (_rippleColor == rippleColor || [_rippleColor isEqual:rippleColor])) {
    return;
  }
  _rippleColor = rippleColor;

  // If no ripple color then reset to the default ripple color.
  self.rippleTouchController.rippleView.rippleColor = rippleColor ?: RippleColor();
}

- (void)setEnableRippleBehavior:(BOOL)enableRippleBehavior {
  if (_enableRippleBehavior == enableRippleBehavior) {
    return;
  }
  _enableRippleBehavior = enableRippleBehavior;

  if (enableRippleBehavior) {
    [self.inkTouchController.defaultInkView removeFromSuperview];
    [self.rippleTouchController addRippleToView:self];
  } else {
    [self.rippleTouchController.rippleView removeFromSuperview];
    [self.inkTouchController addInkView];
  }
}

- (void)setImageRenderingMode:(UIImageRenderingMode)imageRenderingMode {
  _imageRenderingMode = imageRenderingMode;
  [self setNeedsLayout];
}

@end
