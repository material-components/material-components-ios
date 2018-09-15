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

@class MDCFeatureHighlightViewController;

#import <MDFTextAccessibility/MDFTextAccessibility.h>
#import <UIKit/UIKit.h>

/**
 A Mutator that will change an instance of MDCFeatureHighlightViewController to have a high enough
 contrast text between its background.
 Calling this mutator can overwrite UIApperance values.
 */
@interface MDCFeatureHighlightAccessibilityMutator : NSObject

/**
 This method will change the title and body color of the feature highlight to ensure a high
 accessiblity contrast with its background if needed.
 */
+ (void)mutate:(MDCFeatureHighlightViewController *)featureHighlightViewController;

@end

