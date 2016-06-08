/* IMPORTANT:
 This file contains supplemental code used to populate the demos with dummy data or instructions.
 It is not necessary to import this file to implement any Material Design Components.
 */

#import <UIKit/UIKit.h>

#import "MaterialActivityIndicator.h"

static const CGFloat kActivityIndicatorRadius = 72.f;
static const CGFloat kActivityInitialProgress = 0.6f;

@class ActivityIndicatorExample;
@class MDCActivityIndicator;

@interface ActivityIndicatorExample : UIViewController <MDCActivityIndicatorDelegate>

@property(nonatomic, strong) MDCActivityIndicator *activityIndicator;
@property(nonatomic, strong) UILabel *determinateSwitchLabel;
@property(nonatomic, strong) UILabel *onSwitchLabel;
@property(nonatomic, strong) UILabel *progressLabel;
@property(nonatomic, strong) UILabel *progressPercentLabel;
@property(nonatomic, strong) UISlider *slider;
@property(nonatomic, strong) UISwitch *onSwitch;
@property(nonatomic, strong) UISwitch *determinateSwitch;

@end

@interface ActivityIndicatorExample (Supplemental)

- (void)setupExampleViews;

@end
