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
  self.collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
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
  return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [_content count]/2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                            forIndexPath:indexPath];
  cell.textLabel.text = _content[indexPath.item][0];
  cell.detailTextLabel.text = _content[indexPath.item][1];
  cell.backgroundColor = [UIColor whiteColor];
  [(MDCShadowLayer *)cell.layer setElevation:2.f];
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
  return CGSizeMake(self.collectionView.frame.size.width-16, MDCCellDefaultTwoLineHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(8, 8, 0, 8);
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
