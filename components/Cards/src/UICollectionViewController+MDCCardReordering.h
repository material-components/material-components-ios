// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

@interface UICollectionViewController (MDCCardReordering) <UIGestureRecognizerDelegate>

/**
 This method should be called when using a UICollectionViewController and want to have
 the reorder or drag and drop visuals. Please see
 https://developer.apple.com/documentation/uikit/uicollectionviewcontroller/1623979-installsstandardgestureforintera
 for more information. It will make sure that the underlying longPressGestureRecognizer
 doesn't cancel the ink tap visual causing the ink to disappear once the reorder begins.
 */
- (void)mdc_setupCardReordering;

@end
