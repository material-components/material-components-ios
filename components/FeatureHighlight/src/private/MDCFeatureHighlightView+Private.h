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

#import "MDCFeatureHighlightView.h"

typedef void (^MDCFeatureHighlightInteractionBlock)(BOOL accepted);

@interface MDCFeatureHighlightView ()

@property(nonatomic, readonly) CGPoint highlightCenter;
@property(nonatomic, readonly) CGFloat highlightRadius;

@property(nonatomic, assign) CGPoint highlightPoint;
@property(nonatomic, strong) UIView *displayedView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *bodyLabel;
@property(nonatomic, strong) MDCFeatureHighlightInteractionBlock interactionBlock;

@end

@interface MDCFeatureHighlightView (Private) <UIGestureRecognizerDelegate>

- (void)layoutAppearing;
- (void)layoutDisappearing;
- (void)updateOuterHighlight;

- (void)animateDiscover:(NSTimeInterval)duration;
- (void)animateAccepted:(NSTimeInterval)duration;
- (void)animateRejected:(NSTimeInterval)duration;
- (void)animatePulse;

- (void)updateTitleFont;
- (void)updateBodyFont;

@end
