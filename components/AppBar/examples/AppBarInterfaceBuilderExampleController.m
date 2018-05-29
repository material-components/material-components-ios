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

#import "MaterialAppBar.h"
#import "MaterialAppBar+ColorThemer.h"

@interface AppBarInterfaceBuilderExample : UIViewController <UIScrollViewDelegate>

@property(nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) MDCAppBar *appBar;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;

@end

@implementation AppBarInterfaceBuilderExample

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonAppBarInterfaceBuilderExampleSetup];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self commonAppBarInterfaceBuilderExampleSetup];
}

- (void)commonAppBarInterfaceBuilderExampleSetup {
  self.appBar = [[MDCAppBar alloc] init];
  self.colorScheme = [[MDCSemanticColorScheme alloc] init];
  [self addChildViewController:self.appBar.headerViewController];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [MDCAppBarColorThemer applySemanticColorScheme:self.colorScheme toAppBar:_appBar];
  
  self.appBar.headerViewController.headerView.trackingScrollView = self.scrollView;

  // Choice: If you do not need to implement any delegate methods and you are not using a
  //         collection view, you can use the headerViewController as the delegate.
  // Alternative: See AppBarTypicalUseExample.
  self.scrollView.delegate = self.appBar.headerViewController;

  [self.appBar addSubviewsToParent];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

@end

@implementation AppBarInterfaceBuilderExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"App Bar", @"Interface Builder" ];
}

+ (NSString *)catalogStoryboardName {
  return @"AppBarInterfaceBuilderExampleController";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

@end
