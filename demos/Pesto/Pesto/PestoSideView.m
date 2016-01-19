#import "PestoSideView.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

static CGFloat kPestoSideViewAnimationDuration = 0.2f;
static CGFloat kPestoSideViewAvatarDim = 64.f;
static CGFloat kPestoSideViewCollectionViewInset = 5.f;
static CGFloat kPestoSideViewHideThreshhold = 64.f;
static CGFloat kPestoSideViewUserItemHeight = 200.f;
static CGFloat kPestoSideViewWidth = 240.f;
static NSString *const kPestoSideViewWidthBaseURL =
    @"https://www.gstatic.com/angular/material-adaptive/pesto/";

@interface PestoSideViewCollectionViewCell : UICollectionViewCell

@property (nonatomic) NSString *title;

@end

@implementation PestoSideViewCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.backgroundColor = [UIColor whiteColor];
  UILabel *title = [[UILabel alloc] initWithFrame:self.bounds];
  title.text = _title;
  title.font = [MDCTypography body1Font];
  title.textAlignment = NSTextAlignmentCenter;
  [self addSubview:title];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }
}

@end

@interface PestoSideContentView : UIView <UICollectionViewDataSource,
                                          UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSArray *titles;
@property (nonatomic) NSCache *imageCache;
@property (nonatomic) UICollectionView *collectionView;

@end

@implementation PestoSideContentView

- (void)layoutSubviews {
  _titles = @[  @"Home", @"Favorite", @"Saved", @"Trending", @"Settings" ];

  CGRect avatarRect = CGRectMake(0, 0, kPestoSideViewAvatarDim, kPestoSideViewAvatarDim);
  NSString *imageURL = [kPestoSideViewWidthBaseURL stringByAppendingString:@"avatar.jpg"];
  UIImageView *avatar = [self imageViewWithURL:imageURL];
  avatar.frame = avatarRect;
  avatar.layer.cornerRadius = avatar.bounds.size.width / 2.f;
  avatar.center = CGPointMake(self.bounds.size.width / 2.f,
                              kPestoSideViewUserItemHeight / 2.f - 12.f);
  avatar.layer.masksToBounds = YES;
  [self addSubview:avatar];

  CGRect cirlceRect = CGRectMake(-3.f,
                                 -3.f,
                                 kPestoSideViewAvatarDim + 6.f,
                                 kPestoSideViewAvatarDim + 6.f);
  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];
  UIView *circleView = [[UIView alloc] initWithFrame:avatarRect];
  CAShapeLayer *circleLayer = [CAShapeLayer layer];
  [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:cirlceRect] CGPath]];
  [circleLayer setStrokeColor:teal.CGColor];
  [circleLayer setFillColor:[UIColor clearColor].CGColor];
  [circleLayer setLineWidth:2.f];
  [circleView.layer addSublayer:circleLayer];
  circleView.center = avatar.center;
  [self addSubview:circleView];

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

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:url]];
      [_imageCache setObject:imageData forKey:url];
    }
    if (imageData == nil) {
      return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      UIImage *image = [UIImage imageWithData:imageData];
      imageView.image = image;
    });
  });
  return imageView;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

# pragma mark - UICollectionViewDataSource

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
  [cell setNeedsLayout];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

# pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(collectionView.bounds.size.width, 40.f);
}

@end

@interface PestoSideView () <UIGestureRecognizerDelegate>

@property (nonatomic) CGFloat xDelta;
@property (nonatomic) CGFloat xStart;
@property (nonatomic) PestoSideContentView *contentView;
@property (nonatomic) UIButton *dismissButton;

@end

@implementation PestoSideView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGRect contentViewFrame =
        CGRectMake(-kPestoSideViewWidth, 0, kPestoSideViewWidth, self.frame.size.height);
    _contentView = [[PestoSideContentView alloc] initWithFrame:contentViewFrame];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];

    UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(hideSideView)];
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
                   animations:^ {
                     _contentView.transform = [PestoSideView showTransform];
                   } completion:^(BOOL finished) {
                     
                   }];
}

- (void)hideSideView {
  [UIView animateWithDuration:kPestoSideViewAnimationDuration
                        delay:0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^ {
                     _contentView.transform = [PestoSideView hideTransform];
                   } completion:^(BOOL finished) {
                     self.hidden = YES;
                   }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
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

@end
