# SpritedAnimationView example app

This app demonstrates how to create a sprited animation view using the
MDCSpritedAnimationView. 

## Where is the code?

The relevant code may be found in the 'App' directory.

## Code structure

This example shows how one might use a sprited animation view. A tap gesture is added to
the view, and when tapped will start the animation. The control toggles between two
sprite images.

### ViewController

Creates a MDCSpritedAnimationView. A label is added with instructions to tap the view.
Upon tap, the sprited animation view starts its animation, then updates to another sprite
upon completion depending on the checked state.
