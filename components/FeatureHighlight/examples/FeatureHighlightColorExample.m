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

#import "MaterialFeatureHighlight+FeatureHighlightAccessibilityMutator.h"
#import "MaterialFeatureHighlight.h"
#import "supplemental/FeatureHighlightExampleSupplemental.h"

@implementation FeatureHighlightColorExample

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  MDCCollectionViewTextCell *cell =
      (MDCCollectionViewTextCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
  MDCFeatureHighlightViewController *highlightController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:cell.accessoryView
                                                              completion:nil];
  highlightController.titleText = @"So pretty!";
  // Remove "double-tap to dismiss"
  highlightController.accessibilityHint = nil;
  highlightController.bodyText = @"What a nice color you've chosen.";
  highlightController.outerHighlightColor = cell.accessoryView.backgroundColor;
  [MDCFeatureHighlightAccessibilityMutator mutate:highlightController];
  [self presentViewController:highlightController animated:YES completion:nil];
}

@end
