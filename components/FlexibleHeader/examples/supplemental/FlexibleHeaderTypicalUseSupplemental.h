/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to implement any Material Design Components.
 */

#import <UIKit/UIKit.h>

@class ExampleInstructionsViewFlexibleHeaderTypicalUse;

@interface FlexibleHeaderTypicalUseViewController : UIViewController

@property(nonatomic) ExampleInstructionsViewFlexibleHeaderTypicalUse *exampleView;
@property(nonatomic) UIScrollView *scrollView;

@end

@interface FlexibleHeaderTypicalUseViewController (Supplemental)

- (void)setupExampleViews;

@end
