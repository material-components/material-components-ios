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

#import "MDCListItemCell.h"

#import "ManualLayoutListItemCell2.h"

#import <MDFInternationalization/MDFInternationalization.h>
#import "MaterialInk.h"
#import "MaterialTypography.h"

static const CGFloat kDefaultVerticalMarginMin = 8.0;
static const CGFloat kDefaultVerticalMarginMax = 16.0;
static const CGFloat kDefaultHorizontalMargin = 16.0;

static const CGFloat kImageSideLengthMedium = 40.0;
static const CGFloat kImageSideLengthMax = 56.0;

static const CGFloat kTitleColorOpacity = 0.87f;
static const CGFloat kDetailColorOpacity = 0.6f;

@interface MDCListItemCell ()

@property (nonatomic, strong) UIView *textContainer;
@property (nonatomic, assign) CGRect textContainerFrame;
@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect detailLabelFrame;
@property (nonatomic, assign) CGRect leadingImageViewFrame;
@property (nonatomic, assign) CGRect trailingImageViewFrame;

@end

@implementation MDCListItemCell
@synthesize mdc_adjustsFontForContentSizeCategory = _mdc_adjustsFontForContentSizeCategory;

-(instancetype)init {
  self = [super init];
  if (self) {
    [self baseMDCListItemCellInit];
    return self;
  }
  return nil;
}

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self baseMDCListItemCellInit];
    return self;
  }
  return nil;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self baseMDCListItemCellInit];
    return self;
  }
  return nil;
}
- (void)baseMDCListItemCellInit {
  [self createSubviews];
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Setup

- (void)createSubviews {
  self.textContainer = [[UIView alloc] init];
  [self.contentView addSubview:self.textContainer];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.numberOfLines = 0;
  self.titleLabel.font = self.defaultDetailLabelFont;
  [self.textContainer addSubview:self.titleLabel];

  self.detailLabel = [[UILabel alloc] init];
  self.detailLabel.numberOfLines = 0;
  self.detailLabel.font = self.defaultDetailLabelFont;
  [self.textContainer addSubview:self.detailLabel];

  self.leadingImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:self.leadingImageView];

  self.trailingImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:self.trailingImageView];
}

#pragma mark UIView Overrides

-(void)layoutSubviews {
  [super layoutSubviews];
  self.textContainer.frame = self.textContainerFrame;
  self.titleLabel.frame = self.titleLabelFrame;
  self.detailLabel.frame = self.detailLabelFrame;
  self.leadingImageView.frame = self.leadingImageViewFrame;
  self.trailingImageView.frame = self.trailingImageViewFrame;
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    self.leadingImageView.frame =
    MDFRectFlippedHorizontally(self.leadingImageView.frame, self.cellWidth);
    self.trailingImageView.frame =
    MDFRectFlippedHorizontally(self.trailingImageView.frame, self.cellWidth);
    self.textContainer.frame =
    MDFRectFlippedHorizontally(self.textContainer.frame, self.cellWidth);
  }
}

#pragma mark UICollectionViewCell Overrides

-(void)prepareForReuse {
  [super prepareForReuse];
  self.titleLabel.text = nil;
  self.titleLabel.font = self.defaultTitleLabelFont;
  self.titleLabelFrame = CGRectZero;
  self.detailLabel.text = nil;
  self.detailLabel.font = self.defaultDetailLabelFont;
  self.detailLabelFrame = CGRectZero;
  self.leadingImageView.image = nil;
  self.leadingImageViewFrame = CGRectZero;
  self.trailingImageView.image = nil;
  self.trailingImageViewFrame = CGRectZero;
}

-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
  self.cellWidth = targetSize.width;
  [self calculateSubviewFrames];
  return CGSizeMake(self.cellWidth, [self calculateHeight]);
}

- (void)calculateSubviewFrames {
  [self calculateLeadingImageViewFrame];
  [self calculateTrailingViewFrame];
  [self calculateTextContainerFrame];
}

- (void)calculateLeadingImageViewFrame {
  CGSize size = [self sizeForImage:self.leadingImageView.image];
  CGFloat leadingPadding = 0;
  CGFloat topPadding = 0;
  if (!CGSizeEqualToSize(size, CGSizeZero)) {
    leadingPadding = kDefaultHorizontalMargin;
    topPadding = [self verticalMarginForImageViewOfSize:size];
  }
  CGPoint origin = CGPointMake(leadingPadding, topPadding);
  CGRect rect = CGRectZero;
  rect.origin = origin;
  rect.size = size;
  if (CGRectGetMaxX(rect) > self.cellWidth) {
    rect = CGRectZero;
  }
  self.leadingImageViewFrame = rect;
}

- (void)calculateTrailingViewFrame {
  CGSize size = [self sizeForImage:self.trailingImageView.image];
  CGFloat trailingPadding = 0;
  CGFloat topPadding = 0;
  if (!CGSizeEqualToSize(size, CGSizeZero)) {
    trailingPadding = kDefaultHorizontalMargin;
    topPadding = [self verticalMarginForImageViewOfSize:size];
  }
  CGFloat originX = self.cellWidth - trailingPadding - size.width;
  CGPoint origin = CGPointMake(originX, topPadding);
  CGRect rect = CGRectZero;
  rect.origin = origin;
  rect.size = size;
  if (originX < 0 || (CGRectGetMaxX(rect) > self.cellWidth)) {
    rect = CGRectZero;
  }
  self.trailingImageViewFrame = rect;
}

- (void)calculateTextContainerFrame {
  BOOL containsTitleText = self.titleLabel.text.length > 0;
  BOOL containsDetailText = self.detailLabel.text.length > 0;
  if (!containsTitleText && !containsDetailText) {
    self.titleLabelFrame = CGRectZero;
    self.detailLabelFrame = CGRectZero;
    self.textContainerFrame = CGRectZero;
    return;
  }

    CGFloat leadingImageViewMaxX = self.leadingImageView.image ?
        CGRectGetMaxX(self.leadingImageViewFrame) : 0;
    CGFloat textContainerMinX = leadingImageViewMaxX + kDefaultHorizontalMargin;
  CGFloat trailingImageViewMinX = self.trailingImageView.image ?
  CGRectGetMinX(self.trailingImageViewFrame) : self.cellWidth;
  CGFloat textContainerMaxX = trailingImageViewMinX - kDefaultHorizontalMargin;
  CGFloat textContainerMinY = kDefaultVerticalMarginMax;
  CGFloat textContainerWidth = textContainerMaxX - textContainerMinX;
  CGFloat textContainerHeight = 0;

  CGFloat labelMinX = 0;
  CGFloat labelMinY = 0;

  CGSize fittingSize = CGSizeMake(textContainerWidth, 50000);
  CGSize titleSize = [self.titleLabel sizeThatFits:fittingSize];
  if (self.titleLabel.numberOfLines != 0 && titleSize.width > textContainerWidth) {
    titleSize.width = textContainerWidth;
  }
  CGPoint titleOrigin = CGPointMake(labelMinX, labelMinY);
  CGRect titleFrame = CGRectZero;
  titleFrame.origin = titleOrigin;
  titleFrame.size = titleSize;
  self.titleLabelFrame = titleFrame;

  labelMinY = CGRectGetMaxY(titleFrame);
  if (self.titleLabel.text.length > 0 && self.detailLabel.text.length > 0) {
    labelMinY += [self dynamicInterLabelVerticalPadding];
  }

  CGSize detailSize = [self.detailLabel sizeThatFits:fittingSize];
  if (self.detailLabel.numberOfLines != 0 && detailSize.width > textContainerWidth) {
    detailSize.width = textContainerWidth;
  }
  CGPoint detailOrigin = CGPointMake(labelMinX, labelMinY);
  CGRect detailFrame = CGRectZero;
  detailFrame.origin = detailOrigin;
  detailFrame.size = detailSize;
  self.detailLabelFrame = detailFrame;

  textContainerHeight = CGRectGetMaxY(self.detailLabelFrame);

  CGRect textContainerFrame = CGRectZero;
  CGPoint textContainerOrigin = CGPointMake(textContainerMinX, textContainerMinY);
  CGSize textContainerSize = CGSizeMake(textContainerWidth, textContainerHeight);
  textContainerFrame.origin = textContainerOrigin;
  textContainerFrame.size = textContainerSize;
  self.textContainerFrame = textContainerFrame;

  BOOL containsOnlyTitleText = containsTitleText && !containsDetailText;
  BOOL shouldVerticallyCenterTitleText = containsOnlyTitleText && self.leadingImageView.image;
  if (shouldVerticallyCenterTitleText) {
    CGFloat leadingImageViewCenterY = CGRectGetMidY(self.leadingImageViewFrame);
    CGFloat textContainerCenterY = CGRectGetMidY(self.textContainerFrame);
    CGFloat difference = textContainerCenterY - leadingImageViewCenterY;
    CGRect offsetTextContainerRect = CGRectOffset(self.textContainerFrame, 0, -difference);
    BOOL willExtendPastMargin = offsetTextContainerRect.origin.y < kDefaultVerticalMarginMax;
    if (!willExtendPastMargin) {
      self.textContainerFrame = offsetTextContainerRect;
    }
  }
}

- (CGSize)sizeForImage:(UIImage *)image {
  CGSize maxSize = CGSizeMake(kImageSideLengthMax, kImageSideLengthMax);
  if (!image || image.size.width <= 0 || image.size.height <= 0) {
    return CGSizeZero;
  } else if (image.size.width > maxSize.width || image.size.height > maxSize.height) {
    CGFloat aspectWidth = maxSize.width / image.size.width;
    CGFloat aspectHeight = maxSize.height / image.size.height;
    CGFloat aspectRatio = MIN(aspectWidth, aspectHeight);
    return CGSizeMake(image.size.width * aspectRatio, image.size.height * aspectRatio);
  } else {
    return image.size;
  }
}

- (CGFloat)dynamicInterLabelVerticalPadding {
  CGFloat titleLineHeight = self.titleLabel.font.lineHeight;
  CGFloat detailLineHeight = self.detailLabel.font.lineHeight;
  CGFloat lineHeightDifference = titleLineHeight - detailLineHeight;
  CGFloat interLabelPadding = (CGFloat)round((double)(detailLineHeight - lineHeightDifference));
  return interLabelPadding;
}

- (CGFloat)verticalMarginForImageViewOfSize:(CGSize)size {
  CGFloat leadingImageHeight = size.height;
  if (leadingImageHeight > 0 && leadingImageHeight <= kImageSideLengthMedium) {
    return kDefaultVerticalMarginMax;
  } else {
    return kDefaultVerticalMarginMin;
  }
}

- (CGFloat)calculateHeight {
  CGFloat maxHeight = 0;
  CGFloat leadingImageViewRequiredVerticalSpace = 0;
  CGFloat trailingImageViewRequiredVerticalSpace = 0;
  CGFloat textContainerRequiredVerticalSpace = 0;
  if (self.leadingImageView.image) {
    leadingImageViewRequiredVerticalSpace = CGRectGetMaxY(self.leadingImageViewFrame) +
    [self verticalMarginForImageViewOfSize:self.leadingImageViewFrame.size];
    if (leadingImageViewRequiredVerticalSpace > maxHeight) {
      maxHeight = leadingImageViewRequiredVerticalSpace;
    }
  }
  if (self.trailingImageView.image) {
    trailingImageViewRequiredVerticalSpace = CGRectGetMaxY(self.trailingImageViewFrame) +
    [self verticalMarginForImageViewOfSize:self.trailingImageViewFrame.size];
    if (trailingImageViewRequiredVerticalSpace > maxHeight) {
      maxHeight = trailingImageViewRequiredVerticalSpace;
    }
  }
  if (CGRectGetMaxY(self.titleLabelFrame) > 0) {
    textContainerRequiredVerticalSpace = CGRectGetMaxY(self.textContainerFrame) +
    kDefaultVerticalMarginMax;
    if (textContainerRequiredVerticalSpace > maxHeight) {
      maxHeight = textContainerRequiredVerticalSpace;
    }
  }
  return maxHeight;
}

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
  [self calculateSubviewFrames];
}

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
