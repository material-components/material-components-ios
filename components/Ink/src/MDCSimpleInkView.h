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

/** Completion block signature. */
typedef void (^MDCSimpleInkCompletionBlock)(void);

@protocol MDCSimpleInkViewDelegate;

/**
 A UIView that draws and animates the Material Design ink effect for touch interactions.
 */
@interface MDCSimpleInkView : UIView

/**
 The ink view delegate.
 */
@property(nonatomic, weak, nullable) IBOutlet id<MDCSimpleInkViewDelegate> delegate;

/**
 Completion block fired when ink animation ends after touch up.
 */
@property(nonatomic, copy, nullable) MDCSimpleInkCompletionBlock completionBlock;

/**
 Color of the ink ripple.
 Default color is black with alpha of 0.08.
 */
@property(nonatomic, strong, null_resettable) UIColor *inkColor UI_APPEARANCE_SELECTOR;

/*
 Adds a MDCSimpleInkGestureRecognizer gesture recognizer to ink view so ink will spread on touch
 down and evaporate on touch up.
 */
- (void)addInkGestureRecognizer;

/*
 The starting point where ink will begin its spread animation. Completion block is called when the
 ink animation ends after |endInkAnimated| is called.
 */
- (void)startInkAtPoint:(CGPoint)point
             completion:(nullable MDCSimpleInkCompletionBlock)completionBlock;

/*
 Ends the ink spread.
 */
- (void)endInkAnimated:(BOOL)animated;

@end

/**
 Delegate protocol for MDCSimpleInkView. Implement protocol to respond to ink touch down and touch
 up events.
 */
@protocol MDCSimpleInkViewDelegate <NSObject>

@optional

/**
 Called when the ink touch down event is triggered and ink begins to spread.
 */
- (void)inkView:(nonnull MDCSimpleInkView *)inkView didTouchDownAtPoint:(CGPoint)point;

/**
 Called when the ink touch up event is triggered and ink begins to dissipate.
 */
- (void)inkView:(nonnull MDCSimpleInkView *)inkView didTouchUpAtPoint:(CGPoint)point;

@end
