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
static const CGFloat kImageTopPadding = 16;
static const CGFloat kImageHeightAndWidth = 24;
static const CGFloat kTitleLeadingPadding = 56;  // 16 (layoutMargins) + 24 (image) + 16
static const CGFloat kActionItemTitleVerticalPadding = 18;
/** The height of the divider. */
static const CGFloat kDividerHeight = 1;
/** Default value for @c imageEdgeInsets. */
static const UIEdgeInsets kDefaultImageEdgeInsets = {-16, 0, 0, -32};
static const UIEdgeInsets kDefaultTitleEdgeInsets = {-18, 0, -18, 0};
static const CGFloat kImageHeightAndWidth = 24;

static inline UIColor *RippleColor() {
  return [[UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.14];
}

@interface MDCActionSheetItemTableViewCell ()
@property(nonatomic, strong) UIImageView *actionImageView;
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
/** Container view holding all custom content so it can be inset. */
@property(nonatomic, strong) UIView *contentContainerView;
/** A divider that is show at the top of the action. */
@property(nonatomic, strong, nonnull) UIView *divider;
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

  _divider = [[UIView alloc] init];
  _divider.translatesAutoresizingMaskIntoConstraints = NO;
  _divider.backgroundColor = UIColor.clearColor;
  [self.contentContainerView addSubview:_divider];
  [_contentContainerView.topAnchor constraintEqualToAnchor:_divider.topAnchor].active = YES;
  [NSLayoutConstraint constraintWithItem:_divider
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:kDividerHeight]
      .active = YES;
  [_contentContainerView.leadingAnchor constraintEqualToAnchor:_divider.leadingAnchor].active = YES;
  [_contentContainerView.trailingAnchor constraintEqualToAnchor:_divider.trailingAnchor].active =
      YES;

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

  _rippleColor = RippleColor();
  if (!_rippleTouchController) {
    _rippleTouchController = [[MDCRippleTouchController alloc] init];
    [_rippleTouchController addRippleToView:self];
    _rippleTouchController.rippleView.rippleColor = _rippleColor;
  }

  _actionImageView = [[UIImageView alloc] init];
  [_contentContainerView addSubview:_actionImageView];
  _actionImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [_actionImageView.topAnchor constraintEqualToAnchor:_contentContainerView.topAnchor
                                             constant:kImageTopPadding]
      .active = YES;
  [_actionImageView.leadingAnchor constraintEqualToAnchor:_contentContainerView.leadingAnchor]
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

- (void)setDividerColor:(UIColor *)dividerColor {
  self.divider.backgroundColor = dividerColor;
}

- (UIColor *)dividerColor {
  return self.divider.backgroundColor;
}

- (void)setShowsDivider:(BOOL)showsDivider {
  self.divider.hidden = !showsDivider;
}

- (BOOL)showsDivider {
  return !self.divider.hidden;
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

- (void)setRippleColor:(UIColor *)rippleColor {
  _rippleColor = rippleColor ?: RippleColor();
  self.rippleTouchController.rippleView.rippleColor = _rippleColor;
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
