### Migration guide: semantic color schemes

Deprecation schedule:

- October 10, 2018: Both APIs and any corresponding themer API will be deprecated.
- November 10, 2018: Both APIs and any corresponding themer API will be deleted.

The following is guidance for migrating from the legacy colors cheme APIs to the modern, Material
color system-compatible APIs.

The legacy APIs roughly map to the modern APIs like so:

| Legacy API            | Modern API               |
|:----------------------|:-------------------------|
| `MDCColorScheme`      | `MDCColorScheming`       |
| `MDCBasicColorScheme` | `MDCSemanticColorScheme` |
| `MDCTonalColorScheme` | No equivalent.           |
| `MDCTonalPalette`     | No equivalent.           |

#### A brief comparison of MDCColorScheme and MDCColorScheming

`MDCColorScheme` and `MDCColorScheming` are both protocols that define a set of semantic property
names. The key difference between these two APIs is that `MDCColorScheme` is a mostly-optional bag
of color properties, while `MDCColorScheming`'s properties are all required.

Both protocols are currently accepted by each component's color themer. The legacy themer APIs
tend to map far fewer color scheme properties to their components, while the modern themer APIs
more rigorously map the scheme's colors to their component. For example, `MDCButtonColorThemer`'s
legacy API merely sets the button's background color, while the modern API sets background
color, text color, image tint color, ink color, and more.

The modern APIs also introduce a concept of "on-" colors, which are colors that can generally
be used as the color for text or iconography placed in front of their similarly-named color. For
example, if `primaryColor` is white, `onPrimaryColor` might typically be black.

In essence: the modern APIs represent a more comprehensive take on a global theming system.

The legacy properties map to the modern properties roughly like so:

| `MDCColorScheme`      | `MDCColorScheming`    |
|:----------------------|:----------------------|
| `primaryColor`        | `primaryColor`        |
| `primaryLightColor`   | `primaryColorVariant` |
| `primaryDarkColor`    | `primaryColorVariant` |
| `secondaryColor`      | `secondaryColor`      |
| `secondaryLightColor` | No equivalent.        |
| `secondaryDarkColor`  | No equivalent.        |
| No equivalent.        | `errorColor`          |
| No equivalent.        | `surfaceColor`        |
| No equivalent.        | `backgroundColor`     |
| No equivalent.        | `onPrimaryColor`      |
| No equivalent.        | `onSecondaryColor`    |
| No equivalent.        | `onSurfaceColor`      |
| No equivalent.        | `onBackgroundColor`   |

#### A brief comparison of MDCBasicColorScheme and MDCSemanticColorScheme

`MDCBasicColorScheme` and `MDCSemanticColorScheme` are both concrete implementations of
`MDCColorScheme` and `MDCColorScheming`, respectively.

The legacy API, `MDCBasicColorScheme`, provides a variety of convenience initializers for setting
specific subsets of the color scheme.

The modern API, `MDCSemanticColorScheme`, only provides a basic initializer that initializes the
colors to the Material defaults. You are expected to fully configure the color scheme according to
your needs. A common pattern is to define a global method that returns an instance of a
pre-configured color scheme for your app to use when theming components.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Before
let colorScheme = MDCBasicColorScheme(primaryColor: .white)

// After
let colorScheme = MDCSemanticColorScheme()
colorScheme.primaryColor = .white
colorScheme.onPrimaryColor = .black
```

#### Objective-C

```objc
// Before
MDCBasicColorScheme *colorScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:UIColor.whiteColor];

// After
MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
colorScheme.primaryColor = UIColor.whiteColor;
colorScheme.onPrimaryColor = UIColor.blackColor;
```
<!--</div>-->

#### Differences in themer APIs

The color themer extensions for each component now have both a legacy and modern API for color
theming. The legacy APIs typically have the signature `applyColorScheme:toComponent:`, while the
modern APIs typically have the signature `applySemanticColorScheme:toComponent:`.

In cases where no previous legacy API existed, the modern API may use the
`applyColorScheme:toComponent:` signature but it will accept an `MDCColorScheming` instance.

Example before/after code:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Before
MDCActivityIndicatorColorThemer.apply(colorScheme, to: activityIndicator)

// After
MDCActivityIndicatorColorThemer.applySemanticColorScheme(colorScheme, to: activityIndicator)
```

#### Objective-C

```objc
// Before
[MDCActivityIndicatorColorThemer applyColorScheme:colorScheme
                              toActivityIndicator:activityIndicator];

// After
[MDCActivityIndicatorColorThemer applySemanticColorScheme:colorScheme
                                      toActivityIndicator:activityIndicator];
```
<!--</div>-->
