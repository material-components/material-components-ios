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
#import "MDCActionSheetAction.h"

#import <MaterialComponents/MaterialRipple.h>
#import <MaterialComponents/MaterialTypography.h>

static const CGFloat kLabelAlpha = (CGFloat)0.87;
static const CGFloat kImageTopPadding = 16;
static const CGFloat kImageHeightAndWidth = 24;
static const CGFloat kTitleLeadingPadding = 56;  // 16 (layoutMargins) + 24 (image) + 16
static const CGFloat kActionItemTitleVerticalPadding = 18;
/** The height of the divider. */
static const CGFloat kDividerHeight = 1;

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

#ifdef __IPHONE_13_4
@interface MDCActionSheetItemTableViewCell (PointerInteractions) <UIPointerInteractionDelegate>
@end
#endif

@implementation MDCActionSheetItemTableViewCell {
  MDCActionSheetAction *_itemAction;
  NSLayoutConstraint *_titleLeadingConstraint;
  NSLayoutConstraint *_contentContainerTopConstraint;
  NSLayoutConstraint *_contentContainerLeadingConstraint;
  NSLayoutConstraint *_contentContainerBottomConstraint;
  NSLayoutConstraint *_contentContainerTrailingConstraint;
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
  [_actionLabel sizeToFit];
  _actionLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  _actionLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  _actionLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:kLabelAlpha];
  CGFloat leadingConstant = 0;
  if (_itemAction.image || _addLeadingPadding) {
    leadingConstant = kTitleLeadingPadding;
  }
  [_actionLabel.topAnchor constraintEqualToAnchor:_contentContainerView.topAnchor
                                         constant:kActionItemTitleVerticalPadding]
      .active = YES;
  NSLayoutConstraint *labelBottomConstraint =
      [_actionLabel.bottomAnchor constraintEqualToAnchor:_contentContainerView.bottomAnchor
                                                constant:-kActionItemTitleVerticalPadding];
  labelBottomConstraint.priority = UILayoutPriorityDefaultHigh;
  labelBottomConstraint.active = YES;
  _titleLeadingConstraint =
      [_actionLabel.leadingAnchor constraintEqualToAnchor:_contentContainerView.leadingAnchor
                                                 constant:leadingConstant];
  _titleLeadingConstraint.active = YES;
  [_contentContainerView.trailingAnchor constraintEqualToAnchor:_actionLabel.trailingAnchor]
      .active = YES;

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

#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    // Because some iOS 13 betas did not have the UIPointerInteraction class, we need to verify
    // that it exists before attempting to use it.
    if (NSClassFromString(@"UIPointerInteraction")) {
      UIPointerInteraction *pointerInteraction =
          [[UIPointerInteraction alloc] initWithDelegate:self];
      [self.contentView addInteraction:pointerInteraction];
    }
  }
#endif
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.actionLabel.accessibilityLabel = _itemAction.accessibilityLabel;
  self.actionLabel.text = _itemAction.title;
  CGFloat leadingConstant = 0;
  if (_itemAction.image || self.addLeadingPadding) {
    leadingConstant = kTitleLeadingPadding;
  }
  _titleLeadingConstraint.constant = leadingConstant;

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

#pragma mark - UIPointerInteractionDelegate

#ifdef __IPHONE_13_4
- (UIPointerStyle *)pointerInteraction:(UIPointerInteraction *)interaction
                        styleForRegion:(UIPointerRegion *)region API_AVAILABLE(ios(13.4)) {
  UIPointerStyle *pointerStyle = nil;
  if (interaction.view) {
    UITargetedPreview *targetedPreview = [[UITargetedPreview alloc] initWithView:interaction.view];
    UIPointerEffect *hoverEffect = [UIPointerHoverEffect effectWithPreview:targetedPreview];
    pointerStyle = [UIPointerStyle styleWithEffect:hoverEffect shape:nil];
  }
  return pointerStyle;
}
#endif

@end
