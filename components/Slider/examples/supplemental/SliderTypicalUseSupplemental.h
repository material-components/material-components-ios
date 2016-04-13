/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to implement any Material Design Components.
 */

#import <UIKit/UIKit.h>

@class MDCSlider;
@class SliderTypicalUseViewController;

@interface SliderTypicalUseViewController : UIViewController

@property(nonatomic) MDCSlider *slider;
@property(nonatomic) MDCSlider *disabledSlider;

@end

@interface SliderTypicalUseViewController (Supplemental)

- (void)setupExampleViews;

@end
