# SpritedAnimationView

This control provides performance benefits over animating an array of images with a UIImageView.
Only a single image composed of individual sprite frames is used, and animation simply consists of
updating the layer contentsRect.

## Requirements

Xcode 7.0 or higher.
iOS SDK version 7.0 or higher. 

## Usage

```objectivec
// Create a Sprited Animation View.
UIImage *spriteSheet = [UIImage imageNamed:@"myImage"];
QTMSpritedAnimationView *animationView =
    [[QTMSpritedAnimationView alloc] initWithSpriteSheetImage:spriteSheet];
animationView.tintColor = [UIColor blueColor];
[self.view addSubview:animationView];

// To Animate.
[animationView startAnimatingWithCompletion:^{
    NSLog(@"Done animating.");
}];
```
