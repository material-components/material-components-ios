// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#if !TARGET_OS_MACCATALYST

#import "supplemental/BottomSheetDummyStaticViewController.h"
#import "BottomSheetPresenterViewController.h"
#import "MaterialBottomSheet.h"

@interface BottomSheetTallExample : BottomSheetPresenterViewController
@end

@implementation BottomSheetTallExample

- (void)presentBottomSheet {
  BottomSheetDummyStaticViewController *viewController =
      [[BottomSheetDummyStaticViewController alloc] init];
  viewController.preferredContentSize = CGSizeMake(200, 200);
  viewController.view.isAccessibilityElement = YES;
  viewController.view.accessibilityLabel = @"Example content";

  MDCBottomSheetController *bottomSheet =
      [[MDCBottomSheetController alloc] initWithContentViewController:viewController];
  [self presentViewController:bottomSheet animated:YES completion:nil];
}

@end

@implementation BottomSheetTallExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Preferred Content Size" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

#endif
