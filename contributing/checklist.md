# Component checklist


Over time we have curated a growing checklist of things we feel improve the experience of using a custom UIKit component. Many of these checks are performed by humans but we're now increasing the number of checks that can be performed by scripts.


## The steps


### Api Review


### README.md


### Additional Usage Docs
#### If necessary


### Usage Video


### Usage Still


### Catalog Tile


### Site Icon


### Site Left Nav Presence


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


### Interaction Tests


### Translations


### Right-to-Left Language (RTL) Support


Any UI code that isn’t centered - e.g. has directionality - will need RTL support.


1. Prefer .leading and .trailing over .left and .right when laying out view hierarchies.
1. Prefer Natural or Left when setting the alignment of text fields and labels.
1. Add an example to our catalog.
1. Enter YES or NO


### VoiceOver Support


### Text Accessibility


### Scrubbed Comments


### Material Design Guidelines Review


### Test URLs


------
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


### Auto Layout Support
#### If possible


General recommendations:
1. Components should support autolayout (see: intrinsicContentSize)
1. Components don’t have to adopt autolayout (adding constraints)
1. When adopting autolayout, be aware of performance implications, such as continually adding/removing subviews.


Supporting Autolayout In Your Component:
1. Implement `intrinsicContentSize` on your view. This will ensure that, if your view is used in an auto-layout-based hierarchy, that the system knows the view’s preferred size. This is analogous to implementing `sizeThatFits:`.
1. If any size-impacting features of your view (i.e. new text, different image, etc) change, call `invalidateIntrinsicContentSize` to tell the layout engine that something changed.


If your view adopts autolayout internally:
1. Make sure to use .leading and .trailing instead of .left and .right to support RTL languages correctly.
1. If your view sets its constraints in `updateConstraints`, override `requiresConstraintBasedLayout` to return YES.
1. Make sure your view does not add constraints which force its width/height to be a specific value. Prefer -intrinsicContentSize along with content hugging/compression settings (see: UIView).


1. Enter YES, NO or N/A


Articles on AutoLayout
Advanced Auto Layout Toolbox
Auto Layout Performance on iOS




### UIAppearance Support (If possible)


We use the UIAppearance proxy with our visible components to allow setting default values of properties and state.


General Recommendations
	Attempt to name properties in line with Apple’s style: UISlider.thumbTintColor, UISlider.maximumTrackTintColor, UISwitch.onTintColor, UINavigationBar.barTintColor.
	tintColor is not compatible with the UIAppearance proxy.  Avoid using tintColor unless we are implementing it as UIView does.
	NSObject* properties should be nullable.
Avoid “primary”, “secondary” or “accent” in our property names to avoid confusion with our color schemes.


Enter YES, NO or N/A


### IBDesignable Support for UIView Subclasses
#### If possible
Consider adding support for IBDesignable.


If you have created a public subclass of UIView this may be as simple as adding IB_DESIGNABLE above your @interface declaration.


```
IB_DESIGNABLE
@interface MDCBrandNewView : UIView
```


Mark YES, NO or N/A




### Asset Catalogs Support
#### If necessary


//TODO


### Nullability


The work: add nullability annotations to every header of your component.
The why: nullability annotations improve Swift usage of a component's APIs. Learn more
Recommendations:
We explicitly annotate all public APIs rather than use NS_ASSUME_NONNULL_BEGIN. This is an intentional deviation from Apple’s practice of using the ASSUME macros.
Further reading:
http://nshipster.com/swift-1.2/#nullability-annotations




### Swift Name Overrides


### Verify Podspec is Accurate




// TODO: Flesh out with more instruction


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




