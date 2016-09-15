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

#import <XCTest/XCTest.h>

#import "MDCAlertController.h"
#import "MDCDialogPresentationControllerDelegate.h"
#import "MDCDialogPresentationController.h"
#import "MDCDialogTransitionController.h"

@interface DummyPresentationControllerDelegate : UIViewController <MDCDialogPresentationControllerDelegate>

@end

@implementation DummyPresentationControllerDelegate

@end

@interface TestGestureRecognizer : UIGestureRecognizer

@property(nonatomic,readwrite) UIGestureRecognizerState state;

@end

@implementation TestGestureRecognizer

@end

@interface TestPresentingViewController : UIViewController

@property (nonatomic, assign) BOOL wasDismissed;

@end

@implementation TestPresentingViewController

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
  [super dismissViewControllerAnimated:flag completion:completion];
  self.wasDismissed = true;
}

@end

@interface MDCDialogPresentationController ()

- (void)dismiss:(UIGestureRecognizer *)gesture;

@end

@interface TestAlertController : MDCAlertController

@property(nonatomic, strong) MDCDialogTransitionController *transitionController;

@end

@implementation TestAlertController

@end

@interface DialogPresentationControllerDelegateTests : XCTestCase <MDCDialogPresentationControllerDelegate>

@property (nonatomic, nullable, strong) UIViewController *presentedViewController;
@property (nonatomic, nullable, strong) TestPresentingViewController *presentingViewController;
@property (nonatomic, nullable, strong) MDCDialogPresentationController *presentationViewController;

@property (nonatomic, nullable, strong) TestGestureRecognizer *gestureRecognizer;

@property (nonatomic, assign) BOOL shouldDismissOnBackgroundTap;

@end

@implementation DialogPresentationControllerDelegateTests

- (void)setUp {
  [super setUp];
  self.presentedViewController = [[UIViewController alloc] init];
  self.presentingViewController = [[TestPresentingViewController alloc] init];
  self.presentationViewController = [[MDCDialogPresentationController alloc] initWithPresentedViewController:self.presentedViewController presentingViewController:self.presentingViewController];
  self.presentationViewController.presentationControllerDelegate = self;
  
  self.gestureRecognizer = [[TestGestureRecognizer alloc] init];
  self.gestureRecognizer.state = UIGestureRecognizerStateRecognized;
  
  self.shouldDismissOnBackgroundTap = true;
}

- (void)testDelegateInitializer {
  MDCAlertController *alertViewController = [MDCAlertController alertControllerWithTitle:@"Title" message:@"Message" presentationControllerDelegate:self];
  
  XCTAssertNotNil(alertViewController);
}

- (void)testPresentationControllerIsDismissed {
  [self.presentationViewController dismiss:self.gestureRecognizer];
  
  XCTAssertTrue(self.presentingViewController.wasDismissed);
}

- (void)testPresentationControllerIsNotDismissedWhenGestureRecognizerIsNotRecognized {
  TestGestureRecognizer *gestureRecognizer = [[TestGestureRecognizer alloc] init];
  gestureRecognizer.state = UIGestureRecognizerStateBegan;
  
  [self.presentationViewController dismiss:gestureRecognizer];
  
  XCTAssertFalse(self.presentingViewController.wasDismissed);
}

- (void)testPresentationControllerIsDismissedIfDelegateIsNil {
  self.presentationViewController.presentationControllerDelegate = nil;
  
  [self.presentationViewController dismiss:self.gestureRecognizer];
  
  XCTAssertTrue(self.presentingViewController.wasDismissed);
}

- (void)testPresentationControllerIsNotDismissedIfDelegateSaysSo {
  self.shouldDismissOnBackgroundTap = NO;
  
  [self.presentationViewController dismiss:self.gestureRecognizer];
  
  XCTAssertFalse(self.presentingViewController.wasDismissed);
}

- (void)testPresentationControllerIsDismissedIfDelegateDoesNotImplementMethods {
  DummyPresentationControllerDelegate *dummyDelegate = [[DummyPresentationControllerDelegate alloc] init];
  self.presentationViewController.presentationControllerDelegate = dummyDelegate;
  
  [self.presentationViewController dismiss:self.gestureRecognizer];
  
  XCTAssertTrue(self.presentingViewController.wasDismissed);
}

- (void)testTransitionControllerDelegation {
  TestAlertController *alertViewController = [TestAlertController alertControllerWithTitle:@"Title" message:@"Message" presentationControllerDelegate:nil];
  
  XCTAssertNil(alertViewController.presentationControllerDelegate);
  XCTAssertNil(alertViewController.transitionController.presentationControllerDelegate);
  
  alertViewController.presentationControllerDelegate = self;
  
  XCTAssertTrue([alertViewController.presentationControllerDelegate isEqual:self]);
  XCTAssertTrue([alertViewController.transitionController.presentationControllerDelegate isEqual:self]);
}

- (void)testViewControllerTransitioningDelegate {
  UIViewController *sourceViewController = [[UIViewController alloc] init];
  TestAlertController *alertViewController = [TestAlertController alertControllerWithTitle:@"Title" message:@"Message" presentationControllerDelegate:self];
  
  MDCDialogPresentationController *presentationController = [alertViewController.transitionController presentationControllerForPresentedViewController:self.presentedViewController presentingViewController:self.presentingViewController sourceViewController:sourceViewController];
  
  XCTAssertTrue([presentationController.presentationControllerDelegate isEqual:self]);
}

#pragma mark MDCDialogPresentationControllerDelegate

- (BOOL)presentationControllerShouldDismissOnBackgroundTap:(MDCDialogPresentationController *)presentationController {
  return self.shouldDismissOnBackgroundTap;
}

@end
