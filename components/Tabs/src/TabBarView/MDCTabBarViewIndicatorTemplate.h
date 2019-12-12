// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

@class MDCTabBarViewIndicatorAttributes;
@protocol MDCTabBarViewIndicatorContext;

/*
 Template for indicator content which defines how the indicator changes appearance in response to
 changes in its context.

 Template objects are expected to be immutable once set on a tab bar.
 */
@protocol MDCTabBarViewIndicatorTemplate <NSObject>

/**
 Returns an attributes object that describes how the indicator should appear in a given context.
 */
- (nonnull MDCTabBarViewIndicatorAttributes *)indicatorAttributesForContext:
    (nonnull id<MDCTabBarViewIndicatorContext>)context;

@end
