/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to implement any Material Design Components.
 */

#import <UIKit/UIKit.h>

@class ButtonsTypicalUseViewController;

@interface ButtonsTypicalUseViewController : UIViewController

@property(nonatomic, strong) NSMutableDictionary *views;
@property(nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *portraitLayoutConstraints;
@property(nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *landscapeLayoutConstraints;

@end

@interface ButtonsTypicalUseViewController (Supplemental)

- (void)setupExampleViews;

@end
