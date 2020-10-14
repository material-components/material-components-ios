// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextControlTextAreaConfiguratorExample.h"

#import "MDCTextControlTextAreaContentViewController.h"

static NSString *const kExampleTitle = @"MDCTextControl TextAreas";

@implementation MDCTextControlTextAreaConfiguratorExample

#pragma mark View Controller Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = kExampleTitle;
}

#pragma mark Setup

- (void)initializeContentViewController {
  self.contentViewController = [[MDCTextControlTextAreaContentViewController alloc] init];
}

@end

#pragma mark - CatalogByConvention

@implementation MDCTextControlTextAreaConfiguratorExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Controls", kExampleTitle ],
    @"description" : @"Text areas let users enter and edit text.",
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end
