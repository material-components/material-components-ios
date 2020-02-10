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

#import <MaterialComponents/MaterialMath.h>
#import <MaterialComponents/MaterialRipple.h>
#import <MaterialComponents/MaterialTypography.h>
#import <MDFInternationalization/MDFInternationalization.h>

static const CGFloat kLabelAlpha = (CGFloat)0.87;
/** The size of the image in both dimensions. */
static const CGFloat kImageHeightAndWidth = 24;
/** Used to account for a missing image when title alignment is desired. */
static const CGFloat kTitleAlignmentAdjustment = 56;  // 24 (image) + 32 (spacing)
/** The height of the divider. */
static const CGFloat kDividerHeight = 1;
/**
 Internal constants used to ensure having @c contentEdgeInsets equal to @c UIEdgeInsetsZero still
 results in actions that match Material.io's guidance for single-row List items' padding.
 */
static const UIEdgeInsets kInternalPadding = (UIEdgeInsets){16, 0, 16, 0};

static inline UIColor *RippleColor() {
  return [[UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.14];
}

@interface MDCActionSheetItemTableViewCell ()
@property(nonatomic, strong) UIImageView *actionImageView;
@property(nonatomic, strong) MDCRippleTouchController *rippleTouchController;
/** A divider that is show at the top of the action. */
@property(nonatomic, strong, nonnull) UIView *divider;
@end

@implementation MDCActionSheetItemTableViewCell {
  MDCActionSheetAction *_itemAction;
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
  _divider = [[UIView alloc] init];
  _divider.backgroundColor = UIColor.clearColor;
  [self.contentView addSubview:_divider];

  _actionLabel = [[UILabel alloc] init];
  [self.contentView addSubview:_actionLabel];
  _actionLabel.numberOfLines = 0;
  [_actionLabel sizeToFit];
  _actionLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  _actionLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  _actionLabel.textColor = [UIColor.blackColor colorWithAlphaComponent:kLabelAlpha];

  _rippleColor = RippleColor();
  if (!_rippleTouchController) {
    _rippleTouchController = [[MDCRippleTouchController alloc] init];
    [_rippleTouchController addRippleToView:self];
    _rippleTouchController.rippleView.rippleColor = _rippleColor;
  }

  _actionImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:_actionImageView];
}

- (UIEdgeInsets)_contentPadding {
  return UIEdgeInsetsMake(kInternalPadding.top - self.contentEdgeInsets.top,
                          self.layoutMargins.left + kInternalPadding.left - self.contentEdgeInsets.left,
                          kInternalPadding.bottom - self.contentEdgeInsets.bottom,
                          self.layoutMargins.right + kInternalPadding.right - self.contentEdgeInsets.right);
}

- (CGSize)sizeThatFits:(CGSize)size {
  const UIEdgeInsets contentPadding = UIEdgeInsetsMake(kInternalPadding.top - self.contentEdgeInsets.top,
                                                       self.layoutMargins.left + kInternalPadding.left - self.contentEdgeInsets.left,
                                                       kInternalPadding.bottom - self.contentEdgeInsets.bottom,
                                                       self.layoutMargins.right + kInternalPadding.right - self.contentEdgeInsets.right);
  // Account for an absent image when title alignment is desired.
  CGFloat labelWidthDiscount = (self.actionImageView.image != nil || self.addLeadingPadding) ? kTitleAlignmentAdjustment : 0;
  // Account for horizontal content edge insets
  labelWidthDiscount += contentPadding.left + contentPadding.right;
  // Account for vertical content edge insets
  CGFloat labelHeightDiscount = contentPadding.top + contentPadding.bottom;

  // Label needs to fit within the space available.
  CGSize labelFitSize = [self.actionLabel sizeThatFits:CGSizeMake(size.width - labelWidthDiscount, size.height - labelHeightDiscount)];
  CGSize returnSize = CGSizeMake(labelWidthDiscount + labelFitSize.width, labelFitSize.height + labelHeightDiscount);
  return returnSize;
}

- (CGSize)intrinsicContentSize {
  const UIEdgeInsets contentPadding = UIEdgeInsetsMake(kInternalPadding.top - self.contentEdgeInsets.top,
                                                       kInternalPadding.left - self.contentEdgeInsets.left,
                                                       kInternalPadding.bottom - self.contentEdgeInsets.bottom,
                                                       kInternalPadding.right - self.contentEdgeInsets.right);
  // Height is max of 24 points (for images) or the label's fitting size.
  CGFloat intrinsicHeight = MAX(kImageHeightAndWidth, [self.actionLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].height);
  // Add or remove the vertical content edge insets
  intrinsicHeight = intrinsicHeight - contentPadding.top - contentPadding.bottom;
  return CGSizeMake(UIViewNoIntrinsicMetric, intrinsicHeight);
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.actionLabel.accessibilityLabel = _itemAction.accessibilityLabel;
  self.actionLabel.text = _itemAction.title;
  self.actionImageView.image = [_itemAction.image imageWithRenderingMode:self.imageRenderingMode];

  BOOL isRTL = self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
  // Although layoutMargins flip for RTL, manual flipping is required for this class's APIs.
  UIEdgeInsets contentPadding = isRTL ? UIEdgeInsetsMake(kInternalPadding.top - self.contentEdgeInsets.top,
                                                         self.layoutMargins.left + kInternalPadding.right - self.contentEdgeInsets.right,
                                                         kInternalPadding.bottom - self.contentEdgeInsets.bottom,
                                                         self.layoutMargins.right + kInternalPadding.left - self.contentEdgeInsets.left)
  : UIEdgeInsetsMake(kInternalPadding.top - self.contentEdgeInsets.top,
                                                 self.layoutMargins.left + kInternalPadding.left - self.contentEdgeInsets.left,
                                                 kInternalPadding.bottom - self.contentEdgeInsets.bottom,
                                                 self.layoutMargins.right + kInternalPadding.right - self.contentEdgeInsets.right);
  CGRect contentRect = UIEdgeInsetsInsetRect(CGRectStandardize(self.bounds), contentPadding);
  const CGFloat contentMidY = CGRectGetMidY(contentRect);


  // Position the divider.
  if (self.showsDivider) {
    self.divider.frame = CGRectMake(CGRectGetMinX(contentRect), 0, contentRect.size.width, kDividerHeight);
  }

  // Position the action label
  CGFloat labelAvailableHeight = CGRectGetHeight(contentRect);
  CGFloat labelAvailableWidth = CGRectGetWidth(contentRect);
  CGFloat titleLeadingXAdjustment = (self.actionImageView.image || self.addLeadingPadding) ? kTitleAlignmentAdjustment : 0;
  labelAvailableWidth -= titleLeadingXAdjustment;

  CGSize labelFittingSize = [self.actionLabel sizeThatFits:CGSizeMake(labelAvailableWidth, labelAvailableHeight)];
  CGSize labelFinalSize = CGSizeMake(MIN(labelAvailableWidth, labelFittingSize.width), MIN(labelAvailableHeight, labelFittingSize.height));
  CGFloat labelOriginX = isRTL ? CGRectGetMaxX(contentRect) - titleLeadingXAdjustment - labelFinalSize.width : CGRectGetMinX(contentRect) + titleLeadingXAdjustment;
  CGFloat labelOriginY = contentMidY - labelFinalSize.height / 2;
  CGPoint labelOrigin = MDCPointRoundWithScale(CGPointMake(labelOriginX, labelOriginY), self.window.screen.scale > 0 ? self.window.screen.scale : 1);
  self.actionLabel.frame = CGRectMake(labelOrigin.x, labelOrigin.y, labelFinalSize.width, labelFinalSize.height);

  // Position the action image
  if (self.actionImageView.image) {
    CGFloat imageViewMinX = isRTL ? CGRectGetMaxX(contentRect) - kImageHeightAndWidth : CGRectGetMinX(contentRect);
    CGFloat imageViewMinY = CGRectGetMinY(self.actionLabel.frame);
    CGPoint imageOrigin = MDCPointRoundWithScale(CGPointMake(imageViewMinX, imageViewMinY), self.window.screen.scale > 0 ? self.window.screen.scale : 1);
    CGRect imageFrame = CGRectMake(imageOrigin.x, imageOrigin.y, kImageHeightAndWidth, kImageHeightAndWidth);
    self.actionImageView.frame = imageFrame;
  }
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
  [self setNeedsLayout];
  [self invalidateIntrinsicContentSize];
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

@end
