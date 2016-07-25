/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import <Foundation/Foundation.h>

#import "DialogsAlertViewControllerSupplemental.h"
#import "MaterialButtons.h"
#import "MaterialDialogs.h"
#import "MaterialTypography.h"

#pragma mark - DialogsAlertViewController

@implementation DialogsAlertViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Dialogs", @"AlertController" ];
}

+ (NSString *)catalogDescription {
  return @"Demonstrate material spec'd alert controllers.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (NSString *)catalogStoryboardName {
  return @"DialogsAlertViewController";
}

@end
