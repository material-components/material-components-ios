#import "PestoCollectionViewController.h"
#import "PestoCardCollectionViewCell.h"
#import "PestoData.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"

static CGFloat kPestoCollectionViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoCollectionViewControllerDefaultHeaderHeight = 240.f;
static CGFloat kPestoCollectionViewControllerInset = 5.f;
static CGFloat kPestoCollectionViewControllerSmallHeaderHeight = 64.f;

@interface PestoCollectionViewController ()

@property(nonatomic) CGFloat logoScale;
@property(nonatomic) UIView *logoSmallView;
@property(nonatomic) UIView *logoView;
@property(nonatomic) PestoData *pestoData;

@end

@implementation PestoCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PestoCardCollectionViewCell class]
            forCellWithReuseIdentifier:@"PestoCardCollectionViewCell"];
    _pestoData = [[PestoData alloc] init];
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
  [headerView setShadowLayer:shadowLayer
      intensityDidChangeBlock:^(CALayer *layer,
                                CGFloat intensity) {
        CGFloat elevation = MDCShadowElevationAppBar * intensity;
        [(MDCShadowLayer *)layer setElevation:elevation];
      }];
}

- (NSInteger)collectionView:(UICollectionView *)view
     numberOfItemsInSection:(NSInteger)section {
  return (NSInteger)[self.pestoData.imageFileNames count];
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self.collectionView.collectionViewLayout invalidateLayout];
  [self centerHeader];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.collectionView.collectionViewLayout invalidateLayout];
  [self centerHeader];
}

- (void)centerHeader {
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  CGRect headerFrame = self.flexHeaderContainerVC.headerViewController.headerView.bounds;
  self.logoView.center = CGPointMake(width / 2.f,
                                     headerFrame.size.height / 2.f);
  self.logoSmallView.center = CGPointMake(width / 2.f,
                                          headerFrame.size.height / 2.f);
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"PestoCardCollectionViewCell"
                                                forIndexPath:indexPath];
  NSUInteger itemNum = (NSUInteger)indexPath.row;
  NSString *baseURL = PestoDataBaseURL;
  NSString *imageURLString =
      [baseURL stringByAppendingString:self.pestoData.imageFileNames[itemNum]];
  NSURL *imageURL = [NSURL URLWithString:imageURLString];
  NSString *title = self.pestoData.titles[itemNum];
  NSString *author = self.pestoData.authors[itemNum];
  NSString *iconName = self.pestoData.iconNames[itemNum];
  cell.descText = self.pestoData.descriptions[itemNum];
  [cell populateContentWithTitle:title author:author imageURL:imageURL iconName:iconName];

  return cell;
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
  [self.delegate didSelectCell:cell
                    completion:^{
                    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  self.scrollOffsetY = scrollView.contentOffset.y;
  [self.flexHeaderContainerVC.headerViewController scrollViewDidScroll:scrollView];
  CGRect headerFrame = self.flexHeaderContainerVC.headerViewController.headerView.bounds;
  self.logoView.center = CGPointMake(headerFrame.size.width / 2.f,
                                     headerFrame.size.height / 2.f);
  self.logoSmallView.center = CGPointMake(headerFrame.size.width / 2.f,
                                          headerFrame.size.height / 2.f);

  self.logoScale = scrollView.contentOffset.y / -kPestoCollectionViewControllerDefaultHeaderHeight;

  if (self.logoScale < 0.5f) {
    self.logoScale = 0.5f;
    [UIView animateWithDuration:kPestoCollectionViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          self.logoView.layer.opacity = 0;
          self.logoSmallView.layer.opacity = 1.f;
        }
        completion:^(BOOL finished){
        }];
  } else {
    [UIView animateWithDuration:kPestoCollectionViewControllerAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          self.logoView.layer.opacity = 1.f;
          self.logoSmallView.layer.opacity = 0;
        }
        completion:^(BOOL finished){
        }];
  }
  self.logoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.logoScale,
                                                   self.logoScale);
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
  _logoView.center = CGPointMake(pestoHeaderView.frame.size.width / 2.f,
                                 pestoHeaderView.frame.size.height / 2.f);
  [pestoHeaderView addSubview:_logoView];

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [pestoHeaderView addSubview:_logoSmallView];

  return pestoHeaderView;
}

- (CGSize)cellSize {
  CGFloat margins = (2.f * kPestoCollectionViewControllerInset);
  CGFloat cellDim = self.view.frame.size.width - margins * 2.f;
  CGFloat maxCellWidth = 400.f;
  if (cellDim > maxCellWidth && cellDim < maxCellWidth * 2.f) {
    cellDim = floor((self.view.frame.size.width -
                     (2.f * kPestoCollectionViewControllerInset)) /
                    2.f) -
              (2.f * kPestoCollectionViewControllerInset);
  } else if (cellDim >= maxCellWidth * 2.f) {
    cellDim = floor((self.view.frame.size.width -
                     (3.f * kPestoCollectionViewControllerInset)) /
                    3.f) -
              (2.f * kPestoCollectionViewControllerInset);
  }
  return CGSizeMake(cellDim, 300.f);
}

@end
