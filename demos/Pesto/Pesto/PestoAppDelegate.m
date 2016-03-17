#import "PestoAppDelegate.h"
#import "PestoFlexibleHeaderContainerViewController.h"

@interface PestoAppDelegate ()

@end

@implementation PestoAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// setStatusBarHidden:withAnimation: was deprecated in iOS 9.
// Silence the related warning.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [[UIApplication sharedApplication] setStatusBarHidden:YES
                                          withAnimation:NO];
#pragma clang diagnostic pop

  PestoFlexibleHeaderContainerViewController *flexHeadContainerVC =
      [[PestoFlexibleHeaderContainerViewController alloc] init];

  [self.window setRootViewController:flexHeadContainerVC];
  [self.window makeKeyAndVisible];

  return YES;
}

@end
