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

@protocol MDCSimpleInkViewDelegate;

/**
 A UIView that draws and animates the Material Design ink effect for touch interactions.
 */
@interface MDCSimpleInkView : UIView

@property(nonatomic, weak) id<MDCSimpleInkViewDelegate> delegate;

/*
 Adds a MDCSimpleInkGestureRecognizer gesture recognizer to ink view so ink will spread on touch
 down and evaporate on touch up.
 */
- (void)addInkGestureRecognizer;

/*
 The starting point where ink will begin its spread animation.
 */
- (void)startInkAtPoint:(CGPoint)point;

/*
 Causes the ink spread animation to evaporate gradually before ending.
 */
- (void)endInk;

/*
 Immediately ends the ink spread animation without an evaporation animation.
 */
- (void)endInkNow;

@end

/**
 Delegate protocol for MDCSimpleInkView. Clients may implement this protocol to receive
 notifications of when ink touch down and touch up events occur.
 */
@protocol MDCSimpleInkViewDelegate <NSObject>

@optional

/**
 Called when the ink touch down event is triggered and ink begins to spread.
 */
- (void)inkView:(MDCSimpleInkView *)inkView didTouchDownAtPoint:(CGPoint)point;

/**
 Called when the ink touch up event is triggered and ink begins to dissipate.
 */
- (void)inkView:(MDCSimpleInkView *)inkView didTouchUpFromPoint:(CGPoint)point;

@end
