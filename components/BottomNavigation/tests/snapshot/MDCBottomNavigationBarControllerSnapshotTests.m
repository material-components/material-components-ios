// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialBottomNavigation.h"
#import "MaterialSnapshot.h"

#import "MDCBottomNavigationBarController.h"

/** Number of cells shown in the scrollable child view controller. */
static const NSInteger kNumberOfCellsInScrollableChild = 25;

/** The size of a cell in the scrollable child view controller. */
static const CGSize kSizeOfCellInScrollableChild = (CGSize){(CGFloat)48, (CGFloat)48};

/** A view controller with content that expands to fit its bounds. */
@interface MDCBottomNavigationBarControllerSnapshotTestFixedContentChildViewController
    : UIViewController
@end

@implementation MDCBottomNavigationBarControllerSnapshotTestFixedContentChildViewController
@end

/** A view controller with content that scrolls. */
@interface MDCBottomNavigationBarControllerSnapshotTestScrollableChildViewController
    : UICollectionViewController <UICollectionViewDataSource>
/** The flow layout for this view controller. */
@property(nonatomic, readonly, nonnull) UICollectionViewFlowLayout *flowLayout;
@end

@implementation MDCBottomNavigationBarControllerSnapshotTestScrollableChildViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:@"cell"];
  self.collectionView.dataSource = self;
  self.collectionView.insetsLayoutMarginsFromSafeArea = YES;
  self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
}

- (UICollectionViewFlowLayout *)flowLayout {
  return (UICollectionViewFlowLayout *)self.collectionViewLayout;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return kNumberOfCellsInScrollableChild;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat hue = (CGFloat)indexPath.row / kNumberOfCellsInScrollableChild;
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                         forIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1];
  return cell;
}

@end

/** Snapshot tests for @c MDCBottomNavigationBarController. */
@interface MDCBottomNavigationBarControllerSnapshotTests : MDCSnapshotTestCase

/** The view controller being tested. */
@property(nonatomic, strong) MDCBottomNavigationBarController *navBarController;

/** A child view controller that has scrollable content. */
@property(nonatomic, strong)
    MDCBottomNavigationBarControllerSnapshotTestScrollableChildViewController *scrollableChildVC;

/** A child view controller with non-scrolling content. */
@property(nonatomic, strong)
    MDCBottomNavigationBarControllerSnapshotTestFixedContentChildViewController
        *fixedContentChildVC;

@end

@implementation MDCBottomNavigationBarControllerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.navBarController = [[MDCBottomNavigationBarController alloc] init];
  self.navBarController.navigationBar.barTintColor =
      [UIColor.redColor colorWithAlphaComponent:(CGFloat)0.5];
  self.navBarController.view.backgroundColor = UIColor.blackColor;
  self.navBarController.view.bounds = CGRectMake(0, 0, 240, 360);

  self.fixedContentChildVC =
      [[MDCBottomNavigationBarControllerSnapshotTestFixedContentChildViewController alloc] init];
  self.fixedContentChildVC.view.backgroundColor = UIColor.whiteColor;
  self.fixedContentChildVC.tabBarItem.title = @"Fixed";

  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  flowLayout.estimatedItemSize = kSizeOfCellInScrollableChild;
  self.scrollableChildVC =
      [[MDCBottomNavigationBarControllerSnapshotTestScrollableChildViewController alloc]
          initWithCollectionViewLayout:flowLayout];
  self.scrollableChildVC.collectionView.backgroundColor = UIColor.whiteColor;
  self.scrollableChildVC.tabBarItem.title = @"Scrollable";

  self.navBarController.viewControllers = @[ self.scrollableChildVC, self.fixedContentChildVC ];
  self.navBarController.navigationBar.unselectedItemTintColor = UIColor.whiteColor;
  self.navBarController.navigationBar.selectedItemTitleColor = UIColor.whiteColor;
  self.navBarController.navigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
}

- (void)tearDown {
  self.scrollableChildVC = nil;
  self.fixedContentChildVC = nil;
  self.navBarController = nil;

  [super tearDown];
}

- (void)generateAndVerifySnapshot {
  UIView *backgroundView = [self.navBarController.view mdc_addToBackgroundView];
  [self snapshotVerifyView:backgroundView];
}

#pragma mark - Tests

- (void)testNonScrollingChildViewControllerDefault {
  // When
  self.navBarController.selectedViewController = self.fixedContentChildVC;
  [self.navBarController.view layoutIfNeeded];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testScrollableChildViewControllerDefault {
  // When
  self.navBarController.selectedViewController = self.scrollableChildVC;
  [self.navBarController.view layoutIfNeeded];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testScrollableChildViewControllerScrolledToBottom {
  // Given
  self.navBarController.selectedViewController = self.scrollableChildVC;
  // Forces the layout system to update the layout margins and correctly position the
  // scroll view within the content view of the Bottom Navigation bar.
  UIView *backgroundView = [self.navBarController.view mdc_addToBackgroundView];
  [backgroundView drawViewHierarchyInRect:backgroundView.bounds afterScreenUpdates:YES];

  // When
  NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForRow:kNumberOfCellsInScrollableChild - 1
                                                      inSection:0];
  [self.scrollableChildVC.collectionView scrollToItemAtIndexPath:lastItemIndexPath
                                                atScrollPosition:UICollectionViewScrollPositionTop
                                                        animated:NO];

  // Then
  [self snapshotVerifyView:backgroundView];
}

- (void)testNonScrollingChildViewControllerWithSafeAreaInsets {
  // Given
  self.navBarController.additionalSafeAreaInsets = UIEdgeInsetsMake(10, 15, 25, 20);

  // When
  self.navBarController.selectedViewController = self.fixedContentChildVC;
  [self.navBarController.view layoutIfNeeded];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testScrollableChildViewControllerWithSafeAreaInsets {
  // Given
  self.navBarController.additionalSafeAreaInsets = UIEdgeInsetsMake(10, 15, 25, 20);

  // When
  self.navBarController.selectedViewController = self.scrollableChildVC;
  [self.navBarController.view layoutIfNeeded];

  // Then
  [self generateAndVerifySnapshot];
}

- (void)testScrollingChildViewControllerWithSafeAreaInsetsScrolledToBottom {
  // Given
  self.navBarController.additionalSafeAreaInsets = UIEdgeInsetsMake(10, 15, 25, 20);
  self.navBarController.selectedViewController = self.scrollableChildVC;
  // Forces the layout system to update the layout margins and correctly position the
  // scroll view within the content view of the Bottom Navigation bar.
  UIView *backgroundView = [self.navBarController.view mdc_addToBackgroundView];
  [backgroundView drawViewHierarchyInRect:backgroundView.bounds afterScreenUpdates:YES];

  // When
  NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForRow:kNumberOfCellsInScrollableChild - 1
                                                      inSection:0];
  [self.scrollableChildVC.collectionView scrollToItemAtIndexPath:lastItemIndexPath
                                                atScrollPosition:UICollectionViewScrollPositionTop
                                                        animated:NO];

  // Then
  [self generateAndVerifySnapshot];
}

@end
