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

#import "ManualLayoutListItemCell2.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialInk.h"
#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kDefaultVerticalMarginMin = 8.0;
static const CGFloat kDefaultVerticalMarginMax = 16.0;
static const CGFloat kDefaultHorizontalMargin = 16.0;

static const CGFloat kTextLeadingMarginMin = 16.0;
static const CGFloat kTextLeadingMarginMedium = 72.0;
static const CGFloat kTextLeadingMarginMax = 88.0;

static const CGFloat kImageSideLengthMedium = 40.0;
static const CGFloat kImageSideLengthMax = 56.0;

static const CGFloat kTitleColorOpacity = 0.87f;
static const CGFloat kDetailColorOpacity = 0.6f;

@interface ManualLayoutListItemCell2 ()

@property (strong, nonatomic, nonnull) UIView *textContainer;
@property (strong, nonatomic, nonnull) UILabel *titleLabel;
@property (strong, nonatomic, nonnull) UILabel *detailLabel;
@property (strong, nonatomic, nonnull) UIImageView *leadingImageView;
@property (strong, nonatomic, nonnull) UIImageView *trailingImageView;
@property (nonatomic, assign) BOOL hasSetCellWidth;

@end

@implementation ManualLayoutListItemCell2
@synthesize mdc_adjustsFontForContentSizeCategory = _mdc_adjustsFontForContentSizeCategory;

#pragma mark Object Lifecycle

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self baseManualLayoutListItemCell2Init];
    return self;
  }
  return nil;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self baseManualLayoutListItemCell2Init];
    return self;
  }
  return nil;
}

-(instancetype)init {
  self = [super init];
  if (self) {
    [self baseManualLayoutListItemCell2Init];
    return self;
  }
  return nil;
}

- (void)baseManualLayoutListItemCell2Init {
  [self createSupportingViews];
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Setup

- (void)createSupportingViews {
  self.leadingImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:self.leadingImageView];

  self.trailingImageView = [[UIImageView alloc] init];
  [self.contentView addSubview:self.trailingImageView];

  self.textContainer = [[UIView alloc] init];
  [self.contentView addSubview:self.textContainer];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:kTitleColorOpacity];
  [self.textContainer addSubview:self.titleLabel];

  self.detailLabel = [[UILabel alloc] init];
  self.detailLabel.textColor = [UIColor colorWithWhite:0 alpha:kDetailColorOpacity];
  [self.textContainer addSubview:self.detailLabel];
}

#pragma mark UICollectionViewCell Overrides

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:
(UICollectionViewLayoutAttributes *)layoutAttributes {
  UICollectionViewLayoutAttributes *attributes =
      [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
  [self assignFrames];
  CGPoint origin = attributes.frame.origin;
  CGFloat cellHeight = [self calculateHeight];
  CGRect frame = CGRectMake(origin.x, origin.y, self.cellWidth, cellHeight);
  attributes.frame = frame;
  return attributes;
}

-(void)prepareForReuse {
  [super prepareForReuse];
  self.titleText = nil;
  self.detailText = nil;
  self.leadingImage = nil;
  self.trailingImage = nil;
  self.typographyScheme = self.defaultTypographyScheme;
}

#pragma mark Accessors

-(void)setTitleText:(NSString *)titleText {
  if ([titleText isEqualToString:self.titleLabel.text]) {
    return;
  }
  self.titleLabel.text = titleText;
}

-(NSString *)titleText {
  return self.titleLabel.text;
}

-(void)setDetailText:(NSString *)detailText {
  if ([detailText isEqualToString:self.detailLabel.text]) {
    return;
  }
  self.detailLabel.text = detailText;
}

-(NSString *)detailText {
  return self.detailLabel.text;
}

- (void)setLeadingImage:(UIImage *)leadingImage {
  if (leadingImage == self.leadingImageView.image) {
    return;
  }
  self.leadingImageView.image = leadingImage;
}

-(UIImage *)leadingImage {
  return self.leadingImageView.image;
}

- (void)setTrailingImage:(UIImage *)trailingImage {
  if (trailingImage == self.trailingImageView.image) {
    return;
  }
  self.trailingImageView.image = trailingImage;
}

-(UIImage *)trailingImage {
  return self.trailingImageView.image;
}

#pragma mark Layout

-(void)setCellWidth:(CGFloat)cellWidth {
  self.hasSetCellWidth = YES;
  if (cellWidth == _cellWidth) {
    return;
  }
  _cellWidth = cellWidth;
}

-(void)setHasSetCellWidth:(BOOL)hasSetCellWidth {
  if (hasSetCellWidth == _hasSetCellWidth) {
    return;
  }
  _hasSetCellWidth = hasSetCellWidth;
}

- (void)assignFrames {
  NSAssert(self.hasSetCellWidth, @"Developer Error - You must set desired cell width for height \
      calculation to work properly.");
  [self assignLeadingViewFrame];
  [self assignTrailingViewFrame];
  [self assignTextContainerFrame];
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    self.leadingImageView.frame =
        MDFRectFlippedHorizontally(self.leadingImageView.frame, self.cellWidth);
    self.trailingImageView.frame =
        MDFRectFlippedHorizontally(self.trailingImageView.frame, self.cellWidth);
    self.textContainer.frame =
        MDFRectFlippedHorizontally(self.textContainer.frame, self.cellWidth);
  }
}

- (void)assignLeadingViewFrame {
  CGSize size = [self sizeForImage:self.leadingImage];
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
  self.leadingImageView.frame = rect;
}

- (void)assignTrailingViewFrame {
  CGSize size = [self sizeForImage:self.trailingImage];
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
  self.trailingImageView.frame = rect;
}

- (void)assignTextContainerFrame {
  BOOL containsTitleText = self.titleLabel.text.length > 0;
  BOOL containsDetailText = self.detailLabel.text.length > 0;
  if (!containsTitleText && !containsDetailText) {
    self.titleLabel.frame = CGRectZero;
    self.detailLabel.frame = CGRectZero;
    self.textContainer.frame = CGRectZero;
    return;
  }

//  CGFloat leadingImageViewMaxX = self.leadingImage ?
//      CGRectGetMaxX(self.leadingImageView.frame) : 0;
//  CGFloat textContainerMinX = leadingImageViewMaxX + kDefaultHorizontalMargin;
  CGFloat textContainerMinX = [self dynamicTextOffset];
  CGFloat trailingImageViewMinX = self.trailingImage ?
      CGRectGetMinX(self.trailingImageView.frame) : self.cellWidth;
  CGFloat textContainerMaxX = trailingImageViewMinX - kDefaultHorizontalMargin;
  CGFloat textContainerMinY = kDefaultVerticalMarginMax;
  CGFloat textContainerWidth = textContainerMaxX - textContainerMinX;
  CGFloat textContainerHeight = 0;

  CGFloat labelMinX = 0;
  CGFloat labelMinY = 0;

  CGSize fittingSize = CGSizeMake(textContainerWidth, 50000);
  CGSize titleSize = [self.titleLabel sizeThatFits:fittingSize];
  if (titleSize.width > textContainerWidth) {
    titleSize.width = textContainerWidth;
  }
  CGPoint titleOrigin = CGPointMake(labelMinX, labelMinY);
  CGRect titleFrame = CGRectZero;
  titleFrame.origin = titleOrigin;
  titleFrame.size = titleSize;
  self.titleLabel.frame = titleFrame;

  labelMinY = CGRectGetMaxY(titleFrame);
  if (self.titleText.length > 0 && self.detailText.length > 0) {
    labelMinY += [self dynamicInterLabelVerticalPadding];
  }

  CGSize detailSize = [self.detailLabel sizeThatFits:fittingSize];
  if (detailSize.width > textContainerWidth) {
    detailSize.width = textContainerWidth;
  }
  CGPoint detailOrigin = CGPointMake(labelMinX, labelMinY);
  CGRect detailFrame = CGRectZero;
  detailFrame.origin = detailOrigin;
  detailFrame.size = detailSize;
  self.detailLabel.frame = detailFrame;

  textContainerHeight = CGRectGetMaxY(self.detailLabel.frame);

  CGRect textContainerFrame = CGRectZero;
  CGPoint textContainerOrigin = CGPointMake(textContainerMinX, textContainerMinY);
  CGSize textContainerSize = CGSizeMake(textContainerWidth, textContainerHeight);
  textContainerFrame.origin = textContainerOrigin;
  textContainerFrame.size = textContainerSize;
  self.textContainer.frame = textContainerFrame;

  BOOL containsOnlyTitleText = containsTitleText && !containsDetailText;
  BOOL shouldVerticallyCenterTitleText = containsOnlyTitleText && self.leadingImage;
  if (shouldVerticallyCenterTitleText) {
    CGFloat leadingImageViewCenterY = CGRectGetMidY(self.leadingImageView.frame);
    CGFloat textContainerCenterY = CGRectGetMidY(self.textContainer.frame);
    CGFloat difference = textContainerCenterY - leadingImageViewCenterY;
    CGRect offsetTextContainerRect = CGRectOffset(self.textContainer.frame, 0, -difference);
    BOOL willExtendPastMargin = offsetTextContainerRect.origin.y < kDefaultVerticalMarginMax;
    if (!willExtendPastMargin) {
      self.textContainer.frame = offsetTextContainerRect;
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

- (CGFloat)dynamicTextOffset {
  if (!self.leadingImage) {
    return kTextLeadingMarginMin;
  } else if (CGRectGetHeight(self.leadingImageView.frame) <= kImageSideLengthMedium) {
    return kTextLeadingMarginMedium;
  } else {
    return kTextLeadingMarginMax;
  }
}

- (CGFloat)dynamicInterLabelVerticalPadding {
  CGFloat titleLineHeight = self.titleLabel.font.lineHeight;
  CGFloat detailLineHeight = self.detailLabel.font.lineHeight;
  CGFloat lineHeightDifference = titleLineHeight - detailLineHeight;
  CGFloat interLabelPadding = round((double)(detailLineHeight - lineHeightDifference));
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
  CGRect leadingImageViewFrame = self.leadingImageView.frame;
  CGRect trailingImageViewFrame = self.trailingImageView.frame;
  CGRect textContainerFrame = self.textContainer.frame;
  CGFloat leadingImageViewRequiredVerticalSpace = 0;
  CGFloat trailingImageViewRequiredVerticalSpace = 0;
  CGFloat textContainerRequiredVerticalSpace = 0;
  if (self.leadingImage) {
    leadingImageViewRequiredVerticalSpace = CGRectGetMaxY(leadingImageViewFrame) +
        [self verticalMarginForImageViewOfSize:leadingImageViewFrame.size];
    if (leadingImageViewRequiredVerticalSpace > maxHeight) {
      maxHeight = leadingImageViewRequiredVerticalSpace;
    }
  }
  if (self.trailingImage) {
    trailingImageViewRequiredVerticalSpace = CGRectGetMaxY(trailingImageViewFrame) +
        [self verticalMarginForImageViewOfSize:trailingImageViewFrame.size];
    if (trailingImageViewRequiredVerticalSpace > maxHeight) {
      maxHeight = trailingImageViewRequiredVerticalSpace;
    }
  }
  if (CGRectGetMaxY(textContainerFrame) > 0) {
    textContainerRequiredVerticalSpace = CGRectGetMaxY(textContainerFrame) +
        kDefaultVerticalMarginMax;
    if (textContainerRequiredVerticalSpace > maxHeight) {
      maxHeight = textContainerRequiredVerticalSpace;
    }
  }
  return maxHeight;
}

#pragma mark - Typography/Dynamic Type Support

- (MDCTypographyScheme *)defaultTypographyScheme {
  return [MDCTypographyScheme new];
}

-(void)setTypographyScheme:(MDCTypographyScheme *)typographyScheme {
  _typographyScheme = typographyScheme;
  self.titleLabel.font = _typographyScheme.body1 ?: self.titleLabel.font;
  self.detailLabel.font = _typographyScheme.body2 ?: self.detailLabel.font;
  [self adjustFontsForContentSizeCategory];
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
  UIFont *titleFont = self.titleLabel.font ?: self.typographyScheme.headline1;
  UIFont *detailFont = self.detailLabel.font ?: self.typographyScheme.subtitle1;
//  if (_mdc_adjustsFontForContentSizeCategory) {
//    titleFont =
//    [titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleHeadline
//                            scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
//    detailFont =
//    [detailFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
//                             scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
//  }
  self.titleLabel.font = titleFont;
  self.detailLabel.font = detailFont;
  [self assignFrames];
}

@end
