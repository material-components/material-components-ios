/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

/**
 A UIPresentationController for presenting a modal view controller as a bottom sheet.
 
 @note MDCBottomSheetPresentationController can dismiss the presented view controller if the user
 taps outside the bottom sheet or pulls it offscreen.
 */
@interface MDCBottomSheetPresentationController : UIPresentationController

/**
 Controls the height that the sheet should be when it appears. If NO, it defaults to half the height
 of the screen. If YES, and the @c -preferredContentSize is non-zero on the content view controller,
 it defaults to the preferredContentSize.

 @note The height used will never be any taller than the screen of the device.
 The default value is NO.
 */
@property(nonatomic) BOOL usePreferredHeight;

@end
