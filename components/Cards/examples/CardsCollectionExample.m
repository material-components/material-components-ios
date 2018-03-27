/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "CardsCollectionExample.h"
#import "MaterialInk.h"
#import "MaterialChips.h"
#import "UICollectionViewController+MDCCardReordering.h"

@interface MDCCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) MDCChipView *chip;
@end

@implementation MDCCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    self.button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.chip = [[MDCChipView alloc] initWithFrame:CGRectMake(45, 0, 40, 20)];
    self.chip.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.button setTitle:@"B" forState:UIControlStateNormal];
    self.chip.titleLabel.text = @"C";
    [self addSubview:self.button];
    [self addSubview:self.chip];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    self.button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.chip = [[MDCChipView alloc] initWithFrame:CGRectMake(45, 0, 40, 20)];
    self.chip.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.button setTitle:@"B" forState:UIControlStateNormal];
    self.chip.titleLabel.text = @"C";
    [self addSubview:self.button];
    [self addSubview:self.chip];
  }
  return self;
}

@end

@interface CardsCollectionExample ()

@end
static NSUInteger nextCellIdentifier = 7U;
@implementation CardsCollectionExample {
  NSMutableDictionary<NSString *, UIGestureRecognizer *> *_gestureRecognizers;
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
    _gestureRecognizers = [@{} mutableCopy];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:1];
  self.collectionView.alwaysBounceVertical = YES;
  // Register cell classes
  [self.collectionView registerClass:[MDCCell  class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  [self mdc_setupCardReordering];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                            forIndexPath:indexPath];
  if (!cell.accessibilityIdentifier) {
    cell.accessibilityIdentifier = [NSString stringWithFormat:@"%lu", (unsigned long)nextCellIdentifier++];
  }
  [cell setBackgroundColor:[UIColor colorWithRed:107/255.f green:63/255.f blue:238/255.f alpha:1]];
  [cell.button removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
  [cell.button addTarget:self action:@selector(didTap:) forControlEvents:UIControlEventTouchUpInside];
  [cell.chip removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
  [cell.chip addTarget:self action:@selector(didTap:) forControlEvents:UIControlEventTouchUpInside];
  UIGestureRecognizer *oldRecognizer = _gestureRecognizers[cell.accessibilityIdentifier];
  if (oldRecognizer) {
    [cell removeGestureRecognizer:oldRecognizer];
  }
  UIGestureRecognizer *newRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
  _gestureRecognizers[cell.accessibilityIdentifier] = newRecognizer;
  [cell addGestureRecognizer:newRecognizer];
  return cell;
}

- (void)didTap:(id)sender {
  if ([sender class] == [MDCChipView class]) {
    NSLog(@"Chip!");
  }
  else if ([sender class] == [UIButton class]) {
    NSLog(@"Button!");
  }
  else {
    NSLog(@"%@",sender);
  }
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
  return NO;
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
