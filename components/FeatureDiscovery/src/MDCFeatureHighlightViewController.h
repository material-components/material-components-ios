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

/**
 Called when the feature highlight is dismissed either by calling |acceptFeature| or
 |rejectFeature| on the feature highlight or the user accepts or rejects the highlight by tapping
 somewhere on the highlight view.

 @param accepted Whether the highlight was accepted or rejected
 */
typedef id (^MDCFeatureHighlightCompletion)(BOOL accepted);

/**
 MDCFeatureHighlightViewController highlights an element of a UI to introduce features or
 functionality that a user hasn’t tried.

 https://material.googleplex.com/growth-communications/feature-discovery.html

 MDCFeatureHighlightViewController should be presented modally and dismissed using either
 |acceptFeature| or |rejectFeature|.

 While MDCFeatureHighlightViewController supports changing state while presented, it is not
 recommended as the design spec does not specify any patterns for that behavior.
 */
@interface MDCFeatureHighlightViewController : UIViewController

/**
 Initializes the controller.

 @param highlightedView The highlight will be presented above the |center| of |highlightedView|
 @param displayedView Added to the highlight view and centered at the |center| of |highlightedView|
 @param completion The completion block called when the highlight is dismissed
 */
- (nullable instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                     andShowView:(nonnull UIView *)displayedView
                                      completion:(nullable MDCFeatureHighlightCompletion)completion
    NS_DESIGNATED_INITIALIZER;

/**
 Initializes the controller.

 This is a convience method for |initWithHighlightedView:andShowView:| with a snapshot of
 |highlightedView| sent as |displayedView|.

 @param highlightedView The highlight will be presented above the |center| of |highlightedView|
 */
- (nullable instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                      completion:(nullable MDCFeatureHighlightCompletion)completion
    NS_DESIGNATED_INITIALIZER;

/**
 Sets the text to be displayed as the header of the help text.

 The header is displayed above the body text.
 */
@property(nonatomic, copy, nullable) NSString *titleText;

/**
 Sets the text to be displayed as the body of the help text.

 The body is displayed below the header text. If you are only showing a single block of text without
 any header/body distinction, prefer |titleText|.
 */
@property(nonatomic, copy, nullable) NSString *bodyText;

/**
 Sets the color to be used for the outer highlight. If unset, returns |tintColor|.
 */
@property(nonatomic, strong, null_resettable) UIColor *outerHighlightColor;

/**
 Sets the color to be used for the inner highlight. Defaults to white.
 */
@property(nonatomic, strong, null_resettable) UIColor *innerHighlightColor;

/**
 Dismisses the feature highlight using the 'accept' style dismissal animation and triggers the
 completion block with accepted set to YES.

 Identical to the user tapping on the inner highlight.
 */
- (void)acceptFeature;

/**
 Dismisses the feature highlight using the 'reject' style dismissal animation and triggers the
 completion block with accepted set to NO.

 Identical to the user tapping outside of the inner highlight.
 */
- (void)rejectFeature;

@end
