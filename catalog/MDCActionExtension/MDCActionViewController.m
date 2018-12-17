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

#import "MDCActionViewController.h"

#import <CatalogByConvention/CatalogByConvention.h>

@implementation MDCActionViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  CBCNode *tree = CBCCreatePresentableNavigationTree();

  CBCNodeListViewController *viewController = [[CBCNodeListViewController alloc] initWithNode:tree];
  viewController.title = @"Material Components";
  viewController.navigationItem.leftBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(done)];
  [self pushViewController:viewController animated:NO];
}

- (void)done {
  // Return any edited content to the host app.
  // This extension doesn't do anything, so we just echo the passed in items.
  [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems
                                     completionHandler:nil];
}

@end
