// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <UIKit/UIKit.h>

#import "MaterialAppBar.h"
#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialButtons.h"
#import "MaterialButtons+ButtonThemer.h"

@interface PresentedDemoViewController : UICollectionViewController
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation PresentedDemoViewController

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}

- (id)init {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 10;

  self = [super initWithCollectionViewLayout:layout];

  if (self) {
    self.title = @"Presented App Bar";

    _appBarViewController = [[MDCAppBarViewController alloc] init];

    // Behavioral flags.
    _appBarViewController.inferTopSafeAreaInsetFromViewController = YES;
    _appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;

    [self addChildViewController:_appBarViewController];

    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Allows us to avoid forwarding events, but means we can't enable shift behaviors.
  self.appBarViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:_appBarViewController];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                            toAppBarViewController:_appBarViewController];

  // Need to update the status bar style after applying the theme.
  [self setNeedsStatusBarAppearanceUpdate];

  _appBarViewController.headerView.trackingScrollView = self.collectionView;

  [self.view addSubview:_appBarViewController.view];
  [_appBarViewController didMoveToParentViewController:self];

  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:@"Cell"];

  self.navigationItem.leftBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(dismiss)];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)dismiss {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 100;
}

- (CGSize)preferredContentSize {
  return CGSizeMake(300, 300);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  switch (indexPath.row%3) {
    case 0:
      cell.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.2 alpha:1];
      break;
    case 1:
      cell.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.5 alpha:1];
      break;
    case 2:
      cell.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.7 alpha:1];
      break;
    default:
      break;
  }

  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGRect collectionViewFrame = collectionView.frame;
  return CGSizeMake(collectionViewFrame.size.width / 2 - 14, 40);
}

@end

@interface AppBarPresentedExample : UIViewController

@property(nonatomic, strong) PresentedDemoViewController *demoViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@implementation AppBarPresentedExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.95 alpha:1];

  self.demoViewController = [[PresentedDemoViewController alloc] init];
  self.demoViewController.colorScheme = self.colorScheme;
  self.demoViewController.typographyScheme = self.typographyScheme;

  // Need to update the status bar style after applying the theme.
  [self setNeedsStatusBarAppearanceUpdate];

  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.typographyScheme = self.typographyScheme;

  CGFloat buttonMargin = 10;
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Present Modal App Bar Demo" forState:UIControlStateNormal];
  [button sizeToFit];
  button.center = self.view.center;
  button.frame =
      CGRectMake(button.frame.origin.x,
                 button.center.y - 48 * 2 - buttonMargin,
                 button.bounds.size.width,
                 MAX(button.bounds.size.height, 48));
  [button addTarget:self
             action:@selector(presentDemo)
   forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:button];

  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    MDCButton *popoverButton = [[MDCButton alloc] init];
    [popoverButton setTitle:@"Present Popover App Bar Demo" forState:UIControlStateNormal];
    [popoverButton sizeToFit];
    popoverButton.center = self.view.center;
    popoverButton.frame =
    CGRectMake(popoverButton.frame.origin.x,
               popoverButton.center.y - 48,
               popoverButton.bounds.size.width,
               MAX(popoverButton.bounds.size.height, 48));
    [popoverButton addTarget:self
                      action:@selector(presentDemoPopover)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popoverButton];

    [MDCContainedButtonThemer applyScheme:buttonScheme toButton:popoverButton];
  }
}

- (void)presentDemo {
  self.demoViewController.modalPresentationStyle = UIModalPresentationPageSheet;
  [self presentViewController:self.demoViewController animated:YES completion:nil];
}

- (void)presentDemoPopover {
  CGRect rect = CGRectMake(self.view.bounds.size.width / 2, self.topLayoutGuide.length, 1, 1);
  if (@available(iOS 11.0, *)) {
    rect = CGRectMake(self.view.bounds.size.width / 2, self.view.safeAreaInsets.top, 1, 1);
  }
  
  self.demoViewController.modalPresentationStyle = UIModalPresentationPopover;
  self.demoViewController.popoverPresentationController.sourceView = self.view;
  self.demoViewController.popoverPresentationController.sourceRect = rect;
  UIPopoverController *popoverController =
      [[UIPopoverController alloc] initWithContentViewController:self.demoViewController];
  [popoverController presentPopoverFromRect:rect
                                     inView:self.view
                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                   animated:YES];
}

@end

@implementation AppBarPresentedExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"App Bar", @"Presented" ],
    @"primaryDemo": @NO,
    @"presentable": @YES,
  };
}

@end
