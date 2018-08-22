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

#import <UIKit/UIKit.h>

#import "MaterialShadowLayer.h"
#import "MaterialSlider.h"
#import "ShadowRadiusLabel.h"

static const CGFloat kShadowElevationsDefault = 8.f;
static const CGFloat kShadowElevationsMax = 24.f;
static const CGFloat kShadowElevationsSliderFrameHeight = 27.0f;

@interface ShadowCornerRadiusView : UIView <MDCSliderDelegate>

@property(nonatomic) ShadowRadiusLabel *paper;
@property(nonatomic) UILabel *elevationLabel;

@end

@implementation ShadowCornerRadiusView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];

    _elevationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 100)];
    _elevationLabel.textAlignment = NSTextAlignmentCenter;
    _elevationLabel.text = @"MDCShadowElevationFABPressed";
    [self addSubview:_elevationLabel];

    CGFloat paperDim = 200.f;
    CGRect paperFrame =
        CGRectMake((CGRectGetWidth(frame) - paperDim) / 2, 200.f, paperDim, paperDim);
    _paper = [[ShadowRadiusLabel alloc] initWithFrame:paperFrame];
    _paper.textAlignment = NSTextAlignmentCenter;
    _paper.text = [NSString stringWithFormat:@"%ld pt", (long)kShadowElevationsDefault];
    _paper.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |
         UIViewAutoresizingFlexibleRightMargin);
    _paper.cornerRadius = 8.0;
    _paper.elevation = 12.0;
    [self addSubview:_paper];

    CGFloat margin = 20.f;
    CGRect sliderRect = CGRectMake(margin, 140.f, frame.size.width - margin * 2,
                                   kShadowElevationsSliderFrameHeight);
    MDCSlider *sliderControl = [[MDCSlider alloc] initWithFrame:sliderRect];
    sliderControl.numberOfDiscreteValues = (NSUInteger) kShadowElevationsMax + 1;
    sliderControl.maximumValue = kShadowElevationsMax;
    sliderControl.value = kShadowElevationsDefault;
    sliderControl.delegate = self;
    sliderControl.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |
         UIViewAutoresizingFlexibleRightMargin);
    [sliderControl addTarget:self
                      action:@selector(sliderValueChanged:)
            forControlEvents:UIControlEventValueChanged];
    [self addSubview:sliderControl];
  }
  return self;
}

- (NSString *)slider:(MDCSlider *)slider displayedStringForValue:(CGFloat)value {
  NSInteger points = (NSInteger)round(value);
  return [NSString stringWithFormat:@"%ld pt", (long)points];
}

// TODO: (#4848) [ShadowLayer] cornerRadius changes don't render
- (void)sliderValueChanged:(MDCSlider *)slider {
  NSInteger points = (NSInteger)round(slider.value);
  _paper.text = [NSString stringWithFormat:@"%ld pt", (long)points];
  _paper.cornerRadius = (CGFloat)points;
  _elevationLabel.text = _paper.text;
}

@end

@interface ShadowCornerRadiusViewController : UIViewController
@property(nonatomic) ShadowCornerRadiusView *shadowsView;
@end

@implementation ShadowCornerRadiusViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"Shadow Corner Radius";
  _shadowsView = [[ShadowCornerRadiusView alloc] initWithFrame:self.view.bounds];
  _shadowsView.autoresizingMask =
      UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_shadowsView];
}

#pragma mark catalog by convention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Shadow", @"Shadow Corner Radius" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

@end
