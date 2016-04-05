/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import <UIKit/UIKit.h>

@class ExampleInstructionsViewNavigationBarTypicalUseExample;
@class MDCNavigationBar;

@interface NavigationBarTypicalUseExample : UIViewController

@property(nonatomic) ExampleInstructionsViewNavigationBarTypicalUseExample *exampleView;
@property(nonatomic) MDCNavigationBar *navBar;

@end

@interface NavigationBarTypicalUseExample (Supplemental)

- (void)setupExampleViews;

@end
