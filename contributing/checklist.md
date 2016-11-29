# Component checklist


Over time we have curated a growing checklist of things we feel improve the experience of using a custom UIKit component. Many of these checks are performed by humans but we're now increasing the number of checks that can be performed by scripts.


## The steps


### API Review

Before a component is built, the API proposed must be agreed upon by the main contributors.

1. Create a pull request with only the .h files of the proposed component linked back to the original issue for the component's creation.
1. Enter the pull request # or NO


### README.md

Every component has a README.md file describing what it is, what it does, when to use it, etc, in the root of the component's folder. To create a new README.md file see the template at //TODO: Link

1. Verify the component has a filled out README.md
1. Enter YES or NO


### Additional Usage Docs
#### If necessary

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

#### To convert a raw asset to Core Graphics

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

#### Verify a tile exists

1. Run the catalog application and look for the component. Make sure the tile shown is specific to the component and not a placeholder nor empty view.
1. Enter YES or NO

### Site Icon

The documentation site uses icons in an [ordered list](https://material-ext.appspot.com/mdc-ios-preview/components/) of the components. These icons are created by Google's Material Design department specifically for this purpose.

1. Make sure the site source's `.../images/custom_icons_` folder contains an icon named `ic` + name of component lowercase + `_24.svg`.
1. Make sure the site source's `_icons.scss` contains an entry for that icon for that component:
~~~CSS
  .icon-componentname a::before {
    background-image: url(#{$root_folder}/images/custom_icons/ic_componentname_24px.svg);
  }
~~~

### Site Left Nav Presence

The component should have an entry in the left nav of [the documentation site](https://material-ext.appspot.com/mdc-ios-preview/components/). If missing, add it in the site source's `_data/navigation.yaml` file.

1. Verify [the documentation site's](https://material-ext.appspot.com/mdc-ios-preview/components/) left nav contains a link to the component's docs.
1. Enter YES or NO

### License Stanzas in Every Text-based File


Every file must have the Apache 2.0 license stanza at the top of the file.  The copyright should be assigned to “the Material Components for iOS authors“.
You can do this manually or use a tool such as (autogen)[https://github.com/mbrukman/autogen] to add a license.


Example:
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
1. Enter YES or NO  // TODO Link


### Unit Tests

//TODO

### Interaction Tests

Visual components should have interaction tests built with [Earl Grey](https://github.com/google/EarlGrey).

//TODO and explain how

### Translations

Google strives to support as many different written languages as possible.

//TODO: Explain how to get translations

1. Any strings that are added must be internationalized. Please don’t include English strings in code. We have language bundles for the various components. Add your English strings there and use a key to access it via code (key will be generated after compilation).
1. Make sure strings are internationalized (takes about a week) and dumped before releasing a feature (manual process).
  1. Edge case: Some strings are super long in some languages, make sure UI displays/handles long text correctly.
1. Enter YES, NO or N/A

### Right-to-Left Language (RTL) Support


Any UI code that isn’t centered - e.g. has directionality - will need RTL support.


1. Prefer .leading and .trailing over .left and .right when laying out view hierarchies.
1. Prefer Natural or Left when setting the alignment of text fields and labels.
1. Add an example to our catalog.
1. Enter YES or NO


### VoiceOver Support

//TODO

### Text Accessibility

//TODO

### Scrubbed Comments

Comments are useful when used properly. In addition, they are necessary for the system of documentation generation used in MDC.

1. Carefully review all comments for necessity and brevity.
1. Make sure all classes have comments that comply with //TODO:
1. Enter YES or NO

### Material Design Guidelines Review

Every component has to support all features outlined for it in the Material Design guidelines. It can support additional features or customization.

1. Review what the [Material Design Guidelines](https://material.google.com/) says about the component and make sure the component can *at least* satisfy those requirements.
1. Enter YES or NO

### Test URLs

Both documentation and code can contain URLs to assets or additional text. Make sure they are converted to production values.

1. Verify all URLs inline are set to production values.
1. Enter YES, NO or N/A


### Swift Examples


Each component must have its own standalone examples in Swift. They must appear in the MDCCatalog by conforming to the “Catalog by Convention.” These examples should follow the format set forth in // TODO: Link to doc on examples and supplemental

They should focus on educating thru the catalog’s visual result and the code itself. Include comments when helpful.

1. Include an example of typical usage.
1. Include examples of additional features of the component, if possible.
1. Enter YES or NO


### Objc Examples


These examples must be direct ports to Objc of every Swift example. See “Swift Examples” for more information.


### Interface Builder Support
#### If possible


Our users create their views both in code and in Interface Builder. It’s important to support both usages. Almost all components should be able to be added to a view hierarchy thru Interface Builder.

1. UIView subclasses must support initWithCoder along with initWithFrame. The recommended practice is to override both init methods and have them both call a commonInit method with required initialization logic.
1. Enter YES, NO or N/A


### Interface Builder Examples
#### If necessary


If a component supports Interface Builder usage, then we need to show our users how to do that.

1. Include an example of typical usage via storyboard.
1. Include examples of additional features of the component, if possible.
1. Enter YES, NO or N/A


### Tested on Supported iOSs


Sometimes the operating system changes in ways that cause unpredictable or surprising behavior (even if your code is unchanged.)

1. Test your component on devices running every major OS version we support. For example, if our current iOS minimum target was 8.0 and the highest version in beta was 10.x, it would be acceptable to test on three versions: 8.x, 9.x and 10.x.
1. Enter YES or NO


### Extensions Support
#### If possible


Many components could be sensibly used in an extension. But sometimes code prevents a component from working correctly in extensions (or at all.)

1. Do not use `[UIApplication sharedApplication]`.
1. Conditional compilation and runtime checks might be necessary in some cases, but generally liberal application of `NS_EXTENSION_UNAVAILABLE_IOS` can take care of most cases.
1. Enter YES or NO (with reason)


### All Designated Initializers


We want to avoid misuse of initializers both in the calling of existing classes and the implementation of our new classes.

1. Add the `NS_DESIGNATED_INITIALIZER` macro in all new classes.
1. Call convenience initializers that refer to the designated initializer or the designated initializer itself. Only call `init` if you know that it is, or refers to, the designated initializer
1. Enter YES or NO


### NSCoding Support


Conforming to NSCoding is necessary for Interface Builder support in views and could be used to serialize non-view classes.

1. Implement `initWithCoder:`.
1. Implement `encodeWithCoder:`.
1. Enter YES or NO


### commonMDCClassInit
#### If necessary


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


Consider adding support for IBDesignable.


If you have created a public subclass of UIView this may be as simple as adding IB_DESIGNABLE above your @interface declaration.


```Objective-C
IB_DESIGNABLE
@interface MDCBrandNewView : UIView
```

1. Verify inclusion of `IB_DESIGNABLE`.
1. Mark YES, NO or N/A


### Asset Catalogs Support
#### If necessary


//TODO


### Nullability

Nullability annotations improve Swift usage of a component's APIs. Learn more in Apple's [documentation](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

Material Components explicitly annotate all public APIs rather than use `NS_ASSUME_NONNULL_BEGIN`. This is an intentional deviation from Apple’s practice of using the `ASSUME` macros. [Further reading](http://nshipster.com/swift-1.2/#nullability-annotations)


1. Add nullability annotations to every header of your component.
1. Enter YES or NO


### Swift Name Overrides

Swift naming conventions differ from ObjC. It's important to consider the experience of users implementing Material Components in Swift targets and add naming annotations accordingly. See Apple's [documentation](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

1. Add `NS_SWIFT_NAME` annotations where appropriate.
1. Use `typedef` for enums to allow truncation of enumeration value name prefixes.
1. Enter YES, NO or N/A

### Verify Podspec is Accurate

Material Components for iOS is built primarily for adoption with CocoaPods. There is `MaterialComponents.podspec` file in the root folder of the project. It contains information on component naming, dependencies, resources, etc. To learn more about `.podspec` files, go to [CocoaPods.org](https://guides.cocoapods.org/syntax/podspec.html)

1. Verify `MaterialComponents.podspec` contains a properly filled out entry for the component.
1. Enter YES or NO

## Running the checklist


To run the checklist, execute the following command from the root of this repo:


~~~bash
scripts/check_components
~~~


This command will run every check on every component. The output will look something like this:


~~~
<some check>:
<component failing the check>
<another component failing the check>
<another check>:
<a third check>:
~~~


Each check is expected to output each component that is failing the check.


For example, our `missing_readme` check simply verifies whether each component has a README.md file
in its root directory. If a component is missing a README.md, the check outputs the component's
name, like so:


~~~
FontDiskLoader
private/Color
private/Icons/icons/ic_arrow_back
private/ThumbTrack
RobotoFontLoader
~~~


## Creating checks


Creating a check is as simple creating an executable script in the `scripts/check/` directory. Your
script will not be provided any arguments or stdin and is expected to output a components that fail
the check, one component per line.


### Snippets


Use the following snippets to bootstrap your checks.


*Find all components and perform a simple conditional*


~~~bash
find components -type d -name 'src' | while read path; do
  folder=$(dirname $path)
  component=$(echo $folder | cut -d'/' -f2-)


  if [ <your check logic> ]; then
    echo $component # This component failed the check
  fi
done
~~~




