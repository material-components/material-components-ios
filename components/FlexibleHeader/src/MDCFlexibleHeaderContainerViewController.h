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

@class MDCFlexibleHeaderViewController;

/**
 The MDCFlexibleHeaderContainerViewController controller is a straightforward container of a
 content view controller and a MDCFlexibleHeaderViewController.

 This view controller may be used in situations where the content view controller can't have a
 header injected into its view hierarchy. UIPageViewController is one such view controller.
 */
@interface MDCFlexibleHeaderContainerViewController : UIViewController

- (nonnull instancetype)initWithContentViewController:
    (nullable UIViewController *)contentViewController NS_DESIGNATED_INITIALIZER;

/**
 The header view controller that lives alongside the content view controller.

 This view controller's view will be placed in front of the content view controller's view.
 */
@property(nonatomic, strong, nonnull, readonly)
    MDCFlexibleHeaderViewController *headerViewController;

/**
 The content view controller to be displayed behind the header.

 This view controller's layout will be owned and managed by the container view controller. If the
 content view controller has prior layout constraints associated with it, the behavior is undefined.
 */
@property(nonatomic, strong, nullable) UIViewController *contentViewController;

#pragma mark - Enabling top layout guide adjustment behavior

/**
 If enabled, the content view controller's top layout guide will be adjusted as the flexible
 header's height changes and the content view controller view's frame will be set to the container
 view controller's bounds.

 This behavior is disabled by default, but it will be enabled by default in the future. Consider
 enabling this behavior and making use of the topLayoutGuide in your view controller accordingly.

 Example positioning a view using constraints:

     [NSLayoutConstraint constraintWithItem:view
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.topLayoutGuide
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:32]

 Example positioning a view without constraints:

     frame.origin.y = self.topLayoutGuide.length + 32
 */
@property(nonatomic, getter=isTopLayoutGuideAdjustmentEnabled) BOOL topLayoutGuideAdjustmentEnabled;

/**
 A block that is invoked when the @c MDCFlexibleHeaderContainerViewController receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCFlexibleHeaderContainerViewController *_Nonnull flexibleHeaderContainer,
     UITraitCollection *_Nullable previousTraitCollection);

@end
