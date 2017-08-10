/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCollectionViewTextCell.h"

#import "MaterialMath.h"
#import "MaterialRTL.h"
#import "MaterialTypography.h"

#include <tgmath.h>

// Default cell heights.
const CGFloat MDCCellDefaultOneLineHeight = 48.0f;
const CGFloat MDCCellDefaultOneLineWithAvatarHeight = 56.0f;
const CGFloat MDCCellDefaultTwoLineHeight = 72.0f;
const CGFloat MDCCellDefaultThreeLineHeight = 88.0f;

// Default cell fonts.
static inline UIFont *CellDefaultTextFont(void) {
  return [MDCTypography subheadFont];
}

static inline UIFont *CellDefaultDetailTextFont(void) {
  return [MDCTypography body1Font];
}

// Default cell font opacity.
static inline CGFloat CellDefaultTextOpacity(void) {
  return [MDCTypography subheadFontOpacity];
}

static inline CGFloat CellDefaultDetailTextFontOpacity(void) {
  return [MDCTypography captionFontOpacity];
}

// Cell padding top/bottom.
static const CGFloat kCellTwoLinePaddingTop = 20;
static const CGFloat kCellTwoLinePaddingBottom = 20;
static const CGFloat kCellThreeLinePaddingTop = 16;
static const CGFloat kCellThreeLinePaddingBottom = 20;
// Cell padding leading/trailing.
static const CGFloat kCellTextNoImagePaddingLeading = 16;
static const CGFloat kCellTextNoImagePaddingTrailing = 16;
static const CGFloat kCellTextWithImagePaddingLeading = 72;
// Cell image view padding.
static const CGFloat kCellImagePaddingLeading = 16;

// Returns the closest pixel-aligned value higher than |value|, taking the scale factor into
// account. At a scale of 1, equivalent to Ceil().
static inline CGFloat AlignValueToUpperPixel(CGFloat value) {
  CGFloat scale = [[UIScreen mainScreen] scale];
  return (CGFloat)MDCCeil(value * scale) / scale;
}

// Returns the closest pixel-aligned value lower than |value|, taking the scale factor into
// account. At a scale of 1, equivalent to Floor().
static inline CGFloat AlignValueToLowerPixel(CGFloat value) {
  CGFloat scale = [[UIScreen mainScreen] scale];
  return (CGFloat)MDCFloor(value * scale) / scale;
}

// Returns the rect resulting from applying AlignSizeToUpperPixel to the rect size.
static inline CGRect AlignRectToUpperPixel(CGRect rect) {
  rect = CGRectStandardize(rect);
  return CGRectMake(AlignValueToLowerPixel(rect.origin.x), AlignValueToLowerPixel(rect.origin.y),
                    AlignValueToUpperPixel(rect.size.width),
                    AlignValueToUpperPixel(rect.size.height));
}

@implementation MDCCollectionViewTextCell {
  UIView *_contentWrapper;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionViewTextCellInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCCollectionViewTextCellInit];
  }
  return self;
}

- (void)resetMDCCollectionViewTextCellLabelProperties {
  _textLabel.font = CellDefaultTextFont();
  _textLabel.textColor = [UIColor colorWithWhite:0 alpha:CellDefaultTextOpacity()];
  _textLabel.shadowColor = nil;
  _textLabel.shadowOffset = CGSizeZero;
  _textLabel.textAlignment = NSTextAlignmentNatural;
  _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _textLabel.numberOfLines = 1;

  _detailTextLabel.font = CellDefaultDetailTextFont();
  _detailTextLabel.textColor = [UIColor colorWithWhite:0 alpha:CellDefaultDetailTextFontOpacity()];
  _detailTextLabel.shadowColor = nil;
  _detailTextLabel.shadowOffset = CGSizeZero;
  _detailTextLabel.textAlignment = NSTextAlignmentNatural;
  _detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _detailTextLabel.numberOfLines = 1;
}

- (void)commonMDCCollectionViewTextCellInit {
  _contentWrapper = [[UIView alloc] initWithFrame:self.contentView.bounds];
  _contentWrapper.autoresizingMask =
      UIViewAutoresizingFlexibleWidth |
      MDCAutoresizingFlexibleTrailingMargin(self.mdc_effectiveUserInterfaceLayoutDirection);
  _contentWrapper.clipsToBounds = YES;
  [self.contentView addSubview:_contentWrapper];

  // Text label.
  _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _textLabel.autoresizingMask =
      MDCAutoresizingFlexibleTrailingMargin(self.mdc_effectiveUserInterfaceLayoutDirection);

  // Detail text label.
  _detailTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _detailTextLabel.autoresizingMask =
      MDCAutoresizingFlexibleTrailingMargin(self.mdc_effectiveUserInterfaceLayoutDirection);

  [self resetMDCCollectionViewTextCellLabelProperties];

  [_contentWrapper addSubview:_textLabel];
  [_contentWrapper addSubview:_detailTextLabel];

  // Image view.
  _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _imageView.autoresizingMask =
      MDCAutoresizingFlexibleTrailingMargin(self.mdc_effectiveUserInterfaceLayoutDirection);
  [self.contentView addSubview:_imageView];
}

#pragma mark - Layout

- (void)prepareForReuse {
  self.imageView.image = nil;
  self.textLabel.text = nil;
  self.detailTextLabel.text = nil;

  [self resetMDCCollectionViewTextCellLabelProperties];

  [super prepareForReuse];
  [self setNeedsLayout];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self applyMetrics];
}

- (CGRect)contentWrapperFrame {
  CGFloat leadingPadding =
      _imageView.image ? kCellTextWithImagePaddingLeading : kCellTextNoImagePaddingLeading;
  CGFloat trailingPadding = kCellTextNoImagePaddingTrailing;
  UIEdgeInsets insets = MDCInsetsMakeWithLayoutDirection(
      0, leadingPadding, 0, trailingPadding, self.mdc_effectiveUserInterfaceLayoutDirection);
  return UIEdgeInsetsInsetRect(self.contentView.bounds, insets);
}

- (void)applyMetrics {
  // Set content wrapper frame.
  _contentWrapper.frame = [self contentWrapperFrame];
  CGFloat boundsHeight = CGRectGetHeight(_contentWrapper.bounds);

  // Image layout.
  [_imageView sizeToFit];
  CGRect imageFrame = _imageView.frame;
  imageFrame.origin.x = kCellImagePaddingLeading;
  imageFrame.origin.y =
      (CGRectGetHeight(self.contentView.frame) / 2) - (imageFrame.size.height / 2);

  // Text layout and line count
  CGRect textFrame = CGRectZero;
  textFrame.size = [self frameSizeForLabel:_textLabel];
  NSInteger textLines = (NSInteger)floor(textFrame.size.height / _textLabel.font.lineHeight);
  CGRect detailFrame = CGRectZero;
  detailFrame.size = [self frameSizeForLabel:_detailTextLabel];
  NSInteger detailsLines =
      (NSInteger)floor(detailFrame.size.height / _detailTextLabel.font.lineHeight);
  NSInteger numberOfAllVisibleTextLines = textLines + detailsLines;

  // Adjust the labels X origin.
  textFrame.origin.x = 0;
  detailFrame.origin.x = 0;

  // Adjust the labels Y origin.
  if (numberOfAllVisibleTextLines == 1) {
    // Alignment for single line.
    textFrame.origin.y = (boundsHeight / 2) - (textFrame.size.height / 2);
    detailFrame.origin.y = (boundsHeight / 2) - (detailFrame.size.height / 2);

  } else if (numberOfAllVisibleTextLines == 2) {
    if (!CGRectIsEmpty(textFrame) && !CGRectIsEmpty(detailFrame)) {
      // Alignment for two lines.
      textFrame.origin.y =
          kCellTwoLinePaddingTop + _textLabel.font.ascender - textFrame.size.height;
      detailFrame.origin.y = boundsHeight - kCellTwoLinePaddingBottom - detailFrame.size.height -
                             _detailTextLabel.font.descender;
    } else {
      // Since single wrapped label, just center.
      textFrame.origin.y = (boundsHeight / 2) - (textFrame.size.height / 2);
      detailFrame.origin.y = (boundsHeight / 2) - (detailFrame.size.height / 2);
    }

  } else if (numberOfAllVisibleTextLines == 3) {
    if (!CGRectIsEmpty(textFrame) && !CGRectIsEmpty(detailFrame)) {
      // Alignment for three lines.
      textFrame.origin.y =
          kCellThreeLinePaddingTop + _textLabel.font.ascender - _textLabel.font.lineHeight;
      detailFrame.origin.y = boundsHeight - kCellThreeLinePaddingBottom - detailFrame.size.height -
                             _detailTextLabel.font.descender;
      imageFrame.origin.y = kCellThreeLinePaddingTop;
    } else {
      // Since single wrapped label, just center.
      textFrame.origin.y = (boundsHeight / 2) - (textFrame.size.height / 2);
      detailFrame.origin.y = (boundsHeight / 2) - (detailFrame.size.height / 2);
    }
  }
  _textLabel.frame =
      MDCRectFlippedForRTL(AlignRectToUpperPixel(textFrame), CGRectGetWidth(_contentWrapper.bounds),
                           self.mdc_effectiveUserInterfaceLayoutDirection);
  _detailTextLabel.frame = MDCRectFlippedForRTL(AlignRectToUpperPixel(detailFrame),
                                                CGRectGetWidth(_contentWrapper.bounds),
                                                self.mdc_effectiveUserInterfaceLayoutDirection);
  _imageView.frame = MDCRectFlippedForRTL(AlignRectToUpperPixel(imageFrame),
                                          CGRectGetWidth(self.contentView.bounds),
                                          self.mdc_effectiveUserInterfaceLayoutDirection);
}

- (CGSize)frameSizeForLabel:(UILabel *)label {
  CGFloat width = CGRectGetWidth(_contentWrapper.bounds);
  CGFloat height =
      [label textRectForBounds:_contentWrapper.bounds limitedToNumberOfLines:label.numberOfLines]
          .size.height;
  return CGSizeMake(width, height);
}

@end
