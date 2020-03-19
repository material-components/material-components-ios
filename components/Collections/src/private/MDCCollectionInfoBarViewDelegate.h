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

@class MDCCollectionInfoBarView;

@protocol MDCCollectionInfoBarViewDelegate <NSObject>
@required
/**
 Allows the receiver to update the info bar after it has been created.

 @param infoBar The MDCCollectionInfoBarView info bar.
 */
- (void)updateControllerWithInfoBar:(nonnull MDCCollectionInfoBarView *)infoBar;

@optional
/**
 Allows the receiver to get notifed when a tap gesture has been performed on the info bar.

 @param infoBar The MDCCollectionInfoBarView info bar.
 */
- (void)didTapInfoBar:(nonnull MDCCollectionInfoBarView *)infoBar;

/**
 Allows the receiver to get notifed when an info bar will show.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition will be animated; otherwise, NO.
 @param willAutoDismiss YES the info bar will be auto-dismissed after the time interval
        set in @c autoDismissAfterDuration.
 */
- (void)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar
    willShowAnimated:(BOOL)animated
     willAutoDismiss:(BOOL)willAutoDismiss;

/**
 Allows the receiver to get notifed after an info bar did show.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition was animated; otherwise, NO.
 @param willAutoDismiss YES the info bar will be auto-dismissed after the time interval
        set in @c autoDismissAfterDuration.
 */
- (void)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar
    didShowAnimated:(BOOL)animated
    willAutoDismiss:(BOOL)willAutoDismiss;

/**
 Allows the receiver to get notifed when an info bar will dismiss.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition will be animated; otherwise, NO.
 @param willAutoDismiss YES the info bar will be auto-dismissed after the time interval
        set in @c autoDismissAfterDuration.
 */
- (void)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar
    willDismissAnimated:(BOOL)animated
        willAutoDismiss:(BOOL)willAutoDismiss;

/**
 Allows the receiver to get notifed after an info bar has been dismissed.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition was animated; otherwise, NO.
 @param didAutoDismiss YES the info bar was auto-dismissed.
 */
- (void)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar
    didDismissAnimated:(BOOL)animated
        didAutoDismiss:(BOOL)didAutoDismiss;

@end
