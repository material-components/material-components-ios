// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialApplication.h"
#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialCollections.h"
#import "MaterialColorScheme.h"
#import "MaterialDialogs+Theming.h"
#import "MaterialDialogs.h"
#import "MaterialTypographyScheme.h"
#import "supplemental/DialogWithPreferredContentSizeExampleViewController.h"

#pragma mark - DialogsDismissingExampleViewController Interfaces

@interface DialogsDismissingExampleViewController : MDCCollectionViewController
@property(nonatomic, strong, nullable) id<MDCContainerScheming> containerScheme;
@property(nonatomic, strong, nullable) NSArray *modes;
@property(nonatomic, strong) MDCDialogTransitionController *transitionController;
@end

@interface DialogsDismissingExampleViewController (Supplemental)
- (void)loadCollectionView:(nullable NSArray *)modes;
@end

@interface ProgrammaticViewController : UIViewController
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@end

@interface OpenURLViewController : UIViewController
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@end

#pragma mark - DialogsDismissingExampleViewController Implementation

@implementation DialogsDismissingExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
    scheme.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _containerScheme = scheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self loadCollectionView:@[
    @"Dismissable Programmatic", @"Dismissable Storyboard", @"Non-dismissable Programmatic",
    @"Open URL"
  ]];
  // We must create and store a strong reference to the transitionController.
  // A presented view controller will set this object as its transitioning delegate.
  self.transitionController = [[MDCDialogTransitionController alloc] init];
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  if (indexPath.row == 0) {
    [self didTapProgrammatic];
  } else if (indexPath.row == 1) {
    [self didTapStoryboard];
  } else if (indexPath.row == 2) {
    [self didTapModalProgrammatic];
  } else if (indexPath.row == 3) {
    [self didTapOpenURL];
  }
}

- (IBAction)didTapProgrammatic {
  ProgrammaticViewController *viewController =
      [[ProgrammaticViewController alloc] initWithNibName:nil bundle:nil];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;
  viewController.containerScheme = self.containerScheme;

  // Apply a presentation theme to the custom view controller
  [viewController.mdc_dialogPresentationController applyThemeWithScheme:self.containerScheme];
  [self presentViewController:viewController animated:YES completion:NULL];
}

- (IBAction)didTapModalProgrammatic {
  ProgrammaticViewController *viewController =
      [[ProgrammaticViewController alloc] initWithNibName:nil bundle:nil];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;
  viewController.containerScheme = self.containerScheme;

  MDCDialogPresentationController *presentationController =
      viewController.mdc_dialogPresentationController;
  presentationController.dismissOnBackgroundTap = NO;
  [presentationController applyThemeWithScheme:self.containerScheme];
  [self presentViewController:viewController animated:YES completion:NULL];
}

- (IBAction)didTapOpenURL {
  OpenURLViewController *viewController = [[OpenURLViewController alloc] initWithNibName:nil
                                                                                  bundle:nil];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;
  viewController.containerScheme = self.containerScheme;

  [viewController.mdc_dialogPresentationController applyThemeWithScheme:self.containerScheme];
  [self presentViewController:viewController animated:YES completion:NULL];
}

- (IBAction)didTapStoryboard {
  // If you are using this code outside of the MDCCatalog in your own app, your bundle may be nil.
  NSBundle *bundle = [NSBundle bundleForClass:[DialogsDismissingExampleViewController class]];
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DialogWithPreferredContentSize"
                                                       bundle:bundle];
  NSString *identifier = @"DialogID";

  DialogWithPreferredContentSizeExampleViewController *viewController =
      [storyboard instantiateViewControllerWithIdentifier:identifier];
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  viewController.transitioningDelegate = self.transitionController;
  viewController.containerScheme = self.containerScheme;

  [viewController.mdc_dialogPresentationController applyThemeWithScheme:self.containerScheme];
  [self presentViewController:viewController animated:YES completion:NULL];
}

@end

#pragma mark - DialogsDismissingExampleViewController - Supplemental

static NSString *const kReusableIdentifierItem = @"cell";

@implementation DialogsDismissingExampleViewController (Supplemental)

- (void)loadCollectionView:(nullable NSArray *)modes {
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];
  self.modes = modes;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.modes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = self.modes[indexPath.row];
  cell.isAccessibilityElement = YES;
  cell.accessibilityTraits = UIAccessibilityTraitButton;
  cell.accessibilityLabel = cell.textLabel.text;
  return cell;
}

@end

@implementation DialogsDismissingExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Dialogs", @"Dismissing Dialogs" ],
    @"description" : @"Exploring different aspects of dismissing Dialogs.",
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

#pragma mark - ProgrammaticViewController

@interface ProgrammaticViewController ()

@property(nonatomic, strong) MDCButton *dismissButton;

@end

@implementation ProgrammaticViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  id<MDCColorScheming> colorScheme =
      self.containerScheme.colorScheme
          ?: [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  self.view.backgroundColor = colorScheme.backgroundColor;

  self.dismissButton = [[MDCButton alloc] init];
  [self.dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [self.dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  self.dismissButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  [self.dismissButton addTarget:self
                         action:@selector(dismiss:)
               forControlEvents:UIControlEventTouchUpInside];
  [self.dismissButton applyTextThemeWithScheme:self.containerScheme];

  [self.view addSubview:self.dismissButton];
}

- (void)setContainerScheme:(id<MDCContainerScheming>)containerScheme {
  _containerScheme = containerScheme;

  [self.dismissButton applyTextThemeWithScheme:_containerScheme];
  self.view.backgroundColor = _containerScheme.colorScheme.backgroundColor;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_dismissButton sizeToFit];
  _dismissButton.center =
      CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

- (CGSize)preferredContentSize {
  return CGSizeMake(200.0, 140.0);
}

- (IBAction)dismiss:(id)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)accessibilityPerformEscape {
  [self dismissViewControllerAnimated:YES completion:nil];
  return YES;
}

@end

#pragma mark - OpenURLViewController

@interface OpenURLViewController ()

@property(nonatomic, strong) MDCButton *dismissButton;

@end

@implementation OpenURLViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  id<MDCColorScheming> colorScheme =
      self.containerScheme.colorScheme
          ?: [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  self.view.backgroundColor = colorScheme.backgroundColor;

  self.dismissButton = [[MDCButton alloc] init];
  [self.dismissButton setTitle:@"material.io" forState:UIControlStateNormal];
  [self.dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  self.dismissButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  [self.dismissButton addTarget:self
                         action:@selector(dismiss:)
               forControlEvents:UIControlEventTouchUpInside];
  [self.dismissButton applyTextThemeWithScheme:self.containerScheme];
  [self.view addSubview:self.dismissButton];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_dismissButton sizeToFit];
  _dismissButton.center =
      CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

- (CGSize)preferredContentSize {
  return CGSizeMake(200.0, 140.0);
}

- (IBAction)dismiss:(id)sender {
  NSURL *testURL = [NSURL URLWithString:@"https://material.io"];
  // Use mdc_safeSharedApplication to avoid a compiler warning about extensions
  [[UIApplication mdc_safeSharedApplication] performSelector:@selector(openURL:)
                                                  withObject:testURL];
}

- (BOOL)accessibilityPerformEscape {
  [self dismissViewControllerAnimated:YES completion:nil];
  return YES;
}

@end
