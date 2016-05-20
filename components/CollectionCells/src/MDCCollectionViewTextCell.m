/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCCollectionViewTextCell.h"

#import "MaterialTypography.h"

#import <tgmath.h>

// Default cell heights.
const CGFloat MDCCellDefaultOneLineHeight = 48.0f;
const CGFloat MDCCellDefaultOneLineWithAvatarHeight = 56.0f;
const CGFloat MDCCellDefaultTwoLineHeight = 72.0f;
const CGFloat MDCCellDefaultThreeLineHeight = 88.0f;

// Default cell fonts.
#define kCellDefaultTextFont [MDCTypography subheadFont]
#define kCellDefaultDetailTextFont [MDCTypography body1Font]

// Default cell font opacity.
#define kCellDefaultTextOpacity [MDCTypography subheadFontOpacity]
#define kCellDefaultDetailTextFontOpacity [MDCTypography captionFontOpacity]

// Cell padding top/bottom.
static const CGFloat kCellTwoLinePaddingTop = 20;
static const CGFloat kCellTwoLinePaddingBottom = 20;
static const CGFloat kCellThreeLinePaddingTop = 16;
static const CGFloat kCellThreeLinePaddingBottom = 20;
// Cell padding left/right.
static const CGFloat kCellTextNoImagePaddingLeft = 16;
static const CGFloat kCellTextNoImagePaddingRight = 16;
static const CGFloat kCellTextWithImagePaddingLeft = 72;
// Cell image view padding.
static const CGFloat kCellImagePaddingLeft = 16;

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

- (void)commonMDCCollectionViewTextCellInit {
  _contentWrapper = [[UIView alloc] initWithFrame:self.contentView.bounds];
  _contentWrapper.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _contentWrapper.clipsToBounds = YES;
  [self.contentView addSubview:_contentWrapper];

  // Text label.
  _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _textLabel.font = kCellDefaultTextFont;
  _textLabel.textColor = [UIColor colorWithWhite:0 alpha:kCellDefaultTextOpacity];
  _textLabel.shadowColor = nil;
  _textLabel.shadowOffset = CGSizeZero;
  _textLabel.textAlignment = NSTextAlignmentLeft;
  _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  [_contentWrapper addSubview:_textLabel];

  // Detail text label.
  _detailTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _detailTextLabel.font = kCellDefaultDetailTextFont;
  _detailTextLabel.textColor = [UIColor colorWithWhite:0 alpha:kCellDefaultDetailTextFontOpacity];
  _detailTextLabel.shadowColor = nil;
  _detailTextLabel.shadowOffset = CGSizeZero;
  _detailTextLabel.textAlignment = NSTextAlignmentLeft;
  _detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  [_contentWrapper addSubview:_detailTextLabel];

  // Image view.
  _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self.contentView addSubview:_imageView];
}

#pragma mark - Layout

- (void)prepareForReuse {
  [super prepareForReuse];
  [self setNeedsLayout];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self applyMetrics];
}

- (CGRect)contentWrapperFrame {
  CGFloat leftPadding =
      _imageView.image ? kCellTextWithImagePaddingLeft : kCellTextNoImagePaddingLeft;
  CGFloat rightPadding = kCellTextNoImagePaddingRight;
  if (self.accessoryView && !self.isEditing) {
    rightPadding += CGRectGetWidth(self.accessoryView.bounds) + kCellTextNoImagePaddingRight;
  }
  return UIEdgeInsetsInsetRect(self.contentView.bounds,
                               UIEdgeInsetsMake(0, leftPadding, 0, rightPadding));
}

- (void)applyMetrics {
  // Set content wrapper frame.
  _contentWrapper.frame = [self contentWrapperFrame];
  CGFloat boundsHeight = CGRectGetHeight(_contentWrapper.bounds);

  // Image layout.
  [_imageView sizeToFit];
  CGRect imageFrame = _imageView.frame;
  imageFrame.origin.x = kCellImagePaddingLeft;
  imageFrame.origin.y =
      (CGRectGetHeight(self.contentView.frame) / 2) - (imageFrame.size.height / 2);

  // Text layout.
  CGRect textFrame = CGRectZero;
  textFrame.size = [self frameSizeForLabel:_textLabel];
  CGRect detailFrame = CGRectZero;
  detailFrame.size = [self frameSizeForLabel:_detailTextLabel];

  if ([self numberOfAllVisibleTextLines] == 1) {
    // Alignment for single line.
    textFrame.origin.y = (boundsHeight / 2) - (textFrame.size.height / 2);
    detailFrame.origin.y = (boundsHeight / 2) - (detailFrame.size.height / 2);

  } else if ([self numberOfAllVisibleTextLines] == 2) {
    if (!CGRectIsEmpty(textFrame) && !CGRectIsEmpty(detailFrame)) {
      // Alignment for two lines.
      textFrame.origin.y =
          kCellTwoLinePaddingTop + _textLabel.font.ascender - textFrame.size.height;
      detailFrame.origin.y =
          boundsHeight - kCellTwoLinePaddingBottom -
          detailFrame.size.height - _detailTextLabel.font.descender;
    } else {
      // Since single wrapped label, just center.
      textFrame.origin.y = (boundsHeight / 2) - (textFrame.size.height / 2);
      detailFrame.origin.y = (boundsHeight / 2) - (detailFrame.size.height / 2);
    }

  } else if ([self numberOfAllVisibleTextLines] == 3) {
    if (!CGRectIsEmpty(textFrame) && !CGRectIsEmpty(detailFrame)) {
      // Alignment for three lines.
      textFrame.origin.y =
          kCellThreeLinePaddingTop + _textLabel.font.ascender - _textLabel.font.lineHeight;
      detailFrame.origin.y =
          boundsHeight - kCellThreeLinePaddingBottom -
          detailFrame.size.height - _detailTextLabel.font.descender;
      imageFrame.origin.y = kCellThreeLinePaddingTop;
    } else {
      // Since single wrapped label, just center.
      textFrame.origin.y = (boundsHeight / 2) - (textFrame.size.height / 2);
      detailFrame.origin.y = (boundsHeight / 2) - (detailFrame.size.height / 2);
    }
  }
  _textLabel.frame = textFrame;
  _detailTextLabel.frame = detailFrame;
  _imageView.frame = imageFrame;
}

- (NSInteger)numberOfAllVisibleTextLines {
  return [self numberOfLinesForLabel:_textLabel] + [self numberOfLinesForLabel:_detailTextLabel];
}

- (NSInteger)numberOfLinesForLabel:(UILabel *)label {
  CGSize size = [self frameSizeForLabel:label];
  return (NSInteger)floor(size.height / label.font.lineHeight);
}

- (CGSize)frameSizeForLabel:(UILabel *)label {
  CGFloat width = MIN(CGRectGetWidth(_contentWrapper.bounds),
                      [label.text sizeWithAttributes:@{NSFontAttributeName : label.font}].width);
  CGFloat height = [label textRectForBounds:_contentWrapper.bounds
                       limitedToNumberOfLines:label.numberOfLines]
                       .size.height;
  return CGSizeMake(width, height);
}

@end
