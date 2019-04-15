// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBottomNavigationLargeItemDialogView.h"

#import <CoreGraphics/CoreGraphics.h>

static const CGFloat kTitleFontScaling = 0.5;
static const CGFloat kTitleFontSize = 35;
static const CGFloat kImageViewHeightToDialogRatio = 0.35;

/**
 * Returns an image representing the given UITabBarItem. If the item has a largeContentSizeImage,
 * this function will return that image, otherwise it returns the value of the item's image
 * property. This value may be nil.
 */
static UIImage *_Nullable MDCImageForItem(UITabBarItem *_Nullable item) {
  if (!item) {
    return nil;
  }

  UIImage *image;
  if (@available(iOS 11, *)) {
    image = item.largeContentSizeImage;
  }

  return image ?: item.image;
}

@interface MDCBottomNavigationLargeItemDialogView ()

/** The view that hosts the image of the tab bar item. */
@property(nonatomic, nonnull) UIImageView *imageView;

/** The view that is set to the title of the tab bar item. */
@property(nonatomic, nonnull) UILabel *titleLabel;

@end

@implementation MDCBottomNavigationLargeItemDialogView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonInitMDCBottomNavigationLargeItemView];
  }

  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInitMDCBottomNavigationLargeItemView];
  }

  return self;
}

- (void)commonInitMDCBottomNavigationLargeItemView {
  UIColor *contentColor = [UIColor colorWithWhite:(CGFloat)0.15 alpha:(CGFloat)1];

  _imageView = [[UIImageView alloc] init];
  _imageView.tintColor = contentColor;
  _imageView.contentMode = UIViewContentModeScaleAspectFit;
  [self.contentView addSubview:_imageView];

  _titleLabel = [[UILabel alloc] init];
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _titleLabel.adjustsFontSizeToFitWidth = YES;
  _titleLabel.minimumScaleFactor = kTitleFontScaling;
  _titleLabel.textColor = contentColor;
  _titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
  _titleLabel.numberOfLines = (_imageView.image) ? 1 : 0;
  [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIEdgeInsets margins = self.layoutMargins;
  CGFloat dialogHeight = MAX(0, CGRectGetHeight(self.bounds) - margins.top - margins.bottom);
  CGFloat dialogWidth = MAX(0, CGRectGetWidth(self.bounds) - margins.left - margins.right);
  CGFloat imageHeight =
      self.imageView.image ? floor(dialogHeight * kImageViewHeightToDialogRatio) : 0;
  CGFloat titleHeight = [self titleLabelHeight];

  CGFloat totalHeight = imageHeight + titleHeight;
  CGFloat imageX = margins.left;
  CGFloat imageY = MAX(0, floor((dialogHeight - totalHeight) / 2.0)) + margins.top;

  CGFloat titleX = margins.left;
  CGFloat titleY = imageY + imageHeight;

  self.imageView.frame = CGRectMake(imageX, imageY, dialogWidth, imageHeight);
  self.titleLabel.frame = CGRectMake(titleX, titleY, dialogWidth, titleHeight);
}

- (void)updateWithTabBarItem:(UITabBarItem *)item {
  UIImage *image = MDCImageForItem(item);
  self.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.titleLabel.text = item.title;
  [self setNeedsLayout];
}

#pragma mark - Private Methods

/** Returns the desired height of the title label. */
- (CGFloat)titleLabelHeight {
  if (self.titleLabel.text.length == 0) {
    return 0;
  } else if (self.imageView.image) {
    return self.titleLabel.intrinsicContentSize.height;
  }

  return MAX(0, CGRectGetHeight(self.bounds) - self.layoutMargins.top - self.layoutMargins.bottom);
}

@end
