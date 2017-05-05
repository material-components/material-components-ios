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

#import "MaterialOverlays.h"
#import "MaterialSnackbar.h"
#import "SnackbarExampleSupplemental.h"

static const CGFloat kFABBottomOffset = 24.0f;
static const CGFloat kFABSideOffset = 24.0f;

@implementation SnackbarOverlayViewExample

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupExampleViews:@[@"Show Snackbar"]];
  self.title = @"Snackbar Overlay View";

  // Make sure we're listening for overlay notifications.
  MDCOverlayObserver *manager = [MDCOverlayObserver observerForScreen:nil];
  [manager addTarget:self action:@selector(handleOverlayTransition:)];

  self.floatingButton = [[MDCFloatingButton alloc] init];
  [self.floatingButton sizeToFit];
  [self.view addSubview:self.floatingButton];

  // Position the FAB.
  CGRect fabFrame = self.floatingButton.frame;
  fabFrame.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(fabFrame) - kFABSideOffset;
  fabFrame.origin.y =
      CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(fabFrame) - kFABBottomOffset;
  self.floatingButton.frame = fabFrame;
  self.floatingButton.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);
}

#pragma mark - Event Handling

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  NSString *text = @"Snackbar Message";
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:text];
  message.duration = 5.0f;
  [MDCSnackbarManager showMessage:message];
  return;
}

#pragma mark - Overlay Transitions

- (void)handleOverlayTransition:(id<MDCOverlayTransitioning>)transition {
  CGRect bounds = self.view.bounds;
  CGRect coveredRect = [transition compositeFrameInView:self.view];

  // Trim the covered rectangle to only consider the current view's bounds.
  CGRect boundedRect = CGRectIntersection(bounds, coveredRect);

  // How much should we shift the FAB up by.
  CGFloat fabVerticalShift = 0;

  if (!CGRectIsEmpty(boundedRect)) {
    // Calculate how far from the bottom of the current view the overlay goes. All we really care
    // about is the absolute top of all overlays, we'll put the FAB above that point.
    CGFloat distanceFromBottom = CGRectGetMaxY(bounds) - CGRectGetMinY(boundedRect);

    // We're applying a transform to the FAB, so no need to account for padding or such.
    fabVerticalShift = distanceFromBottom;
  }

  [transition animateAlongsideTransition:^{
    if (fabVerticalShift > 0) {
      self.floatingButton.transform = CGAffineTransformMakeTranslation(0, -fabVerticalShift);
    } else {
      self.floatingButton.transform = CGAffineTransformIdentity;
    }
  }];
}

@end
