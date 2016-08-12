/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to use Material Components for iOS.
 */

#import <UIKit/UIKit.h>

@class MDCSwitch;
@class SwitchTypicalUseViewController;

@interface SwitchTypicalUseViewController : UIViewController

@property(nonatomic) MDCSwitch *switchComponent;
@property(nonatomic) MDCSwitch *colorSwitchComponent;
@property(nonatomic) MDCSwitch *disabledSwitchComponent;

@end

@interface SwitchTypicalUseViewController (Supplemental)

- (void)setupExampleViews;

@end
