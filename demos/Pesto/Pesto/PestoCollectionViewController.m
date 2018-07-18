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

#import "PestoCollectionViewController.h"
#import "PestoCardCollectionViewCell.h"
#import "PestoData.h"

#import "MaterialInk.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

static CGFloat kPestoCollectionViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoCollectionViewControllerCellHeight = 300.f;
static CGFloat kPestoCollectionViewControllerDefaultHeaderHeight = 220.f;
static CGFloat kPestoCollectionViewControllerInset = 5.f;
static CGFloat kPestoCollectionViewControllerSmallHeaderHeight = 56.f;

@interface PestoCollectionViewController ()

@property(nonatomic) CGFloat logoScale;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property(nonatomic) PestoData *pestoData;
@property(nonatomic) UIView *logoSmallView;
@property(nonatomic) UIView *logoView;

@end

@implementation PestoCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PestoCardCollectionViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass([PestoCardCollectionViewCell class])];
    _pestoData = [[PestoData alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
  self.styler.cellLayoutType = MDCCollectionViewCellLayoutTypeGrid;
  self.styler.gridPadding = kPestoCollectionViewControllerInset * 2;
  if (self.view.frame.size.width < self.view.frame.size.height) {
    self.styler.gridColumnCount = 1;
  } else {
    self.styler.gridColumnCount = 2;
  }
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  if (size.width < size.height) {
    self.styler.gridColumnCount = 1;
  } else {
    self.styler.gridColumnCount = 2;
  }
  [self.collectionView.collectionViewLayout invalidateLayout];
  [self centerHeaderWithSize:size];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.collectionView.collectionViewLayout invalidateLayout];
  [self centerHeaderWithSize:self.view.frame.size];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return (NSInteger)[self.pestoData.imageFileNames count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PestoCardCollectionViewCell *cell = [collectionView
      dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PestoCardCollectionViewCell class])
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

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  PestoCardCollectionViewCell *cell =
      (PestoCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  [self.delegate didSelectCell:cell
                    completion:^{
                    }];
}

#pragma mark - <MDCCollectionViewStylingDelegate>

- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  return kPestoCollectionViewControllerCellHeight;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  self.scrollOffsetY = scrollView.contentOffset.y;
  [self.flexHeaderContainerVC.headerViewController scrollViewDidScroll:scrollView];
  [self centerHeaderWithSize:self.view.frame.size];
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
  self.logoView.transform =
      CGAffineTransformScale(CGAffineTransformIdentity, self.logoScale, self.logoScale);
}

#pragma mark - Private methods

- (void)centerHeaderWithSize:(CGSize)size {
  CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
  CGFloat width = size.width;
  CGRect headerFrame = self.flexHeaderContainerVC.headerViewController.headerView.bounds;
  self.logoView.center = CGPointMake(width / 2.f, headerFrame.size.height / 2.f);
  self.logoSmallView.center =
      CGPointMake(width / 2.f, (headerFrame.size.height - statusBarHeight) / 2.f + statusBarHeight);
}

- (UIView *)pestoHeaderView {
  CGRect headerFrame = _flexHeaderContainerVC.headerViewController.headerView.bounds;
  UIView *pestoHeaderView = [[UIView alloc] initWithFrame:headerFrame];
  UIColor *teal = [UIColor colorWithRed:0.f green:0.67f blue:0.55f alpha:1.f];
  pestoHeaderView.backgroundColor = teal;
  pestoHeaderView.layer.masksToBounds = YES;
  pestoHeaderView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

  UIImage *image = [UIImage imageNamed:@"PestoLogoLarge"];
  _logoView = [[UIImageView alloc] initWithImage:image];
  _logoView.contentMode = UIViewContentModeScaleAspectFill;
  _logoView.center =
      CGPointMake(pestoHeaderView.frame.size.width / 2.f, pestoHeaderView.frame.size.height / 2.f);
  [pestoHeaderView addSubview:_logoView];

  UIImage *logoSmallImage = [UIImage imageNamed:@"PestoLogoSmall"];
  _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
  _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
  _logoSmallView.layer.opacity = 0;
  [pestoHeaderView addSubview:_logoSmallView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:pestoHeaderView];
  [_inkTouchController addInkView];

  return pestoHeaderView;
}

- (void)setFlexHeaderContainerVC:(MDCFlexibleHeaderContainerViewController *)flexHeaderContainerVC {
  _flexHeaderContainerVC = flexHeaderContainerVC;
  MDCFlexibleHeaderView *headerView = _flexHeaderContainerVC.headerViewController.headerView;
  headerView.trackingScrollView = self.collectionView;
  headerView.maximumHeight = kPestoCollectionViewControllerDefaultHeaderHeight;
  headerView.minimumHeight = kPestoCollectionViewControllerSmallHeaderHeight;
  headerView.minMaxHeightIncludesSafeArea = NO;
  [headerView addSubview:[self pestoHeaderView]];

  // Use a custom shadow under the flexible header.
  MDCShadowLayer *shadowLayer = [MDCShadowLayer layer];
  [headerView setShadowLayer:shadowLayer
      intensityDidChangeBlock:^(CALayer *layer, CGFloat intensity) {
        CGFloat elevation = MDCShadowElevationAppBar * intensity;
        [(MDCShadowLayer *)layer setElevation:elevation];
      }];
}

@end
