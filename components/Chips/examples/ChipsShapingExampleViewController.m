// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"
#import "MaterialContainerScheme.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapes.h"
#import "MaterialSlider+ColorThemer.h"
#import "MaterialSlider.h"

#import "supplemental/ChipsExampleAssets.h"

@interface ChipsShapingExampleViewController : UIViewController
@property(nonatomic, strong) MDCChipView *chipView;
@property(nonatomic, strong) MDCSlider *cornerSlider;
@property(nonatomic, strong) MDCRectangleShapeGenerator *rectangleShapeGenerator;
@property(nonatomic, strong) UISegmentedControl *cornerStyleControl;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@end

@implementation ChipsShapingExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  self.rectangleShapeGenerator = [[MDCRectangleShapeGenerator alloc] init];

  self.chipView = [[MDCChipView alloc] init];
  self.chipView.titleLabel.text = @"Material";
  self.chipView.imageView.image = ChipsExampleAssets.faceImage;
  self.chipView.accessoryView = ChipsExampleAssets.deleteButton;
  self.chipView.imagePadding = UIEdgeInsetsMake(0, 10, 0, 0);
  self.chipView.accessoryPadding = UIEdgeInsetsMake(0, 0, 0, 10);
  CGSize chipSize = [self.chipView sizeThatFits:self.view.bounds.size];
  self.chipView.frame = CGRectMake(20, 20, chipSize.width + 20, chipSize.height + 20);
  [self.chipView applyThemeWithScheme:self.containerScheme];
  self.chipView.shapeGenerator = self.rectangleShapeGenerator;
  [self.view addSubview:self.chipView];

  self.cornerSlider = [[MDCSlider alloc] initWithFrame:CGRectZero];
  self.cornerSlider.maximumValue =
      MIN(CGRectGetWidth(self.chipView.bounds), CGRectGetHeight(self.chipView.bounds)) / 2;
  self.cornerSlider.value = self.cornerSlider.maximumValue / 2;
  [self.cornerSlider addTarget:self
                        action:@selector(cornerSliderChanged:)
              forControlEvents:UIControlEventValueChanged];
  if (self.containerScheme.colorScheme) {
    [MDCSliderColorThemer applySemanticColorScheme:self.containerScheme.colorScheme
                                          toSlider:self.cornerSlider];
  } else {
    MDCSemanticColorScheme *colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    [MDCSliderColorThemer applySemanticColorScheme:colorScheme toSlider:self.cornerSlider];
  }
  [self.view addSubview:self.cornerSlider];

  self.cornerStyleControl =
      [[UISegmentedControl alloc] initWithItems:@[ @"Rounded", @"Cut", @"None" ]];
  self.cornerStyleControl.selectedSegmentIndex = 0;
  [self.cornerStyleControl addTarget:self
                              action:@selector(cornerStyleChanged:)
                    forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.cornerStyleControl];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGSize sliderSize = [self.cornerSlider sizeThatFits:self.view.bounds.size];
  self.cornerSlider.frame =
      CGRectMake(20, 140, self.view.bounds.size.width - 40, sliderSize.height);
  self.cornerSlider.frame = CGRectMake(20, 140 + sliderSize.height + 20,
                                       self.view.bounds.size.width - 40, sliderSize.height);
  self.cornerStyleControl.frame =
      CGRectMake(20, CGRectGetMaxY(self.cornerSlider.frame) + 20, self.view.bounds.size.width - 40,
                 self.cornerStyleControl.frame.size.height);

  [self cornerSliderChanged:self.cornerSlider];
}

- (void)cornerSliderChanged:(MDCSlider *)slider {
  if (self.cornerStyleControl.selectedSegmentIndex == 0) {
    // Rounded
    MDCRoundedCornerTreatment *roundedCorners =
        [[MDCRoundedCornerTreatment alloc] initWithRadius:slider.value];
    [self.rectangleShapeGenerator setCorners:roundedCorners];
  } else if (self.cornerStyleControl.selectedSegmentIndex == 1) {
    // Cut
    MDCCutCornerTreatment *cutCorners = [[MDCCutCornerTreatment alloc] initWithCut:slider.value];
    [self.rectangleShapeGenerator setCorners:cutCorners];
  }
  [self.chipView setNeedsLayout];
}

- (void)cornerStyleChanged:(UISegmentedControl *)segmentedControl {
  if (segmentedControl.selectedSegmentIndex == 2) {
    self.chipView.shapeGenerator = nil;
    self.cornerSlider.hidden = YES;
  } else {
    self.chipView.shapeGenerator = self.rectangleShapeGenerator;
    self.cornerSlider.hidden = NO;
  }
  self.cornerSlider.value = self.cornerSlider.maximumValue / 2;
  [self cornerSliderChanged:self.cornerSlider];
}

@end

@implementation ChipsShapingExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Shaped Chip" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
