/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import <Foundation/Foundation.h>

#import "MaterialSwitch.h"
#import "MaterialTypography.h"
#import "SwitchTypicalUseSupplemental.h"

#pragma mark - SwitchTypicalUseViewController

@implementation SwitchTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Switch", @"Switch" ];
}

+ (NSString *)catalogDescription {
  return @"The MDCSlider object is a Material Design control used to select a value from a"
          " continuous range or discrete set of values.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation SwitchTypicalUseViewController (Supplemental)

- (void)setupExampleViews {
  UILabel *switchLabel = [[UILabel alloc] init];
  switchLabel.text = @"Switch";
  switchLabel.font = [MDCTypography captionFont];
  switchLabel.alpha = [MDCTypography captionFontOpacity];
  [switchLabel sizeToFit];
  switchLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:switchLabel];

  UILabel *colorSwitchButtonLabel = [[UILabel alloc] init];
  colorSwitchButtonLabel.text = @"Custom Color";
  colorSwitchButtonLabel.font = [MDCTypography captionFont];
  colorSwitchButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [colorSwitchButtonLabel sizeToFit];
  colorSwitchButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:colorSwitchButtonLabel];

  UILabel *disabledSwitchButtonLabel = [[UILabel alloc] init];
  disabledSwitchButtonLabel.text = @"Disabled";
  disabledSwitchButtonLabel.font = [MDCTypography captionFont];
  disabledSwitchButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [disabledSwitchButtonLabel sizeToFit];
  disabledSwitchButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledSwitchButtonLabel];

  NSDictionary *views = @{
    @"slider" : self.switchComponent,
    @"label" : switchLabel,
    @"colorSlider" : self.colorSwitchComponent,
    @"colorLabel" : colorSwitchButtonLabel,
    @"disabledSlider" : self.disabledSwitchComponent,
    @"disabledLabel" : disabledSwitchButtonLabel
  };

  NSDictionary *metrics = @{
    @"smallVMargin" : @24.0,
    @"smallHMargin" : @24.0,
    @"buttonHeight" : @(self.switchComponent.bounds.size.height)
  };

  // Vertical column of switches
  NSString *sliderLayoutConstraints =
      @"V:[slider]-smallVMargin-[colorSlider]-smallVMargin-[disabledSlider]";

  // Vertical column of labels
  NSString *labelLayoutConstraints =
      @"V:[label(buttonHeight)]-smallVMargin-[colorLabel(buttonHeight)]-smallVMargin-"
       "[disabledLabel(buttonHeight)]";

  // Horizontal alignment between the two columns
  NSString *columnConstraints = @"[label(100)]-smallHMargin-[slider]";

  // Center view horizontally on the left edge of one of the switches
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.colorSwitchComponent
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.f
                                                         constant:40.f]];

  // Center view vertically
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.colorSwitchComponent
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.f
                                                         constant:0]];

  // Center switches in their column
  [self.view
      addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:sliderLayoutConstraints
                                                             options:NSLayoutFormatAlignAllCenterX
                                                             metrics:metrics
                                                               views:views]];

  // Left align labels in their column
  [self.view
      addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:labelLayoutConstraints
                                                             options:NSLayoutFormatAlignAllLeading
                                                             metrics:metrics
                                                               views:views]];

  // Vertically align first element in label column to first element in switch column
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.switchComponent
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:switchLabel
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
