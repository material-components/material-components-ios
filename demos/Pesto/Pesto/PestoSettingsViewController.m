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

#import "PestoSettingsViewController.h"

#import "MaterialAppBar.h"

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";

@interface PestoSettingsViewController ()

@property(nonatomic, strong) MDCAppBar *appBar;
@property(nonatomic, strong) UIColor *tealColor;

@end

@implementation PestoSettingsViewController {
  NSMutableArray *_content;
}

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Settings";

    _appBar = [[MDCAppBar alloc] init];
    [self addChildViewController:_appBar.headerViewController];

    _tealColor = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1.f];
    _appBar.headerViewController.headerView.backgroundColor = _tealColor;
    _appBar.navigationBar.tintColor = [UIColor whiteColor];
    _appBar.navigationBar.titleTextAttributes =
        @{NSForegroundColorAttributeName : [UIColor whiteColor]};
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.appBar.headerViewController.headerView.trackingScrollView = self.collectionView;
  [self.appBar addSubviewsToParent];

  UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(didTapBack:)];
  UIImage *backImage = [UIImage imageNamed:@"Back"];
  backButton.image = backImage;
  self.navigationItem.leftBarButtonItem = backButton;
  self.navigationItem.rightBarButtonItem = nil;

  // Register cell.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Register header.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:UICollectionElementKindSectionHeader];

  _content = [NSMutableArray array];
  [_content addObject:@[ @"Public Profile", @"Subscribe to Daily Digest" ]];
  [_content addObject:@[ @"Get Email Notifications", @"Get Text Notifications" ]];

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return (NSInteger)[_content count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  NSArray *sectionContent = _content[(NSUInteger)section];
  return (NSInteger)sectionContent.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _content[(NSUInteger)indexPath.section][(NSUInteger)indexPath.item];
  UISwitch *editingSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
  cell.accessoryView = editingSwitch;
  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *supplementaryView =
      [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                         withReuseIdentifier:kind
                                                forIndexPath:indexPath];
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    if (indexPath.section == 0) {
      supplementaryView.textLabel.text = @"Account";
    } else if (indexPath.section == 1) {
      supplementaryView.textLabel.text = @"Notification";
    }
    supplementaryView.textLabel.textColor = self.tealColor;
  }
  return supplementaryView;
}

- (void)didTapBack:(id)button {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(collectionView.bounds.size.width, MDCCellDefaultOneLineHeight);
}

@end
