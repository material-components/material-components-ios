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
#import "MaterialBottomSheet.h"
#import "MaterialShapes.h"
#import "MaterialShapeLibrary.h"
#import "supplemental/BottomSheetDummyStaticViewController.h"
#import "supplemental/BottomSheetDummyCollectionViewController.h"
#import "supplemental/BottomSheetSupplemental.h"

@implementation BottomSheetShapedExample

- (void)presentBottomSheet {
  BottomSheetDummyCollectionViewController *viewController =
      [[BottomSheetDummyCollectionViewController alloc] initWithNumItems:102];
  viewController.title = @"Shaped bottom sheet example";

  MDCAppBarContainerViewController *container =
      [[MDCAppBarContainerViewController alloc] initWithContentViewController:viewController];
  container.preferredContentSize = CGSizeMake(500, 200);
  container.appBarViewController.headerView.trackingScrollView =
      viewController.collectionView;
  container.topLayoutGuideAdjustmentEnabled = YES;

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:container.appBarViewController];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                            toAppBarViewController:container.appBarViewController];

  MDCBottomSheetController *bottomSheet =
      [[MDCBottomSheetController alloc] initWithContentViewController:container];
  bottomSheet.trackingScrollView = viewController.collectionView;
  MDCRectangleShapeGenerator *shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  MDCCornerTreatment *cornerTreatment = [[MDCRoundedCornerTreatment alloc] initWithRadius:16.f];
  shapeGenerator.topLeftCorner = cornerTreatment;
  shapeGenerator.topRightCorner = cornerTreatment;
  [bottomSheet setShapeGenerator:shapeGenerator forState:MDCSheetStatePreferred];
  [self presentViewController:bottomSheet animated:YES completion:nil];
}

@end
