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

#import "MaterialOverlay.h"
#import "MaterialSnackbar.h"
#import "SnackbarExampleSupplemental.h"

static const CGFloat kFABBottomOffset = 24.0f;
static const CGFloat kFABSideOffset = 24.0f;
static const CGFloat kBottomBarHeight = 44.0f;

@interface SnackbarOverlayViewExample ()
@property(nonatomic, assign) CGFloat floatingButtonOffset;
@end

@implementation SnackbarOverlayViewExample

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupExampleViews:@[ @"Show Snackbar", @"Toggle bottom bar" ]];
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
  [self.floatingButton setBackgroundColor:[UIColor colorWithRed:11 / 255.0f
                                                          green:232 / 255.0f
                                                           blue:94 / 255.0f
                                                          alpha:1]
                                 forState:UIControlStateNormal];
  self.floatingButton.frame = fabFrame;
  self.floatingButton.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);
  [self.floatingButton addTarget:self
                          action:@selector(didTapFAB:)
                forControlEvents:UIControlEventTouchUpInside];

  self.bottomBar =
      [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds),
                                               CGRectGetWidth(self.view.bounds), kBottomBarHeight)];
  self.bottomBar.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  self.bottomBar.backgroundColor = [UIColor redColor];
  [self.view addSubview:self.bottomBar];
}

#pragma mark - Event Handling

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  if (indexPath.row == 0) {
    [self showSnackbar];
  } else {
    [self toggleBottomBar];
  }
  return;
}

- (void)showSnackbar {
  NSString *text = @"Snackbar Message";
  MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:text];
  message.duration = 5.0f;
  [MDCSnackbarManager showMessage:message];
}

- (void)toggleBottomBar {
  self.isShowingBottomBar = !self.isShowingBottomBar;

  CGFloat bottomOffset = 0;
  CGFloat translation = kBottomBarHeight;

  if (self.isShowingBottomBar) {
    translation = -translation;
    bottomOffset = kBottomBarHeight;
  }

  [UIView animateWithDuration:0.25
                   animations:^{
                     self.bottomBar.center = CGPointMake(self.bottomBar.center.x,
                                                         self.bottomBar.center.y + translation);
                     [MDCSnackbarManager setBottomOffset:bottomOffset];
                   }];
}

- (void)didTapFAB:(id)sender {
  [self.floatingButton collapse:YES
                     completion:^{
                       [self.floatingButton expand:YES completion:nil];
                     }];
}

#pragma mark - Overlay Transitions

- (void)handleOverlayTransition:(id<MDCOverlayTransitioning>)transition {
  CGRect bounds = self.view.bounds;
  CGRect coveredRect = [transition compositeFrameInView:self.view];

  // Trim the covered rectangle to only consider the current view's bounds.
  CGRect boundedRect = CGRectIntersection(bounds, coveredRect);

  // How much should we shift the FAB up by.
  CGFloat fabVerticalShift = 0;
  CGFloat distanceFromBottom = 0;

  if (!CGRectIsEmpty(boundedRect)) {
    // Calculate how far from the bottom of the current view the overlay goes. All we really care
    // about is the absolute top of all overlays, we'll put the FAB above that point.
    distanceFromBottom = CGRectGetMaxY(bounds) - CGRectGetMinY(boundedRect);
  }

  // We're applying a transform to the FAB, so no need to account for padding or such.
  fabVerticalShift = self.floatingButtonOffset - distanceFromBottom;
  self.floatingButtonOffset = distanceFromBottom;

  [transition animateAlongsideTransition:^{
    self.floatingButton.center =
        CGPointMake(self.floatingButton.center.x, self.floatingButton.center.y + fabVerticalShift);
  }];
}

@end
