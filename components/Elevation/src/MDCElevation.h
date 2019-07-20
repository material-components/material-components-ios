// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

/**
 Provides APIs for @c UIViews to communicate their elevation throughout the view hierarchy.
 */
@protocol MDCElevation <NSObject>

/**
 The current elevation of the conforming @c UIView.
 */
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;

/**
 This block is called when the elevation changes for the conforming @c UIView or @c UIViewController
 reciever or one of its direct ancestors in the view hierarchy.

 Use this block to respond to elevation changes in the view or its ancestor views.

 @param elevation The @c mdc_currentElevation plus the @c mdc_currentElevation of all ancestor
 views.
 */
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);

@optional

/**
 When available, used by @c MaterialElevationResponding instead of @c mdc_baseElevation.

 This can be used in cases where there is elevation behind an object that is not part of the
 view hierarchy, like a @c UIPresentationController.
 */
@property(nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;

@end
