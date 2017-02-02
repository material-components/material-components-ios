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

#import "MaterialBottomSheet.h"
#import "MaterialButtons.h"

@interface ExampleScrollView : UIScrollView
@end

@implementation ExampleScrollView
@end

@interface BottomSheetExampleViewController : UIViewController
@end

@implementation BottomSheetExampleViewController

- (void)loadView {
  UIScrollView *scrollView = [[ExampleScrollView alloc] initWithFrame:CGRectZero];
  scrollView.contentSize = CGSizeMake(100, 1000);
  self.view = scrollView;
  self.view.backgroundColor = [UIColor redColor];
}

@end

@interface BottomSheetTypicalUseExample : UIViewController <UIViewControllerTransitioningDelegate>
@end

@implementation BottomSheetTypicalUseExample {
  MDCButton *_button;
  MDCBottomSheetPresentationController *_presentationController;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [_button setTitle:@"Show Bottom Sheet" forState:UIControlStateNormal];
  [_button sizeToFit];
  _button.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
      UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  [_button addTarget:self
              action:@selector(didTapButton:)
    forControlEvents:UIControlEventTouchUpInside];
  _button.center = self.view.center;
  [self.view addSubview:_button];
}

- (void)didTapButton:(id)sender {
  UIViewController *viewController = [[BottomSheetExampleViewController alloc] initWithCoder:nil];
  viewController.transitioningDelegate = self;
  viewController.modalPresentationStyle = UIModalPresentationCustom;
  [self presentViewController:viewController animated:YES completion:nil];
}

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(UIViewController *)source {
  return [[MDCBottomSheetPresentationController alloc] initWithPresentedViewController:presented
                                                              presentingViewController:presenting];
}

@end

@implementation BottomSheetTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom Sheet", @"Bottom Sheet" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"...";
}

@end

#pragma mark - Typical application code (not Material-specific)

@implementation BottomSheetTypicalUseExample (GeneralApplicationLogic)

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom Sheet";
  }
  return self;
}

@end
