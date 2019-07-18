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
 This protocol is used by @c UIViews that want to provide their elevation and wish to react to
 elevation changes occuring in their view hierarchy.
 */
@protocol MDCElevation <NSObject>

/**
 The current elevation of the conforming @c UIView reciever.

 The elevation for the current state of the receiver.
 */
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;

@end
