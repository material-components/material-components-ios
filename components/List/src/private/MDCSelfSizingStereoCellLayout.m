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
#import "MDCSelfSizingStereoCellImageViewVerticalPosition.h"

static const CGFloat kVerticalMarginMin = 8.0;
static const CGFloat kVerticalMarginMax = 16.0;
static const CGFloat kHorizontalMargin = 16.0;

static const CGFloat kImageSideLengthMedium = 40.0;
static const CGFloat kImageSideLengthMax = 56.0;
static const CGFloat kInterLabelVerticalPadding = 6.0;

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
        leadingImageViewVerticalPosition:
            (MDCSelfSizingStereoCellImageViewVerticalPosition)leadingImageViewVerticalPosition
                       trailingImageView:(UIImageView *)trailingImageView
       trailingImageViewVerticalPosition:
           (MDCSelfSizingStereoCellImageViewVerticalPosition)trailingImageViewVerticalPosition
                           textContainer:(UIView *)textContainer
                              titleLabel:(UILabel *)titleLabel
                             detailLabel:(UILabel *)detailLabel
                               cellWidth:(CGFloat)cellWidth {
  self = [super init];
  if (self) {
    [self calculateLayoutWithLeadingImageView:leadingImageView
             leadingImageViewVerticalPosition:leadingImageViewVerticalPosition
                            trailingImageView:trailingImageView
            trailingImageViewVerticalPosition:trailingImageViewVerticalPosition
                                textContainer:textContainer
                                   titleLabel:titleLabel
                                  detailLabel:detailLabel
                                    cellWidth:cellWidth];
  }
  return self;
}

/**
 This method calculates the frames for the subviews in the cell. It starts by determining the
 leading and trailing image view frames. Then it uses those frames to determine the frame of the
 title label, detail label, and the view that contains them. Then, it calculates the height of the
 cell. Finally, it vertically centers the iamge views if necessary.
 */
- (void)calculateLayoutWithLeadingImageView:(UIImageView *)leadingImageView
           leadingImageViewVerticalPosition:
               (MDCSelfSizingStereoCellImageViewVerticalPosition)leadingImageViewVerticalPosition
                          trailingImageView:(UIImageView *)trailingImageView
          trailingImageViewVerticalPosition:
              (MDCSelfSizingStereoCellImageViewVerticalPosition)trailingImageViewVerticalPosition
                              textContainer:(UIView *)textContainer
                                 titleLabel:(UILabel *)titleLabel
                                detailLabel:(UILabel *)detailLabel
                                  cellWidth:(CGFloat)cellWidth {
  // Initially assume an image view frame of .zero.
  CGRect leadingImageViewFrame = CGRectZero;
  CGSize leadingImageViewSize = [self sizeForImage:leadingImageView.image];
  BOOL displaysLeadingImageView = !CGSizeEqualToSize(leadingImageViewSize, CGSizeZero);
  if (displaysLeadingImageView) {
    // Calculate non-zero image view frame because image exists and has a valid size.
    CGFloat leadingImageViewMinX = kHorizontalMargin;
    CGFloat leadingImageViewMinY = [self verticalMarginForImageViewOfSize:leadingImageViewSize];
    leadingImageViewFrame = CGRectMake(leadingImageViewMinX, leadingImageViewMinY,
                                       leadingImageViewSize.width, leadingImageViewSize.height);
  }

  // Initially assume an image view frame of .zero.
  CGRect trailingImageViewFrame = CGRectZero;
  CGSize trailingImageViewSize = [self sizeForImage:trailingImageView.image];
  BOOL displaysTrailingImageView = !CGSizeEqualToSize(trailingImageViewSize, CGSizeZero);
  if (displaysTrailingImageView) {
    // Calculate non-zero image view frame because image exists and has a valid size.
    CGFloat trailingImageViewMinX = cellWidth - kHorizontalMargin - trailingImageViewSize.width;
    CGFloat trailingImageViewMinY = [self verticalMarginForImageViewOfSize:trailingImageViewSize];
    trailingImageViewFrame = CGRectMake(trailingImageViewMinX, trailingImageViewMinY,
                                        trailingImageViewSize.width, trailingImageViewSize.height);
  }

  // Initialize text-related view frame as .zero.
  CGRect titleLabelFrame = CGRectZero;
  CGRect detailLabelFrame = CGRectZero;
  CGRect textContainerFrame = CGRectZero;

  BOOL containsTitleText = titleLabel.text.length > 0;
  BOOL containsDetailText = detailLabel.text.length > 0;
  if (containsTitleText || containsDetailText) {
    // Determine min x of text region
    CGFloat textContainerMinX = kHorizontalMargin;
    if (displaysLeadingImageView) {
      textContainerMinX = CGRectGetMaxX(leadingImageViewFrame) + kHorizontalMargin;
    }

    // Determine max x of text region
    CGFloat textContainerMaxX = cellWidth - kHorizontalMargin;
    if (displaysTrailingImageView) {
      textContainerMaxX = CGRectGetMinX(trailingImageViewFrame) - kHorizontalMargin;
    }

    // Begin determining the frame of the view that contains the title and detail labels.
    // The final frame of this view must be calculated further down because it depends on the frames
    // of the labels it contains.
    CGFloat textContainerMinY = kVerticalMarginMax;
    CGFloat textContainerWidth = textContainerMaxX - textContainerMinX;
    CGFloat textContainerHeight = 0;

    CGSize fittingSize = CGSizeMake(textContainerWidth, CGFLOAT_MAX);

    // Determine title label size and then frame within container view
    CGSize titleSize = [titleLabel sizeThatFits:fittingSize];
    titleSize.width = textContainerWidth;
    CGFloat titleLabelMinX = 0;
    CGFloat titleLabelMinY = 0;
    CGPoint titleOrigin = CGPointMake(titleLabelMinX, titleLabelMinY);
    titleLabelFrame.origin = titleOrigin;
    titleLabelFrame.size = titleSize;

    // Determine detail label size and then frame within container view
    CGSize detailSize = [detailLabel sizeThatFits:fittingSize];
    detailSize.width = textContainerWidth;
    CGFloat detailLabelMinX = 0;
    CGFloat detailLabelMinY = CGRectGetMaxY(titleLabelFrame);
    if (titleLabel.text.length > 0 && detailLabel.text.length > 0) {
      detailLabelMinY += kInterLabelVerticalPadding;
    }
    CGPoint detailOrigin = CGPointMake(detailLabelMinX, detailLabelMinY);
    detailLabelFrame.origin = detailOrigin;
    detailLabelFrame.size = detailSize;

    // Determine title and detail label container view height and then frame
    textContainerHeight = CGRectGetMaxY(detailLabelFrame);

    CGPoint textContainerOrigin = CGPointMake(textContainerMinX, textContainerMinY);
    CGSize textContainerSize = CGSizeMake(textContainerWidth, textContainerHeight);
    textContainerFrame.origin = textContainerOrigin;
    textContainerFrame.size = textContainerSize;

    // Usually the image views are positioned at the top. However, this looks funny if there is only
    // one line of text. If there is only one line of text, make it have the same center Y as the
    // image views.
    BOOL hasOnlyTitleText = containsTitleText && !containsDetailText;
    BOOL shouldVerticallyCenterTitleText = hasOnlyTitleText && displaysLeadingImageView;
    if (shouldVerticallyCenterTitleText) {
      CGFloat leadingImageViewCenterY = CGRectGetMidY(leadingImageViewFrame);
      CGFloat textContainerCenterY = CGRectGetMidY(textContainerFrame);
      CGFloat difference = textContainerCenterY - leadingImageViewCenterY;
      CGRect offsetTextContainerRect = CGRectOffset(textContainerFrame, 0, -difference);
      BOOL willExtendPastMargin = offsetTextContainerRect.origin.y < kVerticalMarginMax;
      if (!willExtendPastMargin) {
        textContainerFrame = offsetTextContainerRect;
      }
    }
  }

  // Calculate the height of the cell.
  CGFloat calculatedHeight = [self calculateHeightWithLeadingImageViewFrame:leadingImageViewFrame
                                                     trailingImageViewFrame:trailingImageViewFrame
                                                         textContainerFrame:textContainerFrame];

  // Center the image views if the user has specified that they want the image views centered.
  if (displaysLeadingImageView &&
      leadingImageViewVerticalPosition == MDCSelfSizingStereoCellImageViewVerticalPositionCenter) {
    CGFloat verticallyCenteredLeadingImageViewMinY =
        (0.5f * calculatedHeight) - (0.5f * leadingImageViewSize.height);
    leadingImageViewFrame =
        CGRectMake(CGRectGetMinX(leadingImageViewFrame), verticallyCenteredLeadingImageViewMinY,
                   leadingImageViewSize.width, leadingImageViewSize.height);
  }

  if (displaysTrailingImageView &&
      trailingImageViewVerticalPosition == MDCSelfSizingStereoCellImageViewVerticalPositionCenter) {
    CGFloat verticallyCenteredTrailingImageViewMinY =
        (0.5f * calculatedHeight) - (0.5f * trailingImageViewSize.height);
    trailingImageViewFrame =
        CGRectMake(CGRectGetMinX(trailingImageViewFrame), verticallyCenteredTrailingImageViewMinY,
                   trailingImageViewSize.width, trailingImageViewSize.height);
  }

  // Set the properties to be read by the cell.
  self.textContainerFrame = textContainerFrame;
  self.titleLabelFrame = titleLabelFrame;
  self.detailLabelFrame = detailLabelFrame;
  self.cellWidth = cellWidth;
  self.leadingImageViewFrame = leadingImageViewFrame;
  self.trailingImageViewFrame = trailingImageViewFrame;
  self.calculatedHeight = calculatedHeight;
}

- (CGFloat)calculateHeightWithLeadingImageViewFrame:(CGRect)leadingImageViewFrame
                             trailingImageViewFrame:(CGRect)trailingImageViewFrame
                                 textContainerFrame:(CGRect)textContainerFrame {
  CGFloat maxHeight = 0;
  CGFloat leadingImageViewRequiredVerticalSpace = 0;
  CGFloat trailingImageViewRequiredVerticalSpace = 0;
  CGFloat textContainerRequiredVerticalSpace = 0;
  if (!CGRectEqualToRect(leadingImageViewFrame, CGRectZero)) {
    leadingImageViewRequiredVerticalSpace =
        CGRectGetMaxY(leadingImageViewFrame) +
        [self verticalMarginForImageViewOfSize:leadingImageViewFrame.size];
    if (leadingImageViewRequiredVerticalSpace > maxHeight) {
      maxHeight = leadingImageViewRequiredVerticalSpace;
    }
  }
  if (!CGRectEqualToRect(trailingImageViewFrame, CGRectZero)) {
    trailingImageViewRequiredVerticalSpace =
        CGRectGetMaxY(trailingImageViewFrame) +
        [self verticalMarginForImageViewOfSize:trailingImageViewFrame.size];
    if (trailingImageViewRequiredVerticalSpace > maxHeight) {
      maxHeight = trailingImageViewRequiredVerticalSpace;
    }
  }
  if (!CGRectEqualToRect(textContainerFrame, CGRectZero)) {
    textContainerRequiredVerticalSpace = CGRectGetMaxY(textContainerFrame) + kVerticalMarginMax;
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
  if (size.height == 0) {
    return 0;
  } else if (size.height > 0 && size.height <= kImageSideLengthMedium) {
    return kVerticalMarginMax;
  } else {
    return kVerticalMarginMin;
  }
}

@end
