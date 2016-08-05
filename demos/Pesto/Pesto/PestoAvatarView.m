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

#import "PestoAvatarView.h"
#import "PestoRemoteImageService.h"

static CGFloat kPestoAvatarViewImageInset = 3.f;
static CGFloat kPestoAvatarViewCircleLineWidth = 2.f;

@interface PestoAvatarView ()

@property(nonatomic) UIImageView *imageView;

@end

@implementation PestoAvatarView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat imageInset = kPestoAvatarViewImageInset + kPestoAvatarViewCircleLineWidth;

    _imageView =
        [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, imageInset, imageInset)];
    _imageView.layer.masksToBounds = YES;

    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    CGRect ovalRect =
        CGRectInset(self.bounds, kPestoAvatarViewCircleLineWidth, kPestoAvatarViewCircleLineWidth);
    circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:ovalRect].CGPath;
    UIColor *teal = [UIColor colorWithRed:0.0f green:0.67f blue:0.55f alpha:1.f];
    circleLayer.strokeColor = teal.CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = kPestoAvatarViewCircleLineWidth;

    [self.layer addSublayer:circleLayer];
    [self addSubview:_imageView];
    self.layer.masksToBounds = YES;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  self.imageView.layer.cornerRadius = self.imageView.bounds.size.width / 2.f;
  [CATransaction commit];
}

- (void)setAvatarImageURL:(NSURL *)avatarImageURL {
  _avatarImageURL = [avatarImageURL copy];

  __weak __typeof__(self) weakSelf = self;
  PestoRemoteImageService *imageService = [PestoRemoteImageService sharedService];
  [imageService fetchImageAndThumbnailFromURL:_avatarImageURL
                                   completion:^(UIImage *image, UIImage *thumbnailImage) {
                                     dispatch_sync(dispatch_get_main_queue(), ^{
                                       weakSelf.imageView.image = image;
                                     });
                                   }];
}

@end
