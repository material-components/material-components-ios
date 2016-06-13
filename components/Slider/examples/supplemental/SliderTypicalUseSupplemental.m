/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
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
  return @"The MDCSlider object is a Material Design control used to select a value from a"
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
    @"disabledSlider" : self.disabledSlider,
    @"disabledSliderLabel" : disabledSliderLabel
  };

  NSDictionary *metrics = @{
    @"smallVMargin" : @24.0,
    @"largeVMargin" : @56.0,
    @"smallHMargin" : @24.0,
    @"sliderHeight" : @(self.slider.bounds.size.height)
  };

  // Vertical column of sliders
  NSString *sliderLayoutConstraints = @"V:[slider]-smallVMargin-[disabledSlider]";

  // Vertical column of labels
  NSString *labelLayoutConstraints =
      @"V:[label(sliderHeight)]-smallVMargin-[disabledSliderLabel(sliderHeight)]";

  // Horizontal alignment between the two columns
  NSString *columnConstraints = @"[label(100)]-smallHMargin-[slider]";

  // Center view horizontally on the left edge of one of the sliders
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.disabledSlider
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.f
                                                         constant:12.f]];

  // Center view vertically
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.disabledSlider
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.f
                                                         constant:0.f]];

  // Center sliders in their column
  [self.view
      addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:sliderLayoutConstraints
                                                             options:NSLayoutFormatAlignAllCenterX
                                                             metrics:metrics
                                                               views:views]];

  // Left align labels in their column
  [self.view
      addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:labelLayoutConstraints
                                                             options:NSLayoutFormatAlignAllLeft
                                                             metrics:metrics
                                                               views:views]];

  // Vertically align first element in label column to first element in slider column
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slider
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:sliderLabel
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.f
                                                         constant:0.f]];

  // Position label column left of slider column, wide enough to accommodate label text
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:columnConstraints
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:views]];
}

@end
