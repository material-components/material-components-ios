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

#import "MDCBottomSheetController.h"

#import "MDCBottomSheetTransitionController.h"

@interface MDCBottomSheetController () <UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) MDCBottomSheetTransitionController *transitionController;

@end

@implementation MDCBottomSheetController

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController {
  if (self = [super initWithNibName:nil bundle:nil]) {
    _contentViewController = contentViewController;

    _transitionController = [[MDCBottomSheetTransitionController alloc] init];
    self.transitioningDelegate = _transitionController;
    self.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

@end
