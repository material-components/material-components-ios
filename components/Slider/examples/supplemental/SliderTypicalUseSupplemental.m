/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components iOS.
 */

#import <Foundation/Foundation.h>

#import "MaterialSlider.h"
#import "MaterialTypography.h"
#import "SliderTypicalUseSupplemental.h"

#pragma mark - SliderTypicalUseViewController

@implementation SliderTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Slider", @"Slider" ];
}

+ (NSString *)catalogDescription {
  return @"The MDCSlider object is a material design control used to select a value from a"
          " continuous range or discrete set of values.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation SliderTypicalUseViewController (Supplemental)

- (void)setupExampleViews {
  UILabel *sliderLabel = [[UILabel alloc] init];
  sliderLabel.text = @"Slider";
  sliderLabel.font = [MDCTypography captionFont];
  sliderLabel.alpha = [MDCTypography captionFontOpacity];
  [sliderLabel sizeToFit];
  sliderLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:sliderLabel];

  UILabel *discreteSliderLabel = [[UILabel alloc] init];
  discreteSliderLabel.text = @"Discrete Slider";
  discreteSliderLabel.font = [MDCTypography captionFont];
  discreteSliderLabel.alpha = [MDCTypography captionFontOpacity];
  [discreteSliderLabel sizeToFit];
  discreteSliderLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view insertSubview:discreteSliderLabel belowSubview:self.discreteSlider];

  UILabel *disabledSliderLabel = [[UILabel alloc] init];
  disabledSliderLabel.text = @"Slider Disabled";
  disabledSliderLabel.font = [MDCTypography captionFont];
  disabledSliderLabel.alpha = [MDCTypography captionFontOpacity];
  [disabledSliderLabel sizeToFit];
  disabledSliderLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledSliderLabel];

  NSDictionary *views = @{
    @"slider" : self.slider,
    @"label" : sliderLabel,
    @"discreteSlider" : self.discreteSlider,
    @"discreteSliderLabel" : discreteSliderLabel,
    @"disabledSlider" : self.disabledSlider,
    @"disabledSliderLabel" : disabledSliderLabel
  };

  NSDictionary *metrics = @{
    @"smallVMargin" : @24.0,
    @"largeVMargin" : @56.0,
    @"smallHMargin" : @24.0,
    @"sliderHeight" : @(self.slider.bounds.size.height)
  };

  // Vertical column
  NSString *columnConstraints =
      @"V:[label(sliderHeight)]-smallVMargin-[slider]-largeVMargin-[discreteSliderLabel("
      @"sliderHeight)]-smallVMargin-[discreteSlider]-largeVMargin-[disabledSliderLabel("
      @"sliderHeight)]-smallVMargin-[disabledSlider]";

  // Center view vertically
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.discreteSlider
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.f
                                                         constant:0.f]];

  // Left-align views
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sliderLabel
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1.f
                                                         constant:24.f]];

  // Right-align views
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sliderLabel
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1.f
                                                         constant:-24.f]];

  // All views have same left
  [self.view
      addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:columnConstraints
                                                             options:NSLayoutFormatAlignAllLeft
                                                             metrics:metrics
                                                               views:views]];

  // All views have same right
  [self.view
      addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:columnConstraints
                                                             options:NSLayoutFormatAlignAllRight
                                                             metrics:metrics
                                                               views:views]];
}

@end
