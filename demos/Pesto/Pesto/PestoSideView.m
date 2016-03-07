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

@property(nonatomic) NSString *title;
@property(nonatomic) UIColor *titleColor;
@property(nonatomic) UILabel *titleLabel;

@end

@implementation PestoSideViewCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.titleColor = [UIColor lightGrayColor];
    self.backgroundColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.font = [MDCTypography body1Font];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = self.titleColor;
    [self addSubview:_titleLabel];
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  _titleLabel.text = nil;
}

- (void)setTitle:(NSString *)title {
  _title = title;
  _titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
  _titleColor = titleColor;
  _titleLabel.textColor = titleColor;
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
@property(weak) id<PestoSideContentViewDelegate> delegate;

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
  return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoSideViewCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoSideViewCollectionViewCell"
                                                forIndexPath:indexPath];
  NSInteger itemNum = indexPath.row;
  cell.title = _titles[itemNum];
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
    [self.delegate sideContentView:self didSelectItemWithTitle:_titles[[indexPath row]]];
  }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(collectionView.bounds.size.width, 40.f);
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
        _contentView.transform = [PestoSideView showTransform];
      }
      completion:^(BOOL finished){

      }];
}

- (void)hideSideView {
  [UIView animateWithDuration:kPestoSideViewAnimationDuration
      delay:0
      options:UIViewAnimationOptionCurveEaseOut
      animations:^{
        _contentView.transform = [PestoSideView hideTransform];
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
  if ([touch.view isDescendantOfView:_contentView]) {
    return ![gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]];
  }
  return YES;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer {
  CGPoint tappedPoint = [recognizer locationInView:self];
  CGFloat xCoordinate = tappedPoint.x;
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan:
      _xStart = xCoordinate;
      break;
    case UIGestureRecognizerStateChanged:
      _xDelta = kPestoSideViewWidth - (_xStart - xCoordinate);
      if (_xDelta > kPestoSideViewWidth) {
        _xDelta = kPestoSideViewWidth;
      }
      _contentView.transform = CGAffineTransformMakeTranslation(_xDelta, 0);
      break;
    case UIGestureRecognizerStateEnded:
      if (_xDelta > kPestoSideViewWidth - kPestoSideViewHideThreshhold) {
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
