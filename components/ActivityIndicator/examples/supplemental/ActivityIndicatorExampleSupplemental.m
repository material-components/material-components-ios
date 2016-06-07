/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import <Foundation/Foundation.h>

#import "ActivityIndicatorExampleSupplemental.h"
#import "MaterialTypography.h"

@implementation ActivityIndicatorExample (CatalogByConvention)

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

@implementation ActivityIndicatorExample (Supplemental)

- (void)setupExampleViews {
  self.onSwitch = [[UISwitch alloc] init];
  [self.onSwitch setOn:YES];
  [self.onSwitch addTarget:self
                    action:@selector(didChangeOnSwitch:)
          forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.onSwitch];

  self.onSwitchLabel = [[UILabel alloc] init];
  self.onSwitchLabel.text = @"Indicator Active";
  self.onSwitchLabel.font = [MDCTypography captionFont];
  self.onSwitchLabel.alpha = [MDCTypography captionFontOpacity];
  [self.onSwitchLabel sizeToFit];
  [self.view addSubview:self.onSwitchLabel];

  self.determinateSwitch = [[UISwitch alloc] init];
  [self.determinateSwitch setOn:YES];
  [self.determinateSwitch addTarget:self
                             action:@selector(didChangeDeterminateSwitch:)
                   forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.determinateSwitch];

  self.determinateSwitchLabel = [[UILabel alloc] init];
  self.determinateSwitchLabel.text = @"Determinate Mode";
  self.determinateSwitchLabel.font = [MDCTypography captionFont];
  self.determinateSwitchLabel.alpha = [MDCTypography captionFontOpacity];
  [self.determinateSwitchLabel sizeToFit];
  [self.view addSubview:self.determinateSwitchLabel];

  CGRect sliderFrame = CGRectMake(0, 0, 240, 27);
  self.slider = [[UISlider alloc] initWithFrame:sliderFrame];
  self.slider.value = kActivityInitialProgress;
  [self.slider addTarget:self
                  action:@selector(didChangeSliderValue:)
        forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.slider];

  self.progressLabel = [[UILabel alloc] init];
  self.progressLabel.text = @"Progress";
  self.progressLabel.font = [MDCTypography captionFont];
  self.progressLabel.alpha = [MDCTypography captionFontOpacity];
  [self.progressLabel sizeToFit];
  [self.view addSubview:self.progressLabel];

  self.progressPercentLabel = [[UILabel alloc] init];
  self.progressPercentLabel.text =
      [NSString stringWithFormat:@"%.00f%%", kActivityInitialProgress * 100];
  self.progressPercentLabel.font = [MDCTypography captionFont];
  self.progressPercentLabel.alpha = [MDCTypography captionFontOpacity];
  self.progressPercentLabel.frame = CGRectMake(0, 0, 100, 16);
  self.progressPercentLabel.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:self.progressPercentLabel];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
  if (self.view.frame.size.height > self.view.frame.size.width) {
    self.activityIndicator.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                                CGRectGetMidY(self.view.frame) - navHeight * 2);
    self.slider.center = CGPointMake(CGRectGetMidX(self.view.frame), 80);
    self.progressLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), 110);
    self.onSwitch.center = CGPointMake(CGRectGetMidX(self.view.frame) - 50,
                                       self.view.frame.size.height - 140);
    self.onSwitchLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) + 32,
                                            self.view.frame.size.height - 140);
    self.determinateSwitch.center = CGPointMake(CGRectGetMidX(self.view.frame) - 50,
                                                self.view.frame.size.height - 90);
    self.determinateSwitchLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) + 38,
                                                     self.view.frame.size.height - 90);
  } else {
    self.activityIndicator.center = CGPointMake(CGRectGetMidX(self.view.frame) - 150,
                                                CGRectGetMidY(self.view.frame) - 100);
    self.slider.center = CGPointMake(CGRectGetMidX(self.view.frame) + 150, 20);
    self.progressLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) + 150, 50);
    self.onSwitch.center = CGPointMake(CGRectGetMidX(self.view.frame) + 90,
                                       self.view.frame.size.height - 140);
    self.onSwitchLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) + 172,
                                            self.view.frame.size.height - 140);
    self.determinateSwitch.center = CGPointMake(CGRectGetMidX(self.view.frame) + 90,
                                                self.view.frame.size.height - 90);
    self.determinateSwitchLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) + 178,
                                                     self.view.frame.size.height - 90);
  }
  self.progressPercentLabel.center = self.activityIndicator.center;
}

- (void)didChangeDeterminateSwitch:(UISwitch *)determinateSwitch {
  if (determinateSwitch.on) {
    self.activityIndicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  } else {
    self.activityIndicator.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  }
}

- (void)didChangeOnSwitch:(UISwitch *)onSwitch {
  if (onSwitch.on) {
    [self.activityIndicator startAnimating];
  } else {
    [self.activityIndicator stopAnimating];
  }
}

- (void)didChangeSliderValue:(UISlider *)slider {
  self.activityIndicator.progress = slider.value;
  self.progressPercentLabel.text = [NSString stringWithFormat:@"%.00f%%", slider.value * 100];
}

@end
