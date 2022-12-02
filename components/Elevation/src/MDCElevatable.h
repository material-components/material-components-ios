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

API_DEPRECATED_BEGIN("🤖👀 Use colors with dynamic providers that handle elevation instead. "
                     "See go/material-ios-color/gm2-migration and "
                     "go/material-ios-elevation/gm2-migration for more info. "
                     "This has go/material-ios-migrations#scriptable-potential 🤖👀.",
                     ios(12, 12))

/**
 Provides APIs for @c UIViews to communicate their elevation throughout the view hierarchy.
 */
@protocol MDCElevatable <NSObject>

/**
 The current elevation of the conforming @c UIView.
 */
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;

/**
 This block is called when the elevation changes for the conforming @c UIView or @c UIViewController
 receiver or one of its direct ancestors in the view hierarchy.

 Use this block to respond to elevation changes in the view or its ancestor views.

 @param absoluteElevation The @c mdc_currentElevation plus the @c mdc_currentElevation of all
 ancestor views. This equates to @c mdc_absoluteElevation of the UIView+MaterialElevationResponding
 category.
 @param object The receiver (self) which conforms to the protocol.
 */
@property(nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)
    (id<MDCElevatable> _Nonnull object, CGFloat absoluteElevation);

@end

API_DEPRECATED_END
