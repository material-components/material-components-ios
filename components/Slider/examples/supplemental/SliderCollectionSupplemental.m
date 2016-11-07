/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to use Material Components for iOS.
 */

#import "SliderCollectionSupplemental.h"

@implementation SliderCollectionViewController (CatalogByConvention)

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
