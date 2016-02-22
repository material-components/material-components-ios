#import "PestoCollectionViewController.h"
#import "PestoCardCollectionViewCell.h"
#import "PestoData.h"
#import "PestoRemoteImageService.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"

static CGFloat kPestoCollectionViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoCollectionViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoCollectionViewControllerInset = 5.f;
static CGFloat kPestoCollectionViewControllerSmallHeaderHeight = 120.f;

@interface PestoCollectionViewController ()

@property (nonatomic) CGFloat logoScale;
@property (nonatomic) UIView *logoSmallView;
@property (nonatomic) UIView *logoView;
@property (nonatomic) PestoData *pestoData;
@property (nonatomic) PestoRemoteImageService *imageService;

@end

@implementation PestoCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PestoCardCollectionViewCell class]
            forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
    self.pestoData = [[PestoData alloc] init];
    self.imageService = [PestoRemoteImageService sharedService];
    [self setNeedsStatusBarAppearanceUpdate];
  }
  return self;
}

- (void)setFlexHeaderContainerVC:(MDCFlexibleHeaderContainerViewController *)flexHeaderContainerVC {
  _flexHeaderContainerVC = flexHeaderContainerVC;
  MDCFlexibleHeaderView *headerView = _flexHeaderContainerVC.headerViewController.headerView;
  headerView.trackingScrollView = self.collectionView;
  headerView.maximumHeight = kPestoCollectionViewControllerDefaultHeaderHeight;
  headerView.minimumHeight = kPestoCollectionViewControllerSmallHeaderHeight;
  [headerView.contentView addSubview:[self pestoHeaderView]];

  // Use a custom shadow under the flexible header.
  MDCShadowLayer *shadowLayer = [MDCShadowLayer layer];
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationNone];
  headerView.shadowLayer = shadowLayer;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (NSInteger)collectionView:(UICollectionView *)view
     numberOfItemsInSection:(NSInteger)section {
  return [self.pestoData.imageFileNames count];
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  CGRect headerFrame = _flexHeaderContainerVC.headerViewController.headerView.bounds;
  _logoView.center = CGPointMake(headerFrame.size.width / 2.f,
                                 headerFrame.size.height / 2.f);
  _logoSmallView.center = CGPointMake(headerFrame.size.width / 2.f,
                                      headerFrame.size.height / 2.f);
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];
  NSInteger itemNum = indexPath.row;
  NSString *baseURL = PestoDataBaseURL;
  NSString *imageURLString =
      [baseURL stringByAppendingString:self.pestoData.imageFileNames[itemNum]];
  NSURL *imageURL = [NSURL URLWithString:imageURLString];

  cell.title = self.pestoData.titles[itemNum];
  cell.author = self.pestoData.authors[itemNum];
  cell.imageURL = imageURLString;
  cell.icon = self.pestoData.iconNames[itemNum];
  [self updateImageViewWithURL:imageURL cell:cell];
  [cell setNeedsLayout];

  return cell;
}

- (void)updateImageViewWithURL:(NSURL *)imageURL
                                   cell:(PestoCardCollectionViewCell *)cell {
  [_imageService fetchImageDataFromURL:imageURL
                            completion:^(NSData *imageData) {
                              if (!imageData) {
                                return;
                              }
                              dispatch_async(dispatch_get_main_queue(), ^{
                                UIImage *image = [UIImage imageWithData:imageData];
                                UIImage *thumbnailImage =
                                    [_imageService.thumbnailCache objectForKey:imageURL];
                                cell.image = image;
                                cell.imageView.image = thumbnailImage;
                                [cell setNeedsLayout];
                              });
                            }];
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.cellSize;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  [self.delegate didSelectCell:cell completion:^{
  }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  _scrollOffsetY = scrollView.contentOffset.y;
  [_flexHeaderContainerVC.headerViewController scrollViewDidScroll:scrollView];
  CGRect headerFrame = _flexHeaderContainerVC.headerViewController.headerView.bounds;
  _logoView.center = CGPointMake(headerFrame.size.width / 2.f,
                                 headerFrame.size.height / 2.f);
  _logoSmallView.center = CGPointMake(headerFrame.size.width / 2.f,
                                      headerFrame.size.height / 2.f);

  _logoScale = scrollView.contentOffset.y / -kPestoCollectionViewControllerDefaultHeaderHeight;

  if (_logoScale < 0.5f) {
    _logoScale = 0.5f;
    [UIView animateWithDuration:kPestoCollectionViewControllerAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       _logoView.layer.opacity = 0;
                       _logoSmallView.layer.opacity = 1.f;
                     }
                     completion:^(BOOL finished){
                     }];
  } else {
    [UIView animateWithDuration:kPestoCollectionViewControllerAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       _logoView.layer.opacity = 1.f;
                       _logoSmallView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished){
                     }];
  }
  _logoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, _logoScale, _logoScale);

  MDCFlexibleHeaderView *headerView = _flexHeaderContainerVC.headerViewController.headerView;
  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)headerView.shadowLayer;
  CGFloat elevation = MDCShadowElevationAppBar * headerView.shadowIntensity;
  [shadowLayer setElevation:elevation];
}

#pragma mark - Private methods

- (UIView *)pestoHeaderView {
  CGRect headerFrame = _flexHeaderContainerVC.headerViewController.headerView.bounds;
  UIView *pestoHeaderView = [[UIView alloc] initWithFrame:headerFrame];
  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1];
  pestoHeaderView.backgroundColor = teal;
  pestoHeaderView.layer.masksToBounds = YES;
  pestoHeaderView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  _logoView.center = CGPointMake(pestoHeaderView.frame.size.width  / 2,
                                 pestoHeaderView.frame.size.height / 2);
  [pestoHeaderView addSubview:_logoView];

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [pestoHeaderView addSubview:_logoSmallView];

  return pestoHeaderView;
}

- (CGSize)cellSize {
  CGFloat cellDim = floor((self.view.frame.size.width - (2.f * kPestoCollectionViewControllerInset))
                          / 2.f) - (2.f * kPestoCollectionViewControllerInset);
  if (cellDim > 320) {
    cellDim = floor((self.view.frame.size.width -
                     (3.f * kPestoCollectionViewControllerInset)) / 3.f) -
                     (2.f * kPestoCollectionViewControllerInset);
  }
  self.cellSize = CGSizeMake(cellDim, cellDim);
  return CGSizeMake(cellDim, cellDim);
}

@end
