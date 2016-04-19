/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MaterialFlexibleHeader.h"

#import "FlexibleHeaderConfiguratorSupplemental.h"

@interface FlexibleHeaderConfiguratorExample () <MDCFlexibleHeaderViewLayoutDelegate>
@property(nonatomic) BOOL overrideStatusBarHidden;
@end

@implementation FlexibleHeaderConfiguratorExample

// Invoked when the user has changed a control's value.
- (void)field:(FlexibleHeaderConfiguratorField)field didChangeValue:(NSNumber *)value {
  MDCFlexibleHeaderView *headerView = self.fhvc.headerView;
  switch (field) {
    // Basic behavior

    case FlexibleHeaderConfiguratorFieldCanOverExtend:
      headerView.canOverExtend = [value boolValue];
      break;

    case FlexibleHeaderConfiguratorFieldInFrontOfInfiniteContent:
      headerView.inFrontOfInfiniteContent = [value boolValue];
      break;

    case FlexibleHeaderConfiguratorFieldHideStatusBar: {
      self.overrideStatusBarHidden = [value boolValue];
      [UIView animateWithDuration:0.4
                       animations:^{
                         [self setNeedsStatusBarAppearanceUpdate];
                       }];
      break;
    }

    // Shift behavior

    case FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled: {
      BOOL isOn = [value boolValue];
      if (!isOn) {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorDisabled;
        [self didChangeValueForField:FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar
                            animated:YES];
      } else {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
      }
      break;
    }

    case FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar: {
      BOOL isOn = [value boolValue];
      if (!isOn) {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
      } else {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;
        [self didChangeValueForField:FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled
                            animated:YES];
      }
      break;
    }

    case FlexibleHeaderConfiguratorFieldContentImportance:
      headerView.headerContentImportance = ([value boolValue]
                                                ? MDCFlexibleHeaderContentImportanceHigh
                                                : MDCFlexibleHeaderContentImportanceDefault);
      break;

    // Header height

    case FlexibleHeaderConfiguratorFieldMinimumHeight:
      headerView.minimumHeight = [self heightDenormalized:[value floatValue]];
      break;

    case FlexibleHeaderConfiguratorFieldMaximumHeight:
      headerView.maximumHeight = [self heightDenormalized:[value floatValue]];
      break;
  }
}

#pragma mark - Typical Flexible Header implementations

// Required for shiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar.
- (BOOL)prefersStatusBarHidden {
  return _overrideStatusBarHidden || self.fhvc.prefersStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
  return UIStatusBarAnimationSlide;
}

#pragma mark - UIScrollViewDelegate

// Note that, unlike the Typical Use example, we are explicitly forwarding the UIScrollViewDelegate
// methods to the header view. This is because this example controller also needs to handle other
// UITableViewDelegate events.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  MDCFlexibleHeaderView *headerView = self.fhvc.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  MDCFlexibleHeaderView *headerView = self.fhvc.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                          targetContentOffset:targetContentOffset];
  }
}

#pragma mark - MDCFlexibleHeaderViewLayoutDelegate

- (void)flexibleHeaderViewController:(nonnull MDCFlexibleHeaderViewController *)flexibleHeaderViewController
    flexibleHeaderViewFrameDidChange:(nonnull MDCFlexibleHeaderView *)flexibleHeaderView {
  CGFloat headerContentAlpha;
  switch (flexibleHeaderView.scrollPhase) {
    case MDCFlexibleHeaderScrollPhaseCollapsing:
    case MDCFlexibleHeaderScrollPhaseOverExtending:
      headerContentAlpha = 1;
      break;
    case MDCFlexibleHeaderScrollPhaseShifting:
      headerContentAlpha = 1 - flexibleHeaderView.scrollPhasePercentage;
      break;
  }
  for (UIView *subview in self.fhvc.headerView.subviews) {
    subview.alpha = headerContentAlpha;
  }
}

#pragma mark - Field data manipulation

static const CGFloat kHeightScalar = 300;

- (CGFloat)normalizedHeight:(CGFloat)height {
  return (height - self.minimumHeaderHeight) / (kHeightScalar - self.minimumHeaderHeight);
}

- (CGFloat)heightDenormalized:(CGFloat)normalized {
  return normalized * (kHeightScalar - self.minimumHeaderHeight) + self.minimumHeaderHeight;
}

- (NSNumber *)valueForField:(FlexibleHeaderConfiguratorField)field {
  switch (field) {
    case FlexibleHeaderConfiguratorFieldCanOverExtend:
      return @(self.fhvc.headerView.canOverExtend);

    case FlexibleHeaderConfiguratorFieldContentImportance:
      return @((self.fhvc.headerView.headerContentImportance == MDCFlexibleHeaderContentImportanceHigh));

    case FlexibleHeaderConfiguratorFieldHideStatusBar:
      return @(self.overrideStatusBarHidden);

    case FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled: {
      MDCFlexibleHeaderShiftBehavior behavior = self.fhvc.headerView.shiftBehavior;
      BOOL enabled = (behavior == MDCFlexibleHeaderShiftBehaviorEnabled || behavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar);
      return @(enabled);
    }

    case FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar: {
      MDCFlexibleHeaderShiftBehavior behavior = self.fhvc.headerView.shiftBehavior;
      BOOL enabled = (behavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar);
      return @(enabled);
    }

    case FlexibleHeaderConfiguratorFieldInFrontOfInfiniteContent:
      return @(self.fhvc.headerView.inFrontOfInfiniteContent);

    case FlexibleHeaderConfiguratorFieldMinimumHeight:
      return @([self normalizedHeight:self.fhvc.headerView.minimumHeight]);

    case FlexibleHeaderConfiguratorFieldMaximumHeight:
      return @([self normalizedHeight:self.fhvc.headerView.maximumHeight]);
  }
}

@end
