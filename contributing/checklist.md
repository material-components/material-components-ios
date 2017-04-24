# Component checklist


Over time we have curated a growing checklist of things we feel improve the experience of using a custom UIKit component. Many of these checks are performed by humans but we're now increasing the number of checks that can be performed by scripts.


## The steps


### API Review


Before a component is built, the API proposed must be agreed upon by the main contributors.

1. Create a pull request with only the .h files of the proposed component linked back to the original issue for the component's creation.
1. Enter the pull request # or NO


### README.md


Every component has a README.md file describing what it is, what it does, when to use it, etc, in the root of the component's folder. To create a new README.md file see the template at [writing_readmes](writing_readmes.md).

1. Verify the component has a filled out README.md
1. Verify Swift code samples appear before Objective-C samples.
1. Enter YES or NO


### Additional Usage Docs (If necessary)


Sometimes, the inline comments and README.md will not be sufficient to describe usage of the component. In these cases, create additional README.md files in child folders of the component. See: [Collections](https://github.com/material-components/material-components-ios/tree/develop/components/Collections) for a good example.

1. Verify the component has filled out README.md files in its child folders.
1. Enter YES, NO or N/A


### Usage Video


Each component must have a short video captured from either iPhone or iPhone simulator of it in action.

1. Verify the component's `.../docs/assets` folder contains a video named `component_name.mp4`.
1. Enter YES or NO


### Usage Still


Each component must also have a still image to use when video cannot play.

1. Verify the component's `.../docs/assets` folder contains a still named `component_name.png`.
1. Enter YES or NO


### Catalog Tile


The included catalog application uses Core Graphics to draw landing page tiles for each component. These tiles are created by Google's Material Design department specifically for this purpose and then converted to Core Graphics code via [PaintCode](https://www.paintcodeapp.com/).

#### To convert a raw asset to Core Graphics:

1. Set the canvass size to 188 x 155.
1. Import the file (.svg or .ai) into PaintCode.
1. Massage values until it matches the original (colors, gradients, spacing, etc).
1. Make sure all shapes are enclosed in a group named Component Name Group.
1. Enclose the group in a frame with the same bounds and origin as the canvas.
1. Set the group's springs and struts to:
  1. Top and Left pinned
  1. All others resize
1. In `catalog/MDCCCatalog/MDCCatalogTiles.h`, declare a function for the new component.
1. In `catalog/MDCCCatalog/MDCCatalogTiles.m`, add that function (empty.)
1. Copy and paste the generated iOS Objc code into the function.
1. In `catalog/MDCCatalog/MDCCatalogTileView.swift`, add a new case for the new component and have it create `newImage` from the new function.

#### Verify a tile exists:

1. Run the catalog application and look for the component. Make sure the tile shown is specific to the component and not a placeholder nor empty view.
1. Enter YES or NO


### License Stanzas in Every Text-based Source File


Every source file must have the Apache 2.0 license stanza at the top of the file.  The copyright should be assigned to “the Material Components for iOS authors“.
You can do this manually or use a tool such as [autogen](https://github.com/mbrukman/autogen) to add a license.


Sample:
```
/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.


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
```


1. Add the license to every source and script file in your component.
1. Enter YES or NO


### Unit Tests


Unit tests in MDC are run by the developer, the continuous integration service, and the release engineer: the developer runs them regularly during development, the CI service when a pull request is submitted, and the release engineer as part of the release process prior to final merging. If a developer submits a PR with broken unit tests, the CI service will prevent merging thru GitHub.

#### Writing unit tests:

1. Store unit test files for a component in the directory `components/ComponentName/tests/unit/`
1. Unit tests may be written in either Objc or Swift. Swift is preferred as merely writing them can verify the Objc-to-Swift experience is seamless.
1. //TODO: helpful ideas for tests

#### Ensuring test sufficiency:

1. Include unit tests for new functionality.
1. Inlcude unit tests for bug fixes and changes initiated from GitHub issues. Name them `ClassNameIssue` + issue number + `Tests`. e.g. `AppBarContainerIssue246Tests`, `FlexibleHeaderControllerIssue176Tests`.
1. Update existing unit tests for new changes.
1. Ensure unit tests run with no errors.
1. Enter YES or NO


### Interaction Tests (If necessary)


Visual components should have interaction tests built with [Earl Grey](https://github.com/google/EarlGrey).

//TODO and explain how


### Translations (If necessary)


Google strives to support as many different written languages as possible in components containing static text. The necessary translations must be written by Google's internal translators. To request translations, open an issue with all text and all requested languages.


1. Any strings that are added must be internationalized. Please don’t include English strings in code. We have language bundles for the various components. Add your English strings there and use a key to access it via code (key will be generated after compilation).
1. Make sure strings are internationalized (takes about a week) and dumped before releasing a feature (manual process).
  1. Edge case: Some strings are super long in some languages, make sure UI displays/handles long text correctly.
1. Enter YES, NO or N/A


### Right-to-Left Language (RTL) Support (If necessary)


Any UI code that isn’t centered - e.g. has directionality - will need RTL support.


1. Prefer .leading and .trailing over .left and .right when laying out view hierarchies.
1. Prefer Natural or Left when setting the alignment of text fields and labels.
1. Add an example to our catalog.
1. Enter YES, NO or N/A


### VoiceOver Support


Custom controls should support VoiceOver.
See Apple's [Accessibility Programming Guide for iOS](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/iPhoneAccessibility/Accessibility_on_iPhone/Accessibility_on_iPhone.html) for further information.

1. Test your control on a device in VoiceOver mode and ensure the bahavior is at least as robust as UIKit.
1. Enter YES, NO or N/A


### Scrubbed Comments


Comments are useful when used properly. In addition, they are necessary for the system of documentation generation used in MDC.

1. Carefully review all comments for necessity and brevity.
1. Make sure all classes have complete header comments that comply with [HeaderDoc](https://developer.apple.com/legacy/library/documentation/DeveloperTools/Conceptual/HeaderDoc/tags/tags.html) for [Jazzy](https://github.com/realm/jazzy) parsing.
1. Enter YES or NO


### Material Design Guidelines Review


Every component has to support all features outlined for it in the Material Design guidelines. It can support additional features or customization.

1. Review what the [Material Design Guidelines](https://material.io/guidelines/) says about the component and make sure the component can *at least* satisfy those requirements.
1. Enter YES or NO


### Test URLs


Both documentation and code can contain URLs to assets or additional text. Make sure they are converted to production values.

1. Verify all URLs inline are set to production values.
1. Enter YES, NO or N/A


### Examples

Each component must have its own standalone examples in Swift and Objective-C. If you only include a single example, use Swift. If you are including multiple examples, it's preferable to use Swift for some and Objective-C for others so our users can get a feel for how the component works in both languages.

Examples will appear automatically in MDCCatalog if they are placed on disk in conformance to the “Catalog by Convention.” These examples should follow the format set forth in // TODO: Link to doc on examples and supplemental

They should focus on educating thru the catalog’s visual result and the code itself. Include comments when helpful.

1. Include an example of typical usage.
1. Include examples of additional features of the component, if possible.
1. Enter YES or NO

### Interface Builder Support (If possible)


Our users create their views both in code and in Interface Builder. It’s important to support both usages. Almost all components should be able to be added to a view hierarchy thru Interface Builder.

1. UIView subclasses must support initWithCoder along with initWithFrame. The recommended practice is to override both init methods and have them both call a commonInit method with required initialization logic.
1. Do not include @IBIspectable as it interferes with UIAppearance support.
1. Enter YES, NO or N/A


### Interface Builder Examples (If necessary)


If a component supports Interface Builder usage, then we need to show our users how to do that.

1. Include an example of typical usage via storyboard.
1. Include examples of additional features of the component, if possible.
1. Enter YES, NO or N/A


### Test on Supported iOSs


Sometimes the operating system changes in ways that cause unpredictable or surprising behavior (even if your code is unchanged.)

1. Test your component on devices running every major OS version we support. For example, if our current iOS minimum target was 8.0 and the highest version in beta was 10.x, it would be acceptable to test on three versions: 8.x, 9.x and 10.x.
1. Enter YES or NO


### Extensions Support (If possible)


Many components could be sensibly used in an extension. But sometimes code prevents a component from working correctly in extensions (or at all.)

1. Do not use `[UIApplication sharedApplication]`.
1. Conditional compilation and runtime checks might be necessary in some cases, but generally liberal application of `NS_EXTENSION_UNAVAILABLE_IOS` can take care of most cases.
1. Enter YES or NO (with reason)


### All Designated Initializers


We want to avoid misuse of initializers both in the calling of existing classes and the implementation of our new classes. Aside from being a best practice in Objc, it is mandatory in Swift. Don't forget that some classes have more than one designated initializer (e.g. `UIView`.)

1. Add the `NS_DESIGNATED_INITIALIZER` macro to new designated initializers in all new classes (even private.) Remember, designated initializers must call an initializer of the super class. All others (the convenience initializers) must call an initializer within the class (`self` level, not `super`).
1. If a class provides one or more designated initializers, it must also implement all of the designated initializers of its superclass; mark them `NS_DESIGNATED_INITIALIZER` if you want them to still to be designated. If those initializers should no longer be called, declare them `NS_UNAVAILABLE`.
1. If a class has no new designated initializers and no existing designated initializers have been marked `NS_UNAVAILABLE`, nothing needs to be done.
1. Call convenience initializers that refer to the designated initializer or the designated initializer itself. Only call `init` if you know that it is, or refers to, the designated initializer.
1. Enter YES or NO


### NSCoding Support


Conforming to NSCoding is necessary for Interface Builder support in views and could be used to
serialize non-view classes. Tip: write a unit test for this.

1. Implement `initWithCoder:`.
1. Implement `encodeWithCoder:`.
1. Enter YES or NO


### commonMDCClassInit (If necessary)


Classes that set ivar values or perform other commands from the initializer, should avoid duplicate code by writing a `common*MDCClass*init` method to call from all initializers.

1. The method should be named `common` + the name of the class prefixed with MDC + `init`.
1. The method should be called from all initializers (initWithFrame:, initWithCoder:, etc.)
1. Enter YES, NO or N/A


### Auto Layout Support (If possible)


#### General recommendations:

* Components should support autolayout (see: `intrinsicContentSize`.)
* Components don’t have to adopt autolayout (adding constraints.)
* When adopting autolayout, be aware of performance implications, such as continually adding/removing subviews.


#### Supporting auto layout in your component:

1. Implement `intrinsicContentSize` on your view. This will ensure that, if your view is used in an auto-layout-based hierarchy, that the system knows the view’s preferred size. This is analogous to implementing `sizeThatFits:`.
1. If any size-impacting features of your view (i.e. new text, different image, etc) change, call `invalidateIntrinsicContentSize` to tell the layout engine that something changed.


#### If your view adopts auto layout internally:

1. Make sure to use .leading and .trailing instead of .left and .right to support RTL languages correctly.
1. If your view sets its constraints in `updateConstraints`, override `requiresConstraintBasedLayout` to return YES.
1. Make sure your view does not add constraints which force its width/height to be a specific value. Prefer `intrinsicContentSize` along with content-hugging / compression settings (see: `UIView`.)
1. Enter YES, NO or N/A


#### Articles on Auto Layout:
[Advanced Auto Layout Toolbox](https://www.objc.io/issues/3-views/advanced-auto-layout-toolbox/)
[Auto Layout Performance on iOS](http://floriankugler.com/2013/04/22/auto-layout-performance-on-ios/)


### UIAppearance Support (If possible)


We use the UIAppearance proxy with our visible components to allow setting default values of properties and state.


1. Attempt to name properties in line with Apple’s style: `UISlider.thumbTintColor`, `UISlider.maximumTrackTintColor`, `UISwitch.onTintColor`, `UINavigationBar.barTintColor`, etc.
1. `tintColor` is not compatible with the `UIAppearance` proxy.  Avoid using `tintColor` unless we are implementing it as `UIView` does.
1. `NSObject` properties should be nullable.
1. Avoid “primary”, “secondary” or “accent” in your property names to avoid confusion with our color schemes.
1. Enter YES, NO or N/A


### IBDesignable Support for UIView Subclasses (If possible)


Consider adding support for [IBDesignable](http://nshipster.com/ibinspectable-ibdesignable/). If you have created a public subclass of UIView this may be as simple as adding IB_DESIGNABLE above your @interface declaration. **Note:** Do not include @IBInspectable as it interferes with UIAppearance support.


```Objective-C
IB_DESIGNABLE
@interface MDCBrandNewView : UIView
```

1. Verify inclusion of `IB_DESIGNABLE`.
1. Mark YES, NO or N/A


### Nullability


Nullability annotations improve Swift usage of a component's APIs. Learn more in Apple's [documentation](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

Material Components explicitly annotate all public APIs rather than use `NS_ASSUME_NONNULL_BEGIN`. This is an intentional deviation from Apple’s practice of using the `ASSUME` macros. [Further reading](http://nshipster.com/swift-1.2/#nullability-annotations)


1. Add nullability annotations to every header of your component.
1. Enter YES or NO


### Swift Overrides and Annotations


Swift coding conventions differ from Objective-C. It's important to consider the experience of users implementing Material Components in Swift targets and add naming annotations, refinements, and other cross-language features accordingly. See Apple's [documentation](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

1. Use [lightweight Objective-C generics](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID173) whenever possible.
1. Add Swift annotation macros where appropriate:
  - `NS_SWIFT_NAME`
  - `NS_SWIFT_NOTHROW`
  - `NS_SWIFT_UNAVAILABLE`
  - `NS_REFINED_FOR_SWIFT`
1. Use `typedef NS_ENUM` for enums to allow truncation of enumeration value name prefixes.
1. Typedef string constants with [proper macros](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithCAPIs.html#//apple_ref/doc/uid/TP40014216-CH8-ID29) for better swift translation:
  1. `NS_STRING_ENUM` for importing as a `String` backed enum.
  1. `NS_EXTENSIBLE_STRING_ENUM` for importing as an extensible `struct` in Swift.
1. Mark non-escaping blocks as `NS_NOESCAPE` and non-escaping closures as `@noescape`.
1. Enter YES, NO or N/A


### Verify Podspec is Accurate


Material Components for iOS is built primarily for adoption with CocoaPods. There is `MaterialComponents.podspec` file in the root folder of the project. It contains information on component naming, dependencies, resources, etc. To learn more about `.podspec` files, go to [CocoaPods.org](https://guides.cocoapods.org/syntax/podspec.html)

1. Verify `MaterialComponents.podspec` contains a properly filled out entry for the component.
1. Enter YES or NO


## Running the checklist

We have automated some of the above checks in a set of scripts. To run all the checks against every component, run:

```bash
scripts/check_components
```

To run the checks against particular components, list their directories on the command line:

```bash
scripts/check_components components/ActivityIndicator components/Buttons
```

Each check is a small script in the `scripts/check` directory. To run only particular checks, use the `-c` flag:

```bash
scripts/check_components -c scripts/check/readme -c scripts/check/video
```

Errors are printed out and summarized at the end of the checks:

```bash
Error: '/Users/ajsecord/Source/Git/mdc-fork/components/ActivityIndicator/examples' has no Swift examples.
The following components failed: components/ActivityIndicator.
```

## Creating new checks

To create a new check, see [`scripts/check/README.md`](../scripts/check/README.md).
