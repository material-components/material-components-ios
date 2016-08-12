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

/** The content view controller to be displayed behind the header. */
@property(nonatomic, strong, nullable) UIViewController *contentViewController;

@end
