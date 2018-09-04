/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCActionSheetItemTableViewCell.h"

#import "MaterialTypography.h"

static const CGFloat ImageAlpha = 0.54f;
static const CGFloat LabelAlpha = 0.87f;
static const CGFloat ImageLeadingPadding = 16.f;
static const CGFloat ImageTopPadding = 16.f;
static const CGFloat ImageHeightAndWidth = 24.f;
static const CGFloat TitleLeadingPadding = 72.f;
static const CGFloat TitleTrailingPadding = 16.f;
static const CGFloat ActionItemTitleVerticalPadding = 18.f;

@implementation MDCActionSheetItemTableViewCell {
  MDCActionSheetAction *_itemAction;
  UILabel *_textLabel;
  UIImageView *_imageView;
  NSLayoutConstraint *_titleLeadingConstraint;
  NSLayoutConstraint *_titleWidthConstraint;
  MDCInkTouchController *_inkTouchController;
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
  _textLabel = [[UILabel alloc] init];
  [self.contentView addSubview:_textLabel];
  _textLabel.numberOfLines = 0;
  _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [_textLabel sizeToFit];
  _textLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  _textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  _textLabel.alpha = LabelAlpha;
  CGFloat leadingConstant;
  if (_itemAction.image) {
    leadingConstant = TitleLeadingPadding;
  } else {
    leadingConstant = ImageLeadingPadding;
  }
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:ActionItemTitleVerticalPadding].active = YES;
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:-ActionItemTitleVerticalPadding].active = YES;
  _titleLeadingConstraint = [NSLayoutConstraint constraintWithItem:_textLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1
                                                          constant:leadingConstant];
  _titleLeadingConstraint.active = YES;
  CGFloat width = CGRectGetWidth(self.contentView.frame) - leadingConstant - TitleTrailingPadding;
  _titleWidthConstraint = [NSLayoutConstraint constraintWithItem:_textLabel
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1
                                                        constant:width];
  _titleWidthConstraint.active = YES;
  if (!_inkTouchController) {
    _inkTouchController = [[MDCInkTouchController alloc] initWithView:self];
    [_inkTouchController addInkView];
  }

  _imageView = [[UIImageView alloc] init];
  [self.contentView addSubview:_imageView];
  _imageView.translatesAutoresizingMaskIntoConstraints = NO;
  _imageView.alpha = ImageAlpha;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:ImageTopPadding].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:ImageLeadingPadding].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:ImageHeightAndWidth].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:ImageHeightAndWidth].active = YES;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  _textLabel.text = _itemAction.title;
  CGFloat leadingConstant;
  if (_itemAction.image) {
    leadingConstant = TitleLeadingPadding;
  } else {
    leadingConstant = ImageLeadingPadding;
  }
  _titleLeadingConstraint.constant = leadingConstant;
  CGFloat width = CGRectGetWidth(self.contentView.frame) - leadingConstant - TitleTrailingPadding;
  _titleWidthConstraint.constant = width;
  _imageView.image = [_itemAction.image imageWithRenderingMode:*(self.imageRenderingMode)];
}

- (void)setAction:(MDCActionSheetAction *)action {
  _itemAction = [action copy];
  _textLabel.text = _itemAction.title;
  //_imageView.image = [_itemAction.image imageWithRenderingMode:self.imageRenderingMode];
  [self setNeedsLayout];
}

- (MDCActionSheetAction *)action {
  return _itemAction;
}

- (void)setActionsFont:(UIFont *)actionFont {
  _actionFont = actionFont;
  [self updateTitleFont];
}

- (void)updateTitleFont {
  UIFont *titleFont = _actionFont ?:
      [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    _textLabel.font =
        [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  } else {
    _textLabel.font = titleFont;
  }
  [self setNeedsLayout];
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  [self updateTitleFont];
}

- (void)setActionTextColor:(UIColor *)actionTextColor {
  _textLabel.textColor = actionTextColor;
}
- (UIColor *)actionTextColor {
  return _textLabel.textColor;
}

/*- (void)setImageRenderingMode:(UIImageRenderingMode *)imageRenderingMode {
  _imageRenderingMode = imageRenderingMode;
  [self setNeedsLayout];
}

- (UIImageRenderingMode *)imageRenderingMode {
  return self.imageRenderingMode;
}*/

@end
