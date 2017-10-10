//
//  MDCTextInputControllerOutlinedChips.m
//  MaterialComponents
//
//  Created by Will Larche on 10/9/17.
//

#import "MDCTextInputControllerOutlinedTextAreaChips.h"

@interface MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleLabel];

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|" options:0 metrics:nil views:@{@"titleLabel": _titleLabel}]];
    [_titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
  }
  return self;
}

@end


@interface MDCTextInputControllerOutlinedTextAreaChips() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSMutableArray <NSString *> *data;

@end

@implementation MDCTextInputControllerOutlinedTextAreaChips

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)input {
  self = [super initWithTextInput:input];
  if (self) {
    _data = [NSMutableArray array];

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [input addSubview:_collectionView];

    [_collectionView registerClass:[MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
  }
  return self;
}

#pragma mark - CollectionView DataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

  cell.titleLabel.text = self.data[indexPath.item];
  return cell;
}

- (NSInteger)collectionView:(nonnull __unused UICollectionView *)collectionView numberOfItemsInSection:(__unused NSInteger)section {
  return self.data.count;
}

#pragma mark - CollectionView Delegate

@end
