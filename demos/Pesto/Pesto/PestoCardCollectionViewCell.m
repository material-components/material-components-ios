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

#import "PestoCardCollectionViewCell.h"
#import "PestoRemoteImageService.h"

#import "PestoIcons/PestoIconFish.h"
#import "PestoIcons/PestoIconMain.h"
#import "PestoIcons/PestoIconMeat.h"
#import "PestoIcons/PestoIconSpicy.h"
#import "PestoIcons/PestoIconTimer.h"
#import "PestoIcons/PestoIconVeggie.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

static const CGFloat kPestoCardPadding = 15.f;
static const CGFloat kPestoCardIconSize = 72.f;

@interface PestoCardCollectionViewCell ()

@property(nonatomic) UIImageView *iconImageView;
@property(nonatomic) UIImageView *thumbnailImageView;
@property(nonatomic) UILabel *authorLabel;
@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) UIView *cellView;
@property(nonatomic) PestoRemoteImageService *imageService;

@end

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    _imageService = [PestoRemoteImageService sharedService];
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  _cellView = [[UIView alloc] initWithFrame:self.bounds];
  _cellView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _cellView.backgroundColor = [UIColor whiteColor];
  _cellView.clipsToBounds = YES;
  [self addSubview:_cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect =
      CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - kPestoCardIconSize);
  _thumbnailImageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  _thumbnailImageView.backgroundColor = [UIColor lightGrayColor];
  _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
  _thumbnailImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _thumbnailImageView.clipsToBounds = YES;
  [_cellView addSubview:_thumbnailImageView];

  CGRect iconImageViewFrame = CGRectMake(0, self.frame.size.height - kPestoCardIconSize,
                                         kPestoCardIconSize, kPestoCardIconSize);
  _iconImageView = [[UIImageView alloc] initWithFrame:iconImageViewFrame];
  _iconImageView.contentMode = UIViewContentModeCenter;
  _iconImageView.alpha = 0.87f;
  [_cellView addSubview:_iconImageView];

  _authorLabel = [[UILabel alloc] init];
  _authorLabel.font = [MDCTypography captionFont];
  _authorLabel.alpha = [MDCTypography captionFontOpacity];
  _authorLabel.textColor = [UIColor colorWithWhite:0.5f alpha:1.f];
  _authorLabel.frame = CGRectMake(
      kPestoCardIconSize, self.frame.size.height - _authorLabel.font.pointSize - kPestoCardPadding,
      self.frame.size.width - iconImageViewFrame.size.width, self.authorLabel.font.pointSize + 2.f);
  [_cellView addSubview:_authorLabel];

  _titleLabel = [[UILabel alloc] init];
  _titleLabel.font = [MDCTypography headlineFont];
  _titleLabel.alpha = [MDCTypography headlineFontOpacity];
  _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.87f];
  _titleLabel.frame = CGRectMake(
      kPestoCardIconSize,
      _authorLabel.frame.origin.y - _titleLabel.font.pointSize - kPestoCardPadding / 2.f,
      self.frame.size.width - iconImageViewFrame.size.width, _titleLabel.font.pointSize + 2.f);
  [_cellView addSubview:_titleLabel];
}

- (void)populateContentWithTitle:(NSString *)title
                          author:(NSString *)author
                        imageURL:(NSURL *)imageURL
                        iconName:(NSString *)iconName {
  self.title = title;
  self.titleLabel.text = title;
  self.authorLabel.text = author;
  self.iconImageName = iconName;

  CGRect iconFrame = CGRectMake(0, 0, 32, 32);
  UIImage *icon = [PestoIconFish drawTileImage:iconFrame];
  if ([iconName isEqualToString:@"Main"]) {
    icon = [PestoIconMain drawTileImage:iconFrame];
  } else if ([iconName isEqualToString:@"Meat"]) {
    icon = [PestoIconMeat drawTileImage:iconFrame];
  } else if ([iconName isEqualToString:@"Spicy"]) {
    icon = [PestoIconSpicy drawTileImage:iconFrame];
  } else if ([iconName isEqualToString:@"Timer"]) {
    icon = [PestoIconTimer drawTileImage:iconFrame];
  } else if ([iconName isEqualToString:@"Veggie"]) {
    icon = [PestoIconVeggie drawTileImage:iconFrame];
  }

  self.iconImageView.image = icon;
  __weak __typeof__(self) weakSelf = self;
  [self.imageService fetchImageAndThumbnailFromURL:imageURL
                                        completion:^(UIImage *image, UIImage *thumbnailImage) {
                                          [weakSelf setImage:image];
                                          dispatch_sync(dispatch_get_main_queue(), ^{
                                            [weakSelf.thumbnailImageView setImage:thumbnailImage];
                                          });
                                        }];
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.title = nil;
  self.image = nil;
  [self.thumbnailImageView setImage:nil];
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
