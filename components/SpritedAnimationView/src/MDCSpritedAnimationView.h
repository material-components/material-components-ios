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

#import <AvailabilityMacros.h>
#import <UIKit/UIKit.h>

/**
 Animation view for loading in sprites.

 This control provides an alternative to animating an array of images with a UIImageView. Only
 a single image composed of individual sprite frames is used, and animation simply consists of
 updating the layer contentsRect.
 */
DEPRECATED_MSG_ATTRIBUTE("Use https://github.com/material-foundation/material-sprited-animation-view-ios instead.")
@interface MDCSpritedAnimationView : UIView

/**
 Optional tint color of the icon.

 If set to non-nil, the sprite sheet will be treated as an alpha mask and the color will be
 applied.
 */
@property(nonatomic, strong, nullable) UIColor *tintColor;

/**
 An image composed of a single column of individual sprite frames.

 Each sprite frame is assumed to be square.
 */
@property(nonatomic, strong, nullable) UIImage *spriteSheetImage;

/**
 Framerate of the sprite playback in number of frames per second.

 Default is 60 frames per second.
 */
@property(nonatomic, assign) NSInteger frameRate;

/**
 Number of times to repeat the animation.

 Setting to 0 means infinite. Default is 1.
 */
@property(nonatomic, assign) NSInteger animationRepeatCount;

/**
 Returns whether the animation is playing.

 @return YES if the the sprite animation is playing.
 */
@property(nonatomic, readonly, getter=isAnimating) BOOL animating;

/**
 Creates an animated sprite view.

 Designated initializer.

 @param spriteSheetImage A vertical sprite sheet of square images.
 @return Initialized sprited animation view.
 */
- (nonnull instancetype)initWithSpriteSheetImage:(nullable UIImage *)spriteSheetImage
    NS_DESIGNATED_INITIALIZER;

/**
 Creates an animated sprite view. Use this initializer if your images are non-square.

 @param spriteSheetImage A vertical sprite sheet of images.
 @param numberOfFrames The number of frames in the sprite sheet image. Used for calculating
      the size of each frame.
 @return Initialized sprited animation view.
 */
- (nonnull instancetype)initWithSpriteSheetImage:(nullable UIImage *)spriteSheetImage
                                  numberOfFrames:(NSInteger)numberOfFrames;

/** Please use initWithSpriteSheetImage:. */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 Start the animation.

 Does nothing if the animation is already playing.

 @param completion Block called when transition completes.
 */
- (void)startAnimatingWithCompletion:(nullable void (^)(BOOL finished))completion;

/** Stop the animation. */
- (void)stop;

/** Reset playing state to the first frame. */
- (void)seekToBeginning;

/** Reset playing state to the last frame. */
- (void)seekToEnd;

@end
