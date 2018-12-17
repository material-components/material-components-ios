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

#import "MDCSelfSizingStereoCellLayout.h"

static const CGFloat kVerticalMarginMin = 8.0;
static const CGFloat kVerticalMarginMax = 16.0;
static const CGFloat kHorizontalMargin = 16.0;

static const CGFloat kImageSideLengthMedium = 40.0;
static const CGFloat kImageSideLengthMax = 56.0;

@interface MDCSelfSizingStereoCellLayout ()

@property(nonatomic, assign) CGFloat cellWidth;
@property(nonatomic, assign) CGFloat calculatedHeight;
@property(nonatomic, assign) CGRect textContainerFrame;
@property(nonatomic, assign) CGRect titleLabelFrame;
@property(nonatomic, assign) CGRect detailLabelFrame;
@property(nonatomic, assign) CGRect leadingImageViewFrame;
@property(nonatomic, assign) CGRect trailingImageViewFrame;

@end

@implementation MDCSelfSizingStereoCellLayout

- (instancetype)initWithLeadingImageView:(UIImageView *)leadingImageView
                       trailingImageView:(UIImageView *)trailingImageView
                           textContainer:(UIView *)textContainer
                              titleLabel:(UILabel *)titleLabel
                             detailLabel:(UILabel *)detailLabel
                               cellWidth:(CGFloat)cellWidth {
  self = [super init];
  if (self) {
    self.cellWidth = cellWidth;
    [self assignFrameForLeadingImageView:leadingImageView];
    [self assignFrameForTrailingImageView:trailingImageView];
    [self assignFramesForTextContainer:textContainer titleLabel:titleLabel detailLabel:detailLabel];
    self.calculatedHeight = [self calculateHeight];
  }
  return self;
}

- (void)assignFrameForLeadingImageView:(UIImageView *)leadingImageView {
  CGSize size = [self sizeForImage:leadingImageView.image];
  CGFloat leadingPadding = 0;
  CGFloat topPadding = 0;
  if (!CGSizeEqualToSize(size, CGSizeZero)) {
    leadingPadding = kHorizontalMargin;
    topPadding = [self verticalMarginForImageViewOfSize:size];
  }
  CGRect rect = CGRectZero;
  rect.origin = CGPointMake(leadingPadding, topPadding);
  rect.size = size;
  self.leadingImageViewFrame = rect;
}

- (void)assignFrameForTrailingImageView:(UIImageView *)trailingImageView {
  CGSize size = [self sizeForImage:trailingImageView.image];
  CGFloat trailingPadding = 0;
  CGFloat topPadding = 0;
  if (!CGSizeEqualToSize(size, CGSizeZero)) {
    trailingPadding = kHorizontalMargin;
    topPadding = [self verticalMarginForImageViewOfSize:size];
  }
  CGFloat originX = self.cellWidth - trailingPadding - size.width;
  CGRect rect = CGRectZero;
  rect.origin = CGPointMake(originX, topPadding);
  rect.size = size;
  self.trailingImageViewFrame = rect;
}

- (void)assignFramesForTextContainer:(UIView *)textContainer
                          titleLabel:(UILabel *)titleLabel
                         detailLabel:(UILabel *)detailLabel {
  BOOL containsTitleText = titleLabel.text.length > 0;
  BOOL containsDetailText = detailLabel.text.length > 0;
  if (!containsTitleText && !containsDetailText) {
    self.titleLabelFrame = CGRectZero;
    self.detailLabelFrame = CGRectZero;
    self.textContainerFrame = CGRectZero;
    return;
  }

  BOOL hasLeadingImage = !CGRectEqualToRect(self.leadingImageViewFrame, CGRectZero);
  BOOL hasTrailingImage = !CGRectEqualToRect(self.trailingImageViewFrame, CGRectZero);
  CGFloat leadingImageViewMaxX = (hasLeadingImage ? CGRectGetMaxX(self.leadingImageViewFrame) : 0);
  CGFloat textContainerMinX = leadingImageViewMaxX + kHorizontalMargin;
  CGFloat trailingImageViewMinX =
      (hasTrailingImage ? CGRectGetMinX(self.trailingImageViewFrame) : self.cellWidth);
  CGFloat textContainerMaxX = trailingImageViewMinX - kHorizontalMargin;
  CGFloat textContainerMinY = kVerticalMarginMax;
  CGFloat textContainerWidth = textContainerMaxX - textContainerMinX;
  CGFloat textContainerHeight = 0;

  const CGSize fittingSize = CGSizeMake(textContainerWidth, CGFLOAT_MAX);

  CGSize titleSize = [titleLabel sizeThatFits:fittingSize];
  titleSize.width = textContainerWidth;
  const CGFloat titleLabelMinX = 0;
  CGFloat titleLabelMinY = 0;
  CGPoint titleOrigin = CGPointMake(titleLabelMinX, titleLabelMinY);
  CGRect titleFrame = CGRectZero;
  titleFrame.origin = titleOrigin;
  titleFrame.size = titleSize;
  self.titleLabelFrame = titleFrame;

  CGSize detailSize = [detailLabel sizeThatFits:fittingSize];
  detailSize.width = textContainerWidth;
  const CGFloat detailLabelMinX = 0;
  CGFloat detailLabelMinY = CGRectGetMaxY(titleFrame);
  if (titleLabel.text.length > 0 && detailLabel.text.length > 0) {
    detailLabelMinY += [self dynamicInterLabelVerticalPaddingWithTitleLabel:titleLabel
                                                                detailLabel:detailLabel];
  }
  CGPoint detailOrigin = CGPointMake(detailLabelMinX, detailLabelMinY);
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

  BOOL hasOnlyTitleText = containsTitleText && !containsDetailText;
  BOOL shouldVerticallyCenterTitleText = hasOnlyTitleText && hasLeadingImage;
  if (shouldVerticallyCenterTitleText) {
    CGFloat leadingImageViewCenterY = CGRectGetMidY(self.leadingImageViewFrame);
    CGFloat textContainerCenterY = CGRectGetMidY(self.textContainerFrame);
    CGFloat difference = textContainerCenterY - leadingImageViewCenterY;
    CGRect offsetTextContainerRect = CGRectOffset(self.textContainerFrame, 0, -difference);
    BOOL willExtendPastMargin = offsetTextContainerRect.origin.y < kVerticalMarginMax;
    if (!willExtendPastMargin) {
      self.textContainerFrame = offsetTextContainerRect;
    }
  }
}

- (CGFloat)calculateHeight {
  CGFloat maxHeight = 0;
  CGFloat leadingImageViewRequiredVerticalSpace = 0;
  CGFloat trailingImageViewRequiredVerticalSpace = 0;
  CGFloat textContainerRequiredVerticalSpace = 0;
  if (!CGRectEqualToRect(self.leadingImageViewFrame, CGRectZero)) {
    leadingImageViewRequiredVerticalSpace =
        CGRectGetMaxY(self.leadingImageViewFrame) +
        [self verticalMarginForImageViewOfSize:self.leadingImageViewFrame.size];
    if (leadingImageViewRequiredVerticalSpace > maxHeight) {
      maxHeight = leadingImageViewRequiredVerticalSpace;
    }
  }
  if (!CGRectEqualToRect(self.trailingImageViewFrame, CGRectZero)) {
    trailingImageViewRequiredVerticalSpace =
        CGRectGetMaxY(self.trailingImageViewFrame) +
        [self verticalMarginForImageViewOfSize:self.trailingImageViewFrame.size];
    if (trailingImageViewRequiredVerticalSpace > maxHeight) {
      maxHeight = trailingImageViewRequiredVerticalSpace;
    }
  }
  if (!CGRectEqualToRect(self.textContainerFrame, CGRectZero)) {
    textContainerRequiredVerticalSpace =
        CGRectGetMaxY(self.textContainerFrame) + kVerticalMarginMax;
    if (textContainerRequiredVerticalSpace > maxHeight) {
      maxHeight = textContainerRequiredVerticalSpace;
    }
  }
  CGFloat calculatedHeight = (CGFloat)ceil((double)maxHeight);
  return calculatedHeight;
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

- (CGFloat)verticalMarginForImageViewOfSize:(CGSize)size {
  CGFloat leadingImageHeight = size.height;
  if (leadingImageHeight > 0 && leadingImageHeight <= kImageSideLengthMedium) {
    return kVerticalMarginMax;
  } else {
    return kVerticalMarginMin;
  }
}

- (CGFloat)dynamicInterLabelVerticalPaddingWithTitleLabel:(UILabel *)titleLabel
                                              detailLabel:(UILabel *)detailLabel {
  CGFloat titleLineHeight = titleLabel.font.lineHeight;
  CGFloat detailLineHeight = detailLabel.font.lineHeight;
  CGFloat lineHeightDifference = titleLineHeight - detailLineHeight;
  CGFloat interLabelPadding = (CGFloat)round((double)(detailLineHeight - lineHeightDifference));
  return interLabelPadding;
}

@end
