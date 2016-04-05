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

#import "PestoSideView.h"
#import "PestoAvatarView.h"
#import "PestoRemoteImageService.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

static CGFloat kPestoSideViewAnimationDuration = 0.2f;
static CGFloat kPestoSideViewAvatarDim = 70.f;
static CGFloat kPestoSideViewCollectionViewInset = 5.f;
static CGFloat kPestoSideViewHideThreshhold = 64.f;
static CGFloat kPestoSideViewUserItemHeight = 200.f;
static CGFloat kPestoSideViewWidth = 240.f;
static NSString *const kPestoSideViewWidthBaseURL =
    @"https://www.gstatic.com/angular/material-adaptive/pesto/";

@interface PestoSideViewCollectionViewCell : UICollectionViewCell

@property(nonatomic, copy) NSString *title;
@property(nonatomic) UIColor *titleColor;
@property(nonatomic) UILabel *titleLabel;

@end

@implementation PestoSideViewCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _titleColor = [UIColor lightGrayColor];
    self.backgroundColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.font = [MDCTypography body1Font];
    _titleLabel.alpha = [MDCTypography body1FontOpacity];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = _titleColor;
    [self addSubview:_titleLabel];
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.titleLabel.text = nil;
}

- (void)setTitle:(NSString *)title {
  _title = title;
  self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
  _titleColor = titleColor;
  self.titleLabel.textColor = _titleColor;
}

@end

@class PestoSideContentView;
@protocol PestoSideContentViewDelegate <NSObject>

@optional
- (void)sideContentView:(PestoSideContentView *)sideContentView
 didSelectItemWithTitle:(NSString *)title;

@end

@interface PestoSideContentView : UIView <UICollectionViewDataSource,
                                          UICollectionViewDelegateFlowLayout>

@property(nonatomic) NSArray *titles;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) UICollectionView *collectionView;
@property(weak, nonatomic) id<PestoSideContentViewDelegate> delegate;

@end

@implementation PestoSideContentView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  CGRect avatarRect = CGRectMake(0, 0, kPestoSideViewAvatarDim, kPestoSideViewAvatarDim);
  NSURL *avatarURL = [NSURL URLWithString:[kPestoSideViewWidthBaseURL
                                              stringByAppendingString:@"avatar.jpg"]];
  PestoAvatarView *avatarView = [[PestoAvatarView alloc] initWithFrame:avatarRect];
  avatarView.avatarImageURL = avatarURL;
  avatarView.center = CGPointMake(self.bounds.size.width / 2.f,
                                  kPestoSideViewUserItemHeight / 2.f - 12.f);
  [self addSubview:avatarView];

  CGRect nameRect = CGRectMake(0,
                               110.f,
                               self.bounds.size.width,
                               kPestoSideViewAvatarDim);
  UILabel *name = [[UILabel alloc] initWithFrame:nameRect];
  name.text = @"Jonathan";
  name.font = [MDCTypography titleFont];
  name.alpha = [MDCTypography titleFontOpacity];
  name.textAlignment = NSTextAlignmentCenter;
  [self addSubview:name];

  CGFloat lightHeight = 0.5f;
  UIView *lineView =
      [[UIView alloc] initWithFrame:CGRectMake(15.f,
                                               180.f,
                                               self.bounds.size.width - 30.f,
                                               lightHeight)];
  [lineView.heightAnchor constraintEqualToConstant:lightHeight].active = YES;
  lineView.backgroundColor = [UIColor lightGrayColor];
  [self addSubview:lineView];

  _titles = @[ @"Home", @"Favorite", @"Saved", @"Trending", @"Settings" ];

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoSideViewCollectionViewInset,
                                           kPestoSideViewCollectionViewInset,
                                           kPestoSideViewCollectionViewInset,
                                           kPestoSideViewCollectionViewInset)];
  CGRect collectionViewFrame = CGRectMake(0,
                                          kPestoSideViewUserItemHeight,
                                          self.bounds.size.width,
                                          self.bounds.size.height);
  _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  _collectionView.backgroundColor = [UIColor whiteColor];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:_collectionView];
  [_collectionView registerClass:[PestoSideViewCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoSideViewCollectionViewCell"];
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  _collectionView.delegate = self;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return (NSInteger)self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoSideViewCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoSideViewCollectionViewCell"
                                                forIndexPath:indexPath];
  NSInteger itemNum = indexPath.row;
  cell.title = self.titles[(NSUInteger)itemNum];
  // Show settings item as enabled.
  if ([cell.title isEqualToString:@"Settings"]) {
    cell.titleColor = [UIColor blackColor];
  }
  [cell setNeedsLayout];
  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (self.delegate &&
      [self.delegate respondsToSelector:@selector(sideContentView:didSelectItemWithTitle:)]) {
    [self.delegate sideContentView:self
            didSelectItemWithTitle:_titles[(NSUInteger)[indexPath row]]];
  }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat sizeOffset = 0;
  if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
    sizeOffset += [(UICollectionViewFlowLayout *)collectionViewLayout sectionInset].left +
                  [(UICollectionViewFlowLayout *)collectionViewLayout sectionInset].right;
  }
  return CGSizeMake(collectionView.bounds.size.width - sizeOffset, 40.f);
}

@end

@interface PestoSideView () <UIGestureRecognizerDelegate, PestoSideContentViewDelegate>

@property(nonatomic) CGFloat xDelta;
@property(nonatomic) CGFloat xStart;
@property(nonatomic) PestoSideContentView *contentView;
@property(nonatomic) UIButton *dismissButton;

@end

@implementation PestoSideView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGRect contentViewFrame =
        CGRectMake(-kPestoSideViewWidth, 0, kPestoSideViewWidth, self.frame.size.height);
    _contentView = [[PestoSideContentView alloc] initWithFrame:contentViewFrame];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.delegate = self;
    [self addSubview:_contentView];

    UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(hideSideView)];
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];

    UIPanGestureRecognizer *panRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(panGestureRecognized:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.delegate = self;
    [self addGestureRecognizer:panRecognizer];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)_contentView.layer;
  [shadowLayer setElevation:MDCShadowElevationNavDrawer];
}

- (void)showSideView {
  [UIView animateWithDuration:kPestoSideViewAnimationDuration
      delay:0
      options:UIViewAnimationOptionCurveEaseOut
      animations:^{
        self.contentView.transform = [PestoSideView showTransform];
      }
      completion:^(BOOL finished){

      }];
}

- (void)hideSideView {
  [UIView animateWithDuration:kPestoSideViewAnimationDuration
      delay:0
      options:UIViewAnimationOptionCurveEaseOut
      animations:^{
        self.contentView.transform = [PestoSideView hideTransform];
      }
      completion:^(BOOL finished) {
        self.hidden = YES;
      }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  if ([touch.view isDescendantOfView:self.contentView]) {
    return ![gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]];
  }
  return YES;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer {
  CGPoint tappedPoint = [recognizer locationInView:self];
  CGFloat xCoordinate = tappedPoint.x;
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan:
      self.xStart = xCoordinate;
      break;
    case UIGestureRecognizerStateChanged:
      self.xDelta = kPestoSideViewWidth - (self.xStart - xCoordinate);
      if (self.xDelta > kPestoSideViewWidth) {
        self.xDelta = kPestoSideViewWidth;
      }
      self.contentView.transform = CGAffineTransformMakeTranslation(self.xDelta, 0);
      break;
    case UIGestureRecognizerStateEnded:
      if (self.xDelta > kPestoSideViewWidth - kPestoSideViewHideThreshhold) {
        [self showSideView];
      } else {
        [self hideSideView];
      }
    default:
      break;
  }
}

+ (CGAffineTransform)showTransform {
  return CGAffineTransformMakeTranslation(kPestoSideViewWidth, 0);
}

+ (CGAffineTransform)hideTransform {
  return CGAffineTransformIdentity;
}

#pragma mark - PestoSideContentViewDelegate

- (void)sideContentView:(PestoSideContentView *)sideContentView
 didSelectItemWithTitle:(NSString *)title {
  if (self.delegate) {
    if ([title isEqualToString:@"Settings"] &&
        [self.delegate respondsToSelector:@selector(sideViewDidSelectSettings:)]) {
      [self.delegate sideViewDidSelectSettings:self];
    }
  }
}

@end
