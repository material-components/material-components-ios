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

#import "ChipsTapInterceptExample.h"
#import "MaterialButtons.h"
#import "MaterialChips.h"

@interface MDCChipViewTapRecognizer : MDCChipView <UIGestureRecognizerDelegate>
@end

@implementation MDCChipViewTapRecognizer {
  UIGestureRecognizer *_gesture;
  BOOL _ignoreTap;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    _gesture.delegate = self;
    [self addGestureRecognizer:_gesture];
  }
  return self;
}

- (void)tapEvent:(UIGestureRecognizer *)gestureRecognizer {
  if (_ignoreTap) {
    return;
  }
  CGPoint touchPoint = [gestureRecognizer locationInView:self];
  MDCInkView *inkView = [super valueForKey:@"_inkView"];
  [inkView startTouchBeganAnimationAtPoint:touchPoint completion:^{
    [inkView startTouchEndedAnimationAtPoint:touchPoint completion:nil];
  }];
  [self sendActionsForControlEvents:UIControlEventTouchDown];
  [self sendActionsForControlEvents:UIControlEventTouchUpInside];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  _ignoreTap = YES;
  [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  _ignoreTap = NO;
  [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  _ignoreTap = NO;
  [super touchesCancelled:touches withEvent:event];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  if ([otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
    UITapGestureRecognizer *otherTapRecognizer = (UITapGestureRecognizer *)otherGestureRecognizer;
    if (otherTapRecognizer.numberOfTapsRequired == 1 && otherTapRecognizer.numberOfTouchesRequired == 1) {
      return NO;
    }
  }
  return YES;
}

@end

static NSUInteger nextCellIdentifier = 7U;

@implementation ChipsTapInterceptExample {
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
  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];
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
  UICollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  if (!cell.accessibilityIdentifier) {
    cell.accessibilityIdentifier = [NSString stringWithFormat:@"%lu", (unsigned long)nextCellIdentifier++];
  }
  cell.backgroundColor = UIColor.greenColor;
  NSArray<UIView *> *subviews = cell.subviews;
  for (UIView *subview in subviews) {
    [subview removeFromSuperview];
  }
  if (indexPath.row % 4 == 0) {
    MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [button setTitleFont:@"Button" forState:UIControlStateNormal];
    [cell addSubview:button];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
  } else if (indexPath.row % 4 == 1) {
    MDCChipView *chip = [[MDCChipView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    chip.titleLabel.text = @"Chip";
    [cell addSubview:chip];
    [chip addTarget:self action:@selector(didTapChip:) forControlEvents:UIControlEventTouchUpInside];
  } else if (indexPath.row % 4 == 2){
    MDCChipView *chip = [[MDCChipViewTapRecognizer alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    chip.titleLabel.text = @"C-Tap";
    [cell addSubview:chip];
    [chip addTarget:self action:@selector(didTapChipWithTap:) forControlEvents:UIControlEventTouchUpInside];
  } else {
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [cell addSubview:aSwitch];
    [aSwitch addTarget:self action:@selector(didTapSwitch:) forControlEvents:UIControlEventTouchUpInside];
  }
  UIGestureRecognizer *oldRecognizer = _gestureRecognizers[cell.accessibilityIdentifier];
  if (oldRecognizer) {
    [cell removeGestureRecognizer:oldRecognizer];
  }
  UIGestureRecognizer *newRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerPerformed:)];
  _gestureRecognizers[cell.accessibilityIdentifier] = newRecognizer;
  [cell addGestureRecognizer:newRecognizer];
  return cell;
}

- (void)didTapButton:(MDCButton *)sender {
  NSLog(@"%@", sender.currentTitle);
}

- (void)didTapChip:(MDCChipView *)sender {
  NSLog(@"%@", sender.titleLabel.text);
}

- (void)didTapChipWithTap:(MDCChipViewTapRecognizer *)sender {
  NSLog(@"%@", sender.titleLabel.text);
}

- (void)didTapSwitch:(UISwitch *)aSwitch {
  NSLog(@"Switch!");
}

- (void)gestureRecognizerPerformed:(UIGestureRecognizer *)gestureRecognizer {
  NSLog(@"%@",gestureRecognizer.view);
  UIColor *bgColor = gestureRecognizer.view.backgroundColor;
  gestureRecognizer.view.backgroundColor = UIColor.redColor;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    gestureRecognizer.view.backgroundColor = bgColor;
  });
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat cellSize = (self.view.bounds.size.width / 3) - 12;
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
  return @[ @"Chips", @"Tap Gesture Recognizer Support" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

+ (BOOL)catalogIsDebug {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return NO;
}

@end
