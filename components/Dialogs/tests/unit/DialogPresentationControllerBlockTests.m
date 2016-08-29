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
#import "MDCDialogPresentationController.h"
#import "MDCDialogTransitionController.h"

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

@interface DialogPresentationControllerBlockTests : XCTestCase

@property (nonatomic, nullable, strong) UIViewController *presentedViewController;
@property (nonatomic, nullable, strong) TestPresentingViewController *presentingViewController;
@property (nonatomic, nullable, strong) MDCDialogPresentationController *presentationViewController;

@property (nonatomic, nullable, strong) TestGestureRecognizer *gestureRecognizer;

@end

@implementation DialogPresentationControllerBlockTests

- (void)setUp {
  [super setUp];
  self.presentedViewController = [[UIViewController alloc] init];
  self.presentingViewController = [[TestPresentingViewController alloc] init];
  self.presentationViewController = [[MDCDialogPresentationController alloc] initWithPresentedViewController:self.presentedViewController presentingViewController:self.presentingViewController];
  self.presentationViewController.presentationControllerBlock = ^BOOL(MDCDialogPresentationController * _Nonnull presentationController) {
    return YES;
  };
  
  self.gestureRecognizer = [[TestGestureRecognizer alloc] init];
  self.gestureRecognizer.state = UIGestureRecognizerStateRecognized;
}

- (void)testBlockInitializer {
  MDCAlertController *alertController = [MDCAlertController alertControllerWithTitle:@"Title" message:@"Message" presentationControllerBlock:^BOOL(MDCDialogPresentationController * _Nonnull presentationController) {
    return YES;
  }];
  
  XCTAssertNotNil(alertController);
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

- (void)testPresentationControllerIsDismissedIfBlockIsNil {
  self.presentationViewController.presentationControllerBlock = nil;
  
  [self.presentationViewController dismiss:self.gestureRecognizer];
  
  XCTAssertTrue(self.presentingViewController.wasDismissed);
}

- (void)testPresentationControllerIsNotDismissedIfBlockSaysSo {
  
  self.presentationViewController.presentationControllerBlock = ^BOOL(MDCDialogPresentationController * _Nonnull presentationController) {
    return NO;
  };
  
  [self.presentationViewController dismiss:self.gestureRecognizer];
  
  XCTAssertFalse(self.presentingViewController.wasDismissed);
}

@end
