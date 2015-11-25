# SpritedAnimationView

This control provides an alternative to animating an array of images with a UIImageView. Only
a single image composed of individual sprite frames is used, and animation simply consists of
updating the layer contentsRect.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher. 

## Usage

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
