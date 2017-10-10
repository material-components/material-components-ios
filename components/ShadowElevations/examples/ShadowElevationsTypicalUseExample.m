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

#import <UIKit/UIKit.h>

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSlider.h"
#import "ShadowElevationsPointsLabel.h"

static const CGFloat kShadowElevationsDefault = 8.f;
static const CGFloat kShadowElevationsMax = 24.f;
static const CGFloat kShadowElevationsSliderFrameHeight = 27.0f;

@interface ShadowElevationsPointsView : UIView

@property(nonatomic) ShadowElevationsPointsLabel *paper;
@property(nonatomic) UILabel *elevationLabel;

@end

@implementation ShadowElevationsPointsView

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
    _paper = [[ShadowElevationsPointsLabel alloc] initWithFrame:paperFrame];
    _paper.textAlignment = NSTextAlignmentCenter;
    _paper.text = [NSString stringWithFormat:@"%ld pt", (long)kShadowElevationsDefault];
    _paper.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |
         UIViewAutoresizingFlexibleRightMargin);
    MDCShadowElevation *elevation = [[MDCShadowElevation alloc] init];
    elevation.value = kShadowElevationsDefault;
    [_paper setElevation:elevation];
    [self addSubview:_paper];

    CGFloat margin = 20.f;
    CGRect sliderRect = CGRectMake(margin, 140.f, frame.size.width - margin * 2,
                                   kShadowElevationsSliderFrameHeight);
    MDCSlider *sliderControl = [[MDCSlider alloc] initWithFrame:sliderRect];
    sliderControl.value = kShadowElevationsDefault / kShadowElevationsMax;
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

- (void)sliderValueChanged:(MDCSlider *)slider {
  NSInteger points = (NSInteger)round(slider.value * kShadowElevationsMax);
  _paper.text = [NSString stringWithFormat:@"%ld pt", (long)points];
  MDCShadowElevation *elevation = [[MDCShadowElevation alloc] init];
  elevation.value = points;
  [_paper setElevation:elevation];
  if (points == [MDCShadowElevation none]) {
    _elevationLabel.text = @"MDCShadowElevationNone";
  } else if (points == [MDCShadowElevation raisedButtonResting]) {
    _elevationLabel.text = @"MDCShadowElevationRaisedButtonResting";
  } else if (points == [MDCShadowElevation refresh]) {
    _elevationLabel.text = @"MDCShadowElevationRefresh";
  } else if (points == [MDCShadowElevation appBar]) {
    _elevationLabel.text = @"MDCShadowElevationAppBar";
  } else if (points == [MDCShadowElevation fabResting]) {
    _elevationLabel.text = @"MDCShadowElevationFABResting";
  } else if (points == [MDCShadowElevation raisedButtonPressed]) {
    _elevationLabel.text = @"MDCShadowElevationRaisedButtonPressed";
  } else if (points == [MDCShadowElevation subMenu]) {
    _elevationLabel.text = @"MDCShadowElevationSubMenu";
  } else if (points == [MDCShadowElevation fabPressed]) {
    _elevationLabel.text = @"MDCShadowElevationFABPressed";
  } else if (points == [MDCShadowElevation navDrawer]) {
    _elevationLabel.text = @"MDCShadowElevationNavDrawer";
  } else if (points == [MDCShadowElevation cardDialog]) {
    _elevationLabel.text = @"MDCShadowElevationDialog";
  } else {
    _elevationLabel.text = @"";
  }
}

@end

@interface ShadowElevationsTypicalUseViewController : UIViewController
@property(nonatomic) ShadowElevationsPointsView *shadowsView;
@end

@implementation ShadowElevationsTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"Shadow Elevations";
  _shadowsView = [[ShadowElevationsPointsView alloc] initWithFrame:self.view.bounds];
  _shadowsView.autoresizingMask =
      UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_shadowsView];
}

#pragma mark catalog by convention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Shadow", @"Shadow Elevations" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
