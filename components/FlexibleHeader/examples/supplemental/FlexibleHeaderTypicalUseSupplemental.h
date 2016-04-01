/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to implement any Material Design Components.
*/

#import <UIKit/UIKit.h>

@class MDCFlexibleHeaderViewController;
@class ExampleInstructionsView;

@interface FlexibleHeaderTypicalUseViewController : UIViewController

@property(nonatomic) ExampleInstructionsView *exampleView;
@property(nonatomic) UIScrollView *scrollView;

@end

@class ExampleInstructionsView;

@interface FlexibleHeaderTypicalUseViewController (Supplemental)

- (void)setupExampleViews;

@end
