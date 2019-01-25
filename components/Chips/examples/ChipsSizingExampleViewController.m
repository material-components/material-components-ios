// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "supplemental/ChipsExamplesSupplemental.h"

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"
#import "MaterialSlider.h"

@implementation ChipsSizingExampleViewController {
  MDCChipView *_chipView;
  MDCSlider *_widthSlider;
  MDCSlider *_heightSlider;
  UISegmentedControl *_horizontalAlignmentControl;
}

- (id)init {
  self = [super init];
  if (self) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
    self.containerScheme.colorScheme =
    [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.containerScheme.shapeScheme = [[MDCShapeScheme alloc] init];
    self.containerScheme.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _chipView = [[MDCChipView alloc] init];
  _chipView.titleLabel.text = @"Material";
  _chipView.imageView.image = [self faceImage];
  _chipView.accessoryView = [self deleteButton];
  [_chipView applyThemeWithScheme:self.containerScheme];
  [self.view addSubview:_chipView];

  CGSize chipSize = [_chipView sizeThatFits:self.view.bounds.size];
  _chipView.frame = (CGRect){CGPointMake(20, 20), chipSize};

  _widthSlider = [[MDCSlider alloc] initWithFrame:CGRectZero];
  _widthSlider.maximumValue = 200;
  _widthSlider.value = _chipView.frame.size.width;
  [_widthSlider addTarget:self
                   action:@selector(widthSliderChanged:)
         forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_widthSlider];

  _heightSlider = [[MDCSlider alloc] initWithFrame:CGRectZero];
  _heightSlider.maximumValue = 100;
  _heightSlider.value = _chipView.frame.size.height;
  [_heightSlider addTarget:self
                    action:@selector(heightSliderChanged:)
          forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_heightSlider];

  _horizontalAlignmentControl =
      [[UISegmentedControl alloc] initWithItems:@[ @"Default", @"Centered" ]];
  _horizontalAlignmentControl.selectedSegmentIndex = 0;
  [_horizontalAlignmentControl addTarget:self
                                  action:@selector(horizontalAlignmentChanged:)
                        forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_horizontalAlignmentControl];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGSize sliderSize = [_widthSlider sizeThatFits:self.view.bounds.size];
  _widthSlider.frame = CGRectMake(20, 140, self.view.bounds.size.width - 40, sliderSize.height);
  _heightSlider.frame = CGRectMake(20, 140 + sliderSize.height + 20,
                                   self.view.bounds.size.width - 40, sliderSize.height);
  _horizontalAlignmentControl.frame =
      CGRectMake(20, CGRectGetMaxY(_heightSlider.frame) + 20, self.view.bounds.size.width - 40,
                 _horizontalAlignmentControl.frame.size.height);
}

- (void)widthSliderChanged:(MDCSlider *)slider {
  CGRect frame = _chipView.frame;
  frame.size.width = slider.value;
  _chipView.frame = frame;
  [_chipView layoutIfNeeded];
}

- (void)heightSliderChanged:(MDCSlider *)slider {
  CGRect frame = _chipView.frame;
  frame.size.height = slider.value;
  _chipView.frame = frame;
  [_chipView layoutIfNeeded];
}

- (void)horizontalAlignmentChanged:(UISegmentedControl *)segmentedControl {
  UIControlContentHorizontalAlignment alignment = (segmentedControl.selectedSegmentIndex == 0)
                                                      ? UIControlContentHorizontalAlignmentFill
                                                      : UIControlContentHorizontalAlignmentCenter;
  _chipView.contentHorizontalAlignment = alignment;
  [_chipView layoutIfNeeded];
}

@end
