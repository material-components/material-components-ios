#import "PestoCardCollectionViewCell.h"
#import "PestoDetailViewController.h"
#import "PestoSideView.h"
#import "PestoViewController.h"

#import "MaterialInk.h"
#import "MaterialScrollViewDelegateMultiplexer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoViewControllerInset = 5.f;
static CGFloat kPestoViewControllerSmallHeaderHeight = 100.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoHeaderView : UIView

@end

@implementation PestoHeaderView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoViewController () <UIScrollViewDelegate>

@property(nonatomic) CALayer *headerColorLayer;
@property(nonatomic) CGFloat initialCollectionViewHeight;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) CGSize initialLogoSize;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) MDCScrollViewDelegateMultiplexer *multiplexer;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSArray *icons;
@property(nonatomic) NSArray *images;
@property(nonatomic) NSArray *titles;
@property(nonatomic) NSArray *authors;
@property(nonatomic) NSString *baseURL;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) UIView *collapsedPestoHeaderView;
@property(nonatomic) UIImageView *logoView;
@property(nonatomic) UIImageView *logoSmallView;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) PestoHeaderView *pestoHeaderView;
@property(nonatomic) PestoSideView *sideView;

@end

@implementation PestoViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)setupData {
  _baseURL = @"https://www.gstatic.com/angular/material-adaptive/pesto/";
  _images = @[ @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg",
               @"IMG_0575.jpg",
               @"IMG_5438.jpg",
               @"IMG_5332.jpg",
               @"bok-choy.jpg",
               @"pasta.png",
               @"fish-steaks.jpg",
               @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _icons = @[ @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie" ];

  _imageCache = [[NSCache alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];

  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view.backgroundColor =
      [UIColor colorWithRed:0.9f
                      green:0.9f
                       blue:0.9f
                      alpha:1];
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoViewControllerInset)) / 2.f) - (2.f * kPestoViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width - (3.f * kPestoViewControllerInset)) / 3.f) - (2.f * kPestoViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);

  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];

  _initialCollectionViewHeight =
      self.view.frame.size.height - kPestoViewControllerDefaultHeaderHeight;

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset)];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView registerClass:[PestoCardCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_collectionView];

  _collectionView.delegate = self;
  [_multiplexer addObservingDelegate:self];

  CGRect PestoHeaderViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           kPestoViewControllerDefaultHeaderHeight);
  _pestoHeaderView = [[PestoHeaderView alloc] initWithFrame:PestoHeaderViewFrame];
  _headerColorLayer = [CALayer layer];
  _headerColorLayer.frame = PestoHeaderViewFrame;
  _headerColorLayer.backgroundColor = teal.CGColor;
  [_pestoHeaderView.layer addSublayer:_headerColorLayer];
  _pestoHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pestoHeaderView];

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  [_pestoHeaderView addSubview:_logoView];
  _initialLogoSize = _logoView.frame.size;

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [_pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:_pestoHeaderView];
  [_inkTouchController addInkView];

  [self adjustFramesWithScrollOffset:0];

  _zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _zoomableView.backgroundColor = [UIColor lightGrayColor];
  _zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_zoomableView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20, 30, 30, 30);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:_animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  _sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  _sideView.hidden = YES;
  _sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_sideView];
}

- (void)showMenu {
  _sideView.hidden = NO;
  [_sideView showSideView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adjustFramesWithScrollOffset:(CGFloat)yOffset {
  [CATransaction setDisableActions:YES];
  CGFloat headerHeight = kPestoViewControllerDefaultHeaderHeight - yOffset;

  if (headerHeight < kPestoViewControllerSmallHeaderHeight) {
    headerHeight = kPestoViewControllerSmallHeaderHeight;
  }

  _pestoHeaderView.frame = CGRectMake(0,
                                      0,
                                      _pestoHeaderView.frame.size.width,
                                      headerHeight);
  _headerColorLayer.frame = _pestoHeaderView.frame;

  CGFloat scale = headerHeight / kPestoViewControllerDefaultHeaderHeight;
  if (scale > 1) {
    scale = 1;
  }

  CGSize logoSize = CGSizeMake(_initialLogoSize.width * scale,
                               _initialLogoSize.height * scale);
  CGRect logoViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - logoSize.width) / 2.f,
                 (_pestoHeaderView.frame.size.height - logoSize.height) / 2.f +
                     (2.f * kPestoViewControllerInset),
                 logoSize.width,
                 logoSize.height);
  _logoView.frame = logoViewFrame;
  CGFloat largeLogoOpacity =
      (headerHeight - kPestoViewControllerSmallHeaderHeight) /
      (kPestoViewControllerDefaultHeaderHeight - kPestoViewControllerSmallHeaderHeight);

  CGRect logoSmallViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - _logoSmallView.frame.size.width) / 2.f,
                 (_pestoHeaderView.frame.size.height -
                  _logoSmallView.frame.size.height) /
                         2.f +
                     (2.f * kPestoViewControllerInset),
                 _logoSmallView.frame.size.width,
                 _logoSmallView.frame.size.height);
  _logoSmallView.frame = logoSmallViewFrame;

  CGFloat collectionViewHeight = self.view.frame.size.height - headerHeight;
  CGFloat heightPadding =
      yOffset > kPestoViewControllerInset ? 0 : kPestoViewControllerInset - yOffset;

  _collectionView.frame =
      CGRectMake(kPestoViewControllerInset,
                 headerHeight + heightPadding,
                 _pestoHeaderView.frame.size.width - (2.f * kPestoViewControllerInset),
                 collectionViewHeight - heightPadding);

  MDCShadowLayer *pestoHeaderViewLayer = (MDCShadowLayer *)_pestoHeaderView.layer;
  pestoHeaderViewLayer.shadowMaskEnabled = NO;
  CGFloat elevation = MDCShadowElevationAppBar * _logoSmallView.layer.opacity;
  [pestoHeaderViewLayer setElevation:elevation];

  [CATransaction setDisableActions:NO];

  if (largeLogoOpacity < 0.33f) {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 0;
          _logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 1.f;
          _logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
}

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];

  NSInteger itemNum = indexPath.row;
  NSString *imageURL = [_baseURL stringByAppendingString:_images[itemNum]];
  cell.title = _titles[itemNum];
  cell.author = _authors[itemNum];
  cell.imageURL = imageURL;
  cell.icon = _icons[itemNum];
  cell.imageView = [self imageViewWithURL:imageURL];

  [cell setNeedsLayout];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  PestoDetailViewController *detailVC = [[PestoDetailViewController alloc] init];
  detailVC.image = cell.imageView.image;
  detailVC.imageURL = cell.imageURL;
  detailVC.title = cell.title;

  _zoomableView.frame =
      CGRectMake(cell.frame.origin.x + collectionView.frame.origin.x,
                 cell.frame.origin.y + collectionView.frame.origin.y - _scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  dispatch_async(dispatch_get_main_queue(), ^{
    [_zoomableView setImage:cell.imageView.image];
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _zoomableView.frame = self.view.frame;
        }
        completion:^(BOOL finished) {
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             _zoomableView.frame = CGRectZero;
                           }];
        }];
  });
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
#import "PestoCardCollectionViewCell.h"
#import "PestoDetailViewController.h"
#import "PestoSideView.h"
#import "PestoViewController.h"

#import "MaterialInk.h"
#import "MaterialScrollViewDelegateMultiplexer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoViewControllerInset = 5.f;
static CGFloat kPestoViewControllerSmallHeaderHeight = 100.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoHeaderView : UIView

@end

@implementation PestoHeaderView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoViewController () <UIScrollViewDelegate>

@property(nonatomic) CALayer *headerColorLayer;
@property(nonatomic) CGFloat initialCollectionViewHeight;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) CGSize initialLogoSize;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) MDCScrollViewDelegateMultiplexer *multiplexer;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSArray *icons;
@property(nonatomic) NSArray *images;
@property(nonatomic) NSArray *titles;
@property(nonatomic) NSArray *authors;
@property(nonatomic) NSString *baseURL;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) UIView *collapsedPestoHeaderView;
@property(nonatomic) UIImageView *logoView;
@property(nonatomic) UIImageView *logoSmallView;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) PestoHeaderView *pestoHeaderView;
@property(nonatomic) PestoSideView *sideView;

@end

@implementation PestoViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)setupData {
  _baseURL = @"https://www.gstatic.com/angular/material-adaptive/pesto/";
  _images = @[ @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg",
               @"IMG_0575.jpg",
               @"IMG_5438.jpg",
               @"IMG_5332.jpg",
               @"bok-choy.jpg",
               @"pasta.png",
               @"fish-steaks.jpg",
               @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _icons = @[ @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie" ];

  _imageCache = [[NSCache alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];

  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view.backgroundColor =
      [UIColor colorWithRed:0.9f
                      green:0.9f
                       blue:0.9f
                      alpha:1];
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoViewControllerInset)) / 2.f) - (2.f * kPestoViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width - (3.f * kPestoViewControllerInset)) / 3.f) - (2.f * kPestoViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);

  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];

  _initialCollectionViewHeight =
      self.view.frame.size.height - kPestoViewControllerDefaultHeaderHeight;

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset)];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView registerClass:[PestoCardCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_collectionView];

  _collectionView.delegate = self;
  [_multiplexer addObservingDelegate:self];

  CGRect PestoHeaderViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           kPestoViewControllerDefaultHeaderHeight);
  _pestoHeaderView = [[PestoHeaderView alloc] initWithFrame:PestoHeaderViewFrame];
  _headerColorLayer = [CALayer layer];
  _headerColorLayer.frame = PestoHeaderViewFrame;
  _headerColorLayer.backgroundColor = teal.CGColor;
  [_pestoHeaderView.layer addSublayer:_headerColorLayer];
  _pestoHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pestoHeaderView];

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  [_pestoHeaderView addSubview:_logoView];
  _initialLogoSize = _logoView.frame.size;

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [_pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:_pestoHeaderView];
  [_inkTouchController addInkView];

  [self adjustFramesWithScrollOffset:0];

  _zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _zoomableView.backgroundColor = [UIColor lightGrayColor];
  _zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_zoomableView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20, 30, 30, 30);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:_animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  _sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  _sideView.hidden = YES;
  _sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_sideView];
}

- (void)showMenu {
  _sideView.hidden = NO;
  [_sideView showSideView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adjustFramesWithScrollOffset:(CGFloat)yOffset {
  [CATransaction setDisableActions:YES];
  CGFloat headerHeight = kPestoViewControllerDefaultHeaderHeight - yOffset;

  if (headerHeight < kPestoViewControllerSmallHeaderHeight) {
    headerHeight = kPestoViewControllerSmallHeaderHeight;
  }

  _pestoHeaderView.frame = CGRectMake(0,
                                      0,
                                      _pestoHeaderView.frame.size.width,
                                      headerHeight);
  _headerColorLayer.frame = _pestoHeaderView.frame;

  CGFloat scale = headerHeight / kPestoViewControllerDefaultHeaderHeight;
  if (scale > 1) {
    scale = 1;
  }

  CGSize logoSize = CGSizeMake(_initialLogoSize.width * scale,
                               _initialLogoSize.height * scale);
  CGRect logoViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - logoSize.width) / 2.f,
                 (_pestoHeaderView.frame.size.height - logoSize.height) / 2.f +
                     (2.f * kPestoViewControllerInset),
                 logoSize.width,
                 logoSize.height);
  _logoView.frame = logoViewFrame;
  CGFloat largeLogoOpacity =
      (headerHeight - kPestoViewControllerSmallHeaderHeight) /
      (kPestoViewControllerDefaultHeaderHeight - kPestoViewControllerSmallHeaderHeight);

  CGRect logoSmallViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - _logoSmallView.frame.size.width) / 2.f,
                 (_pestoHeaderView.frame.size.height -
                  _logoSmallView.frame.size.height) /
                         2.f +
                     (2.f * kPestoViewControllerInset),
                 _logoSmallView.frame.size.width,
                 _logoSmallView.frame.size.height);
  _logoSmallView.frame = logoSmallViewFrame;

  CGFloat collectionViewHeight = self.view.frame.size.height - headerHeight;
  CGFloat heightPadding =
      yOffset > kPestoViewControllerInset ? 0 : kPestoViewControllerInset - yOffset;

  _collectionView.frame =
      CGRectMake(kPestoViewControllerInset,
                 headerHeight + heightPadding,
                 _pestoHeaderView.frame.size.width - (2.f * kPestoViewControllerInset),
                 collectionViewHeight - heightPadding);

  MDCShadowLayer *pestoHeaderViewLayer = (MDCShadowLayer *)_pestoHeaderView.layer;
  pestoHeaderViewLayer.shadowMaskEnabled = NO;
  CGFloat elevation = MDCShadowElevationAppBar * _logoSmallView.layer.opacity;
  [pestoHeaderViewLayer setElevation:elevation];

  [CATransaction setDisableActions:NO];

  if (largeLogoOpacity < 0.33f) {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 0;
          _logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 1.f;
          _logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
}

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];

  NSInteger itemNum = indexPath.row;
  NSString *imageURL = [_baseURL stringByAppendingString:_images[itemNum]];
  cell.title = _titles[itemNum];
  cell.author = _authors[itemNum];
  cell.imageURL = imageURL;
  cell.icon = _icons[itemNum];
  cell.imageView = [self imageViewWithURL:imageURL];

  [cell setNeedsLayout];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  PestoDetailViewController *detailVC = [[PestoDetailViewController alloc] init];
  detailVC.image = cell.imageView.image;
  detailVC.imageURL = cell.imageURL;
  detailVC.title = cell.title;

  _zoomableView.frame =
      CGRectMake(cell.frame.origin.x + collectionView.frame.origin.x,
                 cell.frame.origin.y + collectionView.frame.origin.y - _scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  dispatch_async(dispatch_get_main_queue(), ^{
    [_zoomableView setImage:cell.imageView.image];
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _zoomableView.frame = self.view.frame;
        }
        completion:^(BOOL finished) {
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             _zoomableView.frame = CGRectZero;
                           }];
        }];
  });
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
#import "PestoCardCollectionViewCell.h"
#import "PestoDetailViewController.h"
#import "PestoSideView.h"
#import "PestoViewController.h"

#import "MaterialInk.h"
#import "MaterialScrollViewDelegateMultiplexer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoViewControllerInset = 5.f;
static CGFloat kPestoViewControllerSmallHeaderHeight = 100.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoHeaderView : UIView

@end

@implementation PestoHeaderView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoViewController () <UIScrollViewDelegate>

@property(nonatomic) CALayer *headerColorLayer;
@property(nonatomic) CGFloat initialCollectionViewHeight;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) CGSize initialLogoSize;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) MDCScrollViewDelegateMultiplexer *multiplexer;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSArray *icons;
@property(nonatomic) NSArray *images;
@property(nonatomic) NSArray *titles;
@property(nonatomic) NSArray *authors;
@property(nonatomic) NSString *baseURL;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) UIView *collapsedPestoHeaderView;
@property(nonatomic) UIImageView *logoView;
@property(nonatomic) UIImageView *logoSmallView;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) PestoHeaderView *pestoHeaderView;
@property(nonatomic) PestoSideView *sideView;

@end

@implementation PestoViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)setupData {
  _baseURL = @"https://www.gstatic.com/angular/material-adaptive/pesto/";
  _images = @[ @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg",
               @"IMG_0575.jpg",
               @"IMG_5438.jpg",
               @"IMG_5332.jpg",
               @"bok-choy.jpg",
               @"pasta.png",
               @"fish-steaks.jpg",
               @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _icons = @[ @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie" ];

  _imageCache = [[NSCache alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];

  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view.backgroundColor =
      [UIColor colorWithRed:0.9f
                      green:0.9f
                       blue:0.9f
                      alpha:1];
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoViewControllerInset)) / 2.f) - (2.f * kPestoViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width - (3.f * kPestoViewControllerInset)) / 3.f) - (2.f * kPestoViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);

  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];

  _initialCollectionViewHeight =
      self.view.frame.size.height - kPestoViewControllerDefaultHeaderHeight;

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset)];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView registerClass:[PestoCardCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_collectionView];

  _collectionView.delegate = self;
  [_multiplexer addObservingDelegate:self];

  CGRect PestoHeaderViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           kPestoViewControllerDefaultHeaderHeight);
  _pestoHeaderView = [[PestoHeaderView alloc] initWithFrame:PestoHeaderViewFrame];
  _headerColorLayer = [CALayer layer];
  _headerColorLayer.frame = PestoHeaderViewFrame;
  _headerColorLayer.backgroundColor = teal.CGColor;
  [_pestoHeaderView.layer addSublayer:_headerColorLayer];
  _pestoHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pestoHeaderView];

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  [_pestoHeaderView addSubview:_logoView];
  _initialLogoSize = _logoView.frame.size;

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [_pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:_pestoHeaderView];
  [_inkTouchController addInkView];

  [self adjustFramesWithScrollOffset:0];

  _zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _zoomableView.backgroundColor = [UIColor lightGrayColor];
  _zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_zoomableView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20, 30, 30, 30);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:_animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  _sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  _sideView.hidden = YES;
  _sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_sideView];
}

- (void)showMenu {
  _sideView.hidden = NO;
  [_sideView showSideView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adjustFramesWithScrollOffset:(CGFloat)yOffset {
  [CATransaction setDisableActions:YES];
  CGFloat headerHeight = kPestoViewControllerDefaultHeaderHeight - yOffset;

  if (headerHeight < kPestoViewControllerSmallHeaderHeight) {
    headerHeight = kPestoViewControllerSmallHeaderHeight;
  }

  _pestoHeaderView.frame = CGRectMake(0,
                                      0,
                                      _pestoHeaderView.frame.size.width,
                                      headerHeight);
  _headerColorLayer.frame = _pestoHeaderView.frame;

  CGFloat scale = headerHeight / kPestoViewControllerDefaultHeaderHeight;
  if (scale > 1) {
    scale = 1;
  }

  CGSize logoSize = CGSizeMake(_initialLogoSize.width * scale,
                               _initialLogoSize.height * scale);
  CGRect logoViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - logoSize.width) / 2.f,
                 (_pestoHeaderView.frame.size.height - logoSize.height) / 2.f +
                     (2.f * kPestoViewControllerInset),
                 logoSize.width,
                 logoSize.height);
  _logoView.frame = logoViewFrame;
  CGFloat largeLogoOpacity =
      (headerHeight - kPestoViewControllerSmallHeaderHeight) /
      (kPestoViewControllerDefaultHeaderHeight - kPestoViewControllerSmallHeaderHeight);

  CGRect logoSmallViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - _logoSmallView.frame.size.width) / 2.f,
                 (_pestoHeaderView.frame.size.height -
                  _logoSmallView.frame.size.height) /
                         2.f +
                     (2.f * kPestoViewControllerInset),
                 _logoSmallView.frame.size.width,
                 _logoSmallView.frame.size.height);
  _logoSmallView.frame = logoSmallViewFrame;

  CGFloat collectionViewHeight = self.view.frame.size.height - headerHeight;
  CGFloat heightPadding =
      yOffset > kPestoViewControllerInset ? 0 : kPestoViewControllerInset - yOffset;

  _collectionView.frame =
      CGRectMake(kPestoViewControllerInset,
                 headerHeight + heightPadding,
                 _pestoHeaderView.frame.size.width - (2.f * kPestoViewControllerInset),
                 collectionViewHeight - heightPadding);

  MDCShadowLayer *pestoHeaderViewLayer = (MDCShadowLayer *)_pestoHeaderView.layer;
  pestoHeaderViewLayer.shadowMaskEnabled = NO;
  CGFloat elevation = MDCShadowElevationAppBar * _logoSmallView.layer.opacity;
  [pestoHeaderViewLayer setElevation:elevation];

  [CATransaction setDisableActions:NO];

  if (largeLogoOpacity < 0.33f) {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 0;
          _logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 1.f;
          _logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
}

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];

  NSInteger itemNum = indexPath.row;
  NSString *imageURL = [_baseURL stringByAppendingString:_images[itemNum]];
  cell.title = _titles[itemNum];
  cell.author = _authors[itemNum];
  cell.imageURL = imageURL;
  cell.icon = _icons[itemNum];
  cell.imageView = [self imageViewWithURL:imageURL];

  [cell setNeedsLayout];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  PestoDetailViewController *detailVC = [[PestoDetailViewController alloc] init];
  detailVC.image = cell.imageView.image;
  detailVC.imageURL = cell.imageURL;
  detailVC.title = cell.title;

  _zoomableView.frame =
      CGRectMake(cell.frame.origin.x + collectionView.frame.origin.x,
                 cell.frame.origin.y + collectionView.frame.origin.y - _scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  dispatch_async(dispatch_get_main_queue(), ^{
    [_zoomableView setImage:cell.imageView.image];
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _zoomableView.frame = self.view.frame;
        }
        completion:^(BOOL finished) {
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             _zoomableView.frame = CGRectZero;
                           }];
        }];
  });
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
#import "PestoCardCollectionViewCell.h"
#import "PestoDetailViewController.h"
#import "PestoSideView.h"
#import "PestoViewController.h"

#import "MaterialInk.h"
#import "MaterialScrollViewDelegateMultiplexer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoViewControllerInset = 5.f;
static CGFloat kPestoViewControllerSmallHeaderHeight = 100.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoHeaderView : UIView

@end

@implementation PestoHeaderView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoViewController () <UIScrollViewDelegate>

@property(nonatomic) CALayer *headerColorLayer;
@property(nonatomic) CGFloat initialCollectionViewHeight;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) CGSize initialLogoSize;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) MDCScrollViewDelegateMultiplexer *multiplexer;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSArray *icons;
@property(nonatomic) NSArray *images;
@property(nonatomic) NSArray *titles;
@property(nonatomic) NSArray *authors;
@property(nonatomic) NSString *baseURL;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) UIView *collapsedPestoHeaderView;
@property(nonatomic) UIImageView *logoView;
@property(nonatomic) UIImageView *logoSmallView;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) PestoHeaderView *pestoHeaderView;
@property(nonatomic) PestoSideView *sideView;

@end

@implementation PestoViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)setupData {
  _baseURL = @"https://www.gstatic.com/angular/material-adaptive/pesto/";
  _images = @[ @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg",
               @"IMG_0575.jpg",
               @"IMG_5438.jpg",
               @"IMG_5332.jpg",
               @"bok-choy.jpg",
               @"pasta.png",
               @"fish-steaks.jpg",
               @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _icons = @[ @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie" ];

  _imageCache = [[NSCache alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];

  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view.backgroundColor =
      [UIColor colorWithRed:0.9f
                      green:0.9f
                       blue:0.9f
                      alpha:1];
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoViewControllerInset)) / 2.f) - (2.f * kPestoViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width - (3.f * kPestoViewControllerInset)) / 3.f) - (2.f * kPestoViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);

  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];

  _initialCollectionViewHeight =
      self.view.frame.size.height - kPestoViewControllerDefaultHeaderHeight;

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset)];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView registerClass:[PestoCardCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_collectionView];

  _collectionView.delegate = self;
  [_multiplexer addObservingDelegate:self];

  CGRect PestoHeaderViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           kPestoViewControllerDefaultHeaderHeight);
  _pestoHeaderView = [[PestoHeaderView alloc] initWithFrame:PestoHeaderViewFrame];
  _headerColorLayer = [CALayer layer];
  _headerColorLayer.frame = PestoHeaderViewFrame;
  _headerColorLayer.backgroundColor = teal.CGColor;
  [_pestoHeaderView.layer addSublayer:_headerColorLayer];
  _pestoHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pestoHeaderView];

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  [_pestoHeaderView addSubview:_logoView];
  _initialLogoSize = _logoView.frame.size;

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [_pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:_pestoHeaderView];
  [_inkTouchController addInkView];

  [self adjustFramesWithScrollOffset:0];

  _zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _zoomableView.backgroundColor = [UIColor lightGrayColor];
  _zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_zoomableView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20, 30, 30, 30);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:_animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  _sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  _sideView.hidden = YES;
  _sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_sideView];
}

- (void)showMenu {
  _sideView.hidden = NO;
  [_sideView showSideView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adjustFramesWithScrollOffset:(CGFloat)yOffset {
  [CATransaction setDisableActions:YES];
  CGFloat headerHeight = kPestoViewControllerDefaultHeaderHeight - yOffset;

  if (headerHeight < kPestoViewControllerSmallHeaderHeight) {
    headerHeight = kPestoViewControllerSmallHeaderHeight;
  }

  _pestoHeaderView.frame = CGRectMake(0,
                                      0,
                                      _pestoHeaderView.frame.size.width,
                                      headerHeight);
  _headerColorLayer.frame = _pestoHeaderView.frame;

  CGFloat scale = headerHeight / kPestoViewControllerDefaultHeaderHeight;
  if (scale > 1) {
    scale = 1;
  }

  CGSize logoSize = CGSizeMake(_initialLogoSize.width * scale,
                               _initialLogoSize.height * scale);
  CGRect logoViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - logoSize.width) / 2.f,
                 (_pestoHeaderView.frame.size.height - logoSize.height) / 2.f +
                     (2.f * kPestoViewControllerInset),
                 logoSize.width,
                 logoSize.height);
  _logoView.frame = logoViewFrame;
  CGFloat largeLogoOpacity =
      (headerHeight - kPestoViewControllerSmallHeaderHeight) /
      (kPestoViewControllerDefaultHeaderHeight - kPestoViewControllerSmallHeaderHeight);

  CGRect logoSmallViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - _logoSmallView.frame.size.width) / 2.f,
                 (_pestoHeaderView.frame.size.height -
                  _logoSmallView.frame.size.height) /
                         2.f +
                     (2.f * kPestoViewControllerInset),
                 _logoSmallView.frame.size.width,
                 _logoSmallView.frame.size.height);
  _logoSmallView.frame = logoSmallViewFrame;

  CGFloat collectionViewHeight = self.view.frame.size.height - headerHeight;
  CGFloat heightPadding =
      yOffset > kPestoViewControllerInset ? 0 : kPestoViewControllerInset - yOffset;

  _collectionView.frame =
      CGRectMake(kPestoViewControllerInset,
                 headerHeight + heightPadding,
                 _pestoHeaderView.frame.size.width - (2.f * kPestoViewControllerInset),
                 collectionViewHeight - heightPadding);

  MDCShadowLayer *pestoHeaderViewLayer = (MDCShadowLayer *)_pestoHeaderView.layer;
  pestoHeaderViewLayer.shadowMaskEnabled = NO;
  CGFloat elevation = MDCShadowElevationAppBar * _logoSmallView.layer.opacity;
  [pestoHeaderViewLayer setElevation:elevation];

  [CATransaction setDisableActions:NO];

  if (largeLogoOpacity < 0.33f) {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 0;
          _logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 1.f;
          _logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
}

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];

  NSInteger itemNum = indexPath.row;
  NSString *imageURL = [_baseURL stringByAppendingString:_images[itemNum]];
  cell.title = _titles[itemNum];
  cell.author = _authors[itemNum];
  cell.imageURL = imageURL;
  cell.icon = _icons[itemNum];
  cell.imageView = [self imageViewWithURL:imageURL];

  [cell setNeedsLayout];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  PestoDetailViewController *detailVC = [[PestoDetailViewController alloc] init];
  detailVC.image = cell.imageView.image;
  detailVC.imageURL = cell.imageURL;
  detailVC.title = cell.title;

  _zoomableView.frame =
      CGRectMake(cell.frame.origin.x + collectionView.frame.origin.x,
                 cell.frame.origin.y + collectionView.frame.origin.y - _scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  dispatch_async(dispatch_get_main_queue(), ^{
    [_zoomableView setImage:cell.imageView.image];
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _zoomableView.frame = self.view.frame;
        }
        completion:^(BOOL finished) {
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             _zoomableView.frame = CGRectZero;
                           }];
        }];
  });
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
#import "PestoCardCollectionViewCell.h"
#import "PestoDetailViewController.h"
#import "PestoSideView.h"
#import "PestoViewController.h"

#import "MaterialInk.h"
#import "MaterialScrollViewDelegateMultiplexer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoViewControllerInset = 5.f;
static CGFloat kPestoViewControllerSmallHeaderHeight = 100.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoHeaderView : UIView

@end

@implementation PestoHeaderView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoViewController () <UIScrollViewDelegate>

@property(nonatomic) CALayer *headerColorLayer;
@property(nonatomic) CGFloat initialCollectionViewHeight;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) CGSize initialLogoSize;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) MDCScrollViewDelegateMultiplexer *multiplexer;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSArray *icons;
@property(nonatomic) NSArray *images;
@property(nonatomic) NSArray *titles;
@property(nonatomic) NSArray *authors;
@property(nonatomic) NSString *baseURL;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) UIView *collapsedPestoHeaderView;
@property(nonatomic) UIImageView *logoView;
@property(nonatomic) UIImageView *logoSmallView;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) PestoHeaderView *pestoHeaderView;
@property(nonatomic) PestoSideView *sideView;

@end

@implementation PestoViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)setupData {
  _baseURL = @"https://www.gstatic.com/angular/material-adaptive/pesto/";
  _images = @[ @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg",
               @"IMG_0575.jpg",
               @"IMG_5438.jpg",
               @"IMG_5332.jpg",
               @"bok-choy.jpg",
               @"pasta.png",
               @"fish-steaks.jpg",
               @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _icons = @[ @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie" ];

  _imageCache = [[NSCache alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];

  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view.backgroundColor =
      [UIColor colorWithRed:0.9f
                      green:0.9f
                       blue:0.9f
                      alpha:1];
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoViewControllerInset)) / 2.f) - (2.f * kPestoViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width - (3.f * kPestoViewControllerInset)) / 3.f) - (2.f * kPestoViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);

  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];

  _initialCollectionViewHeight =
      self.view.frame.size.height - kPestoViewControllerDefaultHeaderHeight;

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset)];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView registerClass:[PestoCardCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_collectionView];

  _collectionView.delegate = self;
  [_multiplexer addObservingDelegate:self];

  CGRect PestoHeaderViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           kPestoViewControllerDefaultHeaderHeight);
  _pestoHeaderView = [[PestoHeaderView alloc] initWithFrame:PestoHeaderViewFrame];
  _headerColorLayer = [CALayer layer];
  _headerColorLayer.frame = PestoHeaderViewFrame;
  _headerColorLayer.backgroundColor = teal.CGColor;
  [_pestoHeaderView.layer addSublayer:_headerColorLayer];
  _pestoHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pestoHeaderView];

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  [_pestoHeaderView addSubview:_logoView];
  _initialLogoSize = _logoView.frame.size;

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [_pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:_pestoHeaderView];
  [_inkTouchController addInkView];

  [self adjustFramesWithScrollOffset:0];

  _zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _zoomableView.backgroundColor = [UIColor lightGrayColor];
  _zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_zoomableView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20, 30, 30, 30);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:_animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  _sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  _sideView.hidden = YES;
  _sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_sideView];
}

- (void)showMenu {
  _sideView.hidden = NO;
  [_sideView showSideView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adjustFramesWithScrollOffset:(CGFloat)yOffset {
  [CATransaction setDisableActions:YES];
  CGFloat headerHeight = kPestoViewControllerDefaultHeaderHeight - yOffset;

  if (headerHeight < kPestoViewControllerSmallHeaderHeight) {
    headerHeight = kPestoViewControllerSmallHeaderHeight;
  }

  _pestoHeaderView.frame = CGRectMake(0,
                                      0,
                                      _pestoHeaderView.frame.size.width,
                                      headerHeight);
  _headerColorLayer.frame = _pestoHeaderView.frame;

  CGFloat scale = headerHeight / kPestoViewControllerDefaultHeaderHeight;
  if (scale > 1) {
    scale = 1;
  }

  CGSize logoSize = CGSizeMake(_initialLogoSize.width * scale,
                               _initialLogoSize.height * scale);
  CGRect logoViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - logoSize.width) / 2.f,
                 (_pestoHeaderView.frame.size.height - logoSize.height) / 2.f +
                     (2.f * kPestoViewControllerInset),
                 logoSize.width,
                 logoSize.height);
  _logoView.frame = logoViewFrame;
  CGFloat largeLogoOpacity =
      (headerHeight - kPestoViewControllerSmallHeaderHeight) /
      (kPestoViewControllerDefaultHeaderHeight - kPestoViewControllerSmallHeaderHeight);

  CGRect logoSmallViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - _logoSmallView.frame.size.width) / 2.f,
                 (_pestoHeaderView.frame.size.height -
                  _logoSmallView.frame.size.height) /
                         2.f +
                     (2.f * kPestoViewControllerInset),
                 _logoSmallView.frame.size.width,
                 _logoSmallView.frame.size.height);
  _logoSmallView.frame = logoSmallViewFrame;

  CGFloat collectionViewHeight = self.view.frame.size.height - headerHeight;
  CGFloat heightPadding =
      yOffset > kPestoViewControllerInset ? 0 : kPestoViewControllerInset - yOffset;

  _collectionView.frame =
      CGRectMake(kPestoViewControllerInset,
                 headerHeight + heightPadding,
                 _pestoHeaderView.frame.size.width - (2.f * kPestoViewControllerInset),
                 collectionViewHeight - heightPadding);

  MDCShadowLayer *pestoHeaderViewLayer = (MDCShadowLayer *)_pestoHeaderView.layer;
  pestoHeaderViewLayer.shadowMaskEnabled = NO;
  CGFloat elevation = MDCShadowElevationAppBar * _logoSmallView.layer.opacity;
  [pestoHeaderViewLayer setElevation:elevation];

  [CATransaction setDisableActions:NO];

  if (largeLogoOpacity < 0.33f) {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 0;
          _logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 1.f;
          _logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
}

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];

  NSInteger itemNum = indexPath.row;
  NSString *imageURL = [_baseURL stringByAppendingString:_images[itemNum]];
  cell.title = _titles[itemNum];
  cell.author = _authors[itemNum];
  cell.imageURL = imageURL;
  cell.icon = _icons[itemNum];
  cell.imageView = [self imageViewWithURL:imageURL];

  [cell setNeedsLayout];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  PestoDetailViewController *detailVC = [[PestoDetailViewController alloc] init];
  detailVC.image = cell.imageView.image;
  detailVC.imageURL = cell.imageURL;
  detailVC.title = cell.title;

  _zoomableView.frame =
      CGRectMake(cell.frame.origin.x + collectionView.frame.origin.x,
                 cell.frame.origin.y + collectionView.frame.origin.y - _scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  dispatch_async(dispatch_get_main_queue(), ^{
    [_zoomableView setImage:cell.imageView.image];
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _zoomableView.frame = self.view.frame;
        }
        completion:^(BOOL finished) {
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             _zoomableView.frame = CGRectZero;
                           }];
        }];
  });
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
#import "PestoCardCollectionViewCell.h"
#import "PestoDetailViewController.h"
#import "PestoSideView.h"
#import "PestoViewController.h"

#import "MaterialInk.h"
#import "MaterialScrollViewDelegateMultiplexer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoViewControllerInset = 5.f;
static CGFloat kPestoViewControllerSmallHeaderHeight = 100.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoHeaderView : UIView

@end

@implementation PestoHeaderView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoViewController () <UIScrollViewDelegate>

@property(nonatomic) CALayer *headerColorLayer;
@property(nonatomic) CGFloat initialCollectionViewHeight;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) CGSize initialLogoSize;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) MDCScrollViewDelegateMultiplexer *multiplexer;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSArray *icons;
@property(nonatomic) NSArray *images;
@property(nonatomic) NSArray *titles;
@property(nonatomic) NSArray *authors;
@property(nonatomic) NSString *baseURL;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) UIView *collapsedPestoHeaderView;
@property(nonatomic) UIImageView *logoView;
@property(nonatomic) UIImageView *logoSmallView;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) PestoHeaderView *pestoHeaderView;
@property(nonatomic) PestoSideView *sideView;

@end

@implementation PestoViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)setupData {
  _baseURL = @"https://www.gstatic.com/angular/material-adaptive/pesto/";
  _images = @[ @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg",
               @"IMG_0575.jpg",
               @"IMG_5438.jpg",
               @"IMG_5332.jpg",
               @"bok-choy.jpg",
               @"pasta.png",
               @"fish-steaks.jpg",
               @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _icons = @[ @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie" ];

  _imageCache = [[NSCache alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];

  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view.backgroundColor =
      [UIColor colorWithRed:0.9f
                      green:0.9f
                       blue:0.9f
                      alpha:1];
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoViewControllerInset)) / 2.f) - (2.f * kPestoViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width - (3.f * kPestoViewControllerInset)) / 3.f) - (2.f * kPestoViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);

  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];

  _initialCollectionViewHeight =
      self.view.frame.size.height - kPestoViewControllerDefaultHeaderHeight;

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset)];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView registerClass:[PestoCardCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_collectionView];

  _collectionView.delegate = self;
  [_multiplexer addObservingDelegate:self];

  CGRect PestoHeaderViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           kPestoViewControllerDefaultHeaderHeight);
  _pestoHeaderView = [[PestoHeaderView alloc] initWithFrame:PestoHeaderViewFrame];
  _headerColorLayer = [CALayer layer];
  _headerColorLayer.frame = PestoHeaderViewFrame;
  _headerColorLayer.backgroundColor = teal.CGColor;
  [_pestoHeaderView.layer addSublayer:_headerColorLayer];
  _pestoHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pestoHeaderView];

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  [_pestoHeaderView addSubview:_logoView];
  _initialLogoSize = _logoView.frame.size;

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [_pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:_pestoHeaderView];
  [_inkTouchController addInkView];

  [self adjustFramesWithScrollOffset:0];

  _zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _zoomableView.backgroundColor = [UIColor lightGrayColor];
  _zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_zoomableView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20, 30, 30, 30);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:_animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  _sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  _sideView.hidden = YES;
  _sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_sideView];
}

- (void)showMenu {
  _sideView.hidden = NO;
  [_sideView showSideView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adjustFramesWithScrollOffset:(CGFloat)yOffset {
  [CATransaction setDisableActions:YES];
  CGFloat headerHeight = kPestoViewControllerDefaultHeaderHeight - yOffset;

  if (headerHeight < kPestoViewControllerSmallHeaderHeight) {
    headerHeight = kPestoViewControllerSmallHeaderHeight;
  }

  _pestoHeaderView.frame = CGRectMake(0,
                                      0,
                                      _pestoHeaderView.frame.size.width,
                                      headerHeight);
  _headerColorLayer.frame = _pestoHeaderView.frame;

  CGFloat scale = headerHeight / kPestoViewControllerDefaultHeaderHeight;
  if (scale > 1) {
    scale = 1;
  }

  CGSize logoSize = CGSizeMake(_initialLogoSize.width * scale,
                               _initialLogoSize.height * scale);
  CGRect logoViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - logoSize.width) / 2.f,
                 (_pestoHeaderView.frame.size.height - logoSize.height) / 2.f +
                     (2.f * kPestoViewControllerInset),
                 logoSize.width,
                 logoSize.height);
  _logoView.frame = logoViewFrame;
  CGFloat largeLogoOpacity =
      (headerHeight - kPestoViewControllerSmallHeaderHeight) /
      (kPestoViewControllerDefaultHeaderHeight - kPestoViewControllerSmallHeaderHeight);

  CGRect logoSmallViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - _logoSmallView.frame.size.width) / 2.f,
                 (_pestoHeaderView.frame.size.height -
                  _logoSmallView.frame.size.height) /
                         2.f +
                     (2.f * kPestoViewControllerInset),
                 _logoSmallView.frame.size.width,
                 _logoSmallView.frame.size.height);
  _logoSmallView.frame = logoSmallViewFrame;

  CGFloat collectionViewHeight = self.view.frame.size.height - headerHeight;
  CGFloat heightPadding =
      yOffset > kPestoViewControllerInset ? 0 : kPestoViewControllerInset - yOffset;

  _collectionView.frame =
      CGRectMake(kPestoViewControllerInset,
                 headerHeight + heightPadding,
                 _pestoHeaderView.frame.size.width - (2.f * kPestoViewControllerInset),
                 collectionViewHeight - heightPadding);

  MDCShadowLayer *pestoHeaderViewLayer = (MDCShadowLayer *)_pestoHeaderView.layer;
  pestoHeaderViewLayer.shadowMaskEnabled = NO;
  CGFloat elevation = MDCShadowElevationAppBar * _logoSmallView.layer.opacity;
  [pestoHeaderViewLayer setElevation:elevation];

  [CATransaction setDisableActions:NO];

  if (largeLogoOpacity < 0.33f) {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 0;
          _logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 1.f;
          _logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
}

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];

  NSInteger itemNum = indexPath.row;
  NSString *imageURL = [_baseURL stringByAppendingString:_images[itemNum]];
  cell.title = _titles[itemNum];
  cell.author = _authors[itemNum];
  cell.imageURL = imageURL;
  cell.icon = _icons[itemNum];
  cell.imageView = [self imageViewWithURL:imageURL];

  [cell setNeedsLayout];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  PestoDetailViewController *detailVC = [[PestoDetailViewController alloc] init];
  detailVC.image = cell.imageView.image;
  detailVC.imageURL = cell.imageURL;
  detailVC.title = cell.title;

  _zoomableView.frame =
      CGRectMake(cell.frame.origin.x + collectionView.frame.origin.x,
                 cell.frame.origin.y + collectionView.frame.origin.y - _scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  dispatch_async(dispatch_get_main_queue(), ^{
    [_zoomableView setImage:cell.imageView.image];
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _zoomableView.frame = self.view.frame;
        }
        completion:^(BOOL finished) {
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             _zoomableView.frame = CGRectZero;
                           }];
        }];
  });
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
#import "PestoCardCollectionViewCell.h"
#import "PestoDetailViewController.h"
#import "PestoSideView.h"
#import "PestoViewController.h"

#import "MaterialInk.h"
#import "MaterialScrollViewDelegateMultiplexer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoViewControllerInset = 5.f;
static CGFloat kPestoViewControllerSmallHeaderHeight = 100.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoHeaderView : UIView

@end

@implementation PestoHeaderView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoViewController () <UIScrollViewDelegate>

@property(nonatomic) CALayer *headerColorLayer;
@property(nonatomic) CGFloat initialCollectionViewHeight;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) CGSize initialLogoSize;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) MDCScrollViewDelegateMultiplexer *multiplexer;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSArray *icons;
@property(nonatomic) NSArray *images;
@property(nonatomic) NSArray *titles;
@property(nonatomic) NSArray *authors;
@property(nonatomic) NSString *baseURL;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) UIView *collapsedPestoHeaderView;
@property(nonatomic) UIImageView *logoView;
@property(nonatomic) UIImageView *logoSmallView;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) PestoHeaderView *pestoHeaderView;
@property(nonatomic) PestoSideView *sideView;

@end

@implementation PestoViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)setupData {
  _baseURL = @"https://www.gstatic.com/angular/material-adaptive/pesto/";
  _images = @[ @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg",
               @"IMG_0575.jpg",
               @"IMG_5438.jpg",
               @"IMG_5332.jpg",
               @"bok-choy.jpg",
               @"pasta.png",
               @"fish-steaks.jpg",
               @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _icons = @[ @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie" ];

  _imageCache = [[NSCache alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];

  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view.backgroundColor =
      [UIColor colorWithRed:0.9f
                      green:0.9f
                       blue:0.9f
                      alpha:1];
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoViewControllerInset)) / 2.f) - (2.f * kPestoViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width - (3.f * kPestoViewControllerInset)) / 3.f) - (2.f * kPestoViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);

  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];

  _initialCollectionViewHeight =
      self.view.frame.size.height - kPestoViewControllerDefaultHeaderHeight;

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset)];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView registerClass:[PestoCardCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_collectionView];

  _collectionView.delegate = self;
  [_multiplexer addObservingDelegate:self];

  CGRect PestoHeaderViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           kPestoViewControllerDefaultHeaderHeight);
  _pestoHeaderView = [[PestoHeaderView alloc] initWithFrame:PestoHeaderViewFrame];
  _headerColorLayer = [CALayer layer];
  _headerColorLayer.frame = PestoHeaderViewFrame;
  _headerColorLayer.backgroundColor = teal.CGColor;
  [_pestoHeaderView.layer addSublayer:_headerColorLayer];
  _pestoHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pestoHeaderView];

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  [_pestoHeaderView addSubview:_logoView];
  _initialLogoSize = _logoView.frame.size;

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [_pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:_pestoHeaderView];
  [_inkTouchController addInkView];

  [self adjustFramesWithScrollOffset:0];

  _zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _zoomableView.backgroundColor = [UIColor lightGrayColor];
  _zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_zoomableView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20, 30, 30, 30);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:_animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  _sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  _sideView.hidden = YES;
  _sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_sideView];
}

- (void)showMenu {
  _sideView.hidden = NO;
  [_sideView showSideView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adjustFramesWithScrollOffset:(CGFloat)yOffset {
  [CATransaction setDisableActions:YES];
  CGFloat headerHeight = kPestoViewControllerDefaultHeaderHeight - yOffset;

  if (headerHeight < kPestoViewControllerSmallHeaderHeight) {
    headerHeight = kPestoViewControllerSmallHeaderHeight;
  }

  _pestoHeaderView.frame = CGRectMake(0,
                                      0,
                                      _pestoHeaderView.frame.size.width,
                                      headerHeight);
  _headerColorLayer.frame = _pestoHeaderView.frame;

  CGFloat scale = headerHeight / kPestoViewControllerDefaultHeaderHeight;
  if (scale > 1) {
    scale = 1;
  }

  CGSize logoSize = CGSizeMake(_initialLogoSize.width * scale,
                               _initialLogoSize.height * scale);
  CGRect logoViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - logoSize.width) / 2.f,
                 (_pestoHeaderView.frame.size.height - logoSize.height) / 2.f +
                     (2.f * kPestoViewControllerInset),
                 logoSize.width,
                 logoSize.height);
  _logoView.frame = logoViewFrame;
  CGFloat largeLogoOpacity =
      (headerHeight - kPestoViewControllerSmallHeaderHeight) /
      (kPestoViewControllerDefaultHeaderHeight - kPestoViewControllerSmallHeaderHeight);

  CGRect logoSmallViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - _logoSmallView.frame.size.width) / 2.f,
                 (_pestoHeaderView.frame.size.height -
                  _logoSmallView.frame.size.height) /
                         2.f +
                     (2.f * kPestoViewControllerInset),
                 _logoSmallView.frame.size.width,
                 _logoSmallView.frame.size.height);
  _logoSmallView.frame = logoSmallViewFrame;

  CGFloat collectionViewHeight = self.view.frame.size.height - headerHeight;
  CGFloat heightPadding =
      yOffset > kPestoViewControllerInset ? 0 : kPestoViewControllerInset - yOffset;

  _collectionView.frame =
      CGRectMake(kPestoViewControllerInset,
                 headerHeight + heightPadding,
                 _pestoHeaderView.frame.size.width - (2.f * kPestoViewControllerInset),
                 collectionViewHeight - heightPadding);

  MDCShadowLayer *pestoHeaderViewLayer = (MDCShadowLayer *)_pestoHeaderView.layer;
  pestoHeaderViewLayer.shadowMaskEnabled = NO;
  CGFloat elevation = MDCShadowElevationAppBar * _logoSmallView.layer.opacity;
  [pestoHeaderViewLayer setElevation:elevation];

  [CATransaction setDisableActions:NO];

  if (largeLogoOpacity < 0.33f) {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 0;
          _logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 1.f;
          _logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
}

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];

  NSInteger itemNum = indexPath.row;
  NSString *imageURL = [_baseURL stringByAppendingString:_images[itemNum]];
  cell.title = _titles[itemNum];
  cell.author = _authors[itemNum];
  cell.imageURL = imageURL;
  cell.icon = _icons[itemNum];
  cell.imageView = [self imageViewWithURL:imageURL];

  [cell setNeedsLayout];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  PestoDetailViewController *detailVC = [[PestoDetailViewController alloc] init];
  detailVC.image = cell.imageView.image;
  detailVC.imageURL = cell.imageURL;
  detailVC.title = cell.title;

  _zoomableView.frame =
      CGRectMake(cell.frame.origin.x + collectionView.frame.origin.x,
                 cell.frame.origin.y + collectionView.frame.origin.y - _scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  dispatch_async(dispatch_get_main_queue(), ^{
    [_zoomableView setImage:cell.imageView.image];
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _zoomableView.frame = self.view.frame;
        }
        completion:^(BOOL finished) {
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             _zoomableView.frame = CGRectZero;
                           }];
        }];
  });
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
#import "PestoCardCollectionViewCell.h"
#import "PestoDetailViewController.h"
#import "PestoSideView.h"
#import "PestoViewController.h"

#import "MaterialInk.h"
#import "MaterialScrollViewDelegateMultiplexer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoViewControllerInset = 5.f;
static CGFloat kPestoViewControllerSmallHeaderHeight = 100.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoHeaderView : UIView

@end

@implementation PestoHeaderView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoViewController () <UIScrollViewDelegate>

@property(nonatomic) CALayer *headerColorLayer;
@property(nonatomic) CGFloat initialCollectionViewHeight;
@property(nonatomic) CGFloat scrollOffsetY;
@property(nonatomic) CGSize cellSize;
@property(nonatomic) CGSize initialLogoSize;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) MDCScrollViewDelegateMultiplexer *multiplexer;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSArray *icons;
@property(nonatomic) NSArray *images;
@property(nonatomic) NSArray *titles;
@property(nonatomic) NSArray *authors;
@property(nonatomic) NSString *baseURL;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) UIView *collapsedPestoHeaderView;
@property(nonatomic) UIImageView *logoView;
@property(nonatomic) UIImageView *logoSmallView;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) PestoHeaderView *pestoHeaderView;
@property(nonatomic) PestoSideView *sideView;

@end

@implementation PestoViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)setupData {
  _baseURL = @"https://www.gstatic.com/angular/material-adaptive/pesto/";
  _images = @[ @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg",
               @"IMG_0575.jpg",
               @"IMG_5438.jpg",
               @"IMG_5332.jpg",
               @"bok-choy.jpg",
               @"pasta.png",
               @"fish-steaks.jpg",
               @"image2-01.png",
               @"blue-potato.jpg",
               @"image1-01.png",
               @"sausage.jpg",
               @"white-rice.jpg",
               @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _icons = @[ @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Fish",
              @"Healthy",
              @"Main",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie",
              @"Meat",
              @"Spicy",
              @"Veggie" ];

  _imageCache = [[NSCache alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];

  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view.backgroundColor =
      [UIColor colorWithRed:0.9f
                      green:0.9f
                       blue:0.9f
                      alpha:1];
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoViewControllerInset)) / 2.f) - (2.f * kPestoViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width - (3.f * kPestoViewControllerInset)) / 3.f) - (2.f * kPestoViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);

  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];

  _initialCollectionViewHeight =
      self.view.frame.size.height - kPestoViewControllerDefaultHeaderHeight;

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  [layout setSectionInset:UIEdgeInsetsMake(kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset,
                                           kPestoViewControllerInset)];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:layout];
  _collectionView.contentSize = _collectionView.bounds.size;
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView registerClass:[PestoCardCollectionViewCell class]
      forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
  [_collectionView setBackgroundColor:[UIColor clearColor]];
  _collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_collectionView];

  _collectionView.delegate = self;
  [_multiplexer addObservingDelegate:self];

  CGRect PestoHeaderViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           kPestoViewControllerDefaultHeaderHeight);
  _pestoHeaderView = [[PestoHeaderView alloc] initWithFrame:PestoHeaderViewFrame];
  _headerColorLayer = [CALayer layer];
  _headerColorLayer.frame = PestoHeaderViewFrame;
  _headerColorLayer.backgroundColor = teal.CGColor;
  [_pestoHeaderView.layer addSublayer:_headerColorLayer];
  _pestoHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pestoHeaderView];

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  [_pestoHeaderView addSubview:_logoView];
  _initialLogoSize = _logoView.frame.size;

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [_pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:_pestoHeaderView];
  [_inkTouchController addInkView];

  [self adjustFramesWithScrollOffset:0];

  _zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _zoomableView.backgroundColor = [UIColor lightGrayColor];
  _zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_zoomableView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20, 30, 30, 30);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:_animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  _sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  _sideView.hidden = YES;
  _sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_sideView];
}

- (void)showMenu {
  _sideView.hidden = NO;
  [_sideView showSideView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)adjustFramesWithScrollOffset:(CGFloat)yOffset {
  [CATransaction setDisableActions:YES];
  CGFloat headerHeight = kPestoViewControllerDefaultHeaderHeight - yOffset;

  if (headerHeight < kPestoViewControllerSmallHeaderHeight) {
    headerHeight = kPestoViewControllerSmallHeaderHeight;
  }

  _pestoHeaderView.frame = CGRectMake(0,
                                      0,
                                      _pestoHeaderView.frame.size.width,
                                      headerHeight);
  _headerColorLayer.frame = _pestoHeaderView.frame;

  CGFloat scale = headerHeight / kPestoViewControllerDefaultHeaderHeight;
  if (scale > 1) {
    scale = 1;
  }

  CGSize logoSize = CGSizeMake(_initialLogoSize.width * scale,
                               _initialLogoSize.height * scale);
  CGRect logoViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - logoSize.width) / 2.f,
                 (_pestoHeaderView.frame.size.height - logoSize.height) / 2.f +
                     (2.f * kPestoViewControllerInset),
                 logoSize.width,
                 logoSize.height);
  _logoView.frame = logoViewFrame;
  CGFloat largeLogoOpacity =
      (headerHeight - kPestoViewControllerSmallHeaderHeight) /
      (kPestoViewControllerDefaultHeaderHeight - kPestoViewControllerSmallHeaderHeight);

  CGRect logoSmallViewFrame =
      CGRectMake((_pestoHeaderView.frame.size.width - _logoSmallView.frame.size.width) / 2.f,
                 (_pestoHeaderView.frame.size.height -
                  _logoSmallView.frame.size.height) /
                         2.f +
                     (2.f * kPestoViewControllerInset),
                 _logoSmallView.frame.size.width,
                 _logoSmallView.frame.size.height);
  _logoSmallView.frame = logoSmallViewFrame;

  CGFloat collectionViewHeight = self.view.frame.size.height - headerHeight;
  CGFloat heightPadding =
      yOffset > kPestoViewControllerInset ? 0 : kPestoViewControllerInset - yOffset;

  _collectionView.frame =
      CGRectMake(kPestoViewControllerInset,
                 headerHeight + heightPadding,
                 _pestoHeaderView.frame.size.width - (2.f * kPestoViewControllerInset),
                 collectionViewHeight - heightPadding);

  MDCShadowLayer *pestoHeaderViewLayer = (MDCShadowLayer *)_pestoHeaderView.layer;
  pestoHeaderViewLayer.shadowMaskEnabled = NO;
  CGFloat elevation = MDCShadowElevationAppBar * _logoSmallView.layer.opacity;
  [pestoHeaderViewLayer setElevation:elevation];

  [CATransaction setDisableActions:NO];

  if (largeLogoOpacity < 0.33f) {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 0;
          _logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          _logoView.layer.opacity = 1.f;
          _logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
}

- (UIImageView *)imageViewWithURL:(NSString *)url {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSData *imageData = [_imageCache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];

  NSInteger itemNum = indexPath.row;
  NSString *imageURL = [_baseURL stringByAppendingString:_images[itemNum]];
  cell.title = _titles[itemNum];
  cell.author = _authors[itemNum];
  cell.imageURL = imageURL;
  cell.icon = _icons[itemNum];
  cell.imageView = [self imageViewWithURL:imageURL];

  [cell setNeedsLayout];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  PestoDetailViewController *detailVC = [[PestoDetailViewController alloc] init];
  detailVC.image = cell.imageView.image;
  detailVC.imageURL = cell.imageURL;
  detailVC.title = cell.title;

  _zoomableView.frame =
      CGRectMake(cell.frame.origin.x + collectionView.frame.origin.x,
                 cell.frame.origin.y + collectionView.frame.origin.y - _scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  dispatch_async(dispatch_get_main_queue(), ^{
    [_zoomableView setImage:cell.imageView.image];
    [UIView animateWithDuration:kPestoViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _zoomableView.frame = self.view.frame;
        }
        completion:^(BOOL finished) {
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             _zoomableView.frame = CGRectZero;
                           }];
        }];
  });
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [self adjustFramesWithScrollOffset:_scrollOffsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
