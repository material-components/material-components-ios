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

#import <UIKit/UIKit.h>

#import "ShadowElevationsPointsLabel.h"

#import "MaterialMath.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSlider.h"

static NSString *const kDefaultShadowElevationLabelString = @"";

static const CGFloat kShadowElevationLabelTopOffset = 0;
static const CGFloat kShadowElevationLabelHeight = 70;
static const CGFloat kShadowElevationsDefault = 8;
static const CGFloat kShadowElevationsMax = 24;
static const CGFloat kShadowElevationsSliderFrameHeight = 27;
static const CGFloat kShadowElevationsSliderFrameMargin = 20;
static const CGFloat kShadowElevationsElementSpace = 20;
static const CGFloat kShadowElevationsPaperDimRange = 130;
static const CGFloat kShadowElevationsPaperBottomMargin = 20;

@interface ShadowElevationsPointsView : UIView <MDCSliderDelegate>

@property(nonatomic) ShadowElevationsPointsLabel *paper;
@property(nonatomic) UILabel *elevationLabel;
@property(nonatomic) MDCSlider *sliderControl;

@end

@implementation ShadowElevationsPointsView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];

    // Add label
    _elevationLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, kShadowElevationLabelTopOffset,
                                                  frame.size.width, kShadowElevationLabelHeight)];
    _elevationLabel.textAlignment = NSTextAlignmentCenter;
    _elevationLabel.text =
        [[self class] elevationStringForShadowElevationValue:kShadowElevationsDefault];
    [self addSubview:_elevationLabel];

    // Add slider control
    self.sliderControl = [[MDCSlider alloc] initWithFrame:CGRectZero];
    self.sliderControl.numberOfDiscreteValues = (NSUInteger)kShadowElevationsMax + 1;
    self.sliderControl.maximumValue = kShadowElevationsMax;
    self.sliderControl.value = kShadowElevationsDefault;
    self.sliderControl.delegate = self;
    self.sliderControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.sliderControl.accessibilityLabel = @"Displayed shadow elevation";
    [self.sliderControl addTarget:self
                           action:@selector(sliderValueChanged:)
                 forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.sliderControl];

    [NSLayoutConstraint constraintWithItem:self.sliderControl
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_elevationLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:kShadowElevationsElementSpace]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:self.sliderControl
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:kShadowElevationsSliderFrameHeight]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:self.sliderControl
                                 attribute:NSLayoutAttributeLeftMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeftMargin
                                multiplier:1.0
                                  constant:kShadowElevationsSliderFrameMargin]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:self.sliderControl
                                 attribute:NSLayoutAttributeRightMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeRightMargin
                                multiplier:1.0
                                  constant:-kShadowElevationsSliderFrameMargin]
        .active = YES;

    // Add paper
    _paper = [[ShadowElevationsPointsLabel alloc] initWithFrame:CGRectZero];
    _paper.translatesAutoresizingMaskIntoConstraints = NO;
    _paper.textAlignment = NSTextAlignmentCenter;
    _paper.text = [NSString stringWithFormat:@"%ld pt", (long)kShadowElevationsDefault];
    _paper.elevation = kShadowElevationsDefault;
    [self addSubview:_paper];
    [NSLayoutConstraint constraintWithItem:_paper
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:_paper
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.sliderControl
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:kShadowElevationsElementSpace]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:_paper
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:kShadowElevationsPaperBottomMargin]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:_paper
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_paper
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:_paper
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:kShadowElevationsPaperDimRange]
        .active = YES;
  }
  return self;
}

#pragma mark - MDCSliderDelegate methods

- (NSString *)slider:(MDCSlider *)slider displayedStringForValue:(CGFloat)value {
  NSInteger points = (NSInteger)round(value);
  return [NSString stringWithFormat:@"%ld pt", (long)points];
}

- (void)sliderValueChanged:(MDCSlider *)slider {
  MDCShadowElevation points = [self shadowElevationFromSliderValue:slider.value];
  self.paper.text = [NSString stringWithFormat:@"%ld pt", (long)points];
  self.paper.elevation = points;
  self.elevationLabel.text = [[self class] elevationStringForShadowElevationValue:points];
}

- (NSString *)slider:(MDCSlider *)slider accessibilityLabelForValue:(CGFloat)value {
  MDCShadowElevation points = [self shadowElevationFromSliderValue:slider.value];
  NSString *elevationName = [[self class] elevationStringForShadowElevationValue:points];
  if (elevationName.length > 0) {
    return elevationName;
  } else {
    return [NSString stringWithFormat:@"Unlabeled elevation of %@", @((NSInteger)points)];
  }
}

#pragma mark - Internal methods

- (MDCShadowElevation)shadowElevationFromSliderValue:(CGFloat)sliderValue {
  return round(sliderValue);
}

+ (NSString *)elevationStringForShadowElevationValue:(MDCShadowElevation)shadowElevationValue {
  NSString *elevationString = kDefaultShadowElevationLabelString;

  if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationNone)) {
    elevationString = @"MDCShadowElevationNone";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationSwitch)) {
    elevationString = @"MDCShadowElevationSwitch";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationRaisedButtonResting)) {
    elevationString = @"MDCShadowElevationRaisedButtonResting";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationRefresh)) {
    elevationString = @"MDCShadowElevationRefresh";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationAppBar)) {
    elevationString = @"MDCShadowElevationAppBar";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationFABResting)) {
    elevationString = @"MDCShadowElevationFABResting";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationRaisedButtonPressed)) {
    elevationString = @"MDCShadowElevationRaisedButtonPressed";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationSubMenu)) {
    elevationString = @"MDCShadowElevationSubMenu";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationFABPressed)) {
    elevationString = @"MDCShadowElevationFABPressed";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationNavDrawer)) {
    elevationString = @"MDCShadowElevationNavDrawer";
  } else if (MDCCGFloatEqual(shadowElevationValue, MDCShadowElevationDialog)) {
    elevationString = @"MDCShadowElevationDialog";
  }

  return elevationString;
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
  [self.view addSubview:_shadowsView];

  if (@available(iOS 11.0, *)) {
    self.shadowsView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  } else {
    _shadowsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self setupShadowsViewConstraints];
  }
}

- (void)setupShadowsViewConstraints {
  [NSLayoutConstraint constraintWithItem:self.shadowsView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.topLayoutGuide
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:0]
      .active = YES;

  [NSLayoutConstraint constraintWithItem:self.shadowsView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                                constant:0]
      .active = YES;

  [NSLayoutConstraint constraintWithItem:self.shadowsView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeWidth
                              multiplier:1.0
                                constant:0]
      .active = YES;

  [NSLayoutConstraint constraintWithItem:self.shadowsView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.bottomLayoutGuide
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:0]
      .active = YES;
}

- (void)viewSafeAreaInsetsDidChange {
  [super viewSafeAreaInsetsDidChange];
  CGRect insetedShadowViewFrame = CGRectMake(
      self.view.bounds.origin.x, self.view.bounds.origin.y + self.view.safeAreaInsets.top,
      self.view.bounds.size.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right,
      self.view.bounds.size.height - self.view.safeAreaInsets.top -
          self.view.safeAreaInsets.bottom);
  self.shadowsView.frame = insetedShadowViewFrame;
}

#pragma mark catalog by convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Shadow", @"Shadow Elevations" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end
