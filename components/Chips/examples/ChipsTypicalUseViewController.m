/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "ChipsTypicalUseViewController.h"

#import "MaterialChips.h"

@interface ChipModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *selectedImage;
@property(nonatomic, strong) UIView *accessoryView;
@end

static inline ChipModel *MakeModel(NSString *title,
                              UIImage *image,
                              UIImage *selectedImage,
                              UIView *accessoryView) {
  ChipModel *chip = [[ChipModel alloc] init];
  chip.title = title;
  chip.image = image;
  chip.selectedImage = selectedImage;
  chip.accessoryView = accessoryView;
  return chip;
}

@interface ChipsTypicalUseViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<ChipModel *> *model;
@end

@implementation ChipsTypicalUseViewController {
  BOOL _popRecognizerDelaysTouches;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Chips", @"Chips" ];
}

+ (NSString *)catalogDescription {
  return @"Chips!";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

- (instancetype)init {
  MDCAlignedCollectionViewFlowLayout *layout = [[MDCAlignedCollectionViewFlowLayout alloc] init];
  layout.horizontalAlignment = MDCCollectionHorizontalAlignmentLeft;
  layout.minimumInteritemSpacing = 10.0f;
  layout.estimatedItemSize = CGSizeMake(60, 33);

  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.editing = YES;
  }
  return self;
}

- (void)loadView {
  [super loadView];

  self.collectionView.backgroundColor = [UIColor lightGrayColor];
  self.collectionView.delaysContentTouches = NO;
  self.collectionView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
  [self.collectionView registerClass:[MDCChipCollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  _popRecognizerDelaysTouches =
      self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan;
  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan =
  _popRecognizerDelaysTouches;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.model.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCChipCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  ChipModel *model = self.model[indexPath.row];
  MDCChipView *chip = cell.chip;
  chip.titleLabel.text = model.title;
  chip.imageView.image = model.image;
  chip.selectedImageView.image = model.selectedImage;
  chip.accessoryView = model.accessoryView;

  return cell;
}

- (NSArray *)model {
  if (!_model) {
    _model = @[
      MakeModel(@"Chip", [self faceImage], nil, nil),
      MakeModel(@"Chip", [self faceImage], nil, [self deleteButton]),
      MakeModel(@"Chip", nil, nil, [self deleteButton]),
      MakeModel(@"Chip", [self faceImage], [self doneImage], [self deleteButton]),
      MakeModel(@"Chip", nil, [self doneImage], [self deleteButton]),
    ];
  }
  return _model;
}

- (UIImage *)faceImage {
  UIImage *image = [UIImage imageNamed:@"ic_face"
                              inBundle:[NSBundle bundleForClass:[self class]]
         compatibleWithTraitCollection:nil];
  return image;
}

- (UIImage *)doneImage {
  UIImage *image = [UIImage imageNamed:@"ic_done"
                              inBundle:[NSBundle bundleForClass:[self class]]
         compatibleWithTraitCollection:nil];
  return image;
}

- (UIButton *)deleteButton {
  UIImage *image = [UIImage imageNamed:@"ic_check_circle_18pt"
                              inBundle:[NSBundle bundleForClass:[self class]]
         compatibleWithTraitCollection:nil];
  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
  button.tintColor = [UIColor colorWithWhite:0 alpha:0.7];
  [button setImage:image forState:UIControlStateNormal];

  return button;
}

@end

@implementation ChipModel
@end
