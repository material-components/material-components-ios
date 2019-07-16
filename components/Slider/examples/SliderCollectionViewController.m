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

#import "MaterialCollections.h"
#import "MaterialColorScheme.h"
#import "MaterialPalettes.h"
#import "MaterialSlider+ColorThemer.h"
#import "MaterialSlider.h"
#import "MaterialTypographyScheme.h"
#import "supplemental/SliderCollectionSupplemental.h"

static NSString *const kReusableIdentifierItem = @"sliderItemCellIdentifier";
static CGFloat const kSliderHorizontalMargin = 16;
static CGFloat const kSliderVerticalMargin = 12;

@interface MDCSliderModel : NSObject

@property(nonatomic, copy) NSString *labelString;
@property(nonatomic, assign) UIColor *labelColor;
@property(nonatomic, assign) UIColor *bgColor;
@property(nonatomic, nullable) UIColor *sliderColor;
@property(nonatomic, nullable) UIColor *filledTickColor;
@property(nonatomic, nullable) UIColor *backgroundTickColor;
@property(nonatomic, nullable) UIColor *trackBackgroundColor;
@property(nonatomic, assign) int numDiscreteValues;
@property(nonatomic, assign) CGFloat value;
@property(nonatomic, assign) CGFloat anchorValue;
@property(nonatomic, assign) BOOL discreteValueLabel;
@property(nonatomic, assign) BOOL hollowCircle;
@property(nonatomic, assign) BOOL enabled;
@property(nonatomic, assign) BOOL hapticsEnabled;
@property(nonatomic, assign) BOOL shouldEnableHapticsForAllDiscreteValues;

- (void)didChangeMDCSliderValue:(MDCSlider *)slider;

@end

@implementation MDCSliderModel

- (instancetype)init {
  if (self = [super init]) {
    // Default values
    _labelString = @"";
    _labelColor = [UIColor blackColor];
    _bgColor = [UIColor whiteColor];
    _sliderColor = nil;
    _trackBackgroundColor = nil;
    _numDiscreteValues = 0;
    _value = 0.5;
    _anchorValue = -CGFLOAT_MAX;
    _discreteValueLabel = YES;
    _hollowCircle = YES;
    _enabled = YES;
    _hapticsEnabled = YES;
    _shouldEnableHapticsForAllDiscreteValues = NO;
  }

  return self;
}

- (void)didChangeMDCSliderValue:(MDCSlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
  _value = slider.value;
}

@end

@interface MDCSliderExampleCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong, nullable) UIFont *labelFont;
- (void)applyModel:(MDCSliderModel *)model withColorScheme:(MDCSemanticColorScheme *)colorScheme;
@end

@implementation MDCSliderExampleCollectionViewCell {
  UILabel *_label;
  MDCSlider *_slider;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _label = [[UILabel alloc] init];
    [self.contentView addSubview:_label];

    _slider = [[MDCSlider alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_slider];
  }

  return self;
}

- (void)applyModel:(MDCSliderModel *)model withColorScheme:(MDCSemanticColorScheme *)colorScheme {
  _label.text = model.labelString;
  _label.textColor = model.labelColor;
  self.contentView.backgroundColor = model.bgColor;
  _slider.statefulAPIEnabled = YES;
  [MDCSliderColorThemer applySemanticColorScheme:colorScheme toSlider:_slider];
  _slider.numberOfDiscreteValues = model.numDiscreteValues;
  _slider.value = model.value;
  _slider.filledTrackAnchorValue = model.anchorValue;
  _slider.shouldDisplayDiscreteValueLabel = model.discreteValueLabel;
  _slider.thumbHollowAtStart = model.hollowCircle;
  _slider.enabled = model.enabled;
  _slider.hapticsEnabled = model.hapticsEnabled;
  _slider.shouldEnableHapticsForAllDiscreteValues = model.shouldEnableHapticsForAllDiscreteValues;

  // Don't apply a `nil` color, use the default
  if (model.sliderColor) {
    [_slider setTrackFillColor:model.sliderColor forState:UIControlStateNormal];
    [_slider setThumbColor:model.sliderColor forState:UIControlStateNormal];
    _slider.inkColor = model.sliderColor;
  }

  if (model.trackBackgroundColor) {
    [_slider setTrackBackgroundColor:model.trackBackgroundColor forState:UIControlStateNormal];
  }

  if (model.filledTickColor) {
    [_slider setFilledTrackTickColor:model.filledTickColor forState:UIControlStateNormal];
  }

  if (model.backgroundTickColor) {
    [_slider setBackgroundTrackTickColor:model.backgroundTickColor forState:UIControlStateNormal];
  }

  // Add target/action pair
  [_slider addTarget:model
                action:@selector(didChangeMDCSliderValue:)
      forControlEvents:UIControlEventValueChanged];
}

- (void)prepareForReuse {
  // Remove target/action pairs
  NSSet *targets = [_slider allTargets];
  for (id target in targets) {
    [_slider removeTarget:target action:NULL forControlEvents:UIControlEventValueChanged];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIEdgeInsets safeArea = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    // Accommodate insets for iPhone X.
    safeArea = self.safeAreaInsets;
    safeArea.top = 0;
  }
  CGRect labelFrame =
      CGRectMake(kSliderHorizontalMargin + 6, kSliderVerticalMargin,
                 self.contentView.frame.size.width - (2 * kSliderHorizontalMargin), 20);

  _label.frame = UIEdgeInsetsInsetRect(labelFrame, safeArea);

  CGSize intrinsicSize = [_slider intrinsicContentSize];
  CGRect sliderFrame = CGRectMake(
      kSliderHorizontalMargin,
      self.contentView.frame.size.height - kSliderVerticalMargin - intrinsicSize.height,
      self.contentView.frame.size.width - (2 * kSliderHorizontalMargin), intrinsicSize.height);
  _slider.frame = UIEdgeInsetsInsetRect(sliderFrame, safeArea);
}

- (void)setLabelFont:(UIFont *)labelFont {
  _label.font = labelFont;
}

- (UIFont *)labelFont {
  return _label.font;
}

@end

@interface MDCSliderFlowLayout : UICollectionViewFlowLayout
@end

@implementation MDCSliderFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  if (!CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size)) {
    [self invalidateLayout];
    return YES;
  }
  return NO;
}

- (void)invalidateLayout {
  [super invalidateLayout];

  [self.collectionView setNeedsLayout];
}

- (CGSize)itemSize {
  return CGSizeMake(self.collectionView.bounds.size.width, 80);
}

- (CGFloat)minimumInteritemSpacing {
  return 0;
}

@end

@implementation SliderCollectionViewController {
  NSMutableArray<MDCSliderModel *> *_sliders;
  MDCTypographyScheme *_typographyScheme;
}

- (instancetype)init {
  MDCSliderFlowLayout *layout = [[MDCSliderFlowLayout alloc] init];
  if (self = [super initWithCollectionViewLayout:layout]) {
    // Register cell class.
    [self.collectionView registerClass:[MDCSliderExampleCollectionViewCell class]
            forCellWithReuseIdentifier:kReusableIdentifierItem];

    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];

    _typographyScheme = [[MDCTypographyScheme alloc] init];

    // Init the sliders
    _sliders = [[NSMutableArray alloc] init];
    MDCSliderModel *model;

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Default slider";
    model.value = (CGFloat)0.66;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Green slider without hollow circle at 0";
    model.sliderColor = MDCPalette.greenPalette.tint800;
    model.hollowCircle = NO;
    model.value = 0;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Discrete slider with numeric value label";
    model.numDiscreteValues = 5;
    model.value = (CGFloat)0.2;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Discrete slider without numeric value label";
    model.numDiscreteValues = 7;
    model.value = 1;
    model.discreteValueLabel = NO;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Discrete slider with full haptics";
    model.numDiscreteValues = 5;
    model.value = 1;
    model.discreteValueLabel = NO;
    model.shouldEnableHapticsForAllDiscreteValues = YES;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Dark themed slider";
    model.labelColor = [UIColor whiteColor];
    model.trackBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:(CGFloat)0.3];
    model.sliderColor = MDCPalette.bluePalette.tint500;
    model.bgColor = [UIColor darkGrayColor];
    model.value = (CGFloat)0.2;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Anchored slider";
    model.anchorValue = (CGFloat)0.5;
    model.value = (CGFloat)0.7;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Haptics Disabled Slider";
    model.value = (CGFloat)0.66;
    model.hapticsEnabled = NO;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Disabled slider";
    model.value = (CGFloat)0.5;
    model.anchorValue = (CGFloat)0.1;
    model.enabled = NO;
    [_sliders addObject:model];

    _colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }

  return self;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [_sliders count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCSliderExampleCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  MDCSliderModel *model = [_sliders objectAtIndex:indexPath.item];
  [cell applyModel:model withColorScheme:self.colorScheme];
  cell.labelFont = _typographyScheme.subtitle2;
  return cell;
}

@end
