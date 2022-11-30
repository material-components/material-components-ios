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

API_DEPRECATED_BEGIN(
    "🕘 Schedule time to migrate. "
    "Use default system highlight behavior instead: go/material-ios-touch-response. "
    "This is go/material-ios-migrations#not-scriptable 🕘",
    ios(12, 12))

@class MDCInkLayer;

/**
 Delegate protocol for the MDCInkLayer. Clients may implement this protocol to receive updates when
 ink layer animations start and end.
 */
@protocol MDCInkLayerDelegate <CALayerDelegate>

@optional

/**
 Called when the ink ripple animation begins.

 @param inkLayer The MDCInkLayer that starts animating.
 */
- (void)inkLayerAnimationDidStart:(nonnull MDCInkLayer *)inkLayer;

/**
 Called when the ink ripple animation ends.

 @param inkLayer The MDCInkLayer that ends animating.
 */
- (void)inkLayerAnimationDidEnd:(nonnull MDCInkLayer *)inkLayer;

@end

API_DEPRECATED_END
