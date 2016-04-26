/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to implement any Material Design Components.
 */

#import <UIKit/UIKit.h>

@interface ExampleShapes : UIView

@end

@class InkTypicalUseViewController;

@interface InkTypicalUseViewController : UIViewController

@property(nonatomic, strong) ExampleShapes *boundedShapes;
@property(nonatomic, strong) UIView *unboundedShape;

@end

@interface InkTypicalUseViewController (Supplemental)

- (void)setupExampleViews;

@end
