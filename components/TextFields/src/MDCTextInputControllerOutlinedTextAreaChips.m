//
//  MDCTextInputControllerOutlinedChips.m
//  MaterialComponents
//
//  Created by Will Larche on 10/9/17.
//

#import "MDCTextInputControllerOutlinedTextAreaChips.h"

#import "MaterialTypography.h"
#import "private/MDCTextInputControllerDefault+Subclassing.h"

@interface MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
    _titleLabel.textAlignment = NSTextAlignmentCenter;

    self.backgroundColor = [UIColor colorWithRed:1.f green:243 / 255.0 blue:224 / 255.0 alpha:1.0];
    [self.contentView addSubview:_titleLabel];

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|" options:0 metrics:nil views:@{@"titleLabel": _titleLabel}]];
    [_titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
  }
  return self;
}

@end

@interface MDCTextInputControllerOutlinedTextAreaChips() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSMutableArray <NSString *> *data;
@property (nonatomic) MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell *layoutCell;

@end

@implementation MDCTextInputControllerOutlinedTextAreaChips

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)input {
  self = [super initWithTextInput:input];
  if (self) {
    _data = [NSMutableArray array];

    _layoutCell = [[MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell alloc] initWithFrame:CGRectZero];

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    MDCMultilineTextField *textField = (MDCMultilineTextField*)input;
    [input insertSubview:_collectionView belowSubview:textField.textView];
    [_collectionView.topAnchor constraintEqualToAnchor:textField.textView.topAnchor].active = YES;
    [_collectionView.bottomAnchor constraintEqualToAnchor:textField.textView.bottomAnchor].active = YES;
    [_collectionView.leadingAnchor constraintEqualToAnchor:textField.textView.leadingAnchor].active = YES;
    [_collectionView.trailingAnchor constraintEqualToAnchor:textField.textView.trailingAnchor].active = YES;

    [_collectionView registerClass:[MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    _collectionView.backgroundColor = input.backgroundColor;
  }
  return self;
}

#pragma mark - CollectionView DataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  MDCTextInputControllerOutlinedTextAreaChipsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

  cell.titleLabel.text = self.data[indexPath.item];

  cell.layer.cornerRadius = cell.titleLabel.font.lineHeight / 2.0;
  return cell;
}

- (NSInteger)collectionView:(nonnull __unused UICollectionView *)collectionView numberOfItemsInSection:(__unused NSInteger)section {
  return self.data.count;
}

#pragma mark - CollectionView Delegate

- (CGSize)collectionView:(__unused UICollectionView *)collectionView layout:(__unused UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGSize textSize = [self cellSizeForString:self.data[indexPath.item]];

  return CGSizeMake(self.layoutCell.layoutMargins.left + self.layoutCell.layoutMargins.right * 2 + textSize.width, self.textInput.font.lineHeight);
}

#pragma mark - Working with Paths
- (NSArray <UIBezierPath*>*)exclusionPaths {
  NSMutableArray *array = [NSMutableArray array];
  for (NSInteger i = 0; i < [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0]; ++i) {
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathWithIndex:i]];
    CGRect frame = attributes.frame;
    frame.origin.y = 5;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    [array addObject:path];
  }

  return [NSArray arrayWithArray:array];
}

#pragma mark - Text Helpers
- (CGSize)cellSizeForString:(NSString*)string {
  self.layoutCell.titleLabel.text = string;
  CGSize textSize = [self.layoutCell.titleLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

  return textSize;
}

#pragma mark - TextField Events
- (void)textInputDidChange:(NSNotification *)note {
  [super textInputDidChange:note];

  MDCMultilineTextField *textField = (MDCMultilineTextField*)self.textInput;
  if ([textField.text containsString:@"\n"]) {
    NSString *truncatedString = [textField.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [self.data addObject:truncatedString];
    [self.collectionView reloadData];
    textField.text = nil;
    [self.collectionView layoutIfNeeded];
    
    textField.textView.textContainer.exclusionPaths = [self exclusionPaths];
  }
}

- (void)textInputDidEndEditing:(NSNotification *)note {
  [super textInputDidEndEditing:note];
}

- (void)textInputDidLayoutSubviews {
  [super textInputDidLayoutSubviews];

  [self.textInput sendSubviewToBack:self.collectionView];
}
@end
