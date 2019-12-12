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

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"
#import "MaterialSlider.h"

#import "supplemental/ChipsExampleAssets.h"

@interface ChipsSizingExampleViewController : UIViewController <MDCSliderDelegate>
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@property(nonatomic, strong) MDCChipView *chipView;
@property(nonatomic, strong) MDCSlider *widthSlider;
@property(nonatomic, strong) MDCSlider *heightSlider;
@property(nonatomic, strong) UISegmentedControl *horizontalAlignmentControl;
@end

@implementation ChipsSizingExampleViewController

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

  self.chipView = [[MDCChipView alloc] init];
  self.chipView.titleLabel.text = @"Material";
  self.chipView.imageView.image = ChipsExampleAssets.faceImage;
  self.chipView.accessoryView = ChipsExampleAssets.deleteButton;
  [self.chipView applyThemeWithScheme:self.containerScheme];
  [self.view addSubview:self.chipView];

  CGSize chipSize = [self.chipView sizeThatFits:self.view.bounds.size];
  self.chipView.frame = (CGRect){CGPointMake(20, 20), chipSize};

  self.widthSlider = [[MDCSlider alloc] initWithFrame:CGRectZero];
  self.widthSlider.maximumValue = 200;
  self.widthSlider.value = self.chipView.frame.size.width;
  self.widthSlider.accessibilityLabel = @"Width of the chip";
  self.widthSlider.delegate = self;
  [self.widthSlider addTarget:self
                       action:@selector(widthSliderChanged:)
             forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.widthSlider];

  self.heightSlider = [[MDCSlider alloc] initWithFrame:CGRectZero];
  self.heightSlider.maximumValue = 100;
  self.heightSlider.value = self.chipView.frame.size.height;
  self.heightSlider.accessibilityLabel = @"Height of the chip";
  self.heightSlider.delegate = self;
  [self.heightSlider addTarget:self
                        action:@selector(heightSliderChanged:)
              forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.heightSlider];

  self.horizontalAlignmentControl =
      [[UISegmentedControl alloc] initWithItems:@[ @"Default", @"Centered" ]];
  self.horizontalAlignmentControl.selectedSegmentIndex = 0;
  [self.horizontalAlignmentControl addTarget:self
                                      action:@selector(horizontalAlignmentChanged:)
                            forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.horizontalAlignmentControl];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGFloat topEdge;
  if (@available(iOS 11, *)) {
    topEdge = self.view.safeAreaInsets.top;
  } else {
    topEdge = self.topLayoutGuide.length;
  }
  CGRect frame = self.chipView.frame;
  frame.origin.y = topEdge + 16;
  self.chipView.frame = frame;

  CGFloat contentBottomEdge = CGRectGetMaxY(self.chipView.frame);

  CGSize sliderSize = [self.widthSlider sizeThatFits:self.view.bounds.size];
  self.widthSlider.frame =
      CGRectMake(20, contentBottomEdge + 16, self.view.bounds.size.width - 40, sliderSize.height);
  contentBottomEdge = CGRectGetMaxY(self.widthSlider.frame);
  self.heightSlider.frame =
      CGRectMake(20, contentBottomEdge + 16, self.view.bounds.size.width - 40, sliderSize.height);
  contentBottomEdge = CGRectGetMaxY(self.heightSlider.frame);
  self.horizontalAlignmentControl.frame =
      CGRectMake(20, contentBottomEdge + 16, self.view.bounds.size.width - 40,
                 self.horizontalAlignmentControl.frame.size.height);
}

- (void)widthSliderChanged:(MDCSlider *)slider {
  CGRect frame = self.chipView.frame;
  frame.size.width = slider.value;
  self.chipView.frame = frame;
  [self.chipView layoutIfNeeded];
}

- (void)heightSliderChanged:(MDCSlider *)slider {
  CGRect frame = self.chipView.frame;
  frame.size.height = slider.value;
  self.chipView.frame = frame;
  [self.chipView layoutIfNeeded];

  // The vertical layout changes when this slider is adjusted.
  UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

- (void)horizontalAlignmentChanged:(UISegmentedControl *)segmentedControl {
  UIControlContentHorizontalAlignment alignment = (segmentedControl.selectedSegmentIndex == 0)
                                                      ? UIControlContentHorizontalAlignmentFill
                                                      : UIControlContentHorizontalAlignmentCenter;
  self.chipView.contentHorizontalAlignment = alignment;
  [self.chipView layoutIfNeeded];
}

#pragma mark - MDCSliderDelegate

- (NSString *)slider:(MDCSlider *)slider accessibilityLabelForValue:(CGFloat)value {
  if (slider == self.widthSlider) {
    return [NSString stringWithFormat:@"Width of %@", @((NSInteger)slider.value)];
  } else if (slider == self.heightSlider) {
    return [NSString stringWithFormat:@"Height of %@", @((NSInteger)slider.value)];
  }
  return nil;
}

@end

@implementation ChipsSizingExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Sizing" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
