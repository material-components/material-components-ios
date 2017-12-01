//
//  CollectionCellsDefaultUICollectionView.m
//  MaterialCatalog
//
//  Created by yar on 12/1/17.
//

#import "CollectionCellsDefaultUICollectionView.h"

@interface CollectionCellsDefaultUICollectionView () <MDCInkTouchControllerDelegate>

@end

@implementation CollectionCellsDefaultUICollectionView {
  NSMutableArray *_content;
  MDCInkTouchController *_inkTouchController;
  CGPoint _inkTouchLocation;
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
  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.alwaysBounceVertical = YES;
  
  _inkTouchController = [[MDCInkTouchController alloc] initWithView:self.collectionView];
  _inkTouchController.delegate = self;
    
  // Register cell classes
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];
    
  _content = [NSMutableArray array];
  for (int i=0; i<10; i++) {
    [_content addObject:@[[NSString stringWithFormat:@"(Left) Two line text %d", i],
                          [NSString stringWithFormat:@"(Left) here is the detail text %d", i]]];
  }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [_content count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                            forIndexPath:indexPath];
  cell.textLabel.text = _content[indexPath.item][0];
  cell.detailTextLabel.text = _content[indexPath.item][1];
  return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  return MDCCellDefaultTwoLineHeight;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(self.collectionView.frame.size.width, MDCCellDefaultTwoLineHeight);
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collection Cells", @"Cell with UICollectionViewController" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (void)collectionView:(UICollectionView *)collectionView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  CGPoint location = [collectionView convertPoint:_inkTouchLocation toView:cell];
  
  MDCInkView *inkView;
  if ([cell respondsToSelector:@selector(inkView)]) {
    inkView = [cell performSelector:@selector(inkView)];
  } else {
    return;
  }

  [inkView startTouchBeganAnimationAtPoint:location completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  CGPoint location = [collectionView convertPoint:_inkTouchLocation toView:cell];
  
  MDCInkView *inkView;
  if ([cell respondsToSelector:@selector(inkView)]) {
    inkView = [cell performSelector:@selector(inkView)];
  } else {
    return;
  }
  
  [inkView startTouchEndedAnimationAtPoint:location completion:nil];
}

#pragma mark - <MDCInkTouchControllerDelegate>

- (BOOL)inkTouchController:(__unused MDCInkTouchController *)inkTouchController
shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
    _inkTouchLocation = location;
  return NO;
}

@end
