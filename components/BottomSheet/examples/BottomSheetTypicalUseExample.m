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

#import <UIKit/UIKit.h>

#import "MaterialAppBar.h"
#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialBottomSheet.h"
#import "MaterialBottomSheet+ShapeThemer.h"
#import "supplemental/BottomSheetDummyCollectionViewController.h"
#import "supplemental/BottomSheetSupplemental.h"

@implementation BottomSheetTypicalUseExample

- (void)presentBottomSheet {
  BottomSheetDummyCollectionViewController *viewController =
      [[BottomSheetDummyCollectionViewController alloc] initWithNumItems:102];
  viewController.title = @"Bottom sheet example";

  MDCAppBarContainerViewController *container =
      [[MDCAppBarContainerViewController alloc] initWithContentViewController:viewController];
  container.preferredContentSize = CGSizeMake(500, 200);
  container.appBar.headerViewController.headerView.trackingScrollView =
      viewController.collectionView;
  container.topLayoutGuideAdjustmentEnabled = YES;

  [MDCAppBarColorThemer applySemanticColorScheme:self.colorScheme toAppBar:container.appBar];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme toAppBar:container.appBar];

  MDCBottomSheetController *bottomSheet =
      [[MDCBottomSheetController alloc] initWithContentViewController:container];
  [MDCBottomSheetControllerShapeThemer applyShapeScheme:self.shapeScheme
                                toBottomSheetController:bottomSheet];
  [MDCBottomSheetControllerBaselineShapeThemer
      applyShapeBaselineToBottomSheetController:bottomSheet];
  bottomSheet.trackingScrollView = viewController.collectionView;
  [self presentViewController:bottomSheet animated:YES completion:nil];
}

@end
