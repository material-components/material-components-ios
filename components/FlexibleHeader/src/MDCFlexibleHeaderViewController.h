// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

@class MDCFlexibleHeaderView;
@protocol MDCFlexibleHeaderViewLayoutDelegate;
@protocol MDCFlexibleHeaderSafeAreaDelegate;

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

/**
 A block that is invoked when the @c MDCFlexibleHeaderViewController receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCFlexibleHeaderViewController *_Nonnull flexibleHeaderViewController,
     UITraitCollection *_Nullable previousTraitCollection);

/** The layout delegate will be notified of any changes to the flexible header view's frame. */
@property(nonatomic, weak, nullable) id<MDCFlexibleHeaderViewLayoutDelegate> layoutDelegate;

/** The safe area delegate can be queried for the correct way to calculate safe areas. */
@property(nonatomic, weak, nullable) id<MDCFlexibleHeaderSafeAreaDelegate> safeAreaDelegate;

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

/**
 Whether the view controller should attempt to extract safe area insets from the view controller
 hierarchy or not.

 When this property is enabled, the flexible header will infer the top safe area inset for the
 flexible header view based on the header view controller's root ancestor view controller.

 When this property is disabled, the flexible header will infer the top safe area inset using the
 device's inferred top safe area insets. This assumes that the flexible header consumes the entire
 screen. If this is not the case, such as in a popover or an iPad modal sheet, consider enabling
 this property.

 This behavior will eventually be enabled by default.

 Default is NO.

 @note If both topLayoutGuideAdjustmentEnabled and this property are enabled, you must take care
 that your topLayoutGuideViewController has at least one ancestor view controller (i.e. it can't be
 the root view controller), otherwise an assertion will be thrown. This is most commonly addressed
 by placing the view controller in a UINavigationController, but it can also be achieved by making a
 simple container view controller or by using MDCFlexibleHeaderContainerViewController. This
 assertion ensures that the value extracted from the ancestor doesn't increase the
 topLayoutGuideViewController's top layout guide, which would then be included in the
 next read of the ancestor's safe area inset, compounding the safe area inset and increasing the
 header height infinitely.

 If your app only supports iOS 11+, you can instead set
 permitInferringTopSafeAreaFromTopLayoutGuideViewController to YES.
 */
@property(nonatomic) BOOL inferTopSafeAreaInsetFromViewController;

/**
 This runtime flag affects the way the top safe area is calculated.

 When disabled, if both inferTopSafeAreaInsetFromViewController and topLayoutGuideAdjustmentEnabled
 are set to YES, and the view controller selected to extract the safe area inset from (either
 automatically or via the delegate) is the same as topLayoutGuideViewController, the app will
 crash.

 When enabled, the app will not crash in the situation described above. This is only supported on
 iOS 11+.

 Enable this property before setting inferTopSafeAreaInsetFromViewController or
 topLayoutGuideViewController.

 By default this is NO. In the future it will be enabled by default and eventually removed.
 */
@property(nonatomic)
    BOOL permitInferringTopSafeAreaFromTopLayoutGuideViewController NS_AVAILABLE_IOS(11.0);

/**
 When a WKWebView's scroll view is the tracking scroll view, this behavioral flag affects whether
 the flexible header uses additionalSafeAreaInsets or contentInset to adjust the tracking scroll
 view's content.

 Enabling this behavioral flag will fix a bug with small WKWebView content where the contentSize
 would be improperly set, allowing the content to be scrolled when it shouldn't be.

 This behavior will eventually be enabled by default.

 Default is NO.

 @note If you enable this flag you must also set a topLayoutGuideViewController. Failure to do so
 will result in a runtime assertion failure.

 @note If you support devices running an OS older than iOS 11 and you've enabled this flag, you
 must also adjust the frame of your WKWebView to be positioned below the header using the
 topLayoutGuide, like so:

@code
 [NSLayoutConstraint constraintWithItem:webView
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                                 toItem:self.topLayoutGuide
                              attribute:NSLayoutAttributeBottom
                             multiplier:1.0
                               constant:0]
@endcode
 */
@property(nonatomic) BOOL useAdditionalSafeAreaInsetsForWebKitScrollViews;

#pragma mark UIViewController methods

/**
 Returns a Boolean indicating whether the status bar should be hidden or not.

 Must be called by the parent view controller's -prefersStatusBarHidden implementation.
 */
- (BOOL)prefersStatusBarHidden;

/**
 The status bar style that should be used for this view controller.

 If the header view controller has been added as a child view controller then you will need to
 assign the header view controller to the parent's childViewControllerForStatusBarStyle property
 in order for preferredStatusBarStyle to have any effect.

 See inferPreferredStatusBarStyle for more details about how this property's setter and getter
 should be interpreted.
 */
@property(nonatomic) UIStatusBarStyle preferredStatusBarStyle;

/**
 Whether to calculate the preferredStatusBarStyle based on the view's background color.

 If enabled, preferredStatusBarStyle will automatically return a status bar style that meets
 accessibility contrast ratio guidelines. Light background colors use the default black status bar
 and dark background colors use the light status bar. If the header view's background color is not
 fully-opaque, then preferredStatusBarStyle will return UIStatusBarStyleDefault. Attempting to set
 a value when this property is enabled will result in an assertion.

 If disabled, preferredStatusBarStyle will act as a standard property - the value that you set will
 be the value that is returned.

 Default is YES.
 */
@property(nonatomic) BOOL inferPreferredStatusBarStyle;

@end

/**
 This delegate makes it possible to customize which ancestor view controller is used when
 inferTopSafeAreaInsetFromViewController is enabled on MDCFlexibleHeaderViewController.
 */
@protocol MDCFlexibleHeaderSafeAreaDelegate
- (UIViewController *_Nullable)flexibleHeaderViewControllerTopSafeAreaInsetViewController:
    (nonnull MDCFlexibleHeaderViewController *)flexibleHeaderViewController;
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
