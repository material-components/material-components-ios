/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

@class MDCFlexibleHeaderView;
@protocol MDCFlexibleHeaderViewLayoutDelegate;

/**
 The MDCFlexibleHeaderViewController controller is a simple UIViewController-oriented interface
 for the flexible header view.

 Note that for this view controller, self.view == self.headerView. This is because this view
 controller is not meant to take up the full screen. Rather, it should be added as a child view
 controller within another view controller.

 ### UIScrollViewDelegate

 Instances of this view controller implement the UIScrollViewDelegate methods that must be
 forwarded to the flexible header view, so if you do not need to process the scroll view events
 yourself you can set the header view controller instance as your scroll view delegate.

 scrollView.delegate = headerViewController;
 */
@interface MDCFlexibleHeaderViewController
    : UIViewController <UIScrollViewDelegate, UITableViewDelegate>

/** The flexible header view instance that this controller manages. */
@property(nonatomic, strong, nonnull, readonly) MDCFlexibleHeaderView *headerView;

/** The layout delegate will be notified of any changes to the flexible header view's frame. */
@property(nonatomic, weak, nullable) id<MDCFlexibleHeaderViewLayoutDelegate> layoutDelegate;

#pragma mark - Enabling top layout guide adjustment behavior

/**
 This runtime flag affects the way the top layout guide is modified.

 When disabled, the parent view controller is always assumed to be the topLayoutGuideViewController.
 This is considered the "legacy" behavior.

 When enabled, the topLayoutGuideViewController property will always determine which view
 controller's topLayoutGuide is adjusted. If topLayoutGuideViewController is nil and this property
 is enabled, no topLayoutGuide will be adjusted.

 This property will eventually be enabled by default, so we encourage you to start setting an
 explicit topLayoutGuideViewController rather than relying on the implicit legacy behavior.

 By default this is NO. In the future it will be enabled by default and eventually removed.
 */
@property(nonatomic, getter=isTopLayoutGuideAdjustmentEnabled) BOOL topLayoutGuideAdjustmentEnabled;

/**
 The view controller whose topLayoutGuide should be modified to match the flexible header view's
 height.

 If this property is nil, then the parent view controller is assumed to be the top layout guide
 view controller.

 By default, this property is nil.
 */
@property(nonatomic, weak, nullable) UIViewController *topLayoutGuideViewController;

#pragma mark UIViewController methods

/**
 Returns a Boolean indicating whether the status bar should be hidden or not.

 Must be called by the parent view controller's -prefersStatusBarHidden implementation.
 */
- (BOOL)prefersStatusBarHidden;

/**
 Calculates the status bar style based on the header view's background color.

 Light background colors use the default black status bar and dark background colors use the light
 status bar. If the header view's background color is not fully-opaque, then this returns
 UIStatusBarStyleDefault.
 */
- (UIStatusBarStyle)preferredStatusBarStyle;

@end

/**
 An object may conform to this protocol in order to receive layout change events caused by a
 MDCFlexibleHeaderView.
 */
@protocol MDCFlexibleHeaderViewLayoutDelegate <NSObject>
@required

/**
 Informs the receiver that the flexible header view's frame has changed.

 The receiver should use the MDCFlexibleHeader scrollPhase APIs in order to react to the frame
 changes.
 */
- (void)flexibleHeaderViewController:
            (nonnull MDCFlexibleHeaderViewController *)flexibleHeaderViewController
    flexibleHeaderViewFrameDidChange:(nonnull MDCFlexibleHeaderView *)flexibleHeaderView;

@end

@interface MDCFlexibleHeaderViewController (ToBeDeprecated)

/**
 Updates the topLayoutGuide to the correct position of a view controller paired with an instance of
 MDCFlexibleHeaderViewController.

 @warning This API will be deprecated. There is no replacement because the top layout guide should
 update automatically as the flexible header's frame changes.
 */
- (void)updateTopLayoutGuide;

@end
