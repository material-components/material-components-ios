// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "supplemental/CollectionsContainerExample.h"
#import "MaterialCollections.h"

static const NSInteger kSectionCount = 2;
static const NSInteger kSectionItemCount = 2;
static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@implementation CollectionsContainerExample {
  MDCCollectionViewController *_collectionsController;
  NSMutableArray<NSMutableArray *> *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  // Create gray view to contain collection view.
  UIView *container =
      [[UIView alloc] initWithFrame:CGRectMake(30, 200, self.view.bounds.size.width - 60,
                                               self.view.bounds.size.height - 200 - 30)];
  container.backgroundColor = [UIColor lightGrayColor];
  container.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:container];

  // Create collection view controller.
  _collectionsController = [[MDCCollectionViewController alloc] init];
  _collectionsController.collectionView.dataSource = self;
  [container addSubview:_collectionsController.view];
  [_collectionsController.view setFrame:container.bounds];

  // Register cell class.
  [_collectionsController.collectionView registerClass:[MDCCollectionViewTextCell class]
                            forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content.
  _content = [NSMutableArray array];
  for (NSInteger i = 0; i < kSectionCount; i++) {
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger j = 0; j < kSectionItemCount; j++) {
      NSString *itemString = [NSString stringWithFormat:@"Section-%ld Item-%ld", (long)i, (long)j];
      [items addObject:itemString];
    }
    [_content addObject:items];
  }

  // Customize collection view settings.
  _collectionsController.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return [_content count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [_content[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _content[indexPath.section][indexPath.item];
  return cell;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collections", @"Collections in a Container" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
