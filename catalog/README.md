# Material Components for iOS Catalog

The Material Components for iOS Catalog collects examples from each component together into a single
app to explore, experiment, and experience.

## Generation

The catalog app is generated dynamically via CocoaPods wildcards inclusion in
[`MaterialComponentsExamples.podspec`](../MaterialComponentsExamples.podspec) The CocoaPods setup
includes:

- The source for each component
- Example sources matching `components/*/examples/*.{h,m,swift}`

At runtime, the app enumerates all linked instances of UIViewController that respond to the
`+catalogBreadcrumbs` class method, which returns an array of strings that define how to navigate
from the catalog's root view controller to that view controller. View controllers are grouped
together in the hierarchy defined by all the bread crumbs.

## Building and running the catalog

In the `catalog` directory,

    pod update
    open MDCCatalog.xcworkspace

Build and run the `MDCCatalog` target.

## Adding a new example

Let's build a hypothetical example for the "Ink" component.

Create a source file (either `.m` or `.swift`) in the component's `examples` directory, for example:

    components/Ink/examples/InkDemoViewController.m

> View controller names must be globally unique across every component's example set. An easy way
> to ensure this is to prefix the controller with the name of the component.

Note that for—simple examples—you likely won't need to create a .h file.

You can now create the view controller class.

```objective-c
#import <UIKit/UIKit.h>

@interface InkDemoViewController : UIViewController
@end

@implementation InkDemoViewController

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Ink", @"README demo" ];
}

@end
```

To add the example to the Catalog app, simply run `pod install` in the `catalog` directory again:

```bash
cd catalog
pod install
```

Build and run to see your example listed in the app's hierarchy.

## Using storyboards

If you want your example to use a storyboard you need the view controller class to specify that
storyboard. You do this by implementing the `CatalogStoryboardViewController` protocol like so:

```objective-c
+ (NSString *)catalogStoryboardName {
  return @"InkAutolayoutExample";
}
```

Place this source file in the component's `examples` directory, like so:

    components/Ink/examples/InkAutolayoutExample.storyboard

> Storyboard names must be globally unique across every component's example set. An easy way
> to ensure this is to prefix the controller with the name of the component.

## Supplemental sources

Examples exist to demonstrate your component both interactively and in source code. Often examples
require supplemental setup code or sample data that isn't relevant to learning how to use your
component. You can store supplemental classes in the `supplemental` folder to keep them out of the
way. For example:

```bash
components/Ink/examples/supplemental/InkSampleData.h
components/Ink/examples/supplemental/InkSampleData.m
```

Use the `supplemental` folder to keep your example code clean and instructive.

- - -

## Useful Links

- [How To Use MDC-iOS](../docs/)
- [All Components](../components/)
- [Demo Apps](../demos/)
- [Contributing](../contributing/)
- [MDC-iOS on Stack Overflow](https://www.stackoverflow.com/questions/tagged/material-components+ios) (external site)
- [Material.io](https://material.io) (external site)
- [Material Design Guidelines](https://material.io/guidelines) (external site)
