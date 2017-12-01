//
//  CollectionCellsDefaultUICollectionView.m
//  MaterialCatalog
//
//  Created by yar on 12/1/17.
//

#import "CollectionCellsDefaultUICollectionView.h"

@interface CollectionCellsDefaultUICollectionView ()

@end

@implementation CollectionCellsDefaultUICollectionView {
  NSMutableArray *_content;
}

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";
static NSString *const kExampleDetailText =
@"Pellentesque non quam ornare, porta urna sed, malesuada felis. Praesent at gravida felis, "
"non facilisis enim. Proin dapibus laoreet lorem, in viverra leo dapibus a.";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MDCCollectionViewTextCell class]
            forCellWithReuseIdentifier:kReusableIdentifierItem];
    
  _content = [NSMutableArray array];
  NSDictionary *alignmentValues = @{
                                    @"Left" : @(NSTextAlignmentLeft),
                                    @"Right" : @(NSTextAlignmentRight),
                                    @"Center" : @(NSTextAlignmentCenter),
                                    @"Just." : @(NSTextAlignmentJustified),
                                    @"Natural" : @(NSTextAlignmentNatural)
                                    };

  for (NSString *alignmentKey in alignmentValues) {
    [_content addObject:@[
                          [NSString stringWithFormat:@"(%@) Single line text", alignmentKey],
                          alignmentValues[alignmentKey], @"", alignmentValues[alignmentKey],
                          @(MDCCellDefaultOneLineHeight)
                          ]];
    [_content addObject:@[
                          @"", alignmentValues[alignmentKey],
                          [NSString stringWithFormat:@"(%@) Single line detail text", alignmentKey],
                          alignmentValues[alignmentKey], @(MDCCellDefaultOneLineHeight)
                          ]];
    [_content addObject:@[
                          [NSString stringWithFormat:@"(%@) Two line text", alignmentKey],
                          alignmentValues[alignmentKey],
                          [NSString stringWithFormat:@"(%@) Here is the detail text", alignmentKey],
                          alignmentValues[alignmentKey], @(MDCCellDefaultTwoLineHeight)
                          ]];
    [_content addObject:@[
                          [NSString stringWithFormat:@"(%@) Two line text (truncated)", alignmentKey],
                          alignmentValues[alignmentKey],
                          [NSString stringWithFormat:@"(%@) %@", alignmentKey, kExampleDetailText],
                          alignmentValues[alignmentKey], @(MDCCellDefaultTwoLineHeight)
                          ]];
    [_content addObject:@[
                          [NSString stringWithFormat:@"(%@) Three line text (wrapped)", alignmentKey],
                          alignmentValues[alignmentKey],
                          [NSString stringWithFormat:@"(%@) %@", alignmentKey, kExampleDetailText],
                          alignmentValues[alignmentKey], @(MDCCellDefaultThreeLineHeight)
                          ]];
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
  cell.textLabel.textAlignment = [_content[indexPath.item][1] integerValue];
  cell.detailTextLabel.text = _content[indexPath.item][2];
  cell.detailTextLabel.textAlignment = [_content[indexPath.item][3] integerValue];

  if (indexPath.item % 5 == 4) {
    cell.detailTextLabel.numberOfLines = 2;
  }
  return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  return [_content[indexPath.item][4] floatValue];
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collection Cells", @"Cell with UICollectionViewController" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
