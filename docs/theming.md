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
import MaterialComponentsBeta.MaterialButtons_Theming

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
containerScheme.colorScheme.primaryColor = [UIColor redColor];

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

### How to get the code

#### Beta components

In order to use the theming extensions you'll need to follow [these](../../contributing/beta_components.md) 
instructions since they are currently in beta.

#### Cocoapods

In order to use the components and subsystem schemes you'll need to add the targets to your Podfile:

<!--<div class="material-code-render" markdown="1">-->

```bash
pod 'MaterialComponents/Buttons'
pod 'MaterialComponents/schemes/Color'
```
<!--</div>-->

## Themers

**Note** These will soon be deprecated for theming-extensions outlined above.

Our approach to theming relies on the relationships between the following concepts:

1. Components
2. Schemes
3. Themers

Components are expected to provide public APIs for a variety of parameters. An example of a component is [MDCBottomNavigation](https://github.com/material-components/material-components-ios/tree/develop/components/BottomNavigation).

Schemes represent a set of opinionated properties that are intended to be mapped to component parameters. There is a scheme for each Material Theming subsystem. For example, there is a scheme for the color, shape, and typography subsystems.

Themers are objects that, when invoked with a scheme, will theme a component according to the [Material Design guidelines](https://material.io/design).

## Examples

### Theming a Component

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialBottomNavigation_ColorThemer

let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
let bottomNavBar = MDCBottomNavigationBar()
MDCBottomNavigationBarColorThemer.applySemanticColorScheme(colorScheme,
toBottomNavigation: bottomNavBar)
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialBottomNavigation.h>
#import <MaterialComponents/MaterialBottomNavigation+ColorThemer.h>

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
MDCBottomNavigation *bottomNavBar = [[MDCBottomNavigation alloc] init];
[MDCBottomNavigationBarColorThemer applySemanticColorScheme:self.colorScheme
toBottomNavigation:_bottomNavBar];
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

### How to get the code

#### Cocoapods

In order to use the components, themers and subsystem schemes you'll need to add the targets to your Podfile:

<!--<div class="material-code-render" markdown="1">-->

```bash
pod 'MaterialComponents/BottomNavigation'
pod 'MaterialComponents/BottomNavigation+ColorThemer'
pod 'MaterialComponents/schemes/Color'
```
<!--</div>-->

## Additional links

* [Material Guidelines introduction to Theming](https://material.io/design/material-theming/overview.html)
* [Material Theming at Google I/O](https://youtu.be/3VUMl_l-_fI)
