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

#import "MaterialInk.h"
#import "MaterialMath.h"
#import "MaterialTypography.h"

#import "private/MDCSelfSizingStereoCellLayout.h"

static const CGFloat kTitleColorOpacity = 0.87f;
static const CGFloat kDetailColorOpacity = 0.6f;

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
  [self createSubviews];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Setup

- (void)createSubviews {
  self.textContainer = [[UIView alloc] init];
  [self.contentView addSubview:self.textContainer];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.font = self.defaultTitleLabelFont;
  self.titleLabel.numberOfLines = 0;
  [self.textContainer addSubview:self.titleLabel];

  self.detailLabel = [[UILabel alloc] init];
  self.detailLabel.font = self.defaultDetailLabelFont;
  self.detailLabel.numberOfLines = 0;
  [self.textContainer addSubview:self.detailLabel];

  self.leadingImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:self.leadingImageView];

  self.trailingImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:self.trailingImageView];
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
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.detailLabel.textAlignment = NSTextAlignmentRight;
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
  } else {
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
  }
}

- (void)setNeedsLayout {
  [self invalidateCachedLayouts];
  [super setNeedsLayout];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
  MDCSelfSizingStereoCellLayout *layout = [self layoutForCellWidth:targetSize.width];
  return CGSizeMake(targetSize.width, layout.calculatedHeight);
}

#pragma mark UICollectionViewCell Overrides

- (void)prepareForReuse {
  [super prepareForReuse];

  [self invalidateCachedLayouts];
  self.titleLabel.text = nil;
  self.titleLabel.font = self.defaultTitleLabelFont;
  self.detailLabel.text = nil;
  self.detailLabel.font = self.defaultDetailLabelFont;
  self.leadingImageView.image = nil;
  self.trailingImageView.image = nil;
}

#pragma mark Layout

- (MDCSelfSizingStereoCellLayout *)layoutForCellWidth:(CGFloat)cellWidth {
  CGFloat flooredCellWidth = MDCFloor(cellWidth);
  MDCSelfSizingStereoCellLayout *layout = self.cachedLayouts[@(flooredCellWidth)];
  if (!layout) {
    layout = [[MDCSelfSizingStereoCellLayout alloc] initWithLeadingImageView:self.leadingImageView
                                                           trailingImageView:self.trailingImageView
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

  [self adjustFontsForContentSizeCategory];
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self adjustFontsForContentSizeCategory];
}

- (void)adjustFontsForContentSizeCategory {
  UIFont *titleFont = self.titleLabel.font ?: self.defaultTitleLabelFont;
  UIFont *detailFont = self.detailLabel.font ?: self.defaultDetailLabelFont;
  if (_mdc_adjustsFontForContentSizeCategory) {
    titleFont =
        [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleTitle
                                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
    detailFont =
        [detailFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleCaption
                                 scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
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
