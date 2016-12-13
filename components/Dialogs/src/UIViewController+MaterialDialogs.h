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

#if !defined(__IPHONE_8_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0)
#error "This component only supports iOS 8.0 and above."
#endif

@class MDCDialogPresentationController;

/**
 Material Dialog UIViewController Category
 */
@interface UIViewController (MaterialDialogs)

/**
 The Material dialog presentation controller that is managing the current view controller.

 @return nil if the view controller is not managed by a Material dialog presentaiton controller.
 */
@property(nonatomic, readonly) MDCDialogPresentationController *mdc_dialogPresentationController;

@end
