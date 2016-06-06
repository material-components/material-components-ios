/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "MaterialActivityIndicator.h"
#import "MaterialTypography.h"

static const CGFloat kActivityIndicatorRadius = 72.f;
static const CGFloat kActivityInitialProgress = 0.6f;

@interface ActivityIndicatorExample : UIViewController <MDCActivityIndicatorDelegate>

@property(nonatomic, strong) MDCActivityIndicator *activityIndicator;
@property(nonatomic, strong) UILabel *determinateSwitchLabel;
@property(nonatomic, strong) UILabel *onSwitchLabel;
@property(nonatomic, strong) UILabel *progressLabel;
@property(nonatomic, strong) UILabel *progressPercentLabel;
@property(nonatomic, strong) UISlider *slider;
@property(nonatomic, strong) UISwitch *onSwitch;
@property(nonatomic, strong) UISwitch *determinateSwitch;

@end

@implementation ActivityIndicatorExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Activity Indicator";
    self.view.backgroundColor = [UIColor whiteColor];

    CGRect activityIndicator = CGRectMake(0,
                                          0,
                                          kActivityIndicatorRadius * 2,
                                          kActivityIndicatorRadius * 2);
    _activityIndicator = [[MDCActivityIndicator alloc] initWithFrame:activityIndicator];
    _activityIndicator.delegate = self;
    _activityIndicator.radius = kActivityIndicatorRadius;
    _activityIndicator.strokeWidth = 8.f;

    _activityIndicator.autoresizingMask =
        (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
         UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
    [self.view addSubview:_activityIndicator];

    _activityIndicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
    _activityIndicator.progress = kActivityInitialProgress;
    [_activityIndicator startAnimating];
  }
  return self;
}

@end

@implementation ActivityIndicatorExample (CatalogByConvention)

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupViews];
}

- (void)setupViews {
  _onSwitch = [[UISwitch alloc] init];
  [_onSwitch setOn:YES];
  [_onSwitch addTarget:self
                action:@selector(didChangeOnSwitch:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_onSwitch];

  _onSwitchLabel = [[UILabel alloc] init];
  _onSwitchLabel.text = @"Indicator Active";
  _onSwitchLabel.font = [MDCTypography captionFont];
  _onSwitchLabel.alpha = [MDCTypography captionFontOpacity];
  [_onSwitchLabel sizeToFit];
  [self.view addSubview:_onSwitchLabel];

  _determinateSwitch = [[UISwitch alloc] init];
  [_determinateSwitch setOn:YES];
  [_determinateSwitch addTarget:self
                         action:@selector(didChangeDeterminateSwitch:)
               forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_determinateSwitch];

  _determinateSwitchLabel = [[UILabel alloc] init];
  _determinateSwitchLabel.text = @"Determinate Mode";
  _determinateSwitchLabel.font = [MDCTypography captionFont];
  _determinateSwitchLabel.alpha = [MDCTypography captionFontOpacity];
  [_determinateSwitchLabel sizeToFit];
  [self.view addSubview:_determinateSwitchLabel];

  CGRect sliderFrame = CGRectMake(0, 0, 240, 27);
  _slider = [[UISlider alloc] initWithFrame:sliderFrame];
  _slider.value = kActivityInitialProgress;
  [_slider addTarget:self
                action:@selector(didChangeSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_slider];

  _progressLabel = [[UILabel alloc] init];
  _progressLabel.text = @"Progress";
  _progressLabel.font = [MDCTypography captionFont];
  _progressLabel.alpha = [MDCTypography captionFontOpacity];
  [_progressLabel sizeToFit];
  [self.view addSubview:_progressLabel];

  _progressPercentLabel = [[UILabel alloc] init];
  _progressPercentLabel.text =
      [NSString stringWithFormat:@"%.00f%%", kActivityInitialProgress * 100];
  _progressPercentLabel.font = [MDCTypography captionFont];
  _progressPercentLabel.alpha = [MDCTypography captionFontOpacity];
  _progressPercentLabel.frame = CGRectMake(0, 0, 100, 16);
  _progressPercentLabel.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:_progressPercentLabel];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
  _slider.center = CGPointMake(CGRectGetMidX(self.view.frame), 100);
  _progressLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), 130);
  _activityIndicator.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                          CGRectGetMidY(self.view.frame) - navHeight * 2);
  _progressPercentLabel.center = _activityIndicator.center;
  _onSwitch.center = CGPointMake(CGRectGetMidX(self.view.frame) - 50,
                                 self.view.frame.size.height - 150);
  _determinateSwitch.center = CGPointMake(CGRectGetMidX(self.view.frame) - 50,
                                          self.view.frame.size.height - 100);
  _onSwitchLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) + 32,
                                      self.view.frame.size.height - 150);
  _determinateSwitchLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) + 38,
                                               self.view.frame.size.height - 100);
}

- (void)didChangeDeterminateSwitch:(UISwitch *)determinateSwitch {
  if (determinateSwitch.on) {
    _activityIndicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  } else {
    _activityIndicator.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  }
}

- (void)didChangeOnSwitch:(UISwitch *)onSwitch {
  if (onSwitch.on) {
    [_activityIndicator startAnimating];
  } else {
    [_activityIndicator stopAnimating];
  }
}

- (void)didChangeSliderValue:(UISlider *)slider {
  _activityIndicator.progress = slider.value;
  _progressPercentLabel.text = [NSString stringWithFormat:@"%.00f%%", slider.value * 100];
}

#pragma mark - MDCActivityIndicatorDelegate

- (void)activityIndicatorAnimationDidFinish:(nonnull MDCActivityIndicator *)activityIndicator {
  return;
}

#pragma mark - Catalog by Convention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Activity Indicator", @"Activity Indicator" ];
}

+ (NSString *)catalogDescription {
  return @"Activity Indicator is a visual indication of an app loading content. It can display how "
         @"long an operation will take or visualize an unspecified wait time.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end
