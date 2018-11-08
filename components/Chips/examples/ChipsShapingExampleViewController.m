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

#import "ChipsExamplesSupplemental.h"

#import "MaterialChips.h"
#import "MaterialChips+ChipThemer.h"
#import "MaterialSlider.h"
#import "MaterialSlider+ColorThemer.h"
#import "MaterialShapes.h"
#import "MaterialShapeLibrary.h"

@interface ChipsShapingExampleViewController()
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation ChipsShapingExampleViewController {
  MDCChipView *_chipView;
  MDCSlider *_cornerSlider;
  MDCRectangleShapeGenerator *_rectangleShapeGenerator;
  UISegmentedControl *_cornerStyleControl;
}

- (id)init {
  self = [super init];
  if (self) {
    _colorScheme = [[MDCSemanticColorScheme alloc] init];
    _typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _rectangleShapeGenerator = [[MDCRectangleShapeGenerator alloc] init];

  _chipView = [[MDCChipView alloc] init];
  _chipView.titleLabel.text = @"Material";
  _chipView.imageView.image = [self faceImage];
  _chipView.accessoryView = [self deleteButton];
  _chipView.imagePadding = UIEdgeInsetsMake(0, 10, 0, 0);
  _chipView.accessoryPadding = UIEdgeInsetsMake(0, 0, 0, 10);
  CGSize chipSize = [_chipView sizeThatFits:self.view.bounds.size];
  _chipView.frame = CGRectMake(20, 20, chipSize.width + 20, chipSize.height + 20);
  _chipView.shapeGenerator = _rectangleShapeGenerator;

  MDCChipViewScheme *chipScheme = [[MDCChipViewScheme alloc] init];
  chipScheme.colorScheme = _colorScheme;
  chipScheme.typographyScheme = _typographyScheme;
  [MDCChipViewThemer applyScheme:chipScheme toChipView:_chipView];
  [self.view addSubview:_chipView];

  _cornerSlider = [[MDCSlider alloc] initWithFrame:CGRectZero];
  _cornerSlider.maximumValue =
      MIN(CGRectGetWidth(_chipView.bounds), CGRectGetHeight(_chipView.bounds)) / 2;
  _cornerSlider.value = _cornerSlider.maximumValue / 2;
  [_cornerSlider addTarget:self
                    action:@selector(cornerSliderChanged:)
          forControlEvents:UIControlEventValueChanged];
  [MDCSliderColorThemer applySemanticColorScheme:_colorScheme toSlider:_cornerSlider];
  [self.view addSubview:_cornerSlider];

  _cornerStyleControl = [[UISegmentedControl alloc] initWithItems:@[ @"Rounded", @"Cut", @"None" ]];
  _cornerStyleControl.selectedSegmentIndex = 0;
  [_cornerStyleControl addTarget:self
                          action:@selector(cornerStyleChanged:)
                forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_cornerStyleControl];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGSize sliderSize = [_cornerSlider sizeThatFits:self.view.bounds.size];
  _cornerSlider.frame = CGRectMake(20, 140, self.view.bounds.size.width - 40, sliderSize.height);
  _cornerSlider.frame =
      CGRectMake(20,
                 140 + sliderSize.height + 20,
                 self.view.bounds.size.width - 40,
                 sliderSize.height);
  _cornerStyleControl.frame =
      CGRectMake(20,
                 CGRectGetMaxY(_cornerSlider.frame) + 20,
                 self.view.bounds.size.width - 40,
                 _cornerStyleControl.frame.size.height);

  [self cornerSliderChanged:_cornerSlider];
}

- (void)cornerSliderChanged:(MDCSlider *)slider {
  if (_cornerStyleControl.selectedSegmentIndex == 0) {
    // Rounded
    MDCRoundedCornerTreatment *roundedCorners =
        [[MDCRoundedCornerTreatment alloc] initWithRadius:slider.value];
    [_rectangleShapeGenerator setCorners:roundedCorners];
  } else if (_cornerStyleControl.selectedSegmentIndex == 1) {
    // Cut
    MDCCutCornerTreatment *cutCorners = [[MDCCutCornerTreatment alloc] initWithCut:slider.value];
    [_rectangleShapeGenerator setCorners:cutCorners];
  }
  [_chipView setNeedsLayout];
}

- (void)cornerStyleChanged:(UISegmentedControl *)segmentedControl {
  if (segmentedControl.selectedSegmentIndex == 2) {
    _chipView.shapeGenerator = nil;
    _cornerSlider.hidden = YES;
  } else {
    _chipView.shapeGenerator = _rectangleShapeGenerator;
    _cornerSlider.hidden = NO;
  }
  _cornerSlider.value = _cornerSlider.maximumValue / 2;
  [self cornerSliderChanged:_cornerSlider];
}

@end
