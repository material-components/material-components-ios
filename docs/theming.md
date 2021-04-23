<!--docs:
title: "Theming"
layout: detail
section: components
excerpt: "Material Theming refers to the customization of your Material Design app to better reflect your product’s brand."
path: /catalog/theming/
-->

# Theming

Material Theming refers to the customization of your Material Design app to better reflect your product’s brand.

## Theming extensions

### Terminology

Our approach to theming relies on the relationships between the following concepts:

1. Components
2. The Container Scheme
3. Theming Extensions

Components are expected to provide public APIs for a variety of parameters. An example of a component is [MDCButton](https://github.com/material-components/material-components-ios/tree/develop/components/Buttons).

The Container scheme represents configurable theming data that can be applied to components via theming extensions. A container scheme consists of one scheme for each of the Material Theming subsystem schemes, including: color, shape, and typography.

Theming extensions are component extensions that, when invoked with a default container scheme, will theme a component according to the [Material Design guidelines](https://material.io/design). The extension will map each subsystem scheme's values to the component’s parameters.

### Sensible defaults, yet highly configurable

By default, components have reasonable defaults for all of their customizable properties, e.g.
`backgroundColor` or `titleFont`. Theming extensions are the recommended way to express your brand
through Material Theming.

### How to get the code

#### Cocoapods

In order to use the components and subsystem schemes you'll need to add both the component and its
related Theming extension as a dependency. Theming extensions, when available, always have a suffix
of `+Theming`. For example, to add Buttons and its Theming extension:

<!--<div class="material-code-render" markdown="1">-->

```bash
pod 'MaterialComponents/Buttons'
pod 'MaterialComponents/Buttons+Theming'
```
<!--</div>-->

### Schemes

<ul class="icon-list">
<li class="icon-list-item icon-list-item--link"><a href="../components/schemes/Container/">Container scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="../components/schemes/Color/">Color scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="../components/schemes/Shape/">Shape scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="../components/schemes/Typography/">Typography scheme</a></li>
</ul>

## Examples

### How to theme a component with a container scheme

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

let containerScheme = MDCContainerScheme()
let button = MDCButton()
button.applyTextTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponents/MaterialButtons+Theming.h>

MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
MDCButton *button = [[MDCButton alloc] init];
[button applyTextThemeWithScheme:containerScheme];
```
<!--</div>-->

### How to customize a container scheme

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialContainerScheme

let containerScheme = MDCContainerScheme()

// You can directly configure scheme properties:
containerScheme.colorScheme.primaryColor = .red

// Or assign a customized scheme instance:
let shapeScheme = MDCShapeScheme()
containerScheme.shapeScheme = shapeScheme
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialContainerScheme.h>

MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

// You can directly configure scheme properties
containerScheme.colorScheme.primaryColor = UIColor.redColor;

// Or assign a customized scheme instance:
MDCShapeScheme *shapeScheme = [[MDCShapeScheme alloc] init];
containerScheme.shapeScheme = shapeScheme
```
<!--</div>-->

### Recommended theming patterns

The simplest solution to adopting container schemes and theming extensions is to create a singleton
container scheme instance that is accessible throughout your app.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
func globalContainerScheme() -> MDCContainerScheming {
  let containerScheme = MDCContainerScheme()
  // Customize containerScheme here...
  return containerScheme
}

// You can now access your global theme throughout your app:
let containerScheme = globalContainerScheme()
```

#### Objective-C

```objc
id<MDCContainerScheming> GlobalContainerScheme();
  
id<MDCContainerScheming> GlobalContainerScheme() {
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  // Customize containerScheme here...
  return containerScheme;
}

// You can now access your global theme throughout your app:
id<MDCContainerScheming> containerScheme = GlobalContainerScheme();
```
<!--</div>-->

If you need to support different themes in different contexts then we recommend a
[dependency injection-based](https://en.wikipedia.org/wiki/Dependency_injection) approach. In short
form: each view controller is provided the container scheme it should theme itself with.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
extension MyViewController {
  func applyTheme(with containerScheme: MDCContainerScheming) {
    // Apply the theme where applicable.
  }
}
```

#### Objective-C

```objc
@interface MyViewController (Theming)

- (void)applyThemeWithContainerScheme:(id<MDCContainerScheming>)containerScheme {
  // Apply the theme where applicable.
}
```
<!--</div>-->

## Migration guide: themers to theming extensions

This migration guide covers the typical migration path from Themer usage to Theming extensions.
Themers will eventually be deprecated and deleted. Theming extensions are the recommended
replacement.

Theming extensions are discussed in detail above. For [more information about Themers](#themers)
see the section below.

In general, every component's `Themer` targets will gradually be replaced by a single `Theming`
extension target. This includes:

- ColorThemer
- FontThemer
- ShapeThemer
- TypographyThemer
- Component Themers (e.g. CardThemer)

Some components do not have a Theming extension yet. We are prioritizing the remaining Theming
extensions through
[bug #7172](https://github.com/material-components/material-components-ios/issues/7172).

### Typical migration

When migrating from Themers to a Theming extension the first thing to understand is that a Theming
extension will apply *all* of the Material Theming subsystems (Color, Typography, Shape) to a given
component. If you were previously relying on the ability to apply only one subsystem (e.g. Color)
to a component, please file a
[feature request](https://github.com/material-components/material-components-ios/issues/new/choose)
with a code snippet of your existing use case.

The migration from a subsystem Themer to a Theming extension will involve the following steps:

1. Update your dependencies.
2. Update your imports.
3. Make changes to your code.

#### Update your dependencies

When a component has a theming extension it will always be available as a `Theming` target
alongside the component. For example:

In CocoaPods:

```ruby
// Old
pod 'MaterialComponents/TextFields'
pod 'MaterialComponents/TextFields+ColorThemer'

// New
pod 'MaterialComponents/TextFields'
pod 'MaterialComponents/TextFields+Theming'
```

In Bazel:

```ruby
// Old
  deps = [
      "//components/schemes/TextFields",
      "//components/schemes/TextFields:ColorThemer",
  ],

// New
  deps = [
      "//components/schemes/TextFields",
      "//components/schemes/TextFields:Theming",
  ],
```

#### Update your imports

Replace any Themer import with the component's Theming import:

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Old
import MaterialComponents.MaterialTextFields_ColorThemer

// New
import MaterialComponents.MaterialTextFields_Theming
```

#### Objective-C

```objc
// Old
#import <MaterialComponents/MaterialTextFields+ColorThemer.h>

// New
#import <MaterialComponents/MaterialTextFields+Theming.h>
```
<!--</div>-->

#### Make changes to your code

Replace any Themer code with the equivalent use of a component's Theming extension. Each Themer's
equivalent Theming extension is described in the Themer's header documentation.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Old
let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
MDCFilledTextFieldColorThemer.applySemanticColorScheme(colorScheme, to: textField)

// New
let scheme = MDCContainerScheme()
textField.applyTheme(withScheme: scheme)
```

#### Objective-C

```objc
// Old
MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
[MDCFilledTextFieldColorThemer applySemanticColorScheme:colorScheme
                            toTextInputControllerFilled:textFields];

// New
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
[textField applyThemeWithScheme:containerScheme];
```
<!--</div>-->

If you made customizations to one of the subsystem schemes, you can now customize the container
scheme's subsystem instances instead. If you are using a shared container scheme throughout your app
then you'll likely only need to make these customizations once.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Old
let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
colorScheme.primaryColor = .red

// New
let scheme = MDCContainerScheme()
scheme.colorScheme.primaryColor = .red
```

#### Objective-C

```objc
// Old
MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
colorScheme.primaryColor = UIColor.redColor;

// New
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
containerScheme.colorScheme.primaryColor = UIColor.redColor;
```
<!--</div>-->


## Themers

**Note** These will soon be deprecated for Theming Extensions outlined above.

Our approach to theming relies on the relationships between the following concepts:

1. Components
2. Schemes
3. Themers

Components are expected to provide public APIs for a variety of parameters. An example of a component is [MDCBottomNavigation](https://github.com/material-components/material-components-ios/tree/develop/components/BottomNavigation).

Schemes represent a set of opinionated properties that are intended to be mapped to component parameters. There is a scheme for each Material Theming subsystem. For example, there is a scheme for the color, shape, and typography subsystems.

Themers are objects that, when invoked with a scheme, will theme a component according to the [Material Design guidelines](https://material.io/design).

### How to get the code

#### Cocoapods

In order to use the components, themers and subsystem schemes you'll need to add the targets to your Podfile:

<!--<div class="material-code-render" markdown="1">-->

```bash
pod 'MaterialComponents/TextFields'
pod 'MaterialComponents/TextFields+ColorThemer'
pod 'MaterialComponents/schemes/Color'
```
<!--</div>-->

### Using a scheme

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialColorScheme

let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
// Configure custom properties to match your brand
colorScheme.backgroundColor = .lightGray
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialColorScheme.h>

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
// Configure custom properties to match your brand
colorScheme.backgroundColor = UIColor.lightGrayColor
```
<!--</div>-->

### Examples

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextFields_ColorThemer

let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
let textField = MDCTextField()
let controller = MDCTextInputControllerFilled(textInput:textField)

MDCFilledTextFieldColorThemer.applySemanticColorScheme(colorScheme, to: controller)
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialTextFields.h>
#import <MaterialComponents/MaterialTextFields+ColorThemer.h>

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
MDCTextField *textField = [[MDCTextField alloc] init];
MDCTextInputControllerFilled *controller =
    [[MDCTextInputControllerFilled alloc] initWithTextInput:textField];
[MDCFilledTextFieldColorThemer applySemanticColorScheme:colorScheme
    toTextInputControllerFilled:controller];
```
<!--</div>-->


## Additional links

* [Material Guidelines introduction to Theming](https://material.io/design/material-theming/overview.html)
* [Material Theming at Google I/O](https://youtu.be/3VUMl_l-_fI)
