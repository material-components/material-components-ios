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

#import "MDCSlider.h"
#import "MDCTypography.h"
#import "MaterialCollections.h"
#import "SliderCollectionSupplemental.h"

static NSString *const kReusableIdentifierItem = @"sliderItemCellIdentifier";
static CGFloat const kSliderHorizontalMargin = 16.f;
static CGFloat const kSliderVerticalMargin = 12.f;

// From http://www.google.com/design/spec/style/color.html#color-color-palette .
static const uint32_t MDCGreenColor = 0x4CAF50;
static const uint32_t MDCDeepOrangeColor = 0xFF5722;
static const uint32_t MDCPurpleColor = 0x9C27B0;

// Creates a UIColor from a 24-bit RGB color encoded as an integer.
static inline UIColor *MDCColorFromRGB(uint32_t rgbValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                         green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                          blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                         alpha:1];
}

@interface MDCSliderModel : NSObject

@property(nonatomic, copy) NSString *labelString;
@property(nonatomic, assign) UIColor *labelColor;
@property(nonatomic, assign) UIColor *bgColor;
@property(nonatomic, nullable) UIColor *sliderColor;
@property(nonatomic, nullable) UIColor *trackBackgroundColor;
@property(nonatomic, assign) int numDiscreteValues;
@property(nonatomic, assign) CGFloat value;
@property(nonatomic, assign) CGFloat anchorValue;
@property(nonatomic, assign) BOOL discreteValueLabel;
@property(nonatomic, assign) BOOL hollowCircle;
@property(nonatomic, assign) BOOL enabled;

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
  }

  return self;
}

- (void)didChangeMDCSliderValue:(MDCSlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
  _value = slider.value;
}

@end

@interface MDCSliderExampleCollectionViewCell : UICollectionViewCell

- (void)applyModel:(MDCSliderModel *)model;

@end

@implementation MDCSliderExampleCollectionViewCell {
  UILabel *_label;
  MDCSlider *_slider;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _label = [[UILabel alloc] init];
    _label.font = [MDCTypography body1Font];
    [self.contentView addSubview:_label];

    _slider = [[MDCSlider alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_slider];
  }

  return self;
}

- (void)applyModel:(MDCSliderModel *)model {
  _label.text = model.labelString;
  _label.textColor = model.labelColor;
  self.contentView.backgroundColor = model.bgColor;
  _slider.color = model.sliderColor;
  _slider.trackBackgroundColor = model.trackBackgroundColor;
  _slider.numberOfDiscreteValues = model.numDiscreteValues;
  _slider.value = model.value;
  _slider.filledTrackAnchorValue = model.anchorValue;
  _slider.shouldDisplayDiscreteValueLabel = model.discreteValueLabel;
  _slider.thumbIsHollowAtStart = model.hollowCircle;
  _slider.enabled = model.enabled;

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
  _label.frame = CGRectMake(kSliderHorizontalMargin + 6, kSliderVerticalMargin,
                            self.contentView.frame.size.width - (2 * kSliderHorizontalMargin), 20);

  CGSize intrinsicSize = [_slider intrinsicContentSize];
  _slider.frame = CGRectMake(
      kSliderHorizontalMargin,
      self.contentView.frame.size.height - kSliderVerticalMargin - intrinsicSize.height,
      self.contentView.frame.size.width - (2 * kSliderHorizontalMargin), intrinsicSize.height);
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
}

- (instancetype)init {
  MDCSliderFlowLayout *layout = [[MDCSliderFlowLayout alloc] init];
  if (self = [super initWithCollectionViewLayout:layout]) {
    // Register cell class.
    [self.collectionView registerClass:[MDCSliderExampleCollectionViewCell class]
            forCellWithReuseIdentifier:kReusableIdentifierItem];

    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];

    // Init the sliders
    _sliders = [[NSMutableArray alloc] init];
    MDCSliderModel *model;

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Default slider";
    model.value = 0.66f;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Green slider without hollow circle at 0";
    model.hollowCircle = NO;
    model.sliderColor = MDCColorFromRGB(MDCGreenColor);
    model.value = 0.f;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Discrete slider with numeric value label";
    model.numDiscreteValues = 5;
    model.value = 0.2f;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Discrete slider without numeric value label";
    model.numDiscreteValues = 7;
    model.value = 1.f;
    model.sliderColor = MDCColorFromRGB(MDCDeepOrangeColor);
    model.discreteValueLabel = NO;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Dark themed slider";
    model.labelColor = [UIColor whiteColor];
    model.trackBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
    model.bgColor = [UIColor darkGrayColor];
    model.value = 0.2f;
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Anchored slider";
    model.anchorValue = 0.5f;
    model.value = 0.7f;
    model.sliderColor = MDCColorFromRGB(MDCPurpleColor);
    [_sliders addObject:model];

    model = [[MDCSliderModel alloc] init];
    model.labelString = @"Disabled slider";
    model.value = 0.5f;
    model.enabled = NO;
    [_sliders addObject:model];
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

  [cell applyModel:model];
  return cell;
}

@end
