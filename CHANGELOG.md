## In progress since last release

##### Breaking

##### Enhancements

##### Bug Fixes

## 2.1.1

##### Enhancements

###### Code
* [AppBar] Add App Bar builder API. (Jeff Verkoeyen)
* [AppBar] Fix compiler warnings about formatting NSIntegers. (Adrian Secord)
* [FlexibleHeader] MDCFlexibleHeaderViewController conforms to * UITableViewDelegate. (Jeff Verkoeyen)
* [Ink] Updated the ink example to include smaller shapes. (Adrian Secord)
* [Ink] Visual adjustments to ink ripple (Junius Gunaratne)
* [NavigationBar] Add back button icon. (Jeff Verkoeyen)

###### Examples
* [Demos] Updates to header behavior and minor layout changes after UX review (* Junius Gunaratne)
* [Pesto] Adding 'nonatomic' attribute to all delegates (Will Larche)
* [Pesto] Corrections for build warnings (Will Larche)
* [Pesto] making string and URL propertys 'copy' (Will Larche)
* [Pesto] Style update: @property ivars (larche)
* [Pesto] Update card zoom animation to be more Material Design like (Junius * Gunaratne)

###### Docs and site
* [Docs] Minor touchups to FlexibleHeader readme. (Jeff Verkoeyen)
* [Docs] Minor updates to AppBar readme. (Jeff Verkoeyen)
* [Docs] Updated community/README.md (Katy Kasmai)
* [FlexibleHeader] README.md formatting. (Jason Striegel)
* [Site] AppBar jump links to open in new tab. (Jason Striegel)
* [Site] Buttons jump link formatting. (Jason Striegel)
* [Site] Corrected links and formatting. (Jason Striegel)
* [Site] Formatting markdown structure for site. (Jason Striegel)
* [Site] Jump link styling for ButtonBar README. (Jason Striegel)
* [Site] New formatting for Buttons documentation. (Jason Striegel)
* [Site] Removing defunct placeholder documents. (Jason Striegel)
* [Site] Replacing lorem with description content, where possible. (Jason * Striegel)
* [Site] Update component landing page's nav list (Yiran Mao)

## 2.1.0

##### Enhancements

* [AppBar] Introducing the App Bar component. (Jeff Verkoeyen)
* [Arcanist] Adds scripts/install_arc.sh, which installs or updates arc and our project-specific dependencies. (Adrian Secord)
* [Arcanist] Updated Arcanist config to use submodules. (Adrian Secord)
* [ButtonBar] Add ButtonBar component. (Jeff Verkoeyen)
* [ButtonBar] Add ButtonBar readme. (Jeff Verkoeyen)
* [Buttons] Add Flatbutton commonInit (Ian Gordon)
* [Buttons] Add storyboard sample (Ian Gordon)
* [Buttons] Clean up API documentation style. (Jeff Verkoeyen)
* [Catalog] Adds localizable strings to catalog. Allows changing language in scheme for debugging. Closes #166. (Chris Cox)
* [Catalog] Moving assets into catalog by convention. (Jeff Verkoeyen)
* [CocoaPods] Allow pod install to be run from anywhere for the catalog. (Jeff Verkoeyen)
* [CocoaPods] Standardizing the podspec format. (Jeff Verkoeyen)
* [CocoaPods] Variables for podspec. (Jeff Verkoeyen)
* [Examples] Moved all example resources into a examples/resources/ directory by convention. [Jeff Verkoeyen](https://github.com/jverkoey)
* [FlexibleHeader] Add headerIsTranslucent API. (Jeff Verkoeyen)
* [FlexibleHeader] Add sizeThatFits contract tests. (Jeff Verkoeyen)
* [FlexibleHeader] Prefer use of childViewControllerForStatusBarHidden. (Jeff Verkoeyen)
* [FlexibleHeader] Add tests for basic tracking scroll view contract. [Jeff Verkoeyen](https://github.com/jverkoey)
* [HeaderStackView] Add HeaderStackView README. (Jeff Verkoeyen)
* [NavigationBar] Add NavigationBar component. (Jeff Verkoeyen)
* [Pesto] Update layout after design review with UX, fix rotation issues (Junius Gunaratne)
* [Pesto] Update network image request methods, improve collection view cell layout (Junius Gunaratne)
* [Scripts] Add generate_jazzy_yamls script. (Jeff Verkoeyen)
* [Scripts] Added 'bump version' script and updated pod_install_all. (Adrian Secord)
* [Shrine] Layout updates after UX design review, make sure rotation works correctly (Junius Gunaratne)
* [Shrine] Use improved network image class from Pesto (Junius Gunaratne)
* [Testing] Add support for xcode unit tests to arc unit. (Jeff Verkoeyen)

##### Bug Fixes

* [AppBar] Minor changes to MDCAppBar documentation. (Jeff Verkoeyen)
* [Buttons] Adjust the title insets of text buttons, not the frame. (Jeff Verkoeyen)
* [Buttons] Fix uppercasing (Ian Gordon)
* [Buttons] Fixes a bug with contentEdgeInsets for MDCFloatingButtonShapeMini. (Matt Rubin)
* [Catalog] Remove the root catalog workspace. (Jeff Verkoeyen)
* [CocoaPods] Minor fixes to Podspec for ButtonBar and Switch. (Jeff Verkoeyen)
* [CocoaPods] Ran pod install on all Podfiles (randallli)
* [CocoaPods] Update Podfile.lock (Ian Gordon)
* [FlexibleHeader] Cleaning up the README.md. (Jeff Verkoeyen)
* [FlexibleHeader] Minor wording consistency in FlexibleHeader readme. (Jeff Verkoeyen)
* [HeaderStackView] Generated missing HeaderStackView .jazzy.yaml. (Jeff Verkoeyen)
* [Ink] Fix animation, split foreground and background ripple into independent classes (Junius Gunaratne)
* [Ink] Set evaporate point so ink expands from correct point on gesture cancel (Junius Gunaratne)
* [Other] Remove the project templates directory. (Jeff Verkoeyen)
* [PageController] Fix FP conversion warning (Ian Gordon)
* [Site] Add landing page placeholder markdown files & update build-site.sh (Yiran Mao)
* [Site] Continued work on markdown doc formatting. (Jason Striegel)
* [Site] Editing pass at community.md. (Jeff Verkoeyen)
* [Site] Fixed section regarding our license. (Jeff Verkoeyen)
* [Site] Formatting for icon list markdown. (Jason Striegel)
* [Site] Initial import of site build structure. (Jason Striegel)
* [Site] Preliminary additions of the components checklist. (Jeff Verkoeyen)
* [Site] Update community.md (Katy Kasmai)
* [Site] Updates to the community.md doc. [Jeff Verkoeyen](https://github.com/jverkoey)
* [SpritedAnimationView] Replaces example checkmark icon with grid/list icon. Closes #151. (Chris Cox)
* [SpritedAnimationView] Updates readme image assets to new URL (Chris Cox)
* [SpritedAnimationView] Updates readme, test, and example with grid/list icon. (Chris Cox)

## 2.0.4

##### Breaking

##### Enhancements
 * Fixed the reference to the private folder of Typography in podspec.

##### Bug Fixes

## 2.0.3

##### Breaking

##### Enhancements
 * Renamed the privateWasCapitalPrivate folders to private.

##### Bug Fixes

## 2.0.2

##### Breaking

##### Enhancements
* Renamed the Private folders to privateWasCapitalPrivate.

##### Bug Fixes

## 2.0.1

##### Breaking
##### Enhancements
  * Removed unused files: podfile.lock

##### Bug Fixes

## 2.0.0

##### Breaking
* [FlexibleHeader] Removed `-[MDCFlexibleHeaderViewController addFlexibleHeaderViewToParentViewControllerView]`,
  `MDCFlexibleHeaderParentViewController`, and `+[MDCFlexibleHeaderViewController addToParent:]`. These methods
  were marked deprecated in 1.0.0. [Jeff Verkoeyen](https://github.com/jverkoey)

##### Enhancements
* Components
  * [Slider] default color updated to nicer blue.
  * [Ink] Replace rand() with arc4random() to avoid a static analyzer warning. [Ian Gordon](https://github.com/ianegordon)
  * [FlexibleHeader] Removed redundant APIs from MDCFlexibleHeaderContainerViewController. [Jeff Verkoeyen](https://github.com/jverkoey)
  * Rename Private directories to private. (Jeff Verkoeyen)

* Documentation
  * [Button] Readme copy edits
* [Conventions] Moved all docs assets into a `docs/assets` directory per component by
  convention. Issue [#130](https://github.com/google/material-components-ios/issues/130) filed by
  [peterfriese](https://github.com/peterfriese). Closed by [Jeff Verkoeyen](https://github.com/jverkoey)
* [CONTRIBUTING] Document our file system conventions in CONTRIBUTING.md. [Jeff Verkoeyen](https://github.com/jverkoey)
* [CONTRIBUTING] Document our pull request expectations in CONTRIBUTING.md. [Jeff Verkoeyen](https://github.com/jverkoey)
* [Switch] Removed internal docs that were pretending to be public docs. [Jeff Verkoeyen](https://github.com/jverkoey)

* Catalog
  * Use single asset for component icons. [Junius Gunaratne](https://github.com/jgunaratne)
  * Style catalog component screen and change to collection view. [Junius Gunaratne](https://github.com/jgunaratne)
  * Sorts titles alphabetically. Also fixes title typo in sliders. [Chris Cox](https://github.com/chriscox)
  * Catalog by convention grabs storyboard resources. [Randall Li](https://github.com/randallli)
  * Increasing our warnings coverage. [Jeff Verkoeyen](https://github.com/jverkoey)
  * Support duplicate hierarchy entries. [Randall Li](https://github.com/randallli)
  * Add support for Swift examples and unit tests [Jeff Verkoeyen](https://github.com/jverkoey)
  * Added Swift sample for buttons. [Peter Friese](https://github.com/peterfriese)
  * Refactored Button example to be compatibile with catalog by convention [Randall Li](https://github.com/randallli)
  * Refactored Slider example to be compatibile with catalog by convention [Randall Li](https://github.com/randallli)
  * Refactored ShadowLayer example to be compatible with catalog by convention
  [Randall Li](https://github.com/randallli)
  * Refactored Switch example to be compatible with catalog by convention
  [Randall Li](https://github.com/randallli)
  * Added Swift example for Typography. [Peter Friese](https://github.com/peterfriese)

* Demos
  * Shrine
    * Adding PageControl to demo app for scrolling through products. [Junius Gunaratne](https://github.com/jgunaratne)
    * Fix crash when trying to load images when network is down. [Junius Gunaratne](http://github.com/jgunaratne)
* Misc
  * [Jazzy] scripts/gendocs.sh now infers Jazzy arguments by convention. [Jeff Verkoeyen](https://github.com/jverkoey)
  * [gh-pages] Minor tiding of the preview script for gh-pages. [Jeff Verkoeyen](https://github.com/jverkoey)
   Enforced lint with `arc lint --everything`.
* Enable line length warnings in arc lint. [Jeff Verkoeyen](https://github.com/jverkoey)
* Added script to run pod install on all pods. [Randall Li](https://github.com/randallli)
* Fix build breakage in MDCCatalog.
* [FlexibleHeader] Removed redundant APIs from MDCFlexibleHeaderContainerViewController. [Jeff Verkoeyen](https://github.com/jverkoey)
* Increasing our warnings coverage. [Jeff Verkoeyen](https://github.com/jverkoey)


##### Bug Fixes

* [scripts/gendocs.sh] Ensure that doc assets show up in jazzy output. [peterfriese](https://github.com/peterfriese)
* [MDCSlider] Fixed to [issue](https://github.com/google/material-components-ios/issues/128) that
  was causing the slider to disappear when disabled. [Randall Li](https://github.com/randallli)
* Ensure that all private directory references are lower-cased. [Jeff Verkoeyen](https://github.com/jverkoey)
* [MDCSlider] fixed disabled state so it has the mask around the thumb.
  [Randall Li](https://github.com/randallli)
* MaterialComponentsUnitTests.podspec depends on MaterialComponents. [Jeff Verkoeyen](https://github.com/jverkoey)
* [PageControl] Add missing ss.resource_bundles to the podspec.
* [Various] Fixed floating-point conversion warnings with Xcode 6 release mode.
  [ajsecord](https://github.com/ajsecord)
* [Typography] Add CoreText dependency.


## 1.0.1

##### Enhancements

* [Switch] Removed internal docs that were pretending to be public docs. [Jeff Verkoeyen](https://github.com/jverkoey)

## 1.0.0

##### Breaking

* [MDCFlexibleHeaderView] Removed `shadowIntensity` property, use setShadowLayer:intensityDidChangeBlock: instead. [Jeff Verkoeyen](https://github.com/jverkoey)
* [MDCInkTouchControllerDelegate] Renamed `inkTouchControllerShouldProcessInkTouches:` to `inkTouchController:shouldProcessInkTouchesAtTouchLocation:`. [Chris Cox](https://github.com/chriscox)

##### Deprecations

* MDCFlexibleHeaderParentViewController, +[MDCFlexibleHeaderViewController addToParent], and
  -[MDCFlexibleHeaderViewController addFlexibleHeaderViewToParentViewControllerView]. These APIs
  are being deprecated in favor of the eventual equivalent AppBar convenience APIs. In the meantime
  the FlexibleHeader will need to be instantiated and configured like a typical UIViewController.

##### Enhancements

* [MDCFlexibleHeaderView] Added setShadowLayer:intensityDidChangeBlock:. [Jeff Verkoeyen](https://github.com/jverkoey)
* [MDCHeaderStackView] Added MDCHeaderStackView. [Jeff Verkoeyen](https://github.com/jverkoey)
* [MDCSlider] Changed default color. [Randall Li](https://github.com/randallli)
* [MDCSlider] Readme.md copy edits. [Randall Li](https://github.com/randallli)
* [MDCSwitch] Readme.md copy edits. [Randall Li](https://github.com/randallli)
* [MDCTypograpy:example] Refactored to be compatible with catalog by convention [Randall Li](https://github.com/randallli)
* [Shrine] First pass at a new Swift demo app, "Shrine". [Junius Gunaratne](https://github.com/jgunaratne)

##### Bug Fixes

* Fixed issue where MDCShadowLayer would ghost behind the MDCFlexibleHeaderView. [Jeff Verkoeyen](https://github.com/jverkoey)

## 0.2.1

##### Bug Fixes

* Bumped CocoaPod version numbers. [Adrian Secord](https://github.com/ajsecord)

## 0.2.0

##### Enhancements

* [MDCButton] Component added. [Randall Li](https://github.com/randallli), [Adrian Secord](https://github.com/ajsecord)
* [MDCSlider] Add support for interface builder to MDCSlider. [Ian Gordon](https://github.com/ianegordon)
* [MDCFlexibleHeader] Add contentView and custom shadow layers. [Junius Gunaratne](https://github.com/jgunaratne)
* [MDCSwitch] Autolayout demo app. [Ian Gordon](https://github.com/ianegordon)
* [MDCFlexibleHeader] Component added. [Jeff Verkoeyen](https://github.com/jverkoey)
* [Catalog] Add "catalog by convention" experiment. [Jeff Verkoeyen](https://github.com/jverkoey)
* [MDCSwitch] Switch from IBInspectable to UI_APPEARANCE_SELECTOR. [Ian Gordon](https://github.com/ianegordon)

##### Bug Fixes

* [CocoaPods] Remove private_header_files from podspec. [Jeff Verkoeyen](https://github.com/jverkoey)
* [Pesto] Fixes to Pesto example app. [Junius Gunaratne](https://github.com/jgunaratne)
* [MDCInk] Update background opacity timing to match web implementation of ink. [Junius Gunaratne](https://github.com/jgunaratne)
* [MDCInk] Darken default ink to 12% opacity. [Adrian Secord](https://github.com/ajsecord)
* [MDCInk] Make sure completion block is fired after ink animation completes [Junius Gunaratne](https://github.com/jgunaratne)

## x.x.x

This is a template. When cutting a new release, rename "master" to the release number and create a
new, empty "Master" section.

##### Breaking

##### Enhancements

##### Bug Fixes

* This is a template description
[person responsible](https://github.com/...)
[#xxx](github.com/google/material-components-ios/issues/xxx)
