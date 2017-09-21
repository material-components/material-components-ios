/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MDCButtonColorThemer.h"

@interface BottomAppBarTypicalUseExample : MDCBottomAppBarViewController

@end

@implementation BottomAppBarTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom App Bar";
    [self commonBottomBarTypicalUseExampleInit];
  }
  return self;
}

- (void)commonBottomBarTypicalUseExampleInit {
  self.viewController =
      [[BottomAppBarExampleTableViewController alloc] initWithNibName:nil bundle:nil];

  // Add touch handler to the floating button.
  [self.floatingButton addTarget:self
                          action:@selector(didTapFloatingButton:)
                forControlEvents:UIControlEventTouchUpInside];

  // Set the image on the floating button.
  [self.floatingButton setImage:[self floatingButtonImage] forState:UIControlStateNormal];

  // Theme the floating button.
  MDCBasicColorScheme *colorScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:[UIColor whiteColor]];
  [MDCButtonColorThemer applyColorScheme:colorScheme toButton:self.floatingButton];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didTapFloatingButton:(id)sender {
  NSLog(@"Floating button tapped.");
  if (self.floatingButtonPosition == MDCBottomAppBarFloatingButtonPositionCenter) {
    [self setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionTrailing animated:YES];
  } else {
    [self setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionCenter animated:YES];
  }
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

@implementation BottomAppBarTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom App Bar", @"Bottom App Bar" ];
}

+ (NSString *)catalogDescription {
  return @"The bottom app bar is a bar docked at the bottom of the screen that has a floating "
         @"action button and can provide navigation.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
