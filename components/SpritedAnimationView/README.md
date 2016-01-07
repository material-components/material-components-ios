# SpritedAnimationView

This control provides an alternative to animating an array of images with an `UIImageView`. Only a
single image composed of individual sprite frames is used, and animation simply consists of
updating the layer `contentsRect`.

## Requirements

- Xcode 7.0 or higher
- iOS SDK version 7.0 or higher

## Create a sprite sheet asset

A sprite sheet consists of a single image composed of a single column of individual sprite frames.
The individual sprite frames must be sized and spaced evenly across the overall image bounds. A
typical use case is to generate three sprite sheet images (1x, 2x, and 3x) and add these to an
`.xcassets` file for use in the app by the `spritedAnimationView`.

## Animating the sprite sheet

Once a sprite sheet is added to a `spritedAnimationView` (either at `init` or adding later), the
`spritedAnimationView` can animate the image from the first sprite frame to the last sprite frame.
Properties are available to set the frame rate, which defaults to 60 fps (frames per second). The
animation can happen once or be looped via the `animationRepeatCount` property. To start the
animation, use the `-startAnimationWithCompletion:` method. A completion block gets called once
the animation is finished. However, if the `animationRepeatCount` is set to loop infinitely (with
a 0 setting), this block will not get called. Additional methods are provided to reset the
`spritedAnimationView` to the beginning or end without animation.

## Achieving two-state animation

It is enough to provide a single sprite sheet, animate the image, and simply reset to the beginning
once finished. However, in some cases, a nice user experience can be achieved by providing two
separate sprite sheets. One showing an animation from state A to state B, then another sprite sheet
showing state B going back to state A. This way, the sprite sheet can be swapped out after the
animation completes for each state, and be replaced with the other sprite image.

#### Two sample sprite sheets (showing Hide and Show states)

| Checkmark Sprite Sheet (Hide) | Checkmark Sprite Sheet (Show) |
| :---------------------------: | :---------------------------: |
| ![Checkmark Hide](examples/SpritedAnimationViewExample/Assets.xcassets/mdc_sprite_check__hide.imageset/mdc_sprite_check__hide.png) | ![Checkmark Show](examples/SpritedAnimationViewExample/Assets.xcassets/mdc_sprite_check__show.imageset/mdc_sprite_check__show.png) |

#### Two-state example

```objectivec
// Animate the sprited view.
[_animationView startAnimatingWithCompletion:^{

  // When animation completes, toggle image.
  _checked = !_checked;
  UIImage *spriteImage =
      [UIImage imageNamed:_checked ? kSpriteCheckedImage : kSpriteUncheckedImage];
  _animationView.spriteSheetImage = spriteImage;
}];
```

## Usage

Integrating the `spritedAnimationView` is somewhat similar to adding an `UIImageView` to a view.

```objectivec
#import "MaterialSpritedAnimationView.h"

// Create a Sprited Animation View.
UIImage *spriteSheet = [UIImage imageNamed:@"myImage"];
MDCSpritedAnimationView *animationView =
    [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteSheet];
animationView.tintColor = [UIColor blueColor];
[self.view addSubview:animationView];

// To Animate.
[animationView startAnimatingWithCompletion:^{
    NSLog(@"Done animating.");
}];
```
