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

#import "MDCSelfSizingStereoCell.h"

#import <Foundation/Foundation.h>

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialTypography.h"

#import "private/MDCSelfSizingStereoCellLayout.h"

static const CGFloat kTitleColorOpacity = (CGFloat)0.87;
static const CGFloat kDetailColorOpacity = (CGFloat)0.6;

@interface MDCSelfSizingStereoCell ()

@property(nonatomic, strong) UIView *textContainer;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *detailLabel;
@property(nonatomic, strong) UIImageView *leadingImageView;
@property(nonatomic, strong) UIImageView *trailingImageView;

@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, MDCSelfSizingStereoCellLayout *> *cachedLayouts;

@end

@implementation MDCSelfSizingStereoCell

@synthesize mdc_adjustsFontForContentSizeCategory = _mdc_adjustsFontForContentSizeCategory;

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCSelfSizingStereoCellInit];
    return self;
  }
  return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCSelfSizingStereoCellInit];
    return self;
  }
  return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCSelfSizingStereoCellInit];
    return self;
  }
  return nil;
}

- (void)commonMDCSelfSizingStereoCellInit {
  self.cachedLayouts = [[NSMutableDictionary alloc] init];
  _adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
  [self createSubviews];
}

#pragma mark Setup

- (void)createSubviews {
  self.textContainer = [[UIView alloc] init];
  [self.contentView addSubview:self.textContainer];

  self.titleLabel = [[UILabel alloc] init];
  [self.textContainer addSubview:self.titleLabel];

  self.detailLabel = [[UILabel alloc] init];
  [self.textContainer addSubview:self.detailLabel];

  self.leadingImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:self.leadingImageView];

  self.trailingImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:self.trailingImageView];

  [self resetMDCSelfSizingStereoCellLabelProperties];
}

- (void)resetMDCSelfSizingStereoCellLabelProperties {
  self.titleLabel.font = self.defaultTitleLabelFont;
  self.titleLabel.textColor = self.defaultTitleLabelTextColor;
  self.titleLabel.numberOfLines = 0;

  self.detailLabel.font = self.defaultDetailLabelFont;
  self.detailLabel.textColor = self.defaultDetailLabelTextColor;
  self.detailLabel.numberOfLines = 0;
}

#pragma mark UIView Overrides

- (void)layoutSubviews {
  [super layoutSubviews];

  MDCSelfSizingStereoCellLayout *layout = [self layoutForCellWidth:self.frame.size.width];
  self.textContainer.frame = layout.textContainerFrame;
  self.titleLabel.frame = layout.titleLabelFrame;
  self.detailLabel.frame = layout.detailLabelFrame;
  self.leadingImageView.frame = layout.leadingImageViewFrame;
  self.trailingImageView.frame = layout.trailingImageViewFrame;
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    self.leadingImageView.frame =
        MDFRectFlippedHorizontally(self.leadingImageView.frame, layout.cellWidth);
    self.trailingImageView.frame =
        MDFRectFlippedHorizontally(self.trailingImageView.frame, layout.cellWidth);
    self.textContainer.frame =
        MDFRectFlippedHorizontally(self.textContainer.frame, layout.cellWidth);
    self.titleLabel.frame =
        MDFRectFlippedHorizontally(self.titleLabel.frame, self.textContainer.frame.size.width);
    self.detailLabel.frame =
        MDFRectFlippedHorizontally(self.detailLabel.frame, self.textContainer.frame.size.width);
  }
}

- (void)setNeedsLayout {
  [self invalidateCachedLayouts];
  [super setNeedsLayout];
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:
    (UICollectionViewLayoutAttributes *)layoutAttributes {
  UICollectionViewLayoutAttributes *attributes =
      [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
  attributes.size = [self systemLayoutSizeFittingSize:layoutAttributes.size];
  return attributes;
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
  MDCSelfSizingStereoCellLayout *layout = [self layoutForCellWidth:targetSize.width];
  return CGSizeMake(targetSize.width, layout.calculatedHeight);
}

#pragma mark UICollectionViewCell Overrides

- (void)prepareForReuse {
  [super prepareForReuse];

  self.titleLabel.text = nil;
  self.detailLabel.text = nil;
  self.leadingImageView.image = nil;
  self.trailingImageView.image = nil;

  [self setNeedsLayout];

  [self mdc_setAdjustsFontForContentSizeCategory:NO];
  [self resetMDCSelfSizingStereoCellLabelProperties];
}

#pragma mark Layout

- (MDCSelfSizingStereoCellLayout *)layoutForCellWidth:(CGFloat)cellWidth {
  CGFloat flooredCellWidth = floor(cellWidth);
  MDCSelfSizingStereoCellLayout *layout = self.cachedLayouts[@(flooredCellWidth)];
  if (!layout) {
    layout = [[MDCSelfSizingStereoCellLayout alloc]
                 initWithLeadingImageView:self.leadingImageView
         leadingImageViewVerticalPosition:self.leadingImageViewVerticalPosition
                        trailingImageView:self.trailingImageView
        trailingImageViewVerticalPosition:self.trailingImageViewVerticalPosition
                            textContainer:self.textContainer
                               titleLabel:self.titleLabel
                              detailLabel:self.detailLabel
                                cellWidth:flooredCellWidth];
    self.cachedLayouts[@(flooredCellWidth)] = layout;
  }
  return layout;
}

- (void)invalidateCachedLayouts {
  [self.cachedLayouts removeAllObjects];
}

#pragma mark Dynamic Type

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  if (adjusts == _mdc_adjustsFontForContentSizeCategory) {
    return;
  }

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

  [self adjustFontsForDynamicType];
}

- (void)setAdjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable:
    (BOOL)adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable {
  _adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable =
      adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable;
  [self adjustFontsForDynamicType];
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self adjustFontsForDynamicType];
}

- (void)adjustFontsForDynamicType {
  UIFont *titleFont = self.titleLabel.font ?: self.defaultTitleLabelFont;
  UIFont *detailFont = self.detailLabel.font ?: self.defaultDetailLabelFont;
  if (self.mdc_adjustsFontForContentSizeCategory) {
    if (titleFont.mdc_scalingCurve) {
      titleFont = [titleFont mdc_scaledFontForTraitEnvironment:self];
    } else if (self.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable) {
      titleFont =
          [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleTitle
                                  scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
    }

    if (detailFont.mdc_scalingCurve) {
      detailFont = [detailFont mdc_scaledFontForTraitEnvironment:self];
    } else if (self.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable) {
      detailFont =
          [detailFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleCaption
                                   scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
    }
  }
  self.titleLabel.font = titleFont;
  self.detailLabel.font = detailFont;
  [self setNeedsLayout];
}

#pragma mark Font Defaults

- (UIFont *)defaultTitleLabelFont {
  return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleTitle];
}

- (UIFont *)defaultDetailLabelFont {
  return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];
}

- (UIColor *)defaultTitleLabelTextColor {
  return [UIColor colorWithWhite:0 alpha:kTitleColorOpacity];
}

- (UIColor *)defaultDetailLabelTextColor {
  return [UIColor colorWithWhite:0 alpha:kDetailColorOpacity];
}

@end
