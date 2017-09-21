/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "BottomAppBarExampleTableViewController.h"
#import "MaterialBottomAppBar.h"
#import "MaterialNavigationBar.h"
#import "MDCButtonColorThemer.h"
#import "MDCNavigationBarColorThemer.h"

@interface BottomAppBarNavBarViewController : UIViewController

@property(nonatomic, strong) MDCNavigationBar *navBar;

@end

@implementation BottomAppBarNavBarViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupNavBar];
}

- (void)setupNavBar {
  self.navBar = [[MDCNavigationBar alloc] initWithFrame:self.view.bounds];
  self.navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;

  UINavigationItem *navItem = [[UINavigationItem alloc] init];
  [self.view addSubview:self.navBar];

  // Configure the navigation buttons to be shown on the bottom app bar.
  UIBarButtonItem *barButtonLeadingItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapLeft:)];

  UIBarButtonItem *barButtonTrailingItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapRight:)];

  navItem.leftBarButtonItems = @[ barButtonLeadingItem ];
  navItem.rightBarButtonItems = @[ barButtonTrailingItem ];

  [self.navBar setLeftBarButtonItems:navItem.leftBarButtonItems];
  [self.navBar setRightBarButtonItems:navItem.rightBarButtonItems];

  MDCBasicColorScheme *clearScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:[UIColor clearColor]];
  [MDCNavigationBarColorThemer applyColorScheme:clearScheme toNavigationBar:self.navBar];
  self.navBar.tintColor = [UIColor blackColor];
}

- (void)didTapLeft:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapRight:(id)sender {
  NSLog(@"Right button tapped.");
}

@end

@interface BottomBarNavBarExample : MDCBottomAppBarViewController

@end

@implementation BottomBarNavBarExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom App Bar Nav Bar";
    [self commonBottomBarNavBarExampleInit];
  }
  return self;
}

- (void)commonBottomBarNavBarExampleInit {
  self.viewController =
      [[BottomAppBarExampleTableViewController alloc] initWithNibName:nil bundle:nil];
  self.contentViewController =
      [[BottomAppBarNavBarViewController alloc] initWithNibName:nil bundle:nil];
  self.floatingButtonPosition = MDCBottomAppBarFloatingButtonPositionCenter;

  // Add touch handler to the floating button.
  [self.floatingButton addTarget:self
                          action:@selector(didTapFloatingButton:)
                forControlEvents:UIControlEventTouchUpInside];

  // Set the image on the floating button.
  [self.floatingButton setImage:[self floatingButtonImage] forState:UIControlStateNormal];

  // Theme the floating button.
  MDCBasicColorScheme *whiteScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:[UIColor whiteColor]];
  [MDCButtonColorThemer applyColorScheme:whiteScheme toButton:self.floatingButton];
}

- (void)didTapFloatingButton:(id)sender {
  // Hide the floating button.
  [self setFloatingButtonHidden:YES animated:YES];

  // Show the floating button again for illustrative purposes to demonstrate the floating button
  // reappearance animation. In an actual application implementation an action in the application
  // view would typically cause the floating button to reappear.
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [self setFloatingButtonHidden:NO animated:YES];
  });
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (UIImage *)floatingButtonImage {
  UIImage *plusImage = [UIImage imageNamed:@"Plus"];
  CIImage *coreImage = [CIImage imageWithCGImage:plusImage.CGImage];
  CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
  [filter setValue:coreImage forKey:kCIInputImageKey];
  CIImage *result = [filter valueForKey:kCIOutputImageKey];
  return [UIImage imageWithCIImage:result];
}

@end

@implementation BottomBarNavBarExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom App Bar", @"Bottom App Bar with Nav Bar" ];
}

+ (NSString *)catalogDescription {
  return @"The bottom app bar with a nav bar.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
