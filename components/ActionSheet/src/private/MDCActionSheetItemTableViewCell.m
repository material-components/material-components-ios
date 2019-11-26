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
/** Default value for @c imageEdgeInsets. */
static const UIEdgeInsets kDefaultImageEdgeInsets = {-16, 0, 0, -32};
static const UIEdgeInsets kDefaultTitleEdgeInsets = {-18, 0, -18, 0};
static const CGFloat kImageHeightAndWidth = 24;

static inline UIColor *RippleColor() {
  return [[UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.14];
}

@interface MDCActionSheetItemTableViewCell ()
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UIImageView *actionImageView;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
/** Container view holding all custom content so it can be inset. */
@property(nonatomic, strong) UIView *contentContainerView;
/** Container view holding the image view so it can be inset. */
@property(nonatomic, strong) UIView *imageContainerView;
@end

@implementation MDCActionSheetItemTableViewCell {
  MDCActionSheetAction *_itemAction;
  NSLayoutConstraint *_contentContainerTopConstraint;
  NSLayoutConstraint *_contentContainerLeadingConstraint;
  NSLayoutConstraint *_contentContainerBottomConstraint;
  NSLayoutConstraint *_contentContainerTrailingConstraint;
  NSLayoutConstraint *_imageContainerTopConstriant;
  NSLayoutConstraint *_imageContainerLeadingConstriant;
  NSLayoutConstraint *_imageContainerBottomConstriant;
  NSLayoutConstraint *_imageContainerTrailingConstriant;
  NSLayoutConstraint *_actionLabelTopConstraint;
  NSLayoutConstraint *_actionLabelLeadingEdgeToImageConstraint;
  NSLayoutConstraint *_actionLabelLeadingEdgeToContainerViewConstraint;
  NSLayoutConstraint *_actionLabelBottomConstraint;
  NSLayoutConstraint *_actionLabelTrailingConstraint;
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

  _imageEdgeInsets = kDefaultImageEdgeInsets;
  _titleEdgeInsets = kDefaultTitleEdgeInsets;
  _contentContainerView = [[UIView alloc] initWithFrame:self.bounds];
  _contentContainerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addSubview:_contentContainerView];
  _contentContainerTopConstraint =
      [self.contentView.topAnchor constraintEqualToAnchor:_contentContainerView.topAnchor];
  _contentContainerTopConstraint.active = YES;
  _contentContainerLeadingConstraint = [self.contentView.layoutMarginsGuide.leadingAnchor
      constraintEqualToAnchor:_contentContainerView.leadingAnchor];
  _contentContainerLeadingConstraint.active = YES;
  _contentContainerBottomConstraint =
      [_contentContainerView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor];
  _contentContainerBottomConstraint.active = YES;
  _contentContainerTrailingConstraint = [_contentContainerView.trailingAnchor
      constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor];
  _contentContainerTrailingConstraint.active = YES;

  // Image
  _imageContainerView = [[UIView alloc] init];
  _imageContainerView.translatesAutoresizingMaskIntoConstraints = NO;
  [_imageContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisHorizontal];
  [_imageContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisVertical];
  [_contentContainerView addSubview:_imageContainerView];
  _imageContainerTopConstriant =
      [_contentContainerView.topAnchor constraintEqualToAnchor:_imageContainerView.topAnchor
                                                      constant:_imageEdgeInsets.top];
  _imageContainerTopConstriant.active = YES;
  _imageContainerLeadingConstriant =
      [_contentContainerView.leadingAnchor constraintEqualToAnchor:_imageContainerView.leadingAnchor
                                                          constant:_imageEdgeInsets.left];
  _imageContainerLeadingConstriant.active = YES;
  _imageContainerBottomConstriant =
      [_imageContainerView.bottomAnchor constraintEqualToAnchor:_contentContainerView.bottomAnchor
                                                       constant:_imageEdgeInsets.bottom];
  _imageContainerBottomConstriant.active = YES;
  _imageContainerTrailingConstriant = [_imageContainerView.trailingAnchor
      constraintEqualToAnchor:_contentContainerView.trailingAnchor
                     constant:_imageEdgeInsets.right];
  _imageContainerTrailingConstriant.active = YES;

  _actionLabel = [[UILabel alloc] init];
  [_contentContainerView addSubview:_actionLabel];
  _actionLabel.numberOfLines = 0;
  _actionLabel.translatesAutoresizingMaskIntoConstraints = NO;
  _actionLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  _actionLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  _actionLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:kLabelAlpha];
  _actionLabelTopConstraint =
      [_contentContainerView.topAnchor constraintEqualToAnchor:_actionLabel.topAnchor
                                                      constant:_titleEdgeInsets.top];
  _actionLabelTopConstraint.active = YES;
  _actionLabelLeadingEdgeToImageConstraint =
      [_imageContainerView.trailingAnchor constraintEqualToAnchor:_actionLabel.leadingAnchor
                                                         constant:_titleEdgeInsets.left];
  _actionLabelLeadingEdgeToContainerViewConstraint =
      [_contentContainerView.leadingAnchor constraintEqualToAnchor:_actionLabel.leadingAnchor
                                                          constant:_titleEdgeInsets.left];
  if (_itemAction.image || _addLeadingPadding) {
    _actionLabelLeadingEdgeToImageConstraint.active = YES;
  } else {
    _actionLabelLeadingEdgeToContainerViewConstraint.active = YES;
  }
  _actionLabelBottomConstraint =
      [_actionLabel.bottomAnchor constraintEqualToAnchor:_contentContainerView.bottomAnchor
                                                constant:_titleEdgeInsets.bottom];
  _actionLabelBottomConstraint.priority = UILayoutPriorityDefaultHigh;
  _actionLabelBottomConstraint.active = YES;
  _actionLabelTrailingConstraint =
      [_actionLabel.trailingAnchor constraintEqualToAnchor:_contentContainerView.trailingAnchor
                                                  constant:_titleEdgeInsets.right];
  _actionLabelTrailingConstraint.active = YES;

  if (!_inkTouchController) {
    _inkTouchController = [[MDCInkTouchController alloc] initWithView:self];
    [_inkTouchController addInkView];
  }

  if (!_rippleTouchController) {
    _rippleTouchController = [[MDCRippleTouchController alloc] init];
  }

  _actionImageView = [[UIImageView alloc] init];
  [_imageContainerView addSubview:_actionImageView];
  _actionImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [_actionImageView.topAnchor constraintEqualToAnchor:_imageContainerView.topAnchor].active = YES;
  [_actionImageView.leadingAnchor constraintEqualToAnchor:_imageContainerView.leadingAnchor]
      .active = YES;
  [_actionImageView.bottomAnchor constraintLessThanOrEqualToAnchor:_imageContainerView.bottomAnchor]
      .active = YES;
  [_actionImageView.trailingAnchor
      constraintLessThanOrEqualToAnchor:_imageContainerView.trailingAnchor]
      .active = YES;
  [_actionImageView.widthAnchor constraintEqualToConstant:kImageHeightAndWidth].active = YES;
  [_actionImageView.heightAnchor constraintEqualToConstant:kImageHeightAndWidth].active = YES;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.actionLabel.accessibilityLabel = _itemAction.accessibilityLabel;
  self.actionLabel.text = _itemAction.title;
  self.actionImageView.image = [_itemAction.image imageWithRenderingMode:self.imageRenderingMode];
}

- (void)setAction:(MDCActionSheetAction *)action {
  _itemAction = [action copy];
  self.actionLabel.accessibilityLabel = _itemAction.accessibilityLabel;
  self.actionLabel.text = _itemAction.title;
  self.actionImageView.image = _itemAction.image;
  [self setNeedsLayout];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
  _contentEdgeInsets = contentEdgeInsets;
  _contentContainerTopConstraint.constant = contentEdgeInsets.top;
  _contentContainerLeadingConstraint.constant = contentEdgeInsets.left;
  _contentContainerBottomConstraint.constant = contentEdgeInsets.bottom;
  _contentContainerTrailingConstraint.constant = contentEdgeInsets.right;
}

- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
  _imageEdgeInsets = imageEdgeInsets;
  _imageContainerTopConstriant.constant = imageEdgeInsets.top;
  _imageContainerLeadingConstriant.constant = imageEdgeInsets.left;
  _imageContainerBottomConstriant.constant = imageEdgeInsets.bottom;
  _imageContainerTrailingConstriant.constant = imageEdgeInsets.right;
}

- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
  _titleEdgeInsets = titleEdgeInsets;
  _actionLabelTopConstraint.constant = titleEdgeInsets.top;
  _actionLabelLeadingEdgeToContainerViewConstraint.constant = titleEdgeInsets.left;
  _actionLabelLeadingEdgeToImageConstraint.constant = titleEdgeInsets.left;
  _actionLabelBottomConstraint.constant = titleEdgeInsets.bottom;
  _actionLabelTrailingConstraint.constant = titleEdgeInsets.right;
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

- (void)setAddLeadingPadding:(BOOL)addLeadingPadding {
  _addLeadingPadding = addLeadingPadding;
  if (addLeadingPadding) {
    _actionLabelLeadingEdgeToContainerViewConstraint.active = NO;
    _actionLabelLeadingEdgeToImageConstraint.active = YES;
  } else {
    _actionLabelLeadingEdgeToImageConstraint.active = NO;
    _actionLabelLeadingEdgeToContainerViewConstraint.active = YES;
  }
}

@end
