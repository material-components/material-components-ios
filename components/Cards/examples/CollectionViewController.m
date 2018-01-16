//
//  CollectionViewController.m
//  MaterialComponentsExamples
//
//  Created by Yarden Eitan on 1/8/18.
//

#import "CollectionViewController.h"
#import "MaterialInk.h"
#import "UICollectionViewController+MDCCardReordering.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController {
  NSMutableArray *_content;
}

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";
@synthesize collectionViewLayout = _collectionViewLayout;

- (instancetype)init {
  UICollectionViewFlowLayout *defaultLayout = [[UICollectionViewFlowLayout alloc] init];
  defaultLayout.minimumInteritemSpacing = 0;
  defaultLayout.minimumLineSpacing = 1;
  defaultLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  return [self initWithCollectionViewLayout:defaultLayout];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    _collectionViewLayout = layout;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
  self.collectionView.alwaysBounceVertical = YES;
  // Register cell classes
  [self.collectionView registerClass:[MDCCollectionViewCardCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  _content = [NSMutableArray array];
  for (int i=0; i<20; i++) {
    [_content addObject:@[[NSString stringWithFormat:@"(Left) Two line text %d", i],
                          [NSString stringWithFormat:@"(Left) here is the detail text %d", i]]];
  }

  [self mdc_setupCardReordering];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [_content count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewCardCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                            forIndexPath:indexPath];
  [cell setBackgroundColor:[UIColor colorWithRed:107/255.f green:63/255.f blue:238/255.f alpha:1]];
  return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat cardSize = (self.view.bounds.size.width / 3) - 12;
  return CGSizeMake(cardSize, cardSize);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 8.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 8.f;
}

#pragma mark - Reordering

- (void)collectionView:(UICollectionView *)collectionView
   moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath
           toIndexPath:(NSIndexPath *)destinationIndexPath {
}

- (BOOL)collectionView:(UICollectionView *)collectionView
canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Cards", @"Collection Card Cells" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"Material Cards.";
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

+ (BOOL)catalogIsDebug {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
