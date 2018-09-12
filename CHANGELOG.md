# 63.0.0

This major release adds additional support for shape theming to BottomSheet and Cards and
improvements to ActionSheets, BottomAppBar, BottomNavigation, Dialogs, NavigationBar, and
TextFields.

## Breaking changes

### Cards

* [**Breaking**:  Add a card shape themer (#5031)](https://github.com/material-components/material-components-ios/commit/c036e22a7dde0c2c970e380123334f870cdabaae) (Yarden Eitan)

This is a breaking change due to the addition of the `shapeScheme` property to the MDCCardScheming
protocol. If you have created a type that conforms to MDCCardScheming you will need to implement the
`shapeScheme` property now as well.

## New features

ActionSheet's `backgroundColor` can now be customized.

BottomAppBar has a new surface variant color themer. Example:

```swift
MDCBottomAppBarColorThemer.applySurfaceVariant(withSemanticColorScheme: colorScheme,
                                               to: bottomBarView)
```

BottomNavigation now allows you to fetch a view for a given item using the new `viewForItem:` API.

BottomSheet and Cards each now have a Shape themer.

NavigationBar now allows you to set a different tint color for the leading and trailing items.

## API changes

### ActionSheet

#### MDCActionSheetController

*modified* property: `backgroundColor` in `MDCActionSheetController`

| Type of change: | Declaration |
|---|---|
| From: | `@property(nonatomic, nonnull, strong) UIColor *backgroundColor` |
| To: | `@property (readwrite, strong, nonatomic, nonnull) UIColor *backgroundColor;` |

### BottomAppBar+ColorThemer

#### MDCBottomAppBarColorThemer

*new* class method: `+applySurfaceVariantWithSemanticColorScheme:toBottomAppBarView:` in `MDCBottomAppBarColorThemer`

### BottomAppBar

#### MDCBottomAppBarView

*new* property: `trailingBarItemsTintColor` in `MDCBottomAppBarView`

*new* property: `leadingBarItemsTintColor` in `MDCBottomAppBarView`

### BottomNavigation

#### MDCBottomNavigationBar

*new* method: `-viewForItem:` in `MDCBottomNavigationBar`

### BottomSheet+ShapeThemer

**New extension.**

### Cards+CardThemer

#### MDCCardScheme

*new* property: `shapeScheme` in `MDCCardScheme`

#### MDCCardScheming

*new* property: `shapeScheme` in `MDCCardScheming`

### Cards+ShapeThemer

**New extension.**

### NavigationBar

#### MDCNavigationBar

*new* property: `leadingBarItemsTintColor` in `MDCNavigationBar`

*new* property: `trailingBarItemsTintColor` in `MDCNavigationBar`

### ShapeScheme

**New component.**

## Component changes

### ActionSheet

* [Add background color (#5081)](https://github.com/material-components/material-components-ios/commit/888425256f5496f3d7fb6eb7466a69f47d7e75d9) (Cody Weaver)
* [Fix Swift imports. (#5072)](https://github.com/material-components/material-components-ios/commit/6bc8e40fd70e0504c2dbc711f6402251c80fd12c) (Robert Moore)
* [Remove import (#5082)](https://github.com/material-components/material-components-ios/commit/8e2f8a3683e99cf41537fc6d6b0d19d4faf237d8) (Cody Weaver)
* [Update cell image alpha (#5088)](https://github.com/material-components/material-components-ios/commit/b1d27c9256f8027c079285fffb6be1694514adae) (Cody Weaver)

### BottomAppBar

* [Examples use semantic color scheme. (#5070)](https://github.com/material-components/material-components-ios/commit/378f90dc6e4ef4b62fbda187b7b218fda9a49955) (Robert Moore)
* [Add surface variant color themer. (#5068)](https://github.com/material-components/material-components-ios/commit/1ce4467321661243e984bb4dcf7a213d2120edfe) (Robert Moore)
* [Correct cut-out arc angle. (#4997)](https://github.com/material-components/material-components-ios/commit/baa001b59bac15b046f6792d6c83fcda5d42c4b1) (Robert Moore)
* [Tint leading, trailing bar items. (#5065)](https://github.com/material-components/material-components-ios/commit/1ae450095f19ed119d12a183cda98df628ff4733) (Robert Moore)

### BottomNavigation

* [Expose UIView for a given UITabBarItem. (#5061)](https://github.com/material-components/material-components-ios/commit/388a057ad572911088e9a85b9787238dbf34df02) (andrewplai)

### BottomSheet

* [Addition of a Bottom Sheet Shape Themer (#5062)](https://github.com/material-components/material-components-ios/commit/3dc5721da30f7962e939a2dcf9252c511e98bfbf) (Yarden Eitan)
* [Integrating the BottomSheet shape themer in the example (#5078)](https://github.com/material-components/material-components-ios/commit/66b9afbdafc61d597343d4beb24e29d2ba6eca9b) (Yarden Eitan)
* [[ShapeLibrary] Make the new CornerTreatment initializers use concrete types (#5076)](https://github.com/material-components/material-components-ios/commit/c01cd70170f695fd6116e46b8c567bd97e910cdc) (Yarden Eitan)
* [[Shapes] merge MDCShapeCorner and MDCCornerTreatment into one (#5090)](https://github.com/material-components/material-components-ios/commit/75ddb21ed0aab3a286663ab99fec79284b159ed5) (Yarden Eitan)

### Cards

* [[Shapes] merge MDCShapeCorner and MDCCornerTreatment into one (#5090)](https://github.com/material-components/material-components-ios/commit/75ddb21ed0aab3a286663ab99fec79284b159ed5) (Yarden Eitan)
* [added shape theming to card examples (#5059)](https://github.com/material-components/material-components-ios/commit/16c384197856993f0c0f8d32491c2b9b55af05ae) (Yarden Eitan)

### Dialogs

* [Add Header trait to title in AlertControllerView (#5032)](https://github.com/material-components/material-components-ios/commit/f97d5ff971733aed8b8f51337920c999af386676) (SaidinWoT)
* [Revert "Remove use of MDCFlatButton for MDCButton and MDCTextButtonThemer (#4739)" (#5040)](https://github.com/material-components/material-components-ios/commit/1e51e972495e0fa5e6ef95b75758980c1e706bd9) (Cody Weaver)

### FlexibleHeader

* [Extract safe area logic to a separate object. (#4987)](https://github.com/material-components/material-components-ios/commit/b8090cb6382910cc4190c7030739e145f3856929) (featherless)

### HeaderStackView

* [Remove "+Extensions" pod installation instructions from component readmes (#5080)](https://github.com/material-components/material-components-ios/commit/53dfaa3e48a2f306ad043d6d7febbf714213682f) (Andrew Overton)

### Ink

* [Remove "+Extensions" pod installation instructions from component readmes (#5080)](https://github.com/material-components/material-components-ios/commit/53dfaa3e48a2f306ad043d6d7febbf714213682f) (Andrew Overton)
* [Update example description to only have one space (#5018)](https://github.com/material-components/material-components-ios/commit/8078a2c63986743c4bcb5373012d2019be0b7bb5) (Cody Weaver)

### List

* [Updated List Readme to mention MDCSelfSizingStereoCell (#5092)](https://github.com/material-components/material-components-ios/commit/33723bbf772b08abf6b6b3273e967915e4d01d1f) (Andrew Overton)

### MaskedTransition

* [Update Swift example to use MDCFloatingButton (#5028)](https://github.com/material-components/material-components-ios/commit/9684ff485b4420c1e380d567e930fc3f338d1cb7) (Cody Weaver)

### NavigationBar

* [Tint leading, trailing button bars. (#5064)](https://github.com/material-components/material-components-ios/commit/ed819a830492b8be758bd45cad7efee4f49b07a5) (Robert Moore)
* [Update layout when button bar sizes change. (#4992)](https://github.com/material-components/material-components-ios/commit/32fe4e191a0aadea4235aebf9b16ef6e38820714) (featherless)

### NavigationDrawer

* [Fix Swift imports in examples. (#5096)](https://github.com/material-components/material-components-ios/commit/aef3cc73afd984735018897cfad2e0011095c3b7) (Robert Moore)

### TextFields

* [Get rid of "," separator in MDCTextField accessibilityValue (#5098)](https://github.com/material-components/material-components-ios/commit/e2cad8f8dcd313e7b45e337ea90592b0a84fcf94) (Andrew Overton)

### schemes/Shape

* [[ShapeLibrary] Make the new CornerTreatment initializers use concrete types (#5076)](https://github.com/material-components/material-components-ios/commit/c01cd70170f695fd6116e46b8c567bd97e910cdc) (Yarden Eitan)
* [[Shapes] Initial Shape Scheme implementation (#5014)](https://github.com/material-components/material-components-ios/commit/97b830a1e32f56402dcd0a6d57b2a185fe1368bf) (Yarden Eitan)
* [[Shapes] merge MDCShapeCorner and MDCCornerTreatment into one (#5090)](https://github.com/material-components/material-components-ios/commit/75ddb21ed0aab3a286663ab99fec79284b159ed5) (Yarden Eitan)

---

# 62.2.0

This hotfix minor release rolls back a behavioral change in Dialogs that was introduced in v60.0.0.

## Component changes

### Dialogs

* [Revert "Remove use of MDCFlatButton for MDCButton and MDCTextButtonThemer (#4739)" (#5040)](https://github.com/material-components/material-components-ios/commit/93c73b9052fd1fbb565583cf76fdf0ac3fccc2b3) (Cody Weaver)

---

# 62.1.0

This minor release introduces a new auto-sizing List cell implementation, improvements to
ActionSheet, the ability to modify casing behavior on NavigationBar, and bug fixes.

## New features

You can now set an accessibilityIdentifier on ActionSheet actions:

```swift
let action = MDCActionSheetAction(title: "Title", image: nil, handler: nil)
action.accessibilityIdentifier = "Some identifier"
actionSheet.addAction(action)
```

ActionSheet now has a typography themer.

ButtonBar now provides a mechanism for reacting to size changes of its buttons via its delegate.

There is a new [self-sizing collection view cell](https://github.com/material-components/material-components-ios/pull/4953).

NavigationBar exposes a new `uppercasesButtonTitles` property that can be used to change the
auto-uppercasing behavior of the buttons. By default this property is enabled.

## API changes

### ActionSheet

#### MDCActionSheetAction

*new* property: `accessibilityIdentifier` in `MDCActionSheetAction`

*modified* class: `MDCActionSheetAction`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCActionSheetAction : NSObject, NSCopying` |
| To: | `class MDCActionSheetAction : NSObject, NSCopying, UIAccessibilityIdentification` |

*modified* class: `MDCActionSheetAction`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCActionSheetAction : NSObject <NSCopying>` |
| To: | `@interface MDCActionSheetAction     : NSObject <NSCopying, UIAccessibilityIdentification>` |

#### MDCActionSheetController

*new* property: `transitionController` in `MDCActionSheetController`

### ActionSheet+TypographyThemer

**New component.**

### ButtonBar

#### MDCButtonBarDelegate

*new* method: `-buttonBarDidInvalidateIntrinsicContentSize:` in `MDCButtonBarDelegate`

#### MDCButtonBar

*new* property: `uppercasesButtonTitles` in `MDCButtonBar`

*new* property: `delegate` in `MDCButtonBar`

### FlexibleHeader+CanAlwaysExpandToMaximumHeight

**New component.**

## General changes

* [updated to newest CbC standard (#4956)](https://github.com/material-components/material-components-ios/commit/3480c50c67205018688e2a24d76cf19474d5dfee) (Yarden Eitan)

## Component changes

### ActionSheet

* [Add accessibility identifier (#4944)](https://github.com/material-components/material-components-ios/commit/6cd0f771a6f17255276810baa2fc4f5c8625793e) (Cody Weaver)
* [Add example with too many options to fit on screen (#4946)](https://github.com/material-components/material-components-ios/commit/77fc2f759c948d067353d4abaabc9692b6521fbd) (Cody Weaver)
* [Add scrim accessibility properties. (#4919)](https://github.com/material-components/material-components-ios/commit/f76df19f1288448c5459419cbbd334fb91203c55) (Cody Weaver)
* [Add typography themer (#4966)](https://github.com/material-components/material-components-ios/commit/05d4be9e43aad09706cab49f04085802f6ec12d5) (Cody Weaver)
* [Always show first option (#4963)](https://github.com/material-components/material-components-ios/commit/0d1f5148e83477927caa5cec2d0b15f05d1afc24) (Cody Weaver)
* [Make ActionSheet not presentable. (#4995)](https://github.com/material-components/material-components-ios/commit/a2b6a606590bcb00e76c775d3be87622d6eccf9f) (Robert Moore)
* [Update test to guard against silent fail (#4969)](https://github.com/material-components/material-components-ios/commit/e8c688617b98d6cb6d3b22944d4bc6a8fae87d3b) (Cody Weaver)

### BottomAppBar

* [Use the height of bottom app bar as the contentInset of table view (#4928)](https://github.com/material-components/material-components-ios/commit/53fe4771d07f7eb55cd00ced4ea26379f71d5617) (Wenyu Zhang)

### BottomNavigation

* [Update ripple color for unselected items. (#4950)](https://github.com/material-components/material-components-ios/commit/09505ec92096171c4735855acf9a19c6a955aaae) (Robert Moore)

### ButtonBar

* [Add a buttonBarDidInvalidateIntrinsicContentSize API to the delegate. (#4932)](https://github.com/material-components/material-components-ios/commit/471936b842e7473e51b5dc02df619a7e67a0c5b2) (featherless)
* [Add uppercasesButtonTitles API for modifying title casing behavior. (#4935)](https://github.com/material-components/material-components-ios/commit/5d0e7ccfa8c9ed2e7258b5d8b94cba6141f4ec77) (featherless)

### FlexibleHeader

* [Add buttons to the configurator demo for shifting the header on/off-screen. (#4979)](https://github.com/material-components/material-components-ios/commit/349c1915a37f8b2275f270fccce4f5567a47cee1) (featherless)
* [Add new canAlwaysExpandToMaximumHeight behavior. (#4978)](https://github.com/material-components/material-components-ios/commit/3b34e97f5b9ac335364933e96e1d5e57f04fd3a3) (featherless)
* [Revert "Add new canAlwaysExpandToMaximumHeight behavior. (#4794)" (#4976)](https://github.com/material-components/material-components-ios/commit/66b8a7edfe65eb57b19e11e06155c4d6179622a0) (featherless)
* [updated to newest CbC standard (#4956)](https://github.com/material-components/material-components-ios/commit/3480c50c67205018688e2a24d76cf19474d5dfee) (Yarden Eitan)

### List

* [Add Self Sizing Stereo Cell (#4953)](https://github.com/material-components/material-components-ios/commit/cf0997183147a595d363adfaae9aa8086fda9ad9) (Andrew Overton)

### NavigationBar

* [Add uppercasesButtonTitles API for modifying title casing behavior. (#4936)](https://github.com/material-components/material-components-ios/commit/059cbfaebb726a9fa2a91c3da78de460ce8c0434) (featherless)

### ProgressView

* [Address progress view example problems with safe area insets and impr… (#4895)](https://github.com/material-components/material-components-ios/commit/19372e3cdec5f426359a7ce6a351b85ed09c1e75) (Andrew Overton)

### ShadowElevations

* [[Catalog] Avoid cropping on the ShadowLayer example (#4884)](https://github.com/material-components/material-components-ios/commit/5986e38b84e60f4c5a8d3b44993dd2a7685a3e0d) (Wenyu Zhang)

### Tabs

* [fix TabBarViewControllerExample to respect safe area (#4949)](https://github.com/material-components/material-components-ios/commit/4b00a6c745c853114769a0de5773e5b28183a279) (Wenyu Zhang)

### TextFields

* [Specify textRect origin according to UIUserInterfaceLayoutDirection (#4974)](https://github.com/material-components/material-components-ios/commit/adc0a4c3c6b529d04f4dc4c301d6d8867267f6fe) (Andrew Overton)

---

# 62.0.0

This major release reverts the addition of the new canAlwaysExpandToMaximumHeight behavior for the FlexibleHeader introduced in v61.0.0. More details on the commit that was reverted: https://github.com/material-components/material-components-ios/commit/2b3722f7b8cc7df131a8b33695990c99931c0e1b 

### FlexibleHeader

#### Changes

* [Revert "Add new canAlwaysExpandToMaximumHeight behavior. (#4794)"](https://github.com/material-components/material-components-ios/commit/0ea7bf01ee434388b7d047306a3df390c944e49a) (Yarden Eitan)

---

# 61.0.0

In this breaking release we drop support for Xcode 8 and landed two new components in an Alpha state (not ready for clients to use yet).

## Breaking changes

No longer support Xcode 8.

## New deprecations

* `-buttonBar:viewForItem:layoutHints:` in `MDCButtonBarDelegate`

## New features

### More accessibility APIs

*new* property:  `accessibilityIdentifier` in `MDCAlertAction` 
*new* property: `accessibilityHint` in `MDCSnackbarMessageView`
*new* property: `accessibilityLabel` in `MDCSnackbarMessageView`
*new* property: `accessibilityHint` in `MDCSnackbarMessage`

### Alpha components

* ActionSheets

ActionSheets present a list of actions from the bottom of the screen.

* NavigationDrawer

NavigationDrawer provides a container that presents from the bottom of the screen and also responds
to drag gestures to flick to full screen, half screen or off screen.

## API changes

### ActionSheet

**New component.**

### ButtonBar

#### MDCButtonBarDelegate

*modified* method: `-buttonBar:viewForItem:layoutHints:` in `MDCButtonBarDelegate`

| Type of change: | Deprecation message |
|---|---|
| From: | `` |
| To: | `There will be no replacement for this API.` |

*modified* method: `-buttonBar:viewForItem:layoutHints:` in `MDCButtonBarDelegate`

| Type of change: | Swift declaration |
|---|---|
| From: | `func buttonBar(_ buttonBar: MDCButtonBar, viewForItem barButtonItem: Any!, layoutHints: Any!) -> Any!` |
| To: | `optional func buttonBar(_ buttonBar: MDCButtonBar, viewForItem barButtonItem: Any!, layoutHints: Any!) -> Any!` |

### Dialogs

#### MDCAlertAction

*new* property: `accessibilityIdentifier` in `MDCAlertAction`

*modified* class: `MDCAlertAction`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCAlertAction : NSObject <NSCopying>` |
| To: | `@interface MDCAlertAction : NSObject <NSCopying, UIAccessibilityIdentification>` |

### FlexibleHeader+CanAlwaysExpandToMaximumHeight

**New component.**

### NavigationBar

#### MDCNavigationBar

*modified* property: `titleTextAttributes` in `MDCNavigationBar`

| Type of change: | Declaration |
|---|---|
| From: | `@property(nonatomic, copy, nullable)     NSDictionary<NSAttributedStringKey, id> *titleTextAttributes` |
| To: | `@property (readwrite, copy, nonatomic, nullable)     NSDictionary<NSAttributedStringKey, id> *titleTextAttributes;` |

### NavigationDrawer

**New component.**

### Snackbar

#### MDCSnackbarMessageView

*new* property: `accessibilityHint` in `MDCSnackbarMessageView`

*new* property: `accessibilityLabel` in `MDCSnackbarMessageView`

#### MDCSnackbarMessage

*new* property: `accessibilityHint` in `MDCSnackbarMessage`

#### MDCSnackbarMessageView()

*new* category: `MDCSnackbarMessageView()`

*removed* category: `MDCSnackbarMessageView()`

*modified* property: `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(ext)MDCSnackbarMessageView@MDCSnackbarMessageView.h@3125` |
| To: | `c:objc(ext)MDCSnackbarMessageView@MDCSnackbarMessageView.h@3411` |

## Component changes

### Tabs

#### Changes

* [Fix Tab Bar theming and background color issue (#4841)](https://github.com/material-components/material-components-ios/commit/d60637ab7171ce74fba3770cdb268681573dbdb6) (Wenyu Zhang)
* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### AppBar

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)
* [Use objc_subclassing_restricted attributes directly instead of a macro (#4876)](https://github.com/material-components/material-components-ios/commit/353829de95b323a4cf8d9c2c378b020663ea163d) (featherless)
* [[FlexibleHeader] Add a note regarding the need to clear trackingScrollView. (#4877)](https://github.com/material-components/material-components-ios/commit/2a8d0db067bfa72c455e1e1bfae08dcedbcae18b) (featherless)

### Ink

#### Changes

* [Fix demo being clipped by safe area issue (#384)](https://github.com/material-components/material-components-ios/commit/44ca45ceb001705709ea7613ed06afe828752559) (Wenyu Zhang)

### ActionSheet

#### Changes

* [Add Action sheet (#4830)](https://github.com/material-components/material-components-ios/commit/1f4b8e0789066dfda94fb9e4bc0aa8c11b418985) (Cody Weaver)
* [Update header to support RTL (#4926)](https://github.com/material-components/material-components-ios/commit/63eeff1d3020615d8be5f088887a2a7b7ec4dbec) (Cody Weaver)
* [add missing .jazzy.yaml files (#4939)](https://github.com/material-components/material-components-ios/commit/7aee1fb68acbac5e80220a3d00d79d6bf41edadc) (Yarden Eitan)

### CollectionCells

#### Changes

* [Support more than three lines in MDCCollectionViewTextCell? (#4718)](https://github.com/material-components/material-components-ios/commit/69833582670c2b639653a01740532626d40b7ed3) (Andrew Overton)

### Buttons

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### ButtonBar

#### Changes

* [Add support for pure Swift class button invocations. (#4878)](https://github.com/material-components/material-components-ios/commit/bc6dfc007f5fd01ff560423f506398b8187bca58) (featherless)
* [Annotate MDCButtonBarDelegate's only API as deprecated. (#4931)](https://github.com/material-components/material-components-ios/commit/aa2b2189d28d861da99785bbe7bb5e9daaf55f87) (featherless)
* [Remove unnecessary ColorThemer dependency on NavigationBar. (#4885)](https://github.com/material-components/material-components-ios/commit/f6db581e01a41a335df4b82318454705c8654e05) (featherless)
* [[ButtonBar|NavigationBar] Remove custom iPad heights. (#4874)](https://github.com/material-components/material-components-ios/commit/e89ece3bb8a46cd6ff123f4fe1c3f0527c096a4a) (featherless)

### TextFields

#### Changes

* [Do not set placeholderLabel.textColor to active color while editing with non-floating placeholder (#4850)](https://github.com/material-components/material-components-ios/commit/281392db6b7427a38695d5ff016ee80b66a96bea) (Andrew Overton)
* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### Chips

#### Changes

* [Make collectionView in Chip Demo respect safe area (#4896)](https://github.com/material-components/material-components-ios/commit/1ccd86a256d5a8dfa43caa5677adb5a904f77cbc) (Wenyu Zhang)
* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### Snackbar

#### Changes

* [API to set `accessibilityHint`. (#4924)](https://github.com/material-components/material-components-ios/commit/ed0b0efe2cabaa7b7a209d376a80388e9c22d31d) (Robert Moore)
* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### NavigationDrawer

#### Changes

* [Adding the navigation drawer component (#4886)](https://github.com/material-components/material-components-ios/commit/b2d17e1ed6e360a12408f0fa371a8369be6e463c) (guylivneh)
* [Initial doc write-up of overview, and usage. (#4927)](https://github.com/material-components/material-components-ios/commit/358050f1c3fbc8e712fbc06f192e8881405c99e3) (Yarden Eitan)

### BottomAppBar

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### Slider

#### Changes

* [Respect safe area (#4912)](https://github.com/material-components/material-components-ios/commit/f3e218320494da47911c1412c24a2089c00d63a5) (Cody Weaver)
* [Update examples for safeAreaInsets and schemes (#4897)](https://github.com/material-components/material-components-ios/commit/a5a8ba0c74f26130411753f1a4653f45ec82b213) (Cody Weaver)

### NavigationBar

#### Changes

* [Add a flag that makes it possible to set any font size. (#4879)](https://github.com/material-components/material-components-ios/commit/56e8c4fd27add570a2711198bc87f682dc31d7b2) (featherless)
* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)
* [[ButtonBar|NavigationBar] Remove custom iPad heights. (#4874)](https://github.com/material-components/material-components-ios/commit/e89ece3bb8a46cd6ff123f4fe1c3f0527c096a4a) (featherless)

### LibraryInfo

#### Changes

* [Use objc_subclassing_restricted attributes directly instead of a macro (#4876)](https://github.com/material-components/material-components-ios/commit/353829de95b323a4cf8d9c2c378b020663ea163d) (featherless)

### ShadowLayer

#### Changes

* [Add dragon demonstrating cornerRadius changes aren't rendering (#4849)](https://github.com/material-components/material-components-ios/commit/cc3c77866f68a8e1de9679642195756574753d21) (ianegordon)

### List

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)
* [add missing .jazzy.yaml files (#4939)](https://github.com/material-components/material-components-ios/commit/7aee1fb68acbac5e80220a3d00d79d6bf41edadc) (Yarden Eitan)

### ActivityIndicator

#### Changes

* [Fix activity indicator layout by autoresizingMask (#4913)](https://github.com/material-components/material-components-ios/commit/91e103f8cadbe9d242cb56f1018969784c29ce38) (Wenyu Zhang)
* [Use objc_subclassing_restricted attributes directly instead of a macro (#4876)](https://github.com/material-components/material-components-ios/commit/353829de95b323a4cf8d9c2c378b020663ea163d) (featherless)

### BottomSheet

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### Typography

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### Dialogs

#### Changes

* [Add accessibilityIdentifier to Actions. (#4917)](https://github.com/material-components/material-components-ios/commit/823776e6ba58592f772c8ed61bd6993875d0628c) (Robert Moore)
* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### BottomNavigation

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### PageControl

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### AnimationTiming

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### Collections

#### Changes

* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

### FlexibleHeader

#### Changes

* [Add a note regarding the need to clear trackingScrollView. (#4877)](https://github.com/material-components/material-components-ios/commit/2a8d0db067bfa72c455e1e1bfae08dcedbcae18b) (featherless)
* [Add new canAlwaysExpandToMaximumHeight behavior. (#4794)](https://github.com/material-components/material-components-ios/commit/2b3722f7b8cc7df131a8b33695990c99931c0e1b) (featherless)
* [Remove all __IPHONE_11_0 checks now that we no longer support Xcode 8. (#4915)](https://github.com/material-components/material-components-ios/commit/bbe4a23fe049f71e6e8d75f34ece82dee72f2dfb) (featherless)

---

# 60.3.0

This minor release introduces a new behavioral flag for changing the title font size on
MDCNavigationBar.

## New features

MDCNavigationBar has a new flag that, once enabled, allows you to set a font with any size.

```objc
MDCNavigationBar *navigationBar = [[MDCNavigationBar alloc] init];
navigationBar.allowAnyTitleFontSize = YES;
UIFont *font = [UIFont systemFontOfSize:24];
navigationBar.titleFont = font; // Font size will actually be 24
```

## API changes

### NavigationBar

#### MDCNavigationBar

*new* property: `allowAnyTitleFontSize` in `MDCNavigationBar`

## Component changes

### NavigationBar

#### Changes

* [Add a flag that makes it possible to set any font size. (#4879)](https://github.com/material-components/material-components-ios/commit/86f7e7a405e4f7ac7bd6948f4c661abf3e27e249) (featherless)

---

# 60.2.0

In this minor release we updated examples imports, added an API to set the ink color of buttons
and started the deprecation of some AppBar APIs.

## New deprecations

* Deprecated `MDCAppBarTextColorAccessibilityMutator`.

## Will be deprecated

### FlexibleHeader

* [minMaxHeightIncludesSafeArea](https://github.com/material-components/material-components-ios/issues/4764)

## New features

* AlertController got a new buttonInkColor property so you can specify the color of the ink.
```
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  alert.buttonInkColor = testColor;
```

## API changes

### AppBar

#### MDCAppBarTextColorAccessibilityMutator

*deprecated* class: `MDCAppBarTextColorAccessibilityMutator`

*deprecated* method: `-mutate:` in `MDCAppBarTextColorAccessibilityMutator`

### Dialogs

#### MDCAlertController

*new* property: `buttonInkColor` in `MDCAlertController`

#### MDCAlertControllerView

*new* property: `buttonInkColor` in `MDCAlertControllerView`

### FlexibleHeader

#### MDCFlexibleHeaderView()

*moved* category: `MDCFlexibleHeaderView()`

*modified* property: `contentView` in `MDCFlexibleHeaderView()`

## Component changes

### MaskedTransition

#### Changes

* [Fix Swift imports (#4828)](https://github.com/material-components/material-components-ios/commit/b917bf24d60029d76bf29114a2c1526793dfe6b1) (Robert Moore)

### FeatureHighlight

#### Changes

* [Fix crash when backgrounding and re-opening app. (#4796)](https://github.com/material-components/material-components-ios/commit/44bed97140da63cee922b70bcfd152ebfc984c13) (Andrew Overton)

### AppBar

#### Changes

* [Make migration links be actual links (#4808)](https://github.com/material-components/material-components-ios/commit/4efe02d07a4d49a474acb3e4495fa61073550d57) (featherless)
* [Mark MDCAppBarTextColorAccessibilityMutator as deprecated. (#4807)](https://github.com/material-components/material-components-ios/commit/8c394dc2728eb9d107fbed705932acb4fed8aa80) (featherless)

### Buttons

#### Changes

* [fix the text overlapping safeArea issue on](https://github.com/material-components/material-components-ios/commit/2444107e30b81d921b650208373fa4c6c4239ae1) (Wenyu Zhang)

### TextFields

#### Changes

* [Trigger layout pass to update borderView.borderLayer (#4815)](https://github.com/material-components/material-components-ios/commit/13bff72b262ffb521432a80665db3727fc4dcbe5) (Andrew Overton)

### Chips

#### Changes

* [Example respects safe area (#4856)](https://github.com/material-components/material-components-ios/commit/6e6a6bf827908b7b78cb776c038b23d159d2996d) (Joe Aguilar)

### Cards

#### Changes

* [Fix Swift imports (#4826)](https://github.com/material-components/material-components-ios/commit/ae8fcb4e473a2beb9a55d1c3f99442c718244792) (Robert Moore)
* [Fix example IBOutlet (#4827)](https://github.com/material-components/material-components-ios/commit/bf099ab14fcf0d9222534cbf67f37ef7250c9a42) (Robert Moore)

### BottomAppBar

#### Changes

* [Fix typo in the readme (#4869)](https://github.com/material-components/material-components-ios/commit/215011b3866b47724553cde55b5239d057dc5455) (Brad Mallow)

### ShadowLayer

#### Changes

* [Revert "Setting the corner radius should recalculate the shadowPath (#4804)"](https://github.com/material-components/material-components-ios/commit/bd8a8153bc318365e2e76c42a7f6e16e76267ac0) (Ian Gordon)

### List

#### Changes

* [Fix Swift imports (#4828)](https://github.com/material-components/material-components-ios/commit/b917bf24d60029d76bf29114a2c1526793dfe6b1) (Robert Moore)

### ActivityIndicator

#### Changes

* [Default demo to .determinate (#4855)](https://github.com/material-components/material-components-ios/commit/7c6e16fe2569e9090bdfa4faa46e7d28df64ffd6) (Robert Moore)
* [Fix example conditional (#4843)](https://github.com/material-components/material-components-ios/commit/a3c3e78ebba6bf7613240667a9dc6314d8dae760) (Robert Moore)

### BottomSheet

#### Changes

* [Add Safe Area Handling Example (#4870)](https://github.com/material-components/material-components-ios/commit/1fea42b984a110ce2ea56d2becde8f87c726443b) (danblakemore)

### Dialogs

#### Changes

* [Adding 'buttonInkColor'  (#4847)](https://github.com/material-components/material-components-ios/commit/cce878a837097dc70526372e20b16ee2b1b13736) (Robert Moore)

### BottomNavigation

#### Changes

* [ Button for badge increment. (#4857)](https://github.com/material-components/material-components-ios/commit/7307a8c5c05e5f2a4e196267e34ccb9d65f22b54) (Robert Moore)

### AnimationTiming

#### Changes

* [Add button to start animation. (#4852)](https://github.com/material-components/material-components-ios/commit/f9515494f141c9d1be0be40a3b92c67b84004d64) (Robert Moore)

### HeaderStackView

#### Changes

* [Remove the header stack view examples. (#4811)](https://github.com/material-components/material-components-ios/commit/7a935a97221c3c1dadf345bb6d25d29abf5ffdd7) (featherless)

### FlexibleHeader

#### Changes

* [Add WKWebView considerations docs. (#4801)](https://github.com/material-components/material-components-ios/commit/70229421da62cc53a4cf7444e51d6c1f9f1a9d7e) (featherless)
* [Add a deprecation schedule for minMaxHeightIncludesSafeArea. (#4810)](https://github.com/material-components/material-components-ios/commit/caad377fc45fc5cf7e275bfa48014d38d2844b72) (featherless)
* [Fix bug where orientation changes would result in incorrect contentOffset. (#4860)](https://github.com/material-components/material-components-ios/commit/0fd07657752b600aa6512cfe0a0c5233802e5a19) (featherless)
* [Mark minMaxHeightIncludesSafeArea as to be deprecated. (#4809)](https://github.com/material-components/material-components-ios/commit/7cb8525e0ce77c4c511db034bf7494aac98f4a54) (featherless)

### ProgressView

#### Changes

* [Add 'animate' button to example. (#4863)](https://github.com/material-components/material-components-ios/commit/43b4f6dcd2d1c4178b0694c09e0d8ad677edc4b1) (Robert Moore)
* [Use schemes in example. (#4859)](https://github.com/material-components/material-components-ios/commit/5a10eeef514025023189a0e56b1f4b38e048120e) (Robert Moore)

---

# 60.1.0

## Component changes

### Tabs

#### Changes

* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### MaskedTransition

#### Changes

* [Update README.md (#4758)](https://github.com/material-components/material-components-ios/commit/2856ce9168a35eec9928730d8609f70735abc5bc) (trungducc)

### schemes/Color

#### Changes

* [Add schedule to the migration guide. (#4768)](https://github.com/material-components/material-components-ios/commit/1cec879955b81affe5c901c53bc6519e6449d30b) (featherless)
* [[Automated] Regenerate schemes/Color readme.](https://github.com/material-components/material-components-ios/commit/512cbe3725813075f08c8f669b9af9f5864a42e5) (Jeff Verkoeyen)

### FeatureHighlight

#### Changes

* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### AppBar

#### Changes

* [Add MDCAppBar migration guide. (#4762)](https://github.com/material-components/material-components-ios/commit/afca8fa6aaee07e13169a288b083c08547aa8357) (featherless)
* [Add deprecation schedule to the MDCAppBar migration guide. (#4802)](https://github.com/material-components/material-components-ios/commit/7cfd859f190997ed312ff353cf27fae34461dcc2) (featherless)
* [Annotate APIs as to-be-deprecated. (#4763)](https://github.com/material-components/material-components-ios/commit/d3faf7f4b7941b78185429efab3e89f34d7bc9ca) (featherless)
* [[Catalog] set cell selection style to none in several examples (#3870) (#4776)](https://github.com/material-components/material-components-ios/commit/980443d994d3ddc2aff779944aeaeb0e813dab20) (Wenyu Zhang)
* [Fix a bug with WKWebView as a tracking scroll view. (#4701)](https://github.com/material-components/material-components-ios/commit/4e658a5aee98b6d9664d6e890e40de5f68125494) (featherless)

### Buttons

#### Changes

* [Fix `safeAreaInsets` availability check (#4775)](https://github.com/material-components/material-components-ios/commit/c43677ace0c8610e40d025152c3d57cb44ccdf11) (Robert Moore)
* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### ButtonBar

#### Changes

* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### TextFields

#### Changes

* [Update placeholder and outline border color when enabling/disabling text fields with outline controllers (#4779)](https://github.com/material-components/material-components-ios/commit/efc3a86c5ec98789c0918545ab6ce1c184125196) (Andrew Overton)
* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### Snackbar

#### Changes

* [VoiceOver users can exit the snackbar (#4799)](https://github.com/material-components/material-components-ios/commit/acfbd580f48b661c990b609ced3327bda875d9a2) (Robert Moore)
* [[Catalog] Fix Snackbar crash after switching between LEGACY and NEW (#4700)](https://github.com/material-components/material-components-ios/commit/4ccb93cba97679a0b3debd0c46451296230e2371) (trungducc)
* [Add switch control focus control to snackbar when an action is in it (#4795)](https://github.com/material-components/material-components-ios/commit/2bfbe053c46d83d82fc899b12d815207f94c2010) (Yarden Eitan)

### NavigationBar

#### Changes

* [Update swift example to not depend on objc (#4784)](https://github.com/material-components/material-components-ios/commit/e018f4ab40039169c4eadb660b82283c5ec5256d) (Cody Weaver)
* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)
* [[Swift] Fix remaining imports (#4792)](https://github.com/material-components/material-components-ios/commit/8aeb618d1a96ebd22a6db4dcf99f269a7fbe0816) (Robert Moore)

### ActivityIndicator

#### Changes

* [[Catalog] set cell selection style to none in several examples (#3870) (#4776)](https://github.com/material-components/material-components-ios/commit/980443d994d3ddc2aff779944aeaeb0e813dab20) (Wenyu Zhang)

### Dialogs

#### Changes

* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### BottomNavigation

#### Changes

* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### PageControl

#### Changes

* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### AnimationTiming

#### Changes

* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

### HeaderStackView

#### Changes

* [Update swift example to not depend on obj-c example (#4783)](https://github.com/material-components/material-components-ios/commit/4c3814c2ab80ecbdeb1c153494b8e41ad3a6ad17) (Cody Weaver)
* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)
* [[Swift] Fix remaining imports (#4792)](https://github.com/material-components/material-components-ios/commit/8aeb618d1a96ebd22a6db4dcf99f269a7fbe0816) (Robert Moore)

### FlexibleHeader

#### Changes

* [Add minMaxHeightIncludesSafeArea migration guide. (#4767)](https://github.com/material-components/material-components-ios/commit/c1c2ddebbd493f4e3073d02133b509dfccb92ebc) (featherless)
* [Fix bug with WKWebView as a tracking scroll view. (#4701)](https://github.com/material-components/material-components-ios/commit/4e658a5aee98b6d9664d6e890e40de5f68125494) (featherless)
* [Fix infinite recursion when VoiceOver is enabled. (#4769)](https://github.com/material-components/material-components-ios/commit/f9304930ecf903457b1d7e317dbaf24dabf9a6c2) (featherless)
* [Fix property setter (#4771)](https://github.com/material-components/material-components-ios/commit/b2160889af2bbb9ee1e566614c2690edb54cb6ad) (ianegordon)
* [Move all shift behavior APIs to their own header. (#4778)](https://github.com/material-components/material-components-ios/commit/b49031be34b9031861362b99bb5a4e583658ad62) (featherless)

### ShadowElevations

#### Changes

* [Rewrite ShadowElevationsPointsLabel in Swift (#4782)](https://github.com/material-components/material-components-ios/commit/ac038bf996154e369c21a0efcc45221040e9afc0) (Robert Moore)
* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)
* [[Swift] Fix remaining imports (#4792)](https://github.com/material-components/material-components-ios/commit/8aeb618d1a96ebd22a6db4dcf99f269a7fbe0816) (Robert Moore)

### Palettes

#### Changes

* [[Catalog] Fix Swift example imports (#4780)](https://github.com/material-components/material-components-ios/commit/175942d9e0284b32041701fc545c21ef2240afe9) (Robert Moore)

---

# 60.0.0

This major release introduces a breaking change for Swift libraries using FlexibleHeader. This
change also introduces a migration guide for color schemes along, changes to the Snackbar's
singleton pattern, and updated button theming in Dialogs.

## Breaking changes

### FlexibleHeader

* [**Breaking** Make preferredStatusBarStyle settable. (#4750)](https://github.com/material-components/material-components-ios/commit/d3cc4e4ebe14c8bd4b25b258ba02f19cbdc7bc0b) (featherless)

This breaking change only affects Swift code and requires the following changes.

```swift
// Before
.preferredStatusBarStyle()

// After
.preferredStatusBarStyle
```

## New features

FlexibleHeader has a new `inferPreferredStatusBarStyle` API that allows you to set an explicity
`preferredStatusBarStyle` on the `MDCFlexibleHeaderViewController`.

An example of setting an explicit `preferredStatusBarStyle`:

```swift
flexibleHeaderViewController.inferPreferredStatusBarStyle = false
flexibleHeaderViewController.preferredStatusBarStyle = .lightContent
```

## Upcoming deprecations

`MDCColorScheme` and `MDCBasicColorScheme` will both be deprecated on the following timeline:

- October 10, 2018: Both APIs and any corresponding themer API will be deprecated.
- November 10, 2018: Both APIs and any corresponding themer API will be deleted.

[Learn more by reading the migration guide](https://github.com/material-components/material-components-ios/blob/develop/components/schemes/Color/docs/migration-guide-semantic-color-scheme.md).

## API changes

### ActivityIndicator+ColorThemer

#### MDCActivityIndicatorColorThemer(ToBeDeprecated)

*new* category: `MDCActivityIndicatorColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toActivityIndicator:` in `MDCActivityIndicatorColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCActivityIndicatorColorThemer` |
| To: | `c:objc(cy)MDCActivityIndicatorColorThemer@ToBeDeprecated` |

### AppBar+ColorThemer

#### MDCAppBarColorThemer(ToBeDeprecated)

*new* category: `MDCAppBarColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toAppBar:` in `MDCAppBarColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCAppBarColorThemer` |
| To: | `c:objc(cy)MDCAppBarColorThemer@ToBeDeprecated` |

### BottomAppBar+ColorThemer

#### MDCBottomAppBarColorThemer(ToBeDeprecated)

*new* category: `MDCBottomAppBarColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toBottomAppBarView:` in `MDCBottomAppBarColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCBottomAppBarColorThemer` |
| To: | `c:objc(cy)MDCBottomAppBarColorThemer@ToBeDeprecated` |

### BottomNavigation+ColorThemer

#### MDCBottomNavigationBarColorThemer(ToBeDeprecated)

*new* category: `MDCBottomNavigationBarColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toBottomNavigationBar:` in `MDCBottomNavigationBarColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCBottomNavigationBarColorThemer` |
| To: | `c:objc(cy)MDCBottomNavigationBarColorThemer@ToBeDeprecated` |

### ButtonBar+ColorThemer

#### MDCButtonBarColorThemer(ToBeDeprecated)

*new* category: `MDCButtonBarColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toButtonBar:` in `MDCButtonBarColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCButtonBarColorThemer` |
| To: | `c:objc(cy)MDCButtonBarColorThemer@ToBeDeprecated` |

### Buttons+ColorThemer

#### MDCButtonColorThemer(ToBeDeprecated)

*new* category: `MDCButtonColorThemer(ToBeDeprecated)`

*modified* class method: `+applySemanticColorScheme:toRaisedButton:` in `MDCButtonColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCButtonColorThemer` |
| To: | `c:objc(cy)MDCButtonColorThemer@ToBeDeprecated` |

*modified* class method: `+applySemanticColorScheme:toFlatButton:` in `MDCButtonColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCButtonColorThemer` |
| To: | `c:objc(cy)MDCButtonColorThemer@ToBeDeprecated` |

*modified* class method: `+applyColorScheme:toButton:` in `MDCButtonColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCButtonColorThemer` |
| To: | `c:objc(cy)MDCButtonColorThemer@ToBeDeprecated` |

*modified* class method: `+applySemanticColorScheme:toButton:` in `MDCButtonColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCButtonColorThemer` |
| To: | `c:objc(cy)MDCButtonColorThemer@ToBeDeprecated` |

*modified* class method: `+applySemanticColorScheme:toFloatingButton:` in `MDCButtonColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCButtonColorThemer` |
| To: | `c:objc(cy)MDCButtonColorThemer@ToBeDeprecated` |

### Chips+ColorThemer

#### MDCChipViewColorThemer(ToBeDeprecated)

*new* category: `MDCChipViewColorThemer(ToBeDeprecated)`

*modified* class method: `+applySemanticColorScheme:toStrokedChipView:` in `MDCChipViewColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCChipViewColorThemer` |
| To: | `c:objc(cy)MDCChipViewColorThemer@ToBeDeprecated` |

### Dialogs+ColorThemer

#### MDCAlertColorThemer(ToBeDeprecated)

*new* category: `MDCAlertColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:` in `MDCAlertColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCAlertColorThemer` |
| To: | `c:objc(cy)MDCAlertColorThemer@ToBeDeprecated` |

### FeatureHighlight+ColorThemer

#### MDCFeatureHighlightColorThemer(ToBeDeprecated)

*new* category: `MDCFeatureHighlightColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toFeatureHighlightView:` in `MDCFeatureHighlightColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCFeatureHighlightColorThemer` |
| To: | `c:objc(cy)MDCFeatureHighlightColorThemer@ToBeDeprecated` |

### FlexibleHeader+ColorThemer

#### MDCFlexibleHeaderColorThemer(ToBeDeprecated)

*new* category: `MDCFlexibleHeaderColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toFlexibleHeaderView:` in `MDCFlexibleHeaderColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCFlexibleHeaderColorThemer` |
| To: | `c:objc(cy)MDCFlexibleHeaderColorThemer@ToBeDeprecated` |

*modified* class method: `+applyColorScheme:toMDCFlexibleHeaderController:` in `MDCFlexibleHeaderColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCFlexibleHeaderColorThemer` |
| To: | `c:objc(cy)MDCFlexibleHeaderColorThemer@ToBeDeprecated` |

### FlexibleHeader

#### MDCFlexibleHeaderViewController

*new* property: `preferredStatusBarStyle` in `MDCFlexibleHeaderViewController`

*new* property: `inferPreferredStatusBarStyle` in `MDCFlexibleHeaderViewController`

*removed* method: `-preferredStatusBarStyle` in `MDCFlexibleHeaderViewController`

### HeaderStackView+ColorThemer

#### MDCHeaderStackViewColorThemer(ToBeDeprecated)

*new* category: `MDCHeaderStackViewColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toHeaderStackView:` in `MDCHeaderStackViewColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCHeaderStackViewColorThemer` |
| To: | `c:objc(cy)MDCHeaderStackViewColorThemer@ToBeDeprecated` |

### Ink+ColorThemer

#### MDCInkColorThemer(ToBeDeprecated)

*new* category: `MDCInkColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toInkView:` in `MDCInkColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCInkColorThemer` |
| To: | `c:objc(cy)MDCInkColorThemer@ToBeDeprecated` |

### NavigationBar+ColorThemer

#### MDCNavigationBarColorThemer(ToBeDeprecated)

*new* category: `MDCNavigationBarColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toNavigationBar:` in `MDCNavigationBarColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCNavigationBarColorThemer` |
| To: | `c:objc(cy)MDCNavigationBarColorThemer@ToBeDeprecated` |

### PageControl+ColorThemer

#### MDCPageControlColorThemer(ToBeDeprecated)

*new* category: `MDCPageControlColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toPageControl:` in `MDCPageControlColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCPageControlColorThemer` |
| To: | `c:objc(cy)MDCPageControlColorThemer@ToBeDeprecated` |

### ProgressView+ColorThemer

#### MDCProgressViewColorThemer(ToBeDeprecated)

*new* category: `MDCProgressViewColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toProgressView:` in `MDCProgressViewColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCProgressViewColorThemer` |
| To: | `c:objc(cy)MDCProgressViewColorThemer@ToBeDeprecated` |

### Slider+ColorThemer

#### MDCSliderColorThemer(ToBeDeprecated)

*new* category: `MDCSliderColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toSlider:` in `MDCSliderColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSliderColorThemer` |
| To: | `c:objc(cy)MDCSliderColorThemer@ToBeDeprecated` |

*modified* class method: `+defaultSliderLightColorScheme` in `MDCSliderColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSliderColorThemer` |
| To: | `c:objc(cy)MDCSliderColorThemer@ToBeDeprecated` |

*modified* class method: `+defaultSliderDarkColorScheme` in `MDCSliderColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSliderColorThemer` |
| To: | `c:objc(cy)MDCSliderColorThemer@ToBeDeprecated` |

### Snackbar+ColorThemer

#### MDCSnackbarColorThemer(Deprecated)

*new* category: `MDCSnackbarColorThemer(Deprecated)`

*modified* class method: `+applyColorScheme:toSnackbarMessageView:` in `MDCSnackbarColorThemer(Deprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarColorThemer` |
| To: | `c:objc(cy)MDCSnackbarColorThemer@Deprecated` |

### Snackbar

#### MDCSnackbarManager

*new* property: `defaultManager` in `MDCSnackbarManager`

*new* property: `messageTextColor` in `MDCSnackbarManager`

*new* method: `-suspendMessagesWithCategory:` in `MDCSnackbarManager`

*new* property: `buttonFont` in `MDCSnackbarManager`

*new* property: `snackbarMessageViewShadowColor` in `MDCSnackbarManager`

*new* method: `-buttonTitleColorForState:` in `MDCSnackbarManager`

*new* property: `alignment` in `MDCSnackbarManager`

*new* method: `-showMessage:` in `MDCSnackbarManager`

*new* property: `shouldApplyStyleChangesToVisibleSnackbars` in `MDCSnackbarManager`

*new* method: `-setBottomOffset:` in `MDCSnackbarManager`

*new* property: `messageFont` in `MDCSnackbarManager`

*new* property: `snackbarMessageViewBackgroundColor` in `MDCSnackbarManager`

*new* method: `-suspendAllMessages` in `MDCSnackbarManager`

*new* property: `delegate` in `MDCSnackbarManager`

*new* method: `-setPresentationHostView:` in `MDCSnackbarManager`

*new* method: `-resumeMessagesWithToken:` in `MDCSnackbarManager`

*new* method: `-setButtonTitleColor:forState:` in `MDCSnackbarManager`

*new* method: `-hasMessagesShowingOrQueued` in `MDCSnackbarManager`

*new* method: `-dismissAndCallCompletionBlocksWithCategory:` in `MDCSnackbarManager`

*new* property: `mdc_adjustsFontForContentSizeCategory` in `MDCSnackbarManager`

#### MDCSnackbarManager(LegacyAPI)

*new* category: `MDCSnackbarManager(LegacyAPI)`

*modified* property: `snackbarMessageViewBackgroundColor` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+hasMessagesShowingOrQueued` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* property: `shouldApplyStyleChangesToVisibleSnackbars` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* property: `delegate` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+setButtonTitleColor:forState:` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* property: `alignment` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* property: `messageTextColor` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+suspendAllMessages` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+resumeMessagesWithToken:` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+showMessage:` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+setBottomOffset:` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* property: `messageFont` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* property: `mdc_adjustsFontForContentSizeCategory` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+dismissAndCallCompletionBlocksWithCategory:` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+setPresentationHostView:` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+buttonTitleColorForState:` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* class method: `+suspendMessagesWithCategory:` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* property: `snackbarMessageViewShadowColor` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

*modified* property: `buttonFont` in `MDCSnackbarManager(LegacyAPI)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarManager` |
| To: | `c:objc(cy)MDCSnackbarManager@LegacyAPI` |

### Tabs+ColorThemer

#### MDCTabBarColorThemer(ToBeDeprecated)

*new* category: `MDCTabBarColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toTabBar:` in `MDCTabBarColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCTabBarColorThemer` |
| To: | `c:objc(cy)MDCTabBarColorThemer@ToBeDeprecated` |

### TextFields+ColorThemer

#### MDCTextFieldColorThemer(ToBeDeprecated)

*new* category: `MDCTextFieldColorThemer(ToBeDeprecated)`

*modified* class method: `+applyColorScheme:toAllTextInputControllersOfClass:` in `MDCTextFieldColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCTextFieldColorThemer` |
| To: | `c:objc(cy)MDCTextFieldColorThemer@ToBeDeprecated` |

*modified* class method: `+applyColorScheme:toTextInputController:` in `MDCTextFieldColorThemer(ToBeDeprecated)`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCTextFieldColorThemer` |
| To: | `c:objc(cy)MDCTextFieldColorThemer@ToBeDeprecated` |

## Component changes

### Tabs

#### Changes

* [[automated] Regenerate all readmes.](https://github.com/material-components/material-components-ios/commit/4a9df7c8cbabfa43c08ef23d22aa8b0d552c881a) (Jeff Verkoeyen)
* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### schemes/Color

#### Changes

* [Add a color scheme migration guide. (#4737)](https://github.com/material-components/material-components-ios/commit/2495417ca2d5f6f54cebbe57874bbbed1fd5a9e6) (featherless)

### FeatureHighlight

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### AppBar

#### Changes

* [Move more app bar logic back to the init phase. (#4749)](https://github.com/material-components/material-components-ios/commit/8444432c4cb809e142d6687af06f3460f1df1284) (featherless)
* [Move shadow layer initialization back to the init phase. (#4746)](https://github.com/material-components/material-components-ios/commit/9012cf9b747dbfb5657fe66229d02ff691c39711) (featherless)
* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### Ink

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### Buttons

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### ButtonBar

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### TextFields

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### Chips

#### Changes

* [[automated] Regenerate all readmes.](https://github.com/material-components/material-components-ios/commit/4a9df7c8cbabfa43c08ef23d22aa8b0d552c881a) (Jeff Verkoeyen)
* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### Snackbar

#### Changes

* [Create explicit singleton (#4742)](https://github.com/material-components/material-components-ios/commit/df30e777ba5acea9713318c7142373ba01df6a34) (Robert Moore)
* [Make examples accessible to Switch Control (#4745)](https://github.com/material-components/material-components-ios/commit/514ed51aeaa99570f6e1eb2cae8db076999db5c5) (Robert Moore)
* [[automated] Regenerate all readmes.](https://github.com/material-components/material-components-ios/commit/4a9df7c8cbabfa43c08ef23d22aa8b0d552c881a) (Jeff Verkoeyen)
* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### Cards

#### Changes

* [[automated] Regenerate all readmes.](https://github.com/material-components/material-components-ios/commit/4a9df7c8cbabfa43c08ef23d22aa8b0d552c881a) (Jeff Verkoeyen)

### BottomAppBar

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### Slider

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### NavigationBar

#### Changes

* [[automated] Regenerate all readmes.](https://github.com/material-components/material-components-ios/commit/4a9df7c8cbabfa43c08ef23d22aa8b0d552c881a) (Jeff Verkoeyen)
* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### ActivityIndicator

#### Changes

* [[automated] Regenerate all readmes.](https://github.com/material-components/material-components-ios/commit/4a9df7c8cbabfa43c08ef23d22aa8b0d552c881a) (Jeff Verkoeyen)
* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### Dialogs

#### Changes

* [Remove use of MDCFlatButton for MDCButton and MDCTextButtonThemer (#4739)](https://github.com/material-components/material-components-ios/commit/84d5dfbb83d0118ff26921318df8cc549d919809) (Cody Weaver)
* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### BottomNavigation

#### Changes

* [Fix accessibilityValue for badgeValue updates (#4734)](https://github.com/material-components/material-components-ios/commit/057c72429f06b6c99fd3ea78e368f0c2cce7061a) (Robert Moore)
* [[automated] Regenerate all readmes.](https://github.com/material-components/material-components-ios/commit/4a9df7c8cbabfa43c08ef23d22aa8b0d552c881a) (Jeff Verkoeyen)
* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### PageControl

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### HeaderStackView

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### FlexibleHeader

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

### ProgressView

#### Changes

* [[schemes/Color] Formally mark all to-be-deprecated APIs as "ToBeDeprecated". (#4738)](https://github.com/material-components/material-components-ios/commit/e14b90e8292577c7ee5e284080353097fbbe5c2e) (featherless)

---

# 59.2.2

This patch release undoes some additional App Bar initialization changes that were introduced in
v59.2.0.

## Component changes

### AppBar

#### Changes

* [Move more app bar logic back to the init phase. (#4749)](https://github.com/material-components/material-components-ios/commit/b77876e2885eb272a433ede6c32d17afbbe3b25c) (featherless)

---

# 59.2.1

This patch release reverts an unintentional change in App Bar shadow layer initialization behavior
that was introduced in v59.2.0.

## Component changes

### AppBar

#### Changes

* [Move shadow layer initialization back to the init phase. (#4746)](https://github.com/material-components/material-components-ios/commit/2e6f22b313b56f3a48d1f1ba608d19c78084e09d) (featherless)

---

# 59.2.0

This minor release introduces several new improvements to the AppBar component and bug fixes and
accessibility improvements to various components.

## New features

AppBar's documentation has been updated to reflect all of the most modern APIs and behavioral flags.

AppBar also now exposes a new `MDCAppBarViewController` API which is meant to be a more familiar
replacement API for `MDCAppBar`.

A typical migration diff will look something like so (in Swift):

```swift
// Step 1
-  let appBar = MDCAppBar()
+  let appBarViewController = MDCAppBarViewController()

// Step 2
-    self.addChildViewController(appBar.headerViewController)
+    self.addChildViewController(appBarViewController)

// Step 3
-    appBar.addSubviewsToParent()
+    view.addSubview(appBarViewController.view)
+    appBarViewController.didMove(toParentViewController: self)
```

## API changes

### AppBar+ColorThemer

#### MDCAppBarColorThemer

*new* class method: `+applySurfaceVariantWithColorScheme:toAppBarViewController:` in `MDCAppBarColorThemer`

*new* class method: `+applyColorScheme:toAppBarViewController:` in `MDCAppBarColorThemer`

### AppBar

#### MDCAppBar

*new* property: `appBarViewController` in `MDCAppBar`

#### MDCAppBarNavigationControllerDelegate

*new* method: `-appBarNavigationController:willAddAppBarViewController:asChildOfViewController:` in `MDCAppBarNavigationControllerDelegate`

#### MDCAppBarNavigationController

*new* method: `-appBarViewControllerForViewController:` in `MDCAppBarNavigationController`

#### MDCAppBarContainerViewController

*new* property: `appBarViewController` in `MDCAppBarContainerViewController`

#### MDCAppBarViewController

*new* class: `MDCAppBarViewController`

### AppBar+TypographyThemer

#### MDCAppBarTypographyThemer

*new* class method: `+applyTypographyScheme:toAppBarViewController:` in `MDCAppBarTypographyThemer`

### TextFields

#### MDCTextInputController

*new* method: `-setHelperText:helperAccessibilityLabel:` in `MDCTextInputController`

## Component changes

### Tabs

#### Changes

* [[Catalog] Conversion to new App Bar View Controller API (#4696)](https://github.com/material-components/material-components-ios/commit/50e1fd091d8d08426f390c124bf6310c54174d8c) (featherless)

### AppBar

#### Changes

* [Complete pass at documentation modernization. (#4708)](https://github.com/material-components/material-components-ios/commit/4f181203ad7f74ae0e38b214466fda9fdf36b131) (featherless)
* [Enable inferTopSafeAreaInsetFromViewController on the App Bar in the navigation controller. (#4693)](https://github.com/material-components/material-components-ios/commit/3192a41078ecde5fb822abaa56d8f70eeee0f740) (featherless)
* [Expose MDCAppBarViewController as a replacement for MDCAppBar. (#4695)](https://github.com/material-components/material-components-ios/commit/2645cc539f6a17e8ecb729a1b5b7997be24f07fa) (featherless)
* [Fix bug where root view controller during initialization of nav controller would not be injected with an App Bar. (#4691)](https://github.com/material-components/material-components-ios/commit/ade5b5daa3f61131817e5d19e6f7413cd249d757) (featherless)
* [Implement setViewControllers on MDCAppBarNavigationController. (#4736)](https://github.com/material-components/material-components-ios/commit/873a89f3d850873fd5f7ffed3e37389348e0d63a) (featherless)
* [Increase likelihood that we detect existing App Bars when auto-injecting. (#4692)](https://github.com/material-components/material-components-ios/commit/e9eb2579aa6f2393472fce4190eb8142924915ff) (featherless)
* [Rename MDCAppBar.h to MDCAppBarViewController.h. (#4704)](https://github.com/material-components/material-components-ios/commit/363750d44a1e047cb7d8f0929d7cc569915020db) (featherless)
* [[Catalog] Conversion to new App Bar View Controller API (#4696)](https://github.com/material-components/material-components-ios/commit/50e1fd091d8d08426f390c124bf6310c54174d8c) (featherless)

### TextFields

#### Changes

* [Add setHelperText:helperAccessibilityLabel (#4661)](https://github.com/material-components/material-components-ios/commit/6acde0b27560a8924639f70f46150fb3a86d4061) (Andrew Overton)
* [Consider UIUserInterfaceLayoutDirection when drawing outlined text controller outline path (#4719)](https://github.com/material-components/material-components-ios/commit/5f66ae926378247066b9153f39f5e9f170b42422) (Andrew Overton)

### Chips

#### Changes

* [Allow clients to set `accessibilityLabel` on MDCChipView (#4664)](https://github.com/material-components/material-components-ios/commit/18bca47a34c5c647c28954abfd4e3712fef3eee2) (compositeprimes)

### Snackbar

#### Changes

* [Removed unused variable from MDCSnackbarMessageView (#4690)](https://github.com/material-components/material-components-ios/commit/a4338106ce9bfe8a3d47ad8db6b358e8f5d0fe79) (trungducc)

### BottomAppBar

#### Changes

* [Add a11y guide to README (#4705)](https://github.com/material-components/material-components-ios/commit/f4199c850a4b9c4edf5c9d6a6f15df31f6ef00aa) (Cody Weaver)
* [[Catalog] Conversion to new App Bar View Controller API (#4696)](https://github.com/material-components/material-components-ios/commit/50e1fd091d8d08426f390c124bf6310c54174d8c) (featherless)

### NavigationBar

#### Changes

* [ButtonBar example with associated UIButton (#4677)](https://github.com/material-components/material-components-ios/commit/e3e6dd39e2d3bd17075645ecf882463906f40dc8) (ianegordon)

### BottomSheet

#### Changes

* [Examples support accessible scrim (#4711)](https://github.com/material-components/material-components-ios/commit/24ddf9c4d671648b957edaf27ed7773b8ccfa26d) (Robert Moore)
* [[Catalog] Conversion to new App Bar View Controller API (#4696)](https://github.com/material-components/material-components-ios/commit/50e1fd091d8d08426f390c124bf6310c54174d8c) (featherless)

### Dialogs

#### Changes

* [Fix button hit areas to match accessibility (#4684)](https://github.com/material-components/material-components-ios/commit/255dae403bd46ab0391d34623da3fe63b0915aee) (Cody Weaver)

### BottomNavigation

#### Changes

* [Fix safe area insets on bottom nav example (#4637)](https://github.com/material-components/material-components-ios/commit/120c93d32973ebbc9baa8c04493dd38f19243dcc) (John Detloff)
* [Remove duplicate tab position descriptions (#4679)](https://github.com/material-components/material-components-ios/commit/5721ba816fba9585402ee664f82ed8b0bf65de61) (Robert Moore)
* [[Catalog] Conversion to new App Bar View Controller API (#4696)](https://github.com/material-components/material-components-ios/commit/50e1fd091d8d08426f390c124bf6310c54174d8c) (featherless)

### FlexibleHeader

#### Changes

* [Allow additionalSafeAreaInsets to respect contextual top insets. (#4697)](https://github.com/material-components/material-components-ios/commit/da322f74027ea486bdbd7a331c03ed5b13cd2f0e) (featherless)
* [Fix infinite recursion when observesTrackingScrollViewScrollEvents is enabled. (#4694)](https://github.com/material-components/material-components-ios/commit/56be84def1069825efb0ed3303a7eeec73033e58) (featherless)
* [Fixes a layout bug with VoiceOver on that was introduced in v57.0.0 (5dc67c88c06f11761769de1d0bae34ff2c657046). (#4698)](https://github.com/material-components/material-components-ios/commit/6325fb35b2f64c47dc9d3780c2decdad9960787e) (featherless)
* [[AppBar] Complete pass at documentation modernization. (#4708)](https://github.com/material-components/material-components-ios/commit/4f181203ad7f74ae0e38b214466fda9fdf36b131) (featherless)

### ShadowElevations

#### Changes

* [[Catalog] Conversion to new App Bar View Controller API (#4696)](https://github.com/material-components/material-components-ios/commit/50e1fd091d8d08426f390c124bf6310c54174d8c) (featherless)

---

# 59.1.1

This patch release fixes a bug with Flexible Header when VoiceOver is enabled.

## API changes

## Component changes

### FlexibleHeader

#### Changes

* [Fixes a layout bug with VoiceOver on that was introduced in v57.0.0 (5dc67c88c06f11761769de1d0bae34ff2c657046). (#4698)](https://github.com/material-components/material-components-ios/commit/e5c3b79df0a9ae09b5063416df57044ba1cb6179) (featherless)

---

# 59.1.0

AppBar and FlexibleHeader shipped several new features in this release and Snackbar's manager is now implemented as a true singleton. This release also includes additional accessibility improvements and examples, and also fixes some bugs.

## New features

The new MDCAppBarNavigationController class is a simpler integration strategy for adding an App Bar to an application. Example:

```swift
let navigationController = MDCAppBarNavigationController()

// Will automatically inject an AppBar into the view controller if one is not already present.
navigationController.pushViewController(viewController, animated: true)
```

This new API enables all of the new AppBar and FlexibleHeader behaviors, meaning view controllers will better handle being presented in non-full screen settings. If you have already integrated with App Bar, migrating to MDCAppBarNavigationController will allow you to delete a substantial amount of boilerplate from your application. Most notably, MDCAppBarNavigationController enables the new `observesTrackingScrollViewScrollEvents` feature on FlexibleHeader, meaning you do not need to forward scroll view events to the navigation controller.

At a minimum you will need to implement the MDCAppBarNavigationController's delegate to theme the injected App Bars. Implement the delegate like so:

```swift
navigationController.delegate = self

// MARK: MDCAppBarNavigationControllerInjectorDelegate

func appBarNavigationController(_ navigationController: MDCAppBarNavigationController,
                                willAdd appBar: MDCAppBar,
                                asChildOf viewController: UIViewController) {
  let colorScheme: MDCSemanticColorScheme = <# Fetch your color scheme #>
  let typographyScheme: MDCTypographyScheme = <# Fetch your typography scheme #>
  MDCAppBarColorThemer.applySemanticColorScheme(colorScheme, to: appBar)
  MDCAppBarTypographyThemer.applyTypographyScheme(typographyScheme, to: appBar)
                                                  
  // Additional configuration of appBar if needed.
}
```

AppBar's new `inferTopSafeAreaInsetFromViewController` property enables App Bars to be presented in non-full-screen contexts, such as iPad popovers or extensions. Consider enabling this property by default in all use cases.

FlexibleHeader's new `observesTrackingScrollViewScrollEvents` property allows the FlexibleHeader to automatically observe content offset changes to the tracking scroll view, removing the need for forwarding the UIScrollViewDelegate events to the FlexibleHeader. Note: you can only use this new feature if you have *not* enabled the shift behavior.

MDCSnackbarManager is now implemented as a true singleton with the ability to also create individual instances, making it possible to write self-contained tests for the component.

## API changes

### AppBar

#### MDCAppBarNavigationController

*new* class: `MDCAppBarNavigationController`

*new* property: `delegate` in `MDCAppBarNavigationController`

*new* method: `-appBarForViewController:` in `MDCAppBarNavigationController`

#### MDCAppBarNavigationControllerDelegate

*new* protocol: `MDCAppBarNavigationControllerDelegate`

*new* method: `-appBarNavigationController:willAddAppBar:asChildOfViewController:` in `MDCAppBarNavigationControllerDelegate`

#### MDCAppBar

*new* property: `inferTopSafeAreaInsetFromViewController` in `MDCAppBar`

### FlexibleHeader

#### MDCFlexibleHeaderView

*new* property: `observesTrackingScrollViewScrollEvents` in `MDCFlexibleHeaderView`

## Component changes

### AppBar

#### Changes

* [Add an inferTopSafeAreaInsetFromViewController behavior. (#4648)](https://github.com/material-components/material-components-ios/commit/76a5c1e6882f46eb4c40d632c5bfd6ac49aff592) (featherless)
* [Add new MDCAppBarNavigationController API.  (#4650)](https://github.com/material-components/material-components-ios/commit/f2d7edb84604244a9a2ffefb0f78abad36d35d92) (featherless)
* [[FlexibleHeader] Add support for observing the tracking scroll view. (#4647)](https://github.com/material-components/material-components-ios/commit/a5594f37802c8563086cc2ba85109c7c975aa535) (featherless)

### Ink

#### Changes

* [[Catalog] Improve Ink demo color contrast (#4660)](https://github.com/material-components/material-components-ios/commit/bece3086d85c624c9112ac68ad7f8baec1ffba66) (Robert Moore)
* [add commonMDCInkViewInit call to -initWithCoder: (#4662)](https://github.com/material-components/material-components-ios/commit/49a870fd94545535ead2b915a1ebf65d793b99fb) (Andrew Overton)

### Snackbar

#### Changes

* [Create explicit singleton (#4556)](https://github.com/material-components/material-components-ios/commit/c6ffe403ba550da972317936c2740790549002b1) (Robert Moore)
* [Revert "Create explicit singleton (#4556)"](https://github.com/material-components/material-components-ios/commit/8492359a0243da096c53b02dcea69f2b8d3d29f9) (Jeff Verkoeyen)

### Cards

#### Changes

* [ accessibility example for collection cards (#4488)](https://github.com/material-components/material-components-ios/commit/f040e95bffda55a4f637dd5d48c679e740cf59bc) (Galia Kaufman)
* [Accessibility: Fixing documentation typos (#4634)](https://github.com/material-components/material-components-ios/commit/cf014946d8f25ee95858631c6f301ef222f3b6c0) (Galia Kaufman)

### LibraryInfo

#### Changes

* [Version bump.](https://github.com/material-components/material-components-ios/commit/85334ead24f13cf7c5dce7caaaf0c0d27e79f28a) (Jeff Verkoeyen)

### Dialogs

#### Changes

* [Best example description (#4643)](https://github.com/material-components/material-components-ios/commit/d2d1cc064f7bad4d96b432d4a1a9797a65c768d8) (ianegordon)
* [Revert "Update buttons touch area to be 48x48 minimum (#4624)" (#4675)](https://github.com/material-components/material-components-ios/commit/a55e190c3c51c04e7f5c6506adac0e460bdf19b4) (ianegordon)
* [Update buttons touch area to be 48x48 minimum (#4624)](https://github.com/material-components/material-components-ios/commit/2c8539c3be9bb39dd8198341fb71c860cbc61e93) (Cody Weaver)

### BottomNavigation

#### Changes

* [Explicitly update label visibility after titleVisibility is set (#4635)](https://github.com/material-components/material-components-ios/commit/203160c80e8e5572443ee27616be730e56a43a79) (Andrew Overton)
* [Fix delayed ink ripple (#4625)](https://github.com/material-components/material-components-ios/commit/9d16a4a8946e9a356c752427f80c6fbb078133cb) (Robert Moore)
* [Give UITabBarItems' accessibilityIdentifiers to MDCBottomNavigationBa… (#4599)](https://github.com/material-components/material-components-ios/commit/87496292fff9a73ca671ab63939fcc2ed665fe34) (Andrew Overton)

### FlexibleHeader

#### Changes

* [Add support for observing the tracking scroll view. (#4647)](https://github.com/material-components/material-components-ios/commit/a5594f37802c8563086cc2ba85109c7c975aa535) (featherless)

---

# 59.0.0

This major release removed the remaining encoding/decoding behaviors from components ([tracking project](https://github.com/material-components/material-components-ios/projects/22)) and fixed a variety of bugs in FlexibleHeader with relation to safe area insets.

## Breaking changes

AppBar, TextFields, BottomNavigation, and Ink all removed support for encoding/decoding their custom properties.

## New features

FlexibleHeader has a new behavior, `inferTopSafeAreaInsetFromViewController`, which allows the flexible header to determine its safe area insets from its view controller context, rather than always assuming that the header will consume the entire screen. This new behavior is most useful in extensions and on the iPad when presenting modal dialogs or popovers. To enable the new behavior, you simply set `inferTopSafeAreaInsetFromViewController` on `MDCFlexibleHeaderViewController` to `YES`.

## API changes

### FlexibleHeader

#### MDCFlexibleHeaderView

*new* property: `topSafeAreaGuide` in `MDCFlexibleHeaderView`

#### MDCFlexibleHeaderViewController

*new* property: `inferTopSafeAreaInsetFromViewController` in `MDCFlexibleHeaderViewController`

### TextFields

#### MDCTextInputControllerLegacyFullWidth

*modified* class: `MDCTextInputControllerLegacyFullWidth`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextInputControllerLegacyFullWidth     : MDCTextInputControllerFullWidth <NSSecureCoding>` |
| To: | `@interface MDCTextInputControllerLegacyFullWidth     : MDCTextInputControllerFullWidth` |

#### MDCTextInputUnderlineView

*modified* class: `MDCTextInputUnderlineView`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextInputUnderlineView : UIView <NSCopying, NSSecureCoding>` |
| To: | `@interface MDCTextInputUnderlineView : UIView <NSCopying>` |

#### MDCTextInputController

*modified* protocol: `MDCTextInputController`

| Type of change: | Declaration |
|---|---|
| From: | `@protocol MDCTextInputController <NSObject, NSSecureCoding, NSCopying,                                   MDCTextInputPositioningDelegate>` |
| To: | `@protocol MDCTextInputController <NSObject, NSCopying,                                   MDCTextInputPositioningDelegate>` |

## Component changes

### AppBar

#### Breaking changes

* [**Breaking**:  Remove encoding/decoding behavior for custom properties (#4566)](https://github.com/material-components/material-components-ios/commit/39248f223017bd64d9d291e5f063dd7ccc4fa9af) (featherless)

### Ink

#### Breaking changes

* [**Breaking**:  Remove encoding/decoding behavior for custom properties (#4555)](https://github.com/material-components/material-components-ios/commit/fc1e82cd17f0abeaa9e62f7c3a3f39a91944a05b) (featherless)

### TextFields

#### Breaking changes

* [**Breaking**:  Remove encoding/decoding behavior for custom properties (#4567)](https://github.com/material-components/material-components-ios/commit/c4935b333d214ec0c028c5147cc8e6ddd00e319c) (featherless)

### BottomAppBar

#### Changes

* [Fix example (#4616)](https://github.com/material-components/material-components-ios/commit/8dd6d9f3d4c7d047fb2a584dd6aced06329cd1be) (Robert Moore)

### BottomSheet

#### Changes

* [Replacing typeof(self) by __typeof(self) (#4617)](https://github.com/material-components/material-components-ios/commit/03244a3dca8e35722e802bd53e6c74a1314118bc) (Jérôme Lebel)

### BottomNavigation

#### Breaking changes

* [**Breaking**:  Remove encoding/decoding behavior for custom properties (#4562)](https://github.com/material-components/material-components-ios/commit/001fbfac55bf1728798cefad767bcf36b9693985) (featherless)

### FlexibleHeader

#### Changes

* [Add behavior for enabling contextual safe area insets (#4596)](https://github.com/material-components/material-components-ios/commit/bb245597d8895a78c346c76f7d0986d7a993ad12) (featherless)
* [Fix iPhone X status bar bug when changing orientation. (#4592)](https://github.com/material-components/material-components-ios/commit/f5011f7e44b0b24af31d7dc4ae872e53ed29cbd7) (featherless)
* [Fix inconsistent shifting behavior when deceleration ends. (#4622)](https://github.com/material-components/material-components-ios/commit/98b046dd1f695c9db2506feb63c820905240c233) (featherless)
* [Improved height consistency when horizontally paging. (#4601)](https://github.com/material-components/material-components-ios/commit/ca4e619287e1c8c438d162ce4f8fe724fcd5d113) (featherless)
* [Remove Swift typical use example. (#4595)](https://github.com/material-components/material-components-ios/commit/272548637f5a2543a14652372a312fd899e340e2) (featherless)

---

# 58.0.0

This major release focused on accessibility and removing property coding/encoding from a variety of
components. It also fixed a bug related to AppBar/FlexibleHeader top layout guide behavior on
pre-iOS 11 devices.

## Breaking changes

Property encoding/decoding has been removed from a majority of the components, along with any
related explicit conformances to NSCoding and NSSecureCoding. See the
[tracking project](https://github.com/material-components/material-components-ios/projects/22) to
learn more about the status of this work.

MDCNavigationBar's deprecated `useFlexibleTopBottomInsets` has been removed.

## New features

A variety of accessibility documentation has been added to many of the components.

BottomNavigation has new parameters for the top padding of the nav bar items and the vertical
spacing between the icon and title. 

## API changes

### BottomNavigation

#### MDCBottomNavigationBar

*new* property: `itemsContentInsets` in `MDCBottomNavigationBar`

*new* property: `itemsContentHorizontalMargin` in `MDCBottomNavigationBar`

*new* property: `itemsContentVerticalMargin` in `MDCBottomNavigationBar`

### NavigationBar

#### MDCNavigationBar

*removed* property: `useFlexibleTopBottomInsets` in `MDCNavigationBar`

## Component changes

### AppBar

#### Breaking changes

* [**Breaking**:  Mainline the YES behaviour for useFlexibleTopBottomInsets, and remove the already deprecated API. (#4570)](https://github.com/material-components/material-components-ios/commit/4438b441b2022201a5a3113825831ba5166f5167) (Ali Rabbani)
* [**Breaking**:  [FlexibleHeader] Remove NSCoding support. (#4554)](https://github.com/material-components/material-components-ios/commit/a7dd419ebe436852b342327b32b60fc61d5216a6) (featherless)
* [**Breaking**:  [NavigationBar] Remove NSCoding support. (#4560)](https://github.com/material-components/material-components-ios/commit/de0d57e8e3cdfd364b388e2f4e726d318038776c) (featherless)

#### Changes

* [Add docs on making navigationItems accessible with MDCAppBars (#4540)](https://github.com/material-components/material-components-ios/commit/0a0db27c915e81ae4c22dfdf456ba4a16c1e7707) (Andrew Overton)
* [[Catalog] Enable AppBar's isTopLayoutGuideAdjustmentEnabled in all examples. (#4537)](https://github.com/material-components/material-components-ios/commit/abae199d7135aaa8ea5ba2d1636e8fd767794285) (featherless)

### Ink

#### Changes

* [Make example accessible. (#4506)](https://github.com/material-components/material-components-ios/commit/f8284cdde41e41e0f59f2554b9e01b36fab0dec4) (Cody Weaver)

### Buttons

#### Breaking changes

* [**Breaking**:  Remove NSCoding support. (#4565)](https://github.com/material-components/material-components-ios/commit/48890aa9bf1991cffe497c906845841681a5386d) (featherless)

#### Changes

* [Disable FAB animation for VoiceOver (#4535)](https://github.com/material-components/material-components-ios/commit/3244f5491d28ffa1077a7e8456349fbed6525c0c) (Robert Moore)
* [Fix button README (#4547)](https://github.com/material-components/material-components-ios/commit/4e7db26ccb43357d01fd844f3bd9867f2d824aff) (Cody Weaver)
* [Make accessibility docs match other components (#4501)](https://github.com/material-components/material-components-ios/commit/88dabcfac9a0d5bdc51b1dc93e5f2572c0ad8f08) (Cody Weaver)
* [Removed internal links from docs. (#4559)](https://github.com/material-components/material-components-ios/commit/3d665a45b8770cd64be5088ec14e7163de9e4c4b) (Randall Li)
* [[Catalog] Enable AppBar's isTopLayoutGuideAdjustmentEnabled in all examples. (#4537)](https://github.com/material-components/material-components-ios/commit/abae199d7135aaa8ea5ba2d1636e8fd767794285) (featherless)

### ButtonBar

#### Breaking changes

* [**Breaking**:  Remove NSCoding support. (#4553)](https://github.com/material-components/material-components-ios/commit/7f5f920493a3081fb8e5b49f527675c95aa4627b) (featherless)

### TextFields

#### Changes

* [Add accessibility docs for MDCTextField (#4498)](https://github.com/material-components/material-components-ios/commit/4745d80b40141679acf987830f33191854af5cf5) (Andrew Overton)
* [Fix clear button render scale (#4539)](https://github.com/material-components/material-components-ios/commit/789f659f159958f2c9bd44e62023dc194903f71b) (Robert Moore)

### Chips

#### Breaking changes

* [**Breaking**:  Remove NSCoding support. (#4549)](https://github.com/material-components/material-components-ios/commit/cfa8a68eaf3c75bb3a92ded94541adcceb33d1dc) (featherless)

#### Changes

* [Add accessibilityHint to clear button in chips example (#4504)](https://github.com/material-components/material-components-ios/commit/7272f877a145d369b1b7ed305081638de7c8f523) (Andrew Overton)

### Cards

#### Breaking changes

* [**Breaking**:  Remove NSCoding support. (#4548)](https://github.com/material-components/material-components-ios/commit/0b26db87660dc0a82fe4f87cdaad2f103ebd244e) (featherless)

#### Changes

* [Add accessibility documentation (#4454)](https://github.com/material-components/material-components-ios/commit/ae8231e49ac1f192adb21b4425176de591e3de5e) (Galia Kaufman)

### Slider

#### Changes

* [Add a11y doc (#4536)](https://github.com/material-components/material-components-ios/commit/a4be5b041283def0e5248ba5b595cc05b030b9d6) (Cody Weaver)
* [Support custom increment and decrement levels (#4534)](https://github.com/material-components/material-components-ios/commit/27e8fcc816a7c4612d48018ceb2f8b430df1eb2b) (Cody Weaver)

### NavigationBar

#### Breaking changes

* [**Breaking**:  Remove NSCoding support. (#4560)](https://github.com/material-components/material-components-ios/commit/de0d57e8e3cdfd364b388e2f4e726d318038776c) (featherless)

#### Changes

* [Mainline the YES behaviour for useFlexibleTopBottomInsets, and remove the already deprecated API. (#4570)](https://github.com/material-components/material-components-ios/commit/4438b441b2022201a5a3113825831ba5166f5167) (Ali Rabbani)

### ShadowLayer

#### Breaking changes

* [**Breaking**:  Remove encoding/decoding behavior for custom properties (#4546)](https://github.com/material-components/material-components-ios/commit/b84b2cc01bd6e05760e588166f4e2a7535847e52) (featherless)

### ActivityIndicator

#### Changes

* [Change override of AccessibilityLabel with setting it to a default. (#4564)](https://github.com/material-components/material-components-ios/commit/76602a760149bacad1f75e84fe1979e07339e200) (Randall Li)
* [Removed outdated comment. (#4561)](https://github.com/material-components/material-components-ios/commit/ac09ad9bc2244f0946c449b3d45ca3c872af2f97) (featherless)

### BottomSheet

#### Changes

* [Inform delegate of accessibility escape dismissal (#4571)](https://github.com/material-components/material-components-ios/commit/b0c8bdfa5520033c96c1298443a5e4f0686d0ce7) (Andrew Overton)
* [[Catalog] Enable AppBar's isTopLayoutGuideAdjustmentEnabled in all examples. (#4537)](https://github.com/material-components/material-components-ios/commit/abae199d7135aaa8ea5ba2d1636e8fd767794285) (featherless)

### Dialogs

#### Changes

* [Update A11y docs (#4509)](https://github.com/material-components/material-components-ios/commit/20445a5d8565070ac3f836363edcf6f41380066a) (ianegordon)
* [make accessibilityPerformEscape honor MDCDialogPresentationController.dismissOnBackgroundTap (#4508)](https://github.com/material-components/material-components-ios/commit/d6f771d3c64ad33d867bb6cd92a1263304b2c087) (Andrew Overton)

### BottomNavigation

#### Changes

* [Add a11y to README (#4497)](https://github.com/material-components/material-components-ios/commit/e7b30aa44982c33ad7ebf48a63bee5db6714c179) (Cody Weaver)
* [Give MDCBottomNavigationBar a TabBar accessibilityTrait (#4510)](https://github.com/material-components/material-components-ios/commit/541a7af867906a924c6d6ca741c5219175a484fc) (Andrew Overton)
* [Parameterize top padding and vertical margin (#4432)](https://github.com/material-components/material-components-ios/commit/5c88af59d152dfb45782486a6b784048f720f85a) (John Detloff)
* [Removed internal links from docs. (#4558)](https://github.com/material-components/material-components-ios/commit/ad872244e1fba4aa252846549c354f432754bff1) (Randall Li)

### AnimationTiming

#### Changes

* [[FlexibleHeader] Enforce top layout guide adjustment on pre-iOS 11 devices. (#4573)](https://github.com/material-components/material-components-ios/commit/3e441f22991368e1ceb3e3e130b0cb666b610b6f) (featherless)

### HeaderStackView

#### Breaking changes

* [**Breaking**:  Remove NSCoding support. (#4544)](https://github.com/material-components/material-components-ios/commit/e68fff55dea351fe49e61bdaf2eabf676b9d1e99) (featherless)

### FlexibleHeader

#### Breaking changes

* [**Breaking**:  Update top layout behavior to match documentation. (#4577)](https://github.com/material-components/material-components-ios/commit/516885895a8eb2ff9bdd268d9510cc635cf8ecc4) (featherless)
* [**Breaking**:  Remove NSCoding support. (#4554)](https://github.com/material-components/material-components-ios/commit/a7dd419ebe436852b342327b32b60fc61d5216a6) (featherless)

#### Changes

* [Enforce top layout guide adjustment on pre-iOS 11 devices. (#4573)](https://github.com/material-components/material-components-ios/commit/3e441f22991368e1ceb3e3e130b0cb666b610b6f) (featherless)

### ProgressView

#### Changes

* [Add accessibility docs for MDCProgressView (#4543)](https://github.com/material-components/material-components-ios/commit/e4f8a63b9e93ab9586f82f541c29f7ae717fefc3) (Andrew Overton)

---

# 57.0.0

In this release we have added the List component, made accessibility improvements to Bottom Sheet, added Shapes support for Chips and Bottom Sheet, made Catalog visual improvements, and other bug fixes.

## Breaking changes

### TextFields

We have removed property `backgroundColor` from `MDCTextInputControllerBase` and properties `backgroundColor` and `backgroundColorDefault` from `MDCTextInputController`. The reason for removal was due to these properties not being used by the controller in any meaningful way, and therefore this should not produce any changes.

## New features

### BottomSheet

VoiceOver and switch device users currently have to use the accessibility escape gesture to dismiss a Bottom Sheet. Optionally, the BottomSheet can use
the dimmed "scrim" area (which can be tappable) to dismiss the bottom sheet using accessibility technologies.

As an example of how this could be used by clients, here's how our AppDelegate would change to support a VoiceOver button for dismissal:
```swift
let menuViewController = MDCMenuViewController(style: .plain)
let bottomSheet = MDCBottomSheetController(contentViewController: menuViewController)
bottomSheet.dismissOnBackgroundTap = true
bottomSheet.isScrimAccessibilityElement = true
bottomSheet.scrimAccessibilityLabel = "Close"
self.present(bottomSheet, animated: true, completion: nil)
```

### Cards

You can now set the car to be interactable or not. Our specification for cards explicitly define a card as being an interactable component.
Therefore, the interactable property should be set to NO *only if* there are other interactable items within the card's content, such as buttons or other tappable controls.
To set the interactability to no in your cards:
```swift
let card = MDCCard()
card.isInteractable = false

let cardCell = MDCCardCollectionCell()
cardCell.isInteractable = false
```

### List

We now have a new component, List! See more information about the component here: https://github.com/material-components/material-components-ios/tree/develop/components/List

## API changes

### BottomSheet

#### MDCBottomSheetTransitionController(ScrimAccessibility)

*new* category: `MDCBottomSheetTransitionController(ScrimAccessibility)`

*new* property: `isScrimAccessibilityElement` in `MDCBottomSheetTransitionController(ScrimAccessibility)`

*new* property: `scrimAccessibilityLabel` in `MDCBottomSheetTransitionController(ScrimAccessibility)`

*new* property: `scrimAccessibilityHint` in `MDCBottomSheetTransitionController(ScrimAccessibility)`

*new* property: `scrimAccessibilityTraits` in `MDCBottomSheetTransitionController(ScrimAccessibility)`

#### MDCBottomSheetController

*new* property: `scrimAccessibilityHint` in `MDCBottomSheetController`

*new* property: `isScrimAccessibilityElement` in `MDCBottomSheetController`

*new* property: `state` in `MDCBottomSheetController`

*new* method: `-shapeGeneratorForState:` in `MDCBottomSheetController`

*new* property: `scrimAccessibilityLabel` in `MDCBottomSheetController`

*new* method: `-setShapeGenerator:forState:` in `MDCBottomSheetController`

*new* property: `scrimAccessibilityTraits` in `MDCBottomSheetController`

#### MDCSheetState

*new* enum: `MDCSheetState` with values `MDCSheetStateExtended`, `MDCSheetStatePreferred`, and `MDCSheetStateClosed`

#### MDCBottomSheetPresentationControllerDelegate

*new* method: `-bottomSheetWillChangeState:sheetState:` in `MDCBottomSheetPresentationControllerDelegate`

#### MDCBottomSheetPresentationController

*new* property: `scrimAccessibilityLabel` in `MDCBottomSheetPresentationController`

*new* property: `isScrimAccessibilityElement` in `MDCBottomSheetPresentationController`

*new* property: `scrimAccessibilityTraits` in `MDCBottomSheetPresentationController`

*new* property: `scrimAccessibilityHint` in `MDCBottomSheetPresentationController`

### Cards

#### MDCCardCollectionCell

*new* property: `interactable` in `MDCCardCollectionCell`

#### MDCCard

*new* property: `interactable` in `MDCCard`

### List

**New component.**

### TextFields

#### MDCTextInputControllerFullWidth

*new* property: `backgroundColor` in `MDCTextInputControllerFullWidth`

*new* property: `backgroundColorDefault` in `MDCTextInputControllerFullWidth`

#### MDCTextInputControllerBase

*removed* property: `backgroundColor` in `MDCTextInputControllerBase`

#### MDCTextInputController

*new* property: `textInputClearButtonTintColorDefault` in `MDCTextInputController`

*new* property: `textInputClearButtonTintColor` in `MDCTextInputController`

*removed* property: `backgroundColorDefault` in `MDCTextInputController`

*removed* property: `backgroundColor` in `MDCTextInputController`

### Typography

#### UIFont(MaterialSimpleEquality)

*new* method: `-mdc_isSimplyEqual:` in `UIFont(MaterialSimpleEquality)`

*new* category: `UIFont(MaterialSimpleEquality)`

## Component changes

### Tabs

#### Changes

* [ Fix alerts in examples (#4480)](https://github.com/material-components/material-components-ios/commit/cb08164a8d29642619c4578e9552856ae82a3cc4) (Robert Moore)

### FeatureHighlight

#### Changes

* [Add swift example (#4439)](https://github.com/material-components/material-components-ios/commit/7e71bb0079ae77046eae5fdb6460c8dd6792f7ec) (Cody Weaver)

### Buttons

#### Changes

* [[Catalog] Fix VoiceOver ordering in Buttons demo (#4482)](https://github.com/material-components/material-components-ios/commit/7a1c3ced310c214fce431a78632d4b0ecadc8540) (Robert Moore)

### TextFields

#### Changes

* [Fix clearIcon drawing (#4450)](https://github.com/material-components/material-components-ios/commit/2abcf53b9dc18a0f469fa7a0b35d9e24b38a6b74) (Robert Moore)
* [Make MDCTextField accessibilityValue include only placeholder or [super accessibilityValue], not both (#4460)](https://github.com/material-components/material-components-ios/commit/c0124aa9fe7b20aec23e54530d29ab645036cdc4) (Andrew Overton)
* [Migrate textInputClearButtonTintColor to MDCTextInputController, tests (#4465)](https://github.com/material-components/material-components-ios/commit/528f46323fb7f7ab5a16ac306da0ee71c2f548c7) (Michelle Dudley)
* [Support clear button tint color (#4449)](https://github.com/material-components/material-components-ios/commit/8835a412a271026b8e4a9d0ed155b266b1840f83) (Robert Moore)
* [[Typography] 3rd PR on font equality (#4435)](https://github.com/material-components/material-components-ios/commit/53876c3dca2e5bcb07d6e8f1ef91fc5bb202835c) (Will Larche)
* [{BreakingChange} Remove unused `backgroundColor` property (#4452)](https://github.com/material-components/material-components-ios/commit/55eead6f1668095b73833d7652839757682a4fa2) (Robert Moore)

### Chips

#### Changes

* [Fix Choice demo (#4473)](https://github.com/material-components/material-components-ios/commit/63970a2b1fd6a759b5d38b96e57e21361350ebe9) (Robert Moore)
* [chips shape support fix + example (#4474)](https://github.com/material-components/material-components-ios/commit/84e9f2334505b45be96ade7559400bbc50641218) (Yarden Eitan)

### Cards

#### Changes

* [Added interactability toggle to Cards (#4404)](https://github.com/material-components/material-components-ios/commit/27a6c46fc3bd41f121d9c23b832f3297dafe2418) (Yarden Eitan)

### List

#### Changes

* [[ListItems] Add Base Cell With Example (#4461)](https://github.com/material-components/material-components-ios/commit/4b6eb9430ce5d4bb061b633946df14152f79db51) (Andrew Overton)

### BottomSheet

#### Changes

* [Dismiss BottomSheet with UIAccessibility (#4475)](https://github.com/material-components/material-components-ios/commit/031d797ecf188c9994701ab90aad3b31603b6a55) (Robert Moore)
* [[Shapes] Added Shapes support for BottomSheet (#4486)](https://github.com/material-components/material-components-ios/commit/61e65488afd298bd78db2acb5f6bcda92b1f1b4d) (Yarden Eitan)

### Typography

#### Changes

* [3rd PR on font equality (#4435)](https://github.com/material-components/material-components-ios/commit/53876c3dca2e5bcb07d6e8f1ef91fc5bb202835c) (Will Larche)

### BottomNavigation

#### Changes

* [AccessibilityValue and Selected icon support (#4444)](https://github.com/material-components/material-components-ios/commit/684f96c9f38337f0c3fad531a58e53635d3839d1) (Cody Weaver)
* [Test cases when we reset the bottom navigation items array (#4431)](https://github.com/material-components/material-components-ios/commit/c9fb2d91a4278d22da9151a8b49b546d6217e628) (Cody Weaver)
* [[BottomNavigation, Math] Fix `BOOL` types (#4436)](https://github.com/material-components/material-components-ios/commit/f1bb92ee921050fddb0eaf80f07b0d09a28ef09e) (Robert Moore)

### FlexibleHeader

#### Changes

* [Fix odd scrolling bugs in voiceover (#4485)](https://github.com/material-components/material-components-ios/commit/5dc67c88c06f11761769de1d0bae34ff2c657046) (John Detloff)

---

# 56.0.0

In this release we updated the icon layout of `MDCTextField`s add accessibilty docs for `MDCButton`
and some more `MDCBottomNavigation` examples. We also tweeked the `MDCChipView` and `MDCButtonBar` 
buttons.

## Breaking changes

### New layout for `MDCTextField`'s with icons

* [Making leading and trailing view layout customizeable (#4434)](https://github.com/material-components/material-components-ios/commit/1f10ae3e3e12b8a0b367ae118c7cc7d6e706e8a5) (Will Larche)

## API changes

### TextFields

#### MDCLeadingViewTextInput

*new* protocol: `MDCLeadingViewTextInput`

*new* property: `leadingView` in `MDCLeadingViewTextInput`

*new* property: `leadingViewMode` in `MDCLeadingViewTextInput`

#### MDCTextInputPositioningDelegate

*new* method: `-leadingViewTrailingPaddingConstant` in `MDCTextInputPositioningDelegate`

*new* method: `-leadingViewRectForBounds:defaultRect:` in `MDCTextInputPositioningDelegate`

*new* method: `-trailingViewTrailingPaddingConstant` in `MDCTextInputPositioningDelegate`

*new* method: `-trailingViewRectForBounds:defaultRect:` in `MDCTextInputPositioningDelegate`

#### MDCTextField

*modified* class: `MDCTextField`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCTextField : MDCTextInput` |
| To: | `class MDCTextField : MDCTextInput, MDCLeadingViewTextInput` |

*modified* class: `MDCTextField`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextField : UITextField <MDCTextInput>` |
| To: | `@interface MDCTextField : UITextField <MDCTextInput, MDCLeadingViewTextInput>` |

## Component changes

### Buttons

#### Changes

* [Updated accessibility documentation and examples (#4418)](https://github.com/material-components/material-components-ios/commit/25b0ed9ea21cee6369c7ad00c497b198ed29e589) (Randall Li)

### ButtonBar

#### Changes

* [Update disabled button alpha to match spec (#4430)](https://github.com/material-components/material-components-ios/commit/95751ee02ba8f118f004bee02d66accdd2215add) (Randall Li)

### TextFields

#### Changes

* [Making leading and trailing view layout customizeable (#4434)](https://github.com/material-components/material-components-ios/commit/1f10ae3e3e12b8a0b367ae118c7cc7d6e706e8a5) (Will Larche)

### Chips

#### Changes

* [Update accessibility selected & dimmed states (#4399)](https://github.com/material-components/material-components-ios/commit/9fc828498f6469326a447f5664ab4f1f6977f14f) (galiak11)

### BottomNavigation

#### Changes

* [Add example when we explicitly set color (#4420)](https://github.com/material-components/material-components-ios/commit/a9d508c681543397ea809b5d848986f79566e6be) (Cody Weaver)
* [Update ripple color to match spec. (#4422)](https://github.com/material-components/material-components-ios/commit/beecea91ef9af9ba892ddc0498f0bce5971d1ed4) (Cody Weaver)
* [Use size classes instead of device orientation to determine layout in bottom navigation (#4424)](https://github.com/material-components/material-components-ios/commit/1dd5ee9e4acf9a9eb4622b44e8582f50f322003c) (Andrew Overton)

---

# 55.5.0

## API changes

### TextFields

#### MDCTextField

*new* property: `inputLayoutStrut` in `MDCTextField`

## Component changes

### Buttons

#### Changes

* [Added a11y minimum touch target size to Accessibility section in readme. (#4386)](https://github.com/material-components/material-components-ios/commit/1d692a8ab2597c95b70ec03f36fb7d1d40a2fef8) (Randall Li)

### ButtonBar

#### Changes

* [Add tintColor observation support. (#4380)](https://github.com/material-components/material-components-ios/commit/c1b513ba9eecbfe5513282ca1198fed8f251875f) (featherless)
* [Add unit tests for KVO behavior. (#4379)](https://github.com/material-components/material-components-ios/commit/fc2671fe9400e28d8baf31e1a2a5bb0a6c34389e) (featherless)

### TextFields

#### Changes

* [Add baseline constraint support (#4387)](https://github.com/material-components/material-components-ios/commit/89c2a40911e38376a1e6595eea98d8d35162f5f4) (Will Larche)
* [Example cleanup. (#4392)](https://github.com/material-components/material-components-ios/commit/bc119b3b73778cdebab80a6eeaf0a957cfd5a09b) (Will Larche)
* [TableView example. (#4391)](https://github.com/material-components/material-components-ios/commit/0516f703c89a53dae458574e096de8fa4ee3c888) (Will Larche)
* [Text Input adjustment. (#4389)](https://github.com/material-components/material-components-ios/commit/fc61f064511c7c7bca370121f049ad7387022f09) (Will Larche)

### Chips

#### Changes

* [Adds support for reading contentHorizontalAlignment in MDCChipView. The only supported values so far are Fill (the default now) and Center (the new value). (#4369)](https://github.com/material-components/material-components-ios/commit/d8a1dfc9194e1f70ecc65253d302918659667e63) (compositeprimes)

### BottomNavigation

#### Changes

* [Fix bug when `setItems` does not correctly set items (#4398)](https://github.com/material-components/material-components-ios/commit/1d6444634a9bed1238afb2c7e551502bc38dbcc2) (Cody Weaver)

---

# 55.4.0

This minor release includes better layout guide and safe area insets support to `MDCAppBar`'s `MDCAppBarContainerViewController`, added customization to `MDCNavigationBar` title view layout, accessibility improvements and documentation.

## New deprecations

`MDCNavigationBar`'s property `useFlexibleTopBottomInsets` has been defaulted to `YES` and has now been deprecated. It will eventually be removed and become the default behavior.

## New features

AppBar now allows its wrapped content view controllers to make proper use of the top layout guide and additional safe area insets APIs. This is done using the newly added property to AppBar's `MDCAppBarContainerViewController` named `topLayoutGuideAdjustmentEnabled`.
An example on how to implement this behavior:

```objc
MDCAppBarContainerViewController *appBarContainerViewController;
UITableViewController *tableViewController =
    [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
appBarContainerViewController =
    [[MDCAppBarContainerViewController alloc] initWithContentViewController:tableViewController];
self.appBarContainerViewController.topLayoutGuideAdjustmentEnabled = YES;
```

NavigationBar now allows configuration of its title view layout behavior to be either "fill" or "center". The fill behavior is the default and existing behavior, which sets the title view's frame to fill the available navigation bar space. The center behavior will always attempt to center the title view within the navigation bar's bounds.
The center behavior is desired by teams in the simple cases of when they want their title view to be centered within the navigation bar as best as possible. This is also the default behavior of UINavigationBar.
Example usage:

```objc
MDCNavigationBar *navBar = [[MDCNavigationBar alloc] init];
navBar.titleView = [[UIView alloc] init];
navBar.titleViewLayoutBehavior = MDCNavigationBarTitleViewLayoutBehaviorCenter;
```

## API changes

### AppBar

#### MDCAppBarContainerViewController

*new* property: `topLayoutGuideAdjustmentEnabled` in `MDCAppBarContainerViewController`

### NavigationBar

#### MDCNavigationBar

*new* property: `titleViewLayoutBehavior` in `MDCNavigationBar`

*deprecated* property: `useFlexibleTopBottomInsets` in `MDCNavigationBar`

| Type of change: | Deprecation message |
|---|---|
| From: | `useFlexibleTopBottomInsets` |
| To: | `Implement proper vertical alignment with the default YES behavior.` |

*new* enum `MDCNavigationBarTitleViewLayoutBehavior` with values `MDCNavigationBarTitleViewLayoutBehaviorFill` and `MDCNavigationBarTitleViewLayoutBehaviorCenter`.

## Component changes

### AppBar

#### Changes

* [Add a wrapped table view controller example. (#4336)](https://github.com/material-components/material-components-ios/commit/0e792aacf65d2aaea573437b98f308d998514fb1) (featherless)
* [Add example of an AppBar in a presented vc (#4351)](https://github.com/material-components/material-components-ios/commit/56bdce0b32bf5f12adc908647e5bf422c963cb45) (John Detloff)
* [Fix VoiceOver escape gesture bug. (#4360)](https://github.com/material-components/material-components-ios/commit/944a0947e2661d4c09aae7dac17f58ad7651ea0f) (featherless)
* [Implement topLayoutGuideAdjustmentEnabled on the app bar container. (#4370)](https://github.com/material-components/material-components-ios/commit/9707aec0fd0bb5e0fe667439d6246e0d6e5824ce) (featherless)
* [[NavigationBar] Deprecate useFlexibleTopBottomInsets (#4358)](https://github.com/material-components/material-components-ios/commit/b9086c94c48f7360e9bb4319c873c2f1e80333a9) (Ali Rabbani)

### Buttons

#### Changes

* [Adding Accessibility labels to README and fab example. (#4330)](https://github.com/material-components/material-components-ios/commit/5ec8aa09805051b241a569715d4808ae395db9bf) (Randall Li)

### TextFields

#### Changes

* [Add placeholderLabel accessibilityLabel to textField accessibilityValue (#4319)](https://github.com/material-components/material-components-ios/commit/9bbaaaad6e8f75e0ea93ce3c003c65203c23c654) (Andrew Overton)
* [Tweak accessibility notification to prevent VoiceOver from cutting off (#4364)](https://github.com/material-components/material-components-ios/commit/0b5706dadd4837ddf8d4da45a73ff9a5203c76ee) (Andrew Overton)
* [[Documentation] Update TextField README.md (#4352)](https://github.com/material-components/material-components-ios/commit/fec408500a0891a0218f5ae027b6fdaed4fffa99) (ianegordon)

### Snackbar

#### Changes

* [Fix Earl Grey test (#4349)](https://github.com/material-components/material-components-ios/commit/d9d4b5ca616f847c33649037e04ff63f34c31dbb) (Robert Moore)

### Slider

#### Changes

* [Fix accessibilityIncrement for discrete sliders (#4327)](https://github.com/material-components/material-components-ios/commit/e965234aaf3893452a9b363f9e1dc5cb19eebc41) (John Detloff)
* [Notify VoiceOver of MDCSlider value changes (#4350)](https://github.com/material-components/material-components-ios/commit/ede606f704a8f62e012c104e629ee0fbdd87c179) (Andrew Overton)

### NavigationBar

#### Changes

* [Add a titleViewLayoutBehavior API. (#4371)](https://github.com/material-components/material-components-ios/commit/c7ee146de25c67300816ca10dff5273b173e00e6) (featherless)
* [Deprecate useFlexibleTopBottomInsets (#4358)](https://github.com/material-components/material-components-ios/commit/b9086c94c48f7360e9bb4319c873c2f1e80333a9) (Ali Rabbani)

### BottomSheet

#### Changes

* [Add a short bottom sheet example to MDCCatalog (#4318)](https://github.com/material-components/material-components-ios/commit/18b23ed0e623428dbc49698369b046479975f49c) (featherless)

### Typography

#### Changes

* [[TextFields] Prevents functionally equivalent fonts from causing rendering jumps (#4344)](https://github.com/material-components/material-components-ios/commit/de44925eb609f1a06c6529fbd06ba7d5f80dcfa9) (Will Larche)

### PageControl

#### Changes

* [Make MDCPageControl minimum height adhere to accessibility requirements (#4359)](https://github.com/material-components/material-components-ios/commit/8c3063b2ed58042e49d7e2648e106967bbd01112) (Andrew Overton)

### Collections

#### Changes

* [Remove Earl Grey tests (#4348)](https://github.com/material-components/material-components-ios/commit/acd639cf4d8ece7c8a7ca436889a57c4c50a4e31) (Robert Moore)

### HeaderStackView

#### Changes

* [Change the layout behavior in MDCHeaderStack view to accommodate a topBar with flexible height. (#4355)](https://github.com/material-components/material-components-ios/commit/912bdcb9128e589c99429082d7687391d26d03c3) (Ali Rabbani)

### FlexibleHeader

#### Changes

* [Fix additionalSafeAreaInsets bug when topLayoutGuideAdjustmentEnabled is enabled. (#4354)](https://github.com/material-components/material-components-ios/commit/dc903f95ba532d3c6ffad7677f9468f7be9fb232) (featherless)
* [Only extract the top layout guide if the view has loaded. (#4357)](https://github.com/material-components/material-components-ios/commit/b663fcfa7004d545aa19fbe12f2c3f972e8c19f8) (featherless)

---

# 55.3.0

This minor release includes added customization to `MDCDialogPresentationController`,  better topLayoutGuide support for `MDCFlexibleHeader`, doc improvements and other small bug fixes.

## New features

Flexible header has a new behavioral flag for opting in to better topLayoutGuide support. This is primarily useful when using the flexible header container view controller. To opt in to this new behavior, do the following:

```swift
let container = MDCFlexibleHeaderContainerViewController()
container.isTopLayoutGuideAdjustmentEnabled = true
```

Dialogs now offer customizable cornerRadius support to enable proper shadowing. You can set the dialog corner radius like so:

```swift

// We set the corner radius to adjust the shadow that is implemented via the trackingView in the
// presentation controller.
if let presentationController = presentedController.mdc_dialogPresentationController {
  presentationController.dialogCornerRadius = presentedController.view.layer.cornerRadius
}
```

## API changes

### Dialogs

#### MDCDialogPresentationController

*new* property: `dialogCornerRadius` in `MDCDialogPresentationController`

### FlexibleHeader

#### MDCFlexibleHeaderContainerViewController

*new* property: `topLayoutGuideAdjustmentEnabled` in `MDCFlexibleHeaderContainerViewController`

#### MDCFlexibleHeaderViewController(ToBeDeprecated)

*new* category: `MDCFlexibleHeaderViewController(ToBeDeprecated)`

*moved* method: `-updateTopLayoutGuide` from class `MDCFlexibleHeaderViewController` to category `MDCFlexibleHeaderViewController(ToBeDeprecated)`

#### MDCFlexibleHeaderViewController

*new* property: `topLayoutGuideAdjustmentEnabled` in `MDCFlexibleHeaderViewController`

*new* property: `topLayoutGuideViewController` in `MDCFlexibleHeaderViewController`

## Component changes

### Tabs

#### Changes

* [We should not force viewDidLoad when ViewControllers are set.  (#4230)](https://github.com/material-components/material-components-ios/commit/2bf80cd568f2f5ed14aad02ad4daf93325f54eb8) (Mohammad Cazi)
* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### FeatureHighlight

#### Changes

* [View should not be loaded unless it's explicitly called or presented. (#4234)](https://github.com/material-components/material-components-ios/commit/99f230313517930b85a6b87d6ed479c3577450db) (Mohammad Cazi)
* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)
* [we dismiss and present feature highlight from the new spot. (#4300)](https://github.com/material-components/material-components-ios/commit/e91de068414486355a8426816846b6298a46a533) (Mohammad Cazi)

### AppBar

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### Buttons

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### ButtonBar

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### TextFields

#### Changes

* [Correcting copy mistake. (#4281)](https://github.com/material-components/material-components-ios/commit/d13077450f95f0b436e568a88c757f524f1bbb0f) (Will Larche)
* [Corrects obscure bug of height. (#4297)](https://github.com/material-components/material-components-ios/commit/776a40e409a1c779cbfd6872952e8a462c34ba09) (Will Larche)
* [Documentation update (#4295)](https://github.com/material-components/material-components-ios/commit/520ac156a3953db22436e7c868060fa4e881681e) (Will Larche)
* [Fix notification parameter type (#4249)](https://github.com/material-components/material-components-ios/commit/7cfd4d67a68dab9f5d5e48dd65b2f270d501e3e4) (Robert Moore)
* [Fix text area placeholder (#4274)](https://github.com/material-components/material-components-ios/commit/6f740c8c6281aa48e60ae347a2b39ae98e0e7fcd) (Will Larche)
* [Post SetText notifications for attributed text (#4282)](https://github.com/material-components/material-components-ios/commit/a37b2891535b8f70a520215d36a66d0fb9eb01ab) (Robert Moore)
* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### Chips

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### Snackbar

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### Cards

#### Changes

* [Fix the cards docs image asset.](https://github.com/material-components/material-components-ios/commit/790062b34f67c74b89b9a1d0a6d919045af67933) (Jeff Verkoeyen)
* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### BottomAppBar

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### Slider

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### NavigationBar

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### ActivityIndicator

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### BottomSheet

#### Changes

* [Add an app bar to the typical use example. (#4268)](https://github.com/material-components/material-components-ios/commit/0575212f1ce0e97eadfbd512adb24a2e21924230) (featherless)
* [Fix layout issues caused by invoking self.dismissOnBackgroundTap in -init (#4241)](https://github.com/material-components/material-components-ios/commit/2c80a9509e35d0288f26c9b6f720b4eb5fd95d83) (featherless)

### Dialogs

#### Changes

* [Add customizable cornerRadius to enable proper shadowing (#4233)](https://github.com/material-components/material-components-ios/commit/02d19e08ad3953624ecd4741aeda2a45db0f3709) (ianegordon)
* [AlertController button layout issue (#4291)](https://github.com/material-components/material-components-ios/commit/cacd2e2fdda6551dda9e523cd17741440439c971) (ianegordon)
* [Setting Properties on Alert controller will not force the view to load. (#4238)](https://github.com/material-components/material-components-ios/commit/39030e7b2040e930e47deb3c3667374b320203bc) (Mohammad Cazi)
* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### BottomNavigation

#### Changes

* [Correct long title layout (#4303)](https://github.com/material-components/material-components-ios/commit/4975c38a41977a1aabe4f08f8956886063b94369) (Robert Moore)
* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### PageControl

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### FlexibleHeader

#### Changes

* [Fixed behavior for top layout guide and safe area insets. (#4214)](https://github.com/material-components/material-components-ios/commit/80fd217f766e0f5be6a3bc6bef5923f231721f9d) (featherless)
* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

### ProgressView

#### Changes

* [[Docs] Add badges to all components. (#4278)](https://github.com/material-components/material-components-ios/commit/e1e6d249a4f554ff76c36a49dcae8a824552ea58) (featherless)

---

# 55.2.0

This minor release includes new Snackbar features and minor improvements to the Catalog.

## New features

Snackbar now allows you to change the snackbar message alignment on iPad. For example:

```objc
MDCSnackbarManager.alignment = MDCSnackbarAlignmentLeading;
```

Snackbar also exposes a delegate for theming snackbar messages.

```objc
MDCSnackbarManager.delegate = appDelegate;

- (void)willPresentSnackbarWithMessageView:(nullable MDCSnackbarMessageView *)messageView {
  // You can theme the individual messageView.actionButtons here.
}
```

There is a new shadow elevation constant, `MDCShadowElevationBottomNavigationBar`.

## API changes

### ShadowElevations

#### MDCShadowElevationBottomNavigationBar

*new* constant: `MDCShadowElevationBottomNavigationBar`

### Snackbar

#### MDCSnackbarAlignment

*new* enum value: `MDCSnackbarAlignmentCenter` in `MDCSnackbarAlignment`

*new* enum value: `MDCSnackbarAlignmentLeading` in `MDCSnackbarAlignment`

*new* enum: `MDCSnackbarAlignment`

#### MDCSnackbarMessageView

*new* property: `actionButtons` in `MDCSnackbarMessageView`

#### MDCSnackbarManager

*new* property: `delegate` in `MDCSnackbarManager`

*new* property: `alignment` in `MDCSnackbarManager`

#### MDCSnackbarManagerDelegate

*new* protocol: `MDCSnackbarManagerDelegate`

*new* method: `-willPresentSnackbarWithMessageView:` in `MDCSnackbarManagerDelegate`

## Component changes

### Tabs

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### schemes/Typography

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### FeatureHighlight

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### AppBar

#### Changes

* [Create an example of MDCAppBarContainerViewController usage (#4197)](https://github.com/material-components/material-components-ios/commit/82afdff90d2f40a6c8830c70360943269c821553) (John Detloff)
* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### Buttons

#### Changes

* [Disable flaky test. (#4157)](https://github.com/material-components/material-components-ios/commit/480ceda7225a8dc8b0503e06ecc6407c2ebf0a8c) (featherless)
* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### ButtonBar

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### TextFields

#### Changes

* [Getting rid of paddedLabel Class since it's not needed anymore. (#4196)](https://github.com/material-components/material-components-ios/commit/9e7db06c7e917cd8fa023f6d885ae58ffa2a74cd) (Mohammad Cazi)

### Chips

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### Snackbar

#### Changes

* [Allow Snackbars to have leading alignment on iPads (#4163)](https://github.com/material-components/material-components-ios/commit/fe0780ce5592553f0b2fce2116f82a5381731afd) (Andrew Overton)
* [Exposed the snackbar button class (#4171)](https://github.com/material-components/material-components-ios/commit/b9d4698caa1d3652ccddf2f86c18e4838a093674) (Yarden Eitan)

### Slider

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### NavigationBar

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### ActivityIndicator

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### Typography

#### Changes

* [Add unit test to improve coverage (#4198)](https://github.com/material-components/material-components-ios/commit/5f0e12550df56a9db112aaae5617cad4f4a1ff6d) (ianegordon)

### Dialogs

#### Changes

* [Initialize default color and typography schemes in examples (#4200)](https://github.com/material-components/material-components-ios/commit/0c0ce4248edb23aeed4d139a55367192edff710c) (John Detloff)

### BottomNavigation

#### Changes

* [Fix shadow elevation value (#4195)](https://github.com/material-components/material-components-ios/commit/7bf1c4ad8f6d0e974431aa512db5f542d2046131) (Robert Moore)

### FlexibleHeader

#### Changes

* [Always update opacity for views that hide when shifted. (#4170)](https://github.com/material-components/material-components-ios/commit/28b93d5bbf32412a67f101068c2a1b7fedaaeaab) (featherless)

### ShadowElevations

#### Changes

* [Expose BottomNavigationBar elevation (#4194)](https://github.com/material-components/material-components-ios/commit/fb77f5c42cd5ec5c031775cef4d2402b7ae83387) (Robert Moore)

---

# 55.1.0

This minor release introduces some new features to Flexible Header and Snackbar and includes some
bug fixes in the Catalog app.

## Upcoming deprecations

MDCFlexibleHeaderViewController's `-updateTopLayoutGuide` will be deprecated in the future. It
should no longer be necessary to call this API if you are using an
`MDCFlexibleHeaderContainerViewController`.

## API changes

### Snackbar

#### MDCSnackbarManager

*new* class method: `+hasMessagesShowingOrQueued` in `MDCSnackbarManager`

## Component changes

### Tabs

#### Changes

* ["Add" button shows when needed (#3739)](https://github.com/material-components/material-components-ios/commit/957f3fa127e5d7b11c4f01251efe5e48d53efa8e) (Robert Moore)

### schemes/Color

#### Changes

* [[schemes] Fix docsite generation due to missing and malformed metadata. (#4151)](https://github.com/material-components/material-components-ios/commit/8c036dbace4c4e2f76cf4c624984f77a0d4c6009) (featherless)

### schemes/Typography

#### Changes

* [[schemes] Fix docsite generation due to missing and malformed metadata. (#4151)](https://github.com/material-components/material-components-ios/commit/8c036dbace4c4e2f76cf4c624984f77a0d4c6009) (featherless)

### FeatureHighlight

#### Changes

* [Color Should be a dragon example. (#3743)](https://github.com/material-components/material-components-ios/commit/8b4c29328773709d24fcaaf92fd9dd36d174fb91) (Mohammad Cazi)
* [[Catalog] Feature highlight should be triggered from a separate Button. (#3742)](https://github.com/material-components/material-components-ios/commit/f1b919ed5b8f711dde60397b39a05aba88ea7584) (Mohammad Cazi)
* [[Catalog] FeatureHighlight should be themed according to global theming. (#3738)](https://github.com/material-components/material-components-ios/commit/6e7ed439ced27c3dc58af242be886f64f0bebf46) (Mohammad Cazi)
* [title not attributed. (#4175)](https://github.com/material-components/material-components-ios/commit/5ed1f44fb19d8881073198e4de4106b936a55320) (Mohammad Cazi)

### Buttons

#### Changes

* [FAB button in shapes example should be themed. (#3737)](https://github.com/material-components/material-components-ios/commit/988a577902dce2acc59952760fd6b8fb84bc78f4) (Mohammad Cazi)
* [Fix updateTitles to prevent crash (#4153)](https://github.com/material-components/material-components-ios/commit/f8e2d2872ab947ac847ecc8dfcf4df9a17cb06bc) (Robert Moore)

### Snackbar

#### Changes

* [add hasMessagesShowingOrQueued method (#4168)](https://github.com/material-components/material-components-ios/commit/9dc4065db7b4f41ca0544f583581c982a5358c1a) (Yarden Eitan)

### Cards

#### Changes

* ['Edit' button should show action, not state (#3733)](https://github.com/material-components/material-components-ios/commit/9cef13c1a7ce68f0b2fe67435436fa98891f3e21) (Robert Moore)

### BottomAppBar

#### Changes

* [Add an app bar to the bottom app bar demo (#3760)](https://github.com/material-components/material-components-ios/commit/bf21b5a2e673b527bb25d0fa3c0f01e9d62b65a2) (John Detloff)
* [Make FAB visibility a switch (#3734)](https://github.com/material-components/material-components-ios/commit/ef522de732c5c283dd217f7d4c1b85a2d6e6b97e) (Robert Moore)
* [[Catalog] Bottom App bar should theme the FAB Button. (#3740)](https://github.com/material-components/material-components-ios/commit/116071bf966e731257eb5fed6350b6b97242cef2) (Mohammad Cazi)

### Dialogs

#### Changes

* [Make "modal" dialog "non-dismissable" (#3736)](https://github.com/material-components/material-components-ios/commit/b63c534ada8437f5ec9e2d707671fcd24677a1aa) (Robert Moore)

### Themes

#### Changes

* [Add simple unit test (#4147)](https://github.com/material-components/material-components-ios/commit/128a545a21d2338760cc8b6d83ffaa60d1ca8f96) (Robert Moore)

### ShadowElevations

#### Changes

* [[Shadow Elevation] Changed slider to be discrete to make it more clear that the named labels are for specific values of the slider. (#3741)](https://github.com/material-components/material-components-ios/commit/f6e04eb72c2597813d6ffa78cf5e1494262aa97a) (Randall Li)

---

# 55.0.4

This patch release adds metadata to the bidirectionality eng stub doc.

---

# 55.0.3

This patch release adds documentation polish around bidirectionality.

---

# 55.0.2

This patch release includes more documentation polish and a bug fix for Cards theming.

## Component changes

### Tabs

#### Changes

* [Reorder image assets.](https://github.com/material-components/material-components-ios/commit/4272dc0074b4f453a10f136bfbfd5e90e074057c) (Jeff Verkoeyen)

### schemes/Color

#### Changes

* [[Theming] Consolidate the theming documentation into one folder on the site.](https://github.com/material-components/material-components-ios/commit/15d7f006f622acf0bf7dd619b87c734260c0e999) (Jeff Verkoeyen)

### schemes/Typography

#### Changes

* [[Theming] Consolidate the theming documentation into one folder on the site.](https://github.com/material-components/material-components-ios/commit/15d7f006f622acf0bf7dd619b87c734260c0e999) (Jeff Verkoeyen)

### FeatureHighlight

#### Changes

* [Reorder image assets.](https://github.com/material-components/material-components-ios/commit/4272dc0074b4f453a10f136bfbfd5e90e074057c) (Jeff Verkoeyen)

### Ink

#### Changes

* [Make a gif.](https://github.com/material-components/material-components-ios/commit/fe2431b66db96609613f989f300e902ce4a380a4) (Jeff Verkoeyen)

### Buttons

#### Changes

* [Avoid picking up class properties in the API table for READMEs.](https://github.com/material-components/material-components-ios/commit/f059a37d5040ea85f7fe005e759efff9678bb86c) (Jeff Verkoeyen)
* [Update material.io/go/design-theming shortlink to material.io/go/design-color-theming.](https://github.com/material-components/material-components-ios/commit/8cf0cb3e14e6f6bceb8e857f9e7e9170e2cc136a) (Adrian Secord)

### ButtonBar

#### Changes

* [Avoid picking up class properties in the API table for READMEs.](https://github.com/material-components/material-components-ios/commit/f059a37d5040ea85f7fe005e759efff9678bb86c) (Jeff Verkoeyen)

### TextFields

#### Changes

* [Regenerate the readme.](https://github.com/material-components/material-components-ios/commit/dd122f98a8ea4328d3f857191f1dc5a87f4fc24b) (Jeff Verkoeyen)
* [Reorder image assets.](https://github.com/material-components/material-components-ios/commit/4272dc0074b4f453a10f136bfbfd5e90e074057c) (Jeff Verkoeyen)

### Chips

#### Changes

* [Update the intro copy.](https://github.com/material-components/material-components-ios/commit/fc6f997f6c907d09770ec259570a058450b2375e) (Jeff Verkoeyen)

### Snackbar

#### Changes

* [Avoid picking up class properties in the API table for READMEs.](https://github.com/material-components/material-components-ios/commit/f059a37d5040ea85f7fe005e759efff9678bb86c) (Jeff Verkoeyen)
* [Reorder image assets.](https://github.com/material-components/material-components-ios/commit/4272dc0074b4f453a10f136bfbfd5e90e074057c) (Jeff Verkoeyen)

### Cards

#### Changes

* [Fix examples and themer (#3700)](https://github.com/material-components/material-components-ios/commit/96933c385f2aa80b9199143f3cb23bb345a1d8d9) (Yarden Eitan)

### BottomAppBar

#### Changes

* [Avoid picking up class properties in the API table for READMEs.](https://github.com/material-components/material-components-ios/commit/f059a37d5040ea85f7fe005e759efff9678bb86c) (Jeff Verkoeyen)

### Slider

#### Changes

* [Reorder image assets.](https://github.com/material-components/material-components-ios/commit/4272dc0074b4f453a10f136bfbfd5e90e074057c) (Jeff Verkoeyen)

### LibraryInfo

#### Changes

* [Add a header and intro blurb.](https://github.com/material-components/material-components-ios/commit/1c53439fa899ddbdd44738995024f92337bc5d50) (Jeff Verkoeyen)

### ShadowLayer

#### Changes

* [Tidy up links for shadows and progress indicators.](https://github.com/material-components/material-components-ios/commit/8f8c0819d368581101ab00b038b5f543c7c18c94) (Jeff Verkoeyen)
* [[Shadow] Reorder screenshots.](https://github.com/material-components/material-components-ios/commit/651031dc569e9fcd5007fd1e97dbf53dd5fe6a62) (Jeff Verkoeyen)

### BottomSheet

#### Changes

* [Reorder image assets.](https://github.com/material-components/material-components-ios/commit/4272dc0074b4f453a10f136bfbfd5e90e074057c) (Jeff Verkoeyen)

### Dialogs

#### Changes

* [Update the copy and make a gif.](https://github.com/material-components/material-components-ios/commit/d16824c765c4f4667ea6c5551ebe4ab399a8e121) (Jeff Verkoeyen)

### PageControl

#### Changes

* [Add gif.](https://github.com/material-components/material-components-ios/commit/28845deb5a74fdc8d9422412ea5de5bc395ad8de) (Jeff Verkoeyen)

### FlexibleHeader

#### Changes

* [Avoid picking up class properties in the API table for READMEs.](https://github.com/material-components/material-components-ios/commit/f059a37d5040ea85f7fe005e759efff9678bb86c) (Jeff Verkoeyen)

### ShadowElevations

#### Changes

* [[Shadow] Reorder screenshots.](https://github.com/material-components/material-components-ios/commit/651031dc569e9fcd5007fd1e97dbf53dd5fe6a62) (Jeff Verkoeyen)

### ProgressView

#### Changes

* [Tidy up the docs and links.](https://github.com/material-components/material-components-ios/commit/fb0f5a1cbb19f2c8a4116dd85468891b4492e895) (Jeff Verkoeyen)

### Palettes

#### Changes

* [Remove screenshot.](https://github.com/material-components/material-components-ios/commit/805bb5769eb13233d87828219b80a422402725bb) (Jeff Verkoeyen)
* [Update material.io/go/design-theming shortlink to material.io/go/design-color-theming.](https://github.com/material-components/material-components-ios/commit/8cf0cb3e14e6f6bceb8e857f9e7e9170e2cc136a) (Adrian Secord)

---

# 55.0.1

This patch release polishes and fleshes out documentation across many of our components. There are
no source changes in this release.

## Component changes

### MaskedTransition

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### schemes/Color

#### Changes

* [Fix more casings.](https://github.com/material-components/material-components-ios/commit/ee0eeb7f511f639f6aaedd31ff764d44aefcc26d) (Jeff Verkoeyen)
* [Fix scheme links.](https://github.com/material-components/material-components-ios/commit/a9f0b65a1606a13588f5cfbe6421998eaf507fa4) (Jeff Verkoeyen)

### schemes/Typography

#### Changes

* [Fix more casings.](https://github.com/material-components/material-components-ios/commit/ee0eeb7f511f639f6aaedd31ff764d44aefcc26d) (Jeff Verkoeyen)
* [Fix scheme links.](https://github.com/material-components/material-components-ios/commit/a9f0b65a1606a13588f5cfbe6421998eaf507fa4) (Jeff Verkoeyen)
* [[Typography] Ensure that typography scheme is showing up on the site. (#3694)](https://github.com/material-components/material-components-ios/commit/a06a62beb062b40bbe1d93c9bab1900c13b37cde) (featherless)

### FeatureHighlight

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### AppBar

#### Changes

* [Update site naming for top and bottom app bars to match spec. (#3680)](https://github.com/material-components/material-components-ios/commit/c166652ae6977c26146a6450751d2580fbbd58f3) (featherless)

### CollectionCells

#### Changes

* [[Collections] Add deprecation notice to the readmes and remove from the site. (#3695)](https://github.com/material-components/material-components-ios/commit/8ec943f57df1f29a080022b1eae34ef2d0b9c123) (featherless)
* [[Collections] Mark all examples as dragons. (#3697)](https://github.com/material-components/material-components-ios/commit/01e592cb72481551a93d407bb2e29b5f1c5638d3) (featherless)

### ButtonBar

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### TextFields

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### Cards

#### Changes

* [Make the site title be "Cards".](https://github.com/material-components/material-components-ios/commit/2c0a515df60c282048e8c674d8d109877bfbf520) (Jeff Verkoeyen)
* [Update image and docs.](https://github.com/material-components/material-components-ios/commit/d94e03161ad0841116ff02dfb03b49e52c08b403) (Jeff Verkoeyen)

### BottomAppBar

#### Changes

* [Add gif for bottom navigation and fix alt text in bottom app bar.](https://github.com/material-components/material-components-ios/commit/72ccfa73426c7d42cbdd7377f5fcb38faae8c89e) (Jeff Verkoeyen)
* [Crop the screenshot to emphasize the bottom app bar.](https://github.com/material-components/material-components-ios/commit/1d85f287a00d960f7a9f64125467c859af6c1294) (Jeff Verkoeyen)
* [Touch up the readme intro copy and image ordering.](https://github.com/material-components/material-components-ios/commit/75f367e61cbfabad9d84ea36d5b376c597893124) (Jeff Verkoeyen)
* [Update site naming for top and bottom app bars to match spec. (#3680)](https://github.com/material-components/material-components-ios/commit/c166652ae6977c26146a6450751d2580fbbd58f3) (featherless)

### NavigationBar

#### Changes

* [Fix ordering of header stack view and navigation bar intro text.](https://github.com/material-components/material-components-ios/commit/ead0ae49365d2db3778116798613110cb1ebdbdc) (Jeff Verkoeyen)
* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)
* [Update header stack view and navigation bar screenshots.](https://github.com/material-components/material-components-ios/commit/087d22f441e06c835b5a27f8228a1ca71eaf96e7) (Jeff Verkoeyen)

### OverlayWindow

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### ShadowLayer

#### Changes

* [Fix more casings.](https://github.com/material-components/material-components-ios/commit/ee0eeb7f511f639f6aaedd31ff764d44aefcc26d) (Jeff Verkoeyen)

### ActivityIndicator

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### BottomSheet

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### BottomNavigation

#### Changes

* [Add gif for bottom navigation and fix alt text in bottom app bar.](https://github.com/material-components/material-components-ios/commit/72ccfa73426c7d42cbdd7377f5fcb38faae8c89e) (Jeff Verkoeyen)
* [Remove redundant link and update copy.](https://github.com/material-components/material-components-ios/commit/c8b8acabf8c78b9e266c33803848e9e67967fe73) (Jeff Verkoeyen)
* [Shrink the gif.](https://github.com/material-components/material-components-ios/commit/e7b2b2c8e8888bd0525830613783c0c06b747fe4) (Jeff Verkoeyen)
* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### PageControl

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### AnimationTiming

#### Changes

* [Move animation below the intro text.](https://github.com/material-components/material-components-ios/commit/7af5818beffd68470a7a39670a3dc793b7a228eb) (Jeff Verkoeyen)
* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)
* [Update the copy.](https://github.com/material-components/material-components-ios/commit/e777fe00d330bafb98eeacaee093bbe020af5d40) (Jeff Verkoeyen)

### Collections

#### Changes

* [Add deprecation notice to the readmes and remove from the site. (#3695)](https://github.com/material-components/material-components-ios/commit/8ec943f57df1f29a080022b1eae34ef2d0b9c123) (featherless)
* [Mark all examples as dragons. (#3697)](https://github.com/material-components/material-components-ios/commit/01e592cb72481551a93d407bb2e29b5f1c5638d3) (featherless)

### HeaderStackView

#### Changes

* [Fix ordering of header stack view and navigation bar intro text.](https://github.com/material-components/material-components-ios/commit/ead0ae49365d2db3778116798613110cb1ebdbdc) (Jeff Verkoeyen)
* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)
* [Update header stack view and navigation bar screenshots.](https://github.com/material-components/material-components-ios/commit/087d22f441e06c835b5a27f8228a1ca71eaf96e7) (Jeff Verkoeyen)

### FlexibleHeader

#### Changes

* [Add a gif for the docs.](https://github.com/material-components/material-components-ios/commit/1f3953d88ee0391494c4076140f8f1e1325ae1ad) (Jeff Verkoeyen)
* [Fix casing in the site nav.](https://github.com/material-components/material-components-ios/commit/06c210637d8e24b6b8f7c342e9da28d34abe3f94) (Jeff Verkoeyen)
* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### ShadowElevations

#### Changes

* [Fix more casings.](https://github.com/material-components/material-components-ios/commit/ee0eeb7f511f639f6aaedd31ff764d44aefcc26d) (Jeff Verkoeyen)

### ProgressView

#### Changes

* [Standardize the casing for all components to match spec. (#3693)](https://github.com/material-components/material-components-ios/commit/a078a9722d9806dbac7bc63af976efe043e6d858) (featherless)

### CollectionLayoutAttributes

#### Changes

* [[Collections] Add deprecation notice to the readmes and remove from the site. (#3695)](https://github.com/material-components/material-components-ios/commit/8ec943f57df1f29a080022b1eae34ef2d0b9c123) (featherless)

---

# 55.0.0

This major release introduces breaking changes to CocoaPods dependencies. Please read the breaking
changes section for more details.

This release also includes a significant amount of documnetation polish and some accessibility bug
fixes.

## Breaking changes

CocoaPods +Extension targets have been removed and replaced with more specific targets for the
individual extensions. For example, if you were importing a component's extensions like this before:

```
pod 'MaterialComponents/Buttons+Extensions'
```

You'll now need to depend on the individual Button extension targets that you're making use of:

```
pod 'MaterialComponents/Buttons+ButtonThemer'
```

To see a full list of available extensions for a given component, read the
MaterialComponents.podspec file.

## API changes

## Component changes

### Tabs

#### Changes

* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Rename Examples.md to examples.md](https://github.com/material-components/material-components-ios/commit/a26665e9a793109d2848f0aaa7197f3c572f4cab) (Mohammad Cazi)
* [Rename Usage.md to usage.md](https://github.com/material-components/material-components-ios/commit/e9923dd93397be3fd3e3129cbc1adb7ed77f09b4) (Mohammad Cazi)
* [Update README.md](https://github.com/material-components/material-components-ios/commit/8d8b459e97e6a86e4646fa3f864cf415e6c65d32) (Mohammad Cazi)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)
* [readme update. (#3613)](https://github.com/material-components/material-components-ios/commit/f84e745a990136fa4e2ba1021593848de0150eb7) (Mohammad Cazi)
* [regenerating tabs after file change. (#3623)](https://github.com/material-components/material-components-ios/commit/7f9214eae3a37238c77b8d2dffcb65380c686d9a) (Mohammad Cazi)

### schemes/Color

#### Changes

* [Fix build breakage.](https://github.com/material-components/material-components-ios/commit/09043a3e2ce57faa677a01eeb2d30607377f3887) (Jeff Verkoeyen)
* [Update the default error color to match spec. (#3591)](https://github.com/material-components/material-components-ios/commit/31140876fb8bcb263667538dce91fe96d39b525e) (featherless)
* [[Themes] Add deprecation notice to APIs and remove from the site. (#3636)](https://github.com/material-components/material-components-ios/commit/cd3a53c263f3b8968a9d947ecf2bd46ebe7c756a) (featherless)
* [[schemes/Color Flesh out the documentation. (#3668)](https://github.com/material-components/material-components-ios/commit/f8b40770f70660b55282f437ed4aa6ec67599cc8) (featherless)

### schemes/Typography

#### Changes

* [Add docs stubs. (#3609)](https://github.com/material-components/material-components-ios/commit/2979d1494aa065595ee33cb9f095119afc997053) (featherless)
* [[Themes] Add deprecation notice to APIs and remove from the site. (#3636)](https://github.com/material-components/material-components-ios/commit/cd3a53c263f3b8968a9d947ecf2bd46ebe7c756a) (featherless)
* [[Typography] Add TypographyScheme example (#3607)](https://github.com/material-components/material-components-ios/commit/3ba99c280b5bf9a7499dbbd334e691811713150d) (Robert Moore)
* [[Typography] Preliminary Typography Scheme README (#3671)](https://github.com/material-components/material-components-ios/commit/fa87fde4b96f9b23f65beaf851b55fac50d83562) (ianegordon)

### FeatureHighlight

#### Changes

* [Allow setting accessibilityHint (#3649)](https://github.com/material-components/material-components-ios/commit/47c1bcb5d33772e9ef4e48d4e0aadba7f8ebd404) (Robert Moore)
* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Remove theming preambles and regenerate root readme. (#3635)](https://github.com/material-components/material-components-ios/commit/de2bd52da695e2fddb08ee3888e646f19cf6e967) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3620)](https://github.com/material-components/material-components-ios/commit/c1fc4e728b26b75df2bb04d30a3f0ffb011fbd70) (featherless)

### AppBar

#### Changes

* [Add animated gif to the readme. (#3677)](https://github.com/material-components/material-components-ios/commit/8d7dda64e307d855967b02c93ffba3e136b0e5f5) (featherless)
* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Make the App Bar appear as "Top App Bar" in the docsite. (#3670)](https://github.com/material-components/material-components-ios/commit/a312ab1b3065f9154c0cf778cb565db30839e996) (featherless)
* [Make the interface builder and modal presentation examples be dragons. (#3659)](https://github.com/material-components/material-components-ios/commit/c2b286d559b9dbcdee3edb0d05aec082b632be3e) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3634)](https://github.com/material-components/material-components-ios/commit/1e80136d29ce0283123cc5fbda25fc2b324eceb9) (featherless)

### Buttons

#### Changes

* [Add documentation describing variants to buttons, chips and cards (#3600)](https://github.com/material-components/material-components-ios/commit/045e93e669cf1e08de486a4e17e4695e3d722f46) (John Detloff)
* [Add outlined button gif. (#3639)](https://github.com/material-components/material-components-ios/commit/06667639354c75c66e16c076cc0096e5f2b45dfd) (featherless)
* [Break the docs into separate articles and run the readme generator. (#3605)](https://github.com/material-components/material-components-ios/commit/5ec3e78a50e943e40885e66067ca1e77c52ea179) (featherless)
* [Ensure buttons and cards reset their states correctly (#3599)](https://github.com/material-components/material-components-ios/commit/d471d4324cef89a83b4cc12d41ba66dc3747492b) (John Detloff)
* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Theme the typical use example with the injected schemes. (#3603)](https://github.com/material-components/material-components-ios/commit/966a70e86d99483a7476e431f4dacde0e7369a38) (featherless)
* [[scripts] Ensure that asset urls are remapped when generating readmes. (#3640)](https://github.com/material-components/material-components-ios/commit/91eca05769ab4bf976d16e9c4026d2bfdb2e1c7b) (featherless)

### ButtonBar

#### Changes

* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Mark all of the AppBar implementation component examples as dragons. (#3596)](https://github.com/material-components/material-components-ios/commit/d0866fc6f0388456ec33f180d55c941a72bb9396) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Remove from the website. (#3638)](https://github.com/material-components/material-components-ios/commit/3e2cca9e9856d4c9f990194a771ab9a20e22eebc) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3614)](https://github.com/material-components/material-components-ios/commit/74d0320132306f690db3f44c61742ac4c6c8820f) (featherless)

### TextFields

#### Changes

* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)
* [[TextField] floating placeholder overlaps with border. (#3606)](https://github.com/material-components/material-components-ios/commit/a0aa72556756cb48dbf8c579fb9285f82fa441c8) (Mohammad Cazi)
* [[Textfields] readme auto generated update. (#3628)](https://github.com/material-components/material-components-ios/commit/c18026c59eafb4345445ad3b2c23ece70a27307b) (Mohammad Cazi)
* [[scripts] Ensure that asset urls are remapped when generating readmes. (#3640)](https://github.com/material-components/material-components-ios/commit/91eca05769ab4bf976d16e9c4026d2bfdb2e1c7b) (featherless)
* [fixing color mapping for floatingNormal and floatingActive Colors. (#3617)](https://github.com/material-components/material-components-ios/commit/7e3c5ae10731e08daead0052f1b15319fbe0fa16) (Mohammad Cazi)

### Chips

#### Changes

* [Add documentation describing variants to buttons, chips and cards (#3600)](https://github.com/material-components/material-components-ios/commit/045e93e669cf1e08de486a4e17e4695e3d722f46) (John Detloff)
* [Auto Generated README update. (#3621)](https://github.com/material-components/material-components-ios/commit/2835de1ac5be29d0ef80ff819ff5893b0aadf73b) (Mohammad Cazi)
* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Replace "stroked" with "outlined" in the examples. (#3647)](https://github.com/material-components/material-components-ios/commit/3cd06801bbd24e82ea5d997533972937291c2634) (featherless)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)

### Snackbar

#### Changes

* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Global replace of "utilize" vs "use". (#3662)](https://github.com/material-components/material-components-ios/commit/14b9c1503f5a5de900413f44472f99fab38d2738) (Adrian Secord)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3627)](https://github.com/material-components/material-components-ios/commit/af0fb05ae59480765040520c8aee7c7f4ad0d098) (featherless)

### Cards

#### Changes

* [Add documentation describing variants to buttons, chips and cards (#3600)](https://github.com/material-components/material-components-ios/commit/045e93e669cf1e08de486a4e17e4695e3d722f46) (John Detloff)
* [Ensure buttons and cards reset their states correctly (#3599)](https://github.com/material-components/material-components-ios/commit/d471d4324cef89a83b4cc12d41ba66dc3747492b) (John Detloff)
* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Global replace of "utilize" vs "use". (#3662)](https://github.com/material-components/material-components-ios/commit/14b9c1503f5a5de900413f44472f99fab38d2738) (Adrian Secord)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3618)](https://github.com/material-components/material-components-ios/commit/a3ad2dde8a947fbdc0db2928d853e0d818f1a0a4) (featherless)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)

### BottomAppBar

#### Changes

* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3615)](https://github.com/material-components/material-components-ios/commit/ff1022a690258225af327a252391dc3ca9fbdadb) (featherless)

### Slider

#### Changes

* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3626)](https://github.com/material-components/material-components-ios/commit/854e234091ab2391d3cc7a3f5e6b7780535bfaaa) (featherless)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)

### NavigationBar

#### Changes

* [Fix broken link. (#3632)](https://github.com/material-components/material-components-ios/commit/574e115a7b267641bcf3669bd6522b553b641269) (featherless)
* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Mark all of the AppBar implementation component examples as dragons. (#3596)](https://github.com/material-components/material-components-ios/commit/d0866fc6f0388456ec33f180d55c941a72bb9396) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3622)](https://github.com/material-components/material-components-ios/commit/7ebaeb51bef3d0b1aa052448d4f434e1ae3d26c4) (featherless)
* [[AppBar] Nest all of the implementation detail components under AppBar.](https://github.com/material-components/material-components-ios/commit/c541893c30bc151589432c24cdb5d839038e63f1) (featherless)
* [[ButtonBar] Remove from the website. (#3638)](https://github.com/material-components/material-components-ios/commit/3e2cca9e9856d4c9f990194a771ab9a20e22eebc) (featherless)

### ShadowLayer

#### Changes

* [Global replace of "utilize" vs "use". (#3662)](https://github.com/material-components/material-components-ios/commit/14b9c1503f5a5de900413f44472f99fab38d2738) (Adrian Secord)

### ActivityIndicator

#### Changes

* [ Break the docs into separate articles and run the readme generator. (#3608)](https://github.com/material-components/material-components-ios/commit/00d40923c4e35da2beed828ce1d3821d50d4bcf1) (featherless)
* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)

### BottomSheet

#### Changes

* [Fix issue causing black squares on bottom sheet rotation (#3630)](https://github.com/material-components/material-components-ios/commit/f12feaea2b5fb312538a138207112327d2384d79) (John Detloff)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)

### Typography

#### Changes

* [Add TypographyScheme example (#3607)](https://github.com/material-components/material-components-ios/commit/3ba99c280b5bf9a7499dbbd334e691811713150d) (Robert Moore)
* [Add deprecation notice to the MDCTypography APIs and README (#3633)](https://github.com/material-components/material-components-ios/commit/fa155e0d1765381b8b2cca575008bedfb1d29428) (featherless)

### Dialogs

#### Changes

* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Global replace of "utilize" vs "use". (#3662)](https://github.com/material-components/material-components-ios/commit/14b9c1503f5a5de900413f44472f99fab38d2738) (Adrian Secord)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3619)](https://github.com/material-components/material-components-ios/commit/ce9f1e0bbf5234ec373976074f0fda16d22d35d3) (featherless)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)

### BottomNavigation

#### Changes

* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3616)](https://github.com/material-components/material-components-ios/commit/d2b8f7618ecada20392d4fcadfa324c188d6b7c4) (featherless)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)
* [[scripts] Ensure that asset urls are remapped when generating readmes. (#3640)](https://github.com/material-components/material-components-ios/commit/91eca05769ab4bf976d16e9c4026d2bfdb2e1c7b) (featherless)

### PageControl

#### Changes

* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3624)](https://github.com/material-components/material-components-ios/commit/ec4ec5fa2aafe31910b4625840e0beec8564a588) (featherless)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)

### AnimationTiming

#### Changes

* [Add a gif to the readme. (#3641)](https://github.com/material-components/material-components-ios/commit/6d02252fafab9243101b9a8022977e6488284baf) (featherless)

### Collections

#### Changes

* [Global replace of "utilize" vs "use". (#3662)](https://github.com/material-components/material-components-ios/commit/14b9c1503f5a5de900413f44472f99fab38d2738) (Adrian Secord)

### HeaderStackView

#### Changes

* [Mark all of the AppBar implementation component examples as dragons. (#3596)](https://github.com/material-components/material-components-ios/commit/d0866fc6f0388456ec33f180d55c941a72bb9396) (featherless)
* [Remove color theming docs and mark the color themer as to be deprecated. (#3612)](https://github.com/material-components/material-components-ios/commit/e76147d8cd85ff1df6fcefe8c9fae9c87fdde818) (featherless)
* [[AppBar] Nest all of the implementation detail components under AppBar.](https://github.com/material-components/material-components-ios/commit/c541893c30bc151589432c24cdb5d839038e63f1) (featherless)

### FlexibleHeader

#### Changes

* [Flatten all +Extensions CocoaPods targets into standalone targets.  (#3572)](https://github.com/material-components/material-components-ios/commit/037bf7d0f0baee504a7f8111ece785fd33b0f722) (featherless)
* [Global replace of "utilize" vs "use". (#3662)](https://github.com/material-components/material-components-ios/commit/14b9c1503f5a5de900413f44472f99fab38d2738) (Adrian Secord)
* [Mark all of the AppBar implementation component examples as dragons. (#3596)](https://github.com/material-components/material-components-ios/commit/d0866fc6f0388456ec33f180d55c941a72bb9396) (featherless)
* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3610)](https://github.com/material-components/material-components-ios/commit/e9e403d307f3779f6312b7b7acd214fe75cecae6) (featherless)

### Themes

#### Changes

* [Add deprecation notice to APIs and remove from the site. (#3636)](https://github.com/material-components/material-components-ios/commit/cd3a53c263f3b8968a9d947ecf2bd46ebe7c756a) (featherless)

### ProgressView

#### Changes

* [Regenerate component docs with automatic API links. (#3673)](https://github.com/material-components/material-components-ios/commit/da21941afa8500ba0fb5775da14e9f3646ed9299) (featherless)
* [Split the documentation into separate articles and run the readme generator. (#3625)](https://github.com/material-components/material-components-ios/commit/6f8efafd30a536e8dd90fc74aa1f151792ee929d) (featherless)

### Palettes

#### Changes

* [Improve example text contrast (#3590)](https://github.com/material-components/material-components-ios/commit/f636a9c5f2472c27cff92f64a7809075f4124f61) (Robert Moore)
* [[Catalog] Make many examples be dragons. (#3642)](https://github.com/material-components/material-components-ios/commit/e923d2d9283bfd9619f6db13bff2f72c47c8181c) (featherless)

---

# 54.13.0

This release focused on documentation across all of our componentry and introduced new outlined
themes for components. There have also been significant improvements to theming in the MDCCatalog
app.

## Breaking changes

## New features

Buttons, Cards, and Chips now support outlined themes.

```objc
// Buttons:
[MDCOutlinedButtonThemer applyScheme:buttonScheme toButton:outlinedButton];

// Cards:
[MDCCardThemer applyOutlinedVariantWithScheme:cardScheme toCard:component];

// Chips:
[MDCChipViewThemer applyOutlinedVariantWithScheme:cardScheme toChipView:component];
```

Chip hit areas can now be modified using the new `hitAreaInsets` API:

```objc
chip.hitAreaInsets = UIEdgeInsetsMake(chipVerticalInset, 0, chipVerticalInset, 0);
```

## API changes

### Chips

#### MDCChipView

*new* property: `hitAreaInsets` in `MDCChipView`

## Component changes

### Tabs

#### Changes

* [Add umbrella headers for all extension targets. (#3476)](https://github.com/material-components/material-components-ios/commit/08403aecf78a08a249b9991c21aafd6dbd6be478) (featherless)
* [Adding .vars files for each component. (#3561)](https://github.com/material-components/material-components-ios/commit/81aca79c69780d27b59a74e60f2364c297ebe2e1) (Mohammad Cazi)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Replace MDCRaisedButton with contained button themer in TabBarIconExample. (#3499)](https://github.com/material-components/material-components-ios/commit/a5c816e8239c9d238dce20b06723ebfd86d77e9a) (featherless)
* [Replace MDCRaisedButton with contained button themer in TabBarIndicatorTemplateExample. (#3500)](https://github.com/material-components/material-components-ios/commit/6ef99391113caf4ca19503019ae2b36c8fbc690c) (featherless)
* [Replace MDCRaisedButton with contained button themer. (#3497)](https://github.com/material-components/material-components-ios/commit/32138a911831d6fdadc2f0599723da70ba979740) (featherless)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [Update Tabs Theme Section README.md (#3527)](https://github.com/material-components/material-components-ios/commit/a5fe979bc339d181f1adb0ee15a2f6b89ce96319) (Mohammad Cazi)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)
* [update README.md Mistake](https://github.com/material-components/material-components-ios/commit/01b460529a87679b479359041491f263c766df9d) (Mohammad Cazi)

### MaskedTransition

#### Changes

* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)

### schemes/Color

#### Changes

* [Delete all of the older themer examples. (#3484)](https://github.com/material-components/material-components-ios/commit/24cf2bad0d6c40091d15c765f554872ff8b0caea) (featherless)
* [[Tabs] Add umbrella headers for all extension targets. (#3476)](https://github.com/material-components/material-components-ios/commit/08403aecf78a08a249b9991c21aafd6dbd6be478) (featherless)
* [[TextFields] Add umbrella headers for all extension targets. (#3477)](https://github.com/material-components/material-components-ios/commit/7e1e2f0e895d1a1bacf785a1c30886f407cc5f73) (featherless)

### schemes/Typography

#### Changes

* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)

### FeatureHighlight

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [[Typography][Color] Make sure our examples only use the new Color/Typography APIs (#3489)](https://github.com/material-components/material-components-ios/commit/a291896f0758575400bd35ba0a2ac3895e65e75c) (Mohammad Cazi)

### AppBar

#### Changes

* [Add Theming Section to README.md (#3516)](https://github.com/material-components/material-components-ios/commit/b77e73d06e6fa008c185ca08d1c3e2efed76d569) (Mohammad Cazi)
* [Added a AppBarTypicalCollectionViewExample. (#3491)](https://github.com/material-components/material-components-ios/commit/f7869ea61b70d95cdab2fa698b0fe99434ab5f6e) (Mohammad Cazi)
* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Fix the app bar status bar style in the typical use demo. (#3505)](https://github.com/material-components/material-components-ios/commit/41ac8443640585693454488d339229b53507c9ac) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Make MDCAppBarContainerViewController set bounds of child view controller (#3450)](https://github.com/material-components/material-components-ios/commit/3db1410ede9045b22663284b7c0830ddf80a360a) (John Detloff)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Revert "Make MDCAppBarContainerViewController set bounds of child view controller (#3450)" (#3594)](https://github.com/material-components/material-components-ios/commit/d512c3a9afa76e4b7e9258475001d1743c020892) (featherless)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [Update the examples, forwarding scrollView Delegate typical use. (#3494)](https://github.com/material-components/material-components-ios/commit/a6b31d4d54018495afba3b9fc863d3db2161704b) (Mohammad Cazi)

### Ink

#### Changes

* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)

### CollectionCells

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### Buttons

#### Changes

* [Add a floating action button themer. (#3588)](https://github.com/material-components/material-components-ios/commit/200fc906215de8201429c0ffca86495263160605) (featherless)
* [Add floating action button documentation. (#3592)](https://github.com/material-components/material-components-ios/commit/c061444df2b60b2383595a0c6fb4757b200a8c93) (featherless)
* [Add notice of pending deprecation to Flat and Raised buttons. (#3581)](https://github.com/material-components/material-components-ios/commit/2c8af495d32e3ea62833c619e9e8a516251a2d5a) (featherless)
* [Add outlined button themer (#3566)](https://github.com/material-components/material-components-ios/commit/55b995233229ad536f5538d183c1f1dd010e5183) (John Detloff)
* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Copy-edit pass of the readme. (#3587)](https://github.com/material-components/material-components-ios/commit/1766e1790fad143225121ade705b6ff0a75604d3) (featherless)
* [Fix build breakage due to API changes in ButtonThemer. (#3518)](https://github.com/material-components/material-components-ios/commit/bfe781a17fe9294b91d0e83eaf3a2af40a17c3ff) (featherless)
* [Fix build breakage. (#3593)](https://github.com/material-components/material-components-ios/commit/cb8571ab91438dec1b720e488f8fbd3d61f2ef9c) (featherless)
* [Fix build regression. (#3595)](https://github.com/material-components/material-components-ios/commit/a66e99c3101180126086c882426f8f95a6089992) (featherless)
* [Fix outlined button themer tests (#3598)](https://github.com/material-components/material-components-ios/commit/fc39022a08f5ded7582d4248f0225c5c3730791e) (John Detloff)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Minor copy edits to the main readme. (#3589)](https://github.com/material-components/material-components-ios/commit/7086086e50e61c2635b69a064bdaff6b2cc00b07) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Replace MDCFlatButton with MDCButton + text themer in content edge insets example. (#3583)](https://github.com/material-components/material-components-ios/commit/2414525074f43c849b1564f18e016c552d776d3e) (featherless)
* [Replace MDCRaisedButton with a contained button themer. (#3502)](https://github.com/material-components/material-components-ios/commit/d70da6a18d3fa7b041ba2cd2665e34267f9fdf06) (featherless)
* [Replace MDCRaisedButton with contained button themer in ButtonsShapesExampleViewController. (#3503)](https://github.com/material-components/material-components-ios/commit/c4d443a5f3e0da80ec865cc7a4a600614d1cff11) (featherless)
* [Replace references to MDCRaisedButton with MDCContainedButtonThemer. (#3482)](https://github.com/material-components/material-components-ios/commit/5a977ebd5fb8ac33ba0b0be663349d0d3626c450) (featherless)
* [Revert "Changing ButtonScheme Header to accept protocols instead of actual class. (#3488)" (#3512)](https://github.com/material-components/material-components-ios/commit/5e051afefa1ccc087e92eb5147e8f45fdfbbdf7f) (featherless)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [[Button:TextButton] Fixed the ripple color for text buttons (#3524)](https://github.com/material-components/material-components-ios/commit/e789ba4551753e65c746995209fe2a3eaaef8d03) (Randall Li)
* [[Button] Removed example of stroked button (#3421)](https://github.com/material-components/material-components-ios/commit/9201d9ec15fd2111bcfebede4d7dd2a50efe088b) (Randall Li)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### ButtonBar

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Fix typo in docs. (#3580)](https://github.com/material-components/material-components-ios/commit/f8f8092a6e6cf51fe87d1ce3859b39f0052ffd49) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)

### TextFields

#### Changes

* [Add umbrella headers for all extension targets. (#3477)](https://github.com/material-components/material-components-ios/commit/7e1e2f0e895d1a1bacf785a1c30886f407cc5f73) (featherless)
* [Adding .vars files for each component. (#3561)](https://github.com/material-components/material-components-ios/commit/81aca79c69780d27b59a74e60f2364c297ebe2e1) (Mohammad Cazi)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [Stop the text example from loading on startup (#3567)](https://github.com/material-components/material-components-ios/commit/8c7f8faa51ddae7b3c8d30f8d0638be9e23392be) (ianegordon)
* [Textfield Readme.md mistake.](https://github.com/material-components/material-components-ios/commit/0974e71428acd2674a89adae9234663f1c4b24c0) (Mohammad Cazi)
* [Themer Example (#3521)](https://github.com/material-components/material-components-ios/commit/4a258d2a47c359779b3304c55483be2ce87465f0) (ianegordon)
* [Update TextField Themer Section README.md (#3523)](https://github.com/material-components/material-components-ios/commit/8f3cf237bed97d098f26b3e123063bf8cc00b296) (Mohammad Cazi)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### Chips

#### Changes

* [Add support for custom touch target (#3517)](https://github.com/material-components/material-components-ios/commit/25984d9f4bb5eee7412e80fd342ee7ba32e200a6) (Robert Moore)
* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Create a ChipThemer for material and outlined schemes (#3563)](https://github.com/material-components/material-components-ios/commit/c185bc956f07aa9d1646844f6c5a0b96c08c4089) (John Detloff)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Revert "Vertically center chips within available space (#3511)" (#3582)](https://github.com/material-components/material-components-ios/commit/dfe1f8516aa13f547c139c820295c4a1afdd8b79) (Robert Moore)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [Vertically center chips within available space (#3511)](https://github.com/material-components/material-components-ios/commit/f69d36d963b5a172df42dce62b2bb3f847c99f47) (Robert Moore)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### Snackbar

#### Changes

* [Adding .vars files for each component. (#3561)](https://github.com/material-components/material-components-ios/commit/81aca79c69780d27b59a74e60f2364c297ebe2e1) (Mohammad Cazi)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### Cards

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Implement stroke variant themer (#3485)](https://github.com/material-components/material-components-ios/commit/fc486cf285be44561474be8908ba3614233af5b6) (John Detloff)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Replace MDCFlatButton with text button themer in CardExampleViewController. (#3584)](https://github.com/material-components/material-components-ios/commit/7f9f54d5cb7d350622939074edb96ac93d441334) (featherless)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### BottomAppBar

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [[Typography][Color] Make sure our examples only use the new Color/Typography APIs (#3489)](https://github.com/material-components/material-components-ios/commit/a291896f0758575400bd35ba0a2ac3895e65e75c) (Mohammad Cazi)

### Slider

#### Changes

* [Added Theming Section to README (#3530)](https://github.com/material-components/material-components-ios/commit/a6b8c8533fc8e378f98106e62debc652298204e5) (Mohammad Cazi)
* [Adding .vars files for each component. (#3561)](https://github.com/material-components/material-components-ios/commit/81aca79c69780d27b59a74e60f2364c297ebe2e1) (Mohammad Cazi)
* [Disabling flaky test. (#3560)](https://github.com/material-components/material-components-ios/commit/40f69695cfdf242498cb2685369b668b00ba6659) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [Stateful API Section Added. (#3565)](https://github.com/material-components/material-components-ios/commit/77d10fde8f2313a37d9d41d5372566fcf491e187) (Mohammad Cazi)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### NavigationBar

#### Changes

* [Adding .vars files for each component. (#3561)](https://github.com/material-components/material-components-ios/commit/81aca79c69780d27b59a74e60f2364c297ebe2e1) (Mohammad Cazi)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)

### OverlayWindow

#### Changes

* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)

### LibraryInfo

#### Changes

* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)

### ShadowLayer

#### Changes

* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)

### ActivityIndicator

#### Changes

* [Apply the color themer template to the docs. (#3556)](https://github.com/material-components/material-components-ios/commit/49590b69fe90e0fb4e077398083f14b223beca7c) (featherless)
* [Apply the contained button theme to the ActivityIndicatorTransitionExample button. (#3504)](https://github.com/material-components/material-components-ios/commit/88cdf7fda9d95131ea73963dea1f7e18fc5874c8) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Make the gif not a screenshot. (#3542)](https://github.com/material-components/material-components-ios/commit/63fb7524425fc1191ac110154678e75668b0c40a) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [Update the README.md and examples. (#3510)](https://github.com/material-components/material-components-ios/commit/149834e8858a83194ee4528fd5aa3d4495bda6c6) (featherless)
* [[Activity Indicator] Update the minimum radius documented in the header (#3498)](https://github.com/material-components/material-components-ios/commit/017b1aaa75c4c1f3881f3e1b0907d980a2cd3950) (Siyu Song)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### BottomSheet

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### Typography

#### Changes

* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### Dialogs

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Replace MDCRaisedButton with themer APIs in DialogWithPreferredContentSizeViewController. (#3495)](https://github.com/material-components/material-components-ios/commit/d406f0fa7cb9813b3378faa715609f0550baa74f) (featherless)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)
* [s/www.material.io/material.io/g (#3576)](https://github.com/material-components/material-components-ios/commit/7f09c94e4638aa7edeaaffd0b1b7570e99c7dc67) (Adrian Secord)

### BottomNavigation

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### PageControl

#### Changes

* [Adding .vars files for each component. (#3561)](https://github.com/material-components/material-components-ios/commit/81aca79c69780d27b59a74e60f2364c297ebe2e1) (Mohammad Cazi)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)

### AnimationTiming

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)

### Collections

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### HeaderStackView

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)

### FlexibleHeader

#### Changes

* [Add Theming section to README.md. (#3531)](https://github.com/material-components/material-components-ios/commit/9ef7d0b607c6d651ae26f27b526ab1ee409e4f42) (featherless)
* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)

### Themes

#### Changes

* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)

### ShadowElevations

#### Changes

* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### ProgressView

#### Changes

* [Adding .vars files for each component. (#3561)](https://github.com/material-components/material-components-ios/commit/81aca79c69780d27b59a74e60f2364c297ebe2e1) (Mohammad Cazi)
* [Generate all themer documentation. (#3562)](https://github.com/material-components/material-components-ios/commit/d3c5316db0c67aadb18fb0b7492a49234f8a4322) (featherless)
* [Remove all UIAppearance references from documentation. (#3480)](https://github.com/material-components/material-components-ios/commit/8395836c98224912c41b455a2651904362a006e7) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [Standardizing API docs. (#3481)](https://github.com/material-components/material-components-ios/commit/0cc7e9860f3820595f90da7110e3dc251950ea90) (featherless)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### Palettes

#### Changes

* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)
* [[Docs] Updated known short link destination URLs to use short links. (#3575)](https://github.com/material-components/material-components-ios/commit/72045ffd6d303bb99a3e1a71e4f3cdda42fe5ad8) (Adrian Secord)

### CollectionLayoutAttributes

#### Changes

* [Adding .vars files for each component. (#3557)](https://github.com/material-components/material-components-ios/commit/4186de3733f10650304c83cc6d29bf5afd714237) (featherless)
* [Remove space after triple-backtick Markdown syntax. (#3577)](https://github.com/material-components/material-components-ios/commit/7a7293883fd25ead73fa16a594a7dcab324c36b7) (Adrian Secord)

---

# 54.12.0

This release introduces umbrella headers for all themer targets. We encourage you to start using the
new umbrella headers for all themer APIs.

For example, Swift imports would change like so:

```swift
// Before
import MaterialComponents.MDCActivityIndicatorColorThemer
// After
import MaterialComponents.MaterialActivityIndicator_ColorThemer
```

While Objective-C imports would change like so:

```objc
// Before
#import "MDCAppBarColorThemer.h"
// After
#import "MaterialAppBar+ColorThemer.h"
```

We are focused on polishing the Catalog with the new theming systems and updating our component
documentation accordingly. Few new features, if any, will be added over the next few releases.

## API changes

## Component changes

### Tabs

#### Changes

* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### schemes/Color

#### Changes

* [[ActivityIndicator] Add an umbrella header for the ColorThemer target. (#3455)](https://github.com/material-components/material-components-ios/commit/ecc5266537036cfd156dabc8d99a92dfde92dddb) (featherless)
* [[BottomAppBar] Add umbrella headers for all extension targets. (#3459)](https://github.com/material-components/material-components-ios/commit/d6e1110e566d9a4661c0d26e65395b85729a957e) (featherless)
* [[ButtonBar] Add umbrella headers for all extension targets. (#3462)](https://github.com/material-components/material-components-ios/commit/a448657a2360225dd69b9e835955b693da27e879) (featherless)
* [[Buttons] Add umbrella headers for all extension targets. (#3454)](https://github.com/material-components/material-components-ios/commit/d4f727e16f2cfb90f84f94c305935278f629fd4d) (featherless)
* [[Dialogs] Add umbrella headers for all extension targets. (#3465)](https://github.com/material-components/material-components-ios/commit/e3dd4c12cedf1494af6e8d5224b9acde91a18ce1) (featherless)
* [[FeatureHighlight] Add umbrella headers for all extension targets. (#3466)](https://github.com/material-components/material-components-ios/commit/bb9324ecae5a407e71d6efd8a3f46c1e5495e6ff) (featherless)
* [[FlexibleHeader] Add umbrella headers for all extension targets. (#3467)](https://github.com/material-components/material-components-ios/commit/7bbee66f9b4649c0df5c4ae936820494f1ba698d) (featherless)
* [[HeaderStackView] Add umbrella headers for all extension targets. (#3468)](https://github.com/material-components/material-components-ios/commit/ce8efd3e27605057b49aea5515200b55b7576de9) (featherless)
* [[NavigationBar] Add umbrella headers for all extension targets. (#3471)](https://github.com/material-components/material-components-ios/commit/e5679888fe81ccf96ccd51fa4d5fbb7bc6b95187) (featherless)
* [[PageControl] Add umbrella headers for all extension targets. (#3472)](https://github.com/material-components/material-components-ios/commit/f8d8de3fb3c95fb2d459c59d322ce8aec1868f02) (featherless)
* [[ProgressView] Add umbrella headers for all extension targets. (#3473)](https://github.com/material-components/material-components-ios/commit/d36136e361dfefdecdf14e30b5d8cdade5320887) (featherless)
* [[Slider] Add umbrella headers for all extension targets. (#3474)](https://github.com/material-components/material-components-ios/commit/0cc6b487ae2154ea80f7ae35499ddd0d3cfcd102) (featherless)

### FeatureHighlight

#### Changes

* [Add umbrella headers for all extension targets. (#3466)](https://github.com/material-components/material-components-ios/commit/bb9324ecae5a407e71d6efd8a3f46c1e5495e6ff) (featherless)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)

### AppBar

#### Changes

* [Add umbrella headers for all extension targets. (#3458)](https://github.com/material-components/material-components-ios/commit/09c3a65e6ebbab6f37fc15a379d2293e82bf2b07) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)
* [[FlexibleHeader] Add umbrella headers for all extension targets. (#3467)](https://github.com/material-components/material-components-ios/commit/7bbee66f9b4649c0df5c4ae936820494f1ba698d) (featherless)
* [[NavigationBar] Add umbrella headers for all extension targets. (#3471)](https://github.com/material-components/material-components-ios/commit/e5679888fe81ccf96ccd51fa4d5fbb7bc6b95187) (featherless)

### Ink

#### Changes

* [Add umbrella headers for all extension targets. (#3469)](https://github.com/material-components/material-components-ios/commit/962d9abcc02764acdd34b7118f957e4a95bffa8c) (featherless)

### Buttons

#### Changes

* [Add umbrella headers for all extension targets. (#3454)](https://github.com/material-components/material-components-ios/commit/d4f727e16f2cfb90f84f94c305935278f629fd4d) (featherless)
* [Added ImageTintColor for theming FAB Button. (#3442)](https://github.com/material-components/material-components-ios/commit/238b6d7b067a2f039d7b1b88e8260139dda9fa59) (Mohammad Cazi)
* [Changing ButtonScheme Header to accept protocols instead of actual class. (#3488)](https://github.com/material-components/material-components-ios/commit/61df0f001711add45abe7559cbea7fe6b88803bb) (Mohammad Cazi)
* [Replace MDCRaisedButton with contained button APIs in content edge insets example. (#3453)](https://github.com/material-components/material-components-ios/commit/7c6248ccc0604511b95d724c63900bc3ad653790) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Implement API for setting app-wide theming (#3461)](https://github.com/material-components/material-components-ios/commit/27eac8c05c00202dd18fa79ac01d88ad2d37b953) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### ButtonBar

#### Changes

* [Add umbrella headers for all extension targets. (#3462)](https://github.com/material-components/material-components-ios/commit/a448657a2360225dd69b9e835955b693da27e879) (featherless)
* [Make left/right insets for image and text buttons consistent (#3397)](https://github.com/material-components/material-components-ios/commit/3c112ae350adb70695828ce896fdeff5a6d9a3d9) (Ali Rabbani)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### TextFields

#### Changes

* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### Chips

#### Changes

* [Add umbrella headers for all extension targets. (#3464)](https://github.com/material-components/material-components-ios/commit/819d321eed40e0d27728d98ee030794bc341d888) (featherless)
* [Reset cell selection state to NO on prepare for reuse. (#3444)](https://github.com/material-components/material-components-ios/commit/847ebd5957369726fa226657a45fe408fc24485c) (Mohammad Cazi)
* [Revert "Reset cell selection state to NO on prepare for reuse." (#3447)](https://github.com/material-components/material-components-ios/commit/93e688fbf0f359f5707e2282d47eb8f7d977868f) (Mohammad Cazi)
* [We should not display ink when the chip is disabled. (#3445)](https://github.com/material-components/material-components-ios/commit/4acc0039f0549f866dc8661c1ecdff94de3e278d) (Mohammad Cazi)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[chips] Updating chips color Themer. (#3452)](https://github.com/material-components/material-components-ios/commit/9144699e2dee0d28a8f6b6ff724419aa3e7bd1d2) (Mohammad Cazi)
* [color themer update. (#3448)](https://github.com/material-components/material-components-ios/commit/beac5b37de29ba6e4b545b942167a422c4eb4a0f) (Mohammad Cazi)

### Snackbar

#### Changes

* [Add umbrella headers for all extension targets. (#3475)](https://github.com/material-components/material-components-ios/commit/330d9f608409ea26876d2d8a2880462fca9f17e0) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)

### Cards

#### Changes

* [Add umbrella headers for all extension targets. (#3463)](https://github.com/material-components/material-components-ios/commit/a132eb2106149bd08c3fd0319e572b604ef99336) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### BottomAppBar

#### Changes

* [Add umbrella headers for all extension targets. (#3459)](https://github.com/material-components/material-components-ios/commit/d6e1110e566d9a4661c0d26e65395b85729a957e) (featherless)
* [[Buttons] Add umbrella headers for all extension targets. (#3454)](https://github.com/material-components/material-components-ios/commit/d4f727e16f2cfb90f84f94c305935278f629fd4d) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### Slider

#### Changes

* [Add umbrella headers for all extension targets. (#3474)](https://github.com/material-components/material-components-ios/commit/0cc6b487ae2154ea80f7ae35499ddd0d3cfcd102) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)

### NavigationBar

#### Changes

* [Add umbrella headers for all extension targets. (#3471)](https://github.com/material-components/material-components-ios/commit/e5679888fe81ccf96ccd51fa4d5fbb7bc6b95187) (featherless)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### ActivityIndicator

#### Changes

* [Add an umbrella header for the ColorThemer target. (#3455)](https://github.com/material-components/material-components-ios/commit/ecc5266537036cfd156dabc8d99a92dfde92dddb) (featherless)
* [Replace collection view with table view in indicator example (#3451)](https://github.com/material-components/material-components-ios/commit/2cc61dfb14d36d950079242d86af4090920d1842) (John Detloff)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)
* [remove line (#3479)](https://github.com/material-components/material-components-ios/commit/05994dfd7c00b5d807a1fa3a0e12e776dac69918) (Yarden Eitan)

### BottomSheet

#### Changes

* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)

### Dialogs

#### Changes

* [Add umbrella headers for all extension targets. (#3465)](https://github.com/material-components/material-components-ios/commit/e3dd4c12cedf1494af6e8d5224b9acde91a18ce1) (featherless)
* [Remove unused DialogsTypicalUseViewController.storyboard. (#3496)](https://github.com/material-components/material-components-ios/commit/1da207b483ddb8d79f086af7c84b651317bf620e) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### BottomNavigation

#### Changes

* [Add umbrella headers for all extension targets. (#3460)](https://github.com/material-components/material-components-ios/commit/683d2f5e748d2acb1a80afc82bad60eadff512a7) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)
* [[Catalog] Expose colorScheme + typographyScheme properties for all examples to use app wide theming (#3478)](https://github.com/material-components/material-components-ios/commit/7f7bc36202cb416eeb1e924ecde9430e3b467c1b) (Yarden Eitan)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### PageControl

#### Changes

* [Add umbrella headers for all extension targets. (#3472)](https://github.com/material-components/material-components-ios/commit/f8d8de3fb3c95fb2d459c59d322ce8aec1868f02) (featherless)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### AnimationTiming

#### Changes

* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### HeaderStackView

#### Changes

* [Add umbrella headers for all extension targets. (#3468)](https://github.com/material-components/material-components-ios/commit/ce8efd3e27605057b49aea5515200b55b7576de9) (featherless)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### FlexibleHeader

#### Changes

* [Add umbrella headers for all extension targets. (#3467)](https://github.com/material-components/material-components-ios/commit/7bbee66f9b4649c0df5c4ae936820494f1ba698d) (featherless)
* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### ShadowElevations

#### Changes

* [[Catalog] Make all swift copycat demos be dragons. (#3443)](https://github.com/material-components/material-components-ios/commit/23110ef1166f56b90f0410bd0d2de2e572261ee6) (featherless)

### ProgressView

#### Changes

* [Add umbrella headers for all extension targets. (#3473)](https://github.com/material-components/material-components-ios/commit/d36136e361dfefdecdf14e30b5d8cdade5320887) (featherless)
* [[Catalog] Component descriptions update. (#3490)](https://github.com/material-components/material-components-ios/commit/5ee14ab92ec45335f851e4c7d30f4b992ab786b1) (Mohammad Cazi)

---

# 54.11.1

## Component changes

### ButtonBar

#### Changes

* [Make left/right insets for image and text buttons consistent (#3397)](https://github.com/material-components/material-components-ios/commit/a9c250aa08035f74e0e49af86b4d28f0356c03fe) (Ali Rabbani)

---

# 54.11.0

This release is the final push towards supporting themers on our components.

We will now shift focus to polishing APIs, documentation, and examples and to fixing bugs.

## New features

It is now possible to configure colors on BottomNavigation, ButtonBar, NavigationBar, and Tabs
statefully.

TextFields now allows customization of the active floating placeholder color.

MDCTabBar now allows the display of a bottom divider using the `bottomDividerColor` API.

## API changes

### BottomNavigation

#### MDCBottomNavigationBar

*new* property: `selectedItemTitleColor` in `MDCBottomNavigationBar`

### ButtonBar

#### MDCButtonBar

*new* method: `-buttonsTitleColorForState:` in `MDCButtonBar`

*new* method: `-setButtonsTitleColor:forState:` in `MDCButtonBar`

### Buttons

#### MDCButton

*new* method: `-imageTintColorForState:` in `MDCButton`

*new* method: `-setImageTintColor:forState:` in `MDCButton`

### NavigationBar

#### MDCNavigationBar

*new* method: `-setButtonsTitleColor:forState:` in `MDCNavigationBar`

*new* method: `-buttonsTitleColorForState:` in `MDCNavigationBar`

### Tabs

#### MDCTabBarItemState

*new* typedef: `MDCTabBarItemState`

*new* enum value: `MDCTabBarItemStateSelected` in `MDCTabBarItemState`

*new* enum: `MDCTabBarItemState`

*new* enum value: `MDCTabBarItemStateNormal` in `MDCTabBarItemState`

#### MDCTabBar

*new* method: `-imageTintColorForState:` in `MDCTabBar`

*new* method: `-titleColorForState:` in `MDCTabBar`

*new* method: `-setImageTintColor:forState:` in `MDCTabBar`

*new* property: `bottomDividerColor` in `MDCTabBar`

*new* method: `-setTitleColor:forState:` in `MDCTabBar`

### TextFields

#### MDCTextInputControllerFloatingPlaceholder

*new* property: `floatingPlaceholderActiveColorDefault` in `MDCTextInputControllerFloatingPlaceholder`

*new* property: `floatingPlaceholderActiveColor` in `MDCTextInputControllerFloatingPlaceholder`

## Component changes

### Tabs

#### Changes

* [Fix MDCTabBarColorThemerTests (#3428)](https://github.com/material-components/material-components-ios/commit/b3e9d45d73b57a1b0381576dc00afe7913b08301) (John Detloff)
* [Fix build breakage (#3425)](https://github.com/material-components/material-components-ios/commit/178a1595819dea623d0b65660bb2f33b00ea1f9e) (John Detloff)
* [[TabBar] Add a 1 pt bottom divider to MDCTabBar (#3390)](https://github.com/material-components/material-components-ios/commit/0922329df1c5895cf068d85285337ce777b5b751) (John Detloff)
* [[TabBars] Add titleColorForState and imageTintColorForState (#3396)](https://github.com/material-components/material-components-ios/commit/f082d88099c62a280544e564bd0738d77c2f9386) (John Detloff)

### AppBar

#### Changes

* [[NavigationBar] Fix the surface variation themer's text/icon colors to match spec. (#3416)](https://github.com/material-components/material-components-ios/commit/bd05a69c88f9e647ccfbc503ef4841ba383eb7db) (featherless)

### Buttons

#### Changes

* [ [Button] Contained: Changed colors for ink and disabled (#3419)](https://github.com/material-components/material-components-ios/commit/3d1a7c2791de6d87589c601624f50639ae1c6872) (Randall Li)
* [Create a separate class for MDCFloatingButton color themer. (#3429)](https://github.com/material-components/material-components-ios/commit/82d19ae5d0645387fc5f789ef4906449e8f4c704) (Mohammad Cazi)
* [[Button] Button Themers calling direct color themers. (#3434)](https://github.com/material-components/material-components-ios/commit/807373e0101c18cabab47ddb561bc6b5a1885156) (Randall Li)
* [[Button] Contained color image themer using tint APIs. (#3439)](https://github.com/material-components/material-components-ios/commit/fb16a6d0e46c57e0f3c17c9abc820e2ba33528f3) (Randall Li)
* [[Button] Fixed catalog description of typical use example (#3435)](https://github.com/material-components/material-components-ios/commit/827552a84049420637a5355df2d9fc987511b614) (Randall Li)
* [[Button] Text button color image themer using tint APIs. (#3440)](https://github.com/material-components/material-components-ios/commit/b2c8738975090ae9d73fdd8829c85ffdc1f00eb3) (Randall Li)
* [[MDCButton] Added new API for coloring image tint color for state. (#3423)](https://github.com/material-components/material-components-ios/commit/ece3c1457b38bcb98f1a9bb9b20d123ffd35e324) (Mohammad Cazi)
* [update disabled alpha (#3420)](https://github.com/material-components/material-components-ios/commit/e094209c2983dfe2159a1f5ff70cc67ca20714b1) (Yarden Eitan)

### ButtonBar

#### Changes

* [Add a stateful buttons title color API. (#3414)](https://github.com/material-components/material-components-ios/commit/5a372de8fc94f743bbec58da0706757bbfb3576a) (featherless)
* [Fix layout behavior when using custom button title font. (#3410)](https://github.com/material-components/material-components-ios/commit/a400ff0b30baeaf273b229f85e78c824c185d76c) (featherless)

### TextFields

#### Changes

* [Adding a floating placeholder active color override. (#3433)](https://github.com/material-components/material-components-ios/commit/b49156ad4d74b2623eb9c170bb209b75a25ba572) (Will Larche)
* [Unit tests for more classes of controller (#3436)](https://github.com/material-components/material-components-ios/commit/128bd79416f4e43915166c286c2cd8b7a164d35d) (Will Larche)
* [[Textfields] Added Filled and Outlined themers (#3438)](https://github.com/material-components/material-components-ios/commit/8717640dbd20fcf56deebc4f7375d0eff834c57a) (Yarden Eitan)

### Snackbar

#### Changes

* [Disable flaky test -[SnackbarManagerTests testMessagesResumedWhenTokenIsDeallocated] (#3426)](https://github.com/material-components/material-components-ios/commit/aa30cd064c5bb1d0520e0db6a8642c865580546e) (Ben Hamilton (Ben Gertzfield))

### NavigationBar

#### Changes

* [Add a stateful buttons title color API. (#3415)](https://github.com/material-components/material-components-ios/commit/8d3f54246ef89055c7d614c9f54130584be3c833) (featherless)
* [Fix the surface variation themer's text/icon colors to match spec. (#3416)](https://github.com/material-components/material-components-ios/commit/bd05a69c88f9e647ccfbc503ef4841ba383eb7db) (featherless)

### BottomNavigation

#### Changes

* [Add separate property for selected title color (#3430)](https://github.com/material-components/material-components-ios/commit/d2db639402e99a6f11487ca035aad5addbf1b900) (John Detloff)

---

# 54.10.0

This release continues to increase coverage of themers across our components.

## New features

ButtonBar now has a Typography themer.

NavigationBar now has APIs for customizing title button fonts.

## API changes

### NavigationBar

#### MDCNavigationBar

*new* method: `-setButtonsTitleFont:forState:` in `MDCNavigationBar`

*new* method: `-buttonsTitleFontForState:` in `MDCNavigationBar`

## Component changes

### Buttons

#### Changes

* [[Button] Changed text button disabled to do 37% opacity, Ink to use onSurface 16% (#3406)](https://github.com/material-components/material-components-ios/commit/1fa5bdf0b30f6c3741c22585a895ec9803b4b1e9) (Randall Li)

### ButtonBar

#### Changes

* [Add a Typography Themer. (#3395)](https://github.com/material-components/material-components-ios/commit/289223a5bb3ecafc1b3c733b404a80cfd7546ee5) (featherless)

### Chips

#### Changes

* [Update README.md](https://github.com/material-components/material-components-ios/commit/bf5c69504571d721fe8ce6cd13719d8ad4e404ea) (Mohammad Cazi)
* [Updating Readme documentation for chips. (#3405)](https://github.com/material-components/material-components-ios/commit/0414aa15f6d0f9d1c40c5b21713d1761b061f816) (Mohammad Cazi)
* [Updating Readme documentation for chips.](https://github.com/material-components/material-components-ios/commit/425f177ffb3581ff20e574777bce8c18e1a074d8) (Mohammad Cazi)

### NavigationBar

#### Changes

* [Add an API for customizing button fonts. (#3412)](https://github.com/material-components/material-components-ios/commit/610d1ab58a44d204b7576bb654a2c6a99a7a0742) (featherless)

---

# 54.9.0

This release continues to improve the support for our themer APIs across all components.

## New features

Button Bar now allows button typography to be configured.

Floating buttons and contained buttons now have themers.

AppBar and Tabs now have a surface variant color themer API.

Slider now has a color themer.

## API changes

### ButtonBar

#### MDCButtonBar

*new* method: `-setButtonsTitleFont:forState:` in `MDCButtonBar`

*new* method: `-buttonsTitleFontForState:` in `MDCButtonBar`

## Component changes

### Tabs

#### Changes

* [Add a surface variant color themer API. (#3388)](https://github.com/material-components/material-components-ios/commit/61cf85c9c2afe0dcaf63555f211dd10469104434) (featherless)

### AppBar

#### Changes

* [Add surface variant color themer API. (#3383)](https://github.com/material-components/material-components-ios/commit/90ec60ed8480adb589792db670d4872350d9514e) (featherless)

### Ink

#### Changes

* [Increase range of accuracy in test to +/-.1. (#3392)](https://github.com/material-components/material-components-ios/commit/b1c3a030eb4603ebc18eba82ee60284a0e9c4dbc) (Randall Li)

### Buttons

#### Changes

* [Created contained button themer. (#3391)](https://github.com/material-components/material-components-ios/commit/c39386679f8ee805c50b23bb571662248ceee36f) (Randall Li)
* [[Button] Renamed color themer styles to text and contained (#3384)](https://github.com/material-components/material-components-ios/commit/aa0fc7c6224b0a02d43abc19dd9a0f74039b7249) (Randall Li)
* [[Button] Split files into more appropriate names: TextButtonThemer and ButtonScheme. (#3385)](https://github.com/material-components/material-components-ios/commit/d2e2fd88e1e17d6ec71c14ada98e68a585a494a5) (Randall Li)
* [[MDCFloatingButton] Color Themer added. (#3381)](https://github.com/material-components/material-components-ios/commit/c818048a1c97b53b6b622bb315af7864026e3cea) (Mohammad Cazi)

### ButtonBar

#### Changes

* [Expose APIs for setting custom button fonts. (#3389)](https://github.com/material-components/material-components-ios/commit/e11d24a110fa490aaf016f5964edc1575638eb67) (featherless)

### Chips

#### Changes

* [Adding Examples/Documentation for all chips types. (#3393)](https://github.com/material-components/material-components-ios/commit/dd0c0123c658a88ffaa4e9d8c86191b747c38260) (Mohammad Cazi)

### Slider

#### Changes

* [Update color themer (#3375)](https://github.com/material-components/material-components-ios/commit/3c139cc00d5acc5ca12ffa5c779c63f7533c8c37) (John Detloff)

### ShadowLayer

#### Changes

* [[Shapes] Example using Shapes and Shadows with animation (#3394)](https://github.com/material-components/material-components-ios/commit/d1767c0086af1d4b7dfc55305f05c964137210bb) (Yarden Eitan)

---

# 54.8.0

This new release introduces shapes support to buttons and a variety of new themer APIs for many
components.

## New features

Buttons can now be styled with different shape outlines. Example usage:

```objc
MDCRectangleShapeGenerator *raisedShapeGenerator =
    [[MDCRectangleShapeGenerator alloc] init];
[raisedShapeGenerator setCorners:[[MDCCutCornerTreatment alloc] initWithCut:8.f]];
button.shapeGenerator = raisedShapeGenerator;
```

There is a new Text Button API for theming an MDCButton to make complete use of typography, color,
and other configurable properties of a button's design. A button themed as a text button is closely
equivalent to the `MDCFlatButton` class, `MDCFlatButton` will soon be deprecated as a result in
favor of the following pattern:

```swift
// Define your button's scheme somewhere centrally in your app.
let buttonScheme = MDCButtonScheme()
buttonScheme.colorScheme = myAppColorScheme

// Apply the button scheme to an MDCButton to give it the appearance of a text button.
// button: MDCButton
MDCTextButtonThemer.applyScheme(buttonScheme, to: button)
```

NavigationBar and FlexibleHeader now both have a surface variant themer.

Chips and Tabs have updated color themers.

## API changes

### Buttons

#### MDCButton

*new* property: `shapeGenerator` in `MDCButton`

## Component changes

### Tabs

#### Changes

* [Fix crasher within tab example (#3370)](https://github.com/material-components/material-components-ios/commit/4bede1313cdbcfdb0ce57d815504080a9837fb9d) (John Detloff)
* [Update MDCTabBar color themer (#3361)](https://github.com/material-components/material-components-ios/commit/7799a15025ca4be0eb9dd0e7cbac1c3acb7c7db6) (John Detloff)

### Buttons

#### Changes

* [Added Shapes Support (#3368)](https://github.com/material-components/material-components-ios/commit/67a68d3d3c05c95cac107d36c0e3e56d618f2db5) (Yarden Eitan)
* [[Button] Color themer: Changed class of argument to be MDCButton rather than be a subclass. (#3382)](https://github.com/material-components/material-components-ios/commit/ac89ec985da7fce5f344f2417aa85e550ae00a99) (Randall Li)
* [[Button] Created button themer that aggregates multiple subsystems to style buttons. (#3362)](https://github.com/material-components/material-components-ios/commit/25c0a953647e8749cf050bde3c4a74fe011ec910) (Randall Li)

### Chips

#### Changes

* [color themer implementation. (#3372)](https://github.com/material-components/material-components-ios/commit/8336003a11b24c1df4de8f56ec7377eb5cdf8dea) (Mohammad Cazi)

### NavigationBar

#### Changes

* [Add surface variant theme. (#3376)](https://github.com/material-components/material-components-ios/commit/6b2de0f3a36213231bfa063ec1c2befa807fc73a) (featherless)

### FlexibleHeader

#### Changes

* [Add a surface variant color themer API. (#3380)](https://github.com/material-components/material-components-ios/commit/c2ab8fa9c4be04d4a89332d02435534e54499c7d) (featherless)

---

# 54.7.0

This release introduces a new API for compositing colors for use by color themers.

## API diff

### schemes/Color

*new* method: `MDCSemanticColorScheme` `+blendColor:withBackgroundColor:`

## Component changes

### schemes/Color

#### Changes

* [Adding a helper to merge two colors with different opacities. (#3355)](https://github.com/material-components/material-components-ios/commit/900384cd75c6cd49ef6c9ad02e04e60fb868cfe6) (Mohammad Cazi)

### ButtonBar

#### Changes

* [[NavigationBar]Restore the changed default inkColor](https://github.com/material-components/material-components-ios/commit/65091d5e36c5ccfa4ff624bd8c0be3605020e6b9) (Ali Rabbani)

### Cards

#### Changes

* [organize cards examples (#3369)](https://github.com/material-components/material-components-ios/commit/755dcb052372497c0c2e9e525ed6058ff4f7119e) (Yarden Eitan)

---

# 54.6.1

This is a hotfix release fixing a bug in ButtonBar that was introduced in 54.6.0.

## Component changes

### ButtonBar

#### Changes

* [[NavigationBar]Restore the changed default inkColor](https://github.com/material-components/material-components-ios/commit/367048d4b2f40eb84f0c3161c218db69798461d5) (Ali Rabbani)

---

# 54.6.0

This release introduces new APIs and themers for customizing typography and color. This release
also fixes a bug in NavigationBar affecting title label kerning for system fonts. This may result
in visual changes for navigation bar instances.

## New features

AppBar now has a Typography themer.

Buttons now has a raised button color themer.

BottomSheets background tap-to-dismiss behavior can now be disabled with `dismissOnBackgroundTap`.

ButtonBar and NavigationBar's ink color can now be customized.

Cars now has a Color themer.

NavigationBar has a new opt-in behavioral change gated by the `useFlexibleTopBottomInsets` property.
Enabling this property will result in new layout behavior for the navigation bar's titleView. This
flag will be enabled by default in the future. Consider enabling this flag on your navigation bar
instances in order to verify that the new behavior will not cause regressions in your app.

TextFields now expose a backgroundColor property.

## API changes

### BottomSheet

#### MDCBottomSheetPresentationController

*new* property: `dismissOnBackgroundTap` in `MDCBottomSheetPresentationController`

#### MDCBottomSheetTransitionController

*new* property: `dismissOnBackgroundTap` in `MDCBottomSheetTransitionController`

#### MDCBottomSheetController

*new* property: `dismissOnBackgroundTap` in `MDCBottomSheetController`

### ButtonBar

#### MDCButtonBar

*new* property: `inkColor` in `MDCButtonBar`

### NavigationBar

#### MDCNavigationBar

*new* property: `inkColor` in `MDCNavigationBar`

*new* property: `useFlexibleTopBottomInsets` in `MDCNavigationBar`

### TextFields

#### MDCTextInputControllerBase

*new* property: `backgroundColor` in `MDCTextInputControllerBase`

#### MDCTextInputController

*new* property: `backgroundColorDefault` in `MDCTextInputController`

*new* property: `backgroundColor` in `MDCTextInputController`

## Component changes

### AppBar

#### Changes

* [Add a Typography themer. (#3359)](https://github.com/material-components/material-components-ios/commit/ab8c104262f471cde821a7af83367a130c10843c) (featherless)
* [[ButtonBar] Allow customizing the inkColor of the buttons (#3250)](https://github.com/material-components/material-components-ios/commit/8af9e9fc8180fbcbc72250f963d2074772aedfcd) (Ali Rabbani)
* [[NavigationBar] Allow flexible height/insets in MDCNavigationBar (#3305)](https://github.com/material-components/material-components-ios/commit/992d58148194d43aed366562da6f12a889767bf2) (Ali Rabbani)

### Buttons

#### Changes

* [Implement a color themer for an MDCRaisedButton (#3335)](https://github.com/material-components/material-components-ios/commit/2869609c2eb48826fa2c4de773746779c53224c9) (Yarden Eitan)
* [[Button Examples] Moved most examples into dragons so that only beautiful demos are in the main catalog. (#3358)](https://github.com/material-components/material-components-ios/commit/53dddde6cf3205e5ec871df503271627207b52f7) (Randall Li)

### ButtonBar

#### Changes

* [Allow customizing the inkColor of the buttons (#3250)](https://github.com/material-components/material-components-ios/commit/8af9e9fc8180fbcbc72250f963d2074772aedfcd) (Ali Rabbani)
* [[NavigationBar] Allow flexible height/insets in MDCNavigationBar (#3305)](https://github.com/material-components/material-components-ios/commit/992d58148194d43aed366562da6f12a889767bf2) (Ali Rabbani)

### TextFields

#### Changes

* [Add backgroundColor property (#3357)](https://github.com/material-components/material-components-ios/commit/abeb391ebaec1438738fc6a8f7d308e87f6412ba) (ianegordon)
* [Adding the expected opacities to color themer. (#3347)](https://github.com/material-components/material-components-ios/commit/3c22a8d18b2fbe3ebb1efa839725a424063fb8d1) (Mohammad Cazi)

### Cards

#### Changes

* [Implement a semantic color scheme color themer API. (#3289)](https://github.com/material-components/material-components-ios/commit/bd8760b94b47bdc50d7e62d86111dac8b4a6010f) (Yarden Eitan)

### NavigationBar

#### Changes

* [Allow flexible height/insets in MDCNavigationBar (#3305)](https://github.com/material-components/material-components-ios/commit/992d58148194d43aed366562da6f12a889767bf2) (Ali Rabbani)
* [Fix bug where system font traits would be lost. (#3360)](https://github.com/material-components/material-components-ios/commit/d259ebed7d0fff6ffacbc74fed8c751bce28b035) (featherless)
* [[ButtonBar] Allow customizing the inkColor of the buttons (#3250)](https://github.com/material-components/material-components-ios/commit/8af9e9fc8180fbcbc72250f963d2074772aedfcd) (Ali Rabbani)

### ActivityIndicator

#### Changes

* [[bazel] Fix BUILD file paths to match file system casing (#3363)](https://github.com/material-components/material-components-ios/commit/1832b072b405577d348968af8e60bce442df35b9) (featherless)

### BottomSheet

#### Changes

* [Adds a setting to make sheets impossible to dismiss. (#3325)](https://github.com/material-components/material-components-ios/commit/a1c66214558904284e6d3d6ed533c64202c29933) (John Detloff)

### BottomNavigation

#### Changes

* [[bazel] Fix BUILD file paths to match file system casing (#3363)](https://github.com/material-components/material-components-ios/commit/1832b072b405577d348968af8e60bce442df35b9) (featherless)

---

# 54.5.0

This release includes bug fixes and increased coverage of our themer APIs for components.

## New features

Slider now exposes a variety of properties for customizing color, including new stateful color APIs.
To make use of the new stateful APIs, you must enable `statefulAPIEnabled` on the MDCSlider
instance.

BottomNavigationBar and Dialogs now both have a semantic color themer.

## API changes

### Slider

#### MDCSlider

*new* method: `-setBackgroundTrackTickColor:forState:` in `MDCSlider`

*new* property: `valueLabelTextColor` in `MDCSlider`

*new* method: `-trackFillColorForState:` in `MDCSlider`

*new* method: `-backgroundTrackTickColorForState:` in `MDCSlider`

*new* method: `-setThumbColor:forState:` in `MDCSlider`

*new* method: `-trackBackgroundColorForState:` in `MDCSlider`

*new* method: `-setFilledTrackTickColor:forState:` in `MDCSlider`

*new* method: `-filledTrackTickColorForState:` in `MDCSlider`

*new* method: `-thumbColorForState:` in `MDCSlider`

*new* method: `-setTrackBackgroundColor:forState:` in `MDCSlider`

*new* property: `inkColor` in `MDCSlider`

*new* property: `statefulAPIEnabled` in `MDCSlider`

*new* property: `valueLabelBackgroundColor` in `MDCSlider`

*new* method: `-setTrackFillColor:forState:` in `MDCSlider`

## Component changes

### ButtonBar

#### Changes

* [Fix insets for the trailing button bar (#3324)](https://github.com/material-components/material-components-ios/commit/9947b8fa2bc901979822cf9aef12ee6d5b4bde16) (Ali Rabbani)

### TextFields

#### Changes

* [Placeholder background color (#3333)](https://github.com/material-components/material-components-ios/commit/7b262bb952dcd3696c616eb1d2d4d1594ed72a01) (Will Larche)
* [[Chips] Ensure MDCChipField notifies delegate when clear button is tapped (#3341)](https://github.com/material-components/material-components-ios/commit/9d4c218a0a0d2693b6fed4839eb050b3132a276e) (Ben Hamilton (Ben Gertzfield))

### Chips

#### Changes

* [Ensure MDCChipField notifies delegate when clear button is tapped (#3341)](https://github.com/material-components/material-components-ios/commit/9d4c218a0a0d2693b6fed4839eb050b3132a276e) (Ben Hamilton (Ben Gertzfield))

### Slider

#### Changes

* [Add inkColor, thumbColorForState:, trackFillColorForState: (#3310)](https://github.com/material-components/material-components-ios/commit/b7d2999215e4a3cce690ca24866eef92ed69ece7) (Robert Moore)
* [Add text, background color to value label (#3330)](https://github.com/material-components/material-components-ios/commit/54d7fdf8da7beea1cc7548eb6aa59b4a781aed60) (Robert Moore)
* [Add tick color API (#3344)](https://github.com/material-components/material-components-ios/commit/3cbd58837bca64f95fbaf7f543411d580be813c6) (Robert Moore)

### ActivityIndicator

#### Changes

* [MDCActivityIndicator shouldnt register as accessibility element when hidden (#3331)](https://github.com/material-components/material-components-ios/commit/d70fce4cf53f6723f3ced505a6c93965a94582c4) (John Detloff)

### Dialogs

#### Changes

* [Implement a semantic color themer. (#3313)](https://github.com/material-components/material-components-ios/commit/4f1c9fa382d41b2677ba80ed649ccc931732b475) (featherless)

### BottomNavigation

#### Changes

* [Update BottomNavigationBar color themer (#3316)](https://github.com/material-components/material-components-ios/commit/f31cd3010dd3568e22b41bc637ef8c7a3df59119) (John Detloff)

---

# 54.4.0

## New features

Buttons now has a Typography themer.

MDCFlatButton now has a color themer API.

## API changes

## Component changes

### Buttons

#### Changes

* [Implement a color themer for an MDCFlatButton (#3308)](https://github.com/material-components/material-components-ios/commit/482bd56d46cb51e1e01e1b4359850d04a0b04a13) (Yarden Eitan)
* [Implement a typography themer. (#3318)](https://github.com/material-components/material-components-ios/commit/2146d297b11a0c6353976f0fb63f055fcd92047a) (Yarden Eitan)

---

# 54.3.0

This release continues to expand our support for component Color and Typography theming.

## New features

Buttons and Snackbar now have a Color themer.

BottomNavigationBar, Chips, NavigationBar, TextFields each now have a Typography themer.

## Component changes

### Buttons

#### Changes

* [Implement a semantic color scheme color themer API. (#3306)](https://github.com/material-components/material-components-ios/commit/99fd914646bfa611d3ddb2845cb7b0b5d6bc3fae) (Yarden Eitan)

### TextFields

#### Changes

* [Typography Themer implementation. (#3303)](https://github.com/material-components/material-components-ios/commit/0efdeb2a3f0d23a3521a35c748893c11d0458e7a) (Mohammad Cazi)

### Chips

#### Changes

* [Chips typography implementation. (#3312)](https://github.com/material-components/material-components-ios/commit/81351551f633ae819f241830460e38c08eea637e) (Mohammad Cazi)

### Snackbar

#### Changes

* [Implement a semantic color scheme color themer API. (#3287)](https://github.com/material-components/material-components-ios/commit/66f9b8702a25e1486620561bedeffe3489459a9b) (Yarden Eitan)

### NavigationBar

#### Changes

* [typography implementation. (#3304)](https://github.com/material-components/material-components-ios/commit/8e83dcf3436accaf5367505f8e383bc152886b99) (Mohammad Cazi)

### BottomNavigation

#### Changes

* [BottomNavigationBar Typography Implementation, (#3311)](https://github.com/material-components/material-components-ios/commit/fe10c83c5d8c95c6d5417b36a7ba62aed46ca342) (Mohammad Cazi)

### FlexibleHeader

#### Changes

* [Fix Flexible Header Configurator catalog example (#3254)](https://github.com/material-components/material-components-ios/commit/0797becc18f005263dfe72eb75e63246948c11e6) (John Detloff)

---

# 54.2.0

## New features

Dialogs, FeatureHighlight, and TabBar now each have a Typography themer.

ActivityIndicator and AppBar now have an updated Color themer.

## API changes

### FeatureHighlight

#### MDCFeatureHighlightViewController

*new* property: `titleFont` in `MDCFeatureHighlightViewController`

*new* property: `bodyFont` in `MDCFeatureHighlightViewController`

### TextFields

#### MDCTextInputController

*new* property: `textInputFont` in `MDCTextInputController`

*new* property: `textInputFontDefault` in `MDCTextInputController`

## Component changes

### Tabs

#### Changes

* [Implementing TabBar Typography Themer. (#3278)](https://github.com/material-components/material-components-ios/commit/207e59d1b190fbae69a72bea6c4cb2321eb3fa5c) (Mohammad Cazi)

### FeatureHighlight

#### Changes

* [Implementation of Typography Themer. (#3268)](https://github.com/material-components/material-components-ios/commit/8563ec05c77973f76c28c694ea3cceb16c2a0c67) (Mohammad Cazi)
* [exposing title and body font for FeatureHighlightViewController. (#3274)](https://github.com/material-components/material-components-ios/commit/2962b79503a27cc36319983ef237f399b2c7fdca) (Mohammad Cazi)

### AppBar

#### Changes

* [Implement semantic color themer. (#3283)](https://github.com/material-components/material-components-ios/commit/0ad1f5dfb29cb6ff63b47085c7d33ece0610a0c7) (featherless)

### TextFields

#### Changes

* [expose input text font property on controller. (#3272)](https://github.com/material-components/material-components-ios/commit/a15a0a7e3a7535a172570282ea1d3be058db1229) (Mohammad Cazi)

### Slider

#### Changes

* [Fix green Slider example color (#3292)](https://github.com/material-components/material-components-ios/commit/2b37db4c90118bd8a654cd5732e148ee17f8a493) (Robert Moore)

### NavigationBar

#### Changes

* [Forcing Font size now does save the right FontName for every case. (#3299)](https://github.com/material-components/material-components-ios/commit/bc3b4e871bd34f137c61112db7eeeff5afd452a7) (Mohammad Cazi)

### ActivityIndicator

#### Changes

* [Update Activity Indicator accessibility label and value (#3261)](https://github.com/material-components/material-components-ios/commit/7b38f3fa2d8e39c5c7e915ffb49fd438cf45fd87) (John Detloff)
* [Update ActivityIndicator Color Themer (#3259)](https://github.com/material-components/material-components-ios/commit/eb3167032ff65c854dd5a8a8e3fe637aadda4f81) (John Detloff)

### Dialogs

#### Changes

* [Implement MDCAlertController typography themer. (#3302)](https://github.com/material-components/material-components-ios/commit/7716981f1fd630e8ee5bb2132d6703ed23d393f4) (Mohammad Cazi)

---

# 54.1.0

## New features

Snackbar now has a Typography themer.

NavigationBar now exposes a Color themer API that makes use of the `MDCColorScheming` type.

## Component changes

### FeatureHighlight

#### Changes

* [cleaning up dynamic type support for feature highlight by defining the default. (#3269)](https://github.com/material-components/material-components-ios/commit/98740fac547f863d5ed80b9ca56cceb650f6f8ab) (Mohammad Cazi)

### Ink

#### Changes

* [Fix flaky test (#3290)](https://github.com/material-components/material-components-ios/commit/b5e2935b53ed4315dfafaedc24770b433f5b050f) (Yarden Eitan)

### Snackbar

#### Changes

* [Implement a typography themer. (#3288)](https://github.com/material-components/material-components-ios/commit/0efc202c35b6c3facbb4f70a25513cfeb21d5dc5) (Yarden Eitan)

### NavigationBar

#### Changes

* [Implement a semantic color scheme color themer API. (#3267)](https://github.com/material-components/material-components-ios/commit/38595c65092358375f9423ed9cf181a760f8a4f1) (featherless)

### Dialogs

#### Changes

* [Loading the view manually caused view did load not to be called.  (#3281)](https://github.com/material-components/material-components-ios/commit/de1119c21e1b7f471b82cd98bdaee471a51fb351) (Mohammad Cazi)

---

# 54.0.1

Added missing CocoaPods dependencies from v54.0.0.

---

# 54.0.0

## Breaking changes

`MDCMaskedTransition` has been removed and replaced with `MDCMaskedTransitionController`. You may
now use `MDCMaskedTransitionController` as a standard UIKit transitioning delegate.

## New features

Many components now expose new public APIs for configuring typography, color, and shapes.

## API changes

### Cards

#### MDCCardCollectionCell

*new* property: `shapeGenerator` in `MDCCardCollectionCell`

#### MDCCard

*new* property: `shapeGenerator` in `MDCCard`

### Dialogs

#### MDCAlertController

*new* property: `titleColor` in `MDCAlertController`

*new* property: `titleFont` in `MDCAlertController`

*new* property: `messageFont` in `MDCAlertController`

*new* property: `buttonTitleColor` in `MDCAlertController`

*new* property: `buttonFont` in `MDCAlertController`

*new* property: `messageColor` in `MDCAlertController`

### MaskedTransition

#### MDCMaskedTransition

*removed* class: `MDCMaskedTransition`

*removed* method: `-init` in `MDCMaskedTransition`

*removed* method: `-initWithSourceView:` in `MDCMaskedTransition`

*removed* property: `calculateFrameOfPresentedView` in `MDCMaskedTransition`

#### MDCMaskedTransitionController

*new* property: `sourceView` in `MDCMaskedTransitionController`

*new* method: `-initWithSourceView:` in `MDCMaskedTransitionController`

*new* method: `-init` in `MDCMaskedTransitionController`

*new* property: `calculateFrameOfPresentedView` in `MDCMaskedTransitionController`

*new* class: `MDCMaskedTransitionController`

### NavigationBar

#### MDCNavigationBar

*new* property: `titleFont` in `MDCNavigationBar`

*new* property: `titleTextColor` in `MDCNavigationBar`

### Snackbar

#### MDCSnackbarManager

*new* class method: `+buttonTitleColorForState:` in `MDCSnackbarManager`

*new* property: `mdc_adjustsFontForContentSizeCategory` in `MDCSnackbarManager`

*new* property: `snackbarMessageViewBackgroundColor` in `MDCSnackbarManager`

*new* property: `shouldApplyStyleChangesToVisibleSnackbars` in `MDCSnackbarManager`

*new* property: `buttonFont` in `MDCSnackbarManager`

*new* class method: `+setButtonTitleColor:forState:` in `MDCSnackbarManager`

*new* property: `snackbarMessageViewShadowColor` in `MDCSnackbarManager`

*new* property: `messageTextColor` in `MDCSnackbarManager`

*new* property: `messageFont` in `MDCSnackbarManager`

*modified* class method: `+setPresentationHostView:` in `MDCSnackbarManager`

| Type of change: | Declaration |
|---|---|
| From: | `+ (void)setPresentationHostView:(UIView *)hostView;` |
| To: | `+ (void)setPresentationHostView:(nullable UIView *)hostView;` |

*modified* class method: `+dismissAndCallCompletionBlocksWithCategory:` in `MDCSnackbarManager`

| Type of change: | Declaration |
|---|---|
| From: | `+ (void)dismissAndCallCompletionBlocksWithCategory:(NSString *)category;` |
| To: | `+ (void)dismissAndCallCompletionBlocksWithCategory:     (nullable NSString *)category;` |

*modified* class method: `+suspendMessagesWithCategory:` in `MDCSnackbarManager`

| Type of change: | Swift declaration |
|---|---|
| From: | `class func suspendMessages(withCategory category: Any!) -> MDCSnackbarSuspensionToken!` |
| To: | `class func suspendMessages(withCategory category: Any!) -> MDCSnackbarSuspensionToken?` |

*modified* class method: `+suspendMessagesWithCategory:` in `MDCSnackbarManager`

| Type of change: | Declaration |
|---|---|
| From: | `+ (id<MDCSnackbarSuspensionToken>)suspendMessagesWithCategory:     (NSString *)category;` |
| To: | `+ (nullable id<MDCSnackbarSuspensionToken>)suspendMessagesWithCategory:     (nullable NSString *)category;` |

*modified* class method: `+showMessage:` in `MDCSnackbarManager`

| Type of change: | Swift declaration |
|---|---|
| From: | `class func show(_ message: MDCSnackbarMessage!)` |
| To: | `class func show(_ message: MDCSnackbarMessage?)` |

*modified* class method: `+showMessage:` in `MDCSnackbarManager`

| Type of change: | Declaration |
|---|---|
| From: | `+ (void)showMessage:(MDCSnackbarMessage *)message;` |
| To: | `+ (void)showMessage:(nullable MDCSnackbarMessage *)message;` |

*modified* class method: `+suspendAllMessages` in `MDCSnackbarManager`

| Type of change: | Swift declaration |
|---|---|
| From: | `class func suspendAllMessages() -> MDCSnackbarSuspensionToken!` |
| To: | `class func suspendAllMessages() -> MDCSnackbarSuspensionToken?` |

*modified* class method: `+suspendAllMessages` in `MDCSnackbarManager`

| Type of change: | Declaration |
|---|---|
| From: | `+ (id<MDCSnackbarSuspensionToken>)suspendAllMessages;` |
| To: | `+ (nullable id<MDCSnackbarSuspensionToken>)suspendAllMessages;` |

*modified* class method: `+resumeMessagesWithToken:` in `MDCSnackbarManager`

| Type of change: | Swift declaration |
|---|---|
| From: | `class func resumeMessages(with token: MDCSnackbarSuspensionToken!)` |
| To: | `class func resumeMessages(with token: MDCSnackbarSuspensionToken?)` |

*modified* class method: `+resumeMessagesWithToken:` in `MDCSnackbarManager`

| Type of change: | Declaration |
|---|---|
| From: | `+ (void)resumeMessagesWithToken:(id<MDCSnackbarSuspensionToken>)token;` |
| To: | `+ (void)resumeMessagesWithToken:(nullable id<MDCSnackbarSuspensionToken>)token;` |

### Themes

#### MDCFontScheme

Moved to schemes/Typography.

#### MDCTonalPalette

Moved to schemes/Color.

#### MDCTonalColorScheme

Moved to schemes/Color.

#### MDCColorScheme

Moved to schemes/Color.

#### MDCBasicColorScheme

Moved to schemes/Color.

#### MDCBasicFontScheme

Moved to schemes/Typography.

### schemes/Typography

**New component.**

## Component changes

### Tabs

#### Changes

* [Disable TabBar test throwing an exception (#3221)](https://github.com/material-components/material-components-ios/commit/d63d4fe79daf9242a5eba8d071ac27006b8be534) (ianegordon)
* [Revert "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3256)](https://github.com/material-components/material-components-ios/commit/83b9ea1735a6d38359896e79452713bd85341ef3) (featherless)
* [[Typography] Migrate from FontScheme to TypographyScheming (#3219)](https://github.com/material-components/material-components-ios/commit/2e48edf99f8c73c81ba4d782f51a55faf06d23a8) (ianegordon)

### MaskedTransition

#### Changes

* [Convert MaskedTransition from a MotionTransitioning Transition type to a vanilla UIKit type (#3070)](https://github.com/material-components/material-components-ios/commit/44515ba81a919bb6c4d61a86448985dab5d54730) (featherless)

### schemes/Color

#### Changes

* [[Color] Implement a swift-friendly API for color scheme defaults. (#3246)](https://github.com/material-components/material-components-ios/commit/246ab9ed9baaab9d6d9e91ad1e4ec13ee34357c8) (featherless)
* [[Color] Reduce the public API contract for MDCSemanticColorScheme. (#3234)](https://github.com/material-components/material-components-ios/commit/f0d9c792f8d9005ed01320aa0c8f723dd28b2870) (featherless)
* [[Color] Remove straggling reference to NSCoding. (#3237)](https://github.com/material-components/material-components-ios/commit/7a93e933e74c7e27bce8909c7bf7a6e35e51b66f) (featherless)
* [[Themes] Add new semantic color scheme (#3216)](https://github.com/material-components/material-components-ios/commit/2be6cd9de54743df7ec768e62c9d52c24333dbee) (featherless)

### schemes/Typography

#### Changes

* [Partial roll-forward of "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3258)](https://github.com/material-components/material-components-ios/commit/6620da4d965890af8ea3f9e8fce0e518b9ed33b0) (featherless)
* [Revert "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3256)](https://github.com/material-components/material-components-ios/commit/83b9ea1735a6d38359896e79452713bd85341ef3) (featherless)
* [[Typography] Fix build breakage due to missing implementation of MDCBasicFontScheme. (#3242)](https://github.com/material-components/material-components-ios/commit/94ae187e035103cbc799e50fb78a636e88861172) (featherless)
* [[Typography] Migrate from FontScheme to TypographyScheming (#3219)](https://github.com/material-components/material-components-ios/commit/2e48edf99f8c73c81ba4d782f51a55faf06d23a8) (ianegordon)

### FeatureHighlight

#### Changes

* [Adding Color Themer. (#3260)](https://github.com/material-components/material-components-ios/commit/fa00c708b73b3276eb2f86a1274f098c14ffbcf0) (Mohammad Cazi)
* [Revert "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3256)](https://github.com/material-components/material-components-ios/commit/83b9ea1735a6d38359896e79452713bd85341ef3) (featherless)
* [[Typography] Migrate from FontScheme to TypographyScheming (#3219)](https://github.com/material-components/material-components-ios/commit/2e48edf99f8c73c81ba4d782f51a55faf06d23a8) (ianegordon)

### AppBar

#### Changes

* [Color Themer now composes to the FlexibleHeader and NavigationBar color themers. (#3210)](https://github.com/material-components/material-components-ios/commit/e68eda7c8cf7a40a34d1b79b088ad5ddee91e663) (featherless)

### Ink

#### Changes

* [[Cards] Added Shapes support for MDCCard and MDCCardCollectionCell + 2 Examples (#3215)](https://github.com/material-components/material-components-ios/commit/af2a3c89d2db301ad05fd2d3eb1e6dae5f057e46) (Yarden Eitan)

### ButtonBar

#### Changes

* [Implement new semantic color scheme themer APIs. (#3252)](https://github.com/material-components/material-components-ios/commit/5c09f5e625ab65dac2670cc1dabb9f1f5d28cb94) (featherless)
* [Update documentation for the themer. (#3265)](https://github.com/material-components/material-components-ios/commit/9d9e8cd3bacd8feded1f89c7f0936c1293cc7ff2) (featherless)

### TextFields

#### Changes

* [Adding Color Themer. (#3255)](https://github.com/material-components/material-components-ios/commit/75c81a1659e01fa13ba12e4868d3c4aa27f9741a) (Mohammad Cazi)
* [Revert "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3256)](https://github.com/material-components/material-components-ios/commit/83b9ea1735a6d38359896e79452713bd85341ef3) (featherless)
* [[Typography] Migrate from FontScheme to TypographyScheming (#3219)](https://github.com/material-components/material-components-ios/commit/2e48edf99f8c73c81ba4d782f51a55faf06d23a8) (ianegordon)

### Chips

#### Changes

* [Revert "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3256)](https://github.com/material-components/material-components-ios/commit/83b9ea1735a6d38359896e79452713bd85341ef3) (featherless)
* [[Typography] Migrate from FontScheme to TypographyScheming (#3219)](https://github.com/material-components/material-components-ios/commit/2e48edf99f8c73c81ba4d782f51a55faf06d23a8) (ianegordon)

### Snackbar

#### Changes

* [Removed dependency on UIAppearance entirely for color/font customization/theming. (#3223)](https://github.com/material-components/material-components-ios/commit/bbf1126b8fbf11c85e1dad8d0cad5cf912c0a8c8) (Yarden Eitan)
* [Revert "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3256)](https://github.com/material-components/material-components-ios/commit/83b9ea1735a6d38359896e79452713bd85341ef3) (featherless)
* [[Typography] Migrate from FontScheme to TypographyScheming (#3219)](https://github.com/material-components/material-components-ios/commit/2e48edf99f8c73c81ba4d782f51a55faf06d23a8) (ianegordon)

### Cards

#### Changes

* [Added Shapes support for MDCCard and MDCCardCollectionCell + 2 Examples (#3215)](https://github.com/material-components/material-components-ios/commit/af2a3c89d2db301ad05fd2d3eb1e6dae5f057e46) (Yarden Eitan)

### NavigationBar

#### Changes

* [Add an API for customizing the title label's text color. (#3266)](https://github.com/material-components/material-components-ios/commit/8c8b8d0a7e8512d9d9a7841d2e35f465ee3d2b5e) (featherless)
* [[MDCNavigationBar] Exposing typography API. (#3217)](https://github.com/material-components/material-components-ios/commit/b0aaa07cb28c1c69df3ca61397d6a9baf027047f) (Mohammad Cazi)

### Dialogs

#### Changes

* [Expose typography and color API. (#3218)](https://github.com/material-components/material-components-ios/commit/a61f529825418130b44227eeeed1822eedcdf67f) (Mohammad Cazi)

### FlexibleHeader

#### Changes

* [Implement a color themer API with the new MDCColorScheming type. (#3236)](https://github.com/material-components/material-components-ios/commit/1e2ed55efe872e35aeced9873968a6a627419d7b) (featherless)
* [Revert "Fix bug where shadow layer's opacity wouldn't be set without a tracking scroll view. (#3201)" (#3225)](https://github.com/material-components/material-components-ios/commit/bcecad50f8a385ac641fd6b10f5968bec49c4dd9) (Robert Moore)
* [Revert "Revert "Fix bug where shadow layer's opacity wouldn't be set without a tracking scroll view. (#3201)" (#3225)" (#3229)](https://github.com/material-components/material-components-ios/commit/aaf882e81103c9fac238be7ee15d4acb740aab0e) (Robert Moore)

### Themes

#### Changes

* [Add new semantic color scheme (#3216)](https://github.com/material-components/material-components-ios/commit/2be6cd9de54743df7ec768e62c9d52c24333dbee) (featherless)
* [Partial roll-forward of "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3258)](https://github.com/material-components/material-components-ios/commit/6620da4d965890af8ea3f9e8fce0e518b9ed33b0) (featherless)
* [Revert "[Typography] Migrate from FontScheme to TypographyScheming (#3219)" (#3256)](https://github.com/material-components/material-components-ios/commit/83b9ea1735a6d38359896e79452713bd85341ef3) (featherless)
* [[Catalog] Remove the global theme change notifications. (#3213)](https://github.com/material-components/material-components-ios/commit/fcfe9d810e98df072ccbdd8d494f4c067e0f2cc1) (featherless)
* [[Typography] Migrate from FontScheme to TypographyScheming (#3219)](https://github.com/material-components/material-components-ios/commit/2e48edf99f8c73c81ba4d782f51a55faf06d23a8) (ianegordon)

---

# 53.0.0

## Component Changes

### ButtonBar

#### Changes

* [Revert "[AppBar] Make MDCNavigationBar and MDCButtonBar size dynamically (#2974)" (#3276)](https://github.com/material-components/material-components-ios/commit/a5c0c8603e12075cb2f37334c6bf5af4584ee307) (Robert Moore)

### NavigationBar

#### Changes

* [Revert "[AppBar] Make MDCNavigationBar and MDCButtonBar size dynamically (#2974)" (#3276)](https://github.com/material-components/material-components-ios/commit/a5c0c8603e12075cb2f37334c6bf5af4584ee307) (Robert Moore)

---

# 52.0.0

## Breaking changes

### BottomNavigation
* Color themer now only uses `primaryColor` and applies it to the `selectedItemTintColor`. It will no longer apply values to either `unselectedItemTintColor` or `barTintColor`.

### TextFields
* TextFields will no longer default to using Dynamic Type.
* TextFields with floating placeholders now account for the placeholder when
  computing their bounds.

## API Changes

### TextFields

#### MDCTextInputControllerLegacyDefault

*modified* class: `MDCTextInputControllerLegacyDefault`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCTextInputControllerLegacyDefault : NSObject, MDCTextInputControllerFloatingPlaceholder` |
| To: | `class MDCTextInputControllerLegacyDefault : MDCTextInputControllerBase` |

*modified* class: `MDCTextInputControllerLegacyDefault`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextInputControllerLegacyDefault     : NSObject <MDCTextInputControllerFloatingPlaceholder>` |
| To: | `@interface MDCTextInputControllerLegacyDefault : MDCTextInputControllerBase` |

#### MDCTextInputControllerLegacyFullWidth

*modified* class: `MDCTextInputControllerLegacyFullWidth`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCTextInputControllerLegacyFullWidth : NSObject, MDCTextInputController` |
| To: | `class MDCTextInputControllerLegacyFullWidth : MDCTextInputControllerFullWidth, NSSecureCoding` |

*modified* class: `MDCTextInputControllerLegacyFullWidth`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextInputControllerLegacyFullWidth     : NSObject <MDCTextInputController>` |
| To: | `@interface MDCTextInputControllerLegacyFullWidth     : MDCTextInputControllerFullWidth <NSSecureCoding>` |

#### MDCTextInputController

*removed* property: `textInputFont` in `MDCTextInputController`

*removed* property: `textInputFontDefault` in `MDCTextInputController`

### Color

**New component.**

## Component changes

### Tabs

#### Changes

* [Fix format string types in debug, examples (#3195)](https://github.com/material-components/material-components-ios/commit/2fd85a2c29026fb84ea339e1529300e312b3362d) (Robert Moore)

### schemes/Color

#### Changes

* [Add initial scaffolding for the Color scheme target. (#3171)](https://github.com/material-components/material-components-ios/commit/bd67db7c4e9380a4b791e2f4952455f4f4d7593a) (featherless)

### FeatureHighlight

#### Changes

* [Copy block instead of assign (#3159)](https://github.com/material-components/material-components-ios/commit/85ed8aed96cd24d895f9dcaf5dceb49f891cf451) (Robert Moore)
* [FeatureHighlightViewController should expose FeatureHighlightView as a property. (#3145)](https://github.com/material-components/material-components-ios/commit/24be789f57aedb732ceddecc36699f52875dc8d6) (Mohammad Cazi)
* [Revert "FeatureHighlightViewController should expose FeatureHighlightView as a property. (#3145)" (#3231)](https://github.com/material-components/material-components-ios/commit/8e8d6f263b598cbeebdbc05e6fd00f50b33ea082) (Robert Moore)

### Ink

#### Changes

* [Fixing static analyzer warnings from Xcode 9.3 (#3196)](https://github.com/material-components/material-components-ios/commit/72283d6b4b8cdb223aadbc33a6685c835702abe9) (Robert Moore)

### Buttons

#### Changes

* [Fixing static analyzer warnings from Xcode 9.3 (#3196)](https://github.com/material-components/material-components-ios/commit/72283d6b4b8cdb223aadbc33a6685c835702abe9) (Robert Moore)

### ButtonBar

#### Changes

* [Restore "[AppBar] Make MDCNavigationBar and MDCButtonBar size dynamically (#2974)" (#3243)](https://github.com/material-components/material-components-ios/commit/aac78b8451f745a555742b9091f0a90eb57cc094) (Robert Moore)
* [Revert "[AppBar] Make MDCNavigationBar and MDCButtonBar size dynamically (#2974)" (#3241)](https://github.com/material-components/material-components-ios/commit/890340e0bae74918afcfbf6a45fcbb3bbedda173) (Robert Moore)

### TextFields

#### Changes

* [Fixing static analyzer warnings from Xcode 9.3 (#3196)](https://github.com/material-components/material-components-ios/commit/72283d6b4b8cdb223aadbc33a6685c835702abe9) (Robert Moore)
* [Make MDCTextInputControllerLegacyDefault a subclass of MDCTextInputControllerBase  (#3152)](https://github.com/material-components/material-components-ios/commit/cb0d00be93bab192e83b0c07b83b655619bf8122) (Mohammad Cazi)
* [Make MDCTextInputControllerLegacyFullWidth a subclass of MDCTextInputControllerFullWidth (#3154)](https://github.com/material-components/material-components-ios/commit/19f2c0fd1be06e31e7405a42aadb1004c2af5bbf) (Mohammad Cazi)
* [Restore Dynamic Type to textInput (#3239)](https://github.com/material-components/material-components-ios/commit/1edaa5625d7c931840f382e1db6398c72a4f9da5) (Robert Moore)
* [Reverting textInputFont property on inputController. #3232](https://github.com/material-components/material-components-ios/commit/8d4d5ea1fc8f70e6fa644fc6d756aac282d12e3b) (Mohammad Cazi)
* [[MDCTextFields + Kokoro] Making textfields dynamic type off by default (#3149)](https://github.com/material-components/material-components-ios/commit/f91317ff0455bc6ecd7b7c728bdb9821cd036aa0) (Yarden Eitan)

### Chips

#### Changes

* [Fix documentation for flow layout class](https://github.com/material-components/material-components-ios/commit/0d8f8c98f4c30a5d8446b9372a652d8020ea8eea) (Robert Moore)

### Snackbar

#### Changes

* [Update content padding for new snackbar, leave old snackbar padding as is. (#3192)](https://github.com/material-components/material-components-ios/commit/8fb8e4c56b3be93c92af6ad7e5e1f7ecf6126120) (Yarden Eitan)
* [added inputAccessory with Snackbar dragon + Fix for it (#3156)](https://github.com/material-components/material-components-ios/commit/7a48b9171a1c3cbf7267ff337a027f28f429aa96) (Yarden Eitan)
* [font and color updates. (#3125)](https://github.com/material-components/material-components-ios/commit/28ef4730aaeb37663a377670b8db95215c090f92) (Yarden Eitan)
* [revert back to before #3106 as this code needs more thorough testing. (#3178)](https://github.com/material-components/material-components-ios/commit/a05140df1b8d2678cbd39fc5d7ea2a27cc1f1a74) (Yarden Eitan)

### NavigationBar

#### Changes

* [Fix RTL for titleView (#3193)](https://github.com/material-components/material-components-ios/commit/e661711251e0666385ce103ed95a354785fb6a01) (ianegordon)
* [Fixing static analyzer warnings from Xcode 9.3 (#3196)](https://github.com/material-components/material-components-ios/commit/72283d6b4b8cdb223aadbc33a6685c835702abe9) (Robert Moore)
* [Restore "[AppBar] Make MDCNavigationBar and MDCButtonBar size dynamically (#2974)" (#3243)](https://github.com/material-components/material-components-ios/commit/aac78b8451f745a555742b9091f0a90eb57cc094) (Robert Moore)
* [Revert "[AppBar] Make MDCNavigationBar and MDCButtonBar size dynamically (#2974)" (#3241)](https://github.com/material-components/material-components-ios/commit/890340e0bae74918afcfbf6a45fcbb3bbedda173) (Robert Moore)

### LibraryInfo

#### Changes

* [Bumped version number to 52.0.0.](https://github.com/material-components/material-components-ios/commit/e500aa658720c9ca42361ab3cb5eb59b9a2cf9a2) (Rob Moore)

### Dialogs

#### Changes

* [Add a Dragons samples to compare UIKit -vs- Material (#3197)](https://github.com/material-components/material-components-ios/commit/481c5f1a2d1d79a7c4f26655a660780488dd2f22) (ianegordon)
* [Fixed regression where in some cases tapping on the buttons in the alert would not do anything (#3182)](https://github.com/material-components/material-components-ios/commit/91f88a4da0070c3f09d1cedb8ac3dadd9aa56011) (Julien Poumailloux)

### BottomNavigation

#### Changes

* [Simplify color themer (#3116)](https://github.com/material-components/material-components-ios/commit/f0368d43838c35ae463afad3a5f75cead61753b5) (Robert Moore)

### PageControl

#### Changes

* [[Tabs] Fix format string types in debug, examples (#3195)](https://github.com/material-components/material-components-ios/commit/2fd85a2c29026fb84ea339e1529300e312b3362d) (Robert Moore)

### AnimationTiming

#### Changes

* [update contrast color for animation timing example (#3198)](https://github.com/material-components/material-components-ios/commit/1a9743ea7e6a6ca58a35b4ac9490ca312eaeec44) (Yarden Eitan)

### Collections

#### Changes

* [[Tabs] Fix format string types in debug, examples (#3195)](https://github.com/material-components/material-components-ios/commit/2fd85a2c29026fb84ea339e1529300e312b3362d) (Robert Moore)

### FlexibleHeader

#### Changes

* [Check if contentView is nil before the comparison (#3098)](https://github.com/material-components/material-components-ios/commit/5674772cb71bb749cddcb442c31d917aec648994) (Siyu Song)
* [Fix bug where shadow layer's opacity wouldn't be set without a tracking scroll view. (#3201)](https://github.com/material-components/material-components-ios/commit/d0af3a729b987b8614b2eadc577ce658cd3d0dcc) (featherless)
* [Revert "Fix bug where shadow layer's opacity wouldn't be set without a tracking scroll view. (#3201)" (#3230)](https://github.com/material-components/material-components-ios/commit/aea0b970687c1b78b2b90a00f734f56b34613242) (Robert Moore)
* [[Tabs] Fix format string types in debug, examples (#3195)](https://github.com/material-components/material-components-ios/commit/2fd85a2c29026fb84ea339e1529300e312b3362d) (Robert Moore)

### Palettes

#### Changes

* [Fixing static analyzer warnings from Xcode 9.3 (#3196)](https://github.com/material-components/material-components-ios/commit/72283d6b4b8cdb223aadbc33a6685c835702abe9) (Robert Moore)

---

# 50.0.0

## Breaking change

MDCTabBarFontThemer and MDCBottomAppBarColorThemer changed a argument to nonnull from nullable.

## API changes

### BottomNavigation

#### MDCBottomNavigationBar

*new* property: `backgroundColor` in `MDCBottomNavigationBar`

*new* property: `barTintColor` in `MDCBottomNavigationBar`

### Chips

#### MDCChipView

*new* property: `minimumSize` in `MDCChipView`

### Collections

#### MDCCollectionViewStyling

*new* property: `cardBorderRadius` in `MDCCollectionViewStyling`

### TextFields

#### MDCTextInputController

*new* property: `textInputFont` in `MDCTextInputController`

*new* property: `textInputFontDefault` in `MDCTextInputController`

## Component changes

### Tabs

#### Changes

* [[BottomAppBar, Tabs] Make themer parameters nonnull (#3133)](https://github.com/material-components/material-components-ios/commit/8882cc904623b9af5d2d15f84d229b6bdb60fd97) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### MaskedTransition

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### FeatureHighlight

#### Changes

* [Use safe selector access for color themers (#3126)](https://github.com/material-components/material-components-ios/commit/61277455f1c6b689a4b9fb80b0a9fc36fd283380) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### AppBar

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Ink

#### Changes

* [Use safe selector access for color themers (#3126)](https://github.com/material-components/material-components-ios/commit/61277455f1c6b689a4b9fb80b0a9fc36fd283380) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### CollectionCells

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Buttons

#### Changes

* [Use safe selector access for color themers (#3126)](https://github.com/material-components/material-components-ios/commit/61277455f1c6b689a4b9fb80b0a9fc36fd283380) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### ButtonBar

#### Changes

* [[AppBar] Make MDCNavigationBar and MDCButtonBar size dynamically (#2974)](https://github.com/material-components/material-components-ios/commit/7172657a7b1cd04839eadc10e9d66e895a71bee7) (Ali Rabbani)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### TextFields

#### Changes

* [Adding font themer (#3096)](https://github.com/material-components/material-components-ios/commit/91a376ffe1330c6c96344259d36c837c88188db3) (Mohammad Cazi)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Chips

#### Changes

* [Create a FontThemer (#3128)](https://github.com/material-components/material-components-ios/commit/6f1418df2a383f9fb72f476ebb34d502d0593428) (Robert Moore)
* [Support Dynamic Type and show it in example. (#3123)](https://github.com/material-components/material-components-ios/commit/92fecd4cdeff37592d16ddbe556777299e870573) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Snackbar

#### Changes

* [../ (#3122)](https://github.com/material-components/material-components-ios/commit/6d432c7ea082dedc9fc271c7a204a2dfce2fe140) (Yarden Eitan)
* [Don't traverse through dismissing presented child view controllers. (#3106)](https://github.com/material-components/material-components-ios/commit/26995ea72fde1889a28a3d2be448ed47eb35f3fa) (Yarden Eitan)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)
* [suppress internal use of deprecated property (#3143)](https://github.com/material-components/material-components-ios/commit/d42a5e8500d3008101511af1cadc2a7b11524b7b) (Yarden Eitan)

### Cards

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)
* [fix: update link to material design guidelines (#3121)](https://github.com/material-components/material-components-ios/commit/b3b8f13bb05758c55ed7ff54c080989dae00dec0) (radeva)

### BottomAppBar

#### Changes

* [[BottomAppBar, Tabs] Make themer parameters nonnull (#3133)](https://github.com/material-components/material-components-ios/commit/8882cc904623b9af5d2d15f84d229b6bdb60fd97) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Slider

#### Changes

* [Use safe selector access for color themers (#3126)](https://github.com/material-components/material-components-ios/commit/61277455f1c6b689a4b9fb80b0a9fc36fd283380) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### NavigationBar

#### Changes

* [[AppBar] Make MDCNavigationBar and MDCButtonBar size dynamically (#2974)](https://github.com/material-components/material-components-ios/commit/7172657a7b1cd04839eadc10e9d66e895a71bee7) (Ali Rabbani)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### OverlayWindow

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### LibraryInfo

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### ShadowLayer

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### ActivityIndicator

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### BottomSheet

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Typography

#### Changes

* [Support Dynamic Type in extensions for iOS >= 10. (#3127)](https://github.com/material-components/material-components-ios/commit/97465d22bb0df90e0e0f300de00935baa6ca8719) (Thomas-Redding-G)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Dialogs

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### BottomNavigation

#### Changes

* [Add `barTintColor` to replace `backgroundColor` (#3085)](https://github.com/material-components/material-components-ios/commit/a7ecc0b6500de5d5ba5c1e2dce05ff33893f540a) (Robert Moore)
* [Remove ink for canceled touch (#3119)](https://github.com/material-components/material-components-ios/commit/5010e7c09d855b5f72e3a23539b5be5164dc5437) (Robert Moore)
* [Use safe selector access for color themers (#3126)](https://github.com/material-components/material-components-ios/commit/61277455f1c6b689a4b9fb80b0a9fc36fd283380) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### PageControl

#### Changes

* [Use safe selector access for color themers (#3126)](https://github.com/material-components/material-components-ios/commit/61277455f1c6b689a4b9fb80b0a9fc36fd283380) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### AnimationTiming

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Collections

#### Changes

* [Add custom cardBorderRadius to MDCCollectionViewStyler (#3114)](https://github.com/material-components/material-components-ios/commit/7f1aa7d28350c6ee845d5024a6ceac2a0a015b63) (strangewiz)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### HeaderStackView

#### Changes

* [Use safe selector access for color themers (#3126)](https://github.com/material-components/material-components-ios/commit/61277455f1c6b689a4b9fb80b0a9fc36fd283380) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### FlexibleHeader

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Themes

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### ShadowElevations

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### ProgressView

#### Changes

* [Use safe selector access for color themers (#3126)](https://github.com/material-components/material-components-ios/commit/61277455f1c6b689a4b9fb80b0a9fc36fd283380) (Robert Moore)
* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### Palettes

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

### CollectionLayoutAttributes

#### Changes

* [[Kokoro / CI] Have Kokoro test multiple iOS versions and simulators on different Xcodes. (#3117)](https://github.com/material-components/material-components-ios/commit/7b742b574557adb5a499d469043738afe55ff6f7) (Yarden Eitan)

---

# 49.0.0

## Breaking changes

### BottomAppBar

#### MDCBottomAppBarView

*NS_UNAVAILABLE* property: `backgroundColor` in `MDCBottomAppBarView`

## API changes

### BottomAppBar

#### MDCBottomAppBarView

*new* property: `barTintColor` in `MDCBottomAppBarView`

*NS_UNAVAILABLE* property: `backgroundColor` in `MDCBottomAppBarView`

*new* property: `shadowColor` in `MDCBottomAppBarView`

*new* property: `backgroundColor` in `MDCBottomAppBarView`

### Dialogs

#### MDCAlertControllerView

*new* property: `titleColor` in `MDCAlertControllerView`

*new* property: `mdc_adjustsFontForContentSizeCategory` in `MDCAlertControllerView`

*new* class: `MDCAlertControllerView`

*new* property: `titleFont` in `MDCAlertControllerView`

*new* property: `buttonColor` in `MDCAlertControllerView`

*new* property: `buttonFont` in `MDCAlertControllerView`

*new* property: `messageColor` in `MDCAlertControllerView`

*new* property: `messageFont` in `MDCAlertControllerView`

## Component changes

### Snackbar

#### Changes

* [Added Color and Font Themers (#3102)](https://github.com/material-components/material-components-ios/commit/b782d2462ab9bfdd10959d27ab6d112ec9e441e8) (Yarden Eitan)
* [bring back buttonTextColor and deprecate it (#3104)](https://github.com/material-components/material-components-ios/commit/85c5351ec74354d5750fafb8d51bb2be0f58389e) (Yarden Eitan)

### BottomAppBar

#### Changes

* [Add simple color themer (#3094)](https://github.com/material-components/material-components-ios/commit/c82fafba3ea3e17a5b4f3ee4bf5b9564d24bb3bb) (Robert Moore)

### Dialogs

#### Changes

* [Enable custom fonts on MDCAlertController (#3097)](https://github.com/material-components/material-components-ios/commit/b22c8c2650a4a5b21c76cf37b3d1041de639e4e5) (ianegordon)

### Themes

#### Changes

* [[BottomAppBar] Add simple color themer (#3094)](https://github.com/material-components/material-components-ios/commit/c82fafba3ea3e17a5b4f3ee4bf5b9564d24bb3bb) (Robert Moore)

---

# 48.0.0

## Breaking changes

*removed* property: `highlightedButtonTextColor` in `MDCSnackbarMessage`

## New deprecations

#### MDCSnackbarMessage

*deprecated* property: `buttonTextColor` in `MDCSnackbarMessage`

#### MDCSnackbarMessageView()

*modified* property: `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

| Type of change: | Deprecation message |
|---|---|
| From: | `snackbarMessageViewTextColor` |
| To: | `messsageTextColor` |

*modified* property: `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

| Type of change: | Deprecation |
|---|---|
| From: | `0` |
| To: | `1` |

*modified* property: `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarMessageView` |
| To: | `c:objc(ext)MDCSnackbarMessageView@MDCSnackbarMessageView.h@2959` |

## New features

## API changes

### Snackbar

#### MDCSnackbarMessageView

*new* property: `messageTextColor` in `MDCSnackbarMessageView`

*new* method: `-buttonTitleColorForState:` in `MDCSnackbarMessageView`

*new* property: `mdc_adjustsFontForContentSizeCategory` in `MDCSnackbarMessageView`

*new* method: `-setButtonTitleColor:forState:` in `MDCSnackbarMessageView`

#### MDCSnackbarMessage

*new* property: `usesLegacySnackbar` in `MDCSnackbarMessage`

*removed* property: `highlightedButtonTextColor` in `MDCSnackbarMessage`

*removed* property: `buttonTextColor` in `MDCSnackbarMessage`

#### MDCSnackbarMessageView()

*new* method: `-snackbarMessageViewTextColor` in `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

*new* category: `MDCSnackbarMessageView()`

*new* method: `-setSnackbarMessageViewTextColor:` in `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

*modified* property: `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

| Type of change: | Deprecation message |
|---|---|
| From: | `` |
| To: | `Use messsageTextColor instead.` |

*modified* property: `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

| Type of change: | Deprecation |
|---|---|
| From: | `0` |
| To: | `1` |

*modified* property: `snackbarMessageViewTextColor` in `MDCSnackbarMessageView()`

| Type of change: | parent.usr |
|---|---|
| From: | `c:objc(cs)MDCSnackbarMessageView` |
| To: | `c:objc(ext)MDCSnackbarMessageView@MDCSnackbarMessageView.h@2959` |
## Component changes


### Tabs

#### Changes

* [Don't call UIAppearance in +initialize (#3067)](https://github.com/material-components/material-components-ios/commit/fcd8ffdc199e4efa8dc93141b627c24f98c2033e) (Robert Moore)
* [Font/Color Scheme support for tab bar. (#3083)](https://github.com/material-components/material-components-ios/commit/2cc00f431e2485316ce9ba0e6f67d511be81b8d4) (Mohammad Cazi)

### FeatureHighlight

#### Changes

* [Accessibility title and body mutator added to fix UIAppearance issue (#3043)](https://github.com/material-components/material-components-ios/commit/fa6a2f67d6886eb89d8182b809ecacab41d0a3ea) (Mohammad Cazi)

### Ink

#### Changes

* [[Button|Ink|TextFields|Palettes] Fixed NSNumber conversion static analyzer errors (#2998)](https://github.com/material-components/material-components-ios/commit/62735c8baf1968e6b287ef30aaf6b17744c5c237) (Yura Samsoniuk)

### Buttons

#### Changes

* [Set FlatButton inkColor via UIAppearance (#3069)](https://github.com/material-components/material-components-ios/commit/5fe8cf2752dcafad7b07d6f8935910f1597ed963) (Robert Moore)
* [Support IB custom fonts (#3082)](https://github.com/material-components/material-components-ios/commit/328b4ba57dcd5caeb7f21cf341704237baac280c) (Robert Moore)
* [[Button|Ink|TextFields|Palettes] Fixed NSNumber conversion static analyzer errors (#2998)](https://github.com/material-components/material-components-ios/commit/62735c8baf1968e6b287ef30aaf6b17744c5c237) (Yura Samsoniuk)

### TextFields

#### Changes

* [[Button|Ink|TextFields|Palettes] Fixed NSNumber conversion static analyzer errors (#2998)](https://github.com/material-components/material-components-ios/commit/62735c8baf1968e6b287ef30aaf6b17744c5c237) (Yura Samsoniuk)

### Snackbar

#### Changes

* [Fix compiler warning due to self reference in block (#3079)](https://github.com/material-components/material-components-ios/commit/1d796f2795706b98e55d935981a7e869fc2c7bdc) (featherless)
* [New Snackbar implementation with legacy toggle to activate (#3055)](https://github.com/material-components/material-components-ios/commit/f3845d2fd1c8c57e3329cd969830b2b7a6ca4eb0) (Yarden Eitan)
* [custom font and dynamic type support, UI_APPEARANCE support for color theming  (#3090)](https://github.com/material-components/material-components-ios/commit/9f735f15d9a912ea8479a78b1a99d99b36aa8d33) (Yarden Eitan)
* [update snackbar text color to the initialized value (#3081)](https://github.com/material-components/material-components-ios/commit/40876a38123096edf43ce1c76a3bccfe7eb08479) (Yarden Eitan)

### BottomSheet

#### Changes

* [Ensure BottomSheet adjusts its target point when its bounds change (#3028)](https://github.com/material-components/material-components-ios/commit/8e6866e80efd081b92c94cf92256e6d057df4772) (John Detloff)

### Themes

#### Changes

* [[FeatureHighlight] Accessibility title and body mutator added to fix UIAppearance issue (#3043)](https://github.com/material-components/material-components-ios/commit/fa6a2f67d6886eb89d8182b809ecacab41d0a3ea) (Mohammad Cazi)

### Palettes

#### Changes

* [[Button|Ink|TextFields|Palettes] Fixed NSNumber conversion static analyzer errors (#2998)](https://github.com/material-components/material-components-ios/commit/62735c8baf1968e6b287ef30aaf6b17744c5c237) (Yura Samsoniuk)

---

# 47.0.0

## Breaking changes

### Cards

#### MDCCardCollectionCell

*removed* property: `selectedImageTintColor` in `MDCCardCollectionCell`

*removed* property: `selectedImage` in `MDCCardCollectionCell`

## New deprecations

## New features

## API changes

### Cards

#### MDCCardCollectionCell

*new* method: `-setVerticalImageAlignment:forState:` in `MDCCardCollectionCell`

*new* method: `-setImageTintColor:forState:` in `MDCCardCollectionCell`

*new* method: `-horizontalImageAlignmentForState:` in `MDCCardCollectionCell`

*new* method: `-imageForState:` in `MDCCardCollectionCell`

*new* method: `-imageTintColorForState:` in `MDCCardCollectionCell`

*new* method: `-setImage:forState:` in `MDCCardCollectionCell`

*new* method: `-verticalImageAlignmentForState:` in `MDCCardCollectionCell`

*new* method: `-setHorizontalImageAlignment:forState:` in `MDCCardCollectionCell`

*removed* property: `selectedImageTintColor` in `MDCCardCollectionCell`

*removed* property: `selectedImage` in `MDCCardCollectionCell`

*modified* class: `MDCCardCollectionCell`

#### MDCCardCellVerticalImageAlignment

*new* enum value: `MDCCardCellVerticalImageAlignmentBottom` in `MDCCardCellVerticalImageAlignment`

*new* typedef: `MDCCardCellVerticalImageAlignment`

*new* enum: `MDCCardCellVerticalImageAlignment`

*new* enum value: `MDCCardCellVerticalImageAlignmentCenter` in `MDCCardCellVerticalImageAlignment`

*new* enum value: `MDCCardCellVerticalImageAlignmentTop` in `MDCCardCellVerticalImageAlignment`

#### MDCCardCellHorizontalImageAlignment

*new* enum value: `MDCCardCellHorizontalImageAlignmentRight` in `MDCCardCellHorizontalImageAlignment`

*new* enum value: `MDCCardCellHorizontalImageAlignmentCenter` in `MDCCardCellHorizontalImageAlignment`

*new* typedef: `MDCCardCellHorizontalImageAlignment`

*new* enum: `MDCCardCellHorizontalImageAlignment`

*new* enum value: `MDCCardCellHorizontalImageAlignmentLeft` in `MDCCardCellHorizontalImageAlignment`

## Component changes

### Tabs

#### Changes

* [[MDCTabBarViewController] Added NSCoding support. (#3029)](https://github.com/material-components/material-components-ios/commit/ca02350c09360ca350750dd8c8d71580c3e44108) (Mohammad Cazi)
* [[MDCTabBar] NSCoding support. (#3019)](https://github.com/material-components/material-components-ios/commit/5ffadf0697a48c48b61a4baab4123eb072ea21ed) (Mohammad Cazi)

### FeatureHighlight

#### Changes

* [Remove use of __typeof__ (#3018)](https://github.com/material-components/material-components-ios/commit/0c97e585d5ce04196d98ea0badc52d9bd96e33e2) (Robert Moore)

### Ink

#### Changes

* [New bounded ink should ignore maxRippleRadius property (#2956)](https://github.com/material-components/material-components-ios/commit/a25ee2d848132490c02c62770c6c7bd5e359cbe8) (Robert Moore)

### CollectionCells

#### Changes

* [[Collections] Fix image sizing (#3027)](https://github.com/material-components/material-components-ios/commit/7bc25ac4e6313c83886dd5784bd051880db22bd1) (ianegordon)

### ButtonBar

#### Changes

* [Remove UIAppearance call in themer (#3020)](https://github.com/material-components/material-components-ios/commit/dcbe2e5cd70b1db54beb610e019e60cf9f24046b) (Robert Moore)
* [Update bazel workspace and version to latest. (#3052)](https://github.com/material-components/material-components-ios/commit/58afde19c72de1a93a0f154fcf4b7e5b24bae97f) (featherless)

### TextFields

#### Changes

* [Added test for MDCTextInputControllerBase (#3036)](https://github.com/material-components/material-components-ios/commit/9c4858c383d1acc81a15a8e229dbf151f010e0cc) (Yura Samsoniuk)
* [Always encode/decode CGFloat as double (#3033)](https://github.com/material-components/material-components-ios/commit/af1bb4418f4b4865d995b879c5c99b32560d50f6) (Yura Samsoniuk)
* [Cast to a protocol textInput conforms to (#3037)](https://github.com/material-components/material-components-ios/commit/f8364d89c4ef3f7fc71a059ee27cb1dd2021cab2) (Yura Samsoniuk)
* [[Collections|TextFields|Themes] Removed dead store static analyzer errors (#2999)](https://github.com/material-components/material-components-ios/commit/32951859b45ef5983ca18a2a6b9a23a9085443d3) (Yura Samsoniuk)

### Snackbar

#### Changes

* [Don't call UIAppearance in +initialize (#3048)](https://github.com/material-components/material-components-ios/commit/b56f296dabe92c3f7e5baa02646d986e9593e1ac) (Robert Moore)

### Cards

#### Changes

* [Added customization of image, image alignment, and image tint for each state. (#3030)](https://github.com/material-components/material-components-ios/commit/bafdbf325c3522350b92a625db1e51b08a9d55bb) (Yarden Eitan)
* [Dragons demo for Tint color in Cards (#3046)](https://github.com/material-components/material-components-ios/commit/7fc91d88b77ce0c7208cd755bbe3710a1f4688fc) (Yarden Eitan)

### NavigationBar

#### Changes

* [Fix license stanza (#3025)](https://github.com/material-components/material-components-ios/commit/70e9cbcbdf2e28d3e598e95e0ade79cd8de3ec19) (Robert Moore)
* [[ButtonBar] Remove UIAppearance call in themer (#3020)](https://github.com/material-components/material-components-ios/commit/dcbe2e5cd70b1db54beb610e019e60cf9f24046b) (Robert Moore)

### BottomSheet

#### Changes

* [Make MDCBottomSheetPresentationController react to preferred content size changes of the presented view controller.](https://github.com/material-components/material-components-ios/commit/293996a05a6230310442e3ee4b6d2ca0130ac102) (Material Components iOS Team)

### BottomNavigation

#### Changes

* [Fix OS version check (#3015)](https://github.com/material-components/material-components-ios/commit/e34908bdbd50ae0f801991dadbe692fe6c17d2c5) (Robert Moore)
* [Fix memory leak in example (#3017)](https://github.com/material-components/material-components-ios/commit/a2e31fc7f69d5e5cf668865d7d745becb5c024d1) (Robert Moore)

### PageControl

#### Changes

* [Fixing example layout (#3059)](https://github.com/material-components/material-components-ios/commit/29af16e46d33c87d11fc274b085f109aed376d6e) (Robert Moore)

### Collections

#### Changes

* [[Collections|TextFields|Themes] Removed dead store static analyzer errors (#2999)](https://github.com/material-components/material-components-ios/commit/32951859b45ef5983ca18a2a6b9a23a9085443d3) (Yura Samsoniuk)
* [[MDCCollectionViewFlowLayout] Set hasSectionItems in ordinalPositionForListElementWithAttribute (#3049)](https://github.com/material-components/material-components-ios/commit/caf58f30894815c147b297990ce16a23b1d8e065) (strangewiz)

### Themes

#### Changes

* [[Collections|TextFields|Themes] Removed dead store static analyzer errors (#2999)](https://github.com/material-components/material-components-ios/commit/32951859b45ef5983ca18a2a6b9a23a9085443d3) (Yura Samsoniuk)

---

# 46.1.1

## Component changes

### CollectionCells

#### Changes

* [[Collections] Fix image sizing (#3027)](https://github.com/material-components/material-components-ios/commit/aa266761061c12892259ab139a45ad209b7d9afd) (ianegordon)

---

# 46.1.0

## API changes

### ActivityIndicator

#### MDCActivityIndicator

*new* method: `-setProgress:animated:` in `MDCActivityIndicator`

### Themes

#### MDCTonalPalette

*modified* class: `MDCTonalPalette`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCTonalPalette : NSObject, NSCoding, NSCopying` |
| To: | `class MDCTonalPalette : NSObject, NSCopying, NSSecureCoding` |

*modified* class: `MDCTonalPalette`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTonalPalette : NSObject <NSCoding, NSCopying>` |
| To: | `@interface MDCTonalPalette : NSObject <NSCopying, NSSecureCoding>` |
## Component changes


### Tabs

#### Changes

* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### MaskedTransition

#### Changes

* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### FeatureHighlight

#### Changes

* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### Ink

#### Changes

* [[MDCBottomNavigationBar] NSSecureCoding. (#2973)](https://github.com/material-components/material-components-ios/commit/705b76f8a468878a9213d49ee6690386b34a7c2e) (Mohammad Cazi)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### CollectionCells

#### Changes

* [Add demonstration of #2911 (#2930)](https://github.com/material-components/material-components-ios/commit/117864b0b50a9d488a134aa69072a31ef5b11ce1) (ianegordon)
* [Support images larger than 40x40 in MDCCollectionViewTextCell (#2912)](https://github.com/material-components/material-components-ios/commit/b089e47b4f10761e7fedfea9ae22ef9721b91f0f) (Ben Hamilton (Ben Gertzfield))
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### Buttons

#### Changes

* [[MDCButtonBar] add NSSecureCoding. (#2976)](https://github.com/material-components/material-components-ios/commit/cdea5d6836f529f75d211b8052a19ad86361663c) (Mohammad Cazi)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)
* [fix local kokoro warnings and errors (#2964)](https://github.com/material-components/material-components-ios/commit/87f9f591921e829c60401b443d2fe48882388e5c) (Yarden Eitan)

### ButtonBar

#### Changes

* [[MDCButtonBar] add NSSecureCoding. (#2976)](https://github.com/material-components/material-components-ios/commit/cdea5d6836f529f75d211b8052a19ad86361663c) (Mohammad Cazi)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### TextFields

#### Changes

* [Adding secure coding for all MDCTextfield and properties of it. (#2990)](https://github.com/material-components/material-components-ios/commit/c52bc7cc58e974a2ddac339579f259068dd11214) (Mohammad Cazi)
* [Fix for GH #2985 (placeholder not moving when chips needs it to.) (#2989)](https://github.com/material-components/material-components-ios/commit/7007607b2e8bb763fe487d82517359fcfb618187) (Will Larche)
* [Updating cursor color for state. (#2967)](https://github.com/material-components/material-components-ios/commit/002b83a15856df06c01bdde55292946811159c07) (Will Larche)
* [[TextField] Fix MDCTextInputControllerUnderline usage description in README.md (#2950)](https://github.com/material-components/material-components-ios/commit/37e721791081a8d3dc20f6e5bdd7b034f5a84ee1) (yokoe)

### Chips

#### Changes

* [ChipView class check for encoding. (#2993)](https://github.com/material-components/material-components-ios/commit/e1707dbcb23d96872a1d9634adcef48f16bb3468) (Mohammad Cazi)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### Snackbar

#### Changes

* [[SnackbarExmaples] Added required super call (#3005)](https://github.com/material-components/material-components-ios/commit/d10d499d80e3dd2dbecfe049903dcb7a3a9031eb) (Yura Samsoniuk)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### Cards

#### Changes

* [[CollectionCells] Add demonstration of #2911 (#2930)](https://github.com/material-components/material-components-ios/commit/117864b0b50a9d488a134aa69072a31ef5b11ce1) (ianegordon)
* [[MDCCard] NSSecureCoding support. (#2984)](https://github.com/material-components/material-components-ios/commit/8d030b94652c3e6825d8592c9a1acafdef0fe097) (Mohammad Cazi)

### BottomAppBar

#### Changes

* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### NavigationBar

#### Changes

* [[MDCAppBar]Support NSSecureCoding for App bar. (#2959)](https://github.com/material-components/material-components-ios/commit/b4491c9c9ace370989f87f25a8d2b9f595d52c2c) (Mohammad Cazi)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### ShadowLayer

#### Changes

* [Document default elevation of 0 (#2960)](https://github.com/material-components/material-components-ios/commit/c7a9b6966e356c6291107f59099d62e471d68aa6) (Robert Moore)

### ActivityIndicator

#### Changes

* [Add setProgress:animated: (#2924)](https://github.com/material-components/material-components-ios/commit/872dacb68fef1b20e9ee4a5e44e0cba664fe029b) (ianegordon)
* [Fixed ActivityIndicatorTests#testSetProgressStrokeAnimated test (#3006)](https://github.com/material-components/material-components-ios/commit/921c9f09e4ee604a72e7ecf2e1c08ad0410be475) (Yura Samsoniuk)
* [Fixing Implicit Self inside blocks. (#2954)](https://github.com/material-components/material-components-ios/commit/5cb871e6fae545a6cba33ccf0ba83702316504eb) (Mohammad Cazi)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### BottomSheet

#### Changes

* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### BottomNavigation

#### Changes

* [Remove MaterialMath import (#2941)](https://github.com/material-components/material-components-ios/commit/df1893ce52770843a7228c2b0eede9fc2b43809e) (Robert Moore)
* [[MDCBottomNavigationBar] NSSecureCoding. (#2973)](https://github.com/material-components/material-components-ios/commit/705b76f8a468878a9213d49ee6690386b34a7c2e) (Mohammad Cazi)

### PageControl

#### Changes

* [Fixing Implicit Self inside blocks. (#2954)](https://github.com/material-components/material-components-ios/commit/5cb871e6fae545a6cba33ccf0ba83702316504eb) (Mohammad Cazi)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### Collections

#### Changes

* [Adding comment from .h to also the .m (#2955)](https://github.com/material-components/material-components-ios/commit/ee2647919c7822dba62c4dbe3a47e9ae7b9f6077) (Will Larche)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### HeaderStackView

#### Changes

* [[MDCAppBar]Support NSSecureCoding for App bar. (#2959)](https://github.com/material-components/material-components-ios/commit/b4491c9c9ace370989f87f25a8d2b9f595d52c2c) (Mohammad Cazi)

### FlexibleHeader

#### Changes

* [[MDCAppBar]Support NSSecureCoding for App bar. (#2959)](https://github.com/material-components/material-components-ios/commit/b4491c9c9ace370989f87f25a8d2b9f595d52c2c) (Mohammad Cazi)
* [[Warnings Fix] Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior. (#2933)](https://github.com/material-components/material-components-ios/commit/261828a056690930decce47f5b57e768d3db4a36) (Mohammad Cazi)

### Themes

#### Changes

* [[MDCTonalPalette] Adding NSSecureCoding. #2904 (#2928)](https://github.com/material-components/material-components-ios/commit/dfa7555d15718a805da54583abe07628b9362e90) (Mohammad Cazi)
* [fix local kokoro warnings and errors (#2964)](https://github.com/material-components/material-components-ios/commit/87f9f591921e829c60401b443d2fe48882388e5c) (Yarden Eitan)

---

# 46.0.0

## Breaking changes

### BottomSheets

Remove Material Motion from the BottomSheets component as it was causing crashes on iOS 8.

---

# 45.0.0

## API changes

### Dialogs

#### MDCDialogTransition

*removed* property: `dismissOnBackgroundTap` in `MDCDialogTransition`

*removed* class: `MDCDialogTransition`

### TextFields

#### MDCTextInputUnderlineView

*modified* class: `MDCTextInputUnderlineView`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCTextInputUnderlineView : UIView, NSCopying, NSCoding` |
| To: | `class MDCTextInputUnderlineView : UIView, NSCopying, NSSecureCoding` |

*modified* class: `MDCTextInputUnderlineView`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextInputUnderlineView : UIView <NSCopying, NSCoding>` |
| To: | `@interface MDCTextInputUnderlineView : UIView <NSCopying, NSSecureCoding>` |

#### MDCTextInputController

*modified* protocol: `MDCTextInputController`

| Type of change: | Swift declaration |
|---|---|
| From: | `protocol MDCTextInputController : NSObjectProtocol, NSCoding, NSCopying, MDCTextInputPositioningDelegate` |
| To: | `protocol MDCTextInputController : NSObjectProtocol, NSSecureCoding, NSCopying, MDCTextInputPositioningDelegate` |

*modified* protocol: `MDCTextInputController`

| Type of change: | Declaration |
|---|---|
| From: | `@protocol MDCTextInputController <NSObject, NSCoding, NSCopying,                                   MDCTextInputPositioningDelegate>` |
| To: | `@protocol MDCTextInputController <NSObject, NSSecureCoding, NSCopying,                                   MDCTextInputPositioningDelegate>` |

## Component changes

### BottomNavigation

#### Changes

* [Handle KVO NSNull parameter (#2919)](https://github.com/material-components/material-components-ios/commit/7c8bb7bee66116307f51fc1e5d387af77e63413d) (ianegordon)

### Cards

#### Changes

* [Added proper readme with overview, installation, and usage. (#2907)](https://github.com/material-components/material-components-ios/commit/d384f34c6fedcb27fadbb552541cc175bdea1f37) (Yarden Eitan)
* [fix bug with ink when dragging an MDCCard (#2906)](https://github.com/material-components/material-components-ios/commit/27c960005cbac1e4c204fdde90bce33014358a77) (Yarden Eitan)
* [updates to unit tests and minor fixes (#2898)](https://github.com/material-components/material-components-ios/commit/de988cfe59717f8e1ae300fb77466ddfb80ac5a2) (Yarden Eitan)

### Dialogs

#### Changes

* [Temporarily revert Material Motion (#2921)](https://github.com/material-components/material-components-ios/commit/f88160007ed44f6d2971c7ff5f6869279d2ab8d0) (ianegordon)

### TextFields

#### Changes

* [Converting NSCoding to NSSecureCoding (#2925)](https://github.com/material-components/material-components-ios/commit/30ce9b6a445d41ed91052a69bf3a1519a4f95bc3) (Will Larche)
* [Correcting color themer (#2920)](https://github.com/material-components/material-components-ios/commit/c41bbdb1bc3acd899b9ca8e34512e337fe8fe8ba) (Will Larche)

---

# 44.6.1

## Component changes

### MDCIcons

Added extra guard to prevent crash cause by adding nil to a NSCache.

---

# 44.6.0

## API changes

### Cards

**New component.**

### Ink

#### MDCInkView

*new* method: `-startTouchBeganAtPoint:animated:withCompletion:` in `MDCInkView`

*new* method: `-startTouchEndAtPoint:animated:withCompletion:` in `MDCInkView`

## Component changes

### AnimationTiming

#### Changes

* [Update custom font example to be in the right cell instead of its own. Update the AnimationTiming example to showcase the right names. (#2869)](https://github.com/material-components/material-components-ios/commit/2161a9be86b8937fe95c4400f68ed6cc642024ac) (Cody Weaver)

### BottomSheet

#### Changes

* [Adds missing Jazzy yaml files. (#2871)](https://github.com/material-components/material-components-ios/commit/cc70fe7ca7ed093c5128aa843556a2b2b74dd7d5) (Scott Hyndman)

### Cards

#### Changes

* [Initial Implementation (#2894)](https://github.com/material-components/material-components-ios/commit/58f24b4f183b1366a9b337f7446ad45ceaed2b26) (Yarden Eitan)

### Chips

#### Changes

* [RTL support (#2863)](https://github.com/material-components/material-components-ios/commit/31f908a10d76becaa9b47e923c89bfdf7193d519) (Sam Morrison)
* [Update font style](https://github.com/material-components/material-components-ios/commit/9995b282e1b3b88f70380d276c48de256b90d6f5) (Ian Gordon)

### Dialogs

#### Changes

* [Added Example for issue #2860 to Dragons (#2864)](https://github.com/material-components/material-components-ios/commit/dea8e3c7f4942ac03d5c83350556a5c35e765116) (danblakemore)
* [Rounded corner example (#2881)](https://github.com/material-components/material-components-ios/commit/2a38d427115966960434a606f85e0141fb0a9915) (ianegordon)

### FlexibleHeader

#### Changes

* [Update MDCFlexibleHeaderView.m (#2861)](https://github.com/material-components/material-components-ios/commit/2afa8c57d806da6fcdfdf669ff8943a65fdf1f68) (andrewplai)

### Ink

#### Changes

* [Fix ink animation timing in time-scaled layers (#2884)](https://github.com/material-components/material-components-ios/commit/61445a677a014e94a922faee33cdbebcffa2e607) (Robert Moore)
* [[Cards] Initial Implementation (#2894)](https://github.com/material-components/material-components-ios/commit/58f24b4f183b1366a9b337f7446ad45ceaed2b26) (Yarden Eitan)

### LibraryInfo

#### Changes

* [Adds missing Jazzy yaml files. (#2871)](https://github.com/material-components/material-components-ios/commit/cc70fe7ca7ed093c5128aa843556a2b2b74dd7d5) (Scott Hyndman)

### TextFields

#### Changes

* [Correcting logic mistake (#2885)](https://github.com/material-components/material-components-ios/commit/0d877a048f842436406f2428e76fe2bebae6cf08) (Will Larche)

### Typography

#### Changes

* [Update custom font example to be in the right cell instead of its own. Update the AnimationTiming example to showcase the right names. (#2869)](https://github.com/material-components/material-components-ios/commit/2161a9be86b8937fe95c4400f68ed6cc642024ac) (Cody Weaver)

---

# 44.5.0

## API changes

### ButtonBar

#### MDCButtonBarButton

*new* class: `MDCButtonBarButton`

## Component changes

### ButtonBar

#### Changes

* [Expose font and padding properties (#2849)](https://github.com/material-components/material-components-ios/commit/a8d903460e6d0bb78b06db0a38b882698069c04e) (ianegordon)

### ProgressView

#### Changes

* [Remove MDMMotion (#2854)](https://github.com/material-components/material-components-ios/commit/fd1681b0de136ca4ac21ec34e31a70292c667176) (ianegordon)

### TextFields

#### Changes

* [Correcting documentation (#2844)](https://github.com/material-components/material-components-ios/commit/b7ec2004ab4fd7567422af3c2d2563923ef1e758) (Will Larche)

---

# 44.4.0

## Breaking changes

## New deprecations

## New features

## API changes

### Chips

#### MDCChipView

*new* method: `-inkColorForState:` in `MDCChipView`

*new* method: `-setInkColor:forState:` in `MDCChipView`

*modified* class: `MDCChipView`

*modified* property: `inkColor` in `MDCChipView`

*modified* property: `inkColor` in `MDCChipView`

### Snackbar

#### MDCSnackbarMessageView

*new* property: `buttonFont` in `MDCSnackbarMessageView`

*new* property: `messageFont` in `MDCSnackbarMessageView`
## Component changes

### Chips

#### Changes

* [Stateful ink (#2823)](https://github.com/material-components/material-components-ios/commit/b67f04ed800e5b2f7ed92a77e41598eb28d0c437) (Sam Morrison)

### Snackbar

#### Changes

* [Add customizable fonts  (#2831)](https://github.com/material-components/material-components-ios/commit/29e98b873673a56c4f84f92b8f31e00c88e476b4) (ianegordon)

---

# 44.3.0

## API changes

### Themes

#### MDCFontScheme

*new* property: `button` in `MDCFontScheme`

*new* property: `body2` in `MDCFontScheme`

*new* property: `headline5` in `MDCFontScheme`

*new* property: `caption` in `MDCFontScheme`

*new* property: `subtitle2` in `MDCFontScheme`

*new* property: `subtitle1` in `MDCFontScheme`

*new* property: `body1` in `MDCFontScheme`

*new* property: `headline1` in `MDCFontScheme`

*new* property: `overline` in `MDCFontScheme`

*new* property: `headline2` in `MDCFontScheme`

*new* property: `headline4` in `MDCFontScheme`

*new* protocol: `MDCFontScheme`

*new* property: `headline3` in `MDCFontScheme`

*new* property: `headline6` in `MDCFontScheme`

#### MDCBasicFontScheme

*new* property: `button` in `MDCBasicFontScheme`

*new* property: `headline1` in `MDCBasicFontScheme`

*new* property: `headline5` in `MDCBasicFontScheme`

*new* property: `body1` in `MDCBasicFontScheme`

*new* property: `subtitle2` in `MDCBasicFontScheme`

*new* property: `headline2` in `MDCBasicFontScheme`

*new* property: `body2` in `MDCBasicFontScheme`

*new* property: `overline` in `MDCBasicFontScheme`

*new* property: `headline6` in `MDCBasicFontScheme`

*new* property: `subtitle1` in `MDCBasicFontScheme`

*new* class: `MDCBasicFontScheme`

*new* property: `headline4` in `MDCBasicFontScheme`

*new* property: `headline3` in `MDCBasicFontScheme`

*new* property: `caption` in `MDCBasicFontScheme`

## Component changes

### FeatureHighlight

#### Changes

* [[Typography] Add FontThemer & FontScheme to FeatureHighlight (#2760)](https://github.com/material-components/material-components-ios/commit/5a05ff9f9b9bc80f213416a8a25409faee3e01b1) (ianegordon)

### Themes

#### Changes

* [[Typography] Add FontThemer & FontScheme to FeatureHighlight (#2760)](https://github.com/material-components/material-components-ios/commit/5a05ff9f9b9bc80f213416a8a25409faee3e01b1) (ianegordon)

---

# 44.2.0

## API changes

### Chips

#### MDCChipView

*new* property: `titleFont` in `MDCChipView`

### ActivityIndicator

#### Changes

* [[Podspec] Fix podspec warnings when issuing a lint (#2811)](https://github.com/material-components/material-components-ios/commit/3fe2bff374b5f4c893ae58e1c742943808c9b4c3) (Yarden Eitan)

### BottomNavigation

#### Changes

* [[Podspec] Fix podspec warnings when issuing a lint (#2811)](https://github.com/material-components/material-components-ios/commit/3fe2bff374b5f4c893ae58e1c742943808c9b4c3) (Yarden Eitan)

### ButtonBar

#### Changes

* [[Podspec] Fix podspec warnings when issuing a lint (#2811)](https://github.com/material-components/material-components-ios/commit/3fe2bff374b5f4c893ae58e1c742943808c9b4c3) (Yarden Eitan)

### Chips

#### Changes

* [Add custom font support (#2820)](https://github.com/material-components/material-components-ios/commit/e4b7f2464a589022b5b1c40167c9c25989b88961) (ianegordon)

### CollectionCells

#### Changes

* [[Podspec] Fix podspec warnings when issuing a lint (#2811)](https://github.com/material-components/material-components-ios/commit/3fe2bff374b5f4c893ae58e1c742943808c9b4c3) (Yarden Eitan)

### FlexibleHeader

#### Changes

* [Fix status bar not disappearing for edge case (#2819)](https://github.com/material-components/material-components-ios/commit/79a506b4eac810b2e258ee17fbaa8399ceab7aa8) (Sam Morrison)

### Typography

#### Changes

* [[Podspec] Fix podspec warnings when issuing a lint (#2811)](https://github.com/material-components/material-components-ios/commit/3fe2bff374b5f4c893ae58e1c742943808c9b4c3) (Yarden Eitan)

---

# 44.1.0

## New features

* `MDCSlider` supports more UIAppearance customization.
* `MDCActivityIndicator` provides improved support for animation transitions.

## API changes

### ActivityIndicator

#### MDCActivityIndicatorTransition

*new* property: `duration` in `MDCActivityIndicatorTransition`

*new* method: `-initWithAnimation:` in `MDCActivityIndicatorTransition`

*new* class: `MDCActivityIndicatorTransition`

*new* property: `animation` in `MDCActivityIndicatorTransition`

*new* method: `-init` in `MDCActivityIndicatorTransition`

*new* method: `-initWithCoder:` in `MDCActivityIndicatorTransition`

*new* property: `completion` in `MDCActivityIndicatorTransition`

#### MDCActivityIndicatorAnimation

*new* typedef: `MDCActivityIndicatorAnimation`

#### MDCActivityIndicator

*new* method: `-startAnimatingWithTransition:cycleStartIndex:` in `MDCActivityIndicator`

*new* method: `-stopAnimatingWithTransition:` in `MDCActivityIndicator`

### Slider

#### MDCSlider

*new* property: `thumbRadius` in `MDCSlider`

*new* property: `thumbElevation` in `MDCSlider`

*modified* property: `trackBackgroundColor` in `MDCSlider`

| Type of change: | Declaration |
|---|---|
| From: | `@property(nonatomic, strong, null_resettable) UIColor *trackBackgroundColor` |
| To: | `@property (readwrite, strong, nonatomic, null_resettable)     UIColor *trackBackgroundColor;` |
## Component changes


### ActivityIndicator

#### Changes

* [Add an api to MDCActivityIndicator to allow animations before/after animating (#2766)](https://github.com/material-components/material-components-ios/commit/d30df6c569ba97c4ab7ef897ca2d1e148900ac05) (John Detloff)
* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)
* [[Activity Indicator] Don't call UIAppearance in +initialize (#2810)](https://github.com/material-components/material-components-ios/commit/a63e8610dafa39920db6d27660f5ce8ff40cd86a) (ianegordon)

### AnimationTiming

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### AppBar

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### BottomAppBar

#### Changes

* [remove themer from bottomnavbar (#2814)](https://github.com/material-components/material-components-ios/commit/c29c4c5b5a4f6f32644c3ef58e6ca75cf8074802) (Yarden Eitan)

### BottomNavigation

#### Changes

* [[BottomNav] Reduce default font to `caption` (#2799)](https://github.com/material-components/material-components-ios/commit/d4a4220e62cc05a2247df691aeff1b654af03693) (Robert Moore)

### BottomSheet

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### ButtonBar

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### Chips

#### Changes

* [[Catalog] Remove unwanted warnings from build (#2794)](https://github.com/material-components/material-components-ios/commit/c88a0596400be26c792b71655bcc6364fcb52023) (Yarden Eitan)

### CollectionCells

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### CollectionLayoutAttributes

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### Collections

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)
* [stop weird behavior of swiping to dismiss cells in collection views if 2 fingers are swiping at the same time (#2792)](https://github.com/material-components/material-components-ios/commit/224115d5f1de6da300c0c76cc45b9e92deb18271) (Yarden Eitan)

### Dialogs

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)
* [Explicitly annotate MDCAlertController as not subclassable (#2801)](https://github.com/material-components/material-components-ios/commit/d70ebaa194591c68e9fb7e4d755b93f56aabe703) (ianegordon)

### FeatureHighlight

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### FlexibleHeader

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### HeaderStackView

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### Ink

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### LibraryInfo

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### MaskedTransition

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### NavigationBar

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### OverlayWindow

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### PageControl

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### Palettes

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### ProgressView

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### ShadowElevations

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### ShadowLayer

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### Slider

#### Changes

* [Add appearance properties and enable UIAppearance. (#2796)](https://github.com/material-components/material-components-ios/commit/294643fc0bab62db3e28203fdae0f065dc780e6f) (Adrian Secord)
* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### Snackbar

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### Tabs

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)

### TextFields

#### Changes

* [[Catalog] Remove unwanted warnings from build (#2794)](https://github.com/material-components/material-components-ios/commit/c88a0596400be26c792b71655bcc6364fcb52023) (Yarden Eitan)

### Typography

#### Changes

* [Consolidate installation requirements in the main README (#2809)](https://github.com/material-components/material-components-ios/commit/49de50edae780245c8b964c043cf1268926bc3b3) (ianegordon)
* [Suppress pointer warning in tests (#2805)](https://github.com/material-components/material-components-ios/commit/f4cc724e54c6b40f0bf85f987d84ee1c347d0451) (Robert Moore)

---

# 44.0.0

## Breaking changes

Podspec now separates out extensions (themers, accessibility additions, etc.) into their own podspec.

If you wish to add a component and all of its extensions, update your Podfile and add "+Extensions"
to the component.

To include Activity Indicator and its extensions you would write:
```
pod 'MaterialComponents/ActivityIndicator+Extensions'
```

## Component changes

### ActivityIndicator

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### BottomNavigation

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### BottomSheet

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### ButtonBar

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### Buttons

#### Changes

* [Cleanup (#2759)](https://github.com/material-components/material-components-ios/commit/ab4e4ea0da213c539480b863ce6734cc6fa29a40) (ianegordon)
* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### Collection Cells

#### Changes

* [Fix accessoryPadding encoding key (#2773)](https://github.com/material-components/material-components-ios/commit/873e6874ef6b024123ac3a8ca6a62e35d5dba7f9) (Robert Moore)
* [Use correct title label text property in README.md (#2776)](https://github.com/material-components/material-components-ios/commit/5866de850ca1857acd3a70ff0c6a732069496809) (heinberg)
* [[Ink] Add NSCoding support to MDCInkView/Layer (#2777)](https://github.com/material-components/material-components-ios/commit/85647affe85fca41592855882215df043eaeff74) (Robert Moore)

### Collections

#### Changes

* [[Examples/Tests] Convert @imports to imports (#2761)](https://github.com/material-components/material-components-ios/commit/e03186525d38969d754ffd6005eb80499fd85673) (Robert Moore)

### Dialogs

#### Changes

* [Add designated initializer to MDCAlertController (#2778)](https://github.com/material-components/material-components-ios/commit/ae955a3af028e291462ff8700d8aad0d5f72eebb) (Robert Moore)
* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)
* [[Examples/Tests] Convert @imports to imports (#2761)](https://github.com/material-components/material-components-ios/commit/e03186525d38969d754ffd6005eb80499fd85673) (Robert Moore)

### Feature Highlights

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### FlexibleHeader

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### HeaderStackView

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### Ink

#### Changes

* [Add NSCoding support to MDCInkView/Layer (#2777)](https://github.com/material-components/material-components-ios/commit/85647affe85fca41592855882215df043eaeff74) (Robert Moore)
* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)
* [Update docs to remove optional chaining for MDCInkTouchController instances (#2756)](https://github.com/material-components/material-components-ios/commit/fc790a4a855a4615508719cab971592881bacc56) (Yarden Eitan)

### NavigationBar

#### Changes

* [Example showing custom font (#2720)](https://github.com/material-components/material-components-ios/commit/06813993fb040c528c3a5a37ad9aee708fc671ed) (ianegordon)
* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### PageControl

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### ProgressView

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### Slider

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### Snackbar

#### Changes

* [[Examples/Tests] Convert @imports to imports (#2761)](https://github.com/material-components/material-components-ios/commit/e03186525d38969d754ffd6005eb80499fd85673) (Robert Moore)
* [[SnackBar] Increase unit test timeout (#2750)](https://github.com/material-components/material-components-ios/commit/e297a8f9e84367d91321cb5fb9b40647179f3020) (Robert Moore)

### Tabs

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)
* [Update README.md](https://github.com/material-components/material-components-ios/commit/9987ff35b21cf933103d485e69fd8cec60b19898) (ianegordon)
* [[Examples/Tests] Convert @imports to imports (#2761)](https://github.com/material-components/material-components-ios/commit/e03186525d38969d754ffd6005eb80499fd85673) (Robert Moore)

### TextFields

#### Changes

* [Update MaterialComponents podspec to separate extensions from component. Breaking change, please see description when sending out a new release (#2748)](https://github.com/material-components/material-components-ios/commit/6df22d2cd62e9da6e685890042e3f8748f9f6c19) (Yarden Eitan)

### Themes

#### Changes

* [[Examples/Tests] Convert @imports to imports (#2761)](https://github.com/material-components/material-components-ios/commit/e03186525d38969d754ffd6005eb80499fd85673) (Robert Moore)

### Typography

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Typography

#### Changes

* [[Tests/Catalog] Suppress partial availability warnings (#2780)](https://github.com/material-components/material-components-ios/commit/25de3728070a8681384fb22919689490d3b2f3ab) (Robert Moore)

---

# 43.1.1

## Component changes

### ActivityIndicator

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### AnimationTiming

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### AppBar

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)
* [An example showing a bug when using MDCFlexibleHeaderView inside a UITableViewController (#2744)](https://github.com/material-components/material-components-ios/commit/89be8d3119c6f4907dc02cc6616a5a694da52155) (Yarden Eitan)

### BottomAppBar

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### BottomNavigation

#### Changes

* [Add NSCoding tests (#2740)](https://github.com/material-components/material-components-ios/commit/86002fe84d974489949c667447c8c36d2385780a) (Robert Moore)

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

* [Correct itemTitleFont behavior (#2736)](https://github.com/material-components/material-components-ios/commit/da57f335e85d4723178774be91b7086c8a031522) (Robert Moore)

### BottomSheet

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### ButtonBar

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Buttons

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)
* [Extended FAB leading-align text and no minimum width (#2732)](https://github.com/material-components/material-components-ios/commit/26f02a360ccb4987b00d123561c670bce7691581) (Robert Moore)
* [Fix docs/art for Floating Button layout (#2745)](https://github.com/material-components/material-components-ios/commit/30a1be6d9cd91214ac8a3d0433bbaaf6f8fbd7ab) (Robert Moore)

### Chips

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)
* [Pixel align subviews (#2739)](https://github.com/material-components/material-components-ios/commit/c63eeafda445eb95eb32d03feb6b3103367026b1) (Sam Morrison)

### CollectionCells

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Collections

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Dialogs

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)
* [Fixed retain cycle in MDCDialogTransition that causes MDCAlertController to never be released and presenting view to never be released. (#2684)](https://github.com/material-components/material-components-ios/commit/c7f9946ee3b444c536bab2a051564310c703ba40) (Randall Li)

### FeatureHighlight

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)
* [Fix crash in Dynamic Type handling (#2742)](https://github.com/material-components/material-components-ios/commit/a903493eeeaeeacac14114bf7b7eda198558c833) (ianegordon)

### FlexibleHeader

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### HeaderStackView

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Ink

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### MaskedTransition

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### NavigationBar

#### Changes

* [Add Accessibility method tests (#2721)](https://github.com/material-components/material-components-ios/commit/8ea0d77f72b98ac2255b0f280ff6bb0080c3d553) (Robert Moore)
* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### PageControl

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Palettes

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### ProgressView

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### ShadowElevations

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### ShadowLayer

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Slider

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Snackbar

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Tabs

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### TextFields

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)
* [Formatting. (#2725)](https://github.com/material-components/material-components-ios/commit/09b3c9583d8dff111414badabc99467e2f4207a8) (Will Larche)

### Themes

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

### Typography

#### Changes

* [Added isPresentable to catalog files, ported over ZShadow to dragons. (#2726)](https://github.com/material-components/material-components-ios/commit/29d760c7d6cd8694cc35118ec66575f15201a636) (Yarden Eitan)

---

# 43.1.0

## API changes

### Buttons

#### MDCButton

*new* method: `-setTitleFont:forState:` in `MDCButton`

*new* method: `-titleFontForState:` in `MDCButton`

### FeatureHighlight

#### MDCFeatureHighlightView

*new* property: `bodyFont` in `MDCFeatureHighlightView`

*new* property: `titleFont` in `MDCFeatureHighlightView`

## Component changes

### ActivityIndicator

#### Changes

* [[kokoro] Add :ColorThemer targets (#2712)](https://github.com/material-components/material-components-ios/commit/d2e028f3886596f7fa6b2400418dc6140a2d4174) (Robert Moore)

### AppBar

#### Changes

* [Add BUILD file (#2699)](https://github.com/material-components/material-components-ios/commit/6469c85b04b61eb21a83610f51b2f9aad11a2fb2) (Robert Moore)

### BottomAppBar

#### Changes

* [Add BUILD file and no-op test (#2700)](https://github.com/material-components/material-components-ios/commit/60c4e169c21b3e9594133c6beb69bf089aabeb07) (Robert Moore)

### BottomNavigation

#### Changes

* [Add BUILD file and no-op test (#2703)](https://github.com/material-components/material-components-ios/commit/c478173606fff7ed6e2927abd8577032f18dbfc7) (Robert Moore)

### ButtonBar

#### Changes

* [[NavBar, ButtonBar] Add NavBar tests, fix ButtonBar KVO (#2713)](https://github.com/material-components/material-components-ios/commit/8f1eb74490f3641ff7edf4608fb16698aaebdf93) (Robert Moore)

### Buttons

#### Changes

* [Add a custom font property (#2715)](https://github.com/material-components/material-components-ios/commit/4befe61f74f42a20bb9667a6c3c50975753ad0d7) (ianegordon)

### Chips

#### Changes

* [Add BUILD file and no-op test (#2706)](https://github.com/material-components/material-components-ios/commit/ef3f7d103b78bd00d6fc17f746b079de20a3ef4a) (Robert Moore)
* [Fix sizeToFit sometimes being too small (#2719)](https://github.com/material-components/material-components-ios/commit/3cc1a7a6c542d3153aa74778933beb6bcfaf8875) (Sam Morrison)
* [Use new layer border properties (#2717)](https://github.com/material-components/material-components-ios/commit/723f8c798e322e503004b822f0a9969976c5be66) (Sam Morrison)
* [[Ink] Add updated ink to chips, update ink animation when bounds change (#2545)](https://github.com/material-components/material-components-ios/commit/892f0c09d95ca4e2e6210429b4ad1dbc4413c551) (Junius Gunaratne)
* [[Shapes] Remove MDCShapedShadowLayer fillColor property (#2716)](https://github.com/material-components/material-components-ios/commit/1a68851befc1e1a6838325a628fce6194e9e37db) (Sam Morrison)

### CollectionCells

#### Changes

* [ Add BUILD file (#2693)](https://github.com/material-components/material-components-ios/commit/847d3757f553ff662d9f6fb48472eb099aaa5bdf) (Robert Moore)

### Collections

#### Changes

* [Add BUILD file and add missing import (#2698)](https://github.com/material-components/material-components-ios/commit/0bade5a52e8c16223c68ad7cb48fa59cd6ac5171) (Robert Moore)

### FeatureHighlight

#### Changes

* [Add custom font support (#2701)](https://github.com/material-components/material-components-ios/commit/fcf9712d325e28f9c1683ca61c7f239536130c8e) (ianegordon)

### FlexibleHeader

#### Changes

* [[kokoro] Add :ColorThemer targets (#2712)](https://github.com/material-components/material-components-ios/commit/d2e028f3886596f7fa6b2400418dc6140a2d4174) (Robert Moore)

### HeaderStackView

#### Changes

* [Add BUILD file and no-op test (#2695)](https://github.com/material-components/material-components-ios/commit/1f5918b55ac3e74bac35ed7eb1da2c9b372cc69d) (Robert Moore)

### Ink

#### Changes

* [Add updated ink to chips, update ink animation when bounds change (#2545)](https://github.com/material-components/material-components-ios/commit/892f0c09d95ca4e2e6210429b4ad1dbc4413c551) (Junius Gunaratne)
* [[kokoro] Add :ColorThemer targets (#2712)](https://github.com/material-components/material-components-ios/commit/d2e028f3886596f7fa6b2400418dc6140a2d4174) (Robert Moore)

### LibraryInfo

#### Changes

* [Add BUILD file (#2707)](https://github.com/material-components/material-components-ios/commit/5c24f30a291b296bd3e8f4641bf88253cb08b243) (Robert Moore)

### MaskedTransition

#### Changes

* [Add BUILD file and no-op test (#2708)](https://github.com/material-components/material-components-ios/commit/5746134132216de8583c79024505ac611f2054f1) (Robert Moore)

### NavigationBar

#### Changes

* [[NavBar, ButtonBar] Add NavBar tests, fix ButtonBar KVO (#2713)](https://github.com/material-components/material-components-ios/commit/8f1eb74490f3641ff7edf4608fb16698aaebdf93) (Robert Moore)

### Slider

#### Changes

* [Add BUILD file (#2694)](https://github.com/material-components/material-components-ios/commit/a31a9e10c291501b6cd3e353d06c08b606b1ea67) (Robert Moore)

### Snackbar

#### Changes

* [Add BUILD file (#2697)](https://github.com/material-components/material-components-ios/commit/9481c61954f6668305071ec3ad50af537657958e) (Robert Moore)

### Tabs

#### Changes

* [Re-enable new ink (reverts #2665) (#2682)](https://github.com/material-components/material-components-ios/commit/b0266e9367b95b851699a1aa62e4082bb6d8f157) (featherless)

### TextFields

#### Changes

* [States example (#2718)](https://github.com/material-components/material-components-ios/commit/290f13f7bede9eceaa8159d7af85cd54a703c1c6) (Will Larche)
* [[kokoro] Add :ColorThemer targets (#2712)](https://github.com/material-components/material-components-ios/commit/d2e028f3886596f7fa6b2400418dc6140a2d4174) (Robert Moore)

---

# 43.0.0

This major release includes a variety of API name changes. Please see the API changes below for more details.

## Breaking changes

`MDCTextInputControllerDefault` has been removed. Use `MDCTextInputControllerUnderline` instead.

## API changes

### TextFields

#### MDCTextInputControllerOutlined

*modified* class: `MDCTextInputControllerOutlined`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCTextInputControllerOutlined : MDCTextInputControllerDefault` |
| To: | `class MDCTextInputControllerOutlined : MDCTextInputControllerBase` |

*modified* class: `MDCTextInputControllerOutlined`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextInputControllerOutlined : MDCTextInputControllerDefault` |
| To: | `@interface MDCTextInputControllerOutlined : MDCTextInputControllerBase` |

#### MDCTextInputControllerOutlinedTextArea

*modified* class: `MDCTextInputControllerOutlinedTextArea`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCTextInputControllerOutlinedTextArea : MDCTextInputControllerDefault` |
| To: | `class MDCTextInputControllerOutlinedTextArea : MDCTextInputControllerBase` |

*modified* class: `MDCTextInputControllerOutlinedTextArea`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextInputControllerOutlinedTextArea     : MDCTextInputControllerDefault` |
| To: | `@interface MDCTextInputControllerOutlinedTextArea : MDCTextInputControllerBase` |

#### MDCTextInputControllerBase

*new* property: `expandsOnOverflow` in `MDCTextInputControllerBase`

*new* property: `borderFillColorDefault` in `MDCTextInputControllerBase`

*new* property: `borderFillColor` in `MDCTextInputControllerBase`

*new* property: `minimumLines` in `MDCTextInputControllerBase`

*new* class: `MDCTextInputControllerBase`

#### MDCTextInputControllerDefault

*removed* property: `expandsOnOverflow` in `MDCTextInputControllerDefault`

*removed* property: `borderFillColor` in `MDCTextInputControllerDefault`

*removed* class: `MDCTextInputControllerDefault`

*removed* property: `borderFillColorDefault` in `MDCTextInputControllerDefault`

*removed* property: `minimumLines` in `MDCTextInputControllerDefault`

#### MDCTextInputDefaultUnderlineActiveHeight

*removed* constant: `MDCTextInputDefaultUnderlineActiveHeight`

#### MDCTextInputControllerFilled

*modified* class: `MDCTextInputControllerFilled`

| Type of change: | Swift declaration |
|---|---|
| From: | `class MDCTextInputControllerFilled : MDCTextInputControllerDefault` |
| To: | `class MDCTextInputControllerFilled : MDCTextInputControllerBase` |

*modified* class: `MDCTextInputControllerFilled`

| Type of change: | Declaration |
|---|---|
| From: | `@interface MDCTextInputControllerFilled : MDCTextInputControllerDefault` |
| To: | `@interface MDCTextInputControllerFilled : MDCTextInputControllerBase` |

#### MDCTextInputDefaultBorderRadius

*removed* constant: `MDCTextInputDefaultBorderRadius`

#### MDCTextInputControllerUnderline

*new* class: `MDCTextInputControllerUnderline`

#### MDCTextInputControllerBaseDefaultBorderRadius

*new* constant: `MDCTextInputControllerBaseDefaultBorderRadius`

#### MDCTextInputController

*new* property: `underlineHeightActiveDefault` in `MDCTextInputController`

*new* property: `underlineHeightActive` in `MDCTextInputController`

*new* property: `underlineHeightNormalDefault` in `MDCTextInputController`

*new* property: `underlineHeightNormal` in `MDCTextInputController`

## Component changes

### TextFields

#### Changes

* [Feature branch merge: Clarity, Safety, Docs, Comments, Formatting (#2634)](https://github.com/material-components/material-components-ios/commit/62d5a4fa850b943e32099fa921bb30082f539c0f) (Will Larche)

### Themes

#### Changes

* [[TextFields] Feature branch merge: Clarity, Safety, Docs, Comments, Formatting (#2634)](https://github.com/material-components/material-components-ios/commit/62d5a4fa850b943e32099fa921bb30082f539c0f) (Will Larche)

---

# 42.2.0

## API changes

### Typography

#### UIFont(MaterialTypography)

*new* method: `-mdc_fontSizedForMaterialTextStyle:scaledForDynamicType:` in `UIFont(MaterialTypography)`

## Component changes

### ButtonBar

#### Changes

* [[ButtonBar, NavigationBar] Add BUILD file for kokoro (#2598)](https://github.com/material-components/material-components-ios/commit/5879c18c26c3b8f69ed7a77ecdf8fcd2e220d427) (Robert Moore)

### NavigationBar

#### Changes

* [[ButtonBar, NavigationBar] Add BUILD file for kokoro (#2598)](https://github.com/material-components/material-components-ios/commit/5879c18c26c3b8f69ed7a77ecdf8fcd2e220d427) (Robert Moore)

### TextFields

#### Changes

* [Corrected imports in examples. (#2655)](https://github.com/material-components/material-components-ios/commit/63abcadd7c62b3c36361cd0108928b8ecf1eb801) (Randall Li)

### Typography

#### Changes

* [font initializer based on style and Dynamic Type (#2666)](https://github.com/material-components/material-components-ios/commit/93e21f1483f3568729cac0fe010e912274945702) (ianegordon)

---

# 42.1.0

## New features

New MDCChipField API in the Chips component provides an interface through which a user can input a collection of string tokens.

## API changes

### Chips

#### MDCChipFieldDefaultContentEdgeInsets

*new* constant: `MDCChipFieldDefaultContentEdgeInsets`

#### MDCChipFieldDelimiter

*new* enum value: `MDCChipFieldDelimiterReturn` in `MDCChipFieldDelimiter`

*new* enum: `MDCChipFieldDelimiter`

*new* enum value: `MDCChipFieldDelimiterAll` in `MDCChipFieldDelimiter`

*new* enum value: `MDCChipFieldDelimiterNone` in `MDCChipFieldDelimiter`

*new* typedef: `MDCChipFieldDelimiter`

*new* enum value: `MDCChipFieldDelimiterDefault` in `MDCChipFieldDelimiter`

*new* enum value: `MDCChipFieldDelimiterSpace` in `MDCChipFieldDelimiter`

*new* enum value: `MDCChipFieldDelimiterDidEndEditing` in `MDCChipFieldDelimiter`

#### MDCChipField

*new* class: `MDCChipField`

*new* method: `-focusTextFieldForAccessibility` in `MDCChipField`

*new* method: `-removeSelectedChips` in `MDCChipField`

*new* method: `-removeChip:` in `MDCChipField`

*new* property: `contentEdgeInsets` in `MDCChipField`

*new* method: `-addChip:` in `MDCChipField`

*new* property: `showPlaceholderWithChips` in `MDCChipField`

*new* property: `textField` in `MDCChipField`

*new* property: `minTextFieldWidth` in `MDCChipField`

*new* property: `chipHeight` in `MDCChipField`

*new* method: `-deselectAllChips` in `MDCChipField`

*new* property: `delegate` in `MDCChipField`

*new* method: `-selectChip:` in `MDCChipField`

*new* property: `chips` in `MDCChipField`

*new* method: `-clearTextInput` in `MDCChipField`

*new* property: `delimiter` in `MDCChipField`

#### MDCChipFieldDelegate

*new* method: `-chipField:didChangeInput:` in `MDCChipFieldDelegate`

*new* protocol: `MDCChipFieldDelegate`

*new* method: `-chipFieldHeightDidChange:` in `MDCChipFieldDelegate`

*new* method: `-chipFieldDidBeginEditing:` in `MDCChipFieldDelegate`

*new* method: `-chipField:didRemoveChip:` in `MDCChipFieldDelegate`

*new* method: `-chipField:didTapChip:` in `MDCChipFieldDelegate`

*new* method: `-chipField:shouldAddChip:` in `MDCChipFieldDelegate`

*new* method: `-chipFieldShouldBecomeFirstResponder:` in `MDCChipFieldDelegate`

*new* method: `-chipField:didAddChip:` in `MDCChipFieldDelegate`

*new* method: `-chipFieldShouldReturn:` in `MDCChipFieldDelegate`

*new* method: `-chipFieldDidEndEditing:` in `MDCChipFieldDelegate`

#### MDCChipView

*new* property: `shapeGenerator` in `MDCChipView`

*new* method: `-shadowColorForState:` in `MDCChipView`

*new* method: `-setShadowColor:forState:` in `MDCChipView`

#### MDCChipFieldDefaultMinTextFieldWidth

*new* constant: `MDCChipFieldDefaultMinTextFieldWidth`

### FeatureHighlight

#### MDCFeatureHighlightView

*new* property: `mdc_adjustsFontForContentSizeCategory` in `MDCFeatureHighlightView`

### ShadowLayer

#### MDCShadowLayer(Subclassing)

*new* category: `MDCShadowLayer(Subclassing)`

### Typography

#### UIFontDescriptor(MaterialTypography)

*new* class method: `+mdc_standardFontDescriptorForMaterialTextStyle:` in `UIFontDescriptor(MaterialTypography)`

#### UIFont(MaterialTypography)

*new* class method: `+mdc_standardFontForMaterialTextStyle:` in `UIFont(MaterialTypography)`

## Component changes

### AnimationTiming

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [[Bazel] Fix BUILD files for bazel 0.8.0 and latest apple_rules (#2640)](https://github.com/material-components/material-components-ios/commit/7c86d12f5f71689d83d41585833355242bd03fc3) (Robert Moore)

### AppBar

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### BottomAppBar

#### Changes

* [Corrected imports in examples. (#2656)](https://github.com/material-components/material-components-ios/commit/c3f9fbd4299e2ff0ce77dacd29197a1ff705b686) (Randall Li)

### BottomNavigation

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### BottomSheet

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### ButtonBar

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### Buttons

#### Changes

* [ Corrected imports in examples. (#2645)](https://github.com/material-components/material-components-ios/commit/00611df7bdc5fac4732708c5d9cc4dcef113beec) (Randall Li)
* [Add unit tests for Floating Button layout (#2577)](https://github.com/material-components/material-components-ios/commit/58f9854760cadd0c2401d040b24afe4eb0b4b0d0) (Robert Moore)
* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [Improve FloatingButton documentation (#2578)](https://github.com/material-components/material-components-ios/commit/c360db7e94d6f43a351ee18c8f568906b4d0d4cb) (Robert Moore)
* [Re-enable legacy ink. (#2657)](https://github.com/material-components/material-components-ios/commit/aae4264e412a8db537bfe43d39cf3c3abd48436e) (featherless)
* [Rename `MDCFloatingButton updateShapeForcingLayout` (#2625)](https://github.com/material-components/material-components-ios/commit/6469bad9dca832923b339e7eaad4a65ac610fb94) (Robert Moore)
* [Revert "Re-enable legacy ink. (#2657)" (#2664)](https://github.com/material-components/material-components-ios/commit/1631d8e45d14ad334406cf6b6fa1b40ee4fd7dfb) (featherless)

### Chips

#### Changes

* [Call [super layoutSubviews] (#2667)](https://github.com/material-components/material-components-ios/commit/25afc0f8ac3b0db3cf43472579f985b967c05b5e) (Sam Morrison)
* [Chip field (#2600)](https://github.com/material-components/material-components-ios/commit/5384f00f9a36c6e13f63dd1782a21723d86391d8) (Sam Morrison)
* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [Stateful shadow colors (#2668)](https://github.com/material-components/material-components-ios/commit/c5d47f8cf321073e3601180995bdd4594ecd02cd) (Sam Morrison)
* [Use shaped shadow layer (#2628)](https://github.com/material-components/material-components-ios/commit/183e289a87c1cbbf4aaaa31778c1e363fc739316) (Sam Morrison)

### CollectionLayoutAttributes

#### Changes

* [Add BUILD file (#2646)](https://github.com/material-components/material-components-ios/commit/35206bbdff1800dc3c35e2f22fc8ed0f3da9c3ec) (Robert Moore)

### Collections

#### Changes

* [Fix iOS 11-specific bug where section headers would overlap scroll indicators. (#2572)](https://github.com/material-components/material-components-ios/commit/fb7109442a9d1cde8a09cec9e51fbdcf8c5933e9) (featherless)
* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [Fixed method collision build errors (#2603)](https://github.com/material-components/material-components-ios/commit/ef179750a003b15e43d2d92f19a61f6a67721f69) (Randall Li)

### Dialogs

#### Changes

* [Add BUILD file and test (#2647)](https://github.com/material-components/material-components-ios/commit/a0915f51835a92d3e7d322bfb9b6eb53cf129f3e) (Robert Moore)
* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### FeatureHighlight

#### Changes

* [Add BUILD file and no-op test (#2648)](https://github.com/material-components/material-components-ios/commit/89b098e308f501751e1dd79081d442c7d3e2b7d2) (Robert Moore)
* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [Move Dynamic Type support to the FeatureHighlightView (#2653)](https://github.com/material-components/material-components-ios/commit/872380d0e934ab942a7f4a177678d5ac0e5ffab2) (ianegordon)

### FlexibleHeader

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### HeaderStackView

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### Ink

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [[Bazel] Fix BUILD files for bazel 0.8.0 and latest apple_rules (#2640)](https://github.com/material-components/material-components-ios/commit/7c86d12f5f71689d83d41585833355242bd03fc3) (Robert Moore)

### NavigationBar

#### Changes

* [Fix navbar placement in catalog for iPhoneX (#2581)](https://github.com/material-components/material-components-ios/commit/d429911bd8f428c720f9de790e54ac7a3e73dab7) (Yarden Eitan)
* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [[CocoaPods] Added warnings to examples. (#2480)](https://github.com/material-components/material-components-ios/commit/d28366d523f39d116a7d856191d91607d3ad8fcb) (Randall Li)

### OverlayWindow

#### Changes

* [Add BUILD file and no-op test (#2649)](https://github.com/material-components/material-components-ios/commit/9d74268cab97c3b4937f500277ca9c7f9e910ddb) (Robert Moore)

### PageControl

#### Changes

* [Add BUILD file (#2652)](https://github.com/material-components/material-components-ios/commit/d65707ad23fc7d1e216cd0f6011cb9f1b3ba93f3) (Robert Moore)
* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### ProgressView

#### Changes

* [Add BUILD file (#2671)](https://github.com/material-components/material-components-ios/commit/5a592ed71b00f72211e6cf8d1d306bed876691de) (Robert Moore)

### ShadowLayer

#### Changes

* [[Bazel] Fix BUILD files for bazel 0.8.0 and latest apple_rules (#2640)](https://github.com/material-components/material-components-ios/commit/7c86d12f5f71689d83d41585833355242bd03fc3) (Robert Moore)
* [[Shapes] Implicitly animate shape path on resizing (#2619)](https://github.com/material-components/material-components-ios/commit/9b097023fb43cfac5e8106c1fab56fe2b05c5ab7) (Sam Morrison)

### Snackbar

#### Changes

* [[EarlGrey] Fixing Snackbar test for iPhone 4S (#2622)](https://github.com/material-components/material-components-ios/commit/acf0eae26eda238c858b80a2512613c527732e9e) (Robert Moore)

### Tabs

#### Changes

* [Add BUILD file (#2676)](https://github.com/material-components/material-components-ios/commit/44704084dd8ae8d34f6e402a7f757a5b70446e3b) (Robert Moore)
* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [Revert "Enable new ink (#2616)" (#2665)](https://github.com/material-components/material-components-ios/commit/83994481a936a47d4bec4381fa34f711c47ba486) (featherless)

### TextFields

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)

### Themes

#### Changes

* [Fixed float conversion build errors (#2602)](https://github.com/material-components/material-components-ios/commit/b1ec22207f9364660d6f5583b8ab5c4b247d1311) (Randall Li)
* [Init temp variable to avoid warning / error. (#2609)](https://github.com/material-components/material-components-ios/commit/a4e0b6cbecd1a661ddc45b6df678bc0fd135be1c) (ianegordon)

### Typography

#### Changes

* [Add standard (non-Dynamic Type) font convenience method (#2629)](https://github.com/material-components/material-components-ios/commit/4da22ef2a728ed4be3db33788d36b39c23fc2736) (ianegordon)

---

# 42.0.0

## Breaking changes

`MDCFloatingButtonShapeLargeIcon` has been removed.

```
// Old code
MDCFloatingButton *button =
    [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeLargeIcon];

// New code
MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
```

## New deprecations

BottomSheet has a variety of new deprecations.

## New features

MDCFloatingButton has a new mode property and can now be expanded.

MDCInkView has a new delegate-based API for responding to animation events.

It's now possible to customize fonts on Tabs.

## API changes

### ActivityIndicator

#### MDCActivityIndicatorDelegate

*new* method: `-activityIndicatorModeTransitionDidFinish:` in `MDCActivityIndicatorDelegate`

### BottomSheet

#### UIViewController(MaterialBottomSheet)

*deprecated* property: `mdc_bottomSheetPresentationController` in `UIViewController(MaterialBottomSheet)`. Assign an instance of MDCBottomSheetTransition to your view controller's mdm_transitionController.transition instead.

#### MDCBottomSheetTransitionController

*deprecated* class: `MDCBottomSheetTransitionController`. Assign an instance of MDCBottomSheetTransition to your view controller's mdm_transitionController.transition instead.

#### MDCBottomSheetPresentationControllerDelegate

*deprecated* protocol: `MDCBottomSheetPresentationControllerDelegate`. This API will soon be made private. Use MDCBottomSheetController instead.

#### MDCBottomSheetPresentationController

*deprecated* class: `MDCBottomSheetPresentationController`. This API will soon be made private. Use MDCBottomSheetController instead.

### Buttons

#### MDCFloatingButton

*new* method: `-setMaximumSize:` in `MDCFloatingButton`

*new* property: `imageTitleSpace` in `MDCFloatingButton`

*new* method: `-setContentEdgeInsets:` in `MDCFloatingButton`

*new* method: `-setMinimumSize:` in `MDCFloatingButton`

*new* property: `imageLocation` in `MDCFloatingButton`

*new* method: `-setMinimumSize:forShape:inMode:` in `MDCFloatingButton`

*new* property: `mode` in `MDCFloatingButton`

*new* method: `-setHitAreaInsets:forShape:inMode:` in `MDCFloatingButton`

*new* method: `-setContentEdgeInsets:forShape:inMode:` in `MDCFloatingButton`

*new* method: `-setHitAreaInsets:` in `MDCFloatingButton`

*new* method: `-setMaximumSize:forShape:inMode:` in `MDCFloatingButton`

#### MDCFloatingButtonMode

*new* enum value: `MDCFloatingButtonModeExpanded` in `MDCFloatingButtonMode`

*new* enum value: `MDCFloatingButtonModeNormal` in `MDCFloatingButtonMode`

*new* enum: `MDCFloatingButtonMode`

#### MDCFloatingButtonShape

*removed* enum value: `MDCFloatingButtonShapeLargeIcon` in `MDCFloatingButtonShape`

#### MDCFloatingButtonImageLocation

*new* enum value: `MDCFloatingButtonImageLocationLeading` in `MDCFloatingButtonImageLocation`

*new* typedef: `MDCFloatingButtonImageLocation`

*new* enum: `MDCFloatingButtonImageLocation`

*new* enum value: `MDCFloatingButtonImageLocationTrailing` in `MDCFloatingButtonImageLocation`

### Ink

#### MDCInkView

*new* property: `animationDelegate` in `MDCInkView`

#### MDCInkViewDelegate

*new* method: `-inkAnimationDidStart:` in `MDCInkViewDelegate`

*new* method: `-inkAnimationDidEnd:` in `MDCInkViewDelegate`

*new* protocol: `MDCInkViewDelegate`

### Tabs

#### MDCTabBar

*new* property: `selectedItemTitleFont` in `MDCTabBar`

*new* property: `titleTextTransform` in `MDCTabBar`

*new* property: `unselectedItemTitleFont` in `MDCTabBar`

#### MDCTabBarTextTransform

*new* enum: `MDCTabBarTextTransform`

*new* enum value: `MDCTabBarTextTransformAutomatic` in `MDCTabBarTextTransform`

*new* typedef: `MDCTabBarTextTransform`

*new* enum value: `MDCTabBarTextTransformUppercase` in `MDCTabBarTextTransform`

*new* enum value: `MDCTabBarTextTransformNone` in `MDCTabBarTextTransform`

## Component changes

### ActivityIndicator

#### Changes

* [Add a delegate callback for the activity indicator mode animation (#2537)](https://github.com/material-components/material-components-ios/commit/beac4fa1502646227a1ce5bf660fc1542e023af8) (John Detloff)
* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### AppBar

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[AppBar:ColorThemer] Add nullability annotations (#2536)](https://github.com/material-components/material-components-ios/commit/d0026701b4a2f7f6c1a2a1da43fbb285e6ed7483) (Brian Moore)

### BottomAppBar

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)

### BottomNavigation

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Ensure item top and bottom content insets are identical (#2579)](https://github.com/material-components/material-components-ios/commit/4bae4dc17880de31c7580fe001c92d487634770c) (Junius Gunaratne)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Ink] Use updated ink for bottom navigation (#2567)](https://github.com/material-components/material-components-ios/commit/17cea995c708622602ad3f39aae42d464f2999c6) (Junius Gunaratne)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### BottomSheet

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Deprecate to-be-removed APIs. (#2539)](https://github.com/material-components/material-components-ios/commit/411eaec1904d51835f548286100095286e6a99d2) (featherless)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)

### ButtonBar

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Cleanup] remove checks for iOS8 and above as we now only support iOS8+ (#2555)](https://github.com/material-components/material-components-ios/commit/f9e187feb4096c5388a3495d1ac7123a9447840f) (Yarden Eitan)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### Buttons

#### Changes

* [Add BUILD file for kokoro (#2599)](https://github.com/material-components/material-components-ios/commit/0b91616d9aaeb3844770dabd7b82b6c9e81471e7) (Robert Moore)
* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Extended FAB (#2563)](https://github.com/material-components/material-components-ios/commit/2d8333d7d83dabafe64bdb6dfa96031f99d89f57) (Robert Moore)
* [Readability for newlines (#2568)](https://github.com/material-components/material-components-ios/commit/f01c39d050b23b30555c1e963ff258313641b6a5) (Robert Moore)
* [Rename `imageTitleSpace` (#2565)](https://github.com/material-components/material-components-ios/commit/c35ddaa8733e4825f2a5db404c257f4dcdedec35) (Robert Moore)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Ink] Enable updated ink on MDCButton, add support for shadowPaths (#2530)](https://github.com/material-components/material-components-ios/commit/c9d1b7163db9f09c62f2acc596e54897a8b1282b) (Junius Gunaratne)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### CollectionCells

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Ink] Enable updated ink for collection views (#2546)](https://github.com/material-components/material-components-ios/commit/10047dfbc9536c2f9dbb16c4a5870280a8bb7173) (Junius Gunaratne)

### Dialogs

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Call actionHandlers after the alert has been dismissed (#2490)](https://github.com/material-components/material-components-ios/commit/fa22f6d39e3797486f7049b3bb8898e3b7f1ef81) (ianegordon)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Cleanup] remove checks for iOS8 and above as we now only support iOS8+ (#2555)](https://github.com/material-components/material-components-ios/commit/f9e187feb4096c5388a3495d1ac7123a9447840f) (Yarden Eitan)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### FeatureHighlight

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### FlexibleHeader

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Cleanup] remove checks for iOS8 and above as we now only support iOS8+ (#2555)](https://github.com/material-components/material-components-ios/commit/f9e187feb4096c5388a3495d1ac7123a9447840f) (Yarden Eitan)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### HeaderStackView

#### Changes

* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### Ink

#### Changes

* [Add MDCInkViewDelegate (#2558)](https://github.com/material-components/material-components-ios/commit/c3695264cf55009f078fcb8503dcc846dea87371) (Junius Gunaratne)
* [Change ink fade out timing (#2576)](https://github.com/material-components/material-components-ios/commit/3078879b422535f68edf93ef42d48d7607d8b74b) (Junius Gunaratne)
* [Enable updated ink on MDCButton, add support for shadowPaths (#2530)](https://github.com/material-components/material-components-ios/commit/c9d1b7163db9f09c62f2acc596e54897a8b1282b) (Junius Gunaratne)
* [Prevent ink layers from collecting. Copy sublayers before calling removeFromSuperlayer (#2596)](https://github.com/material-components/material-components-ios/commit/1c99b810ecfc0a373413ab02ec38ab002bff82ec) (Junius Gunaratne)
* [Use updated ink for bottom navigation (#2567)](https://github.com/material-components/material-components-ios/commit/17cea995c708622602ad3f39aae42d464f2999c6) (Junius Gunaratne)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### LibraryInfo

#### Changes

* [Fix version numbers for statically-compiled components. (#2544)](https://github.com/material-components/material-components-ios/commit/6da7d0af51044faec13fec2800cb1c33ec8b74b4) (Adrian Secord)

### MaskedTransition

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)

### NavigationBar

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### PageControl

#### Changes

* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### ProgressView

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Execute the same logical paths for completion and animation. (#2564)](https://github.com/material-components/material-components-ios/commit/9efe297a4c613cc77678edd2397b2a538ad42dab) (featherless)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### ShadowLayer

#### Changes

* [Animate shadow resizing (#2523)](https://github.com/material-components/material-components-ios/commit/7e2d44522e43852499ebd2c803de464dd56066e3) (Sam Morrison)

### Snackbar

#### Changes

* [Using block typdef to silence warning as error. (#2573)](https://github.com/material-components/material-components-ios/commit/d555a8d7aaeff4ac1c88098f9771b82f2fa8a23a) (Randall Li)

### Tabs

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Allow customization of fonts and text transform (#2547)](https://github.com/material-components/material-components-ios/commit/8463e9b46baa133b40ddde502f9dced9ff1afd8c) (Brian Moore)
* [Enable new ink (#2616)](https://github.com/material-components/material-components-ios/commit/64425cd469716c717e074ebb990efe931b4bf873) (Junius Gunaratne)
* [Replace mdc_animateWithTimingFunction with standard UIKit/QuartzCore APIs. (#2548)](https://github.com/material-components/material-components-ios/commit/cfde77c40061d1c0a8dc0f66cf7e91282e427dcb) (featherless)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Cleanup] remove checks for iOS8 and above as we now only support iOS8+ (#2555)](https://github.com/material-components/material-components-ios/commit/f9e187feb4096c5388a3495d1ac7123a9447840f) (Yarden Eitan)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### TextFields

#### Changes

* [Add compile time flag for import style (#2562)](https://github.com/material-components/material-components-ios/commit/6791dc4993d3a0ffa11735eeeef0583102621d52) (Louis Romero)
* [Removing extra calls in setupClearButton. (#2541)](https://github.com/material-components/material-components-ios/commit/2b8200185bb70c113933c2e04905e796efaec360) (Will Larche)
* [Revert "Add compile time flag for import style (#2562)" (#2612)](https://github.com/material-components/material-components-ios/commit/b9404ded10fe549f211c01ecfdd1ee3c15fdf9fe) (featherless)
* [[Cleanup] remove checks for iOS8 and above as we now only support iOS8+ (#2555)](https://github.com/material-components/material-components-ios/commit/f9e187feb4096c5388a3495d1ac7123a9447840f) (Yarden Eitan)
* [[Themers] Add nullability to themers (#2551)](https://github.com/material-components/material-components-ios/commit/7dc94709434595060c8534f5126c2bdaecc4afca) (Junius Gunaratne)

### Themes

#### Changes

* [Add BUILD file for kokoro (#2601)](https://github.com/material-components/material-components-ios/commit/a33df5ad4ba8de35c638f8b1fca857d8b8019b30) (Robert Moore)

---

# 41.0.0

## API changes

### Dialogs

**new** class: `MDCDialogTransition`.

### Ink

**breaking** **changed** property signature: `MDCInkView`'s `inkColor` from `null_resettable` to `nonnull`.

**new** property: `usesLegacyInkRipple`.

### Snackbar

**breaking** `MDCSnackbarMessage`'s public APIs have all been annotated with nullability annotations.

### TextFields

**new** class: `MDCIntrinsicHeightTextView`.

**changed** property signature: `MDCMultilineTextField`'s textView changed from `UITextView` to `MDCIntrinsicHeightTextView`.

## Component changes

### BottomAppBar

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)

### Buttons

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)

### Dialogs

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)
* [Migrate to Material Motion. (#2481)](https://github.com/material-components/material-components-ios/commit/211ca772ea0456b56e522c0c67bd44312ddfe4d1) (featherless)

### FeatureHighlight

#### Changes

* [Minor fix of comment block notation. (#2503)](https://github.com/material-components/material-components-ios/commit/52f0c766b00d9020a2f249a99c2cbfbe0ec29880) (featherless)

### FlexibleHeader

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)

### Ink

#### Changes

* [Retrofit new ink layer with updated animation into existing ink API (#2488)](https://github.com/material-components/material-components-ios/commit/a27d49408a10282e4340436e13dc1ecbe57612d2) (Junius Gunaratne)

### MaskedTransition

#### Changes

* [Bump the transitioning dependency to v5.0.0 (#2525)](https://github.com/material-components/material-components-ios/commit/38323773823742d130fd66bb076fc406d6da8678) (featherless)

### PageControl

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)

### ProgressView

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)

### ShadowElevations

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)
* [[Shadow*] Add BUILD files for shadow components. (#2510)](https://github.com/material-components/material-components-ios/commit/d24789f484d50ff8437b9b1fdcb4c6ae0577fcff) (featherless)

### ShadowLayer

#### Changes

* [Add support for implicitly animating the shadow layer's elevation using MotionAnimator. (#2509)](https://github.com/material-components/material-components-ios/commit/e38ac60ffd4b9f377249986180ee650c020f7cb4) (featherless)
* [[Shadow*] Add BUILD files for shadow components. (#2510)](https://github.com/material-components/material-components-ios/commit/d24789f484d50ff8437b9b1fdcb4c6ae0577fcff) (featherless)

### Slider

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)

### Snackbar

#### Changes

* [Add nullability annotations to types defined in MDCSnackbarMessage.h (#2445)](https://github.com/material-components/material-components-ios/commit/e8e3c8cd8087a5aadf5ca001ade4d6516a025403) (Benjamin Deming)

### Tabs

#### Changes

* [Add missing import (#2534)](https://github.com/material-components/material-components-ios/commit/b6c054383ade56653bf91835b72361b0e2d49b8f) (featherless)
* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)

### TextFields

#### Changes

* [Adding legacy storyboard. (#2517)](https://github.com/material-components/material-components-ios/commit/47ed556783e804fccfb0e6c53a80d1fa91847b68) (Will Larche)
* [Correcting class of the textview to match the new class required for MDCMultilineTextField. (#2519)](https://github.com/material-components/material-components-ios/commit/0496c225496d2c52cc131835e245de1da8dfd2b4) (Will Larche)
* [Fixes bug: multiline having ambiguous height in the text view (#2489)](https://github.com/material-components/material-components-ios/commit/35727c12495a18357c483b5d1ddacf978d315854) (Will Larche)
* [TrailingView tests. (#2516)](https://github.com/material-components/material-components-ios/commit/7937f1b5c966bbe839d90629d6081e3e6ca39255) (Will Larche)
* [Updating encoding and copying. (#2515)](https://github.com/material-components/material-components-ios/commit/6f48a43b53d7ad0101c05ea57dd07b3107ea020f) (Will Larche)

### Typography

#### Changes

* [Fixed some compiler warnings (#2426)](https://github.com/material-components/material-components-ios/commit/2f29f00d8665ee177e8ad09fc0d7c2a4547ff6f2) (Randall Li)

# 40.1.1

## Component changes

### Tabs

#### Changes

* [Add missing import (#2534)](https://github.com/material-components/material-components-ios/commit/8f56a94eb34370a442856f565b0ee44fe4832f32) (featherless)

# 40.1.0

## API Changes

### AnimationTiming

* New enums: `MDCAnimationTimingFunctionStandard`, `MDCAnimationTimingFunctionDeceleration`, and `MDCAnimationTimingFunctionAcceleration`.

### BottomSheet

* New class: `MDCBottomSheetTransition`.

### Tabs

* New property: `-selectionIndicatorTemplate`.

* New class: `MDCTabBarIndicatorAttributes`.

* New protocol: `MDCTabBarIndicatorContext`.

* New Protocol: `MDCTabBarIndicatorTemplate`.

* New class: `MDCTabBarUnderlineIndicatorTemplate`.

### Themes

* New conformity: `MDCColorScheme` now conforms to `NSObject`.

## Component changes

### ActivityIndicator

#### Changes

* [Convert motion spec to an Objective-C static class. (#2451)](https://github.com/material-components/material-components-ios/commit/68356bbd908417606edefa083866a1a1bd2f2716) (featherless)
* [Make the motion spec values be class properties. (#2473)](https://github.com/material-components/material-components-ios/commit/2a3b2d12200f475e4dbbf4011b207f8079d04e2a) (featherless)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[Kokoro] Support for TextFields, Math, and Typography (#2432)](https://github.com/material-components/material-components-ios/commit/1bd5590bbb19a28f1869733588535429b4642015) (Will Larche)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### AnimationTiming

#### Changes

* [Rename animation timing curves to match spec. (#2370)](https://github.com/material-components/material-components-ios/commit/93f7d880baf66ece00dbe02c120307785c041aaa) (Cody Weaver)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Update animation timing README and examples (#2444)](https://github.com/material-components/material-components-ios/commit/6049093d2aa2d80a22e0cf586621ebc8b69325ef) (Cody Weaver)

### AppBar

#### Changes

* [Automated header standardization by the kokoro script. (#2472)](https://github.com/material-components/material-components-ios/commit/d1b31cab6acaf665e968a59524372e6f24f4520c) (featherless)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### BottomAppBar

#### Changes

* [Implement viewSafeAreaInsetsDidChange (#2466)](https://github.com/material-components/material-components-ios/commit/fbbab80570a1385f697f9476b4bca07f7bd43a8b) (Junius Gunaratne)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)

### BottomNavigation

#### Changes

* [Adding app bar navigation to demo (#2430)](https://github.com/material-components/material-components-ios/commit/a7e0a0163681d6a52c6681e47e4dc9d09d57a6f9) (Junius Gunaratne)
* [Implement viewSafeAreaInsetsDidChange (#2465)](https://github.com/material-components/material-components-ios/commit/36cf023a96a674e6e6c7faaf5d3997a31781bb39) (Junius Gunaratne)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### BottomSheet

#### Changes

* [Convert to Material Motion. (#2400)](https://github.com/material-components/material-components-ios/commit/c9ef0366c1525be0f5c384cf90703ab73dbcf3e3) (featherless)
* [Fix build breakage due to floating point conversions. (#2449)](https://github.com/material-components/material-components-ios/commit/abc6ab9f91141e4884830d0b9cbcbb59891894ef) (featherless)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)

### ButtonBar

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### Buttons

#### Changes

* [Automated header standardization by the kokoro script. (#2472)](https://github.com/material-components/material-components-ios/commit/d1b31cab6acaf665e968a59524372e6f24f4520c) (featherless)
* [Fix example storyboard module (#2427)](https://github.com/material-components/material-components-ios/commit/108aa31fb982f9ae497edca8cc2312154153d220) (Robert Moore)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Update layer elevation only on change (#2484)](https://github.com/material-components/material-components-ios/commit/4f9f95a24433f3dfb69f0439202eae6eb8451ee9) (Robert Moore)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### Chips

#### Changes

* [Fix private header import (#2434)](https://github.com/material-components/material-components-ios/commit/527b093bc8e158a6383914b50d8206023ce8ee59) (Sam Morrison)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)

### CollectionCells

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)

### Collections

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)

### Dialogs

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### FeatureHighlight

#### Changes

* [Automated header standardization by the kokoro script. (#2472)](https://github.com/material-components/material-components-ios/commit/d1b31cab6acaf665e968a59524372e6f24f4520c) (featherless)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### FlexibleHeader

#### Changes

* [Automated header standardization by the kokoro script. (#2472)](https://github.com/material-components/material-components-ios/commit/d1b31cab6acaf665e968a59524372e6f24f4520c) (featherless)
* [Fix bug where insets wouldn't be removed from the old tracking scroll view when a new one was set. (#2498)](https://github.com/material-components/material-components-ios/commit/882c71ae1166f1c3929075a71c0324ec890b76b4) (featherless)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)
* [[kokoro] Specify ios_multi_cpus and ios_minimum_os when building against bazel. (#2458)](https://github.com/material-components/material-components-ios/commit/bac12681f514bfb3e003a1efad4315193b97594b) (featherless)

### HeaderStackView

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### Ink

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### LibraryInfo

#### Changes

* [Clean up warning flags (#2456)](https://github.com/material-components/material-components-ios/commit/b558c28e34e4037475ade8fb4d8e0c78ca31294d) (Adrian Secord)

### MaskedTransition

#### Changes

* [Convert motion spec to an Objective-C static class. (#2460)](https://github.com/material-components/material-components-ios/commit/2ab8cf5c78e17d33fb0906657609e077fb7e02c5) (featherless)

### NavigationBar

#### Changes

* [Automated header standardization by the kokoro script. (#2472)](https://github.com/material-components/material-components-ios/commit/d1b31cab6acaf665e968a59524372e6f24f4520c) (featherless)
* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[NavBar] Fix custom title view on iOS 11. (#2437)](https://github.com/material-components/material-components-ios/commit/8b267bc787325bf5d28db77afa7ccec97cfb6a03) (Andrés)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### PageControl

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### Palettes

#### Changes

* [Clean up warning flags (#2456)](https://github.com/material-components/material-components-ios/commit/b558c28e34e4037475ade8fb4d8e0c78ca31294d) (Adrian Secord)

### ProgressView

#### Changes

* [Convert motion spec to an Objective-C static class. (#2452)](https://github.com/material-components/material-components-ios/commit/a4d0a8512accb2ed9678a9de37a2c3c84b26992f) (featherless)
* [Make the motion spec values be class properties. (#2474)](https://github.com/material-components/material-components-ios/commit/fceb3e8314e1574d973a2b8f6ac5bf8e6d1bf27a) (featherless)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### Slider

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### Snackbar

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)

### Tabs

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Selection indicator templates (#2384)](https://github.com/material-components/material-components-ios/commit/e558394e6eaf148bdd83704c42face9473fcaab8) (Brian Moore)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### TextFields

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [Reverting change that caused regression. (#2492)](https://github.com/material-components/material-components-ios/commit/8472a0ad799cad0fcb07460143e1fdb458146e85) (Will Larche)
* [Use framework-style imports. (#2428)](https://github.com/material-components/material-components-ios/commit/c3615fa300e7fa2bc0cb188bf2caeced5cd33747) (Sylvain Defresne)
* [[Kokoro] Support for TextFields, Math, and Typography (#2432)](https://github.com/material-components/material-components-ios/commit/1bd5590bbb19a28f1869733588535429b4642015) (Will Larche)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### Themes

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [[Themer] Updating the protocol generic syntax. (#2440)](https://github.com/material-components/material-components-ios/commit/d9e0811a819b463a128e8ece569ea5d6e444aed8) (Will Larche)

### Typography

#### Changes

* [Replace unnecessary imports with forward declarations (#2429)](https://github.com/material-components/material-components-ios/commit/2a966822308c5fb2416081480ebf59a5734f1b66) (Yurii Samsoniuk)
* [[Kokoro] Support for TextFields, Math, and Typography (#2432)](https://github.com/material-components/material-components-ios/commit/1bd5590bbb19a28f1869733588535429b4642015) (Will Larche)

# 40.0.3

* [Chips] Fix private header import (#2434)

# 40.0.2

* Fix missing step from 40.0.1: update version numbers throughout library.

# 40.0.1

* [Catalog] Added Import to catalog’s AppDelegate.

# 40.0.0

## API Changes

### Bottom Sheet

* Added `trackingScrollView` property to support better dragging.

### Chips (new)

* Added [Chips](https://material.io/go/design-chips).

### LibraryInfo (new)

* Added LibraryInfo for accessing information about the MDC library itself.

### Tabs

* Added `[MDCTabBar defaultHeightForBarPosition:itemAppearance:]`.

### Text Fields

* Refactored [color theming support](https://github.com/material-components/material-components-ios/pull/2416).

## Component changes

### ActivityIndicator

#### Changes

* [Fix bug where outer rotation was incorrect in determinate state. (#2390)](https://github.com/material-components/material-components-ios/commit/c25d6e32485ea3837d5a333c79ce3ba18fc899a3) (featherless)
* [Prefix the motion spec with the API name. (#2387)](https://github.com/material-components/material-components-ios/commit/13b0631515888140172ac8b923a40a541492a9fe) (featherless)
* [Replace Motion relative imports with framework imports throughout the repo. (#2424)](https://github.com/material-components/material-components-ios/commit/30c9fcb84116ef47ec1d5e629dee06b85962f1aa) (featherless)
* [[ProgressView|ActivityIndicator] Fix build (#2385)](https://github.com/material-components/material-components-ios/commit/114b2e28cd03218a0196663a2ba6ce937d0b8df8) (Brian Moore)

### AppBar

#### Changes

* [[FlexibleHeader] Add hideViewWhenShifted API. (#2317)](https://github.com/material-components/material-components-ios/commit/f11269ad6b15cb50f9b137a4a0ff7512058166da) (Andrés)

### BottomNavigation

#### Changes

* [Update bottom navigation bar defaults to match native component height and orientation behavior (#2411)](https://github.com/material-components/material-components-ios/commit/106de4a6bf8a719e9b1aa6f48e1a58da84af5f16) (Junius Gunaratne)

### BottomSheet

#### Changes

* [Add BUILD file for kokoro + bazel support. (#2396)](https://github.com/material-components/material-components-ios/commit/5c87a3fd9a43cfdf57e14be69e743f3d3f27e351) (featherless)
* [Add a trackingScrollView API to the bottom sheet controller. (#2420)](https://github.com/material-components/material-components-ios/commit/d30b396671021a9b540158c0ca446b8d174046d6) (featherless)
* [Don't set the frame on the draggable view until we've set the anchor point. (#2399)](https://github.com/material-components/material-components-ios/commit/4907310d3453d7ff8768cc826c9abfe0312ef01a) (featherless)
* [Remove umbrella imports from source files. (#2397)](https://github.com/material-components/material-components-ios/commit/dbeb67977f2615686a07095e42fa6d35aa0ca476) (featherless)
* [Replace mdc_cancel category method with a C function. (#2398)](https://github.com/material-components/material-components-ios/commit/607b128566577bfd6974d9efe71d1e70b7b1b75d) (featherless)
* [Safe Area fixes (#2392)](https://github.com/material-components/material-components-ios/commit/c6e8803c86ceb90bd48571408fb15b02caa9a891) (Andrés)

### Chips

#### Changes

* [Chip component (#2389)](https://github.com/material-components/material-components-ios/commit/7c8131b672e9aa296f2dcde47d36d5faace268ee) (Sam Morrison)

### Collections

#### Changes

* [Support SafeAreaInsets in MDCCollectionInfoBarView. (#2378)](https://github.com/material-components/material-components-ios/commit/8cda30a778236df51ae9da5a067476abc67f4862) (Andrés)
* [Use MDCPalettes for info bar colors (#2364)](https://github.com/material-components/material-components-ios/commit/2f1921b64e6aed760fea68491a8ea5a2591713b6) (Yurii Samsoniuk)

### FlexibleHeader

#### Changes

* [Add hideViewWhenShifted API. (#2317)](https://github.com/material-components/material-components-ios/commit/f11269ad6b15cb50f9b137a4a0ff7512058166da) (Andrés)

### LibraryInfo

#### Changes

* [Add new LibraryInfo component (attempt #2) (#2412)](https://github.com/material-components/material-components-ios/commit/1a24b7cb9ed93f2e0196d0839e0e5fa11674a40f) (Adrian Secord)

### MaskedTransition

#### Changes

* [Update the component with MotionAnimator v2 APIs. (#2386)](https://github.com/material-components/material-components-ios/commit/655712a616129dd4253091687e30892c47ffd814) (featherless)

### PageControl

#### Changes

* [Corrected comment that references file name of the strings file. (#2394)](https://github.com/material-components/material-components-ios/commit/e63e9ad595a2f87e2d965c44ede89b0a81ff1904) (Randall Li)

### ProgressView

#### Changes

* [Replace Motion relative imports with framework imports throughout the repo. (#2424)](https://github.com/material-components/material-components-ios/commit/30c9fcb84116ef47ec1d5e629dee06b85962f1aa) (featherless)
* [[ProgressView|ActivityIndicator] Fix build (#2385)](https://github.com/material-components/material-components-ios/commit/114b2e28cd03218a0196663a2ba6ce937d0b8df8) (Brian Moore)

### Slider

#### Changes

* [Correct colors for slider default light color scheme (#2409)](https://github.com/material-components/material-components-ios/commit/74d700e466155aa3475241a83ae37c1973cb65cb) (John Detloff)
* [Use MDCPalettes for default thumb track color (#2369)](https://github.com/material-components/material-components-ios/commit/f437e8187a405c9e320b647e66ca0b110e5ff8df) (Yurii Samsoniuk)

### Tabs

#### Changes

* [Remove incorrect layout optimization (#2422)](https://github.com/material-components/material-components-ios/commit/c1397792ccca4f403ff51fbb026df64b44492228) (Brian Moore)
* [Use bottom position when determining the bottom tab bar's height (#2375)](https://github.com/material-components/material-components-ios/commit/ba097149c4f4c1dd6f2161ca7f7994829273ba40) (Brian Moore)

### TextFields

#### Changes

* [Complete theming of controllers (#2416)](https://github.com/material-components/material-components-ios/commit/93cc72187f8f376cf36747c06d6ecec328533bcb) (Will Larche)

### Themes

#### Changes

* [[TextFields] Complete theming of controllers (#2416)](https://github.com/material-components/material-components-ios/commit/93cc72187f8f376cf36747c06d6ecec328533bcb) (Will Larche)

# 39.0.0

## API Changes

### Animation Timing

* Added the `MDCAnimationTimingFunctionSharp` timing function [from the spec](https://material.io/guidelines/motion/duration-easing.html#duration-easing-natural-easing-curves).

### Bottom Navigation

* Added `MDCBottomNavigationBarDelegate` with controls on selecting items.

### Button

* Added `minimumSize` and `maximumSize` properties.

### Ink

* Added `injectedInkViewForView` convenience function to find an ink view in a view hierarchy.

### Slider

* Added `disabledColor` property.

### Text Fields

* Added `MDCMultilineTextField` `expandsOnOverflow` and `placeholder` text properties.
* The `MDCTextInput` `expandsOnOverflow` property is no longer IBInspectable.

## Component changes

### ActivityIndicator

#### Changes

* [Add a mode switch for the configurator example. (#2341)](https://github.com/material-components/material-components-ios/commit/26297be7d6a97c68caa0ea86a16893cec3de472a) (featherless)
* [Extract motion spec and use the Material Motion Animator for all animations. (#2344)](https://github.com/material-components/material-components-ios/commit/8e6da0f4973b202f4f7334e33bd2747f7ff05bec) (featherless)
* [Fix bug where the indeterminate animation stroke end would animate too quickly. (#2345)](https://github.com/material-components/material-components-ios/commit/4923871005b8756144c919c146478717e4f7042b) (featherless)
* [Implement sizeThatFits on MDCActivityIndicator (#2380)](https://github.com/material-components/material-components-ios/commit/bfe59c010f8eb28cec3a02f5498e712575fa91dd) (John Detloff)
* [Initial addition of kokoro and bazel continuous integration support. (#2316)](https://github.com/material-components/material-components-ios/commit/4ef8b6fdae7a92eca730eee1f9ad669f19dbc053) (featherless)
* [Remove ActivityIndicator prefix from local static consts. (#2342)](https://github.com/material-components/material-components-ios/commit/7ed14b83b91d51c2479534cf02080b3fcb960cbd) (featherless)

### AnimationTiming

#### Changes

* [Add the sharp curve. (#2329)](https://github.com/material-components/material-components-ios/commit/7b86769656def213e5f543835c7653d6570a8121) (Cody Weaver)
* [Initial addition of kokoro and bazel continuous integration support. (#2316)](https://github.com/material-components/material-components-ios/commit/4ef8b6fdae7a92eca730eee1f9ad669f19dbc053) (featherless)

### BottomNavigation

#### Changes

* [ Add protocol for responding to item selection (#2372)](https://github.com/material-components/material-components-ios/commit/9788a65695ee55d3772e0e5a1bb70f543cde20e7) (Junius Gunaratne)
* [Add bottom navigation documentation (#2313)](https://github.com/material-components/material-components-ios/commit/b218a0a379c74d4a247c14b8581d737c3f40bce5) (Junius Gunaratne)
* [Add color themer to bottom navigation bar (#2239)](https://github.com/material-components/material-components-ios/commit/4ada8e028a40a129ee41d2728ee5fd4415966d70) (Junius Gunaratne)
* [Fix example using iOS 10 API (#2357)](https://github.com/material-components/material-components-ios/commit/798f44762da90eef3fed6faffdd258ab28a65f28) (Robert Moore)

### Buttons

#### Changes

* [Add properties minimumSize, maximumSize (#2254)](https://github.com/material-components/material-components-ios/commit/5bba61686c083155e5ac1ec8d332c58ab792b541) (Robert Moore)
* [Deprecate -cornerRadius method (#2256)](https://github.com/material-components/material-components-ios/commit/4e02cc19b82a90782a8d9fbc26aaf1298e67d3da) (Robert Moore)

### CollectionCells

#### Changes

* [[Collections] Change image when accessoryType changes (#2354)](https://github.com/material-components/material-components-ios/commit/5b33ae0c0b9eec9c0b7d5296535e80a14a397733) (Robert Moore)

### FlexibleHeader

#### Changes

* [Fix bug where status bar visibility changes could cause the header size to jump. (#2321)](https://github.com/material-components/material-components-ios/commit/7e35618d2ae89a00228fe7ff3efb2399913c3c12) (featherless)
* [Fix jumping header behavior when shifting off-screen. (#2327)](https://github.com/material-components/material-components-ios/commit/28518354cf717a3d236213a43f9043ead75546e8) (featherless)
* [[FlexibleHeader+UIMetrics] Add BUILD file. (#2323)](https://github.com/material-components/material-components-ios/commit/eed027106ba71609116706ef2ea70460750c1f88) (featherless)
* [updating FlexibleHeader readme (#2318)](https://github.com/material-components/material-components-ios/commit/9175d84dd34706290e80967ce776d261f65c3f3a) (Martin Petrov)

### Ink

#### Changes

* [Add BUILD file. (#2330)](https://github.com/material-components/material-components-ios/commit/cc7033f8575c118dfecf9a1c588a322269719b45) (featherless)
* [Moved InkTouchController injectedInkViewForView: from catalog to Ink component (#2332)](https://github.com/material-components/material-components-ios/commit/fa90fc349506bc0f6e6a14f07d89467ce922c5ab) (Randall Li)

### MaskedTransition

#### Changes

* [Fix imports of private headers (#2331)](https://github.com/material-components/material-components-ios/commit/4d49d02d13c15d0a6aa2b9dac9e11aa0e68d7893) (Robert Moore)

### PageControl

#### Changes

* [Removed unused ColorFromRGB function (#2365)](https://github.com/material-components/material-components-ios/commit/342b19a67b8c2b172ad0ebc672a2d49c4b033619) (Yurii Samsoniuk)

### Palettes

#### Changes

* [Initial addition of kokoro and bazel continuous integration support. (#2316)](https://github.com/material-components/material-components-ios/commit/4ef8b6fdae7a92eca730eee1f9ad669f19dbc053) (featherless)

### ProgressView

#### Changes

* [Add a motion spec and use new implicit motion animator APIs (#2363)](https://github.com/material-components/material-components-ios/commit/d8919eb8a2ab64eb60968610f11f28b6eef727a5) (featherless)
* [Use MDCPalettes for default tint color (#2368)](https://github.com/material-components/material-components-ios/commit/3e0adf5acfe7bc86fdea3fb36150c4fc19e5d95e) (Yurii Samsoniuk)

### Slider

#### Changes

* [Create default light and dark color schemes for MDCSlider (#2362)](https://github.com/material-components/material-components-ios/commit/b9218a2e7562ae91007a580974a45deaa8863729) (John Detloff)

### TextFields

#### Changes

* [Adding a constraints update when the placeholder scale changes. (#2367)](https://github.com/material-components/material-components-ios/commit/b5dc8a79e4c067638346af258003cedea239d3e7) (Will Larche)
* [Correcting alphabetizing of some code. (#2343)](https://github.com/material-components/material-components-ios/commit/336d830895e2a633cde9414e53d5a9734c067bff) (Will Larche)
* [Fix multiline placeholder position and transform bug. PR #2 (#2360)](https://github.com/material-components/material-components-ios/commit/e13fa143a59f548d2adc80a6fb313cf29c94a4e4) (Will Larche)
* [Fixes bugs on multiline IB support (#2289)](https://github.com/material-components/material-components-ios/commit/282754e7a90aeec008365ac75b8985626a462d88) (Will Larche)
* [Some useful comments. (#2366)](https://github.com/material-components/material-components-ios/commit/0bcae8d882fcca8219929116805af8acd20a3513) (Will Larche)


# 38.1.1

No code changes. Added a missing dependency to the BottomNavigation component found after the 38.1.0 release was published.

# 38.1.0

## API Changes

### Bottom Navigation

* New component: Bottom Navigation makes it easy to explore and switch between top-level views in a single tap, similar to a UITabBar.

### Text Fields

* `MDCTextInput.cursorColor` controls the color of the blinking cursor (in the text).

## Component changes

### ActivityIndicator

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [Migrated to MDFi18n. (#2246)](https://github.com/material-components/material-components-ios/commit/58ad191297559f089951cf3c0c43a0f38d77ea7d) (Yurii Samsoniuk)

### AnimationTiming

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

### AppBar

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [Migrated to MDFi18n. (#2243)](https://github.com/material-components/material-components-ios/commit/ddafafc7b1d19ac0e7e1714d35feea3e6fde742b) (Yurii Samsoniuk)

### BottomAppBar

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [Migrated to MDFi18n. (#2244)](https://github.com/material-components/material-components-ios/commit/351bb832cc14ec3edeba81be8b91299035d1e144) (Yurii Samsoniuk)

### BottomNavigation

#### Changes

* [Adding bottom navigation component (#2088)](https://github.com/material-components/material-components-ios/commit/58ecc3e8e1ac6a14e447d3ceacc752e56d26afa4) (Junius Gunaratne)
* [Create Bottom Navigation Swift example (#2288)](https://github.com/material-components/material-components-ios/commit/1f8f13f151d9a5eaca594b2e35b46182e1c0f41c) (Junius Gunaratne)
* [[BotteomNavigation] Migrated to MDFi18n. (#2306)](https://github.com/material-components/material-components-ios/commit/26bf3a36dcd7200ba392ff06e1b3be1bbb2f5ad4) (Yurii Samsoniuk)

### ButtonBar

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [[BottomBar] Migrated to MDFi18n. (#2245)](https://github.com/material-components/material-components-ios/commit/06671d1889c6791dc0f462cf7f7b120f50be9a2d) (Yurii Samsoniuk)

### Buttons

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

### CollectionCells

#### Changes

* [Migrated to MDFi18n. (#2248)](https://github.com/material-components/material-components-ios/commit/6f5fb72de07d7e192ee85067916ff7110e72e9bc) (Yurii Samsoniuk)

### Collections

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

### Dialogs

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

### FlexibleHeader

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [Update the min/max height before enforcing content insets. (#2312)](https://github.com/material-components/material-components-ios/commit/96cef4fd9ebb29792f5c8fa4c0f7c0fc97b68b67) (featherless)

### HeaderStackView

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

### MaskedTransition

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [Fix bug where transitions wouldn't complete. (#2293)](https://github.com/material-components/material-components-ios/commit/7d1f3aed00675c25ab049e5ec3ec05e7762d014f) (featherless)
* [Use the provided key path consts from MotionAnimator. (#2294)](https://github.com/material-components/material-components-ios/commit/c4b7bce94eaa04c790b6957d908d0fcde8c9a101) (featherless)

### NavigationBar

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [Migrated to MDFi18n (#2280)](https://github.com/material-components/material-components-ios/commit/fd639afac18be2f52d8b30edb631212e0db7e361) (Yurii Samsoniuk)
* [[NavigationBarExamples] Swapped private/RTL with MDFi18n (#2300)](https://github.com/material-components/material-components-ios/commit/524e78705bbdc5c52b09dad326ec57830ad4571c) (Yurii Samsoniuk)

### PageControl

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [safeArea fixes (#2301)](https://github.com/material-components/material-components-ios/commit/2ed1139d691baacb6b62ff06b8f6a2326cdf5ffe) (ianegordon)

### Palettes

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

### ProgressView

#### Changes

* [[ProgressBar] Migrated to MDFi18n (#2281)](https://github.com/material-components/material-components-ios/commit/752b7af6f5fd4c88a45648c78a2409ae42e9a88e) (Yurii Samsoniuk)

### ShadowElevations

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

### ShadowLayer

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

### Tabs

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [Internal fixes to account for the Safe Area insets. (#2261)](https://github.com/material-components/material-components-ios/commit/2d8a51e5d5d473d0753929133d54c7cbccc34eb1) (Andrés)
* [Migrated to MDFi18n (#2282)](https://github.com/material-components/material-components-ios/commit/639941a3f554127a76a1806fe0a1fc62e11da801) (Yurii Samsoniuk)
* [[Catalog] De-hardcode the status bar height from a couple of examples. (#2292)](https://github.com/material-components/material-components-ios/commit/cdfbaacec457973d7f3c144183afb931bfac8a9b) (Andrés)
* [[TabBar] Add safeAreaInsets.bottom to tabBarHeight in MDCTabBarViewController. (#2315)](https://github.com/material-components/material-components-ios/commit/ecf0e815c69f3776c81fa83f63dba044bcf7bdd0) (Andrés)

### TextFields

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)
* [Adds cursor color as parameter (#2297)](https://github.com/material-components/material-components-ios/commit/463a2831a0cf40a77ad299d9622643ef617231b8) (Will Larche)
* [Fixes clear button not reseting character count (#2277)](https://github.com/material-components/material-components-ios/commit/327c3f5ef6d92ddd4aa7214bdef49e7bbc65ff92) (Will Larche)
* [Major improvements to RTL (#2274)](https://github.com/material-components/material-components-ios/commit/e411f38259f9f9229e30a5ac42a54787e26b4b21) (Will Larche)
* [Migrated to MDFi18n (#2283)](https://github.com/material-components/material-components-ios/commit/582ddaad1d305e922444dbdeefda2c3ab1e0467c) (Yurii Samsoniuk)

### Typography

#### Changes

* [@objc annotating catalog by convention (#2305)](https://github.com/material-components/material-components-ios/commit/f98a9d42ed6d713460db20f3e08316df153b375d) (Martin Petrov)

# 38.0.1

## API Changes

None for this release.

## Component changes

### BottomAppBar

#### Changes

* [Remove unnecessary autoresizing mask (#2273)](https://github.com/material-components/material-components-ios/commit/f2463399eb626e477a9be480f3f94285a7cd59bd) (Junius Gunaratne)
* [Set nav bar frame on layout (#2272)](https://github.com/material-components/material-components-ios/commit/b3667a712f05ece21fd750e1a2d7cdae90f18c89) (Junius Gunaratne)

### FlexibleHeader

#### Changes

* [Disable content inset adjustments in the horizontal pager scroll view example's horizontal scroll view. (#2264)](https://github.com/material-components/material-components-ios/commit/b0b2a96ce40b3031d675aa2c2ea2963bd0fa33d6) (featherless)
* [Only disable automaticallyAdjustsScrollViewInsets on the parent controller when the device is running an OS older than iOS 11. (#2265)](https://github.com/material-components/material-components-ios/commit/67a810e98304b6627f61d340eebbfe08b7f374e0) (featherless)
* [[Flexible Header] Rework our enforcement of content insets. (#2263)](https://github.com/material-components/material-components-ios/commit/9c6e78fe11c66561296e281b2dda88a84dc231cc) (featherless)

### TextFields

#### Changes

* [Updating kitchen sink example to use trailing and leading views. (#2266)](https://github.com/material-components/material-components-ios/commit/035b9b4cae4eab6b36c902deb3894332fcb02223) (Will Larche)


# 38.0.0

## API Changes

## Navigation Bar

* (Swift only) `titleTextAttributes` uses a dictionary with keys of type `NSAttributedStringKey` instead of `NSString *` so, for example, `.font` should be used intead of `NSAttributedStringKey.font.rawValue`.

## Component changes

### AppBar

#### Changes

* [[AppBarExample] Load image assets using UIImage(named:in:compatibleWith:) (#2233)](https://github.com/material-components/material-components-ios/commit/0601a77200aae7f8c3b3d4e346a3a3195bcd8816) (Yurii Samsoniuk)

### BottomAppBar

#### Changes

* [Update bottom app bar for iPhone X (#2234)](https://github.com/material-components/material-components-ios/commit/9f44d52984f97263b9c85c339fc944cbdf201102) (Junius Gunaratne)

### Collections

#### Changes

* [Don't inset sections when there is a safe area inset. (#2258)](https://github.com/material-components/material-components-ios/commit/67825350b275b242e46a7e33c4a068063c44fadd) (Andrés)

### Dialogs

#### Changes

* [Set Dialog example button to open material.io (#2214)](https://github.com/material-components/material-components-ios/commit/53929d85941168a2fc27ffd486e6073f9f4e4b15) (ianegordon)

### NavigationBar

#### Changes

* [Swift 4/iOS 11 Compatibility: Updated MDCNavigationBar's titleTextAttributes property. (#2213)](https://github.com/material-components/material-components-ios/commit/cb85c9b311c26f65af978b26debf155289fec98a) (Kirk Spaziani)

# 37.0.0

## API Changes

### Text Fields

* Added `[MDCTextFieldPositioningDelegate textInputDidUpdateConstraints]`, called after the input's `updateConstraints`.
* `MDCTextInputControllerDefault`'s `floatingPlaceholderDestination` property is replaced with `floatingPlaceholderOffset` and is a `UIOffset`, not `CGPoint`.

## Component changes

### Buttons

#### Changes

* [Update layout constraint to offset buttons by 20pt upwards, move catalog functions into extension (#2194)](https://github.com/material-components/material-components-ios/commit/1c7c9cd541efbb22ef55c049305c21a984d2a42e) (Cody Weaver)
* [use modern selectors (#2207)](https://github.com/material-components/material-components-ios/commit/3762aecee3d850a8d097f27fdec9528d18b20068) (Martin Petrov)

### FlexibleHeader

#### Changes

* [Update contentInsetAdjustmentBehavior check to include ScrollableAxes (#2223)](https://github.com/material-components/material-components-ios/commit/5f5988f0023614e6f38382bafbe5f73c1bdff0a5) (Andrés)
* [inFrontOfInfiniteContent working when !trackingScrollView (#2221)](https://github.com/material-components/material-components-ios/commit/fa464bad13f88669777a593f798ab47386177c98) (Andrés)

### PageControl

#### Changes

* [Fix bug with OOB array lookup when calling scrollViewDidScroll. (#2197)](https://github.com/material-components/material-components-ios/commit/ab6aae7158e66d90e7899321c71b6b95af7fd1e3) (Moshe Kolodny)
* [use modern selectors (#2207)](https://github.com/material-components/material-components-ios/commit/3762aecee3d850a8d097f27fdec9528d18b20068) (Martin Petrov)

### Slider

#### Changes

* [Fix layout positions so UISlider isn't cropped on iPhone 4s. (#2216)](https://github.com/material-components/material-components-ios/commit/d190b646c7252621cf069393bf6937ddbc2a99ec) (Cody Weaver)

### Snackbar

#### Changes

* [Update to support safeAreaInsets (#2212)](https://github.com/material-components/material-components-ios/commit/5beada0e8dc4975979d9a1b78e44568be6a66ade) (Sam Morrison)

### Tabs

#### Changes

* [Fix a bug that where an item cell title can be missing (#2202)](https://github.com/material-components/material-components-ios/commit/5797b17934e6c021f7a942026efee1cf0c3adaa9) (Chris Silverberg)

### TextFields

#### Changes

* [Corrects cheap floating placeholder layout (2nd PR) (#2210)](https://github.com/material-components/material-components-ios/commit/17e962fb35c3f56aebd47b7720bcb6a227ced8f4) (Will Larche)


# 36.3.0

## API Changes

### Flexible Header

* Added `minMaxHeightIncludesSafeArea` to inform the component if the `minimumHeight` and `maximumHeight` properties include the safe area inset.

## Component changes

### FlexibleHeader

#### Changes

* [Introduce minMaxHeightIncludesSafeArea and fix rotation bugs. (#2184)](https://github.com/material-components/material-components-ios/commit/100d18816b7574f4c210df9c7c3afa716f661b78) (Andrés)
* [Split _hasExplicitlySetMinOrMaxHeight into two. (#2196)](https://github.com/material-components/material-components-ios/commit/1c754aee3b1dda7166babc97306c315c4d7b901d) (Andrés)

# 36.2.0

## API Changes

### Text fields

* `-[MDCTabBarControllerDelegate tabBarController:shouldSelectViewController:]` and `-[MDCTabBarControllerDelegate tabBarController:didSelectViewController:]` will be called for the currently-selected tab if the user taps the tab again (that is, the tab doesn't change). This matches Apple's behavior more closely and allows for custom behaviors.
* `MDCMultilineTextField` now has a `MDCMultilineTextInputDelegate` for useful methods not included in UITextViewDelegate.

## Component changes

### ActivityIndicator

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### AnimationTiming

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### AppBar

#### Changes

* [Make use of MDCDeviceTopSafeAreaInset. (#2186)](https://github.com/material-components/material-components-ios/commit/778d9c6b2f7ac4c10a4cc101c8c8fd3c9d500e53) (featherless)
* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### BottomAppBar

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### BottomSheet

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### Dialogs

#### Changes

* [ Respect safe area insets (#2165)](https://github.com/material-components/material-components-ios/commit/5d0ff9467337de10d414b179440279bd5461ea4f) (ianegordon)
* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### FlexibleHeader

#### Changes

* [Ignore safe area inset changes if we know that the status bar visibility is changing. (#2160)](https://github.com/material-components/material-components-ios/commit/e28536c27d44bc6cb0b6e10204f8bf192cfd7b9d) (featherless)
* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### HeaderStackView

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### NavigationBar

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### ShadowElevations

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)
* [Update ShadowElevations to be extensible. (#2145)](https://github.com/material-components/material-components-ios/commit/49fd0a07eaf0c01aa0f0798f13998fdfb6b68be2) (Martin Petrov)
* [Update shadow examples (#2174)](https://github.com/material-components/material-components-ios/commit/6639fb4f704854452ff391352fecae5b6be81095) (Martin Petrov)

### ShadowLayer

#### Changes

* [Update shadow examples (#2174)](https://github.com/material-components/material-components-ios/commit/6639fb4f704854452ff391352fecae5b6be81095) (Martin Petrov)
* [[ShadowElevations] Update ShadowElevations to be extensible. (#2145)](https://github.com/material-components/material-components-ios/commit/49fd0a07eaf0c01aa0f0798f13998fdfb6b68be2) (Martin Petrov)

### Snackbar

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### Tabs

#### Changes

* [Add standard Material Design shadow shadow to MDCTabBar (#2148)](https://github.com/material-components/material-components-ios/commit/660c3fb066097f8fc5a42fbda8448ce195f6499e) (Scott Atwood)
* [Always call MDCTabBarControllerDelegate methods when a tab is tapped (#2155)](https://github.com/material-components/material-components-ios/commit/d46e3a3fab33581e421db27fb5c1592a68dd9b11) (Scott Atwood)
* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### TextFields

#### Changes

* [Clear button X value adjustment. (#2176)](https://github.com/material-components/material-components-ios/commit/7c5ef7d03ef78b2f013cbb7912c2ccd2e7b85109) (Will Larche)
* [Fix text fields overlapping labels (#2163)](https://github.com/material-components/material-components-ios/commit/75cf565fea869bb002a797c86d452704d8365d90) (Will Larche)
* [Implementing textFieldShouldClear: (#2169)](https://github.com/material-components/material-components-ios/commit/07eea020ca381a34ea8cce264becf1e8a2ba38aa) (Will Larche)
* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)
* [Some alphabetizing. (#2166)](https://github.com/material-components/material-components-ios/commit/9cb8ec36dfeca9ff94385b2c995b0198f0ecee9b) (Will Larche)

### Themes

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

### Typography

#### Changes

* [Remove trailing whitespace everywhere. (#2168)](https://github.com/material-components/material-components-ios/commit/479f7b1141db4d80963f30ecf4fe9096ad5973f0) (Adrian Secord)

# 36.1.0

## API Changes

### Text fields

* Added `placeholderText` property to control the placeholder text.

## Component changes

### ActivityIndicator

#### Changes

* [Resolve issues caused by starting and stopping activitiy indicator quickly (#2053)](https://github.com/material-components/material-components-ios/commit/34f8b4e0af259585df1ea0d307c88c2c6dc15267) (John Detloff)

### Buttons

#### Changes

* [Add tests for MDCButton+Subclassing behaviors (#2136)](https://github.com/material-components/material-components-ios/commit/75e343d0fb830f9db80e7ec75d57e0f1af0b38ff) (Sam Morrison)
* [Remove test broken on travis (#2147)](https://github.com/material-components/material-components-ios/commit/4ff00d3b2a7e0df990be033d0c466d39af837aab) (Sam Morrison)

### Dialogs

#### Changes

* [Migrate to  MDFInternationalization (#2124)](https://github.com/material-components/material-components-ios/commit/c3379250de3f8d7abb86810c37b7fbb363995a85) (ianegordon)

### FlexibleHeader

#### Changes

* [Fix bug where minimumHeight of 0 would result in odd behavior. (#2139)](https://github.com/material-components/material-components-ios/commit/b7cab3bdf0776eb6e98a192e9610d280803582c2) (featherless)
* [Fix where we adjust the frame if the safe area changes. (#2146)](https://github.com/material-components/material-components-ios/commit/94e625f7817bd68590dbcc3613972eab8fcc1585) (Andrés)
* [Forward viewWillTransitionToSize events to the flexible header (#2150)](https://github.com/material-components/material-components-ios/commit/863b85a7d4ebdec672036e8411797ef74c7d2e02) (featherless)
* [Introduce minMaxHeightIncludesSafeArea. (#2123)](https://github.com/material-components/material-components-ios/commit/4a98cdaa32bd443850590610c95d3576cea32847) (Andrés)
* [Revert "Introduce minMaxHeightIncludesSafeArea. (#2123)" (#2161)](https://github.com/material-components/material-components-ios/commit/dcadf2d19c6986e6303a584c878e295377070a3e) (Andrés)

### TextFields

#### Changes

* [Adding .placeholderText to controllers (#2149)](https://github.com/material-components/material-components-ios/commit/5dae93c6c42ffb3594572a2cace4e63850c97189) (Will Larche)
* [Fixes clear button not updating the character counter. (#2143)](https://github.com/material-components/material-components-ios/commit/585571e18ad3eb47741f34ded94d2150de0b77df) (Will Larche)
* [Styling doc gif addition. (#2144)](https://github.com/material-components/material-components-ios/commit/2604acad222b1193599631cf321c6f6c9a844fab) (Will Larche)

### Themes

#### Changes

* [[TextFields] Adding .placeholderText to controllers (#2149)](https://github.com/material-components/material-components-ios/commit/5dae93c6c42ffb3594572a2cace4e63850c97189) (Will Larche)

# 36.0.0

## API Changes

### Buttons

* Converted elevation methods to use `MDCShadowElevation` type insetad of raw CGFloats.

### Palettes

* Palettes require Xcode 8+'s toolchain to compile.

### Shadow Elevations

* Introduced the `MDCShadowElevation` typedef for shadow elevation values instead of raw CGFloats.

## Component changes

### ActivityIndicator

#### Changes

* [[Mutliple components] Update components that use colors to use MDCPalette. (#2129)](https://github.com/material-components/material-components-ios/commit/a462a2ac4f10dc5e820b9927b0947655a51aff99) (Cody Weaver)

### AppBar

#### Changes

* [Example corrections. (#2108)](https://github.com/material-components/material-components-ios/commit/03fd5a02ce533bc9ab8fff06531d6c4bbbb39330) (Will Larche)
* [Fix app bar's top constraint that is buggy on iOS 11.0 (#2103)](https://github.com/material-components/material-components-ios/commit/2aa88ad4a10a4ab6e500d99d63fdd9ba051c2910) (Andrés)
* [[Catalog] Fixes improper use of Bundle and assets (#2118)](https://github.com/material-components/material-components-ios/commit/96fb533554df78d96a112524a5af43e6ecea6975) (Will Larche)

### BottomAppBar

#### Changes

* [Add readme and Swift example (#2040)](https://github.com/material-components/material-components-ios/commit/49e4ae74c6a0d3be2ed1a25fd83391a5442d1214) (Junius Gunaratne)

### BottomSheet

#### Changes

* [[Bottom Sheet] Remove script-breaking whitespace from README.md preamble.](https://github.com/material-components/material-components-ios/commit/736094fc1a4377828a432dddf0a6dfcac2f79771) (Adrian Secord)
* [[Catalog] Fixes improper use of Bundle and assets (#2118)](https://github.com/material-components/material-components-ios/commit/96fb533554df78d96a112524a5af43e6ecea6975) (Will Larche)

### Buttons

#### Changes

* [Change MDCButton to use MDCShadowElevation type instead of CGFloat. Fixes #2105.](https://github.com/material-components/material-components-ios/commit/f49aaa823cfd4efeaee09a970765eb859eb75a43) (Adrian Secord)
* [Restore alpha when re-enabled (#2095)](https://github.com/material-components/material-components-ios/commit/7d80d4677a4585094e0e202284aef4a73f05af35) (Robert Moore)

### CollectionCells

#### Changes

* [[Mutliple components] Update components that use colors to use MDCPalette. (#2129)](https://github.com/material-components/material-components-ios/commit/a462a2ac4f10dc5e820b9927b0947655a51aff99) (Cody Weaver)

### Collections

#### Changes

* [Modernize Swift in styling readme. (#2133)](https://github.com/material-components/material-components-ios/commit/f9cf78cd0fba03ddd8ecd72ec658eae414ffd2c7) (Martin Petrov)
* [Update collections to support iPhone X (#1988)](https://github.com/material-components/material-components-ios/commit/cd39384b48ac3907254ee8785774b47d783b471e) (Gauthier Ambard)
* [[Mutliple components] Update components that use colors to use MDCPalette. (#2129)](https://github.com/material-components/material-components-ios/commit/a462a2ac4f10dc5e820b9927b0947655a51aff99) (Cody Weaver)

### Dialogs

#### Changes

* [[Catalog] Fixes improper use of Bundle and assets (#2118)](https://github.com/material-components/material-components-ios/commit/96fb533554df78d96a112524a5af43e6ecea6975) (Will Larche)

### FlexibleHeader

#### Changes

* [Make sure we update the layout when the safe area changes (#2068)](https://github.com/material-components/material-components-ios/commit/4b2998a670792b5eaa20a105f6efaf4f9be5f81a) (Andrés)
* [[Catalog] Fixes improper use of Bundle and assets (#2118)](https://github.com/material-components/material-components-ios/commit/96fb533554df78d96a112524a5af43e6ecea6975) (Will Larche)
* [[Mutliple components] Update components that use colors to use MDCPalette. (#2129)](https://github.com/material-components/material-components-ios/commit/a462a2ac4f10dc5e820b9927b0947655a51aff99) (Cody Weaver)

### HeaderStackView

#### Changes

* [[Catalog] Fixes improper use of Bundle and assets (#2118)](https://github.com/material-components/material-components-ios/commit/96fb533554df78d96a112524a5af43e6ecea6975) (Will Larche)
* [[Mutliple components] Update components that use colors to use MDCPalette. (#2129)](https://github.com/material-components/material-components-ios/commit/a462a2ac4f10dc5e820b9927b0947655a51aff99) (Cody Weaver)

### NavigationBar

#### Changes

* [[Mutliple components] Update components that use colors to use MDCPalette. (#2129)](https://github.com/material-components/material-components-ios/commit/a462a2ac4f10dc5e820b9927b0947655a51aff99) (Cody Weaver)

### PageControl

#### Changes

* [Fixed crasher when resetting -numberOfPages to 0 (#2132)](https://github.com/material-components/material-components-ios/commit/f7bcc9a7ac40ae6c636251b66463884daaad1045) (Julien Poumailloux)

### ShadowElevations

#### Changes

* [Improve Swift support for shadow elevations (#2116)](https://github.com/material-components/material-components-ios/commit/a9b08ce452d8d46d0f39bc0ef524c634cec1ab48) (Junius Gunaratne)
* [Partial revert of commit bc582f4 to restore the definition of MDCShadowElevationSwitch .](https://github.com/material-components/material-components-ios/commit/960ec4a8231f4488aa99226a2f6c8aeed1204223) (Adrian Secord)
* [[MDCShadowElevations] Remove switch elevation, add bottom navigation bar elevation (#2093)](https://github.com/material-components/material-components-ios/commit/bc582f4b143e32dcdc0d7f7afe406536c67414da) (Junius Gunaratne)

### ShadowLayer

#### Changes

* [[ShadowElevations] Improve Swift support for shadow elevations (#2116)](https://github.com/material-components/material-components-ios/commit/a9b08ce452d8d46d0f39bc0ef524c634cec1ab48) (Junius Gunaratne)

### Snackbar

#### Changes

* [Move dismissal accessibility hint to .strings file (#2107)](https://github.com/material-components/material-components-ios/commit/fd166a1ec53aedd50c9c543fca0bae3c6588de9e) (Sam Morrison)

### Tabs

#### Changes

* [Invalidate layout on window change (#2122)](https://github.com/material-components/material-components-ios/commit/5135ecc27a9effaad989f2b568b35b59847be154) (Brian Moore)
* [MDCTabBarViewController should delegate status bar to children (#2126)](https://github.com/material-components/material-components-ios/commit/a0531c62f9905a7deb9612ad72e4bfc02a1a7e02) (Icycle)
* [Remove tint color from themer (#2104)](https://github.com/material-components/material-components-ios/commit/881b70a960cfb8605be355a880990ebc36fcc134) (Junius Gunaratne)
* [[Catalog] Fixes improper use of Bundle and assets (#2118)](https://github.com/material-components/material-components-ios/commit/96fb533554df78d96a112524a5af43e6ecea6975) (Will Larche)
* [[Mutliple components] Update components that use colors to use MDCPalette. (#2129)](https://github.com/material-components/material-components-ios/commit/a462a2ac4f10dc5e820b9927b0947655a51aff99) (Cody Weaver)

### TextFields

#### Changes

* [Examples bug and formatting (#2137)](https://github.com/material-components/material-components-ios/commit/b438856be2ce9ae796026ad53805def079baefb4) (Will Larche)
* [Fix broken MDCMultilineTextField build for iOS 10. (#2100)](https://github.com/material-components/material-components-ios/commit/467fdf31a5e3fb06145f2447ae8c68031edf9eb0) (Martin Petrov)
* [Fixes a broken link. (#2114)](https://github.com/material-components/material-components-ios/commit/51da715c26cefa25f9557abec35f839651d2d870) (Scott Hyndman)
* [[Catalog] Fixes improper use of Bundle and assets (#2118)](https://github.com/material-components/material-components-ios/commit/96fb533554df78d96a112524a5af43e6ecea6975) (Will Larche)

### Themes

#### Changes

* [Add documentation for material themes (#2094)](https://github.com/material-components/material-components-ios/commit/d4b428b43c3506879a644c782297bb6d3192e503) (Junius Gunaratne)

### Typography

#### Changes

* [Add example using custom font family (#2130)](https://github.com/material-components/material-components-ios/commit/7de124c318b7f8dd2e2ad35496ceed012e26760d) (Cody Weaver)
* [Match MDCTypography docs with nullability annotations (#2117)](https://github.com/material-components/material-components-ios/commit/87cb35b13ea6b1d6fcea6279e4dc9af50477eca4) (Sam Morrison)


# 35.3.0

## API Changes

### Text Fields

* New properties on `MDCTextInputController`:`inlinePlaceholderFont`, `inlinePlaceholderFontDefault`, `leadingUnderlineLabelFont, `leadingUnderlineLabelFontDefault`.
* New classes `MDCTextInputControllerFilled`, `MDCTextInputControllerOutlined`, `MDCTextInputControllerOutlinedTextArea`.

## Component changes

### AppBar

#### Changes

* [Adds example using a UITableViewController with sections. (#2051)](https://github.com/material-components/material-components-ios/commit/21e0bed4a2dbc92d590ab48550da6e5d2849667a) (Marc-Antoine Courteau)
* [Use safeAreaLayoutGuide.topAnchor instead of fixed status bar height (#2078)](https://github.com/material-components/material-components-ios/commit/ad2becaab3fe5e1ec238bcd4a43c0f7f215ce1ce) (Andrés)
* [[FlexibleHeader] Fixes to support scroll views with Safe Area insets. (#2063)](https://github.com/material-components/material-components-ios/commit/80d054e3a571604b2eb2adbc8a09cd5cfbe674a8) (Andrés)

### BottomSheet

#### Changes

* [[Dialogs] Size action buttons during layout (#2065)](https://github.com/material-components/material-components-ios/commit/a5e28488f915f03ef63eeb7ee356f00b880e42df) (Robert Moore)

### Buttons

#### Changes

* [[Catalog] Fix button examples (#2047)](https://github.com/material-components/material-components-ios/commit/d44164290f5e7fff0058cc8d8410c95c695cc48e) (Robert Moore)
* [[Swiftlint]Refactor ButtonsStoryboardAndProgrammatic.swift  (#2060)](https://github.com/material-components/material-components-ios/commit/4e4c06fd8dbe745a95dd01cad5645ae7d433f04a) (Cody Weaver)

### Dialogs

#### Changes

* [Size action buttons during layout (#2065)](https://github.com/material-components/material-components-ios/commit/a5e28488f915f03ef63eeb7ee356f00b880e42df) (Robert Moore)

### FeatureHighlight

#### Changes

* [[TextFields] Adding a doc: menu for styles (#2064)](https://github.com/material-components/material-components-ios/commit/3fc78fd868acac33d9a1ec4d22b0394a65594b0b) (Will Larche)

### FlexibleHeader

#### Changes

* [Fixes to support scroll views with Safe Area insets. (#2063)](https://github.com/material-components/material-components-ios/commit/80d054e3a571604b2eb2adbc8a09cd5cfbe674a8) (Andrés)

### MaskedTransition

#### Changes

* [Upgrade to MotionTransitioning v3.3.0. (#2077)](https://github.com/material-components/material-components-ios/commit/b238e8bbf354c88677d5785be624003f8c9df506) (featherless)

### NavigationBar

#### Changes

* [Fix layoutSubviews to take into account the safe area insets. (#2070)](https://github.com/material-components/material-components-ios/commit/80173864a8b725062084982e5f5054ace1364815) (Andrés)
* [Pixel-align title (#2043)](https://github.com/material-components/material-components-ios/commit/7f798da56be0bbb2dcdb8b02a3e5d9222158e34f) (Robert Moore)

### Tabs

#### Changes

* [Unit tests for two-line text-only tabs (#2075)](https://github.com/material-components/material-components-ios/commit/e2d79b3c7810607963a5ca67921011ff7c55e5e9) (Robert Moore)
* [[TabBar] Support 2-line labels for "top" tabs (#2028)](https://github.com/material-components/material-components-ios/commit/c50dec414c77ea0d1bc7d46975b70cb5a0662e2d) (Robert Moore)
* [[TabBar] Vertically center text tab labels (#2023)](https://github.com/material-components/material-components-ios/commit/6591e941bd28f90fd53275c44e2e68cc954f0891) (Robert Moore)

### TextFields

#### Changes

* [Adding a doc: menu for styles (#2064)](https://github.com/material-components/material-components-ios/commit/3fc78fd868acac33d9a1ec4d22b0394a65594b0b) (Will Larche)
* [Better custom fonts (#2056)](https://github.com/material-components/material-components-ios/commit/f247bae8ba3e5ea409168530ed3f0e0e068bf671) (Will Larche)
* [Fixing bug of bad intrinsicContentSize. (#2073)](https://github.com/material-components/material-components-ios/commit/41bae7a6320ff9778c323d0d9768e3cbfa976126) (Will Larche)
* [Removing unused ivar from full width. (#2058)](https://github.com/material-components/material-components-ios/commit/a09a641dc60b2f5490f83ce33acc59f4620c6865) (Will Larche)
* [Renaming classes to match the MD spec (#2061)](https://github.com/material-components/material-components-ios/commit/cde864f235cc3290ad451f3b53a37ee7f8bef43c) (Will Larche)
* [Updating markdown syntax. (#2052)](https://github.com/material-components/material-components-ios/commit/e5235ee60343dce77d9338cbc1bcd27273c2d768) (Will Larche)
* [iOS 11 example bugs fixed (#2071)](https://github.com/material-components/material-components-ios/commit/90e79dd81581ce700ad694f1bd295e0426a48a20) (Will Larche)

# 35.2.0

## API Changes

### Bottom App Bar

* New component: A bottom app bar view with an embedded floating button.

### Text Fields

* `MDCTextField.clearButtonMode` now supports UIAppearance.

## Component changes

### BottomAppBar

#### Changes

* [Add bottom app bar component to MDC (#2016)](https://github.com/material-components/material-components-ios/commit/3f5b770f2c72e8347f22dccff3ad1deb4ad047cc) (Junius Gunaratne)
* [Fix bottom app bar animation (#2034)](https://github.com/material-components/material-components-ios/commit/71c4548b205aa7d06928cebeae5be33b7b6d6158) (Junius Gunaratne)
* [Fix bottom app bar animation for leading and trailing states. (#2036)](https://github.com/material-components/material-components-ios/commit/e0ce8549b6323a0d0990411b93fc6ed4c091b113) (Junius Gunaratne)
* [Update the file creation date to the correct year (#2035)](https://github.com/material-components/material-components-ios/commit/e68fee2c677c931e262bb0df3395400daea7b442) (Junius Gunaratne)

### Buttons

#### Changes

* [Replace usage of `new`  with `alloc init` to match the style guide. (#2033)](https://github.com/material-components/material-components-ios/commit/fb32dccf2d0e87427d4c792fe811526a985a49e1) (Adrian Secord)

### FlexibleHeader

#### Changes

* [Replace usage of `new`  with `alloc init` to match the style guide. (#2033)](https://github.com/material-components/material-components-ios/commit/fb32dccf2d0e87427d4c792fe811526a985a49e1) (Adrian Secord)

### Ink

#### Changes

* [Replace usage of `new`  with `alloc init` to match the style guide. (#2033)](https://github.com/material-components/material-components-ios/commit/fb32dccf2d0e87427d4c792fe811526a985a49e1) (Adrian Secord)

### NavigationBar

#### Changes

* [[BottomAppBar] Add bottom app bar component to MDC (#2016)](https://github.com/material-components/material-components-ios/commit/3f5b770f2c72e8347f22dccff3ad1deb4ad047cc) (Junius Gunaratne)

### Tabs

#### Changes

* [Replace usage of `new`  with `alloc init` to match the style guide. (#2033)](https://github.com/material-components/material-components-ios/commit/fb32dccf2d0e87427d4c792fe811526a985a49e1) (Adrian Secord)
* [[Catalog] Fix Tabs example for rotation (#2019)](https://github.com/material-components/material-components-ios/commit/017f86f134e61eb8aa2de816bc8cc0ce3bd11528) (Robert Moore)
* [[Catalog] Update all Mono fonts to use system font (#1967)](https://github.com/material-components/material-components-ios/commit/2b160e6a7cbd4dd1991a0b5c002eafbbde593e65) (Cody Weaver)

### TextFields

#### Changes

* [Adding a missing UIAppearance support (#2027)](https://github.com/material-components/material-components-ios/commit/be93066cae09566d978c4fbe36e9de98a2bb1346) (Will Larche)
* [Improved rtl behavior (#2038)](https://github.com/material-components/material-components-ios/commit/8fe46625dff4ae2b1dd7876ef93ccef9c7d56e9c) (Will Larche)
* [Improving alphabetization and comments (#2031)](https://github.com/material-components/material-components-ios/commit/91c6226c6c0c4120a75961ebbfcf744fe4820cbd) (Will Larche)

# 35.1.0

## API Changes

### Shadows

* Added support for colored shadows.

## Component changes

### Buttons

#### Changes

* [Support colored shadows (#1965)](https://github.com/material-components/material-components-ios/commit/d19632cf0feec7cb9df5a86dc13b847c676958c8) (Robert Moore)

### Ink

#### Changes

* [Call setNeedsLayout on max ripple radius change. (#2011)](https://github.com/material-components/material-components-ios/commit/c7bb4319e1b1b59094b59499ac8682baaf277e4b) (Adrian Secord)

### NavigationBar

#### Changes

* [Use CGRectGet instead of accessing properties (#1991)](https://github.com/material-components/material-components-ios/commit/78a1b06e589df5b9259f01eaecaa1fd73fd56433) (Cody Weaver)

### PageControl

#### Changes

* [Fix bad indicator state when changing numberOfPages. (#1997)](https://github.com/material-components/material-components-ios/commit/c5988c9e0b5b56764b26166a9869ce7398ba8f95) (Moshe Kolodny)
* [Switch NSMutableArray to Swift Array. (#1998)](https://github.com/material-components/material-components-ios/commit/9b0a1dbc3cf8ecb2045de7cc4696a8e6d65ad0f6) (Moshe Kolodny)
* [Update swift example (#1979)](https://github.com/material-components/material-components-ios/commit/397a993ca29b2f64effa48edf0e2a646c7edbd09) (Cody Weaver)

### Tabs

#### Changes

* [[Catalog] Bottom Navigation example should use safeAreaInsets (#1976)](https://github.com/material-components/material-components-ios/commit/601789c8c9ee2ae81fa742dfabfce3a801e5b01b) (Robert Moore)
* [fix uppercase title override (#1992)](https://github.com/material-components/material-components-ios/commit/688c26cb6a54825f2462a90de4ebce6932bb73cf) (Elliot Schrock)

### TextFields

#### Changes

* [Adding helper text to examples. (#1994)](https://github.com/material-components/material-components-ios/commit/0d227f32119a2da2fb6d5693ca73fd0e8e69e6e6) (Will Larche)
* [Clear button mode correction. (#2002)](https://github.com/material-components/material-components-ios/commit/f8ee76c23b5980273c419b460abd0452f83384db) (Will Larche)
* [Objective-c example for outlined (#2001)](https://github.com/material-components/material-components-ios/commit/587ca2e95258602f1669a732d632e37fe900f4af) (Will Larche)
* [Padded label for placeholder for outlined style. (#1993)](https://github.com/material-components/material-components-ios/commit/986e6b2d1903289e7361a3e8c80f31aedcbf7bb5) (Will Larche)
* [Pinning clear button to top of input. (#2003)](https://github.com/material-components/material-components-ios/commit/2149c01149faf7a6bf8c1ef73a501faf1ac10b7a) (Will Larche)

# 35.0.0

## API Changes

### PageControl

* [`[MDCPageControl sizeForNumberOfPages:]` method changed from instance method to class method](https://github.com/material-components/material-components-ios/pull/1960) (Cody Weaver)

### TextFields

* [`[MDCTextInputControllerDefault floatingPlaceholderColor]` renamed to `floatingPlaceholderNormalColor`](https://github.com/material-components/material-components-ios/pull/1963), similarly `floatingPlaceholderColorDefault` and the same for `MDCTextInputControllerLegacyDefault`.

## Component changes

### BottomSheet

#### Changes

* [Added README (#1946)](https://github.com/material-components/material-components-ios/commit/5e8d4b0fbeac8d4656e855a9816adbbf64b497b7) (Cody Weaver)

### ButtonBar

#### Changes

* [- Update setting of insets to use size classes and device type (#1936)](https://github.com/material-components/material-components-ios/commit/03f9eea0169d195234c6195ca7c563d296844176) (Justin Shephard)

### Dialogs

#### Changes

* [[Dialog] Fix alert controller, title and message take half screen even they are nil (#1931)](https://github.com/material-components/material-components-ios/commit/bd55e33beea576ad5a0643eab4e5848de20b8784) (ruizhao)

### PageControl

#### Changes

* [Updated sizeForNumberOfPages to class method (#1960)](https://github.com/material-components/material-components-ios/commit/f2e89e73b87a7b25b9a3960449017c45e113f92d) (Cody Weaver)

### Snackbar

#### Changes

* [[Catalog] Fix SnackbarOverlayViewExample's use of the OverlayObserver (#1955)](https://github.com/material-components/material-components-ios/commit/6a0a5a62e5c43ef24dae480015c29171acbf102b) (Andrés)

### TextFields

#### Changes

* [Fix for placeholders being colored active when isEditing = NO (#1963)](https://github.com/material-components/material-components-ios/commit/c70d720e9b5fe9bfb35ec14a8c178a531131f18d) (Will Larche)

### Themes

#### Changes

* [Use onTintColor when styling UISwitch (#1950)](https://github.com/material-components/material-components-ios/commit/33794f7c1f435ff0b6b9553689d46c716d3db289) (Andrés)


# 34.0.2

## API Changes

None.

## Component changes

### ActivityIndicator

#### Changes

* [Use explicit class for bundle (#1930)](https://github.com/material-components/material-components-ios/commit/695712da63f18441e5d7c4bbde923f232188bd66) (Brian Moore)
* [[AnimationTiming | ActivityIndicator] Add swift examples (#1944)](https://github.com/material-components/material-components-ios/commit/7f647e0ee62cafb60220ea3315c36f073979892f) (Cody Weaver)

### AnimationTiming

#### Changes

* [[AnimationTiming | ActivityIndicator] Add swift examples (#1944)](https://github.com/material-components/material-components-ios/commit/7f647e0ee62cafb60220ea3315c36f073979892f) (Cody Weaver)

### AppBar

#### Changes

* [[Bundles] Use explicit class in bundleForClass (#1942)](https://github.com/material-components/material-components-ios/commit/7f4c4e18c594b9b31cca126e313e8db26e1553bf) (Robert Moore)
* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### ButtonBar

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Buttons

#### Changes

* [Deprecate subclassing to set cornerRadius and contentEdgeInsets (#1896)](https://github.com/material-components/material-components-ios/commit/395177518777a355457dc0829903e47483420984) (Sam Morrison)
* [Revert  Deprecate subclassing to set cornerRadius and contentEdgeInsets (#1896) (#1948)](https://github.com/material-components/material-components-ios/commit/0e3b57c785f0c95a32515ed47b72d7205037a1db) (Sam Morrison)
* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### CollectionCells

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Collections

#### Changes

* [[Bundles] Use explicit class in bundleForClass (#1942)](https://github.com/material-components/material-components-ios/commit/7f4c4e18c594b9b31cca126e313e8db26e1553bf) (Robert Moore)
* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Dialogs

#### Changes

* [[Bundles] Use explicit class in bundleForClass (#1942)](https://github.com/material-components/material-components-ios/commit/7f4c4e18c594b9b31cca126e313e8db26e1553bf) (Robert Moore)
* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### FeatureHighlight

#### Changes

* [Fix broken properties (#1938)](https://github.com/material-components/material-components-ios/commit/720c2e360eebd76fae712edc6ccc5cc45cd101e8) (Sam Morrison)
* [[Bundles] Use explicit class in bundleForClass (#1942)](https://github.com/material-components/material-components-ios/commit/7f4c4e18c594b9b31cca126e313e8db26e1553bf) (Robert Moore)
* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### FlexibleHeader

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### HeaderStackView

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### MaskedTransition

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### NavigationBar

#### Changes

* [- Update the setting of edge insets to use size classes and device type, not just device type (#1933)](https://github.com/material-components/material-components-ios/commit/4551b7b2a12cce9e9d62c85d7174b6c2ea103331) (Justin Shephard)
* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### PageControl

#### Changes

* [[Bundles] Use explicit class in bundleForClass (#1942)](https://github.com/material-components/material-components-ios/commit/7f4c4e18c594b9b31cca126e313e8db26e1553bf) (Robert Moore)
* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Palettes

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### ProgressView

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### ShadowElevations

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### ShadowLayer

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Slider

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Snackbar

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Tabs

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### TextFields

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Themes

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)

### Typography

#### Changes

* [[Catalog] Verify all examples provide CatalogByConvention methods (#1911)](https://github.com/material-components/material-components-ios/commit/8940d77d6d5ed124a466ecd35717b5c26a03106f) (Robert Moore)


# 34.0.1

Hotfix: Fixes Feature Highlight configuration.

## Component changes

### FeatureHighlight

#### Changes

* [Fix broken properties (#1938)](https://github.com/material-components/material-components-ios/commit/669e2f7079239edb29d3bf97c66daecbd49f707d) (Sam Morrison)

# 34.0.0

## API Diffs

### AnimationTiming

* Improved nullibility annotations.

### Buttons

* Added more support for UIAppearance in MDCButton.
* Added border color and width parameters.

### FeatureHighlight

* Added support for UIContentSize (preferred user font sizes).

### TextFields

* Major update to improved visual styles. For previous version, use the `*Legacy*` classes.

## Component changes

### ActivityIndicator

#### Changes

* [[Activity Indicator] Added swift example (#1890)](https://github.com/material-components/material-components-ios/commit/178a7d676b7cc065c17d1ff44adf716ee96cf909) (Cody Weaver)
* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### AnimationTiming

#### Changes

* [Add nullability annotations (#1881)](https://github.com/material-components/material-components-ios/commit/4c6601fef5a0e6142faf9ab42d4bf4535f0d4c36) (Brian Moore)

### AppBar

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### BottomSheet

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### ButtonBar

#### Changes

* [[Buttons] Default hitAreaInsets for FAB (#1866)](https://github.com/material-components/material-components-ios/commit/15c0836e3dfc22e46c19931744f27d7dfec27188) (Robert Moore)
* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### Buttons

#### Changes

* [Add state-based border color and width (#1878)](https://github.com/material-components/material-components-ios/commit/e0324dd64b4f4835989f3172772b30479f38f8b1) (Sam Morrison)
* [Default hitAreaInsets for FAB (#1866)](https://github.com/material-components/material-components-ios/commit/15c0836e3dfc22e46c19931744f27d7dfec27188) (Robert Moore)
* [Ink Appearance compatibility (#1873)](https://github.com/material-components/material-components-ios/commit/d0ffcdc9c7b260a335d22c8cdc56d98981be006b) (Sam Morrison)
* [Make uppercaseTitle nondestructive (#1887)](https://github.com/material-components/material-components-ios/commit/a1e5f1685d6d15e572a991c614fdd2073ede1867) (Sam Morrison)
* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### Collections

#### Changes

* [Allow selection of cells with hidden ink (#1739)](https://github.com/material-components/material-components-ios/commit/2b6552d09fa2db540c8ae479097a661d084775bc) (Robert Moore)
* [Remove dismiss animation rotation (#1842)](https://github.com/material-components/material-components-ios/commit/6daa64df87679e5044356bf824c660c9d3083269) (Robert Moore)
* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### Dialogs

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### FeatureHighlight

#### Changes

* [Correctly load view (#1883)](https://github.com/material-components/material-components-ios/commit/65f1571f5d42c402c4ebfa25e055e8fb3e716355) (Sam Morrison)
* [Dynamic type support (#1884)](https://github.com/material-components/material-components-ios/commit/add558db3efce0d08747bc9c979003d9a9993638) (Sam Morrison)
* [Improve text layout (#1867)](https://github.com/material-components/material-components-ios/commit/f73704593b8f7cb4a2bddb599acc7d69b8ee9600) (Sam Morrison)
* [Shown views can receive taps (#1889)](https://github.com/material-components/material-components-ios/commit/7c8778ed75f7e58b7337e6bc9c60e7e2db7b96e2) (Robert Moore)
* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### FlexibleHeader

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### Ink

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### MaskedTransition

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### NavigationBar

#### Changes

* [[Buttons] Default hitAreaInsets for FAB (#1866)](https://github.com/material-components/material-components-ios/commit/15c0836e3dfc22e46c19931744f27d7dfec27188) (Robert Moore)

### OverlayWindow

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### PageControl

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### Slider

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### Snackbar

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### Tabs

#### Changes

* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)

### TextFields

#### Changes

* [Improving hit zone for becoming first responder in multiline. (#1894)](https://github.com/material-components/material-components-ios/commit/fbe70bd34cfc8290d0ab654da45de38f55a3ccce) (Will Larche)
* [Making a test pass on 3x simulator. (#1915)](https://github.com/material-components/material-components-ios/commit/ac57979961da9c93e6786f5ca1a3a1eabf8afc10) (Will Larche)
* [New styles: updated default, box, area (#1908)](https://github.com/material-components/material-components-ios/commit/c3ed6be9d15425c9ad7828efde5ad1588a0602c2) (Will Larche)
* [Outlined fields (#1914)](https://github.com/material-components/material-components-ios/commit/af58c018d9227226ea93a58c23b2813a2ebff779) (Will Larche)
* [[Catalog] Enabling all "unused" warnings (#1875)](https://github.com/material-components/material-components-ios/commit/5498005f65b672eaca14049c74d821eab24c0eb9) (Robert Moore)
* [[Textfields] Remove unused option (#1926)](https://github.com/material-components/material-components-ios/commit/5a83898f0636260b329856c1921767d8d9d26390) (ianegordon)

### Themes

#### Changes

* [New example for custom themes (#1891)](https://github.com/material-components/material-components-ios/commit/9abc922b0a18b2d4721083341780d568647d2b20) (Robert Moore)

### Typography

#### Changes

* [Match large font family on iOS 9+ (#1880)](https://github.com/material-components/material-components-ios/commit/edd0dbc1b9f7b2a57d5ef57583c70982d7eb8586) (Yurii Samsoniuk)

# 33.0.0

## API Diffs

### TextFields

Renaming changes in preparation for a new text field style coming soon. No functional or visual changes to the text fields.

* `MDCTextInputControllerDefault` was renamed to `MDCTextInputControllerLegacyDefault`.
* `MDCTextInputControllerFullWidth` was renamed to `MDCTextInputControllerLegacyFullWidth`.

## Component changes

### ActivityIndicator

#### Changes

* [- Added voice accessibility support for MDCActivityIndicator (#1765)](https://github.com/material-components/material-components-ios/commit/be23697c814507591ea259df571757bb69024aa0) (Justin Shephard)

### Buttons

#### Changes

* [Allow users to set a custom disabled title color (#1839)](https://github.com/material-components/material-components-ios/commit/6bbf52599f5dd25cc6ab8e2da4b2f64e3c3f0151) (Sam Morrison)
* [Correcting FAB expansion animation (#1858)](https://github.com/material-components/material-components-ios/commit/4d6b3c4112bdc60257776bd1e74b95483874db7d) (Robert Moore)
* [[Catalog] Fix ButtonsTypicalUse FAB position (#1847)](https://github.com/material-components/material-components-ios/commit/d5f28a6a4fd417352329c9efa00fc68489a7e64b) (Robert Moore)

### Collections

#### Changes

* [Decoration frame is unset when null (#1845)](https://github.com/material-components/material-components-ios/commit/70026b323b43e6bc6046462317b1215767b25385) (Robert Moore)
* [Fix example property attribute (#1854)](https://github.com/material-components/material-components-ios/commit/584e212fa02afbdc568d2293e4dac74f2bfe1bab) (Robert Moore)

### Dialogs

#### Changes

* [Fix example class warnings (#1850)](https://github.com/material-components/material-components-ios/commit/22d19b7ae68bafb978fc01a53dba6cd83ed07b5a) (Robert Moore)
* [Fix typo in comment](https://github.com/material-components/material-components-ios/commit/73b41562b0dd6993e5e7de6e4004487bf9bdcf3d) (ianegordon)

### FlexibleHeader

#### Changes

* [Make default shadow layer background match the view (#1834)](https://github.com/material-components/material-components-ios/commit/9b4bc89ee59611161add7259458652765ee4859c) (Brian Moore)

### NavigationBar

#### Changes

* [[TextFields] Renaming text field controllers to have 'Legacy' (#1876)](https://github.com/material-components/material-components-ios/commit/3bd23322aded8d2c236590fe2f21b504bc533384) (Will Larche)

### Tabs

#### Changes

* [[TabBar] Fix warnings and button color in example (#1849)](https://github.com/material-components/material-components-ios/commit/21b4e5028c90880a24d71e3f4f3589f4535ecd25) (Robert Moore)

### TextFields

#### Changes

* [New controller api for leading and trailing colors. (#1846)](https://github.com/material-components/material-components-ios/commit/1dcbaeed6b8dbe61659490335a4961089e75e481) (Will Larche)
* [Renaming text field controllers to have 'Legacy' (#1876)](https://github.com/material-components/material-components-ios/commit/3bd23322aded8d2c236590fe2f21b504bc533384) (Will Larche)
* [[TextField] Documentation clean up. (#1868)](https://github.com/material-components/material-components-ios/commit/f465c02cec3baa705f3fd690101be5fd9d5c26dc) (Scott Hyndman)

### Themes

#### Changes

* [[TextFields] Renaming text field controllers to have 'Legacy' (#1876)](https://github.com/material-components/material-components-ios/commit/3bd23322aded8d2c236590fe2f21b504bc533384) (Will Larche)


# 32.0.0

## API Diffs

### Buttons

* Added larger-icon version of the floating action button.

### TextFields

* Added `MDCTextInputController` properties `activeColor`, `disabledColor`, `normalColor`, and associated default colors.
* Removed `MDCTextInputController` properties `underlineColorActive`, `underlineColorNormal`, and associated default colors.
* Removed `MDCTextInputUnderlineView` properties `disabledUnderline` and `underline` in favor of `color` and `disabledColor`.

## Component changes

### AppBar

#### Changes

* [Added missing license stanzas. (#1768)](https://github.com/material-components/material-components-ios/commit/206b0bf39b4ddeb745433bf1a933f70c87b15b42) (Adrian Secord)
* [Fixing modal example bar colors (#1785)](https://github.com/material-components/material-components-ios/commit/f33f8c2d54829acbb43a57d3fb8cfe68ffe9bd1d) (Robert Moore)

### ButtonBar

#### Changes

* [Make ButtonBarButton insets in method (#1797)](https://github.com/material-components/material-components-ios/commit/0ee27517d076212355ffb15e1a6dfd8d021f8581) (Robert Moore)
* [Refactor ButtonBarBuilder for testing (#1796)](https://github.com/material-components/material-components-ios/commit/1441a01113a509cd7a4d37e9aab8dd1f768ae930) (Robert Moore)
* [Remove macro for bit masks (#1795)](https://github.com/material-components/material-components-ios/commit/28f6159e98f56918c3f095779f4841428a6e5c0c) (Robert Moore)

### Buttons

#### Changes

* [Adding FAB support for 36-point icons (#1810)](https://github.com/material-components/material-components-ios/commit/d7521029a8faa67d4c199ad36caf91f65fd25fea) (Robert Moore)
* [Creating animations for FAB appearance (#1755)](https://github.com/material-components/material-components-ios/commit/aaab9e6bb2010d9bed8d37ac62a4a535c5f2853d) (Robert Moore)
* [Fix FAB icon scale collapse timing (#1794)](https://github.com/material-components/material-components-ios/commit/18c8a884dd6c8ebfaa45973f43c54f7c0e0eddc2) (Robert Moore)
* [Unit tests for FAB animations (#1778)](https://github.com/material-components/material-components-ios/commit/7fc013958ee38b619eb33041eabf7b968941fdff) (Robert Moore)
* [[Catalog] Fix button typical use layout on iOS 9 (#1769)](https://github.com/material-components/material-components-ios/commit/4c6d0ba437ed62e3e59e1e365192eb2a7db8074e) (Robert Moore)
* [[FAB] Adding missing void. (#1771)](https://github.com/material-components/material-components-ios/commit/657c9163ffaafea29d304f5da85ed016c87891ea) (Will Larche)

### CollectionCells

#### Changes

* [[Collections] Make cell font values functions (#1763)](https://github.com/material-components/material-components-ios/commit/8b5aeec8e4ec5c730d556b524c72c5c8aebf938f) (Robert Moore)
* [[Collections] Replacing macros with function calls (#1787)](https://github.com/material-components/material-components-ios/commit/080cc3705823587303d78c63039f72be45318b1b) (Robert Moore)

### Collections

#### Changes

* [Adding unit tests for flow layouts (#1779)](https://github.com/material-components/material-components-ios/commit/417ce2b4f637f4101730eafa21940d4160e9bb4e) (Robert Moore)
* [Fix header info view z-index (#1798)](https://github.com/material-components/material-components-ios/commit/155a3975be5ed3abdc0d443036fd909a1d439f37) (Robert Moore)
* [Limit the drag needed to dismiss an item (#1811)](https://github.com/material-components/material-components-ios/commit/84a7a6bf7115724eaf698f2212fcd2e5193b1b4b) (Gauthier Ambard)
* [Replacing macros with function calls (#1787)](https://github.com/material-components/material-components-ios/commit/080cc3705823587303d78c63039f72be45318b1b) (Robert Moore)

### FeatureHighlight

#### Changes

* [Added missing license stanzas. (#1768)](https://github.com/material-components/material-components-ios/commit/206b0bf39b4ddeb745433bf1a933f70c87b15b42) (Adrian Secord)
* [Adjust Dismiss Drag Proportions To Feel More Natural #1754 (#1799)](https://github.com/material-components/material-components-ios/commit/b1c2bef67d05ba48fe1907547b10fd983fb9d28f) (InbarItayG)

### MaskedTransition

#### Changes

* [[Jazzy] Ran `scripts/generate_jazzy_yamls.sh` for new components. (#1766)](https://github.com/material-components/material-components-ios/commit/b89b714964971af19009b5ba5e7859d4831d8f92) (Adrian Secord)
* [[MDCMaskedTransition] Fixed Xcode 9 block declaration.](https://github.com/material-components/material-components-ios/commit/9e885d9f755bd26bfa3c9fef23c82171ce85a648) (Adrian Secord)

### NavigationBar

#### Changes

* [Added missing license stanzas. (#1768)](https://github.com/material-components/material-components-ios/commit/206b0bf39b4ddeb745433bf1a933f70c87b15b42) (Adrian Secord)
* [Hide UINavigationBar in example (#1784)](https://github.com/material-components/material-components-ios/commit/dca1fa0efb504496cbaa08997e57ed2f6122d7d8) (Robert Moore)

### OverlayWindow

#### Changes

* [Remove iOS 7 code (#1826)](https://github.com/material-components/material-components-ios/commit/3aa72e51292957ee47932376344e671fe638adc0) (Robert Moore)

### Snackbar

#### Changes

* [Fixing snackbar/overlay during rotation (#1830)](https://github.com/material-components/material-components-ios/commit/18d791e463cf835aac9c71e55e1c249f3bbf7268) (Robert Moore)
* [[OverlayWindow] Remove iOS 7 code (#1826)](https://github.com/material-components/material-components-ios/commit/3aa72e51292957ee47932376344e671fe638adc0) (Robert Moore)

### Tabs

#### Changes

* [Added missing license stanzas. (#1768)](https://github.com/material-components/material-components-ios/commit/206b0bf39b4ddeb745433bf1a933f70c87b15b42) (Adrian Secord)
* [[Jazzy] Ran `scripts/generate_jazzy_yamls.sh` for new components. (#1766)](https://github.com/material-components/material-components-ios/commit/b89b714964971af19009b5ba5e7859d4831d8f92) (Adrian Secord)

### TextFields

#### Changes

* [Adding a multiline text field to main example (#1790)](https://github.com/material-components/material-components-ios/commit/25c36a4867d525dec67077cf326d4dd25bee60be) (Will Larche)
* [Adding readme metadata. (#1777)](https://github.com/material-components/material-components-ios/commit/988dcc9a6afefb1bbb30c13596511ffa6a18229b) (Will Larche)
* [Adds api_components_root to TextFields/README.md. (#1788)](https://github.com/material-components/material-components-ios/commit/ffdd9b4c486d0f33cea04e4cf4d7b5aef4b0f4b7) (Scott Hyndman)
* [Correcting key typos. (#1770)](https://github.com/material-components/material-components-ios/commit/d8071fe78bc20791afa85f9cfd4fdfd29de79f75) (Will Larche)
* [Making a disabled color property on controllers (#1776)](https://github.com/material-components/material-components-ios/commit/7830d7eb29bcff7c5e3347d235e7d2058671caca) (Will Larche)
* [Readme update. (#1824)](https://github.com/material-components/material-components-ios/commit/e30c9a9f9617c63db81a3329caef2c52eca89409) (Will Larche)
* [Regular example improvements. (#1791)](https://github.com/material-components/material-components-ios/commit/5ab6885a2ad11866300b9490a6f0d4e5b2e3697a) (Will Larche)
* [Removing unused constraints in default. (#1789)](https://github.com/material-components/material-components-ios/commit/ba51dddd2d50504183ccb8ae5afe7fc2a6ba9a1b) (Will Larche)
* [Renaming and cleaning up propertys. (#1767)](https://github.com/material-components/material-components-ios/commit/d42f2c7713278ae585785fb818f95427b626f62d) (Will Larche)
* [[Jazzy] Ran `scripts/generate_jazzy_yamls.sh` for new components. (#1766)](https://github.com/material-components/material-components-ios/commit/b89b714964971af19009b5ba5e7859d4831d8f92) (Adrian Secord)



# 31.0.2

Hotfix release: fixes autolayout bug involving TextFields height.

## Component changes

### TextFields

#### Changes

* [Correcting content compression resistance priority. (#1809)](https://github.com/material-components/material-components-ios/commit/2ddf6a2f8c00179347e0ef3bcf67eb9e1e16fc65) (Will Larche)


# 31.0.1

No changes to code or docs, only updating metadata for generating https://material.io/components/ios/.

# 31.0.0

## API Diffs

### TextFields

* Added `MDCMultilineTextField`, a [Material Design-themed mutiline text field](https://www.google.com/design/spec/components/text-fields.html#text-fields-multi-line-text-field) (multiline text input).
* `[MDCTextFieldPositioningDelegate sizeThatFits:defaultSize:]` has been removed, see `[MDCTextFieldPositioningDelegate textInsets:]` instead.
* Added `MDCMultilineTextInput.minimumLines` and `.expandsOnOverflow` properties.

## Component changes

### Buttons

#### Changes

* [[Math] Align frames to pixel boundaries (#1730)](https://github.com/material-components/material-components-ios/commit/e03ad370c6fdfe23f35e4d3f61d2f55783be83c8) (Robert Moore)

### CollectionCells

#### Changes

* [[Collections] Making Disclosure indicator tinted (#1745)](https://github.com/material-components/material-components-ios/commit/e12db0f2ea806a3f64b3d4865b3402d66d8923b4) (Robert Moore)

### Collections

#### Changes

* [Fix for possible infinite recursion (#1711)](https://github.com/material-components/material-components-ios/commit/abb81d969b09c6baaf51997c04bcf384607ac8d0) (Justin Shephard)
* [Custom section insets call delegate (#1752)](https://github.com/material-components/material-components-ios/commit/0223d431e551e6afdbc33080ef815fef3794e79c) (Robert Moore)

### FeatureHighlight

#### Changes

* [Fix gesture recognizers (#1749)](https://github.com/material-components/material-components-ios/commit/6281b33d66029118c32693098f70d067ffb0b0fc) (Sam Morrison)
* [[Math] Align frames to pixel boundaries (#1730)](https://github.com/material-components/material-components-ios/commit/e03ad370c6fdfe23f35e4d3f61d2f55783be83c8) (Robert Moore)

### NavigationBar

#### Changes

* [Improve centering when barButtonItems are asymmetric (#1721)](https://github.com/material-components/material-components-ios/commit/65434fb244fd5997b84ddf6965404ce7c4cfe0bc) (Robert Moore)

### Slider

#### Changes

* [[Math] Align frames to pixel boundaries (#1730)](https://github.com/material-components/material-components-ios/commit/e03ad370c6fdfe23f35e4d3f61d2f55783be83c8) (Robert Moore)

### TextFields

#### Changes

* [Examples improvements. (#1734)](https://github.com/material-components/material-components-ios/commit/0922de660cfe7844e3d792ccfb03043030eed7ad) (Will Larche)
* [Fixing the ordering and labeling of 2 pragma marks. (#1731)](https://github.com/material-components/material-components-ios/commit/be703bc80037d9097c1704427321988d89045f3a) (Will Larche)
* [Formatting. (#1748)](https://github.com/material-components/material-components-ios/commit/980b9080f01fee0eed02e92a403a22828eb66fbc) (Will Larche)
* [Multiline textfields (#1756)](https://github.com/material-components/material-components-ios/commit/af964fe6706360b6c5bba839385133efe75bcba5) (Will Larche)
* [[Text fields] Simplification of height calculation. (#1733)](https://github.com/material-components/material-components-ios/commit/7d706cdddac80f42bc64d4276a3beda4b0ee935f) (Will Larche)


# 30.0.0

## API Diffs

### Collections

* Added 'shouldHideSeparatorForCellLayoutAttributes' to MDCCollectionViewStyling protocol.
* Added three methods to MDCCollectionViewStylingDelegate for optionally hiding cell separators.

### MaskedTransitioning

* New component that makes it easy to animate between two view controllers using an expanding mask effect.

### TextFields

* Added 'leadingView' and 'leadingViewMode' properties to MDCTextField.
* Renamed MDCTextFieldPositioningDelegate method 'textContainerInset:' to 'textInsets:'
* Added 'enabled', 'textInsets', 'trailingView' and 'trailingViewMode' properties to MDCTextInput.

### Typography

* Changed nullability of 'lightFontOfSize', 'mediumFontOfSize' and 'boldItalicFontOfSize' methods from nonnull to nullable.

## Component changes

### ButtonBar

#### Changes

* [[Themer] Avoid deprecation warning on iOS 9+ targets (#1700)](https://github.com/material-components/material-components-ios/commit/68d21a901edccd0ffffc9ed11ed067dc22e7b3d9) (ianegordon)

### Buttons

#### Changes

* [Add a stroked button to the examples (#1714)](https://github.com/material-components/material-components-ios/commit/04b8ced5a4b7971ad1dddb98bc9191ae8dff9a12) (Sam Morrison)
* [Fix storyboard backgroundColor assignment (#1706)](https://github.com/material-components/material-components-ios/commit/057a430b4b8d059a00b1f4e01930c71c6b20eaff) (Sam Morrison)
* [Reset Ink when moved to new superview (#1656)](https://github.com/material-components/material-components-ios/commit/4110e30ef23e7d5c007d07e676e8fc0c06bf87c9) (Robert Moore)
* [Set default title color of MDCFlatButton to black (#1725)](https://github.com/material-components/material-components-ios/commit/f1059f6aa9c85f52388a9525fd15603f3b925356) (Sam Morrison)
* [Unbounded ink aligns to content insets (#1670)](https://github.com/material-components/material-components-ios/commit/cafcbe3544c6bcbb1725e8f7ccdf5bb008760205) (Robert Moore)
* [Undo MDCFlatButton title color changes (#1681)](https://github.com/material-components/material-components-ios/commit/f4c76013577bc05f1bbdbcc50e1700db6766b9c9) (Sam Morrison)

### CollectionCells

#### Changes

* [[Collections] Extend cell label to superview width (#1661)](https://github.com/material-components/material-components-ios/commit/6785e7a0d33cb3a832cd96debe2a9e960967a059) (Robert Moore)
* [[Collections] Only change selected icon if needed (#1692)](https://github.com/material-components/material-components-ios/commit/44e7c7974b557d0e0e670e50390fd997e56723d7) (Robert Moore)
* [[Collections] Reuse label frames (#1705)](https://github.com/material-components/material-components-ios/commit/c1ce8bcca184a2a31c8af15da42294c450c2e13c) (ianegordon)

### Collections

#### Changes

* [Add "editing" performance example (#1710)](https://github.com/material-components/material-components-ios/commit/14e00b76ce457ca0538056b04bfb8f14d73f74f1) (Robert Moore)
* [Add StylingDelegate methods to control separator display (#1627)](https://github.com/material-components/material-components-ios/commit/14496a33a24652e0df175c2907eee543b6b06fd5) (Gauthier Ambard)

### Dialogs

#### Changes

* [Add Issue number. (#1727)](https://github.com/material-components/material-components-ios/commit/b8f8bfef9c13c06e0030b22398c8a0a8a33cde9e) (ianegordon)

### FeatureHighlight

#### Changes

* [Correctly handle ended and cancelled touches (#1684)](https://github.com/material-components/material-components-ios/commit/cfbb1d9862b5d52e32376caff4f71ef92f2c3041) (Sam Morrison)

### Ink

#### Changes

* [Don't assign compositeRipple frame twice (#1687)](https://github.com/material-components/material-components-ios/commit/756728d0b05eddfc2a9b0b6594c4ba03e6ce60a4) (Robert Moore)
* [[Buttons] Reset Ink when moved to new superview (#1656)](https://github.com/material-components/material-components-ios/commit/4110e30ef23e7d5c007d07e676e8fc0c06bf87c9) (Robert Moore)

### MaskedTransition

#### Changes

* [Add Masked Transition component. (#1513)](https://github.com/material-components/material-components-ios/commit/61acb1cbb09327f24acbebda2f9909a4fd9435fe) (featherless)

### Snackbar

#### Changes

* [Notify MDCOverlayObservers of bottom offset changes  (#1659)](https://github.com/material-components/material-components-ios/commit/392ac852614b72324cd7a3ee77ed20757ccd1f7f) (Sam Morrison)

### TextFields

#### Changes

* [Alphabetizing propertys. (#1691)](https://github.com/material-components/material-components-ios/commit/695dc6d5763ca041a8967ded7499af6e8db545b4) (Will Larche)
* [Comment grammar correction. (#1695)](https://github.com/material-components/material-components-ios/commit/3e135694ab954cc7dfe71b9cac77d376c04b74da) (Will Larche)
* [Constraint correction and cleanup. (#1665)](https://github.com/material-components/material-components-ios/commit/df0d4cbd297284d783358a4cbdbda555d7ab63d5) (Will Larche)
* [Fundament implementation of trailingViewMode. (#1702)](https://github.com/material-components/material-components-ios/commit/ca879cf159a5c3e69d89b465814579db46b591b9) (Will Larche)
* [Making enabled mandatory. (#1679)](https://github.com/material-components/material-components-ios/commit/0578ca3635729c00a16c89c63715154ae8269ddc) (Will Larche)
* [Making textInsets mandatory. (#1697)](https://github.com/material-components/material-components-ios/commit/31810b8872ad1335889809d918deebcbce8970b4) (Will Larche)
* [Moving two propertys to be below the correct pragma mark. (#1703)](https://github.com/material-components/material-components-ios/commit/b005771b19a0928bcd5403daea33490164e7a8e2) (Will Larche)
* [Overlay views. (#1676)](https://github.com/material-components/material-components-ios/commit/9cb9a209c5449e4de2a25dce530c25184c5f0d46) (Will Larche)
* [Renaming a tests file. (#1718)](https://github.com/material-components/material-components-ios/commit/80f7a1b58d5f1bed1a7561c15c77d00e20b40f2a) (Will Larche)
* [Reorganizing and internal clean up (#1677)](https://github.com/material-components/material-components-ios/commit/1920ec92092060cb3209defc9dfca5e000b37619) (Will Larche)
* [Tests for default priorities of constraints. (#1678)](https://github.com/material-components/material-components-ios/commit/ff618a457a21f074a3ef1ad2f8e2a6c8543311af) (Will Larche)
* [[TextField] Add color themer for text fields (#1666)](https://github.com/material-components/material-components-ios/commit/c3d24b71840fff47849a0b1bb0d44f0f6b3252d9) (Junius Gunaratne)
* [[Textfields] Better naming two tests (#1704)](https://github.com/material-components/material-components-ios/commit/b73c23cf1822122d5cba4d7e3ec046db7533c784) (Will Larche)

### Themes

#### Changes

* [[TextField] Add color themer for text fields (#1666)](https://github.com/material-components/material-components-ios/commit/c3d24b71840fff47849a0b1bb0d44f0f6b3252d9) (Junius Gunaratne)

### Typography

#### Changes

* [Fixing nullability attributes for fonts (#1696)](https://github.com/material-components/material-components-ios/commit/a2968c6decbc88226db868ffb6f8b4eb6ad6ea36) (Robert Moore)
* [[Fonts] Cache system fonts (#1689)](https://github.com/material-components/material-components-ios/commit/ebabb3385a8528e0e1bf9044d542ba9f12e01ed4) (Robert Moore)

# 29.0.0

* Reverts changes to the title color of MDCFlatButton and MDCRaisedButton.

# 28.0.0

## API Diffs

### AppBar

* Added MDCAppBarTextColorAccessibilityMutator

### Button

* Marked 'customTitleColor' as deprecated.
* Changed behavior of 'setTitleColor:forState:' so that it no longer changes the titleColor if the color was deemed to be of insufficient contrast with the background color.

### Icons

* For each icon in MDCIcons we now have a method that returns a UIImage.

### TextFields

* Removed UI_APPEARANCE_SELECTOR from all controller style properties.
* Changed all controller style properties from instance to class properties.

## Component changes

### AppBar

#### Changes

* [- Accessibility Mutator (#1236)](https://github.com/material-components/material-components-ios/commit/c6940925206512c4c9523f772dba1df398ba9423) (Justin Shephard)
* [Remove trailing whitespace](https://github.com/material-components/material-components-ios/commit/e63035cb751496da42844d0abbc5315faed69790) (Sam Morrison)

### ButtonBar

#### Changes

* [[Buttons] Deprecate customTitleColor and remove auto-accessibility from setTitleColor (#1609)](https://github.com/material-components/material-components-ios/commit/4c84b99f2b65fdd4208d385c26133d4e4bd153d6) (Sam Morrison)

### Buttons

#### Changes

* [Deprecate customTitleColor and remove auto-accessibility from setTitleColor (#1609)](https://github.com/material-components/material-components-ios/commit/4c84b99f2b65fdd4208d385c26133d4e4bd153d6) (Sam Morrison)

### CollectionCells

#### Changes

* [[Collections] Use image cache for selection icons (#1638)](https://github.com/material-components/material-components-ios/commit/565ae15cdb79e995fa25aa4b116e047973192813) (Robert Moore)

### Collections

#### Changes

* [Allow custom UIEdgeInsets (#1614)](https://github.com/material-components/material-components-ios/commit/0495092f1ecd9656e0fcb4d6b750a94f02af23f0) (Robert Moore)

### Dialogs

#### Changes

* [MDCAlertController should announce 'alert' in VO (#1639)](https://github.com/material-components/material-components-ios/commit/164493929913d25747220d0f6a6160813c254e42) (Sarah Read)
* [[Buttons] Deprecate customTitleColor and remove auto-accessibility from setTitleColor (#1609)](https://github.com/material-components/material-components-ios/commit/4c84b99f2b65fdd4208d385c26133d4e4bd153d6) (Sam Morrison)

### FeatureHighlight

#### Changes

* [[Feature Highlight] Swipe to dismiss (#1636)](https://github.com/material-components/material-components-ios/commit/f466588e4f35d4b6a415c0c888c2e4f2e6b9f250) (Sam Morrison)

### Ink

#### Changes

* [Ink reset passes animation value to ripples (#1652)](https://github.com/material-components/material-components-ios/commit/72657d5f8d45ca7ad399023f24bf93ad6a54a921) (Robert Moore)
* [Reset ink without animation calls delegate (#1654)](https://github.com/material-components/material-components-ios/commit/9e417817cb872354030bfed0137a6d256bf68503) (Robert Moore)

### NavigationBar

#### Changes

* [Vertically center navigationBar title within its default height for UIControlContentVerticalAlignmentTop (#1576)](https://github.com/material-components/material-components-ios/commit/780654af4ca4524f7d06f4732408841f2d679cfe) (Kien Tran)
* [[AppBar] - Fixed center align issue on RTL which was taking incorrect x value to determine centering (#1646)](https://github.com/material-components/material-components-ios/commit/ed6d150208f3d0a23679815092765c64bc2f7d8f) (Justin Shephard)

### PageControl

#### Changes

* [Remove internal references. (#1648)](https://github.com/material-components/material-components-ios/commit/18906c0e1e2a7bff467a837a2e71bbe8fa243d11) (Adrian Secord)

### TextFields

#### Changes

* [Appearance defaults (#1620)](https://github.com/material-components/material-components-ios/commit/36ef081eea4bb720b74a2f905e1d5d231e758ec0) (Will Larche)
* [Correcting active color. (#1640)](https://github.com/material-components/material-components-ios/commit/7a1ad7b4c4cf516e290b2802483a6dc30ecbe7c1) (Will Larche)
* [Correcting documentation typo. (#1647)](https://github.com/material-components/material-components-ios/commit/f3d1b35c6f17eb477107fe285fd2eadcf4de7a3d) (Will Larche)
* [Remove trailing whitespace](https://github.com/material-components/material-components-ios/commit/e63035cb751496da42844d0abbc5315faed69790) (Sam Morrison)
* [[Buttons] Deprecate customTitleColor and remove auto-accessibility from setTitleColor (#1609)](https://github.com/material-components/material-components-ios/commit/4c84b99f2b65fdd4208d385c26133d4e4bd153d6) (Sam Morrison)

# 27.0.0

## API Diffs

### Button

* Removed 'resetElevationForState'.
* Removed NS_UNAVAILABLE from 'setBackgroundColor'.

## Component changes

### ActivityIndicator

#### Changes

* [[Activity Indicator] Add import to QuartzCore (#1587)](https://github.com/material-components/material-components-ios/commit/97098c6caa3f3acafa5500fe788cf7a842e9135e) (Randall Li)

### AppBar

#### Changes

* [Explicitly annotating some known ObjC methods. (#1617)](https://github.com/material-components/material-components-ios/commit/1e14d4109178956486863dec607996100c91795e) (Martin Petrov)

### BottomSheet

#### Changes

* [[KeyboardWatcher] iOS 8 simplification and cleanup (#1589)](https://github.com/material-components/material-components-ios/commit/87574e57e313cb3e90281b3225031b329e8f91de) (ianegordon)

### ButtonBar

#### Changes

* [Explicitly annotating some known ObjC methods. (#1617)](https://github.com/material-components/material-components-ios/commit/1e14d4109178956486863dec607996100c91795e) (Martin Petrov)
* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)

### Buttons

#### Changes

* [Elevation clean up (#1574)](https://github.com/material-components/material-components-ios/commit/eec61cf77316c2853f52070931cb8472a1ced48e) (Sam Morrison)
* [Explicitly annotating some known ObjC methods. (#1617)](https://github.com/material-components/material-components-ios/commit/1e14d4109178956486863dec607996100c91795e) (Martin Petrov)
* [Ink should ignore content edge insets (#1593)](https://github.com/material-components/material-components-ios/commit/cc57a0791890b07cd268da8f3950cb74b4729825) (Robert Moore)
* [Remove NS_UNAVAILABLE from setBackgroundColor (#1572)](https://github.com/material-components/material-components-ios/commit/467b843b169d07f8d71ea8d4dc55df7b03ac7900) (Sam Morrison)
* [Remove trailing spaces from test (#1602)](https://github.com/material-components/material-components-ios/commit/418a5a65fceaadb669a87646c5b17ac53b77e39b) (Sam Morrison)
* [Sort property/method definitions (#1599)](https://github.com/material-components/material-components-ios/commit/360d504442fe1b5cd80a3923e9c875e6c58d0adf) (Sam Morrison)

### CollectionCells

#### Changes

* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)
* [Reset cells in prepareForReuse (#1633)](https://github.com/material-components/material-components-ios/commit/25b7c217ca3ed0d082abb4406c400cd8405d63ee) (Robert Moore)

### Collections

#### Changes

* [Do not invalidate layout for all gesture beginning (#1623)](https://github.com/material-components/material-components-ios/commit/0b905c647d3267ca0d3332226fbf806a5c538bb1) (Gauthier Ambard)
* [Fallback to default cell background color on nil. (#1630)](https://github.com/material-components/material-components-ios/commit/3c92cfe80c6a8b795f52b1baaf6525e0624d433d) (Yurii Samsoniuk)
* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)

### Dialogs

#### Changes

* [Explicitly annotating some known ObjC methods. (#1617)](https://github.com/material-components/material-components-ios/commit/1e14d4109178956486863dec607996100c91795e) (Martin Petrov)
* [[Docs] Replaced internal site references with public equivalents. (#1616)](https://github.com/material-components/material-components-ios/commit/0abca36dbbc455c42795efe7e207419b2f1b6e5b) (Adrian Secord)
* [[KeyboardWatcher] iOS 8 simplification and cleanup (#1589)](https://github.com/material-components/material-components-ios/commit/87574e57e313cb3e90281b3225031b329e8f91de) (ianegordon)

### FeatureHighlight

#### Changes

* [[Docs] Replaced internal site references with public equivalents. (#1616)](https://github.com/material-components/material-components-ios/commit/0abca36dbbc455c42795efe7e207419b2f1b6e5b) (Adrian Secord)

### FlexibleHeader

#### Changes

* [- Updated unit tests (#1619)](https://github.com/material-components/material-components-ios/commit/921241302a7e3f92c8941bf52c6d50f8aaeaf2a2) (Justin Shephard)

### Ink

#### Changes

* [[Docs] Replaced internal site references with public equivalents. (#1616)](https://github.com/material-components/material-components-ios/commit/0abca36dbbc455c42795efe7e207419b2f1b6e5b) (Adrian Secord)

### NavigationBar

#### Changes

* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)

### PageControl

#### Changes

* [Explicitly annotating some known ObjC methods. (#1617)](https://github.com/material-components/material-components-ios/commit/1e14d4109178956486863dec607996100c91795e) (Martin Petrov)
* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)

### ProgressView

#### Changes

* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)

### ShadowLayer

#### Changes

* [Explicitly annotating some known ObjC methods. (#1617)](https://github.com/material-components/material-components-ios/commit/1e14d4109178956486863dec607996100c91795e) (Martin Petrov)
* [Support layer copying (#1625)](https://github.com/material-components/material-components-ios/commit/2283e04f02fe15588e95ed7564e53abeef926cba) (Robert Moore)

### Slider

#### Changes

* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)

### Snackbar

#### Changes

* [[KeyboardWatcher] iOS 8 simplification and cleanup (#1589)](https://github.com/material-components/material-components-ios/commit/87574e57e313cb3e90281b3225031b329e8f91de) (ianegordon)

### Tabs

#### Changes

* [Constrain tabs to the view's width (#1615)](https://github.com/material-components/material-components-ios/commit/00ee81453977901ca03ef987d229a20ca51cba06) (Brian Moore)
* [Explicitly annotating some known ObjC methods. (#1617)](https://github.com/material-components/material-components-ios/commit/1e14d4109178956486863dec607996100c91795e) (Martin Petrov)
* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)
* [Restore initial tab selection behavior (#1605)](https://github.com/material-components/material-components-ios/commit/60db284cb2803e873a4a03ba9a57d1a2ab8b6226) (Brian Moore)

### TextFields

#### Changes

* [Explicitly annotating some known ObjC methods. (#1617)](https://github.com/material-components/material-components-ios/commit/1e14d4109178956486863dec607996100c91795e) (Martin Petrov)
* [Fixes for minor bugs and comment improvements (#1588)](https://github.com/material-components/material-components-ios/commit/6b2cddba39c78b66d1401c6d280632de5857c940) (Will Larche)
* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)
* [[TextField] Update demo alert to indicate floating setting. (#1612)](https://github.com/material-components/material-components-ios/commit/7a26712eb96036e416b1937752ac6b164ebac1fc) (Donna McCulloch)

### Typography

#### Changes

* [Remove uses of `typeof` and the `?:` operator (#1601)](https://github.com/material-components/material-components-ios/commit/fa10d655d7f42f9e564636deb6f32573c3975cfe) (Robert Moore)

# 26.0.0

## API diffs

### ActivityIndicator

* Setting 'cycleColors' to an empty array now sets 'cycleColors' to the default cycle colors.

### BottomSheet

* New component for presenting a view controller as a bottom sheet.

### Buttons

* New subcomponent MDCButtonTitleColorAccessibilityMutator for enforcing title/background color contrast.

### Dialogs

* 'UIViewController+MaterialDialogs' property 'mdc_dialogPresentationController' now has the nullability annotation of nullable.

### TextFields

* 'MDCTextInputController' renamed to 'MDCTextInputControllerDefault'
* Added 'MDCTextInputController' protocol
* Removed 'presentationStyle' property from MDCTextInputController
* Added 'MDCTextInputControllerFullWidth'

## Component changes

### ActivityIndicator

#### Changes

* [Default cycleColors property for empty arrays #1508 (#1540)](https://github.com/material-components/material-components-ios/commit/8be69aecb9f5ff70d526317a5f7685a94f9e042b) (Robert Moore)
* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### AnimationTiming

#### Changes

* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### AppBar

#### Changes

* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### BottomSheet

#### Changes

* [[Bottom sheet] component (#1297)](https://github.com/material-components/material-components-ios/commit/681b2de2fd9b9b30546e9f84ee3b8391f682c21c) (Sam Morrison)

### ButtonBar

#### Changes

* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### Buttons

#### Changes

* [Button title color accessibility mutator (#1567)](https://github.com/material-components/material-components-ios/commit/70cfb2bc6edce5ef951a17ded3d975cf95afa7d0) (Randall Li)
* [Call designated initializer in init methods (#1553)](https://github.com/material-components/material-components-ios/commit/8a98e74d9cb99b8f7dceaab2d4c958023265762b) (ianegordon)
* [[Swift] Fixing swift style errors (#1577)](https://github.com/material-components/material-components-ios/commit/f879c91a9073433d59ee851916310359ca86fb7c) (Will Larche)
* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### Dialogs

#### Changes

* [Add nullability annotation (#1544)](https://github.com/material-components/material-components-ios/commit/4e3c62ba2fbac8dc9ae04dee78eb6eb4574a533e) (ianegordon)
* [[Themer] Support alert color themer in iOS 8 (#1569)](https://github.com/material-components/material-components-ios/commit/695b2dc3ece5c6351e45472b61ff1b8fecba6ab7) (Junius Gunaratne)

### FeatureHighlight

#### Changes

* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### FlexibleHeader

#### Changes

* [[Swift] Fixing swift style errors (#1577)](https://github.com/material-components/material-components-ios/commit/f879c91a9073433d59ee851916310359ca86fb7c) (Will Larche)
* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### HeaderStackView

#### Changes

* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### NavigationBar

#### Changes

* [[Swift] Fixing swift style errors (#1577)](https://github.com/material-components/material-components-ios/commit/f879c91a9073433d59ee851916310359ca86fb7c) (Will Larche)
* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### Slider

#### Changes

* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### Snackbar

#### Changes

* [Resuming messages when tokens are deallocated (#1551)](https://github.com/material-components/material-components-ios/commit/50319d0edb2bb5b3bcfa2c9a34938a924d455eaa) (Robert Moore)
* [[Swift] Fixing swift style errors (#1577)](https://github.com/material-components/material-components-ios/commit/f879c91a9073433d59ee851916310359ca86fb7c) (Will Larche)

### Tabs

#### Changes

* [Reposition the Ink layer in ItemBar cells (#1554)](https://github.com/material-components/material-components-ios/commit/a68a5531935ad1fae496266732b63482deb481dd) (Robert Moore)
* [[ButtonBar] Restoring ink to the top of the cell (#1584)](https://github.com/material-components/material-components-ios/commit/6858f4b0938b83a9cf67c1ce47658aefe5fd2ed0) (Robert Moore)
* [[Swift] Fixing swift style errors (#1577)](https://github.com/material-components/material-components-ios/commit/f879c91a9073433d59ee851916310359ca86fb7c) (Will Larche)
* [[Themes] Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

### TextFields

#### Changes

* [Fix for missing guard from presentationStyles to controller classes refactor. (#1579)](https://github.com/material-components/material-components-ios/commit/68535ad5a9280b4927268b18d9ab771a2b3ba72f) (Will Larche)
* [Fix of minor details and PR comments (#1585)](https://github.com/material-components/material-components-ios/commit/ba85bd03ed123323273cff285ab831d95b234fb1) (Will Larche)
* [Fix text fields placeholder Y preset (#1581)](https://github.com/material-components/material-components-ios/commit/3fdbdea8d99ddb60ac7822d7c24e94eea6bc212f) (Will Larche)
* [Presentation styles to controller classes (#1549)](https://github.com/material-components/material-components-ios/commit/13dcb5746bd2d3f50bbe9d2a289efe0ed2aa2d6b) (Will Larche)
* [[Swift] Fixing swift style errors (#1577)](https://github.com/material-components/material-components-ios/commit/f879c91a9073433d59ee851916310359ca86fb7c) (Will Larche)

### Themes

#### Changes

* [Add ability to change catalog theme (#1477)](https://github.com/material-components/material-components-ios/commit/2873e798f28f70d4808b9c6bdba9fd0cea7fe2c9) (Junius Gunaratne)

# 25.1.1

Hotfix: Cherry picked: [[Buttons] Call designated initializer in init methods](https://github.com/material-components/material-components-ios/pull/1553)

## Component changes

### Buttons

#### Changes

* [Call designated initializer in init methods (#1553)](https://github.com/material-components/material-components-ios/commit/6f2709de8c8cfd2874934abf293cb7e9b2864368) (ianegordon)

# 25.1.0

#### Changes

## API diffs

### Buttons

* Added 'init' method in MDCFloatingButton

### TextFields

* Added properties 'underlineColorNormal', 'underlineColorActive','errorText' properties in MDCTextInputController
* Changed nullabilitity attributes on 'floatingPlaceholdColor' & 'inlinePlaceholderColor' from nullable to null_resettable
* Added class 'MDCTextInputUnderlineView'
* Added properties 'disabledUnderline', 'underline', 'color', 'lineHeight', 'enabled' in MDCTextInputUnderlineView
* Added 'sizeThatFIts:defaultSize:' method to MDCTextFieldPositioningDelegate

## Component changes

### ActivityIndicator

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### AppBar

#### Changes

* [[Themers] Add app bar color themer (#1503)](https://github.com/material-components/material-components-ios/commit/cda52f4e6b29f0ed72a4de47974c603970bfe142) (Junius Gunaratne)

### ButtonBar

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)
* [[Themers] Add app bar color themer (#1503)](https://github.com/material-components/material-components-ios/commit/cda52f4e6b29f0ed72a4de47974c603970bfe142) (Junius Gunaratne)

### Buttons

#### Changes

* [Add -Wstrict-prototypes and fix errors. (#1532)](https://github.com/material-components/material-components-ios/commit/4dba0dfff81e2c2a9073cb29a30f228f02938d49) (Adrian Secord)
* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)
* [Make sure that MDCButton has the proper init methods. (#1542)](https://github.com/material-components/material-components-ios/commit/ee2880881ae374e2fbde39002e4323dabea8420a) (Randall Li)
* [[mdcbutton] Using UIAppearance to set the default background color for the normal state.](https://github.com/material-components/material-components-ios/commit/6670e7409f8fc3ecadbcc18a12de781f16569798) (randallli)
* [Button appearance (#1502)](https://github.com/material-components/material-components-ios/commit/b18aaff93e62ab853e0930867c90da3339cfb2d8) (Randall Li)
* [Revert "Button appearance (#1502)" (#1504)](https://github.com/material-components/material-components-ios/commit/9db80b68b05969f5ab7fdeeab8806fc34f57a2a1) (Randall Li)
* [Reverted MDCButton changes from Component Themer change: (#1490)](https://github.com/material-components/material-components-ios/commit/4128a44538e25c2ba19f627b9a96cffe568f1cad) (Randall Li)
* [[Button] Calling commonMDCButtonInit from init. (#1501)](https://github.com/material-components/material-components-ios/commit/6217edab9e7eba9d5da5fee531211e09f2a2bda2) (Randall Li)


### CollectionCells

#### Changes

* [Add -Wstrict-prototypes and fix errors. (#1532)](https://github.com/material-components/material-components-ios/commit/4dba0dfff81e2c2a9073cb29a30f228f02938d49) (Adrian Secord)
* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### Collections

#### Changes

* [Add -Wstrict-prototypes and fix errors. (#1532)](https://github.com/material-components/material-components-ios/commit/4dba0dfff81e2c2a9073cb29a30f228f02938d49) (Adrian Secord)
* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### Dialogs

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### FeatureHighlight

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)
* [[Feature Highlight] Rotation fixes and animation improvement (#1505)](https://github.com/material-components/material-components-ios/commit/0a102db99bddceefadb0f7bce9474be6180ae0cd) (Sam Morrison)

### FlexibleHeader

#### Changes

* [Add -Wstrict-prototypes and fix errors. (#1532)](https://github.com/material-components/material-components-ios/commit/4dba0dfff81e2c2a9073cb29a30f228f02938d49) (Adrian Secord)
* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)
* [Remove unused function from example. (#1527)](https://github.com/material-components/material-components-ios/commit/3cba5ed8b39e88d88d6d21bf0dd11bf6de123ec8) (Adrian Secord)

### HeaderStackView

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### Ink

#### Changes

* [Add -Wstrict-prototypes and fix errors. (#1532)](https://github.com/material-components/material-components-ios/commit/4dba0dfff81e2c2a9073cb29a30f228f02938d49) (Adrian Secord)
* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### NavigationBar

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### OverlayWindow

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### PageControl

#### Changes

* [Add -Wstrict-prototypes and fix errors. (#1532)](https://github.com/material-components/material-components-ios/commit/4dba0dfff81e2c2a9073cb29a30f228f02938d49) (Adrian Secord)
* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### ProgressView

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### Slider

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### Snackbar

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### Tabs

#### Changes

* [Add -Wstrict-prototypes and fix errors. (#1532)](https://github.com/material-components/material-components-ios/commit/4dba0dfff81e2c2a9073cb29a30f228f02938d49) (Adrian Secord)
* [Added implementation for accessibilityElementForItem:](https://github.com/material-components/material-components-ios/commit/f78fd30242241fa051c882077791b340cb113a6b) (brianjmoore)
* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

### TextFields

#### Changes

* [Adding missing implementations of properties (#1528)](https://github.com/material-components/material-components-ios/commit/448153d7154dc829f1287a7e19d0fb8fdd54f16a) (Will Larche)
* [Corrections to height and frame and better manual layout support (#1525)](https://github.com/material-components/material-components-ios/commit/484a82cd8dbfcdcf490f0aee1c1c12c2dd348dcd) (Will Larche)
* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)
* [Underline color customization (#1537)](https://github.com/material-components/material-components-ios/commit/d085183658a5d88c8e57567ca6a7b8034599c26c) (Will Larche)

### Typography

#### Changes

* [Fix imports to use umbrella imports (#1529)](https://github.com/material-components/material-components-ios/commit/266a716f6096857dc6970e031e23c2c85a6e4f83) (Randall Li)

# 25.0.1

Hotfix: Added implementation for accessibilityElementForItem: for MDCTabBar

# 25.0.0

## API diffs

### FeatureHighlight

* Added properties 'bodyColor' and 'titleColor' in MDCFeatureHighlightView
* Added 'nullable' nullability specifiers to 'innerHighlightColor', 'outerHighlightColor'
* Added properties 'bodyCOlor' and 'titleColor' in MDCFeatureHighlightViewController

### Palettes

* Remove 'redPalette','pinkPalette','purplePalette','deepPurplePalette','indigoPalette','bluePalette',
    'lightBluePalette','cyanPalette','tealPalette','greenPalette','lightGreenPalette','limePalette',
    'yellowPalette','amberPalette','orangePalette','deepOrangePalette','brownPalette','greyPalette',
    'blueGreyPalette' class methods from MDCPalette in favor of class properties

## Component changes

### FeatureHighlight

#### Changes

* [[Feature Highlight] Expose title and body color properties (#1496)](https://github.com/material-components/material-components-ios/commit/a43472d2497836d12b70782b65b17788cf05efd0) (Sam Morrison)

### Palettes

#### Changes

* [Removing palette (#1500)](https://github.com/material-components/material-components-ios/commit/f71cd14b5b3ec3cf123e327bba875faf8ebf8f56) (Martin Petrov)

# 24.0.2

Hotfix: Fixed missing bump of version numbers.

# 24.0.1

Hotfix: Added missing dependencies in our podspec from ColorThemer subspecs to Component subspecs.

# 24.0.0

## API diffs

### Palettes

* Added typedef for NSString so we can differentiate tints from accents
* Added more palettes: Red, Pink, Purple etc.

### Tabs

* MDCTabBarDelegate conforms to UIBarPositioningDelegate protocol.
* Added MDCTabBarViewController.

### TextFields

* New Component: Single line text input.

### Themes

* ColorScheme colors are now nonnull, readonly
* New classes: TonalColorScheme, TonalPalette

## Component changes

### ActivityIndicator

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)
* [Exposed enum and private method to be used for subclassing (#1481)](https://github.com/material-components/material-components-ios/commit/9a08ecaa5c2cc5bf040418607d7767b40ec5123e) (Justin Shephard)

### ButtonBar

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### Buttons

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### Dialogs

#### Changes

* [![ColorThemer] Reorganize source to create separate targets for each color themer. (#1466)](https://github.com/material-components/material-components-ios/commit/1c7ca931421d45dbddd703aaf1bbea474f28afe0) (Randall Li)
* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)
* [Shorten transition duration (#1465)](https://github.com/material-components/material-components-ios/commit/eb9351d1c3fdb1e981b679c0a40e7d803d1c32f6) (ianegordon)
* [[MDCPalette] Use class properties (#1470)](https://github.com/material-components/material-components-ios/commit/ec1feb81a5701e1b6dd7c368b593ef7b1e77e12f) (Martin Petrov)

### FeatureHighlight

#### Changes

* [![ColorThemer] Reorganize source to create separate targets for each color themer. (#1466)](https://github.com/material-components/material-components-ios/commit/1c7ca931421d45dbddd703aaf1bbea474f28afe0) (Randall Li)
* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)
* [[Feature Highlight] Restore innerHighlightColor setter and fix null_resettable colors (#1485)](https://github.com/material-components/material-components-ios/commit/984135f874ec156a6a1d51b517aaae5e00945dfc) (Sam Morrison)
* [[MDCPalette] Use class properties (#1470)](https://github.com/material-components/material-components-ios/commit/ec1feb81a5701e1b6dd7c368b593ef7b1e77e12f) (Martin Petrov)

### FlexibleHeader

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### HeaderStackView

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### Ink

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### NavigationBar

#### Changes

* [- Update handling of center-aligned titles (#1479)](https://github.com/material-components/material-components-ios/commit/d1c2a32339ef9fba687c0f031e3de601670e89c1) (Justin Shephard)
* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### PageControl

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### Palettes

#### Changes

* [[MDCPalette] Use class properties (#1470)](https://github.com/material-components/material-components-ios/commit/ec1feb81a5701e1b6dd7c368b593ef7b1e77e12f) (Martin Petrov)
* [[Palette] Swift enums for MDCPaletteTint/Accent. (#1469)](https://github.com/material-components/material-components-ios/commit/49ed5eb513c5e757d2f5f00bd50b840953e5091b) (Martin Petrov)

### ProgressView

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)
* [[MDCPalette] Use class properties (#1470)](https://github.com/material-components/material-components-ios/commit/ec1feb81a5701e1b6dd7c368b593ef7b1e77e12f) (Martin Petrov)

### Slider

#### Changes

* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### Snackbar

#### Changes

* [[Testing] Interaction tests infrastructure (#1473)](https://github.com/material-components/material-components-ios/commit/2fa4850f4edd4a0e0cf75cd23acf860508e3e385) (Will Larche)

### Tabs

#### Changes

* [Add MDCTabViewController (#1482)](https://github.com/material-components/material-components-ios/commit/f88dc55511d1d634ee6e84208b8f22fdf681f19e) (ianegordon)
* [Bottom navigation support (#1411)](https://github.com/material-components/material-components-ios/commit/a680e30a567d64c586bf0a80f564063e014db02d) (Brian Moore)
* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)
* [[MDCPalette] Use class properties (#1470)](https://github.com/material-components/material-components-ios/commit/ec1feb81a5701e1b6dd7c368b593ef7b1e77e12f) (Martin Petrov)

### TextFields

#### Changes

* [Correcting broken image in readme. (#1489)](https://github.com/material-components/material-components-ios/commit/8c5f0a8846ee3767ea2d4a40f89fadb906e89b55) (Will Larche)
* [Single line text fields (#1318)](https://github.com/material-components/material-components-ios/commit/acf47c10d1bec3ab632adf87c8f5e18cfbaee421) (Will Larche)

### Themes

#### Changes

* [![ColorThemer] Reorganize source to create separate targets for each color themer. (#1466)](https://github.com/material-components/material-components-ios/commit/1c7ca931421d45dbddd703aaf1bbea474f28afe0) (Randall Li)
* [Add support for material design tonal palettes (#1471)](https://github.com/material-components/material-components-ios/commit/5d24dca8835dc1e76e89be61f87a88ba2cb60810) (Junius Gunaratne)
* [Component themers and usage example for catalog (#1443)](https://github.com/material-components/material-components-ios/commit/71d441a065316430d1f13f7a5cbc47ed62ecfbd3) (Junius Gunaratne)

### Typography

#### Changes

* [MDCPreferredFontForStyle now includes the system font family. (#1472)](https://github.com/material-components/material-components-ios/commit/843675b37482a89cb7a587fe556cde512b1a0183) (ianegordon)

# 23.4.1

Fixed podspec

## Component changes

### Buttons

#### Changes

* [Revert "Fix case-sensitive imports from private to Private. Causing compilation failures in Xcode 8.3.2 about non-portable path."](https://github.com/material-components/material-components-ios/commit/9cae7fca7bcd490a921c5ca1aacbd585cd61a021) (randallli)

### Typography

#### Changes

* [Revert "Fix case-sensitive imports from private to Private. Causing compilation failures in Xcode 8.3.2 about non-portable path."](https://github.com/material-components/material-components-ios/commit/9cae7fca7bcd490a921c5ca1aacbd585cd61a021) (randallli)

# 23.4.0

## API diffs

### FeatureHighlight

Made MDCFeatureHighlightView public with two properties: innerHighlightColor and outerHighlightColor.

## Component changes

### ActivityIndicator

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)
* [[catalog] Restyle Activity Indicator example (#1433)](https://github.com/material-components/material-components-ios/commit/3ae88076c727611c6549ff00a1c8381abaeb6ba2) (Alastair Tse)

### AnimationTiming

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### AppBar

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### ButtonBar

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Buttons

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### CollectionCells

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### CollectionLayoutAttributes

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Collections

#### Changes

* [Fixes SwipeToDismiss ability to swipe when not editing. Closes #1207, #1300, #1301. (#1427)](https://github.com/material-components/material-components-ios/commit/33ceb64ee60fd6817454ee473667e73d396fff38) (Chris Cox)
* [Fixes indent. (#1428)](https://github.com/material-components/material-components-ios/commit/52ea84adbd4e0bd77fb31cc98eec22091b904a91) (Chris Cox)
* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Dialogs

#### Changes

* [Adding MDC themes (#1401)](https://github.com/material-components/material-components-ios/commit/0cb6ce6d5f989e9827e39af1b857ca80c9de7081) (Junius Gunaratne)
* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### FeatureHighlight

#### Changes

* [Keep feature highlight view implementation in private with limited public properties (#1422)](https://github.com/material-components/material-components-ios/commit/6d8f757609ab8788c4ed4b1defaa68ef1937e98e) (Junius Gunaratne)
* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### FlexibleHeader

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### HeaderStackView

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Ink

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### NavigationBar

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### PageControl

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Palettes

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### ProgressView

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### ShadowElevations

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### ShadowLayer

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Slider

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Snackbar

#### Changes

* [Add accessibilityHint to MDCSnackbarMessage actions (#1449)](https://github.com/material-components/material-components-ios/commit/7272a1ece883b14a0d57ea8fb587cf77f64f7c9c) (Sam Morrison)
* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Tabs

#### Changes

* [MDCTabBar should not crash if the selection is reset to nil. or array set to empty. Fix. (#1434)](https://github.com/material-components/material-components-ios/commit/2a95590d4ee580fa9afec06b7c66bfe5dd772f61) (David Phillip Oster)
* [Revert "Disallow tabs that are wider than the screen (#1408)" (#1431)](https://github.com/material-components/material-components-ios/commit/c76549c287d74b401a99b457a25878d1f03862c6) (Brian Moore)
* [Until you select an item in MDCTabBar, it should be in the unselected state. Fixed. (#1441)](https://github.com/material-components/material-components-ios/commit/be6888729216d9411579aea37f24b818eb7892b5) (David Phillip Oster)
* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

### Themes

#### Changes

* [Adding MDC themes (#1401)](https://github.com/material-components/material-components-ios/commit/0cb6ce6d5f989e9827e39af1b857ca80c9de7081) (Junius Gunaratne)

### Typography

#### Changes

* [[Docs] Adds API documentation roots and tidies up here and there. (#1425)](https://github.com/material-components/material-components-ios/commit/eed028eacbbee04170f15529ad721fe30bfdffdd) (Scott Hyndman)

# 23.3.0

## API diffs

* No API changes.

## Component changes

### FlexibleHeader

#### Changes

* [Fixes issue where the rotation animation was broken for any GOOHeaderViewController child’s view.](https://github.com/material-components/material-components-ios/commit/65ed2b4872177e3de64e7a9725388bd61358c58b) (Material Components iOS Team)

# 23.2.0

## API diffs

* No API changes.

## Component changes

### ActivityIndicator

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### AnimationTiming

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### AppBar

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### ButtonBar

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Buttons

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### CollectionCells

#### Changes

* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### CollectionLayoutAttributes

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Collections

#### Changes

* [[Docs] Fixes a couple broken links. (#1418)](https://github.com/material-components/material-components-ios/commit/80dab378de07b5b9f1457020fde41d43d1766859) (Scott Hyndman)
* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Dialogs

#### Changes

* [Update alert body text opacity (#1415)](https://github.com/material-components/material-components-ios/commit/5a2702999d6e7193cb6f98b539d75db2d109c921) (ianegordon)
* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### FeatureHighlight

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### FlexibleHeader

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### HeaderStackView

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Ink

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### NavigationBar

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### OverlayWindow

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### PageControl

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Palettes

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### ProgressView

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### ShadowElevations

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### ShadowLayer

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Slider

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Snackbar

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Tabs

#### Changes

* [[Docs] Added Tabs one-liner description.](https://github.com/material-components/material-components-ios/commit/ad1e1033a118ee6c472f6082c618e1cc56f71917) (Adrian Secord)
* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

### Typography

#### Changes

* [[Docs] Misc. cleanup (#1403)](https://github.com/material-components/material-components-ios/commit/1bec0a903a273b52836def8556c17a2b826b06a2) (Scott Hyndman)
* [[Docs] Nests components in the navigation as spec'd. (#1404)](https://github.com/material-components/material-components-ios/commit/1571a1b9ee6fd59a828860fab74a747a325214e9) (Scott Hyndman)

# 23.1.0

## API diffs

### Collections

#### Changes

Make [MDCCollectionViewController cellWidthAtSectionIndex:] public.

## Component changes

### ActivityIndicator

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Junius' Screenshots (#1393)](https://github.com/material-components/material-components-ios/commit/6cb4269240bac5b4ed98827070b2855ae8aed9da) (ianegordon)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [Remove remaining MP4s and markup. (#1396)](https://github.com/material-components/material-components-ios/commit/555476cf89f03a7a432489604286be1ad5ceb24b) (Adrian Secord)
* [Update screenshot widths](https://github.com/material-components/material-components-ios/commit/e9630689f0be39fcc1df00fd78fc5ce5dc9c990c) (Junius Gunaratne)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### AnimationTiming

#### Changes

* [Added a link to the motion spec in the AnimationTiming README. (#1319)](https://github.com/material-components/material-components-ios/commit/92db31da5c115510c9b29be058f77434998fa9a7) (Scott Hyndman)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Junius' Screenshots (#1393)](https://github.com/material-components/material-components-ios/commit/6cb4269240bac5b4ed98827070b2855ae8aed9da) (ianegordon)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### AppBar

#### Changes

* [& [FeatureHighlight] - Remove references to g3 (#1349)](https://github.com/material-components/material-components-ios/commit/acd8d38dc54babbaf58969a2554164745c61cbb5) (Justin Shephard)
* [- Removed Video from Readme (#1390)](https://github.com/material-components/material-components-ios/commit/4a879d363474b322f6ca64a965a28eb5291dfb61) (Justin Shephard)
* [- Update docs photo (#1374)](https://github.com/material-components/material-components-ios/commit/94ed673c2ae0812c6f524162a042f1b40b430f10) (Justin Shephard)
* [- Update readme docs (#1379)](https://github.com/material-components/material-components-ios/commit/6e54a23b74d81bb119f7edb7af6878b8d757a517) (Justin Shephard)
* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [Updated accessibility label on back button (#1334)](https://github.com/material-components/material-components-ios/commit/00009b2106a72e306773af8219e9ccd79fd61487) (Justin Shephard)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### ButtonBar

#### Changes

* [- Removed Video File and updated Readme (#1395)](https://github.com/material-components/material-components-ios/commit/01669183e34d6af48b3911ef40fe6c6bea5036de) (Justin Shephard)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Site] Catalog colors (#1377)](https://github.com/material-components/material-components-ios/commit/653aec06e954ab11db09ac20c0bfd21c2de769cb) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Buttons

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Buttons, Page Control, Typography] Fixed screenshots (#1380)](https://github.com/material-components/material-components-ios/commit/d48a3dae3edd56b2c0f86f0d6d751cb2ae2da91c) (Randall Li)
* [[Buttons, Page Control, Typography] Removed video demos (#1387)](https://github.com/material-components/material-components-ios/commit/d7cf7999eded279d660abaed7c37e14299d3334f) (Randall Li)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Math] New private math component (#1325)](https://github.com/material-components/material-components-ios/commit/ff5d16586947158e743eec1cc6da949662f0d7c0) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### CollectionCells

#### Changes

* [Added new screenshot for CollectionCells. (#1381)](https://github.com/material-components/material-components-ios/commit/fd3bca404082749f354d44fb729a971d85200a98) (Adrian Secord)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Math] New private math component (#1325)](https://github.com/material-components/material-components-ios/commit/ff5d16586947158e743eec1cc6da949662f0d7c0) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### CollectionLayoutAttributes

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Collections

#### Changes

* [Eliminate static analyzer warnings. Simplify Collection supplementary views (#1316)](https://github.com/material-components/material-components-ios/commit/f018e09afe4c0a1d73d20993d0b2283638dfbdcd) (ianegordon)
* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Temporarily expose cellWidthAtSection: in MDCCollectionViewController.h  (#1358)](https://github.com/material-components/material-components-ios/commit/3a4c859f376618e6b33533b2ebe21bcc26e81ef9) (Felix Emiliano)
* [Updated screenshot. (#1383)](https://github.com/material-components/material-components-ios/commit/b2b433f3662220c6d06d81d8ecf8ad78b0e8d34e) (Adrian Secord)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Dialogs

#### Changes

* [Fix AlertController rotation layout (#1306)](https://github.com/material-components/material-components-ios/commit/74e6232777c3d10600bffaee5b1127d9de60baa3) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [Screenshot (#1376)](https://github.com/material-components/material-components-ios/commit/0489e474e9f5db915e4ed9b23e3ec9be23e0467d) (ianegordon)
* [[All] Formatting. (#1329)](https://github.com/material-components/material-components-ios/commit/d8a58feecd69219be8f1f7cc15e98ee0d19f5d49) (Will Larche)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### FeatureHighlight

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [[All] Formatting. (#1329)](https://github.com/material-components/material-components-ios/commit/d8a58feecd69219be8f1f7cc15e98ee0d19f5d49) (Will Larche)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[AppBar] & - Remove references to g3 (#1349)](https://github.com/material-components/material-components-ios/commit/acd8d38dc54babbaf58969a2554164745c61cbb5) (Justin Shephard)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Feature Highlight] Updated screenshot (#1385)](https://github.com/material-components/material-components-ios/commit/b30161df41415824c06b5b2b97710c833f7d5e12) (Sam Morrison)
* [[Feature highlight] Accessibility fixes (#1284)](https://github.com/material-components/material-components-ios/commit/2a47d187edc7a4aec4566641730042fd00df114b) (Sam Morrison)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### FlexibleHeader

#### Changes

* [- Correct use of deprecated property in docs (#1340)](https://github.com/material-components/material-components-ios/commit/9c3f162125a0c2af06877bbe3e9743d150c00c00) (Justin Shephard)
* [- Remove video file and updated readme (#1394)](https://github.com/material-components/material-components-ios/commit/f96c040c7ee61b38e4c3d5104315f8cc2cb56c5f) (Justin Shephard)
* [- Update readme doc (#1378)](https://github.com/material-components/material-components-ios/commit/73c83f22871f39dff753995a5697d04380c85cf0) (Justin Shephard)
* [- Updated doc pic (#1375)](https://github.com/material-components/material-components-ios/commit/7c5586f1caa7f67fda2d190c23f71780c6b216f5) (Justin Shephard)
* [Ensure the MDCFlexibleHeaderView adheres to UIAppearance proxy if set (#1326)](https://github.com/material-components/material-components-ios/commit/92240a337deeec844ce53061eb289c472168202e) (Justin Shephard)
* [Fix Swift example in the FlexibleHeader docs (#1354)](https://github.com/material-components/material-components-ios/commit/d0210fa20a460fa1185f96048b9f7c4c80394b06) (Alastair Tse)
* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### HeaderStackView

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[HeaderStack] - Remove video from Readme (#1391)](https://github.com/material-components/material-components-ios/commit/ebcb49dc14d64c80ccd5cc03c95081e7c81f7a3b) (Justin Shephard)
* [[Site] Catalog colors (#1377)](https://github.com/material-components/material-components-ios/commit/653aec06e954ab11db09ac20c0bfd21c2de769cb) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Ink

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Junius' Screenshots (#1393)](https://github.com/material-components/material-components-ios/commit/6cb4269240bac5b4ed98827070b2855ae8aed9da) (ianegordon)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [Remove remaining MP4s and markup. (#1396)](https://github.com/material-components/material-components-ios/commit/555476cf89f03a7a432489604286be1ad5ceb24b) (Adrian Secord)
* [Update screenshot widths](https://github.com/material-components/material-components-ios/commit/e9630689f0be39fcc1df00fd78fc5ce5dc9c990c) (Junius Gunaratne)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### NavigationBar

#### Changes

* [- Remove Video (#1392)](https://github.com/material-components/material-components-ios/commit/c4a33b3b5fdda1cba4547751310829cab008fdc0) (Justin Shephard)
* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Math] New private math component (#1325)](https://github.com/material-components/material-components-ios/commit/ff5d16586947158e743eec1cc6da949662f0d7c0) (Will Larche)
* [[Site] Catalog colors (#1377)](https://github.com/material-components/material-components-ios/commit/653aec06e954ab11db09ac20c0bfd21c2de769cb) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### OverlayWindow

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### PageControl

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Buttons, Page Control, Typography] Fixed screenshots (#1380)](https://github.com/material-components/material-components-ios/commit/d48a3dae3edd56b2c0f86f0d6d751cb2ae2da91c) (Randall Li)
* [[Buttons, Page Control, Typography] Removed video demos (#1387)](https://github.com/material-components/material-components-ios/commit/d7cf7999eded279d660abaed7c37e14299d3334f) (Randall Li)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Palettes

#### Changes

* [Added Palettes screenshot. (#1373)](https://github.com/material-components/material-components-ios/commit/3dcb30a6eba5f96deec2ee2e76c0e13eec11ac86) (Adrian Secord)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### ProgressView

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Updates ProgressView to use MDCMath. (#1328)](https://github.com/material-components/material-components-ios/commit/d9b7b2f69f5d0f3bb24b2cff5b9811e09b3a9787) (Louis Romero)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Progress view] Updated screenshot (#1384)](https://github.com/material-components/material-components-ios/commit/e87a24febee47a538a6bc8bdd8857b833f9b7174) (Sam Morrison)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### ShadowElevations

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Shadows] Screenshot (#1382)](https://github.com/material-components/material-components-ios/commit/9599118c1ba4af03185e34b5ca3d5482936c7e71) (ianegordon)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### ShadowLayer

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Screenshot (#1389)](https://github.com/material-components/material-components-ios/commit/fc4f2b763a89b5b2f18c4c2ade109b3723806daa) (ianegordon)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Slider

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Updated screenshot (#1386)](https://github.com/material-components/material-components-ios/commit/8321bede0888bbf967ffbc4ffe969fd6f336ff17) (Sam Morrison)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Snackbar

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [Updated screenshot (#1388)](https://github.com/material-components/material-components-ios/commit/5e7d2ebbc76c4ba81aa6bc161fc920e6089ba030) (Sam Morrison)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Tabs

#### Changes

* [Corrections for readme (#1294)](https://github.com/material-components/material-components-ios/commit/7a0e7de88a82262c8f86755124f32268796aff38) (Will Larche)
* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Minor Tweaks to address internal feedback. (#1312)](https://github.com/material-components/material-components-ios/commit/a749a98b4f27652a87527bdd7598ea30e54dd5f2) (ianegordon)
* [Monochromatic sweep of all catalog components (#1370)](https://github.com/material-components/material-components-ios/commit/4a46c8c19e3df6f4c353057a67f34f446441b3a4) (Alastair Tse)
* [Remove remaining MP4s and markup. (#1396)](https://github.com/material-components/material-components-ios/commit/555476cf89f03a7a432489604286be1ad5ceb24b) (Adrian Secord)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Site] Catalog colors (#1377)](https://github.com/material-components/material-components-ios/commit/653aec06e954ab11db09ac20c0bfd21c2de769cb) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Typography

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Workaround for medium system font on iOS 8 (#1292)](https://github.com/material-components/material-components-ios/commit/2bda2c118e66ac04b6458a6eab88a24b3c10500c) (ianegordon)
* [[All] Formatting. (#1329)](https://github.com/material-components/material-components-ios/commit/d8a58feecd69219be8f1f7cc15e98ee0d19f5d49) (Will Larche)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Buttons, Page Control, Typography] Fixed screenshots (#1380)](https://github.com/material-components/material-components-ios/commit/d48a3dae3edd56b2c0f86f0d6d751cb2ae2da91c) (Randall Li)
* [[Buttons, Page Control, Typography] Removed video demos (#1387)](https://github.com/material-components/material-components-ios/commit/d7cf7999eded279d660abaed7c37e14299d3334f) (Randall Li)
* [[Docs] Docstravaganza (#1330)](https://github.com/material-components/material-components-ios/commit/4a011e75a55fa1b0c592c44578a28162ddfa81ce) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

# 23.0.2

## API diffs

No change in public APIs.

## Component changes

### ActivityIndicator

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### AnimationTiming

#### Changes

* [Added a link to the motion spec in the AnimationTiming README. (#1319)](https://github.com/material-components/material-components-ios/commit/92db31da5c115510c9b29be058f77434998fa9a7) (Scott Hyndman)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### AppBar

#### Changes

* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### ButtonBar

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Buttons

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Math] New private math component (#1325)](https://github.com/material-components/material-components-ios/commit/ff5d16586947158e743eec1cc6da949662f0d7c0) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### CollectionCells

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Math] New private math component (#1325)](https://github.com/material-components/material-components-ios/commit/ff5d16586947158e743eec1cc6da949662f0d7c0) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### CollectionLayoutAttributes

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Collections

#### Changes

* [Eliminate static analyzer warnings. Simplify Collection supplementary views (#1316)](https://github.com/material-components/material-components-ios/commit/f018e09afe4c0a1d73d20993d0b2283638dfbdcd) (ianegordon)
* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Dialogs

#### Changes

* [Fix AlertController rotation layout (#1306)](https://github.com/material-components/material-components-ios/commit/74e6232777c3d10600bffaee5b1127d9de60baa3) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] Formatting. (#1329)](https://github.com/material-components/material-components-ios/commit/d8a58feecd69219be8f1f7cc15e98ee0d19f5d49) (Will Larche)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### FeatureHighlight

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] Formatting. (#1329)](https://github.com/material-components/material-components-ios/commit/d8a58feecd69219be8f1f7cc15e98ee0d19f5d49) (Will Larche)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Feature highlight] Accessibility fixes (#1284)](https://github.com/material-components/material-components-ios/commit/2a47d187edc7a4aec4566641730042fd00df114b) (Sam Morrison)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### FlexibleHeader

#### Changes

* [Ensure the MDCFlexibleHeaderView adheres to UIAppearance proxy if set (#1326)](https://github.com/material-components/material-components-ios/commit/92240a337deeec844ce53061eb289c472168202e) (Justin Shephard)
* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### HeaderStackView

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Ink

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### NavigationBar

#### Changes

* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[Math] New private math component (#1325)](https://github.com/material-components/material-components-ios/commit/ff5d16586947158e743eec1cc6da949662f0d7c0) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### OverlayWindow

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### PageControl

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Palettes

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### ProgressView

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Updates ProgressView to use MDCMath. (#1328)](https://github.com/material-components/material-components-ios/commit/d9b7b2f69f5d0f3bb24b2cff5b9811e09b3a9787) (Louis Romero)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### ShadowElevations

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### ShadowLayer

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Slider

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Snackbar

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Tabs

#### Changes

* [Corrections for readme (#1294)](https://github.com/material-components/material-components-ios/commit/7a0e7de88a82262c8f86755124f32268796aff38) (Will Larche)
* [Fix warnings uncovered by the Xcode 8.3 static analyzer (#1298)](https://github.com/material-components/material-components-ios/commit/2ce144abd0c1d074ac32677e242d4b9508d76f40) (ianegordon)
* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Minor Tweaks to address internal feedback. (#1312)](https://github.com/material-components/material-components-ios/commit/a749a98b4f27652a87527bdd7598ea30e54dd5f2) (ianegordon)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

### Typography

#### Changes

* [Gigantic documentation update. (#1305)](https://github.com/material-components/material-components-ios/commit/9ed1d4349d90f0bcf13b95043cf9e741846da69c) (Scott Hyndman)
* [Workaround for medium system font on iOS 8 (#1292)](https://github.com/material-components/material-components-ios/commit/2bda2c118e66ac04b6458a6eab88a24b3c10500c) (ianegordon)
* [[All] Formatting. (#1329)](https://github.com/material-components/material-components-ios/commit/d8a58feecd69219be8f1f7cc15e98ee0d19f5d49) (Will Larche)
* [[All] replacing ~~~ with ```. (#1324)](https://github.com/material-components/material-components-ios/commit/3f99ed2dd9aefb903918efb9253ade09e85d9a0d) (Will Larche)
* [[Docs]: Updated link list classes. (#1320)](https://github.com/material-components/material-components-ios/commit/0913aa9aaf85cfcb041e55acd3b2aa7608bb6a1d) (Scott Hyndman)
* [[docs] Associated icons with components (#1315)](https://github.com/material-components/material-components-ios/commit/69533578ca35c968594680a3ea50abd539fbea59) (Scott Hyndman)

# 23.0.1

## API diffs

No change in public APIs.

## Component changes

## Component changes

### AppBar

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### Buttons

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### CollectionCells

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### CollectionLayoutAttributes

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### Collections

#### Changes

* [Fix markdown in styles readme (#1263)](https://github.com/material-components/material-components-ios/commit/0ab539bd92cb0a52b37f6a8fbe2dd3b23cfc8981) (Morgan Chen)
* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### Dialogs

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### FeatureHighlight

#### Changes

* [[Feature Highlight] Fix feature highlight on iOS8 devices (#1281)](https://github.com/material-components/material-components-ios/commit/6f8304e29b51a74db297631900b15018da782527) (Sam Morrison)
* [[Feature Highlight] Fix leaked CGPaths (thanks static analyzer!) (#1282)](https://github.com/material-components/material-components-ios/commit/5d8a6f9a1f8e1b0b22bb8caf4641ff7701bb7ea4) (Sam Morrison)

### FlexibleHeader

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### Ink

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### NavigationBar

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### Snackbar

#### Changes

* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### Tabs

#### Changes

* [License stanza corrections.](https://github.com/material-components/material-components-ios/commit/258b2919961f6b69c82025db4e3faaa51fd50650) (Will Larche)
* [Reversing order of snippets.](https://github.com/material-components/material-components-ios/commit/801e4bedd9f95e817fc8230c3a77e105228effbf) (Will Larche)
* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

### Typography

#### Changes

* [Added fallback logic for getting bold/italic fonts so that if there are no fonts then it returns the system bold/italic fonts. (#1277)](https://github.com/material-components/material-components-ios/commit/bbfad4f894333a66099f118ee508df5a8bb45ff4) (Randall Li)
* [[All] Formatting. (#1269)](https://github.com/material-components/material-components-ios/commit/8c5350de315acf7d3902e93515aae1de9349edab) (Will Larche)

# 23.0.0

## API diffs

### CollectionCell

#### Changes

* Add kSelectedCellAccessibilityHintKey

* Add kDeselectedCellAccessibilityHintKey

### Collections

#### Changes

* Change [MDCCollectionViewStyling backgroundImageForCellLayoutAttributes] nullability

### Ink

#### Changes

* Change [MDCInkTouchController inkTouchController] nullability

### Typography

#### Changes

* Add [MDCTypography boldItalicFontOfSize:]

* Add [MDCTypography boldFontFromFont:]

* Add [MDCTypography italicFontFromFont:]

* Add [MDCTypography isLargeForContrastRatios]

## Component changes

### CollectionCells

#### Changes

* [Add accessibility hint in edit mode (#1258)](https://github.com/material-components/material-components-ios/commit/4cbdfb9e3190225f3c13a6826b0bd9fd99c02d26) (Louis Romero)

### CollectionLayoutAttributes

#### Changes

* [Fix comparison (#1268)](https://github.com/material-components/material-components-ios/commit/2d8dbeb6de53508c7d6c33085c8863285137ab2c) (Gauthier Ambard)

### Collections

#### Changes

* [- Fix static analyzer warnings (#1231)](https://github.com/material-components/material-components-ios/commit/d640c1c3aac9998b860a087c26c4689a3fbd9261) (Justin Shephard)
* [[Collection] Fix text in header/footer example (#1266)](https://github.com/material-components/material-components-ios/commit/6ddf3fbdcf9cb2948c9d63d8d42ba3ce5424e52d) (Gauthier Ambard)

### FlexibleHeader

#### Changes

* [[FlexibleHeaderView] Temporarily remove assert to workaround iOS 10.3b issue (#1255)](https://github.com/material-components/material-components-ios/commit/ae15b469a8d9e639d6cfbe562edab4b4efa58d7a) (ianegordon)

### Ink

#### Changes

* [[Collections] - Fix static analyzer warnings (#1231)](https://github.com/material-components/material-components-ios/commit/d640c1c3aac9998b860a087c26c4689a3fbd9261) (Justin Shephard)

### Snackbar

#### Changes

* [Dont autodismiss snackbar messages views if they have voiceover focus (#1260)](https://github.com/material-components/material-components-ios/commit/cf7e0d423dde27e64f6c08a6f62a5e7f9ea8cb35) (Sam Morrison)

### Typography

#### Changes

* [Added strong dependency to MDFTextAccessiblity for fallbackack logic when isLargeForContrastRatios: is unspecified. (#1250)](https://github.com/material-components/material-components-ios/commit/5328641bff96768bc8dc31da818932b70e2bd11e) (Randall Li)
* [Make system font return medium and light versions of Helvetica instead of regularSystemFont. (#1246)](https://github.com/material-components/material-components-ios/commit/9fa1bf999b64eff71eea8a8627ebad7cdfa54e48) (Randall Li)
* [Remove unused header that causes circular dependency. (#1240)](https://github.com/material-components/material-components-ios/commit/502136ba8923f6a7b323c20b0400f6febc668432) (Adrian Secord)
* [added boldFontFromFont: and italicFontFormFont: (#1261)](https://github.com/material-components/material-components-ios/commit/7ddf3fb0c65f063ff72726f8472542642ff9b5a1) (Randall Li)
* [added boldItalic font to optional protocol of the TypographyFontLoading protocol (#1252)](https://github.com/material-components/material-components-ios/commit/f922779b29a1283b1cfcfec0500339b066a6b84c) (Randall Li)

# 22.1.1

## Component changes

### Flexible Header

#### Changes

* [FlexibleHeaderView] iOS 10.3beta workaround(https://github.com/material-components/material-components-ios/commit/0d54829bf29e6631de16f6a159fb7b48a8037692) (Ian Gordon)

# 22.1.0

## API diffs

### Typography

#### Changes

* [Added isLargeForContrastRatio to protocol (#1232)](https://github.com/material-components/material-components-ios/commit/36ca5ec407d8a3d8ba159e3af52605135b13010d) (Randall Li)

## Component changes

### NavigationBar

#### Changes

* [[Navigation Bar] - Update docs (#1235)](https://github.com/material-components/material-components-ios/commit/8f3d4a89e360300dc885dc9c9d3c259f6ea7c2ca) (Justin Shephard)

### Typography

#### Changes

* [Added isLargeForContrastRatio to protocol (#1232)](https://github.com/material-components/material-components-ios/commit/36ca5ec407d8a3d8ba159e3af52605135b13010d) (Randall Li)

# 22.0.0

## API diffs

### Dialogs

#### Changes

* [Add Dynamic Type support to Alert controller (#1213)](https://github.com/material-components/material-components-ios/commit/9f92b161db6441dfa8b4eacf7dff6d8aced37509) (ianegordon)

### Typography

#### Changes

* [Added bold and italics to the system fontloader and MDCTypographyFontLoader protocol (#1225)](https://github.com/material-components/material-components-ios/commit/975680a9cb34db366f4d95e62a105d7a0300b972) (Randall Li)

## Component changes

### AppBar

#### Changes

* [Fix analyzer warnings (#1229)](https://github.com/material-components/material-components-ios/commit/42084cb3b8fa4c9b7deef0120231ec1063a5397a) (ianegordon)

### Buttons

#### Changes

* [Dynamic Type resizing fix (#1213)](https://github.com/material-components/material-components-ios/commit/9f92b161db6441dfa8b4eacf7dff6d8aced37509) (ianegordon)

### Dialogs

#### Changes

* [Add Dynamic Type support to Alert controller (#1213)](https://github.com/material-components/material-components-ios/commit/9f92b161db6441dfa8b4eacf7dff6d8aced37509) (ianegordon)

### Snackbar

#### Changes

* [fix case of UIKit.h (#1223)](https://github.com/material-components/material-components-ios/commit/3f2968b54c738c747c6b9a02ab614d7853b0c406) (yoshisatoyanagisawa)

### Typography

#### Changes

* [Add warning about custom fonts and Dynamic Type (#1224)](https://github.com/material-components/material-components-ios/commit/9bea2218a6a6fa7d3eabf4788e4a49ff52487259) (ianegordon)
* [Added bold and italics to the system fontloader and MDCTypographyFontLoader protocol (#1225)](https://github.com/material-components/material-components-ios/commit/975680a9cb34db366f4d95e62a105d7a0300b972) (Randall Li)
* [Fix analyzer warnings (#1229)](https://github.com/material-components/material-components-ios/commit/42084cb3b8fa4c9b7deef0120231ec1063a5397a) (ianegordon)
* [switch it to a objc test (#1226)](https://github.com/material-components/material-components-ios/commit/64852237037ccd68af02b84e03f085392829ec5e) (Randall Li)


# 21.3.0

## API diffs

### Buttons

* [Add Dynamic Type support (#1211)](https://github.com/material-components/material-components-ios/pull/1211) (Ian Gordon)

## Component changes

### AppBar

#### Changes

* [[Project] Clear warnings within project (#1205)](https://github.com/material-components/material-components-ios/commit/95d71cfaac054d9fe88c130617ff963dc4b71ce5) (Justin Shephard)

### Buttons

#### Changes

* [[Button] Add Dynamic Type support (#1211)](https://github.com/material-components/material-components-ios/commit/05d0ad2074d2b4e2a954c6e663ba96798e3efb86) (ianegordon)

### Collections

#### Changes

* [- Updated README docs and example to use collection headers in editing mode (#1193)](https://github.com/material-components/material-components-ios/commit/620b5be1116771e18b3836a44bc806f6a5a3481c) (Justin Shephard)

### NavigationBar

#### Changes

* [[Project] Clear warnings within project (#1205)](https://github.com/material-components/material-components-ios/commit/95d71cfaac054d9fe88c130617ff963dc4b71ce5) (Justin Shephard)

### Snackbar

#### Changes

* [Release voice over's focus on snackbars when they are transient (#1214)](https://github.com/material-components/material-components-ios/commit/2c2592172b323a759af4bdfd969c4be775d95764) (Sam Morrison)

### Tabs

#### Changes

* [[Project] Clear warnings within project (#1205)](https://github.com/material-components/material-components-ios/commit/95d71cfaac054d9fe88c130617ff963dc4b71ce5) (Justin Shephard)

### Typography

#### Changes

* [Silence warning (#1206)](https://github.com/material-components/material-components-ios/commit/cee7266d2fc552f7039baaf8f528171237092b14) (ianegordon)

# 21.2.0

## API diffs

### NavigationBar

* [Added MDCNavigationBarTextColorAccessibilityMutator. (#1180)](https://github.com/material-components/material-components-ios/commit/5db1b8add5e9e77d9439a973cbc9d2d41188d049) (Justin Shephard)

## Component changes

### CollectionCells

#### Changes

* [Fix memory leak in Ink and correct issues with ink when re-using cells (#1180)](https://github.com/material-components/material-components-ios/commit/5db1b8add5e9e77d9439a973cbc9d2d41188d049) (Justin Shephard)

### Ink

#### Changes

* [Fix memory leak in Ink and correct issues with ink when re-using cells (#1180)](https://github.com/material-components/material-components-ios/commit/5db1b8add5e9e77d9439a973cbc9d2d41188d049) (Justin Shephard)

### NavigationBar

#### Changes

* [Added Accessibility Mutator (#1109)](https://github.com/material-components/material-components-ios/commit/c3d3bd34affdd0d52500682bb3c129995f24eadc) (Justin Shephard)

### Typography

#### Changes

* [Corrects typo in snippet. (#1198)](https://github.com/material-components/material-components-ios/commit/a6b23484bdf25b3f15629693e0e8beb65932791a) (Will Larche)

# 21.1.0

## Component changes

### Buttons

#### Changes

* [Revert the button tint color change. (#1196)](https://github.com/material-components/material-components-ios/commit/993edaa5512ce941e5e14e3737945aaa7468b4b5) (Sam Symons)

# 21.0.1

## Fixed podspec so it passes lint.

# 21.0.0

## API diffs

## Minimum iOS version is now 8.0

Given the usage of clients on versions of iOS below 8.0 and the increased power of the APIs available to us on iOS 8, our minimum iOS version is bumped from iOS 7 to 8.

## New component: Tabs

[Tab component with MDCTabBar (#1164)](https://github.com/material-components/material-components-ios/tree/develop/components/Tabs) is an implementation of the [Material tabs](https://material.io/go/design-tabs) used to explore and switch between different views. Try tabs out! (Brian Moore with Will Larche)

## Typography

* [Initial Material Text Style API (#1178)](https://github.com/material-components/material-components-ios/pull/1178) (Ian Gordon)

## Component changes

### ButtonBar

#### Changes

* [Revert "Swift cleanups."](https://github.com/material-components/material-components-ios/commit/7489fca4e4741ae02b406cdaacaf1dae26e19837) (Adrian Secord)
* [Swift cleanups.](https://github.com/material-components/material-components-ios/commit/129789c601a2bb6b09648af953c5433ebe3cebe0) (Adrian Secord)
* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### Buttons

#### Changes

* [Revert "Swift cleanups."](https://github.com/material-components/material-components-ios/commit/7489fca4e4741ae02b406cdaacaf1dae26e19837) (Adrian Secord)
* [Swift cleanups.](https://github.com/material-components/material-components-ios/commit/129789c601a2bb6b09648af953c5433ebe3cebe0) (Adrian Secord)
* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### Dialogs

#### Changes

* [Add a non-dismissing example. (#1184)](https://github.com/material-components/material-components-ios/commit/71d188663654744120bb64ef99762a72565365a3) (ianegordon)
* [Alert body text color to match spec (#1177)](https://github.com/material-components/material-components-ios/commit/e5a9df409b769ae2c861d3f618f45f1913178e47) (ianegordon)
* [Revert "Swift cleanups."](https://github.com/material-components/material-components-ios/commit/7489fca4e4741ae02b406cdaacaf1dae26e19837) (Adrian Secord)
* [Swift cleanups.](https://github.com/material-components/material-components-ios/commit/129789c601a2bb6b09648af953c5433ebe3cebe0) (Adrian Secord)
* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### FeatureHighlight

#### Changes

* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### FlexibleHeader

#### Changes

* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### HeaderStackView

#### Changes

* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### NavigationBar

#### Changes

* [Fxing the spelling for MaterialNavigationBar.h in include statement. (#1181)](https://github.com/material-components/material-components-ios/commit/59adab3eaa341458339806027fa4ea371a2b7482) (Scott Nichols)
* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### Slider

#### Changes

* [Revert "Swift cleanups."](https://github.com/material-components/material-components-ios/commit/7489fca4e4741ae02b406cdaacaf1dae26e19837) (Adrian Secord)
* [Swift cleanups.](https://github.com/material-components/material-components-ios/commit/129789c601a2bb6b09648af953c5433ebe3cebe0) (Adrian Secord)
* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### Snackbar

#### Changes

* [[Swiftlint] Moar swiftlint fixes (#1155)](https://github.com/material-components/material-components-ios/commit/7ff646b58aba753c367bea7c9b7d0325ee61b440) (Adrian Secord)

### Tabs

#### Changes

* [[New Component] Tab component with MDCTabBar (#1164)](https://github.com/material-components/material-components-ios/commit/fd074fca51a06e18b7878973820409695bca05aa) (Brian Moore)

### Typography

#### Changes

* [Initial Material Text Style API (#1178)](https://github.com/material-components/material-components-ios/commit/774d2f03a8175827fcb553176a04784345614b61) (ianegordon)


# 20.1.1

## Component changes

### Snackbar

#### Changes

* [Fix glitchy dismissal animation (#1166)](https://github.com/material-components/material-components-ios/pull/1166) (Sam Morrison)
* [Update file path for private file. (#1168)](https://github.com/material-components/material-components-ios/commit/1effd8ad0cb879048f00972b366bcdf481e3c2b6) (Louis Romero)

# 20.1.0

## API diffs

### Snackbar

* Message View Styling

## Component changes

### AppBar

#### Changes

* [- Added Modal Presentation App Bar Example (#1153)](https://github.com/material-components/material-components-ios/commit/8ab5505d0e438d7e9a7a31cf9e1ffea113e3be7c) (Justin Shephard)
* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)

### Buttons

#### Changes

* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)

### Collections

#### Changes

* [Added custom Storyboard cell to the Storyboard example. (#1152)](https://github.com/material-components/material-components-ios/commit/6843303f9d54a5a11a70abae6976f0b4d011636f) (Adrian Secord)
* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)

### Dialogs

#### Changes

* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)

### FeatureHighlight

#### Changes

* [Build fix: CGFloat casts missing from MDCFeatureHighlightView.m.](https://github.com/material-components/material-components-ios/commit/99d59f3fc6e2be46ebbe93c2784965516615a4ba) (Adrian Secord)
* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)
* [[Feature highlight] Dynamically size inner highlight (#1151)](https://github.com/material-components/material-components-ios/commit/771496f6c6044866ea30622006646e7a7193e070) (Sam Morrison)

### FlexibleHeader

#### Changes

* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)

### PageControl

#### Changes

* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)

### Palettes

#### Changes

* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)

### ShadowLayer

#### Changes

* [More SwiftLint fixes for unit tests and example apps. (#1154)](https://github.com/material-components/material-components-ios/commit/8bcb19781cd8387464f46be51cdd72787d3f12ef) (Adrian Secord)

### Snackbar

#### Changes

* [Message View Styling. (#1120)](https://github.com/material-components/material-components-ios/commit/95891e1130e6ee9351d5e7bad8f1ceb68bc22500) (Sean O'Shea)

# 20.0.0

## API changes

### Ink

* Return value of `-[MDCInkTouchController initWithView:]` changed from `nullable instancetype` to `nonnull instancetype`.

### ProgressView

* Added `MDCProgressViewBackwardAnimationMode` enumeration and `-[MDCProgressView backwardProgressAnimationMode]` to control how the progress view acts when its progress value is set to a _smaller_ value than the current value.

## Component changes

### ActivityIndicator

#### Changes

* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)

### AppBar

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [Header stack view in AppBarController (#1121)](https://github.com/material-components/material-components-ios/commit/f2f00b3339da2658366977f8de972d4c8f9a0c31) (Will Larche)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### ButtonBar

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### Buttons

#### Changes

* [Update the button’s custom title color when the tint color changes. (#1134)](https://github.com/material-components/material-components-ios/commit/85dd5428f2c20c9ec4ca25bcaf531a20990fe4fa) (Sam Symons)
* [[Catalog] Center views in the Buttons (Swift and Storyboard) demo (#1126)](https://github.com/material-components/material-components-ios/commit/94a6d589e07dc6565a9f2011f733e9e2848e4b28) (Sam Symons)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### CollectionCells

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[ReadMes] - Updated asset name for collection_cells (#1111)](https://github.com/material-components/material-components-ios/commit/c0103fc323d6767b90c91d93aa875a401ed98acf) (Justin Shephard)

### Collections

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)

### Dialogs

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### FeatureHighlight

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)

### FlexibleHeader

#### Changes

* [- Update tests so as not to have 0 in contentSize (#1146)](https://github.com/material-components/material-components-ios/commit/89e007b7a603785e94e775c8fdf3d2c505901330) (Justin Shephard)
* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### HeaderStackView

#### Changes

* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### Ink

#### Changes

* [Add nonnull to the MDCInkTouchController initializer (#1123)](https://github.com/material-components/material-components-ios/commit/b62b9c0524cc0bb9b54194ef70d464d0fd756e63) (Sam Symons)
* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)

### NavigationBar

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [Remove redundant RTL frame adjustment (#1103)](https://github.com/material-components/material-components-ios/commit/ac88e9b297306ea3b08e4e9e1eb1c92185b9eeef) (Junius Gunaratne)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### OverlayWindow

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)

### PageControl

#### Changes

* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### Palettes

#### Changes

* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### ProgressView

#### Changes

* [Backward animation support (#1138)](https://github.com/material-components/material-components-ios/commit/26ce625081dea69c947a3383e53128eab0abb7b2) (Sam Symons)
* [Ran scripts/format_all. (#1141)](https://github.com/material-components/material-components-ios/commit/c6620b9ada62bea7e572412e62f109c0d491e134) (Adrian Secord)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)

### ShadowLayer

#### Changes

* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)
* [[Scripts] SwiftLint integration (#1129)](https://github.com/material-components/material-components-ios/commit/bb561ac2575b613ff324772e4e0daa8dad0e9e27) (Sam Symons)

### Slider

#### Changes

* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)

### Snackbar

#### Changes

* [Fixes layout for SnackbarSuspensionExample (#1098)](https://github.com/material-components/material-components-ios/commit/ae5361cca0cff5aec4699bdf07fb9bdcb6f84f05) (Peter Friese)
* [Formatted all Objective-C sources with clang-format. (#1133)](https://github.com/material-components/material-components-ios/commit/7ba66bf09ca984649ee30e58363fc6f995bedaca) (Adrian Secord)
* [Render Snackbar labels correctly for RTL (#1137)](https://github.com/material-components/material-components-ios/commit/7e475358182dcc0cdb8208ad56d94e867244b4d5) (Sam Morrison)
* [Weakify strongify asynchronously dispatched snackbar view dismissal (#1136)](https://github.com/material-components/material-components-ios/commit/82049abf8f9937e2b2932e3839e56a16fb074e7a) (Sam Morrison)
* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)

### Typography

#### Changes

* [[ReadMes] - First image of each component is too big (#1110)](https://github.com/material-components/material-components-ios/commit/7a194835697bbb7d69832b83f1900de8ade2a8c8) (Justin Shephard)


# 19.0.4

This point release changes certain podfiles and instructions to refer to the published pod up at CocoaPods.

# 19.0.3

This point release removes the examples from `private/ThumbTrack`; they didn't follow our normal conventions and was confusing `pod try`.

## API changes

* No API changes in this release.

## Component changes

* No component changes in this release.

# 19.0.2

## API changes

* No API changes in this release.

## Component changes

### ActivityIndicator

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### AppBar

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### ButtonBar

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### Buttons

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### CollectionCells

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### CollectionLayoutAttributes

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### Collections

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### FlexibleHeader

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### HeaderStackView

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### Ink

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### NavigationBar

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### PageControl

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### Palettes

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### ProgressView

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### ShadowElevations

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### ShadowLayer

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### Slider

#### Changes

* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

### Typography

#### Changes

* [Remove all references to removed components (#1067)](https://github.com/material-components/material-components-ios/commit/03059189e5c929d877a6fd83d33c1a5614273527) (Adrian Secord)
* [Removed old refs to API docs. (#1084)](https://github.com/material-components/material-components-ios/commit/e8c45d53942908ceece95bfadbc98db7a92089b0) (Adrian Secord)

# 19.0.1

This point release fixes stale references to MDFFontDiskLoader, MDFSpritedAnimationView, and MDFRobotoFontLoader in our CocoaPods podspec.

## API diffs

None.

## Component changes

### Typography

#### Changes

* [Remove all references to removed components (#1067)](https://github.com/material-components/material-components-ios/commit/3405a9495b57b6f45180847e89f7e3f3d34b7fe1) (Adrian Secord)

# 19.0.0

## API diffs

The following components have been refactored out of MDC into their own repos:

* MDCFontDiskLoader is now [MDFFontDiskLoader](https://github.com/material-foundation/material-font-disk-loader-ios).
* MDCSpritedAnimationView is now [MDFSpritedAnimationView](https://github.com/material-foundation/material-sprited-animation-view-ios).
* MDCRobotoFontLoader is now [MDFRobotoFontLoader](https://github.com/material-foundation/material-roboto-font-loader-ios).

> Please note that while [MDC's
> repo](https://github.com/material-components/material-components-ios) is
> private, there is no way for
> [MDFRobotoFontLoader](https://github.com/material-foundation/material-roboto-font-loader-ios/blob/stable/src/MDFRobotoFontLoader.h#L22)
> to formally depend on
> [MDCTypographyFontLoading](https://github.com/material-components/material-components-ios/blob/develop/components/Typography/src/MDCTypography.h#L27),
> even though it informally implements the protocol. This means that
> MDFRobotoFontLoader can't be used out of the box to configure Typography with
> Roboto. Once we go public, a pull request to MDFFontDiskLoader will be
> created to add this convenience. Until that time, you can manually extend
> your local copy of MDFRobotoFontLoader to declare that it implements
> MDCTypographyFontLoading.

### ShadowLayer
#### MDCShadowLayer

*modified* property: `shadowMaskEnabled` in `MDCShadowLayer`

| Type of change: | declaration |
|---|---|
| From: | `@property (assign, readwrite, nonatomic) BOOL shadowMaskEnabled;` |
| To: | `@property (getter=isShadowMaskEnabled, assign, readwrite, nonatomic)     BOOL shadowMaskEnabled;` |

## Component changes

### ActivityIndicator

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### AnimationTiming

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### AppBar

#### Changes

* [- Re-adding NSCoding Support (#1008)](https://github.com/material-components/material-components-ios/commit/9cb3c3055204cb83891eb9c3e3af7d9ea33e36ea) (Justin Shephard)
* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### ButtonBar

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### Buttons

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### CollectionLayoutAttributes

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### Collections

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### Dialogs

#### Changes

* [Update README.md (#1028)](https://github.com/material-components/material-components-ios/commit/e648cf361000579ba2bd862257a735d74a66a768) (ianegordon)
* [[Catalog] Update dialog storyboard to rotate properly (#1031)](https://github.com/material-components/material-components-ios/commit/2cbfa20b1bafc8b4c37de9a43d8a9cea1aca63ae) (ianegordon)
* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### FeatureHighlight

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### FlexibleHeader

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### HeaderStackView

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### Ink

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### NavigationBar

#### Changes

* [Adding guidance to NavigationBar's docs about not using center-aligned titles (#1030)](https://github.com/material-components/material-components-ios/commit/9c9d6cee11d1916bb6eb6b2ea895fc8fff5fa758) (Junius Gunaratne)
* [[AppBar] - Re-adding NSCoding Support (#1008)](https://github.com/material-components/material-components-ios/commit/9cb3c3055204cb83891eb9c3e3af7d9ea33e36ea) (Justin Shephard)
* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### OverlayWindow

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### PageControl

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### Palettes

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### ProgressView

#### Changes

* [[Readmes] Snippets in Swift 3 (#1039)](https://github.com/material-components/material-components-ios/commit/3c4e9055983635c8b0ac9897816771ee864e030f) (Will Larche)

### ShadowElevations

#### Changes

* [Update ShadowElevation and ShadowLayer examples in README.md to Swift 3 (#1041)](https://github.com/material-components/material-components-ios/commit/1696df81a3b272c353caf6d9b242983bc143891e) (Junius Gunaratne)

### ShadowLayer

#### Changes

* [Add NSCoder support.  (Mark 2) (#1045)](https://github.com/material-components/material-components-ios/commit/2c353f82c2eba4261fe5e1403cb6b974501d9a55) (ianegordon)
* [Initial NSCoding support (#987)](https://github.com/material-components/material-components-ios/commit/4af729a8f3249f6d0511d97cce67a0edd7737747) (ianegordon)
* [Revert "Initial NSCoding support (#987)"](https://github.com/material-components/material-components-ios/commit/e1f886db71be7b70ff07bf7681526334c766a06b) (Ian Gordon)
* [Update ShadowElevation and ShadowLayer examples in README.md to Swift 3 (#1041)](https://github.com/material-components/material-components-ios/commit/1696df81a3b272c353caf6d9b242983bc143891e) (Junius Gunaratne)
* [[Typography] Remove Font Loaders (#1035)](https://github.com/material-components/material-components-ios/commit/0f422df49a48fff7487a71ec2c11297f043f9835) (ianegordon)

### Slider

#### Changes

* [[Readmes] Snippets in Swift 3 (#1050)](https://github.com/material-components/material-components-ios/commit/ae163f527c87869f8326bd159e74378d34a9bcb6) (Will Larche)

### Snackbar

#### Changes

* [[Readmes] Snippets in Swift 3 (#1050)](https://github.com/material-components/material-components-ios/commit/ae163f527c87869f8326bd159e74378d34a9bcb6) (Will Larche)

### Typography

#### Changes

* [Remove Font Loaders (#1035)](https://github.com/material-components/material-components-ios/commit/0f422df49a48fff7487a71ec2c11297f043f9835) (ianegordon)
* [Removed runtime check for MDCRoboto within typography. (#1055)](https://github.com/material-components/material-components-ios/commit/e02c9831365018772d9da1650d8e57e061a55bb9) (Randall Li)
* [[Readmes] Snippets in Swift 3 (#1050)](https://github.com/material-components/material-components-ios/commit/ae163f527c87869f8326bd159e74378d34a9bcb6) (Will Larche)
* [updated bare measurements. (#1063)](https://github.com/material-components/material-components-ios/commit/ab0f705a37d28a55a815106e8cbff3d2c49b9896) (Randall Li)

# 18.0.0

## API diffs

### ButtonBar

* MDCButtonBar is now IB_DESIGNABLE.

#### MDCButtonBarDelegate

*modified* method: `-buttonBar:viewForItem:layoutHints:` in `MDCButtonBarDelegate`

| Type of change: | swift declaration |
|---|---|
| From: | `func buttonBar(_ buttonBar: MDCButtonBar!, viewForItem barButtonItem: Any!, layoutHints: Any!) -> Any!` |
| To: | `func buttonBar(_ buttonBar: MDCButtonBar, viewForItem barButtonItem: Any!, layoutHints: Any!) -> Any!` |

*modified* method: `-buttonBar:viewForItem:layoutHints:` in `MDCButtonBarDelegate`

| Type of change: | declaration |
|---|---|
| From: | `- (UIView *)buttonBar:(MDCButtonBar *)buttonBar           viewForItem:(UIBarButtonItem *)barButtonItem           layoutHints:(MDCBarButtonItemLayoutHints)layoutHints;` |
| To: | `- (nonnull UIView *)buttonBar:(nonnull MDCButtonBar *)buttonBar                   viewForItem:(nonnull UIBarButtonItem *)barButtonItem                   layoutHints:(MDCBarButtonItemLayoutHints)layoutHints;` |

#### MDCButtonBar

*modified* property: `items` in `MDCButtonBar`

| Type of change: | declaration |
|---|---|
| From: | `@property (readwrite, copy, nonatomic) NSArray<UIBarButtonItem *> *items;` |
| To: | `@property (readwrite, copy, nonatomic, nullable)     NSArray<UIBarButtonItem *> *items;` |

### FlexibleHeader
#### MDCFlexibleHeaderViewController

*new* method: `-updateTopLayoutGuide` in `MDCFlexibleHeaderViewController`

### FontDiskLoader
#### MDCFontDiskLoader

*modified* class: `MDCFontDiskLoader`

| Type of change: | key.deprecation_message |
|---|---|
| From: | `` |
| To: | `Use https://github.com/material-foundation/material-font-disk-loader-ios instead.` |

*modified* class: `MDCFontDiskLoader`

| Type of change: | key.always_deprecated |
|---|---|
| From: | `0` |
| To: | `1` |

### HeaderStackView

* MDCHeaderStackView is now IB_DESIGNABLE.

### RobotoFontLoader
#### MDCRobotoFontLoader

*modified* class: `MDCRobotoFontLoader`

| Type of change: | key.deprecation_message |
|---|---|
| From: | `` |
| To: | `Use https://github.com/material-foundation/material-roboto-font-loader-ios instead.` |

*modified* class: `MDCRobotoFontLoader`

| Type of change: | key.always_deprecated |
|---|---|
| From: | `0` |
| To: | `1` |

### SpritedAnimationView
#### MDCSpritedAnimationView

*modified* class: `MDCSpritedAnimationView`

| Type of change: | key.deprecation_message |
|---|---|
| From: | `` |
| To: | `Use https://github.com/material-foundation/material-sprited-animation-view-ios instead.` |

*modified* class: `MDCSpritedAnimationView`

| Type of change: | key.always_deprecated |
|---|---|
| From: | `0` |
| To: | `1` |

### Switch

* MDCSwitch has been removed, please use UISwitch instead.

## Component changes

### ActivityIndicator

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)

### AnimationTiming

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)

### AppBar

#### Changes

* [- Added NSCoding supprt, added commonInit and commonetViewSetup methods (#994)](https://github.com/material-components/material-components-ios/commit/875a8a9be22ae6c338da4fe104ec8201ffa4b159) (Justin Shephard)
* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)
* [Revert "- Added NSCoding supprt, added commonInit and commonetViewSetup methods (#994)" (#1005)](https://github.com/material-components/material-components-ios/commit/73e1549a8babb868b3ed7b387e59dacb992e36b9) (Justin Shephard)
* [[FlexibleHeader] - Update TopLayoutGuide for Paired VC (#923)](https://github.com/material-components/material-components-ios/commit/0b466abfd29b3230448b3087d5a08776b9e82255) (Justin Shephard)

### ButtonBar

#### Changes

* [- Adding NSCoding compliance to component, IBDesignable, nullability qualifiers (#980)](https://github.com/material-components/material-components-ios/commit/00733fa42c35676fbc677226e3c713d8b5200c01) (Justin Shephard)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)
* [Remove struct hacks (#992)](https://github.com/material-components/material-components-ios/commit/8bc7a849ca6079eb1bb3cffdd9789dbea56d7caf) (Adrian Secord)

### Buttons

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)

### CollectionCells

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Layout subviews after updating interface for editing (#989)](https://github.com/material-components/material-components-ios/commit/27c514f4b851f210d8f7ca173560f4862ab24ce0) (Jackie Quinn)
* [Remove struct hacks (#992)](https://github.com/material-components/material-components-ios/commit/8bc7a849ca6079eb1bb3cffdd9789dbea56d7caf) (Adrian Secord)

### Collections

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)

### Dialogs

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)

### FeatureHighlight

#### Changes

* [Remove struct hacks (#992)](https://github.com/material-components/material-components-ios/commit/8bc7a849ca6079eb1bb3cffdd9789dbea56d7caf) (Adrian Secord)

### FlexibleHeader

#### Changes

* [- Added Swift Example (#1009)](https://github.com/material-components/material-components-ios/commit/68499f15b9c0745644851a0720a27dfef8752834) (Justin Shephard)
* [- Update TopLayoutGuide for Paired VC (#923)](https://github.com/material-components/material-components-ios/commit/0b466abfd29b3230448b3087d5a08776b9e82255) (Justin Shephard)
* [Add float cast to avoid warnings (#979)](https://github.com/material-components/material-components-ios/commit/f9c7955489f5a02b9c93ab09fc9e3570bd980a78) (ianegordon)
* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)
* [Remove struct hacks (#992)](https://github.com/material-components/material-components-ios/commit/8bc7a849ca6079eb1bb3cffdd9789dbea56d7caf) (Adrian Secord)

### FontDiskLoader

#### Changes

* [Deprecate migrating components. (#1007)](https://github.com/material-components/material-components-ios/commit/d0202ebc37f0b4fc96ac5ba78b9ab1120a0331cc) (Adrian Secord)
* [Removed FontDiskLoader tests. They were using font assets from another component RobotoFontLoader which is causing problems. Also the component is depreciated and moved into MDFFontDiskLoader. (#1016)](https://github.com/material-components/material-components-ios/commit/6fb5c3aa8fde9fba77260526800f3b2a617dc05d) (Randall Li)

### HeaderStackView

#### Changes

* [- Added IB_Designable, NSCoding support, swift example (#983)](https://github.com/material-components/material-components-ios/commit/2ebebab53566bcaf3e17442ee3b6deb5b468c2ac) (Justin Shephard)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)
* [Remove struct hacks (#992)](https://github.com/material-components/material-components-ios/commit/8bc7a849ca6079eb1bb3cffdd9789dbea56d7caf) (Adrian Secord)

### Ink

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)

### NavigationBar

#### Changes

* [- Added NSCoding support (#985)](https://github.com/material-components/material-components-ios/commit/20a629f5491a60ec86cc3540ee71a8fa340d2e5b) (Justin Shephard)
* [- Component Checklist (#996)](https://github.com/material-components/material-components-ios/commit/40f2b257185cb9f892ddaff41f583da1b2b3070e) (Justin Shephard)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)
* [Remove struct hacks (#992)](https://github.com/material-components/material-components-ios/commit/8bc7a849ca6079eb1bb3cffdd9789dbea56d7caf) (Adrian Secord)
* [Update title frame then apply RTL for title alignment. #831 (#991)](https://github.com/material-components/material-components-ios/commit/d4ec6ee060c88cac48ceac1ce7e14158070f9ef3) (Junius Gunaratne)
* [changed default title alignment to center (#831)](https://github.com/material-components/material-components-ios/commit/b2d95a86df3f311b0417afdc96910b7ea0b6e93e) (Randall Li)

### PageControl

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)

### Palettes

#### Changes

* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)

### ProgressView

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)

### RobotoFontLoader

#### Changes

* [Deprecate migrating components. (#1007)](https://github.com/material-components/material-components-ios/commit/d0202ebc37f0b4fc96ac5ba78b9ab1120a0331cc) (Adrian Secord)
* [[Typography] Removes the runtime inspection that uses Roboto if it can be found (via MDCRobotoFontLoader) (#713)](https://github.com/material-components/material-components-ios/commit/6834ae3efc45a87933e6fb6cdfdc942c0ffbe509) (Randall Li)

### ShadowElevations

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)

### ShadowLayer

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)

### Slider

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)

### SpritedAnimationView

#### Changes

* [Deprecate migrating components. (#1007)](https://github.com/material-components/material-components-ios/commit/d0202ebc37f0b4fc96ac5ba78b9ab1120a0331cc) (Adrian Secord)

### Typography

#### Changes

* [Capitalize "Material" in documentation (#1014)](https://github.com/material-components/material-components-ios/commit/e93a16ca029ca2bc68c9ecaaaeb83b996a79acf0) (Adrian Secord)
* [Convert component examples to Swift 3 (#1002)](https://github.com/material-components/material-components-ios/commit/4842a362f50cd5a3f5b88bdddbbc973d6edf7446) (Adrian Secord)
* [Removes the runtime inspection that uses Roboto if it can be found (via MDCRobotoFontLoader) (#713)](https://github.com/material-components/material-components-ios/commit/6834ae3efc45a87933e6fb6cdfdc942c0ffbe509) (Randall Li)


# 17.2.0

## API Changes

### FlexibleHeader

* `MDCFlexibleHeaderView` is now marked `IB_DESIGNABLE`.

### Switch

* `MDCSwitch` is completely deprecated and will be removed in the next release. We recommend apps use UISwitch instead.

## Component changes

### ActivityIndicator

#### Changes

* [Add missing language switcher comments to READMEs (#963)](https://github.com/material-components/material-components-ios/commit/d246914c96d2b831cb213d9dc8d2caf4afb1dbfd) (Sam Morrison)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)
* [[MDCActivityIndicator] Add API documentation links to README.md (#950)](https://github.com/material-components/material-components-ios/commit/7da34bbff7b17e72c6dc104e41e99ba38aa1bf07) (Junius Gunaratne)

### AnimationTiming

#### Changes

* [Add jekyll file and update pod spec](https://github.com/material-components/material-components-ios/commit/060db3e5966f1bfdfec57e85a3dedde0bc482c49) (Junius Gunaratne)
* [Add missing language switcher comments to READMEs (#963)](https://github.com/material-components/material-components-ios/commit/d246914c96d2b831cb213d9dc8d2caf4afb1dbfd) (Sam Morrison)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### AppBar

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### ButtonBar

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### Buttons

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### CollectionCells

#### Changes

* [Add "selected" accessibility trait when cell is selected in edit mode (#967)](https://github.com/material-components/material-components-ios/commit/3730aa2c580d358322a3efab6f71f40825bbf283) (Jackie Quinn)

### CollectionLayoutAttributes

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### Collections

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### Dialogs

#### Changes

* [Add RTL Support (#972)](https://github.com/material-components/material-components-ios/commit/b13df7f1391c24ea13a53a772c77b68d8ef144e6) (ianegordon)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### FeatureHighlight

#### Changes

* [Fix .png and .mp4 file names to match `scripts/check_components` (#946)](https://github.com/material-components/material-components-ios/commit/850faf828b220b467589b4b16315e9c4b0bbd12b) (Adrian Secord)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### FlexibleHeader

#### Changes

* [- Added NSCoding compliance to component, IBDesignab… (#973)](https://github.com/material-components/material-components-ios/commit/db4b55a54e0dde591e5e171b8a17bfe11ed3ed8d) (Justin Shephard)
* [Fixed double/CGFloat conversion error and formatting in MDCFlexibleHeaderView.m.](https://github.com/material-components/material-components-ios/commit/96ada23f183fd319e6e3b9bd068abdd1ddd67fb4) (Adrian Secord)
* [Undid CGFloat cast for one property.](https://github.com/material-components/material-components-ios/commit/7640a0a567b42832842b5aa2888c297eebbc8900) (Adrian Secord)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### FontDiskLoader

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### HeaderStackView

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### Ink

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### NavigationBar

#### Changes

* [Fix .png and .mp4 file names to match `scripts/check_components` (#946)](https://github.com/material-components/material-components-ios/commit/850faf828b220b467589b4b16315e9c4b0bbd12b) (Adrian Secord)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### OverlayWindow

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### PageControl

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### Palettes

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### ProgressView

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### RobotoFontLoader

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### ShadowElevations

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### ShadowLayer

#### Changes

* [Fix .png and .mp4 file names to match `scripts/check_components` (#946)](https://github.com/material-components/material-components-ios/commit/850faf828b220b467589b4b16315e9c4b0bbd12b) (Adrian Secord)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)
* [[Shadows] Scrub comments (#948)](https://github.com/material-components/material-components-ios/commit/d8df05828047510bb19f0f6ed1e793c55298a0f3) (ianegordon)

### Slider

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### Snackbar

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### SpritedAnimationView

#### Changes

* [Fix .png and .mp4 file names to match `scripts/check_components` (#946)](https://github.com/material-components/material-components-ios/commit/850faf828b220b467589b4b16315e9c4b0bbd12b) (Adrian Secord)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### Switch

#### Changes

* [Deprecated Switch and removed its examples. (#951)](https://github.com/material-components/material-components-ios/commit/b9fdbd6b11f1766b75f2fbd774ec33997d17fa54) (Adrian Secord)
* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

### Typography

#### Changes

* [[Documentation] Putting Swift snippets before Objc (#960)](https://github.com/material-components/material-components-ios/commit/1080e894229e18a7fae391d5e53ccdc7800fcd19) (Will Larche)

# 17.1.1

No public API or component changes.

Added missing components/private/Application/src/MaterialApplication.h umbrella header.

# 17.1.0

## API diffs

No public API changes in this release. Note that the 17.0.0 release was not published to CocoaPods, so if you are updating from 16.3.0 you will see the breaking change from 17.0.0.

### Behavior changes in MDCSnackbar

The behavior of MDCSnackbar has been changed to better match [the spec](https://material.io/go/design-snackbars#snackbars-toasts-specs):
* Animation duration increased from 0.15s to 0.5s.
* The snackbar no longer fades out, but translates down off screen.
* The snackbar's text and button (but not the background) fade out during the animation.

## Component changes

### ActivityIndicator

#### Changes

* [Add missing license headers (#900)](https://github.com/material-components/material-components-ios/commit/dff304e062c317a6bf4e6ea8d9963de45ca26bc7) (Sam Morrison)
* [Reduce minimum activity indicator radius to 5 pt. (#887)](https://github.com/material-components/material-components-ios/commit/cd4abc398c9ca2b89d237ee5484354f47efe1978) (Adrian Secord)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [Updated test to relect new radius of 5. (#907)](https://github.com/material-components/material-components-ios/commit/b2e811af5fd665a4085b93f3fe38ea324ec536b0) (Randall Li)
* [Wrap sharedApplication calls so we can build for app extension targets (#897)](https://github.com/material-components/material-components-ios/commit/e69f038d883b6734a9b7e8312766fcccd742610c) (Sam Morrison)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### AnimationTiming

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### AppBar

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)

### ButtonBar

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Buttons

#### Changes

* [Add missing license headers (#900)](https://github.com/material-components/material-components-ios/commit/dff304e062c317a6bf4e6ea8d9963de45ca26bc7) (Sam Morrison)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[MDCFloatingButton] Floating action button should use a shape rather than text (#833)](https://github.com/material-components/material-components-ios/commit/4596b7c861229b22ca84574e189cf85b7671435c) (Junius Gunaratne)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### CollectionCells

#### Changes

* [Remove MDCSwitch examples and catalog usage. (#892)](https://github.com/material-components/material-components-ios/commit/171e5bfbc553585b1a798d22b269ce6c92afbcca) (Adrian Secord)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### CollectionLayoutAttributes

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Collections

#### Changes

* [Fixes NSString to enum comparison (#872)](https://github.com/material-components/material-components-ios/commit/fb3cd29dce2ab78a55b4664d0b87bf0b4eae4779) (Cezar Cocu)
* [Remove MDCSwitch examples and catalog usage. (#892)](https://github.com/material-components/material-components-ios/commit/171e5bfbc553585b1a798d22b269ce6c92afbcca) (Adrian Secord)
* [Remove unnecessary method call (#875)](https://github.com/material-components/material-components-ios/commit/c293f80d88430a7be9e33d5a49e4c4f1d1a88bf6) (ianegordon)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Dialogs

#### Changes

* [Add missing license (#895)](https://github.com/material-components/material-components-ios/commit/58c910672b653d7e4611e3932ae57fa8a53bd324) (ianegordon)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### FeatureHighlight

#### Changes

* [Add Feature Highlight demo video and still (#899)](https://github.com/material-components/material-components-ios/commit/59d092d5f91db97eb0cbc519383abd5a1da4e47c) (Sam Morrison)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### FlexibleHeader

#### Changes

* [- MDCFlexibleHeader in an app extension (#878)](https://github.com/material-components/material-components-ios/commit/d6130d28e4abf0fdbe47d3b4cbc05e024615928b) (Justin Shephard)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [Wrap sharedApplication calls so we can build for app extension targets (#897)](https://github.com/material-components/material-components-ios/commit/e69f038d883b6734a9b7e8312766fcccd742610c) (Sam Morrison)
* [[MDCFloatingButton] Floating action button should use a shape rather than text (#833)](https://github.com/material-components/material-components-ios/commit/4596b7c861229b22ca84574e189cf85b7671435c) (Junius Gunaratne)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### FontDiskLoader

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### HeaderStackView

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Ink

#### Changes

* [Add missing license headers (#900)](https://github.com/material-components/material-components-ios/commit/dff304e062c317a6bf4e6ea8d9963de45ca26bc7) (Sam Morrison)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### NavigationBar

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### OverlayWindow

#### Changes

* [Add OverlayWindow to the docs.](https://github.com/material-components/material-components-ios/commit/200d83fbd4172235228e03090a5b6827fd4dd22a) (Adrian Secord)
* [Add missing license headers (#900)](https://github.com/material-components/material-components-ios/commit/dff304e062c317a6bf4e6ea8d9963de45ca26bc7) (Sam Morrison)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [Wrap sharedApplication calls so we can build for app extension targets (#897)](https://github.com/material-components/material-components-ios/commit/e69f038d883b6734a9b7e8312766fcccd742610c) (Sam Morrison)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### PageControl

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Palettes

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### ProgressView

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### RobotoFontLoader

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### ShadowElevations

#### Changes

* [Improve shadow elevation description in read me (#879)](https://github.com/material-components/material-components-ios/commit/24a7c39db1102edc050d1d5d73d409b63d641df7) (Junius Gunaratne)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### ShadowLayer

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Slider

#### Changes

* [Add missing license headers (#900)](https://github.com/material-components/material-components-ios/commit/dff304e062c317a6bf4e6ea8d9963de45ca26bc7) (Sam Morrison)
* [Internal change 138179679. (#866)](https://github.com/material-components/material-components-ios/commit/9509c4182608bbca45ff43132f17f57e3ea9f5bc) (Adrian Secord)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Snackbar

#### Changes

* [Remove MDCSwitch examples and catalog usage. (#892)](https://github.com/material-components/material-components-ios/commit/171e5bfbc553585b1a798d22b269ce6c92afbcca) (Adrian Secord)
* [Removed Snackbar's vestigial vertical layout code. (#902)](https://github.com/material-components/material-components-ios/commit/2ce4475e53085cf9e9b28656adffbd6faf316b7e) (Adrian Secord)
* [Snackbar animation (#903)](https://github.com/material-components/material-components-ios/commit/b899a2a62ccfc1ed39064375e3c491fe2299a8a5) (Adrian Secord)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [Wrap sharedApplication calls so we can build for app extension targets (#897)](https://github.com/material-components/material-components-ios/commit/e69f038d883b6734a9b7e8312766fcccd742610c) (Sam Morrison)
* [[MDCFloatingButton] Floating action button should use a shape rather than text (#833)](https://github.com/material-components/material-components-ios/commit/4596b7c861229b22ca84574e189cf85b7671435c) (Junius Gunaratne)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### SpritedAnimationView

#### Changes

* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Switch

#### Changes

* [Internal change 138179679. (#866)](https://github.com/material-components/material-components-ios/commit/9509c4182608bbca45ff43132f17f57e3ea9f5bc) (Adrian Secord)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

### Typography

#### Changes

* [Remove MDCSwitch examples and catalog usage. (#892)](https://github.com/material-components/material-components-ios/commit/171e5bfbc553585b1a798d22b269ce6c92afbcca) (Adrian Secord)
* [Updated refs to GitHub repo with new location. (#885)](https://github.com/material-components/material-components-ios/commit/2997e50c4c502b97606f7511cc6951a0552a0523) (Adrian Secord)
* [[Readme] Removing dead link in components.](https://github.com/material-components/material-components-ios/commit/5ca7c0bcf8e19f827b565911eaf3a3ef453525a3) (Will Larche)

# 17.0.0

## API Diffs

### Buttons


#### MDCButton

*modified* method: `-setBackgroundColor:` in `MDCButton`

| Type of change: | key.deprecation_message |
|---|---|
| From: | `Use setBackgroundColor:forState: instead.` |
| To: | `  `

*modified* method: `-setBackgroundColor:` in `MDCButton`

| Type of change: | key.always_unavailable |
|---|---|
| From: | `0` |
| To: | `1` |

*modified* method: `-setBackgroundColor:` in `MDCButton`

| Type of change: | key.always_deprecated |
|---|---|
| From: | `1` |
| To: | `0` |

*modified* method: `-setBackgroundColor:` in `MDCButton`

| Type of change: | declaration |
|---|---|
| From: | `- (void)setBackgroundColor:(nullable UIColor *)backgroundColor     __deprecated_msg("Use setBackgroundColor:forState: instead.");` |
| To: | `- (void)setBackgroundColor:(nullable UIColor *)backgroundColor;` |

### CollectionCells


#### MDCCollectionViewCell

*new* property: `editingSelectorColor` in `MDCCollectionViewCell`


## Component changes

### Buttons

#### Changes

* [[Button] Made setBackgroundColor unavailable and corrected updateTitle and update baoground order of operations. (#822)](https://github.com/material-components/material-components-ios/commit/33d4839bca3b253e1a4277418b0e47cc69a01e3e) (Randall Li)

### CollectionCells

#### Changes

* [Add color property for editing selector in MDCCollectionViewCell (#844)](https://github.com/material-components/material-components-ios/commit/ba36035d48d37511d7c205eed3ab3a8bc171030f) (Gauthier Ambard)
* [Handle separator insets correctly in RTL](https://github.com/material-components/material-components-ios/commit/c6f6fb85460284463369d2e5fa220ecad597f616) (Louis Romero)
* [Set checked cell's accessibility trait to Selected](https://github.com/material-components/material-components-ios/commit/bb78cbb9d463e16b5118a7826e81adb9a00a3ff0) (Louis Romero)



# 16.3.0

## API diffs

### Snackbar

- [new] [`MDCSnackbar setPresentationHostView:`](https://github.com/material-components/material-components-ios/commit/ee84a40885724453da69ca90bfa6a874008dc0b0)

## Component changes

### CollectionCells

#### Changes

* [[CollectionViewCell] Call |layoutSubviews| when editing (#798)](https://github.com/material-components/material-components-ios/commit/393d6214e08b1ff5bc359a1cfc6f816abe7b2e67) (Gauthier Ambard)

### Collections

#### Changes

* [Change layout invalidation in MDCCollectionViewStyler (#790)](https://github.com/material-components/material-components-ios/commit/82f7758bad9d4573f49d3656816df128642a8968) (Gauthier Ambard)

### FeatureHighlight

#### Changes

* [Convert CGFloats to float for 32 bit compilation (#834)](https://github.com/material-components/material-components-ios/commit/28f1d43595cd2a3fa109acb275214e50c810e94d) (Sam Morrison)

### Snackbar

#### Changes

* [[MDCSnackbar]! Add presentationHostView property to snackbar (#784)](https://github.com/material-components/material-components-ios/commit/ee84a40885724453da69ca90bfa6a874008dc0b0) (Sam Morrison)

# 16.2.0

## API diffs

### FeatureHighlight

* [FeatureHighlight](https://github.com/material-components/material-components-ios/commit/d4806473e49e65f0e9cc52139e39c3f1eba4f499) is a new component that lets you highlight a particular feature of your interface to the user.

## Component changes

### AppBar

#### Changes

* [Ensure typical use examples match for Objective C and Swift (#815)](https://github.com/material-components/material-components-ios/commit/09fb272376e814677f2936651906fd764618ea05) (Junius Gunaratne)

### CollectionCells

#### Changes

* [Align text labels frames to the upper pixel.](https://github.com/material-components/material-components-ios/commit/5a1a23d3c69c1c652b317219e1bb51d163000d4d) (Louis Romero)
* [Show/hide the editing box as entering/leaving edit](https://github.com/material-components/material-components-ios/commit/12206c44e72bd133f77a8d7373614f19cc73ec88) (Louis Romero)

### Collections

#### Changes

* [Fix -[MDCCollectionViewFlowLayout updateCellStateMaskWithAttribute:] (#732)](https://github.com/material-components/material-components-ios/commit/f2b93ae1119b28ee0685b780ccdd7e2a8044da2d) (Jackie Quinn)

### FeatureHighlight

#### Changes

* [MDCFeatureHighlightViewController implementation (#765)](https://github.com/material-components/material-components-ios/commit/d4806473e49e65f0e9cc52139e39c3f1eba4f499) (Sam Morrison)
* [Minor feature highlight fixes (#814)](https://github.com/material-components/material-components-ios/commit/b1c814d038b2cccaed76a7048deac1ae3771d7cd) (Sam Morrison)

### NavigationBar

#### Changes

* [Setting default state of textAlignment (#817)](https://github.com/material-components/material-components-ios/commit/9e947eba06b09ab8ad901af9d2a8001fac824daf) (Randall Li)
* [[Navigation Bar] Fixed text alignment in a better way that accepts the pre iOS8 default. (#820)](https://github.com/material-components/material-components-ios/commit/328631c19a2b89b0f4d8c11c24796ad0963976ee) (Randall Li)

### Switch

#### Changes

* [Added haptic feedback to MDCSwitch (#812)](https://github.com/material-components/material-components-ios/commit/6aae38dfa70db77929ef2952ff3b8fce3caea60b) (Adrian Secord)

# 16.1.0

## Component changes

### ActivityIndicator

#### Changes

* [Implement intrinsicContentSize (#795)](https://github.com/material-components/material-components-ios/commit/731eb321d94eb4957613e1059570cae17a584133) (Louis Romero)

### Buttons

#### Changes

* [MDC #329 - Bounded ink should ignore the maxRippleRadius property (#771)](https://github.com/material-components/material-components-ios/commit/01b73cf1478083baeb9976d4af12a67f02f9cb82) (Justin Shephard)

### Dialogs

#### Changes

* [Improve snackbar and dialogs docs (#785)](https://github.com/material-components/material-components-ios/commit/386964baf25fa9264516f9f0c9ed19410873f1fe) (Sam Morrison)

### Ink

#### Changes

* [Added MDCInkGestureRecognizer.h to Ink's umbrella header. (#801)](https://github.com/material-components/material-components-ios/commit/d24532bc40e0082dc8383d6431feceafa38ec050) (Adrian Secord)
* [MDC #329 - Bounded ink should ignore the maxRippleRadius property (#771)](https://github.com/material-components/material-components-ios/commit/01b73cf1478083baeb9976d4af12a67f02f9cb82) (Justin Shephard)
* [[MDCInkView] cancelAllAnimationsAnimated should support disabling animation (#786)](https://github.com/material-components/material-components-ios/commit/8008e82bd7bea04534ad7ecb2c3aa1903254553e) (Junius Gunaratne)

### ProgressView

#### Changes

* [[MDCProgressView] Execute completion block when setHidden:animated:completion is called sequentially (#787)](https://github.com/material-components/material-components-ios/commit/45c0b06275e88c65c7aae8bba1b78889cba2f93c) (Junius Gunaratne)

### Snackbar

#### Changes

* [Improve snackbar and dialogs docs (#785)](https://github.com/material-components/material-components-ios/commit/386964baf25fa9264516f9f0c9ed19410873f1fe) (Sam Morrison)



# 16.0.0

## API diffs

### InkTouchController

- [deleted] [`MDCInkTouchController.inkView`](https://github.com/material-components/material-components-ios/blob/c39811a2344114302327b6fa64d86346bacbea9a/components/Ink/src/MDCInkTouchController.h#L119)

## Component changes

### AppBar

#### Changes

* [Let the content view controller decide orientation](https://github.com/material-components/material-components-ios/commit/1a3069ff8de8eb406c037a1ff6738093c57efeee) (Louis Romero)

### Dialogs

#### Changes

* [Documentation Updates](https://github.com/material-components/material-components-ios/commit/f1b983465f304efc52d8c792af19b76d88a4a7b2) (Ian Gordon)

### Ink

#### Changes

* [Remove deprecated inkView property](https://github.com/material-components/material-components-ios/commit/2ce6d648292b8dcae90241a5c39405bfa368e1e4) (Junius Gunaratne)
* [define UIGestureRecognizerStateRecognized (#751)](https://github.com/material-components/material-components-ios/commit/4873362130f5d5c1893383dd9f6bfc71506dbbd9) (Junius Gunaratne)

### ShadowElevations

#### Changes

* [Documentation Updates](https://github.com/material-components/material-components-ios/commit/f1b983465f304efc52d8c792af19b76d88a4a7b2) (Ian Gordon)

### ShadowLayer

#### Changes

* [Documentation Updates](https://github.com/material-components/material-components-ios/commit/f1b983465f304efc52d8c792af19b76d88a4a7b2) (Ian Gordon)

### Switch

#### Changes

* [Update colours of MDCSwitch when changing tint color. (#758)](https://github.com/material-components/material-components-ios/commit/6f7b4ebf2b8c0225f02ef27779c204cc181d3abb) (Sylvain Defresne)
* [[MDCSwitch] Update objective-c example to match swift (#777)](https://github.com/material-components/material-components-ios/commit/ceeba259683892b63c474c6d51f86ee20aae0e07) (Chuck Hays)



# 15.2.0

## API diffs

### Palettes

- [new] [`MDCPalette.paletteGeneratedFromColor`](https://github.com/material-components/material-components-ios/blob/fad8519b6a1ba5c29a0368fb470cca3c6da74431/components/Palettes/src/MDCPalettes.h#L137)

## Component changes

### FlexibleHeader

#### Changes

* [MDC_#121 - Added write-up for re-applying swipe to go back feature on MDCFlexibleHeaderController with hidden navigation bar in README.md](https://github.com/material-components/material-components-ios/commit/1aadd7f468d1d00b7fcbc6c4f9979986229f3df7) (Justin Shephard)

### Ink

#### Changes

* [Added emphasis to reference count warning.](https://github.com/material-components/material-components-ios/commit/6a7a48a9ebb2cb94cdb253e06298a07132db92bd) (Will Larche)
* [Handling lack of strong reference to ink touch controller in both examples and instructions.](https://github.com/material-components/material-components-ios/commit/ca5b9a9ef775e06234cec8f64477402d65153670) (Will Larche)

### NavigationBar

#### Changes

* [[NavBar] Corrected mapping of NSTextAlignment to MDCNavigationBarTitleAligment](https://github.com/material-components/material-components-ios/commit/fdf1ff083d3c27c00263251c7fac5738317ce896) (randallli)

### Palettes

#### Changes

* [Added missing example initializer.](https://github.com/material-components/material-components-ios/commit/f5378746668facc793bf31c96a27a4e6b47324d3) (Adrian Secord)
* [Generate palettes to match a target color (#729)](https://github.com/material-components/material-components-ios/commit/fad8519b6a1ba5c29a0368fb470cca3c6da74431) (Adrian Secord)

# 15.1.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 203562553800ed3d3b5eebfd1dd76cda875d833c -n f8e2c8b5e87d0414f6b08f691949ecebfaca41b8

### Ink

- [moved] [`MDCInkGestureRecognizer`](https://github.com/material-components/material-components-ios/blob/f8e2c8b5e87d0414f6b08f691949ecebfaca41b8/components/Ink/src/MDCInkGestureRecognizer.h#L26).
From *private/MDCInkGestureRecognizer.h* to *MDCInkGestureRecognizer.h*.

### NavigationBar

- [new] [`MDCNavigationBar.titleAlignment`](https://github.com/material-components/material-components-ios/blob/f8e2c8b5e87d0414f6b08f691949ecebfaca41b8/components/NavigationBar/src/MDCNavigationBar.h#L121)
- [new] [`MDCNavigationBarTitleAlignmentCenter`](https://github.com/material-components/material-components-ios/blob/f8e2c8b5e87d0414f6b08f691949ecebfaca41b8/components/NavigationBar/src/MDCNavigationBar.h#L24)
- [new] [`MDCNavigationBarTitleAlignmentLeading`](https://github.com/material-components/material-components-ios/blob/f8e2c8b5e87d0414f6b08f691949ecebfaca41b8/components/NavigationBar/src/MDCNavigationBar.h#L26)
- [new] [`MDCNavigationBarTitleAlignment`](https://github.com/material-components/material-components-ios/blob/f8e2c8b5e87d0414f6b08f691949ecebfaca41b8/components/NavigationBar/src/MDCNavigationBar.h#L22)
- [deprecated] [`MDCNavigationBar.textAlignment`](https://github.com/material-components/material-components-ios/blob/f8e2c8b5e87d0414f6b08f691949ecebfaca41b8/components/NavigationBar/src/MDCNavigationBar.h#L163).
*Use titleAlignment instead.*

## Component changes

### ButtonBar

#### Changes

* [Better disabled look (#704)](https://github.com/material-components/material-components-ios/commit/853a3c5d7591b76ffdd3618baf8890f4c391e61c) (Louis Romero)

### CollectionCells

#### Changes

* [MDC_#803 - Fixed multi touch handling in MDCCollectionViews](https://github.com/material-components/material-components-ios/commit/b5b128784c6182b5ed9de546adaaed8e9b44fcfa) (Justin Shephard)

### Collections

#### Changes

* [MDC_#803 - Fixed multi touch handling in MDCCollectionViews](https://github.com/material-components/material-components-ios/commit/b5b128784c6182b5ed9de546adaaed8e9b44fcfa) (Justin Shephard)
* [Showcase a collectionView footer that does not have card style background in a card style collectionView. (#709)](https://github.com/material-components/material-components-ios/commit/68651011a0e6072daa9802f1cf2eef812f4c4d64) (Ed Chin)

### Ink

#### Changes

* [Make MDCInkGestureRecognizer public](https://github.com/material-components/material-components-ios/commit/5ec47cef81370919d92f4561e756ab85f849c19c) (Junius Gunaratne)

### NavigationBar

#### Breaking changes

* [Switch to custom enum rather that reuse the NSTextAlignment so that we can strict our external API surface to the two options we want: Left and Center.](https://github.com/material-components/material-components-ios/commit/531a53b72ad42b40d16b1677729e33b7205dd6ab) (randallli)

# 15.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 1926458f491c928adfb573a6eda38b6d5b5bc55e -n c39811a2344114302327b6fa64d86346bacbea9a

### Dialogs

- [new] [`MDCDialogPresentationController.dismissOnBackgroundTap`](https://github.com/material-components/material-components-ios/blob/c39811a2344114302327b6fa64d86346bacbea9a/components/Dialogs/src/MDCDialogPresentationController.h#L47)
- [new] [`UIViewController (MaterialDialogs)`](https://github.com/material-components/material-components-ios/blob/c39811a2344114302327b6fa64d86346bacbea9a/components/Dialogs/src/UIViewController+MaterialDialogs.h#L28)
- [new] [`UIViewController.mdc_dialogPresentationController`](https://github.com/material-components/material-components-ios/blob/c39811a2344114302327b6fa64d86346bacbea9a/components/Dialogs/src/UIViewController+MaterialDialogs.h#L35)

### Ink

- [new] [`MDCInkTouchController.gestureRecognizer`](https://github.com/material-components/material-components-ios/blob/c39811a2344114302327b6fa64d86346bacbea9a/components/Ink/src/MDCInkTouchController.h#L73)

### NavigationBar

- [new] [`MDCNavigationBar.textAlignment`](https://github.com/material-components/material-components-ios/blob/c39811a2344114302327b6fa64d86346bacbea9a/components/NavigationBar/src/MDCNavigationBar.h#L110)

### Switch

- [protocols changed] [`MDCSwitch`](https://github.com/material-components/material-components-ios/blob/c39811a2344114302327b6fa64d86346bacbea9a/components/Switch/src/MDCSwitch.h#L32).
Removed *NSCoding*.
Added *NSSecureCoding*.

## Component changes

### Collections

#### Changes

* [- Added autoscroll functionality to MDCCollectionViewEditor class](https://github.com/material-components/material-components-ios/commit/54e319f6ab8ed52bb7e6810d3fae3c7829396f75) (Justin Shephard)

### Dialogs

#### Changes

* [Add disable background dismiss property](https://github.com/material-components/material-components-ios/commit/0e3b8b2a3521ebc3961df0938e8089b9969e9fa9) (Ian Gordon)
* [[Catalog] Restore Xcode 7 compatibility](https://github.com/material-components/material-components-ios/commit/7f596f6f2a82bf13e1392a3611ff885c04ce3c1e) (Ian Gordon)

### Ink

#### Changes

* [Expose ink gesture recognizer in MDCInkTouchController, prevent inkLayer color from being set to nil](https://github.com/material-components/material-components-ios/commit/868fa6677d6b4a9dd05e7231ce35fd693ecf3d97) (Junius Gunaratne)

### NavigationBar

#### Changes

* [[MDCNavigationBar] Add ability to center title based on iOS design guidelines](https://github.com/material-components/material-components-ios/commit/2afee9916a8ca37706d408b46e3fe64100cd56db) (randallli)

### Slider

#### Changes

* [Change MDCSlider and MDCSwitch to use NSSecureCoding](https://github.com/material-components/material-components-ios/commit/19a06ed4251e66f04e9fe8a0184e0937066270e0) (Sam Morrison)
* [MDC_#767 - Removed bad import and changed public delegate declaration of MDCThumbTrackDelegate to private.](https://github.com/material-components/material-components-ios/commit/4a7ee8154e7b175c91715b4f53217decabdb12ee) (Justin Shephard)

### Snackbar

#### Changes

* [Fix incorrect type annotation found by clang static analyzer. (#700)](https://github.com/material-components/material-components-ios/commit/e92b8bcecaaa9ad8347ee1eaba944cd37edeefa2) (Sylvain Defresne)

### Switch

#### Changes

* [Change MDCSlider and MDCSwitch to use NSSecureCoding](https://github.com/material-components/material-components-ios/commit/19a06ed4251e66f04e9fe8a0184e0937066270e0) (Sam Morrison)
* [Fixed Xcode 7 analyzer warnings about leaking CGPaths in MDCSwitch.](https://github.com/material-components/material-components-ios/commit/c2b4b3d258add88da728ed5016b50f94ef72ceff) (Adrian Secord)
* [[MDCSwitch] Only dispatch control events for user generated changes](https://github.com/material-components/material-components-ios/commit/90d54bcd555495aaa2c0a038b26e032636a00377) (Sam Morrison)

# 14.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 52692216832dc446ae2471bd2f42a40cd8746bbe -n 9ecf191c8d5fa6d8afc7ba119f4cb0ebe926483c

### FontDiskLoader

- [deleted] [`-[MDCFontDiskLoader initWithName:URL:]`](https://github.com/material-components/material-components-ios/blob/52692216832dc446ae2471bd2f42a40cd8746bbe/components/FontDiskLoader/src/MDCFontDiskLoader.h#L99)
- [deleted] [`-[MDCFontDiskLoader registerFont]`](https://github.com/material-components/material-components-ios/blob/52692216832dc446ae2471bd2f42a40cd8746bbe/components/FontDiskLoader/src/MDCFontDiskLoader.h#L107)
- [deleted] [`-[MDCFontDiskLoader setFontName:]`](https://github.com/material-components/material-components-ios/blob/52692216832dc446ae2471bd2f42a40cd8746bbe/components/FontDiskLoader/src/MDCFontDiskLoader.h#L123)
- [deleted] [`-[MDCFontDiskLoader unregisterFont]`](https://github.com/material-components/material-components-ios/blob/52692216832dc446ae2471bd2f42a40cd8746bbe/components/FontDiskLoader/src/MDCFontDiskLoader.h#L110)
- [deleted] [`MDCFontDiskLoader.hasFailedRegistration`](https://github.com/material-components/material-components-ios/blob/52692216832dc446ae2471bd2f42a40cd8746bbe/components/FontDiskLoader/src/MDCFontDiskLoader.h#L117)
- [deleted] [`MDCFontDiskLoader.isRegistered`](https://github.com/material-components/material-components-ios/blob/52692216832dc446ae2471bd2f42a40cd8746bbe/components/FontDiskLoader/src/MDCFontDiskLoader.h#L113)

## Component changes

### Buttons

#### Changes

* [MDC_#67 - Updated accessibility for titleColor on MDCButton.m](https://github.com/material-components/material-components-ios/commit/eb40e5e56f652ba0ddef1f6bcaecdbfe3a9a8f10) (Justin Shephard)

### Collections

#### Changes

* [Removed all warnings from the build.](https://github.com/material-components/material-components-ios/commit/0b57f48e1dd7e5260d45a13ac5c2650860ce2913) (Adrian Secord)

### FlexibleHeader

#### Changes

* [MDC_#67 - Updated accessibility for titleColor on MDCButton.m](https://github.com/material-components/material-components-ios/commit/eb40e5e56f652ba0ddef1f6bcaecdbfe3a9a8f10) (Justin Shephard)
* [Removed all warnings from the build.](https://github.com/material-components/material-components-ios/commit/0b57f48e1dd7e5260d45a13ac5c2650860ce2913) (Adrian Secord)

### FontDiskLoader

#### Breaking changes

* [**Breaking**:  Deleted deprecated API.](https://github.com/material-components/material-components-ios/commit/da386bb06fca7b7696162d2058c883bb40abeac7) (randallli)

### Ink

#### Changes

* [Removed all warnings from the build.](https://github.com/material-components/material-components-ios/commit/0b57f48e1dd7e5260d45a13ac5c2650860ce2913) (Adrian Secord)

### Palettes

#### Changes

* [Fix tintKey parameter type in MDCPalettes.m (#699)](https://github.com/material-components/material-components-ios/commit/e9c24ed27f0ea130b7d8ab7f42181b11da263ff2) (Jackie Quinn)

### ProgressView

#### Changes

* [Removed all warnings from the build.](https://github.com/material-components/material-components-ios/commit/0b57f48e1dd7e5260d45a13ac5c2650860ce2913) (Adrian Secord)
* [Use a proper singleton for our accessibility proxy.](https://github.com/material-components/material-components-ios/commit/5d39f92db51f4982150a6968f85a797b4061ab5a) (Ian Gordon)

### RobotoFontLoader

#### Changes

* [Revert "Trim fonts for mobile use (#674)"](https://github.com/material-components/material-components-ios/commit/0607e7a1f41d3411dc3132b1c18a802e503b7525) (randallli)
* [Trim fonts for mobile use (#674)](https://github.com/material-components/material-components-ios/commit/88f30a4bd6b7e7df241c5d1bddfc47e5c0df5296) (rsheeter)

### ShadowLayer

#### Changes

* [Fix calculation of masks for the shadows. (#698)](https://github.com/material-components/material-components-ios/commit/0b2b4feec8486ed074701b5195b1e176e5af4034) (Simon Forsyth)

### Switch

#### Changes

* [Optimize and simplify MDCSwitch](https://github.com/material-components/material-components-ios/commit/cd1ac75d8fcadd328aa93e9b661e7b063ebda6d4) (Sam Morrison)
* [Removed all warnings from the build.](https://github.com/material-components/material-components-ios/commit/0b57f48e1dd7e5260d45a13ac5c2650860ce2913) (Adrian Secord)

# 13.4.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o fb77a9716a80ba4ee2a9f92a81a89335570366e3 -n 8fa99ffb150b99597f19783d54203ff77a4219d2

### FontDiskLoader

- [deprecated] [`-[MDCFontDiskLoader initWithName:URL:]`](https://github.com/material-components/material-components-ios/blob/8fa99ffb150b99597f19783d54203ff77a4219d2/components/FontDiskLoader/src/MDCFontDiskLoader.h#L99).
*Use initWithFontName:fontURL: instead.*
- [deprecated] [`-[MDCFontDiskLoader registerFont]`](https://github.com/material-components/material-components-ios/blob/8fa99ffb150b99597f19783d54203ff77a4219d2/components/FontDiskLoader/src/MDCFontDiskLoader.h#L107).
*Use load instead.*
- [deprecated] [`-[MDCFontDiskLoader setFontName:]`](https://github.com/material-components/material-components-ios/blob/8fa99ffb150b99597f19783d54203ff77a4219d2/components/FontDiskLoader/src/MDCFontDiskLoader.h#L123).
*Create a new instance if you need to specifiy a different font name.*
- [deprecated] [`-[MDCFontDiskLoader unregisterFont]`](https://github.com/material-components/material-components-ios/blob/8fa99ffb150b99597f19783d54203ff77a4219d2/components/FontDiskLoader/src/MDCFontDiskLoader.h#L110).
*Use unload instead.*
- [deprecated] [`MDCFontDiskLoader.hasFailedRegistration`](https://github.com/material-components/material-components-ios/blob/8fa99ffb150b99597f19783d54203ff77a4219d2/components/FontDiskLoader/src/MDCFontDiskLoader.h#L117).
*Use loadFailed instead.*
- [deprecated] [`MDCFontDiskLoader.isRegistered`](https://github.com/material-components/material-components-ios/blob/8fa99ffb150b99597f19783d54203ff77a4219d2/components/FontDiskLoader/src/MDCFontDiskLoader.h#L113).
*Use loaded instead.*

## Component changes

### AppBar

#### Changes

* [Removed reference to deleted MDCAppBarParenting.](https://github.com/material-components/material-components-ios/commit/80d36a3500ecab7ab45e94fb7405069460cd6692) (Adrian Secord)
* [[MDCAppBar | MDCDialog | MDCInk] Nullability Clashing](https://github.com/material-components/material-components-ios/commit/7633f1e4307d36c32afc62e866f9e40765a81fc3) (Sean O'Shea)

### Dialogs

#### Changes

* [Correct analyzer and compiler warnings.](https://github.com/material-components/material-components-ios/commit/4a0986a38919dc2a030cc451da490359721837d5) (Ian Gordon)
* [[MDCAppBar | MDCDialog | MDCInk] Nullability Clashing](https://github.com/material-components/material-components-ios/commit/7633f1e4307d36c32afc62e866f9e40765a81fc3) (Sean O'Shea)

### FontDiskLoader

#### Changes

* [Fixed readme reference to new initializer](https://github.com/material-components/material-components-ios/commit/d973f1b86dbbf1f2dfb5f37fe2a0445fd70402fa) (randallli)
* [[FontDiskLoader]? Marked API deprecated that we were planing on deprecating from previous readbility change](https://github.com/material-components/material-components-ios/commit/a58c236f831ef151c0eafd47dd9bac8684f28fdb) (randallli)

### Ink

#### Changes

* [[MDCAppBar | MDCDialog | MDCInk] Nullability Clashing](https://github.com/material-components/material-components-ios/commit/7633f1e4307d36c32afc62e866f9e40765a81fc3) (Sean O'Shea)
* [[MDCInkTouchController] Improve comments to clarify method and protocol behavior](https://github.com/material-components/material-components-ios/commit/51ced6a4a2fc663516b6581e81a4351344e0dace) (Junius Gunaratne)

### Slider

#### Changes

* [Changed clamping behaviour of the min setter to mutate the max instead of clamping to its value.](https://github.com/material-components/material-components-ios/commit/f3288569659d85a41e939005cac40915ffece286) (randallli)

### Switch

#### Changes

* [Remove SKDisplayLinkInterface left over in MDCSwitch stress test](https://github.com/material-components/material-components-ios/commit/f19a6c92a1c59c846a191f08fd587aebf099d596) (Sam Morrison)
* [Stress test for MDCSwitch](https://github.com/material-components/material-components-ios/commit/63d907e24ea53a4e31ac668b0ac982ab83868311) (Sam Morrison)

# 13.3.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 51fbbacdf98a1f086cdbf6210f849c8133e91183 -n dd3d2622f6935e70854d3ccb72677b09e19e045a

### FontDiskLoader

- [new] [`-[MDCFontDiskLoader initWithFontName:fontURL:]`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/FontDiskLoader/src/MDCFontDiskLoader.h#L36)
- [new] [`-[MDCFontDiskLoader load]`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/FontDiskLoader/src/MDCFontDiskLoader.h#L87)
- [new] [`-[MDCFontDiskLoader unload]`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/FontDiskLoader/src/MDCFontDiskLoader.h#L96)
- [new] [`MDCFontDiskLoader.loadFailed`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/FontDiskLoader/src/MDCFontDiskLoader.h#L76)
- [new] [`MDCFontDiskLoader.loaded`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/FontDiskLoader/src/MDCFontDiskLoader.h#L69)
- [property attribute change] [`MDCFontDiskLoader.fontName`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/FontDiskLoader/src/MDCFontDiskLoader.h#L59).
Removed *strong*.
Added *readonly, copy*.
- [property attribute change] [`MDCFontDiskLoader.fontURL`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/FontDiskLoader/src/MDCFontDiskLoader.h#L62).
Removed *strong, nullable*.
Added *copy, nonnull*.
- [declaration changed] [`-[MDCFontDiskLoader setFontName:]`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/FontDiskLoader/src/MDCFontDiskLoader.h#L120).
```
@property (nonatomic, strong, nonnull) NSString *fontName
- (void)setFontName:(nonnull NSString *)fontName
```

### RobotoFontLoader

- [declaration changed] [`+[MDCRobotoFontLoader sharedInstance]`](https://github.com/material-components/material-components-ios/blob/dd3d2622f6935e70854d3ccb72677b09e19e045a/components/RobotoFontLoader/src/MDCRobotoFontLoader.h#L27).
```
+ (nonnull instancetype)sharedInstance
+ (nonnull MDCRobotoFontLoader *)sharedInstance
```


## Component changes

### ActivityIndicator

#### Changes

* [MDC_#758 - Updated incorrectly named setter](https://github.com/material-components/material-components-ios/commit/ad8986dc35203851861ee5004ca723465fd20cff) (Justin Shephard)

### Buttons

#### Changes

* [[FontDiskLoader, RobotoFontLoader, Typography] The results of some readability code reviews from some googlers.](https://github.com/material-components/material-components-ios/commit/ffd56e6d3017c5e107de5e537fc1510f1e4ee88e) (randallli)

### CollectionLayoutAttributes

#### Changes

* [[FontDiskLoader, RobotoFontLoader, Typography] The results of some readability code reviews from some googlers.](https://github.com/material-components/material-components-ios/commit/ffd56e6d3017c5e107de5e537fc1510f1e4ee88e) (randallli)

### Dialogs

#### Changes

* [Dismiss the dialog when we recive the Z A11y gesture](https://github.com/material-components/material-components-ios/commit/f2f95d647cbf345b665c2ab683a8b9179821b682) (Felix Emiliano)

### FlexibleHeader

#### Changes

* [Added `-Wnewline-eof` warning to MDC and MDFTextAccessibility, fix one issue.](https://github.com/material-components/material-components-ios/commit/89e7306d03f33f503e778d5c1444c4699921d1a4) (Adrian Secord)

### FontDiskLoader

#### Changes

* [[FontDiskLoader, RobotoFontLoader, Typography] The results of some readability code reviews from some googlers.](https://github.com/material-components/material-components-ios/commit/ffd56e6d3017c5e107de5e537fc1510f1e4ee88e) (randallli)

### RobotoFontLoader

#### Changes

* [[FontDiskLoader, RobotoFontLoader, Typography] The results of some readability code reviews from some googlers.](https://github.com/material-components/material-components-ios/commit/ffd56e6d3017c5e107de5e537fc1510f1e4ee88e) (randallli)

### Slider

#### Changes

* [[FontDiskLoader, RobotoFontLoader, Typography] The results of some readability code reviews from some googlers.](https://github.com/material-components/material-components-ios/commit/ffd56e6d3017c5e107de5e537fc1510f1e4ee88e) (randallli)

### Typography

#### Changes

* [[FontDiskLoader, RobotoFontLoader, Typography] The results of some readability code reviews from some googlers.](https://github.com/material-components/material-components-ios/commit/ffd56e6d3017c5e107de5e537fc1510f1e4ee88e) (randallli)

# 13.2.1

## API diffs

### Icons

- [new] [Added method to enable testing of new back button style](https://github.com/material-components/material-components-ios/commit/e9175eddabea93bd367e04e97d24cb71900430d1) (Sam Morrison)

## Component changes

### AppBar

#### Changes

* [Adding link to MDCAppBar.h apidoc to the README](https://github.com/material-components/material-components-ios/commit/b3c17a6ab23e758ff058946eb2f3dfdabada08c5) (Will Larche)
* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)
* [AppBar dependency warning](https://github.com/material-components/material-components-ios/commit/585343e5fed11a83f48a6929a47b91453f4ddb2e) (Will Larche)

### ButtonBar

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### Buttons

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### CollectionCells

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### CollectionLayoutAttributes

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### Collections

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### Dialogs

#### Changes

* [Some examples are missing super calls to viewDidLoad (#681)](https://github.com/material-components/material-components-ios/commit/ef7d60b174f7114a37c9387a7bc3ed70cb730e28) (Sean O'Shea)

### FlexibleHeader

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)
* [Some examples are missing super calls to viewDidLoad (#681)](https://github.com/material-components/material-components-ios/commit/ef7d60b174f7114a37c9387a7bc3ed70cb730e28) (Sean O'Shea)

### FontDiskLoader

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### HeaderStackView

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### Ink

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### NavigationBar

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### PageControl

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### Palettes

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### ProgressView

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### RobotoFontLoader

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### ShadowElevations

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### ShadowLayer

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)
* [Small MDCShadowLayer fixes](https://github.com/material-components/material-components-ios/commit/592ce9d54d6328dbfb8aa14f58d5b0b16953aefb) (Sam Morrison)

### Slider

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### Switch

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)

### Typography

#### Changes

* [API docs links were broken in READMEs](https://github.com/material-components/material-components-ios/commit/7a4c71801fd17d7a6250b9fbe4fa8dafc1ca04be) (Will Larche)
* [Typo in README](https://github.com/material-components/material-components-ios/commit/32c499aee17e9f881dcb8f0ae922d20fc9da1736) (Will Larche)

# 13.2.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 6b00b97156fcd8ed5a661c736df6b363cf4c8457 -n 9ef47c149996f078e5f6a4ed3474688e187ab573

### Slider

- [new] [Property for whether or not thumb is hollow at minimum value](https://github.com/material-components/material-components-ios/commit/19ab4675a6d76fdcfb53b528df8be5c9d34e3ce4)

### SpritedAnimationView

- [new] [`-[MDCSpritedAnimationView initWithSpriteSheetImage:numberOfFrames:]`](https://github.com/material-components/material-components-ios/blob/9ef47c149996f078e5f6a4ed3474688e187ab573/components/SpritedAnimationView/src/MDCSpritedAnimationView.h#L83)

## Component changes

### ActivityIndicator

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### AnimationTiming

#### Changes

* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### AppBar

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### ButtonBar

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### Buttons

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)
* [Updating the button README to remove references to Ink. (#675)](https://github.com/material-components/material-components-ios/commit/1b9fd332422517a26de92bd45e7b25b88e4656da) (Sean O'Shea)

### CollectionCells

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### CollectionLayoutAttributes

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### Collections

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### Dialogs

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### FlexibleHeader

#### Changes

* [MDC_#391_Copy_Change - Made modifications to copy on limited number of controllers without a back button](https://github.com/material-components/material-components-ios/commit/5c01be1f355e9474449f53e1fd473023fd1c36ec) (Justin Shephard)
* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### FontDiskLoader

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### HeaderStackView

#### Changes

* [MDC_#391_Copy_Change - Made modifications to copy on limited number of controllers without a back button](https://github.com/material-components/material-components-ios/commit/5c01be1f355e9474449f53e1fd473023fd1c36ec) (Justin Shephard)
* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### Ink

#### Changes

* [Fix build. Delegate cast was incorrect and invoked on the wrong object.](https://github.com/material-components/material-components-ios/commit/9ef47c149996f078e5f6a4ed3474688e187ab573) (randallli)
* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)
* [[MDCInkTouchController] Provide legacy support for shouldInkTouchControllerProcessInkTouches during transition to inkTouchController:shouldProcessInkTouchesAtTouchLocation](https://github.com/material-components/material-components-ios/commit/6f76c3de6ec24c82d0e649ff6b8f41ef7bc251b0) (Junius Gunaratne)

### NavigationBar

#### Changes

* [MDC_#391_Copy_Change - Made modifications to copy on limited number of controllers without a back button](https://github.com/material-components/material-components-ios/commit/5c01be1f355e9474449f53e1fd473023fd1c36ec) (Justin Shephard)
* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### OverlayWindow

#### Changes

* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### PageControl

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### Palettes

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### ProgressView

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### RobotoFontLoader

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### ShadowElevations

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### ShadowLayer

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### Slider

#### Changes

* [Expanded slider demo within a collection view.](https://github.com/material-components/material-components-ios/commit/72088f48cba399b0daa55bcc44e725774790db84) (Max Luzuriaga)
* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Property for whether or not thumb is hollow at minimum value](https://github.com/material-components/material-components-ios/commit/19ab4675a6d76fdcfb53b528df8be5c9d34e3ce4) (Max Luzuriaga)
* [Rename thumbIsHollowAtStart to isThumbHollowAtStart](https://github.com/material-components/material-components-ios/commit/14e1943f44107be086c842d38f1c2e5194caab3b) (Max Luzuriaga)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)
* [ThumbHollowAtStart property better named with obj-c conventions](https://github.com/material-components/material-components-ios/commit/eebab2557dc1678e947581fe1953827301c5aac9) (Max Luzuriaga)

### Snackbar

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### SpritedAnimationView

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)
* [[Sprited Animation View] Support non-square sprite images. (#683)](https://github.com/material-components/material-components-ios/commit/0570c6cbd6d4940718a3cc3c2b5ce4e054fa9799) (Jason Ting)

### Switch

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

### Typography

#### Changes

* [MDC_#546 - Start of separation of README.md and yaml](https://github.com/material-components/material-components-ios/commit/685ea43198ef084b45cd7c6c29e57beb096b3d1d) (Justin Shephard)
* [Site_Readme_Links - Added Jekyll conditional with links to site/github documentation](https://github.com/material-components/material-components-ios/commit/f53506ea2802215375a60b3c429f9d6f5b219026) (Justin Shephard)

# 13.1.1

## Component changes

### Snackbar

#### Changes

* [iOS10+ hotfix.](https://github.com/material-components/material-components-ios/commit/dd2de7c8573ab353274bec4f069a3538f2108a17) (Peter Lee)


# 13.1.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 5d7ad466b9e1429ad6242272958b149ded34da63 -n 205b1b49fd311af9246133e1499007dec0957e4b

### AnimationTiming

**New component.**

### Switch

- [new] [`MDCSwitch.offAccessibilityValue`](https://github.com/material-components/material-components-ios/blob/205b1b49fd311af9246133e1499007dec0957e4b/components/Switch/src/MDCSwitch.h#L78)
- [new] [`MDCSwitch.onAccessibilityValue`](https://github.com/material-components/material-components-ios/blob/205b1b49fd311af9246133e1499007dec0957e4b/components/Switch/src/MDCSwitch.h#L70)

## Component changes

### ActivityIndicator

#### Changes

* [Add RTL to activity indicator.](https://github.com/material-components/material-components-ios/commit/457ea7c3cb49cfb954b2f42ea2ff7cde0b5bda8d) (Ian Gordon)
* [Fix commonInit method.](https://github.com/material-components/material-components-ios/commit/fc4e0a4827c7f265d827fb9d7e46c8f5acd79cc8) (Ian Gordon)
* [Removing the last few remaining references to using id as a return type (#671)](https://github.com/material-components/material-components-ios/commit/bee2af6211586a044415a57e1a66b737df21beb3) (Sean O'Shea)

### AnimationTiming

#### Changes

* [Add animation timing curves and examples, update use of animation timing in snackbar](https://github.com/material-components/material-components-ios/commit/22cfb756faf4e6c6e39913ca6b88e43839af447f) (Junius Gunaratne)

### AppBar

#### Changes

* [[Catalog, NavigationBar] Update catalog to set custom title color using titleTextAttributes; only set attributedText when title is set](https://github.com/material-components/material-components-ios/commit/205b1b49fd311af9246133e1499007dec0957e4b) (Junius Gunaratne)

### Buttons

#### Changes

* [[MDCButton] Add UI_APPEARANCE_SELECTOR to customTextColor.](https://github.com/material-components/material-components-ios/commit/1aaa85381dfd1416f8e43a1b33ae6e8e5e53927b) (Ian Gordon)

### CollectionCells

#### Changes

* [Fix RTL layout for Collection Cells](https://github.com/material-components/material-components-ios/commit/9a0804f8ab2062429c4fe15c19dafc0649b245cb) (Ed Chin)

### Dialogs

#### Changes

* [Minor formatting issues which mostly impact the catalog app. (#666)](https://github.com/material-components/material-components-ios/commit/a944e1f354e0b05a78c207c69ce73eadbd985be2) (Sean O'Shea)
* [[MDCButton] Add UI_APPEARANCE_SELECTOR to customTextColor.](https://github.com/material-components/material-components-ios/commit/1aaa85381dfd1416f8e43a1b33ae6e8e5e53927b) (Ian Gordon)

### FlexibleHeader

#### Changes

* [Add example with UIKit components in flexible header](https://github.com/material-components/material-components-ios/commit/93171fa87c87fd79572805fa9dc861ace2fda4ef) (Junius Gunaratne)
* [Add page control in flexible header example](https://github.com/material-components/material-components-ios/commit/b118dcd97e25c9a18b7574142962c1ba904929d7) (Junius Gunaratne)
* [Add wrapped view controller example](https://github.com/material-components/material-components-ios/commit/41feee6549aefa64c8386e1e2bcc68d228fecc08) (Junius Gunaratne)
* [Prevent retain cycle in CADisplayLink in shift behavior.](https://github.com/material-components/material-components-ios/commit/1432c3cb78a51120815b32741456a55526c763fb) (randallli)
* [Update legal text to include Material Components for iOS authors](https://github.com/material-components/material-components-ios/commit/09cfde15ac055ca7d270556016b41c421659e3d1) (Junius Gunaratne)

### NavigationBar

#### Changes

* [[Catalog, NavigationBar] Update catalog to set custom title color using titleTextAttributes; only set attributedText when title is set](https://github.com/material-components/material-components-ios/commit/205b1b49fd311af9246133e1499007dec0957e4b) (Junius Gunaratne)
* [[MDCNavigationBar] Allow tintColor to change navigation bar title text by applying titleTextAttributes](https://github.com/material-components/material-components-ios/commit/d6b8c54ab09bfa14574c69154c610bcbbe5178ee) (Junius Gunaratne)
* [[MDCNavigationBar] Revert change that sets titleTextAttributes when tintColorDidChange is called](https://github.com/material-components/material-components-ios/commit/0591ee9f62360f9acc40c263a41669a5e4c67b0e) (Junius Gunaratne)

### OverlayWindow

#### Changes

* [Removing the last few remaining references to using id as a return type (#671)](https://github.com/material-components/material-components-ios/commit/bee2af6211586a044415a57e1a66b737df21beb3) (Sean O'Shea)

### PageControl

#### Changes

* [Removing the last few remaining references to using id as a return type (#671)](https://github.com/material-components/material-components-ios/commit/bee2af6211586a044415a57e1a66b737df21beb3) (Sean O'Shea)

### ShadowLayer

#### Changes

* [Removing the last few remaining references to using id as a return type (#671)](https://github.com/material-components/material-components-ios/commit/bee2af6211586a044415a57e1a66b737df21beb3) (Sean O'Shea)

### Slider

#### Changes

* [Delegate method for shouldJumpToValue:](https://github.com/material-components/material-components-ios/commit/2d6fc623edb90a9150e59f657635a9538227fa93) (Max Luzuriaga)
* [Expose filled track anchor value property](https://github.com/material-components/material-components-ios/commit/9b0d87f07f12653436269bdb86695dc01fa7bd9b) (Max Luzuriaga)
* [Expose thumbTrack to subclasses of MDCSlider](https://github.com/material-components/material-components-ios/commit/7045fa4e68eb1c1e5165ca803e7a5c870d24ba7f) (Max Luzuriaga)
* [Property for displaying discrete value label or not](https://github.com/material-components/material-components-ios/commit/eaff59d916e64a298a4ca10a83c6ca81eb549d12) (Max Luzuriaga)

### Snackbar

#### Changes

* [Minor formatting issues which mostly impact the catalog app. (#666)](https://github.com/material-components/material-components-ios/commit/a944e1f354e0b05a78c207c69ce73eadbd985be2) (Sean O'Shea)
* [[AnimationTiming] Add animation timing curves and examples, update use of animation timing in snackbar](https://github.com/material-components/material-components-ios/commit/22cfb756faf4e6c6e39913ca6b88e43839af447f) (Junius Gunaratne)
* [[README] Changing documentation to aid with compilation (#667)](https://github.com/material-components/material-components-ios/commit/acda73aff13e62ac72e1646ff7193116f4ac56a8) (Sean O'Shea)

### Switch

#### Changes

* [Add RTL support to Switch](https://github.com/material-components/material-components-ios/commit/8ab45d01b359e759ce7554a8fd7ec8c1b0c61a13) (Ian Gordon)
* [Custom accessibility labels](https://github.com/material-components/material-components-ios/commit/09b9fcc739329cf8f1a281b66ead482e0d7ded55) (Max Luzuriaga)
* [Switch init cleanup.](https://github.com/material-components/material-components-ios/commit/934b367452a432587669747a5c8aceadf2f5cf4d) (Ian Gordon)


# 13.0.2

## API diffs

Auto-generated by running:

    scripts/api_diff -o 313365e03bc6f74f43910264ee31d1e2721db36b -n e66a70dc0cd3bb40eb0f4ff3d5867bafba20db3a

No public API changes detected.

## Component changes

### ActivityIndicator

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [Pass last state by parameter instead of saving as iVar](https://github.com/material-components/material-components-ios/commit/b19cdb58759a848520b4e81607046a8f776e05ef) (David Couturier)
* [Ran arc lint.](https://github.com/material-components/material-components-ios/commit/ba4b193c60a338aa64895a0777016b14e47c1b1d) (Adrian Secord)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### AppBar

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### ButtonBar

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### Buttons

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### CollectionCells

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [Relayout the text cells on prepareForReuse.](https://github.com/material-components/material-components-ios/commit/163e839c879a0669a7bf9202fa9d34151958d752) (Louis Romero)

### CollectionLayoutAttributes

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### Collections

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [Removes unnecessary method overrides that only call super.](https://github.com/material-components/material-components-ios/commit/f8847a2e26cdc80f23bebebdbd748112a38a30ca) (Chris Cox)

### Dialogs

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [[Catalog] Add a dialog with an input field for keyboard testing](https://github.com/material-components/material-components-ios/commit/26719621fc6697761c5475738dba98efd7af01c8) (Ian Gordon)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### FlexibleHeader

#### Changes

* [Add flexible header demo with FAB](https://github.com/material-components/material-components-ios/commit/4dff6c81702906b145dcc146121bcfc5ca449ea2) (Junius Gunaratne)
* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [Use MDFTextAccessibility for determining whether or not to use the light status bar.](https://github.com/material-components/material-components-ios/commit/f1b4a2a48eddbca41057241f80ce840cd20a21f2) (Adrian Secord)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### FontDiskLoader

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### HeaderStackView

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### Ink

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### NavigationBar

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [Changed CGFloat macros to static inline functions.](https://github.com/material-components/material-components-ios/commit/d953ea0e314c4123ad29206ec92e8c5a3132caa0) (Adrian Secord)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### OverlayWindow

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### PageControl

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### Palettes

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### ProgressView

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### RobotoFontLoader

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### ShadowElevations

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### ShadowLayer

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### Slider

#### Changes

* [Add discrete numeric value label](https://github.com/material-components/material-components-ios/commit/b4ee4184463fae0ff3eade460f21ca76e2075255) (Max Luzuriaga)
* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [Make tests language-agnosti](https://github.com/material-components/material-components-ios/commit/8211a449216dc087f97554e54ca2e59bab0bb7e3) (Max Luzuriaga)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### Snackbar

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)

### SpritedAnimationView

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [Fix SpritedAnimationViewTests](https://github.com/material-components/material-components-ios/commit/716ad830108e727b8e400ca7d3d50ea886fc9b49) (Sam Morrison)

### Switch

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

### Typography

#### Changes

* [Adding AUTHORS and removing CONTRIBUTORS.txt.](https://github.com/material-components/material-components-ios/commit/8c3af252bedffef4ca09bd99a6b3de007d4f64ae) (Adrian Secord)
* [[Docs] Replaced incorrect name of the product. Material Components *for* iOS](https://github.com/material-components/material-components-ios/commit/681cc2b6f7a28ff81def1f2ff9baf8f7f51dbffe) (randallli)

# 13.0.1

Hotfix for Xcode 8.0 beta 3 (8S174q) compilation.

## API diffs

Auto-generated by running:

    scripts/api_diff -o 50ed805a58529c8cd3a0bfe56a9b99937134ad2c -n e8dbfebbb20f3d1314b5396e6cc1f76f9d23beb2

No public API changes detected.

## Component changes

### Collections

#### Changes

* [Source changes to fix Xcode 8 compilation.](https://github.com/material-components/material-components-ios/commit/6ce08f4c0fd500c18becb89b990c9a6ffeb89de7) (Adrian Secord)
* [Undo Xcode 8 changes to CollectionsStoryboardExample.storyboard.](https://github.com/material-components/material-components-ios/commit/e8dbfebbb20f3d1314b5396e6cc1f76f9d23beb2) (Adrian Secord)

### ProgressView

#### Changes

* [Source changes to fix Xcode 8 compilation.](https://github.com/material-components/material-components-ios/commit/6ce08f4c0fd500c18becb89b990c9a6ffeb89de7) (Adrian Secord)

### Snackbar

#### Changes

* [Source changes to fix Xcode 8 compilation.](https://github.com/material-components/material-components-ios/commit/6ce08f4c0fd500c18becb89b990c9a6ffeb89de7) (Adrian Secord)

### SpritedAnimationView

#### Changes

* [Source changes to fix Xcode 8 compilation.](https://github.com/material-components/material-components-ios/commit/6ce08f4c0fd500c18becb89b990c9a6ffeb89de7) (Adrian Secord)

# 13.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 0c7bda2e69db44668360b89e3403a7ad9e16c3aa -n 10e4a258fa529178d1aa6ae8962193eb18b43d20

### Dialogs

- [new] [`+[MDCAlertAction actionWithTitle:handler:]`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L117)
- [new] [`+[MDCAlertController alertControllerWithTitle:message:]`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L48)
- [new] [`-[MDCAlertController addAction:]`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L69)
- [new] [`MDCActionHandler`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L103)
- [new] [`MDCAlertAction.title`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L128)
- [new] [`MDCAlertAction`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L108)
- [new] [`MDCAlertController.actions`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L76)
- [new] [`MDCAlertController.message`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L90)
- [new] [`MDCAlertController.title`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L87)
- [new] [`MDCAlertController`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/Dialogs/src/MDCAlertController.h#L35)

### SpritedAnimationView

- [declaration changed] [`-[MDCSpritedAnimationView startAnimatingWithCompletion:]`](https://github.com/material-components/material-components-ios/blob/10e4a258fa529178d1aa6ae8962193eb18b43d20/components/SpritedAnimationView/src/MDCSpritedAnimationView.h#L85).
```
- (void)startAnimatingWithCompletion:(nullable void (^)())completion
- (void)startAnimatingWithCompletion:(nullable void (^)(BOOL))completion
```

## Component changes

### ActivityIndicator

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)

### AppBar

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)

### ButtonBar

#### Changes

* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)

### Buttons

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)

### CollectionCells

#### Changes

* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)
* [Various bug fixes for MDCCollectionViewCells](https://github.com/material-components/material-components-ios/commit/c7aa271784550c9b14c44c9f2815ea27bf5af225) (Sam Morrison)

### CollectionLayoutAttributes

#### Changes

* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)

### Collections

#### Changes

* [Fix delegate calls for moving an item](https://github.com/material-components/material-components-ios/commit/ed084ccbad4303321a8a87958c98e932a9050583) (randallli)
* [Fix storyboard usage of MDCCollectionViews](https://github.com/material-components/material-components-ios/commit/36164cd6e548ac4efed23df99848f62e003298a1) (Eric Shieh)
* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)

### Dialogs

#### Changes

* [Add Alert Controller](https://github.com/material-components/material-components-ios/commit/1fe4ac3f647727aeb75749d25bc5341bf751e8f6) (Ian Gordon)
* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Use migrated keyboard watcher code](https://github.com/material-components/material-components-ios/commit/df6016a51cc157fd0b9f62444e428a43a704d9fc) (Ian Gordon)
* [[KeyboardWatcher] Extract values from a notification](https://github.com/material-components/material-components-ios/commit/3bfc5f9c9058e0423d22d09ca2b9fdc69ffb0a70) (Ian Gordon)

### FlexibleHeader

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)
* [[MDC #624] Correctly initialize the shifterStatusBar when creating a MDCFlexibleHeaderView](https://github.com/material-components/material-components-ios/commit/f146473416188434ae2fb6b837bd9ce71863ea70) (Sam Morrison)

### HeaderStackView

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)

### Ink

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [MDC_#495 - Removed unused declaration of startPoint](https://github.com/material-components/material-components-ios/commit/f5e940c743836ff4bd589c81d9d12fae9af08c0b) (Justin Shephard)

### NavigationBar

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)

### PageControl

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)

### ProgressView

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)

### ShadowElevations

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)

### ShadowLayer

#### Changes

* [Add additional detail clarifying the difference between CALayer.zPosition and MDCShadowLayer.elevation.](https://github.com/material-components/material-components-ios/commit/56a519186f344e26f92122eaf1871a4530fa3a4f) (Ian Gordon)
* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)

### Slider

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [[ThumbTrack] Slider and Switch implement `isTracking` UIControl method](https://github.com/material-components/material-components-ios/commit/7cfaf9b0969e19b8820d5b23dab154c4c317d647) (Max Luzuriaga)

### Snackbar

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)

### SpritedAnimationView

#### Breaking changes

* [**Breaking**:  Add 'finished' bool to animation completion block](https://github.com/material-components/material-components-ios/commit/d8a2d93ebcd4f284f576c05c7a186d54fe2d6319) (Sam Morrison)

#### Changes

* [Fix SpritedAnimationViewTests](https://github.com/material-components/material-components-ios/commit/10e4a258fa529178d1aa6ae8962193eb18b43d20) (Sam Morrison)

### Switch

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [[ThumbTrack] Slider and Switch implement `isTracking` UIControl method](https://github.com/material-components/material-components-ios/commit/7cfaf9b0969e19b8820d5b23dab154c4c317d647) (Max Luzuriaga)

### Typography

#### Changes

* [Lowercase "Material Design" in text.](https://github.com/material-components/material-components-ios/commit/65a05eed3112816c7441be4f6766d12099d0b0f3) (Adrian Secord)
* [Remove ARC guards from MDC](https://github.com/material-components/material-components-ios/commit/10e11da725499e7bd6e07c034b875b4dcfa1e2fe) (Sam Morrison)


# 12.2.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o c6523eae8e811b1c89d94073b9153a03390b1950 -n edab0db4908985cd0b56003b4341d5f064f98d6a

### Dialogs

**New component.**

## Component changes

### Dialogs

#### Changes

* [Initial Import](https://github.com/material-components/material-components-ios/commit/3742dd4849c64e334a46e6b027ddfa9c75e6034c) (Ian Gordon)
* [Add missing website API and usage docs.](https://github.com/material-components/material-components-ios/commit/493331502c44f6e844ffbdfdf21d439ce4ba455b) (Adrian Secord)

### Ink

#### Changes

* [Arc lint changes.](https://github.com/material-components/material-components-ios/commit/7bedb6183cb47017763bfa8b4d50265b4530ebd9) (Adrian Secord)

### ProgressView

#### Changes

* [Add missing website API and usage docs.](https://github.com/material-components/material-components-ios/commit/493331502c44f6e844ffbdfdf21d439ce4ba455b) (Adrian Secord)

### Slider

#### Changes

* [[Catalog] Bigger sliders in component example](https://github.com/material-components/material-components-ios/commit/e1b7f86879cfc09abfc057344e8a484447ec7766) (Max Luzuriaga)

### Snackbar

#### Changes

* [Add missing website API and usage docs.](https://github.com/material-components/material-components-ios/commit/493331502c44f6e844ffbdfdf21d439ce4ba455b) (Adrian Secord)


# 12.1.1

## API diffs

Auto-generated by running:

    scripts/api_diff -o ec923edf948c5c0ef8cef52f3a3b26a21cbf29d9 -n 34f12cf42f45e30bada83ff6c4c67d5104201a00

No public API changes detected.

## Component changes

### SpritedAnimationView

#### Changes

* [Added intrinsicContentSize.](https://github.com/material-components/material-components-ios/commit/34f12cf42f45e30bada83ff6c4c67d5104201a00) (randallli)


# 12.1.0

## API diffs

### NavigationBar

- [new] [`MDCNavigationBar.titleTextAttributes`](https://github.com/material-components/material-components-ios/blob/4687c48a55316f2ff6aa6ea5edeb73ea3a3173c5/components/NavigationBar/src/MDCNavigationBar.h#L71)

### ProgressView

**New component.**

## Component changes

### ActivityIndicator

#### Changes

* [Added missing Jazzy configs by running scripts/generate_jazzy_yamls.sh.](https://github.com/material-components/material-components-ios/commit/2b8ef4160fdafd9d103b09c6842d647d41b00780) (Adrian Secord)

### Collections

#### Changes

* [Add more conformances to CAAnimationDelegate on iOS 10 SDK](https://github.com/material-components/material-components-ios/commit/8f4a71ea54ff2a7ae01850109919181474bd8104) (Brian Moore)
* [Adds storyboard example.](https://github.com/material-components/material-components-ios/commit/627206634f45721c547eec155f4426c59f5fb2e5) (Chris Cox)

### Ink

#### Changes

* [Add conformances to CAAnimationDelegate on iOS 10 SDK](https://github.com/material-components/material-components-ios/commit/d4ee92a107ebc3d0801cb62d60e5b38e06c9a1dc) (Brian Moore)

### NavigationBar

#### Changes

* [MDC_#623 - Added titleTextAttributes property to MDCNavigationBar](https://github.com/material-components/material-components-ios/commit/1309e628b6aac1e5e83a2e19759e45edb787e061) (Justin Shephard)

### OverlayWindow

#### Changes

* [Added missing Jazzy configs by running scripts/generate_jazzy_yamls.sh.](https://github.com/material-components/material-components-ios/commit/2b8ef4160fdafd9d103b09c6842d647d41b00780) (Adrian Secord)

### Palettes

#### Changes

* [Added missing Jazzy configs by running scripts/generate_jazzy_yamls.sh.](https://github.com/material-components/material-components-ios/commit/2b8ef4160fdafd9d103b09c6842d647d41b00780) (Adrian Secord)

### ProgressView

#### Changes

* [Add the ProgressView component.](https://github.com/material-components/material-components-ios/commit/a806413bd6414f684899c9a0fae10c3fc8aa54fd) (Louis Romero)

### Snackbar

#### Changes

* [Add more conformances to CAAnimationDelegate on iOS 10 SDK](https://github.com/material-components/material-components-ios/commit/8f4a71ea54ff2a7ae01850109919181474bd8104) (Brian Moore)
* [Added missing Jazzy configs by running scripts/generate_jazzy_yamls.sh.](https://github.com/material-components/material-components-ios/commit/2b8ef4160fdafd9d103b09c6842d647d41b00780) (Adrian Secord)
* [Align text correctly in RTL layout](https://github.com/material-components/material-components-ios/commit/112ff5446f567374324e5e7c685625f7ada238bd) (Louis Romero)
* [The button a11y identifier is the action's](https://github.com/material-components/material-components-ios/commit/b92d724d906f6c0f072bca17f92177db819651c5) (Louis Romero)

# 12.0.1

## API diffs

Auto-generated by running:

    scripts/api_diff -o bdc034da8700a9cbd6064823dc045b511d622f8c -n f9f6d8e87d6cdaf884ac2d3ad462403bdb2fd008

No public API changes detected.

## Component changes

### CollectionCells

#### Changes

* [Resize the content view when there is an accessory view.](https://github.com/material-components/material-components-ios/commit/f6d329602f84cc0839ebdfa622877d70201fd798) (Louis Romero)

### Slider

#### Changes

* [Add discrete positions when editing](https://github.com/material-components/material-components-ios/commit/7c0d0a654f030b3e3f2d1136f7415a4caa92917c) (Max Luzuriaga)

### Snackbar

#### Changes

* [Add legal info to snackbar files and umbrella header for keyboard watcher](https://github.com/material-components/material-components-ios/commit/be579f15da376d1029b4bef2abdf5cdd9c65c891) (Junius Gunaratne)
* [Don't force uppercasing of the button.](https://github.com/material-components/material-components-ios/commit/f9f6d8e87d6cdaf884ac2d3ad462403bdb2fd008) (Louis Romero)

# 12.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o e4b240934cbf7211790e0929c73652dbd7c2f46f -n 55a289f0cfeebdc10931243d613d4cf5bcef3986

### ActivityIndicator

- [modified] [`-[MDCActivityIndicatorDelegate activityIndicatorAnimationDidFinish:]`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/ActivityIndicator/src/MDCActivityIndicator.h#L130)

| From | To | Kind |
|:---- |:-- |:---- |
| `Required` | `Optional` | `optional` |

### ButtonBar

- [deleted] [`MDCButtonBar.layoutDirection`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/ButtonBar/src/MDCButtonBar.h#L98)
- [modified] [`MDCButtonBar.items`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/ButtonBar/src/MDCButtonBar.h#L87)

| From | To | Kind |
|:---- |:-- |:---- |
| `@property (nonatomic, copy) NSArray *items` | `@property (nonatomic, copy) NSArray<UIBarButtonItem *> *items` | `declaration` |

### Collections

- [declaration changed] [`-[MDCCollectionViewStyling indexPathsForInlaidItems]`](https://github.com/material-components/material-components-ios/blob/55a289f0cfeebdc10931243d613d4cf5bcef3986/components/Collections/src/MDCCollectionViewStyling.h#L168).
```
- (nullable NSArray *)indexPathsForInlaidItems
- (nullable NSArray<NSIndexPath *> *)indexPathsForInlaidItems
```

### NavigationBar

- [deleted] [`MDCNavigationBar.layoutDirection`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/NavigationBar/src/MDCNavigationBar.h#L109)
- [modified] [`MDCNavigationBar.leadingBarButtonItems`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/NavigationBar/src/MDCNavigationBar.h#L82)

| From | To | Kind |
|:---- |:-- |:---- |
| `@property (nonatomic, copy, nullable) NSArray *leadingBarButtonItems` | `@property (nonatomic, copy, nullable) NSArray<UIBarButtonItem *> *leadingBarButtonItems` | `declaration` |

- [modified] [`MDCNavigationBar.leftBarButtonItems`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/NavigationBar/src/MDCNavigationBar.h#L125)

| From | To | Kind |
|:---- |:-- |:---- |
| `@property (nonatomic, copy, nullable) NSArray *leftBarButtonItems` | `@property (nonatomic, copy, nullable) NSArray<UIBarButtonItem *> *leftBarButtonItems` | `declaration` |

- [modified] [`MDCNavigationBar.rightBarButtonItems`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/NavigationBar/src/MDCNavigationBar.h#L128)

| From | To | Kind |
|:---- |:-- |:---- |
| `@property (nonatomic, copy, nullable) NSArray *rightBarButtonItems` | `@property (nonatomic, copy, nullable) NSArray<UIBarButtonItem *> *rightBarButtonItems` | `declaration` |

- [modified] [`MDCNavigationBar.trailingBarButtonItems`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/NavigationBar/src/MDCNavigationBar.h#L83)

| From | To | Kind |
|:---- |:-- |:---- |
| `@property (nonatomic, copy, nullable) NSArray *trailingBarButtonItems` | `@property (nonatomic, copy, nullable) NSArray<UIBarButtonItem *> *trailingBarButtonItems` | `declaration` |

- [modified] [`MDCUINavigationItemObservables.leftBarButtonItems`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/NavigationBar/src/MDCNavigationBar.h#L31)

| From | To | Kind |
|:---- |:-- |:---- |
| `@property (nonatomic, copy, nullable) NSArray *leftBarButtonItems` | `@property (nonatomic, copy, nullable) NSArray<UIBarButtonItem *> *leftBarButtonItems` | `declaration` |

- [modified] [`MDCUINavigationItemObservables.rightBarButtonItems`](https://github.com/material-components/material-components-ios/blob/e4b240934cbf7211790e0929c73652dbd7c2f46f/components/NavigationBar/src/MDCNavigationBar.h#L32)

| From | To | Kind |
|:---- |:-- |:---- |
| `@property (nonatomic, copy, nullable) NSArray *rightBarButtonItems` | `@property (nonatomic, copy, nullable) NSArray<UIBarButtonItem *> *rightBarButtonItems` | `declaration` |

### OverlayWindow

**New component.**

### Snackbar

**New component.**

## Component changes

### ActivityIndicator

#### Changes

* [Fixed all warnings. FEAR ME, WARNINGS.](https://github.com/material-components/material-components-ios/commit/1a3ae8938fbee7d3e02bfd69180b36598217ef85) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)

### AppBar

#### Changes

* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [Fixed usage of |variable| markup in comments.](https://github.com/material-components/material-components-ios/commit/f971eef8d201c9b7700f21ef5474e4f448f751cd) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)
* [Port the rendering mode when flipping on iOS 8 and below.](https://github.com/material-components/material-components-ios/commit/7550398b6cadc712e0ce72a35fc872bc16489b5b) (Louis Romero)
* [Remove code handling SDK olders than iOS 9.](https://github.com/material-components/material-components-ios/commit/bec7ec4010229df4bf05677a25ebc74b35a6ccb8) (Louis Romero)

### ButtonBar

#### Changes

* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)
* [MDC_#512 - Outdated comment mentions non-existing MDCButtonBar+Builder.h](https://github.com/material-components/material-components-ios/commit/9432c19d4085f9be9493e9a3e5880492619bcaa2) (Justin Shephard)
* [Port the rendering mode when flipping on iOS 8 and below.](https://github.com/material-components/material-components-ios/commit/7550398b6cadc712e0ce72a35fc872bc16489b5b) (Louis Romero)
* [Remove code handling SDK olders than iOS 9.](https://github.com/material-components/material-components-ios/commit/bec7ec4010229df4bf05677a25ebc74b35a6ccb8) (Louis Romero)
* [≈Prevent buttons from redrawing every time a tint color changes by inlining functionality. Prevent incorrect behavior of nav label getting tint.](https://github.com/material-components/material-components-ios/commit/976e1d6b43e9a1cac08b5aafa0ca04cb538cd95c) (Eric Li)

### Buttons

#### Changes

* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [Fixed usage of |variable| markup in comments.](https://github.com/material-components/material-components-ios/commit/f971eef8d201c9b7700f21ef5474e4f448f751cd) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)

### CollectionCells

#### Changes

* [Fixed usage of |variable| markup in comments.](https://github.com/material-components/material-components-ios/commit/f971eef8d201c9b7700f21ef5474e4f448f751cd) (Adrian Secord)
* [Support RTL](https://github.com/material-components/material-components-ios/commit/361699fb6ce6a64a73d896208b8371d0d264359e) (Louis Romero)

### Collections

#### Changes

* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [Fixed usage of |variable| markup in comments.](https://github.com/material-components/material-components-ios/commit/f971eef8d201c9b7700f21ef5474e4f448f751cd) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)
* [Updates __nullable/__nonnull to _Nullable/_Nonnull.](https://github.com/material-components/material-components-ios/commit/c17de91b48878ff18be7411ef7d45f5ba4de7192) (Adrian Secord)

### FlexibleHeader

#### Changes

* [Remove code handling SDK olders than iOS 9.](https://github.com/material-components/material-components-ios/commit/bec7ec4010229df4bf05677a25ebc74b35a6ccb8) (Louis Romero)
* [Updates __nullable/__nonnull to _Nullable/_Nonnull.](https://github.com/material-components/material-components-ios/commit/c17de91b48878ff18be7411ef7d45f5ba4de7192) (Adrian Secord)

### Ink

#### Changes

* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [Fixed usage of |variable| markup in comments.](https://github.com/material-components/material-components-ios/commit/f971eef8d201c9b7700f21ef5474e4f448f751cd) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)
* [Updates __nullable/__nonnull to _Nullable/_Nonnull.](https://github.com/material-components/material-components-ios/commit/c17de91b48878ff18be7411ef7d45f5ba4de7192) (Adrian Secord)

### NavigationBar

#### Changes

* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)
* [Port the rendering mode when flipping on iOS 8 and below.](https://github.com/material-components/material-components-ios/commit/7550398b6cadc712e0ce72a35fc872bc16489b5b) (Louis Romero)
* [Remove code handling SDK olders than iOS 9.](https://github.com/material-components/material-components-ios/commit/bec7ec4010229df4bf05677a25ebc74b35a6ccb8) (Louis Romero)
* [≈Prevent buttons from redrawing every time a tint color changes by inlining functionality. Prevent incorrect behavior of nav label getting tint.](https://github.com/material-components/material-components-ios/commit/976e1d6b43e9a1cac08b5aafa0ca04cb538cd95c) (Eric Li)

### OverlayWindow

#### Changes

* [[Snackbar] Adding Snackbar component and related Overlay Window](https://github.com/material-components/material-components-ios/commit/e8afa47fa6676779923cb571cb99a1dca0e2fb57) (Junius Gunaratne)

### PageControl

#### Changes

* [Added example for button to progress to the next page](https://github.com/material-components/material-components-ios/commit/7f340f053a9ccdc0c56340499d4e5b403ae4b75c) (randallli)
* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [Fixed all warnings. FEAR ME, WARNINGS.](https://github.com/material-components/material-components-ios/commit/1a3ae8938fbee7d3e02bfd69180b36598217ef85) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)
* [Made control compatible with animation blocks adjusting the scrollView.contentOffset.](https://github.com/material-components/material-components-ios/commit/c447675a5d4278647ea8ffcd56927adc855a0b00) (randallli)

### Palettes

#### Changes

* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)
* [Updates __nullable/__nonnull to _Nullable/_Nonnull.](https://github.com/material-components/material-components-ios/commit/c17de91b48878ff18be7411ef7d45f5ba4de7192) (Adrian Secord)

### ShadowLayer

#### Changes

* [Updates __nullable/__nonnull to _Nullable/_Nonnull.](https://github.com/material-components/material-components-ios/commit/c17de91b48878ff18be7411ef7d45f5ba4de7192) (Adrian Secord)

### Slider

#### Changes

* [Grow thumb when dragging the slider](https://github.com/material-components/material-components-ios/commit/4365ebb555f28471a6b81381f62a7e0a962583c7) (Max Luzuriaga)

### Snackbar

#### Changes

* [Adding Snackbar component and related Overlay Window](https://github.com/material-components/material-components-ios/commit/e8afa47fa6676779923cb571cb99a1dca0e2fb57) (Junius Gunaratne)

### SpritedAnimationView

#### Changes

* [Applied the results of `arc lint --everything`. Again.](https://github.com/material-components/material-components-ios/commit/da7177c74e7d3ca04ad52330188e38e9ab3f5a1d) (Adrian Secord)
* [MDC_#388 - Added NSLayoutConstraints to _animationView and label in SpritedAnimationViewTypicalUseViewController.m](https://github.com/material-components/material-components-ios/commit/dd761f7f81c4797e0e751305b4f6a6fc42ad7790) (Justin Shephard)
* [MDC_#492 - Audit for Objective-C Generics](https://github.com/material-components/material-components-ios/commit/34bad428ee7aeb36220199597d03a240e40ee563) (Justin Shephard)

# 11.0.1

## API diffs

Auto-generated by running:

    scripts/api_diff -o 5cea05817470a3fd906dc3663aff5628491e3224 -n 914490127624d9526f24a497021efffddcf3d567

No public API changes detected.

## Component changes

### ButtonBar

#### Changes

* [Prevent incorrect baseline shift when updating button bar buttons.](https://github.com/material-components/material-components-ios/commit/9cf321366b49b6d97f21ca3797db6b255f279090) (Eric Li)

### FontDiskLoader

#### Changes

* [Added include sorting to clang-format.](https://github.com/material-components/material-components-ios/commit/6805403fffeb7368df17f74b3ed66326dc8150b9) (Adrian Secord)

### Slider

#### Changes

* [Make thumb view hollow when on the minimum value.](https://github.com/material-components/material-components-ios/commit/fba387153f456f3e0192bbe92714f236c728d6a3) (Max Luzuriaga)

### Switch

#### Changes

* [[Slider] Make thumb view hollow when on the minimum value.](https://github.com/material-components/material-components-ios/commit/fba387153f456f3e0192bbe92714f236c728d6a3) (Max Luzuriaga)

# 11.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o a33f87199b2f4e29e35f0b93c75d60520742d5aa -n 0b277c9ff00628400b291d2e6900ff6389b27ecf

### FontDiskLoader

- [deleted] [`-[MDCFontDiskLoader setHasFailedRegistration:]`](https://github.com/material-components/material-components-ios/blob/a33f87199b2f4e29e35f0b93c75d60520742d5aa/components/FontDiskLoader/src/MDCFontDiskLoader.h#L109)
- [deleted] [`-[MDCFontDiskLoader setIsRegistered:]`](https://github.com/material-components/material-components-ios/blob/a33f87199b2f4e29e35f0b93c75d60520742d5aa/components/FontDiskLoader/src/MDCFontDiskLoader.h#L108)

### Palettes

- [new] [`+[MDCPalette paletteWithTints:accents:]`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L141)
- [new] [`-[MDCPalette initWithTints:accents:]`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L157)
- [new] [`MDCPaletteAccent100Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L50)
- [new] [`MDCPaletteAccent200Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L53)
- [new] [`MDCPaletteAccent400Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L56)
- [new] [`MDCPaletteAccent700Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L59)
- [new] [`MDCPaletteTint100Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L23)
- [new] [`MDCPaletteTint200Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L26)
- [new] [`MDCPaletteTint300Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L29)
- [new] [`MDCPaletteTint400Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L32)
- [new] [`MDCPaletteTint500Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L35)
- [new] [`MDCPaletteTint50Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L20)
- [new] [`MDCPaletteTint600Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L38)
- [new] [`MDCPaletteTint700Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L41)
- [new] [`MDCPaletteTint800Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L44)
- [new] [`MDCPaletteTint900Name`](https://github.com/material-components/material-components-ios/blob/0b277c9ff00628400b291d2e6900ff6389b27ecf/components/Palettes/src/MDCPalettes.h#L47)

## Component changes

### ActivityIndicator

#### Changes

* [Add read me and example mov/png](https://github.com/material-components/material-components-ios/commit/a84135fd0f6cd9cbbe1f77221fde21d5590eda77) (Junius Gunaratne)
* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### AppBar

#### Changes

* [Fix a layout issue in Multitasking](https://github.com/material-components/material-components-ios/commit/ab56421cd7cc23b575b1114aa09448347208547a) (Louis Romero)
* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### ButtonBar

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)
* [visual fix to issue #534 by applying a clear color to button rather than nil](https://github.com/material-components/material-components-ios/commit/a08b0a2dc99d717d940453e83535f2ba4203fdc9) (Eric Li)

### Buttons

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### CollectionCells

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### CollectionLayoutAttributes

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### Collections

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### FlexibleHeader

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### FontDiskLoader

#### Breaking changes

* [**Breaking**:  Assert added for missing font name in file.](https://github.com/material-components/material-components-ios/commit/b123e117a6de9fc2439a26ab3885e100a0a59c09) (randallli)
* [**Breaking**:  Removed public setters for isRegistered.](https://github.com/material-components/material-components-ios/commit/0d9c626556fe112b0ff536c1e38749385dc1248c) (randallli)

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### HeaderStackView

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### Ink

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### NavigationBar

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### PageControl

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### Palettes

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)
* [[Palette] Added custom palette initializers.](https://github.com/material-components/material-components-ios/commit/cdb423f8985712d56229d21b9918904d84b8decb) (Adrian Secord)

### RobotoFontLoader

#### Changes

* [Added description method.](https://github.com/material-components/material-components-ios/commit/da2a788b8718b40fb2b8efbab773f96d1f0566c9) (randallli)
* [Copy edit of class comment](https://github.com/material-components/material-components-ios/commit/382a2b6eb23d786c8b2afae7357dde635f4ad540) (randallli)
* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)
* [[FontDiskLoader]! Assert added for missing font name in file.](https://github.com/material-components/material-components-ios/commit/b123e117a6de9fc2439a26ab3885e100a0a59c09) (randallli)

### ShadowElevations

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### ShadowLayer

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### Slider

#### Changes

* [Made disabled thumb view a little smaller to match the Material spec.](https://github.com/material-components/material-components-ios/commit/7e59133741d1b311d09d85918da57cb0154951e0) (Max Luzuriaga)
* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### SpritedAnimationView

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### Switch

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

### Typography

#### Changes

* [Re-enabled 100-character line limit.](https://github.com/material-components/material-components-ios/commit/3aedace95926edb9f2427ca1b80464019120412d) (Adrian Secord)

# 10.1.2

#### Changes

* [Bumped version number to 10.1.2. This was needed because 10.1.1 forgot to update the podspec's.] https://github.com/material-components/material-components-ios/commit/73cea102fd6f02854de69b11f33e91acfcfbc5ab

# 10.1.1

### FontDiskLoader

#### Changes

* [Removed extra /x03 character in comment because it shouldn't be there.](https://github.com/material-components/material-components-ios/commit/b018eb87438ccfd4fa99850d9ed48698ff91e7e3) (randallli)

# 10.1.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o dc74cd290f327e950eab32b48f3105c55972fad9 -n d4a3ac376f5c8498cfb52401f4fbb69d2e318897

### ActivityIndicator

**New component.**

### FontDiskLoader

- [new] [`-[MDCFontDiskLoader unregisterFont]`](https://github.com/material-components/material-components-ios/blob/d4a3ac376f5c8498cfb52401f4fbb69d2e318897/components/FontDiskLoader/src/MDCFontDiskLoader.h#L84)
- [property attribute change] [`MDCFontDiskLoader.hasFailedRegistration`](https://github.com/material-components/material-components-ios/blob/d4a3ac376f5c8498cfb52401f4fbb69d2e318897/components/FontDiskLoader/src/MDCFontDiskLoader.h#L100).
Deprecated setter.
- [property attribute change] [`MDCFontDiskLoader.isRegistered`](https://github.com/material-components/material-components-ios/blob/d4a3ac376f5c8498cfb52401f4fbb69d2e318897/components/FontDiskLoader/src/MDCFontDiskLoader.h#L93).
Deprecated setter.
- [protocols changed] [`MDCFontDiskLoader`](https://github.com/material-components/material-components-ios/blob/d4a3ac376f5c8498cfb52401f4fbb69d2e318897/components/FontDiskLoader/src/MDCFontDiskLoader.h#L28).

Added *NSCopying*.

## Component changes

### ActivityIndicator

#### Changes

* [Adding activity indicator component and demo](https://github.com/material-components/material-components-ios/commit/d589b27330d717c9d7a4bd1ebea562453f5c5639) (Junius Gunaratne)
* [Move layout code into supplemental, support landscape mode](https://github.com/material-components/material-components-ios/commit/06acbe8cb8b9aa0befea566233f5e7b7528dd8dd) (Junius Gunaratne)

### AppBar

#### Changes

* [Fix typo in back item accessibility identifier.](https://github.com/material-components/material-components-ios/commit/f5a6ce7244edd1ad67fc8a04a0a087623936db32) (Louis Romero)
* [Respect the navigation bar's layout direction](https://github.com/material-components/material-components-ios/commit/c60de65ffdef1cf83d664e429615b87238f15ccf) (Louis Romero)
* [Set an accessibility identifier on the default back button.](https://github.com/material-components/material-components-ios/commit/ae21fd0453b3f932e2926a14518009429190c39c) (Louis Romero)

### ButtonBar

#### Changes

* [Updated examples and readme to use new swift selector syntax.](https://github.com/material-components/material-components-ios/commit/25ea19e76a7b4d7baf9420639972127022c27602) (Eric Li)

### Buttons

#### Changes

* [Updated examples and readme to use new swift selector syntax.](https://github.com/material-components/material-components-ios/commit/25ea19e76a7b4d7baf9420639972127022c27602) (Eric Li)

### Collections

#### Changes

* [Fixes bug when initializing collection view with own layout.](https://github.com/material-components/material-components-ios/commit/306da8d238cfd9d85f65ccb33370e1c6485418a1) (Chris Cox)

### FontDiskLoader

#### Changes

* [Added unregisterFont method.](https://github.com/material-components/material-components-ios/commit/77d8ebcd78cf37b9e38b77c5b29136ee37d6f719) (randallli)
* [Correct Roboto Font markdown for design specification link.](https://github.com/material-components/material-components-ios/commit/fa55cdd03099dfb2822e76222e81f631f7e000d0) (Yiran Mao)
* [[FontDiskLoader]? added warning NSLog when failing to load the font by name.](https://github.com/material-components/material-components-ios/commit/d62b6dc116d8db90e1f1953c48c0e8b6c45949de) (randallli)
* [[MDCFontDiskLoader] Added copying protocol](https://github.com/material-components/material-components-ios/commit/7a0a9f0aaa61d47a780fd404916701f373f7e53d) (randallli)
* [[MDCFontDiskLoader] sharing registered state across all instances of objects.](https://github.com/material-components/material-components-ios/commit/1ef21ea7e080664050271576fd85dcea3c4d87b4) (randallli)
* [[MDCFontDiskLoader]? Deprecated properties that should not have been public write.](https://github.com/material-components/material-components-ios/commit/25f4d7caec33172ef9aafc1c633c03740da62d16) (randallli)

### PageControl

#### Changes

* [updated examples and readme to use new swift selector syntax](https://github.com/material-components/material-components-ios/commit/25ea19e76a7b4d7baf9420639972127022c27602) (Eric Li)

### RobotoFontLoader

#### Changes

* [Correct Roboto Font markdown for design specification link.](https://github.com/material-components/material-components-ios/commit/fa55cdd03099dfb2822e76222e81f631f7e000d0) (Yiran Mao)

### ShadowLayer

#### Changes

* [updated examples and readme to use new swift selector syntax](https://github.com/material-components/material-components-ios/commit/25ea19e76a7b4d7baf9420639972127022c27602) (Eric Li)

### Switch

#### Changes

* [updated examples and readme to use new swift selector syntax](https://github.com/material-components/material-components-ios/commit/25ea19e76a7b4d7baf9420639972127022c27602) (Eric Li)

# 10.0.0

## Infrastructure

Material Components for iOS now [requires Cocoapods 1.0.0](https://groups.google.com/d/topic/material-components-ios-discuss/FnipGJXMeww/discussion).

## API diffs

Auto-generated by running:

    scripts/api_diff -o 0c97c7e25888d9da312c8610e21aa635cf9fb395 -n 1fc92b09a8539cf235667c4b2fb83c0f52578d65

### RobotoFontLoader

- [deleted] [`-[MDCRobotoFontLoader init]`](https://github.com/material-components/material-components-ios/blob/0c97c7e25888d9da312c8610e21aa635cf9fb395/components/RobotoFontLoader/src/MDCRobotoFontLoader.h#L33)

# 9.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o cdbe7e499d85c320c41f31e51cd7cf29c3afed48 -n 636df09ea57a7cdefdacad3f53277c76df968f72

### ButtonBar

- [new] [`MDCButtonBarLayoutPositionLeading`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/ButtonBar/src/MDCButtonBar.h#L28)
- [new] [`MDCButtonBarLayoutPositionTrailing`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/ButtonBar/src/MDCButtonBar.h#L31)

### NavigationBar

- [new] [`MDCNavigationBar.hidesBackButton`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L68)
- [new] [`MDCNavigationBar.layoutDirection`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L109)
- [new] [`MDCNavigationBar.leadingBarButtonItem`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L97)
- [new] [`MDCNavigationBar.leadingBarButtonItems`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L82)
- [new] [`MDCNavigationBar.leadingItemsSupplementBackButton`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L90)
- [new] [`MDCNavigationBar.leftBarButtonItem`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L142)
- [new] [`MDCNavigationBar.leftBarButtonItems`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L136)
- [new] [`MDCNavigationBar.leftItemsSupplementBackButton`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L148)
- [new] [`MDCNavigationBar.rightBarButtonItem`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L145)
- [new] [`MDCNavigationBar.rightBarButtonItems`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L139)
- [new] [`MDCNavigationBar.title`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L51)
- [new] [`MDCNavigationBar.trailingBarButtonItem`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L98)
- [new] [`MDCNavigationBar.trailingBarButtonItems`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L83)
- [protocols changed] [`MDCNavigationBar`](https://github.com/material-components/material-components-ios/blob/636df09ea57a7cdefdacad3f53277c76df968f72/components/NavigationBar/src/MDCNavigationBar.h#L46).
Removed *MDCUINavigationItemObservables*.

## Component changes

### ButtonBar

#### Changes

* [Hotfix for release.](https://github.com/material-components/material-components-ios/commit/20bcf06d714d45c270fe857a670102ea1085bfeb) (Louis Romero)
* [MDCButtonBar default layout direction is based on the system's.](https://github.com/material-components/material-components-ios/commit/fa171656af0fe8dbacf50808dc88fa4fd2e705d4) (Louis Romero)
* [Re-add previous enum values.](https://github.com/material-components/material-components-ios/commit/8ce80041a41e3f4c7f1ea43f96a3bd192e11dd96) (Ian Gordon)
* [Reload the buttons when the tintColor changes.](https://github.com/material-components/material-components-ios/commit/0ca536cf6c4af594cdaaa8196338fe40596b9404) (Louis Romero)
* [[ButtonBar]? Layout bar button items based on the layout position.](https://github.com/material-components/material-components-ios/commit/56561b40b60ff3c0ea33801b5445c0eaab0f9600) (Louis Romero)

### CollectionCells

#### Changes

* [Fixes reused cells that don't reset their title label frame.](https://github.com/material-components/material-components-ios/commit/79a2054da1346bcc35eb29e23c85bb500ce1860c) (Chris Cox)

### Collections

#### Changes

* [Modify the structure of collection document in preparation for the secondary navigation.](https://github.com/material-components/material-components-ios/commit/5bac0c81f3c68795a4e699826b4de0f4aac399da) (Yiran Mao)

### FlexibleHeader

#### Changes

* [Always update _lastContentOffset when we call fhv_updateLayout.](https://github.com/material-components/material-components-ios/commit/636df09ea57a7cdefdacad3f53277c76df968f72) (Jeff Verkoeyen)
* [Standardize all shift accumulator variable names.](https://github.com/material-components/material-components-ios/commit/bb49bb4265ab3772d5312490df9867baf4c73000) (Jeff Verkoeyen)

### FontDiskLoader

#### Changes

* [Added isEqual and hash logic](https://github.com/material-components/material-components-ios/commit/425a61fe40f5367a6548042af1109951463f41f7) (randallli)

### HeaderStackView

#### Changes

* [[NavigationBar] Use leading/trailing wording in NavigationBar.](https://github.com/material-components/material-components-ios/commit/e413820f83ce05f0e32e4a6e5daf97ae06e80070) (Louis Romero)

### NavigationBar

#### Changes

* [Hotfix for release.](https://github.com/material-components/material-components-ios/commit/20bcf06d714d45c270fe857a670102ea1085bfeb) (Louis Romero)
* [Use leading/trailing wording in NavigationBar.](https://github.com/material-components/material-components-ios/commit/6a5153e1a83c7effe22eb926a71324ce77949449) (Louis Romero)
* [Use leading/trailing wording in NavigationBar.](https://github.com/material-components/material-components-ios/commit/e413820f83ce05f0e32e4a6e5daf97ae06e80070) (Louis Romero)
* [[ButtonBar]? Layout bar button items based on the layout position.](https://github.com/material-components/material-components-ios/commit/56561b40b60ff3c0ea33801b5445c0eaab0f9600) (Louis Romero)

# 8.0.0

## API diffs

Auto-generated by running the following while checked out at
`4bc99e8ad0fe0ac7e9acc044591a8581165fb5c2`:

    scripts/api_diff -o 2153f8fa453ecec4dfe48a328e331846d5d37aac -n bbabb375953fbd01c3f818ac9092b55fe56dd9b9

### AppBar

- [deleted] [`-[MDCAppBarContainerViewController headerViewController]`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/AppBar/src/MDCAppBarContainerViewController.h#L69)
- [deleted] [`MDCAppBarContainerViewController ()`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/AppBar/src/MDCAppBarContainerViewController.h#L66)

### ButtonBar

- [deleted] [`-[MDCButtonBar reloadButtonViews]`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/ButtonBar/src/MDCButtonBar.h#L166)
- [deleted] [`MDCButtonBar ()`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/ButtonBar/src/MDCButtonBar.h#L155)
- [deleted] [`MDCButtonBar.buttonItems`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/ButtonBar/src/MDCButtonBar.h#L158)
- [deleted] [`MDCButtonBar.delegate`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/ButtonBar/src/MDCButtonBar.h#L162)
- [moved] [`MDCButtonBar (Builder)`](https://github.com/material-components/material-components-ios/blob/bbabb375953fbd01c3f818ac9092b55fe56dd9b9/components/ButtonBar/src/MDCButtonBar.h#L177).
From *MDCButtonBar.h* to *private/MDCButtonBar+Private.h*.

### NavigationBar

- [deleted] [`MDCNavigationBar ()`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/NavigationBar/src/MDCNavigationBar.h#L94)
- [deleted] [`MDCNavigationBar.leftButtonBarDelegate`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/NavigationBar/src/MDCNavigationBar.h#L97)
- [deleted] [`MDCNavigationBar.rightButtonBarDelegate`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/NavigationBar/src/MDCNavigationBar.h#L101)
- [deleted] [`MDCUINavigationItemKVO`](https://github.com/material-components/material-components-ios/blob/2153f8fa453ecec4dfe48a328e331846d5d37aac/components/NavigationBar/src/MDCNavigationBar.h#L91)

## Component changes

### AppBar

#### Breaking changes

* [Remove deprecated headerViewController property from MDCAppBarContainerViewController.](https://github.com/material-components/material-components-ios/commit/dbfc6b783d40e229708af1ee956ded363f621601) (Jeff Verkoeyen)

### ButtonBar

#### Breaking changes

* [Remove deprecated APIs.](https://github.com/material-components/material-components-ios/commit/f7c84317ec01774be169bd3486ebb8a561376250) (Jeff Verkoeyen)

#### Changes

* [Propagate the NavigationBar tint color to the bar button items.](https://github.com/material-components/material-components-ios/commit/39bda0a60728a5989971cb0a09ee8d40b7bd4f09) (Louis Romero)


### CollectionCells

#### Changes

* [[Collections|CollectionCells] Updates outdated comments referring to style/editing manager.](https://github.com/material-components/material-components-ios/commit/120030631e3a695559a49100e62cb7a88502cb3b) (Chris Cox)

### Collections

#### Changes

* [Adds border to editing action bar](https://github.com/material-components/material-components-ios/commit/3e7ce26bacd4ee94177bf3daab0c03d2281a6723) (Chris Cox)
* [[Collections|CollectionCells] Updates outdated comments referring to style/editing manager.](https://github.com/material-components/material-components-ios/commit/120030631e3a695559a49100e62cb7a88502cb3b) (Chris Cox)

### NavigationBar

#### Breaking changes

* [[ButtonBar] Remove deprecated APIs.](https://github.com/material-components/material-components-ios/commit/f7c84317ec01774be169bd3486ebb8a561376250) (Jeff Verkoeyen)

# 7.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o d2f436fdcfa711da5a8a077b42feb052c1abdf9e -n 6c8ca274056aed6850920f6010b47655c67730c9


### AppBar

- [deleted] [`MDCAppBarAddViews()`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/AppBar/src/MDCAppBar.h#L101)
- [deleted] [`MDCAppBarParenting.headerStackView`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/AppBar/src/MDCAppBar.h#L74)
- [deleted] [`MDCAppBarParenting.headerViewController`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/AppBar/src/MDCAppBar.h#L82)
- [deleted] [`MDCAppBarParenting.navigationBar`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/AppBar/src/MDCAppBar.h#L78)
- [deleted] [`MDCAppBarParenting`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/AppBar/src/MDCAppBar.h#L69)
- [deleted] [`MDCAppBarPrepareParent()`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/AppBar/src/MDCAppBar.h#L93)

### ButtonBar

- [new] [`MDCButtonBar.layoutPosition`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/ButtonBar/src/MDCButtonBar.h#L112)
- [new] [`MDCButtonBarLayoutPositionLeft`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/ButtonBar/src/MDCButtonBar.h#L28)
- [new] [`MDCButtonBarLayoutPositionNone`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/ButtonBar/src/MDCButtonBar.h#L25)
- [new] [`MDCButtonBarLayoutPositionRight`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/ButtonBar/src/MDCButtonBar.h#L31)
- [new] [`MDCButtonBarLayoutPosition`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/ButtonBar/src/MDCButtonBar.h#L24)

### Collections

- [new] [`-[MDCCollectionViewController collectionView:didHighlightItemAtIndexPath:]`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/Collections/src/MDCCollectionViewController.h#L55)
- [new] [`-[MDCCollectionViewController collectionView:didUnhighlightItemAtIndexPath:]`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/Collections/src/MDCCollectionViewController.h#L58)
- [new] [`-[MDCCollectionViewController collectionView:shouldHighlightItemAtIndexPath:]`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/Collections/src/MDCCollectionViewController.h#L52)
- [new] [`-[MDCCollectionViewStylingDelegate collectionView:inkColorAtIndexPath:]`](https://github.com/material-components/material-components-ios/blob/6c8ca274056aed6850920f6010b47655c67730c9/components/Collections/src/MDCCollectionViewStylingDelegate.h#L136)
- [modified] [`-[MDCCollectionViewEditingDelegate collectionView:didDeleteItemsAtIndexPaths:]`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/Collections/src/MDCCollectionViewEditingDelegate.h#L197)

| From | To | Kind |
|:---- |:-- |:---- |
| - (void)collectionView:(nonnull UICollectionView *)collectionView didDeleteItemsAtIndexPaths:(nonnull NSArray *)indexPaths | - (void)collectionView:(nonnull UICollectionView *)collectionView didDeleteItemsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths | declaration |

- [modified] [`-[MDCCollectionViewEditingDelegate collectionView:willDeleteItemsAtIndexPaths:]`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/Collections/src/MDCCollectionViewEditingDelegate.h#L188)

| From | To | Kind |
|:---- |:-- |:---- |
| - (void)collectionView:(nonnull UICollectionView *)collectionView willDeleteItemsAtIndexPaths:(nonnull NSArray *)indexPaths | - (void)collectionView:(nonnull UICollectionView *)collectionView willDeleteItemsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths | declaration |

- [modified] [`-[MDCCollectionViewStylingDelegate collectionView:didApplyInlayToItemAtIndexPaths:]`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/Collections/src/MDCCollectionViewStylingDelegate.h#L102)

| From | To | Kind |
|:---- |:-- |:---- |
| - (void)collectionView:(nonnull UICollectionView *)collectionView didApplyInlayToItemAtIndexPaths:(nonnull NSArray *)indexPaths | - (void)collectionView:(nonnull UICollectionView *)collectionView didApplyInlayToItemAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths | declaration |

- [modified] [`-[MDCCollectionViewStylingDelegate collectionView:didRemoveInlayFromItemAtIndexPaths:]`](https://github.com/material-components/material-components-ios/blob/d2f436fdcfa711da5a8a077b42feb052c1abdf9e/components/Collections/src/MDCCollectionViewStylingDelegate.h#L112)

| From | To | Kind |
|:---- |:-- |:---- |
| - (void)collectionView:(nonnull UICollectionView *)collectionView didRemoveInlayFromItemAtIndexPaths:(nonnull NSArray *)indexPaths | - (void)collectionView:(nonnull UICollectionView *)collectionView didRemoveInlayFromItemAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths | declaration |

### Palettes

**New component.**

## Component changes

### AppBar

#### Changes

* [Remove deprecated parenting APIs.](https://github.com/material-components/material-components-ios/commit/f21d3adc78b87017d45f50bc806503689a42efa0) (Jeff Verkoeyen)
* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### ButtonBar

#### Changes

* [Add padding property to button bar buttons and position property to button bar](https://github.com/material-components/material-components-ios/commit/b6a7142a8fe0ccbc268c5f348d330f1a853fab15) (Junius Gunaratne)
* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### Buttons

#### Changes

* [[MDCButton] Center ink properly when insets change](https://github.com/material-components/material-components-ios/commit/699de7bcfbc346062ac01b59daf31b1b25d30290) (Junius Gunaratne)
* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### CollectionCells

#### Changes

* [Fixes bug preventing removal of accessoryView.](https://github.com/material-components/material-components-ios/commit/359ac696fa9e5a224f74631a1af1065b14545fa5) (Chris Cox)
* [Initializes ink if not available when requesting inkView](https://github.com/material-components/material-components-ios/commit/98eadc5f4c60d70702c316b1093b50c4a18232f9) (Chris Cox)

### Collections

#### Breaking changes

* [**Breaking**:  Updates ink to fire on cell highlight/unhighlight for faster response. Also adds demo to catalog.](https://github.com/material-components/material-components-ios/commit/86174317b321e73b71a02b8dddb43de17defac64) (Chris Cox)

#### Changes

* [Adds API to allow setting cell ink color at given index path.](https://github.com/material-components/material-components-ios/commit/6c8ca274056aed6850920f6010b47655c67730c9) (Chris Cox)
* [Adds lightweight generics to NSArray of NSIndexPath](https://github.com/material-components/material-components-ios/commit/4e79ce507f20232491ee325a482e04ae58eb3758) (Chris Cox)
* [Breaks out collection styling and editing into own docs.](https://github.com/material-components/material-components-ios/commit/82bd9cf5500641db0a9125c86464b8008493ca58) (Chris Cox)
* [Fixes bug where collection view subviews do not respect auto layout or rotation.](https://github.com/material-components/material-components-ios/commit/de5fdfcd8c3284839a45d8a400ddf89490204ccc) (Chris Cox)
* [Fixes swipe-to-dismiss section bug when attempting to snapshot non-existent 'inf' frame.](https://github.com/material-components/material-components-ios/commit/311ad111948ae0e552ec3cc93840290944322ff2) (Chris Cox)
* [Replaced screenshot with video.](https://github.com/material-components/material-components-ios/commit/7e124034ee9cf16bdb2c27927add5f36fc1a76c8) (Adrian Secord)
* [Updates readme Swipe to dismiss section](https://github.com/material-components/material-components-ios/commit/7e3b64e17f6f0212e073f15ab185f42f3458611e) (Chris Cox)

### FlexibleHeader

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### HeaderStackView

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### Ink

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### NavigationBar

#### Breaking changes

* [**Breaking**:  Pad the outer-most button's icons in accordance to the Material spec](https://github.com/material-components/material-components-ios/commit/968a7bc55bdf3a600ef9adbebc2b7b82f6f0eeaf) (Junius Gunaratne)

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### PageControl

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### Palettes

#### Changes

* [Final review to land in develop.](https://github.com/material-components/material-components-ios/commit/10cfe433b05f8557dcdb6f8ea1ebcc0b0368cd93) (Adrian Secord)

### RobotoFontLoader

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### ShadowLayer

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### Slider

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### Switch

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

### Typography

#### Changes

* [[Website] Added hero videos to component README.md files.](https://github.com/material-components/material-components-ios/commit/4b3b06d2ce615965db9c6f73b5fc0825122fd982) (Adrian Secord)

# 6.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o da19cc89a5bb91c94480aee818d2f0ac52410e1c -n bac6ea73c709e95ac88f202ca6c02e1ab88e91f5

### CollectionLayoutAttributes

- [new] [`MDCCollectionViewLayoutAttributes.backgroundImageViewInsets`](https://github.com/material-components/material-components-ios/blob/bac6ea73c709e95ac88f202ca6c02e1ab88e91f5/components/CollectionLayoutAttributes/src/MDCCollectionViewLayoutAttributes.h#L80)

### Switch

- [new] [`MDCSwitch.offImage`](https://github.com/material-components/material-components-ios/blob/bac6ea73c709e95ac88f202ca6c02e1ab88e91f5/components/Switch/src/MDCSwitch.h#L62)
- [new] [`MDCSwitch.onImage`](https://github.com/material-components/material-components-ios/blob/bac6ea73c709e95ac88f202ca6c02e1ab88e91f5/components/Switch/src/MDCSwitch.h#L55)

### Typography

- [deleted] [`MDCTypographyFontLoader`](https://github.com/material-components/material-components-ios/blob/da19cc89a5bb91c94480aee818d2f0ac52410e1c/components/Typography/src/MDCTypography.h#L144)

## Component changes

### AppBar

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)
* [Swift Interface Builder Example](https://github.com/material-components/material-components-ios/commit/d51f79c22b82f7ffd0b713316c349fea213ba4ec) (Ian Gordon)

### ButtonBar

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### Buttons

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)
* [Split out elevation = 0 special case for default relationship test.](https://github.com/material-components/material-components-ios/commit/3af13f435702e0bfdbc3cb2813b48fdeeb47826e) (Adrian Secord)
* [Temporarily correct MDCCollectionViewFlowLayout and MDCRaisedButton api reference with anchor tag link on summary page.](https://github.com/material-components/material-components-ios/commit/867f1519e799d5503bf26e480b200c16bee5bdb6) (Yiran Mao)
* [[MDCButton] Ink should match button frame to be centered properly](https://github.com/material-components/material-components-ios/commit/5ca5458eb684c90d08f4c9dfa43b788432a336e2) (Junius Gunaratne)

### CollectionCells

#### Changes

* [Fixes separator width which extended past cell bounds. Closes #448.](https://github.com/material-components/material-components-ios/commit/8022c97afa7f4e122e456867cc20bb0840a922fd) (Chris Cox)
* [Removes existing ink subview when setting a new one.](https://github.com/material-components/material-components-ios/commit/dd1b1e0c29d4423d74feb0cf577f7c2d9abf31ce) (Chris Cox)
* [[Collections] Updates attributes component API to allow passing the background image view outsets to the cell.](https://github.com/material-components/material-components-ios/commit/c11e5fce5a68ebc0b1bb0855911a71a7516f7fb5) (Chris Cox)

### CollectionLayoutAttributes

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)
* [[Collections] Updates attributes component API to allow passing the background image view outsets to the cell.](https://github.com/material-components/material-components-ios/commit/c11e5fce5a68ebc0b1bb0855911a71a7516f7fb5) (Chris Cox)

### Collections

#### Changes

* [Adds example of subclass providing own collection view.](https://github.com/material-components/material-components-ios/commit/2e08c3768d79cdad5a4aa7ac5b82a91573f7f5d9) (Chris Cox)
* [Caches decoration views used in grid layout. Cleans up layout invalidation logic.](https://github.com/material-components/material-components-ios/commit/9e37e3adc90e01f0c40be3266d0e9d0c96fcc2b6) (Chris Cox)
* [Fixed InkTouchControllerDelegate usage.](https://github.com/material-components/material-components-ios/commit/1fc3d8decf376bb9d74c20072a8b227da2c24e49) (Adrian Secord)
* [Fixes b/26750509 by copying any layout attributes first before editing.](https://github.com/material-components/material-components-ios/commit/1b1db1d67ab297712ec099be7f3fdb625ada370d) (Chris Cox)
* [Fixes grid layout invalidation causing crash.](https://github.com/material-components/material-components-ios/commit/4c883f073ca7370ea3af3c36b62854ddbf278da6) (Chris Cox)
* [Minor update to background color section of readme](https://github.com/material-components/material-components-ios/commit/4ae4bd796ea038d6bb86addbc0018f5269e0c405) (Chris Cox)
* [Removes internal collection view background color property allowing it to be customized from subclasses.](https://github.com/material-components/material-components-ios/commit/837f923f1cc88af51613ffd5fe9608e9310aecaa) (Chris Cox)
* [Temporarily correct MDCCollectionViewFlowLayout and MDCRaisedButton api reference with anchor tag link on summary page.](https://github.com/material-components/material-components-ios/commit/867f1519e799d5503bf26e480b200c16bee5bdb6) (Yiran Mao)
* [Updates Usage, Styling, and Editing sections of readme.](https://github.com/material-components/material-components-ios/commit/4930ace3b847d9159e9882acffc5d6d115226b94) (Chris Cox)
* [Updates attributes component API to allow passing the background image view outsets to the cell.](https://github.com/material-components/material-components-ios/commit/c11e5fce5a68ebc0b1bb0855911a71a7516f7fb5) (Chris Cox)
* [Updates editing example and readme to reverse sort order index paths before removal.](https://github.com/material-components/material-components-ios/commit/787c09ddb0e7f6066222be5029eb2e4ec84eb8fe) (Chris Cox)
* [Updates layout logic to include isEditing, thereby forcing infoBar positions to get updated.](https://github.com/material-components/material-components-ios/commit/6bb5bec0be597b24b4e01208e05ec8028754d5d9) (Chris Cox)

### FlexibleHeader

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### FontDiskLoader

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)
* [[Typography] Added description method.](https://github.com/material-components/material-components-ios/commit/67971238f09f90618fe2aa8037dad341d94b656e) (randallli)

### HeaderStackView

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### Ink

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### NavigationBar

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### PageControl

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### RobotoFontLoader

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### ShadowElevations

#### Changes

* [Added documentation and sorted alphabetically.](https://github.com/material-components/material-components-ios/commit/65e0db2b396634cb207f70aafaeee7b2db12a341) (Adrian Secord)
* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)
* [Removed typo from ShadowElevations/README.md.](https://github.com/material-components/material-components-ios/commit/4901733a5a7eb359587679adeaeb798bd8891c1f) (Adrian Secord)

### ShadowLayer

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### Slider

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### Switch

#### Changes

* [Add icons on the thumbview](https://github.com/material-components/material-components-ios/commit/17f46bfe53071ca8d75497eca571669a25aeebf6) (Ian Gordon)
* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

### Typography

#### Breaking changes

* [**Breaking**:  Removing deprecated protocol.](https://github.com/material-components/material-components-ios/commit/7dc8398d47a4a2226e2f2725ea8e0f72819d2169) (randallli)

#### Changes

* [Remove command prompt ('$') from command-line examples so they can be trivially copied and pasted.](https://github.com/material-components/material-components-ios/commit/f65f9e2ac4ffecaa689b8545339ac7e355cabea9) (Adrian Secord)

# 5.1.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 037551fa3b17c25f6546d290e41f747e3713bc4f -n 4b6b0a414e599af1fe3a29bba66af8e04ba67b4d

No public API changes.

## Component changes

### AppBar

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Move AppBar header configuration into init so that status bar style is accurate in Hero demo.](https://github.com/material-components/material-components-ios/commit/e46893e0ef87be5629281e1f4c1212a634b2f11c) (Jeff Verkoeyen)

### ButtonBar

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)

### Buttons

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)

### CollectionCells

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove unused MaterialCollectionCells.xcassets.](https://github.com/material-components/material-components-ios/commit/4b6b0a414e599af1fe3a29bba66af8e04ba67b4d) (Louis Romero)
* [Rename all images with @2x/@3x.](https://github.com/material-components/material-components-ios/commit/2df5344ee2a5a35d2e2c6d7d33ac79ecbdc1afba) (Louis Romero)

### CollectionLayoutAttributes

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)

### Collections

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Global find-and-replace of 'kMDC' with 'k'.](https://github.com/material-components/material-components-ios/commit/21d5cf1d04c4a6f296eb07fa82bf2d865674c7bb) (Jeff Verkoeyen)

### FlexibleHeader

#### Changes

* [Add contentOffset side effect tests.](https://github.com/material-components/material-components-ios/commit/c042c5f4e43c65b3cb1b35dd3be9f0c4e4606fa5) (Jeff Verkoeyen)
* [Always provide a valid frame for the issue176 tests.](https://github.com/material-components/material-components-ios/commit/283c87e9eb73d4d2d1f8b863a45f2a0ea966a129) (Jeff Verkoeyen)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove the internal contentOffset property.](https://github.com/material-components/material-components-ios/commit/3d4db0172e6e06109d6a6afdeaf148824a129bef) (Jeff Verkoeyen)
* [Revert "Resolve iOS 8.4 unit test failure of issue176 tests."](https://github.com/material-components/material-components-ios/commit/fe1ac2f14b7ad4179c84b01590df9c93289f2e36) (Jeff Verkoeyen)

### FontDiskLoader

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)

### HeaderStackView

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/b2639f397b7639716957f03a2b3421633796b877) (Jeff Verkoeyen)

### Ink

#### Changes

* [Clarified MDCInkTouchControllerDelegate inkTouchController:shouldProcessInkTouchesAtTouchLocation: documentation.](https://github.com/material-components/material-components-ios/commit/6241d918df44a82218349223285d6b9881d8534b) (Adrian Secord)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Global find-and-replace of 'kMDC' with 'k'.](https://github.com/material-components/material-components-ios/commit/21d5cf1d04c4a6f296eb07fa82bf2d865674c7bb) (Jeff Verkoeyen)

### NavigationBar

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)

### PageControl

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Global find-and-replace of 'kMDC' with 'k'.](https://github.com/material-components/material-components-ios/commit/21d5cf1d04c4a6f296eb07fa82bf2d865674c7bb) (Jeff Verkoeyen)

### RobotoFontLoader

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)

### ShadowElevations

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)

### ShadowLayer

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Global find-and-replace of 'kMDC' with 'k'.](https://github.com/material-components/material-components-ios/commit/21d5cf1d04c4a6f296eb07fa82bf2d865674c7bb) (Jeff Verkoeyen)

### Slider

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)

### SpritedAnimationView

#### Changes

* [Global find-and-replace of 'kMDC' with 'k'.](https://github.com/material-components/material-components-ios/commit/21d5cf1d04c4a6f296eb07fa82bf2d865674c7bb) (Jeff Verkoeyen)
* [Rename all images with @2x/@3x.](https://github.com/material-components/material-components-ios/commit/2df5344ee2a5a35d2e2c6d7d33ac79ecbdc1afba) (Louis Romero)

### Switch

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Global find-and-replace of 'kMDC' with 'k'.](https://github.com/material-components/material-components-ios/commit/21d5cf1d04c4a6f296eb07fa82bf2d865674c7bb) (Jeff Verkoeyen)
* [Set the switch's ink's max ripple radius to the spec value.](https://github.com/material-components/material-components-ios/commit/c15fd0c5c18e442947728472b7b33381cae78f45) (Adrian Secord)

### Typography

#### Changes

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)


# 5.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 55afa3aaef67799bdb8a94881f31c5c3b242e9a6 -n fe1ac2f14b7ad4179c84b01590df9c93289f2e36

### CollectionCells

**New component.**

### CollectionLayoutAttributes

**New component.**

### Collections

**New component.**

### FlexibleHeader

- [new] [`MDCFlexibleHeaderView.statusBarHintCanOverlapHeader`](https://github.com/material-components/material-components-ios/blob/fe1ac2f14b7ad4179c84b01590df9c93289f2e36/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L344)

### PageControl

- [protocols changed] [`MDCPageControl`](https://github.com/material-components/material-components-ios/blob/fe1ac2f14b7ad4179c84b01590df9c93289f2e36/components/PageControl/src/MDCPageControl.h#L41).
Added *UIScrollViewDelegate*.

## Component changes

### AppBar

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove mention of deprecated API.](https://github.com/material-components/material-components-ios/commit/1b35fe48b4f411c049689b398711682513b954d1) (Louis Romero)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Remove the internal MDCAppBarContainerViewController contentViewController setter.](https://github.com/material-components/material-components-ios/commit/8100c088133fd5799eb9f692ab76f463acaab715) (Jeff Verkoeyen)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Revert replace + with _ in icon names](https://github.com/material-components/material-components-ios/commit/552d66f3fb2f258446f1b41951457ee494e7bc06) (Junius Gunaratne)
* [Typical Use Example moving logic from init into viewDidLoad](https://github.com/material-components/material-components-ios/commit/0dc8870271222083a2a4dbbf55dd249a5b5cd4f5) (randallli)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[AppBar]! NSLog warning to NSAssert for incorrect parentViewController behavior.](https://github.com/material-components/material-components-ios/commit/8f3c3f8607ff295b8594ea1edbe8dadb244eaaaa) (randallli)
* [[AppBar]? Added NSLog to ensure that addChildViewController: is called before addSubviewsToParent](https://github.com/material-components/material-components-ios/commit/c7a3891fe9754962cbbb14157cd5595ca5b0abec) (randallli)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog] Example view controllers must implement init.](https://github.com/material-components/material-components-ios/commit/ea405734e97bf96bff2d97f46b28322a0aa2b753) (Jeff Verkoeyen)
* [[Catalog] Fixing Swift example view controller initializers.](https://github.com/material-components/material-components-ios/commit/8e733e163a4b308186345e03d90056e4040c693b) (Jeff Verkoeyen)
* [[Catalog] Make example titles consistent, use Component Name](https://github.com/material-components/material-components-ios/commit/ebd1fbd14c6d2b0c052e28a9bc3cf59a6e01e75e) (Junius Gunaratne)
* [[Catalog] Update AppBar demo design, table view should not have text](https://github.com/material-components/material-components-ios/commit/a147d7b359d1d99fca81aa97594d93263a3cedee) (Junius Gunaratne)
* [[Icons] Replace + with _ in icon names](https://github.com/material-components/material-components-ios/commit/c0bd1de8e5520102f59e9b92d8a1085b285be38e) (Junius Gunaratne)

### ButtonBar

* [Check UIBarButtonItem global appearance configuration when creating the buttons.](https://github.com/material-components/material-components-ios/commit/e3a56fe9624ab978850665ab4f06479ebe5e13bf) (Jeff Verkoeyen)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Update tests to reflect that titleTextAttributes appearance only works on iOS 9.](https://github.com/material-components/material-components-ios/commit/916866a5259d3972ff359f0d57bce67bdb982ed2) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog] Example view controllers must implement init.](https://github.com/material-components/material-components-ios/commit/ea405734e97bf96bff2d97f46b28322a0aa2b753) (Jeff Verkoeyen)
* [[Catalog] Fixing Swift example view controller initializers.](https://github.com/material-components/material-components-ios/commit/8e733e163a4b308186345e03d90056e4040c693b) (Jeff Verkoeyen)
* [[Catalog] Make example titles consistent, use Component Name](https://github.com/material-components/material-components-ios/commit/ebd1fbd14c6d2b0c052e28a9bc3cf59a6e01e75e) (Junius Gunaratne)

### Buttons

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Resolve deprecation warnings.](https://github.com/material-components/material-components-ios/commit/13bb72bed147c249d9db1e8a31e3f7d9a62ecc46) (Jeff Verkoeyen)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog] Adjust layout for button example in landscape mode, move layout to supplemental](https://github.com/material-components/material-components-ios/commit/28e1904f7884de7c18ff646b722678a044497506) (Junius Gunaratne)
* [[Catalog] Fixing Swift example view controller initializers.](https://github.com/material-components/material-components-ios/commit/8e733e163a4b308186345e03d90056e4040c693b) (Jeff Verkoeyen)

### CollectionCells

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Rename all images with @2x/@3x.](https://github.com/material-components/material-components-ios/commit/2df5344ee2a5a35d2e2c6d7d33ac79ecbdc1afba) (Louis Romero)
* [Update README to indicate its present state.](https://github.com/material-components/material-components-ios/commit/a48e31fb2e9aa814198ad3c510b9e653a0f91e72) (Jeff Verkoeyen)
* [Updates cells to depend on MDCIcons for editing and accessory icons.](https://github.com/material-components/material-components-ios/commit/7598638db3ecd26e09a82988857a86806bc1dfe5) (Chris Cox)
* [[Collections] Merge Collections, CollectionCells, and CollectionLayoutAttributes components.](https://github.com/material-components/material-components-ios/commit/f15f6d5db6bcb0ddc6a750683daa649775f1e049) (Chris Cox)
* [[Collections] Replace EditingManager with an Editing protocol.](https://github.com/material-components/material-components-ios/commit/60ffaa55909fd931d976ecbd55f91b5d71394ce4) (Jeff Verkoeyen)
* [[Collections] Replace StyleManager with a Styling protocol.](https://github.com/material-components/material-components-ios/commit/8b925d001c8de48e226de4c83556ad5c440d9301) (Jeff Verkoeyen)
* [[Collections] Updates readmes.](https://github.com/material-components/material-components-ios/commit/a858523cb27c6b7f891d5cfec4722172deb71b5a) (Chris Cox)

### CollectionLayoutAttributes

* [Added unit tests for MDCCollectionLayoutAttributes.](https://github.com/material-components/material-components-ios/commit/142bd2fb7e8cb846fdb449d58873fd5f75419bd1) (Adrian Secord)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Removes broken image.](https://github.com/material-components/material-components-ios/commit/ee3daf2fe52d44c8e552f40ffdd039f6937f896b) (Chris Cox)
* [[Collections] Merge Collections, CollectionCells, and CollectionLayoutAttributes components.](https://github.com/material-components/material-components-ios/commit/f15f6d5db6bcb0ddc6a750683daa649775f1e049) (Chris Cox)
* [[Collections] Updates readmes.](https://github.com/material-components/material-components-ios/commit/a858523cb27c6b7f891d5cfec4722172deb71b5a) (Chris Cox)

### Collections

* [Adds swift example.](https://github.com/material-components/material-components-ios/commit/e88dc4ff3fffd72b29b6b98d2479b4c4334165a4) (Chris Cox)
* [Cells divider is 1 pixel.](https://github.com/material-components/material-components-ios/commit/3ef520462a07f8b015e96b3f5497ec11ff6caf28) (Louis Romero)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Merge Collections, CollectionCells, and CollectionLayoutAttributes components.](https://github.com/material-components/material-components-ios/commit/f15f6d5db6bcb0ddc6a750683daa649775f1e049) (Chris Cox)
* [Removes broken image.](https://github.com/material-components/material-components-ios/commit/ee3daf2fe52d44c8e552f40ffdd039f6937f896b) (Chris Cox)
* [Replace EditingManager with an Editing protocol.](https://github.com/material-components/material-components-ios/commit/60ffaa55909fd931d976ecbd55f91b5d71394ce4) (Jeff Verkoeyen)
* [Replace StyleManager with a Styling protocol.](https://github.com/material-components/material-components-ios/commit/8b925d001c8de48e226de4c83556ad5c440d9301) (Jeff Verkoeyen)
* [Updates readmes.](https://github.com/material-components/material-components-ios/commit/a858523cb27c6b7f891d5cfec4722172deb71b5a) (Chris Cox)
* [Updates to readme.](https://github.com/material-components/material-components-ios/commit/24972cb03d7a9ad30c635fd865ffe428788bda95) (Chris Cox)
* [Updates to readme.](https://github.com/material-components/material-components-ios/commit/89f5075dcdc2ddc20e22756ee408db53c8ffa967) (Chris Cox)

### FlexibleHeader

* [Add horizontal paging example.](https://github.com/material-components/material-components-ios/commit/bf2c12bd7c9b46eb23858673e6c63d3dfa20edf4) (Jeff Verkoeyen)
* [Add status bar visibility switch to configurator example.](https://github.com/material-components/material-components-ios/commit/34b656298fd35fe1440a5e0bfcf9e10934199d91) (Jeff Verkoeyen)
* [Add statusBarCanOverlapHeader property to MDCFlexibleHeaderView.](https://github.com/material-components/material-components-ios/commit/1229fc7b266eb939976a652a695f3d0b201cfea3) (Jeff Verkoeyen)
* [Configurator example is now a table view.](https://github.com/material-components/material-components-ios/commit/b9b819536bf19eca5298acc9fd471f92333cb555) (Jeff Verkoeyen)
* [Consolidate frame projection logic.](https://github.com/material-components/material-components-ios/commit/6b38608a33de7227143faa80933df7c2152c509f) (Jeff Verkoeyen)
* [Convert typical use example to use Interface Builder + auto layout.](https://github.com/material-components/material-components-ios/commit/a0690af49c5c92b1659950863ba8df7d21ff4428) (Jeff Verkoeyen)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Funnel init through initWithStyle:.](https://github.com/material-components/material-components-ios/commit/35206a410e0fd5bc365d69fbbc0d955006558cdd) (Jeff Verkoeyen)
* [Hide header contents in the configurator when the header is shifting.](https://github.com/material-components/material-components-ios/commit/9310ae9de1f5e7a05cfe195f89852eeb9ea7ae33) (Jeff Verkoeyen)
* [Implement the correct designated initializer chain in the Configurator example.](https://github.com/material-components/material-components-ios/commit/c1777eb1f1e9e095257f20cd30a54d7ebc13fff7) (Jeff Verkoeyen)
* [Pull the instructions view out of the typical use example.](https://github.com/material-components/material-components-ios/commit/589c2bf3396a9844ca91f1a8e92a96fc92eaace1) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/a15bfbe35bdd6e61e17739ff4199b6a3940398a0) (Jeff Verkoeyen)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Remove usage of iOS 9 API in Configurator example.](https://github.com/material-components/material-components-ios/commit/6951e147d0a140fce0c9df61a5a074765ee0c0e8) (Jeff Verkoeyen)
* [Resolve iOS 8.4 unit test failure of issue176 tests.](https://github.com/material-components/material-components-ios/commit/271572706e98e93edde01a30a14daf129f639306) (Jeff Verkoeyen)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Revert "Resolve iOS 8.4 unit test failure of issue176 tests."](https://github.com/material-components/material-components-ios/commit/fe1ac2f14b7ad4179c84b01590df9c93289f2e36) (Jeff Verkoeyen)
* [Shift status bar with header](https://github.com/material-components/material-components-ios/commit/c8b22b1b344d211ecf04974bcd212a45e4673165) (keefertaylor)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Update README to include Swift examples](https://github.com/material-components/material-components-ios/commit/e46a7a032171b138b2fd62c74e1d8893fd95b166) (Ian Gordon)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [When changing min/max height, update the opposite property to match the new bounds.](https://github.com/material-components/material-components-ios/commit/757c0ec76413f0bd92b92ddc13692e803c6e0bff) (Jeff Verkoeyen)
* [When injecting insets, set the contentOffset rather than change it relatively.](https://github.com/material-components/material-components-ios/commit/fe107a900cde37fd4f4321d8cf333a20e040669f) (Jeff Verkoeyen)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog] Example view controllers must implement init.](https://github.com/material-components/material-components-ios/commit/ea405734e97bf96bff2d97f46b28322a0aa2b753) (Jeff Verkoeyen)
* [[Catalog] Make example titles consistent, use Component Name](https://github.com/material-components/material-components-ios/commit/ebd1fbd14c6d2b0c052e28a9bc3cf59a6e01e75e) (Junius Gunaratne)
* [[FlexibleHeader]! No longer remove insets from tracking scroll views during dealloc.](https://github.com/material-components/material-components-ios/commit/4ddbae5d6342b3552914e1c4148e4dad11a70d88) (Jeff Verkoeyen)

### FontDiskLoader

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog and Typography] Group Typography and Font Loader examples into Typography and Fonts](https://github.com/material-components/material-components-ios/commit/62f57e2b290155d5bfdfafb3f27839eb8e9c1eb5) (Junius Gunaratne)

### HeaderStackView

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/a15bfbe35bdd6e61e17739ff4199b6a3940398a0) (Jeff Verkoeyen)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Rename mdc_theme.png to header_stack_view_theme.png.](https://github.com/material-components/material-components-ios/commit/03e0cdb05742eca86b0c2f2ee678d99617827cbe) (Jeff Verkoeyen)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog] Add autoresize masks to header stack view demo for landscape orientation](https://github.com/material-components/material-components-ios/commit/6206c48cb0dfb3c23ed228ba31fce6892c3094b8) (Junius Gunaratne)
* [[Catalog] Fix color change issue in header stack view demo](https://github.com/material-components/material-components-ios/commit/ed9c65c3d22e1318aac4b06b8442e6f8e7fa3428) (Junius Gunaratne)
* [[Catalog] Update AppBar demo design, table view should not have text](https://github.com/material-components/material-components-ios/commit/a147d7b359d1d99fca81aa97594d93263a3cedee) (Junius Gunaratne)
* [[Catalog] Update Header Stack View demo visuals, move layout code into supplemental](https://github.com/material-components/material-components-ios/commit/cdc18fb8ccda075e1f8c56fd638c3a66df6f4a93) (Junius Gunaratne)
* [added missing swift code snippet to readme.](https://github.com/material-components/material-components-ios/commit/06df37a74d2b9e99f620c09a2674cc3853c42b19) (randallli)

### Ink

* [Clarified MDCInkTouchControllerDelegate inkTouchController:shouldProcessInkTouchesAtTouchLocation: documentation.](https://github.com/material-components/material-components-ios/commit/6241d918df44a82218349223285d6b9881d8534b) (Adrian Secord)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Update README to include Swift examples](https://github.com/material-components/material-components-ios/commit/6dfac14b518bd81dc62c3398f4416a3cf1fe57e3) (Ian Gordon)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog] Change ink demo shapes to represent pseudo button/FAB, move layout code into supplemental](https://github.com/material-components/material-components-ios/commit/d0683a0e0bbe73fb36641c9ea92a5e715c438d19) (Junius Gunaratne)

### NavigationBar

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Explain exception for UINavigationBar/MDCNavigationBar comparison.](https://github.com/material-components/material-components-ios/commit/5187441e7d42f8006372dbd245e0f51ce1803c53) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/a15bfbe35bdd6e61e17739ff4199b6a3940398a0) (Jeff Verkoeyen)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [Use UIViewNoIntrinsicMetric to indicate the the NavigationBar has no intrinsic width.](https://github.com/material-components/material-components-ios/commit/1e84b7cd5173d85bffb77628341e91d08a90ced6) (Jeff Verkoeyen)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog] Make example titles consistent, use Component Name](https://github.com/material-components/material-components-ios/commit/ebd1fbd14c6d2b0c052e28a9bc3cf59a6e01e75e) (Junius Gunaratne)
* [[Examples] Correcting scope modifier of functions in Swift](https://github.com/material-components/material-components-ios/commit/6d5406baac2d0bb484fff90882c39309a68bc744) (Will Larche)

### PageControl

* [Added MDCPageControl initWithCoder:.](https://github.com/material-components/material-components-ios/commit/43cd7fea3208134fbcf324d11492a9fd182506b4) (Adrian Secord)
* [Added test for updating the currentPage when the contentOffset changes](https://github.com/material-components/material-components-ios/commit/ac8642f4a0b9cd90946ff6fa65440a39b934ebbf) (randallli)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Created swift example for page control and added it to readme](https://github.com/material-components/material-components-ios/commit/1272a1275b219d252dffcefc7748b0e025e50829) (randallli)
* [Fix crash when scrollView offset is set out of bounds of the numberOfPages](https://github.com/material-components/material-components-ios/commit/e1f584adad2950a9c46ba7dba2da01461b6ea899) (randallli)
* [Publicized conformance to UIScrollViewDelegate.](https://github.com/material-components/material-components-ios/commit/e0d8050ef395928ba3eee40045059b9c46c9f21a) (randallli)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)

### RobotoFontLoader

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog and Typography] Group Typography and Font Loader examples into Typography and Fonts](https://github.com/material-components/material-components-ios/commit/62f57e2b290155d5bfdfafb3f27839eb8e9c1eb5) (Junius Gunaratne)

### ShadowElevations

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Update documention with Objective C examples](https://github.com/material-components/material-components-ios/commit/49af52411077d5587ccc4bcb4019ac5ece4a55fe) (Ian Gordon)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog and Shadow] Group shadow elevations with shadow demos](https://github.com/material-components/material-components-ios/commit/b8dc78d58c06c45a8616e6798839b37fd065fc05) (Junius Gunaratne)

### ShadowLayer

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog and Shadow] Group shadow elevations with shadow demos](https://github.com/material-components/material-components-ios/commit/b8dc78d58c06c45a8616e6798839b37fd065fc05) (Junius Gunaratne)
* [[Catalog] Make catalogIsPrimaryDemo static method in demos](https://github.com/material-components/material-components-ios/commit/7bb181a150bc1cf707637fdf112d3a949638c809) (Junius Gunaratne)
* [[Shadow] Add swift examples to the documentation](https://github.com/material-components/material-components-ios/commit/adba94e106b4e576160f15380f97f720800ec373) (Ian Gordon)

### Slider

* [Added swift example to slider readme](https://github.com/material-components/material-components-ios/commit/835a6d358253253cbd3bea960fd8eebb09ddfaf3) (randallli)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Fix unit tests by increasing epsilon](https://github.com/material-components/material-components-ios/commit/8ab280fdc926fe389396a248f2d28dc24fa75c97) (randallli)
* [Fixes MDCSlider example build with required import.](https://github.com/material-components/material-components-ios/commit/bd6ef35fd82c4ee16d2a4d077e224499a3abe9ed) (Adrian Secord)
* [Import the umbrella header in the typical use example.](https://github.com/material-components/material-components-ios/commit/917f68f953132ba345fdf70fe79d80c3d68b23b6) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/a15bfbe35bdd6e61e17739ff4199b6a3940398a0) (Jeff Verkoeyen)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog] Make catalogIsPrimaryDemo method in slider demo static to match other examples](https://github.com/material-components/material-components-ios/commit/a9a28c4cde35e476e886c1f90c44b96988c72f73) (Junius Gunaratne)
* [[Catalog] Use slider in variable names in example layout code](https://github.com/material-components/material-components-ios/commit/784e9a57be01dfa8f93528aa4a92de0b772b4605) (Junius Gunaratne)

### SpritedAnimationView

* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Rename all images with @2x/@3x.](https://github.com/material-components/material-components-ios/commit/2df5344ee2a5a35d2e2c6d7d33ac79ecbdc1afba) (Louis Romero)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)

### Switch

* [Added swift example to catalog and readme.](https://github.com/material-components/material-components-ios/commit/1a7d800cc9a6b29320bf57d61806a85cde387f15) (randallli)
* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Rename label from slider to switch.](https://github.com/material-components/material-components-ios/commit/c92a9510bc8ed6d18339b4d7928cc470cc2a4f07) (Ian Gordon)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Set the switch's ink's max ripple radius to the spec value.](https://github.com/material-components/material-components-ios/commit/c15fd0c5c18e442947728472b7b33381cae78f45) (Adrian Secord)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog & Examples] Added navigationBar example in Swift (Supplemental POC) and corrected slight mistake in Catalog by Convention logic.](https://github.com/material-components/material-components-ios/commit/2ab08f41337d1ef1392bec46f534fe95fb2ac79e) (Will Larche)
* [[Catalog and Switch] Update switch demo, move layout code to supplemental, update switch color](https://github.com/material-components/material-components-ios/commit/e700bf58ee43e35d34b565b9b04f0af4b03f1288) (Junius Gunaratne)
* [[Catalog] Make example titles consistent, use Component Name](https://github.com/material-components/material-components-ios/commit/ebd1fbd14c6d2b0c052e28a9bc3cf59a6e01e75e) (Junius Gunaratne)

### Typography

* [Correct links for deploy on various deployment environment.](https://github.com/material-components/material-components-ios/commit/2b6f7f40a75410e57e13c20cab2d18dd09ae2566) (Yiran Mao)
* [Remove obsolete jazzy.yaml files.](https://github.com/material-components/material-components-ios/commit/fffb75e91e8ab5b979dba7a7fec661d1a058bb11) (Yiran Mao)
* [Resolve iOS 8.4 crash in the Typography hero demo.](https://github.com/material-components/material-components-ios/commit/0859d4b2b2ba8e7e9d91fbd757ac4b0a006384fc) (Jeff Verkoeyen)
* [Revert "Remove obsolete jazzy.yaml files."](https://github.com/material-components/material-components-ios/commit/ad228a154455835c3e871109f12670387b9d926d) (Jeff Verkoeyen)
* [Set autoresizing masks on Read Me example.](https://github.com/material-components/material-components-ios/commit/b54b2c96978fdb15d44c15b565f94ab43e60a22a) (Jeff Verkoeyen)
* [Typography hero demo is now a UITableView.](https://github.com/material-components/material-components-ios/commit/25c20a9abf9a6c9d30397dc7387646ead5fcafc4) (Jeff Verkoeyen)
* [Update .jazzy.yaml module property.](https://github.com/material-components/material-components-ios/commit/977626313e702783835f7ad1aba220b99316ba3f) (Jeff Verkoeyen)
* [Updated top-level "Documentation" to "Components".](https://github.com/material-components/material-components-ios/commit/ac38382e86f058593de41756fb8360dc5a156a10) (Adrian Secord)
* [[Catalog and Typography] Group Typography and Font Loader examples into Typography and Fonts](https://github.com/material-components/material-components-ios/commit/62f57e2b290155d5bfdfafb3f27839eb8e9c1eb5) (Junius Gunaratne)
* [[Catalog] Fixing Swift example view controller initializers.](https://github.com/material-components/material-components-ios/commit/8e733e163a4b308186345e03d90056e4040c693b) (Jeff Verkoeyen)
* [[Catalog] Make catalogIsPrimaryDemo static method in demos](https://github.com/material-components/material-components-ios/commit/7bb181a150bc1cf707637fdf112d3a949638c809) (Junius Gunaratne)
* [[Catalog] Title row name should correspond to type style](https://github.com/material-components/material-components-ios/commit/a576d6e7ae209a1d3308f1fe6312ae0ef4c5e54d) (Junius Gunaratne)

# 4.0.1

## API diffs

Auto-generated by running:

    scripts/api_diff -o 1542251633905c3c2089b38f1c01a5010a8894f1 -n 789beeb556aab8b4aeddb71fa837d7db8c4660d7

### Typography

- [deleted] [`MDCFontResource`](https://github.com/material-components/material-components-ios/blob/1542251633905c3c2089b38f1c01a5010a8894f1/components/Typography/src/MDCFontResource.h#L21)

## Component changes

### Typography

* [[Typgoraphy]! Deleted files need for deprecation](https://github.com/material-components/material-components-ios/commit/789beeb556aab8b4aeddb71fa837d7db8c4660d7) (randallli)

# 4.0.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o 11959487eb429c37b382c521a1c469eac96ed0da -n 7cc87bd6d90ed2c641212339f00f67b08fb76314

### Buttons

- [new] [`+[MDCFloatingButton floatingButtonWithShape:]`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Buttons/src/MDCFloatingButton.h#L50)
- [new] [`MDCButton.inkMaxRippleRadius`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Buttons/src/MDCButton.h#L66)
- [new] [`MDCButton.inkStyle`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Buttons/src/MDCButton.h#L57)
- [new] [`MDCButton.underlyingColorHint`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Buttons/src/MDCButton.h#L116)
- [new] [`MDCButton.uppercaseTitle`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Buttons/src/MDCButton.h#L90)
- [deprecated] [`+[MDCFloatingButton buttonWithShape:]`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Buttons/src/MDCFloatingButton.h#L84).
*Use floatingButtonWithShape: instead.*
- [deprecated] [`MDCButton.shouldCapitalizeTitle`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Buttons/src/MDCButton.h#L166).
*Use uppercaseTitle instead.*
- [deprecated] [`MDCButton.underlyingColor`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Buttons/src/MDCButton.h#L168).
*Use underlyingColorHint instead.*

### FlexibleHeader

- [new] [`MDCFlexibleHeaderContentImportanceDefault`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L53)
- [new] [`MDCFlexibleHeaderContentImportanceHigh`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L63)
- [new] [`MDCFlexibleHeaderContentImportance`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L48)
- [new] [`MDCFlexibleHeaderView.headerContentImportance`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L308)
- [property attribute change] [`MDCFlexibleHeaderView.shadowLayer`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L109).
Removed *retain*.
Added *strong*.

### Ink

- [deleted] [`-[MDCInkView evaporateToPoint:completion:]`](https://github.com/material-components/material-components-ios/blob/11959487eb429c37b382c521a1c469eac96ed0da/components/Ink/src/MDCInkView.h#L123)
- [deleted] [`-[MDCInkView evaporateWithCompletion:]`](https://github.com/material-components/material-components-ios/blob/11959487eb429c37b382c521a1c469eac96ed0da/components/Ink/src/MDCInkView.h#L121)
- [deleted] [`-[MDCInkView reset]`](https://github.com/material-components/material-components-ios/blob/11959487eb429c37b382c521a1c469eac96ed0da/components/Ink/src/MDCInkView.h#L118)
- [deleted] [`-[MDCInkView spreadFromPoint:completion:]`](https://github.com/material-components/material-components-ios/blob/11959487eb429c37b382c521a1c469eac96ed0da/components/Ink/src/MDCInkView.h#L119)
- [deleted] [`MDCInkView.clipsRippleToBounds`](https://github.com/material-components/material-components-ios/blob/11959487eb429c37b382c521a1c469eac96ed0da/components/Ink/src/MDCInkView.h#L115)
- [deleted] [`MDCInkView.fillsBackgroundOnSpread`](https://github.com/material-components/material-components-ios/blob/11959487eb429c37b382c521a1c469eac96ed0da/components/Ink/src/MDCInkView.h#L113)
- [deleted] [`MDCInkView.gravitatesInk`](https://github.com/material-components/material-components-ios/blob/11959487eb429c37b382c521a1c469eac96ed0da/components/Ink/src/MDCInkView.h#L117)
- [new] [`-[MDCInkTouchController inkViewAtTouchLocation:]`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Ink/src/MDCInkTouchController.h#L114)
- [new] [`MDCInkTouchController.defaultInkView`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Ink/src/MDCInkTouchController.h#L43)
- [deprecated] [`MDCInkTouchController.inkView`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/Ink/src/MDCInkTouchController.h#L118).
*To configure ink views before display, use defaultInkView or your delegate's inkTouchController:inkViewAtTouchLocation:. To find an ink view at a particular location, use inkViewAtTouchLocation: instead.*

### RobotoFontLoader

- [protocols changed] [`MDCRobotoFontLoader`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/RobotoFontLoader/src/MDCRobotoFontLoader.h#L25).
Added *MDCTypographyFontLoading*.

### ScrollViewDelegateMultiplexer

- [deprecated] [`MDCScrollViewDelegateCombining`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/ScrollViewDelegateMultiplexer/src/MDCScrollViewDelegateMultiplexer.h#L79).
*This component is now available at https://github.com/google/GOSScrollViewDelegateMultiplexer.*
- [deprecated] [`MDCScrollViewDelegateMultiplexer`](https://github.com/material-components/material-components-ios/blob/7cc87bd6d90ed2c641212339f00f67b08fb76314/components/ScrollViewDelegateMultiplexer/src/MDCScrollViewDelegateMultiplexer.h#L45).
*This component is now available at https://github.com/google/GOSScrollViewDelegateMultiplexer.*

## Component changes

### AppBar

* [Add delegate forwarding example.](https://github.com/material-components/material-components-ios/commit/5fa1719a8b999566098b6d67f5b990438e18a0ce) (Jeff Verkoeyen)
* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Change imagery example to use design sanctioned background](https://github.com/material-components/material-components-ios/commit/e3fee6c71211d993b1fc6af8b11964659e183d24) (Junius Gunaratne)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/8416f8e540e32594163ce2d6b55930f8260ad891) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[Catalog] Update App Bar bg and text color](https://github.com/material-components/material-components-ios/commit/168f7ecc07655dc77b1e1ec50980a9fab37ec0e5) (Junius Gunaratne)

### ButtonBar

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Exposed ink style and max ripple radius and modified MDCButtonBarButton.](https://github.com/material-components/material-components-ios/commit/105810c544aa6cae8cb69bf58d64c057487cff45) (Adrian Secord)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Icon-only buttons use unbounded ink. Buttons with text us bounded ink.](https://github.com/material-components/material-components-ios/commit/792c128c8b91674d555ac5fcc730ccea99b6db71) (Jeff Verkoeyen)
* [Renamed commonInit methods.](https://github.com/material-components/material-components-ios/commit/2e247f2977456fad0b470f7329f0c61439a8347f) (Adrian Secord)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Center button bar demo example](https://github.com/material-components/material-components-ios/commit/8c258529c068352e15907d62c76e9ed4b3014816) (Junius Gunaratne)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)

### Buttons

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Changes from API review.](https://github.com/material-components/material-components-ios/commit/6f79195001fe2afca913658a581d428a7c34f2f0) (Adrian Secord)
* [Exposed ink style and max ripple radius and modified MDCButtonBarButton.](https://github.com/material-components/material-components-ios/commit/105810c544aa6cae8cb69bf58d64c057487cff45) (Adrian Secord)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Fixed float conversion.](https://github.com/material-components/material-components-ios/commit/1ef0af44c9752e2d2d28fc76bb207242c83230ac) (Adrian Secord)
* [Fixed the order of MDCButton's initWithCoder:.](https://github.com/material-components/material-components-ios/commit/8f149123b32bfc5b38e02d93c36a2bf6dce51488) (Adrian Secord)
* [Layout design updates for buttons demo.](https://github.com/material-components/material-components-ios/commit/1269fbfb4d38261506c3aeee73d12800ecbaffc4) (Jason Striegel)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/8416f8e540e32594163ce2d6b55930f8260ad891) (Jeff Verkoeyen)
* [Renamed commonInit methods.](https://github.com/material-components/material-components-ios/commit/2e247f2977456fad0b470f7329f0c61439a8347f) (Adrian Secord)
* [Update example](https://github.com/material-components/material-components-ios/commit/363a766c94b8157f6030d084be0c934681f7cb1d) (Ian Gordon)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [screen grab demo.](https://github.com/material-components/material-components-ios/commit/58279ee77d4ccfae19b91a72fa9c5efd8a86d6a9) (Jason Striegel)

### FlexibleHeader

* [Add headerContentImportance.](https://github.com/material-components/material-components-ios/commit/d7accbaf244d86a0f64cf5a25dc214b0c676ae4d) (Jeff Verkoeyen)
* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Configurator demo min/max sliders react to each other.](https://github.com/material-components/material-components-ios/commit/6a5918450df03683497d5be923b34cf34ee008b5) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/8416f8e540e32594163ce2d6b55930f8260ad891) (Jeff Verkoeyen)
* [Replaced retain with strong.](https://github.com/material-components/material-components-ios/commit/2d3c95a9359b825983dab54e16ddb888e38ee098) (Adrian Secord)
* [Update documentation for the deprecated contentView API.](https://github.com/material-components/material-components-ios/commit/6f3707046e621b896abaf69a5a2df15d7a08c3fb) (Jeff Verkoeyen)
* [[AppBar] Add delegate forwarding example.](https://github.com/material-components/material-components-ios/commit/5fa1719a8b999566098b6d67f5b990438e18a0ce) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)

### FontDiskLoader

* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [[DiskFontLoader] Added readme and simple example.](https://github.com/material-components/material-components-ios/commit/a325fdf973406fb15324409faebe0072f45606f1) (randallli)
* [[RobotoFontLoader, FontDiskLoader, Typography] Readme: Added some missing sections and edits.](https://github.com/material-components/material-components-ios/commit/2fe58210bb9dc57f1a5ad1f09587b3b678aab8b1) (randallli)
* [fix readme spurious }](https://github.com/material-components/material-components-ios/commit/0350ef09a878d160f5c8ee6a634fe6ce24bd906b) (randallli)
* [fix readme syntax](https://github.com/material-components/material-components-ios/commit/d0d72909e8723a88d1aebe449287117320b60e1c) (randallli)

### HeaderStackView

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)

### Ink

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Adds defaultInkView, inkViewAtLocation:.](https://github.com/material-components/material-components-ios/commit/9ff47756e291793e03d9afec6da84b48c865f863) (Adrian Secord)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Removed deprecated Ink APIs.](https://github.com/material-components/material-components-ios/commit/fdaba18e1bca7688423f619178daf074a8c31edb) (Adrian Secord)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[Catalog] Layout ink examples horizontally in landscape orientation](https://github.com/material-components/material-components-ios/commit/ecc87e4410e35d748821c84d5dde81de950eee7e) (Junius Gunaratne)

### NavigationBar

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/8416f8e540e32594163ce2d6b55930f8260ad891) (Jeff Verkoeyen)
* [Renamed commonInit methods.](https://github.com/material-components/material-components-ios/commit/2e247f2977456fad0b470f7329f0c61439a8347f) (Adrian Secord)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[Catalog] Use white title and hide status bar in Navigation Bar demo](https://github.com/material-components/material-components-ios/commit/49bffc8800302003c3be5bfb00d4c385e259160e) (Junius Gunaratne)

### PageControl

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Example: fix vertical scrolling behaviour.](https://github.com/material-components/material-components-ios/commit/317fffcf52eb0df2e806021c97300df3334c406b) (randallli)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Fixed sizeForNumberOfPages: was not using passed in argument](https://github.com/material-components/material-components-ios/commit/b78ffc5b68d59b16699ee13dc71b70ec34aa8c12) (randallli)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/8416f8e540e32594163ce2d6b55930f8260ad891) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)

### RobotoFontLoader

* [Add description and set Roboto vs. System as main demo](https://github.com/material-components/material-components-ios/commit/a89f9ab5aba640f0d7a2b4ea5573e9c409fe1564) (Junius Gunaratne)
* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[RobotoFontLoader, FontDiskLoader, Typography] Readme: Added some missing sections and edits.](https://github.com/material-components/material-components-ios/commit/2fe58210bb9dc57f1a5ad1f09587b3b678aab8b1) (randallli)
* [[Roboto] Added simple example](https://github.com/material-components/material-components-ios/commit/489d4355ae5cfb241c261685b397e9ca88260d41) (randallli)
* [[Roboto] created a roboto vs system font example](https://github.com/material-components/material-components-ios/commit/25760fc24083bce068f7fe5d489847fafcfdf6ce) (randallli)
* [[Typogarphy] Set font loader example](https://github.com/material-components/material-components-ios/commit/6f4f2dff211683b1940ed5b782032494e7833dbd) (randallli)
* [[Typography]! Finished splitting out RobotoFontLoader and FontDiskLoader from Typography](https://github.com/material-components/material-components-ios/commit/cbbcb7271cfacb827bd05249760df529a36d1bed) (randallli)

### ScrollViewDelegateMultiplexer

* [Deprecate ScrollViewDelegateMultiplexer.](https://github.com/material-components/material-components-ios/commit/cf08f8319fe62b006f852d9ae97468232a202365) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[PageControl] Example: fix vertical scrolling behaviour.](https://github.com/material-components/material-components-ios/commit/317fffcf52eb0df2e806021c97300df3334c406b) (randallli)

### ShadowElevations

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/8416f8e540e32594163ce2d6b55930f8260ad891) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)

### ShadowLayer

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[Catalog] Update shadow layer demo color](https://github.com/material-components/material-components-ios/commit/f63da172336b7293cf82b62a1f6a8084a0780057) (Junius Gunaratne)

### Slider

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[Catalog] Improve slider demo, move layout code into supplemental files](https://github.com/material-components/material-components-ios/commit/7cc87bd6d90ed2c641212339f00f67b08fb76314) (Junius Gunaratne)
* [[ThumbTrack] Re-enable Ink](https://github.com/material-components/material-components-ios/commit/5fa91b67cd3bb8e1c0d91fd44b96acd3a0e9f7e8) (Ian Gordon)

### SpritedAnimationView

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/8416f8e540e32594163ce2d6b55930f8260ad891) (Jeff Verkoeyen)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)

### Switch

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[ThumbTrack] Re-enable Ink](https://github.com/material-components/material-components-ios/commit/5fa91b67cd3bb8e1c0d91fd44b96acd3a0e9f7e8) (Ian Gordon)
* [[Typogarphy] Set font loader example](https://github.com/material-components/material-components-ios/commit/6f4f2dff211683b1940ed5b782032494e7833dbd) (randallli)

### Typography

* [Added import sections for each component.](https://github.com/material-components/material-components-ios/commit/2acbf968a59c8db39e86e8d4d9dab303075b1bd0) (Adrian Secord)
* [Addressing linter warnings.](https://github.com/material-components/material-components-ios/commit/06c44a0e47a0a7fa38efc1f953cdb7e3c33e08e2) (Jeff Verkoeyen)
* [Fix .jazzy.yaml objc configuration and regenerate all jazzy yamls.](https://github.com/material-components/material-components-ios/commit/ca70b442a5f4e68f32c90644724a159161e48d6e) (Jeff Verkoeyen)
* [Ran arc lint --everything --apply-patches.](https://github.com/material-components/material-components-ios/commit/8416f8e540e32594163ce2d6b55930f8260ad891) (Jeff Verkoeyen)
* [[Bug Fix] Correct all api reference links in markdowns](https://github.com/material-components/material-components-ios/commit/40fb585bb48d27cd9a4ae1cfceb303b9f16845b0) (Yiran Mao)
* [[Catalog] Demo selection screen updated with description and primary demo](https://github.com/material-components/material-components-ios/commit/0411613c71083be6288a8a73ee9168ec8702552d) (Junius Gunaratne)
* [[Catalog] Fix description text for Swift](https://github.com/material-components/material-components-ios/commit/91dcb1fd37a2245f4302d00efa27d1d108925638) (Junius Gunaratne)
* [[Catalog] Fixed TypographySystemFontLoader example because it need to import MaterialRobotoFontLoader](https://github.com/material-components/material-components-ios/commit/3f8f7e61a951a9aa1f16f6dae7c07c315624203b) (randallli)
* [[RobotoFontLoader, FontDiskLoader, Typography] Readme: Added some missing sections and edits.](https://github.com/material-components/material-components-ios/commit/2fe58210bb9dc57f1a5ad1f09587b3b678aab8b1) (randallli)
* [[Roboto] created a roboto vs system font example](https://github.com/material-components/material-components-ios/commit/25760fc24083bce068f7fe5d489847fafcfdf6ce) (randallli)
* [[Typogarphy] Set font loader example](https://github.com/material-components/material-components-ios/commit/6f4f2dff211683b1940ed5b782032494e7833dbd) (randallli)
* [[Typography]! Finished splitting out RobotoFontLoader and FontDiskLoader from Typography](https://github.com/material-components/material-components-ios/commit/cbbcb7271cfacb827bd05249760df529a36d1bed) (randallli)
* [fix readme screenshot](https://github.com/material-components/material-components-ios/commit/ff70ccc8ba995221474aa81d9d0f83382902fb81) (randallli)
* [fixed import order](https://github.com/material-components/material-components-ios/commit/60b3d6203badb4f6e9fd096a57a304141f99a9e1) (randallli)
* [fixed links in readme](https://github.com/material-components/material-components-ios/commit/0e390b59a397b9ec92cfc42acbde7c08cb7ac0a6) (randallli)

# 3.1.0

## API diffs

Auto-generated by running:

    scripts/api_diff -o ddb35150fe10c2974b63d1e29c4ecce4ccaa51fb -n ad904b8748ce469af886b2f27172d8e3c44928e8

### AppBar

- [new] [`-[MDCAppBar addSubviewsToParent]`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L36)
- [new] [`MDCAppBar.headerStackView`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L47)
- [new] [`MDCAppBar.headerViewController`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L39)
- [new] [`MDCAppBar.navigationBar`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L42)
- [new] [`MDCAppBarContainerViewController.appBar`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBarContainerViewController.h#L58)
- [new] [`MDCAppBar`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L30)
- [deprecated] [`-[MDCAppBarContainerViewController headerViewController]`](https://github.com/material-components/material-components-ios/blob/ddb35150fe10c2974b63d1e29c4ecce4ccaa51fb/components/AppBar/src/MDCAppBarContainerViewController.h#L57)
*Use appBar.headerViewController instead.*
- [deprecated] [`MDCAppBarAddViews()`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L101).
*Please create an instance of MDCAppBar instead.*
- [deprecated] [`MDCAppBarParenting.headerStackView`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L74).
*Please create an instance of MDCAppBar instead.*
- [deprecated] [`MDCAppBarParenting.headerViewController`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L82).
*Please create an instance of MDCAppBar instead.*
- [deprecated] [`MDCAppBarParenting.navigationBar`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L78).
*Please create an instance of MDCAppBar instead.*
- [deprecated] [`MDCAppBarParenting`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L69).
*Please create an instance of MDCAppBar instead.*
- [deprecated] [`MDCAppBarPrepareParent()`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/AppBar/src/MDCAppBar.h#L93).
*Please create an instance of MDCAppBar instead.*

### ButtonBar

- [new] [`-[MDCButtonBar sizeThatFits:]`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/ButtonBar/src/MDCButtonBar.h#L96)

### Buttons

- [new] [`-[MDCButton setBackgroundColor:]`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/Buttons/src/MDCButton.h#L54)

### FlexibleHeader

- [new] [`-[MDCFlexibleHeaderView shiftHeaderOffScreenAnimated:]`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L153)
- [new] [`MDCFlexibleHeaderView.shiftBehavior`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L279)
- [deprecated] [`MDCFlexibleHeaderView.behavior`](https://github.com/material-components/material-components-ios/blob/ddb35150fe10c2974b63d1e29c4ecce4ccaa51fb/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L283)
*Use shiftBehavior instead.*
- [deprecated] [`MDCFlexibleHeaderView.contentView`](https://github.com/material-components/material-components-ios/blob/ddb35150fe10c2974b63d1e29c4ecce4ccaa51fb/components/FlexibleHeader/src/MDCFlexibleHeaderView.h#L97)
*Please register views directly to the flexible header.*

### RobotoFontLoader

- [new] [`-[MDCRobotoFontLoader init]`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/RobotoFontLoader/src/MDCRobotoFontLoader.h#L35)

### Typography

- [new] [`+[MDCTypography fontLoader]`](https://github.com/material-components/material-components-ios/blob/ad904b8748ce469af886b2f27172d8e3c44928e8/components/Typography/src/MDCTypography.h#L56)

## Component changes

### AppBar

* [Add container tests.](https://github.com/material-components/material-components-ios/commit/f87efd019a0760e67fbe73b7cf4cf6806c0e5dec) (Jeff Verkoeyen)
* [Add parenting tests.](https://github.com/material-components/material-components-ios/commit/4820321787267e262abaa7b26ff8e61849d6bd15) (Jeff Verkoeyen)
* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)
* [Expose MDCAppBar APIs in the container view controller.](https://github.com/material-components/material-components-ios/commit/21d4ea8a0d7ad288860919b16d1dcab45f38dfab) (Jeff Verkoeyen)
* [MDCAppBarContainerViewController now observes the content view controller's navigationItem.](https://github.com/material-components/material-components-ios/commit/3a39cb0811115f45cca6316c572af1ba01870fa0) (Jeff Verkoeyen)
* [Remove unnecessary logic in setContentViewController:](https://github.com/material-components/material-components-ios/commit/e0aca65b97c0eda55adcba7b9faed59beb77fc2c) (Jeff Verkoeyen)
* [Simplify creation/registration mechanisms.](https://github.com/material-components/material-components-ios/commit/adcc69b0eeb835a58e383359c66b805e92577cc4) (Jeff Verkoeyen)
* [[Catalog] Change nav to use top AppBar instead of bottom CatalogBar](https://github.com/material-components/material-components-ios/commit/692287aee468245446e059fe9401937127f88b81) (Junius Gunaratne)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)
* [[FlexibleHeader] Deprecate the contentView API.](https://github.com/material-components/material-components-ios/commit/627e238850c6f89d944e40285542a3748b8a4a3f) (Jeff Verkoeyen)
* [[FlexibleHeader] Flesh out the README.md.](https://github.com/material-components/material-components-ios/commit/794cbc964c6d87c9838ad07883d4478031a4173f) (Jeff Verkoeyen)

### ButtonBar

* [Add essential README content.](https://github.com/material-components/material-components-ios/commit/56142f28418dfd42d9e58c182b62acc05cf82508) (Jeff Verkoeyen)
* [Add typical use example.](https://github.com/material-components/material-components-ios/commit/3ae43a1567c73d1fa2cf47f2598cdf9c74ac6c0f) (Jeff Verkoeyen)
* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)
* [Document sizeThatFits: behavior.](https://github.com/material-components/material-components-ios/commit/f086f125a5e957a06727261c46ade108cce0ba78) (Jeff Verkoeyen)
* [First pass at resolving swiftlint warnings.](https://github.com/material-components/material-components-ios/commit/4b435d3e9ef542937152bc8976311e274601b7bf) (Jeff Verkoeyen)
* [Minor documentation touchups in examples.](https://github.com/material-components/material-components-ios/commit/3b8b1f94ab92462812a027b6219c4ad7fcc055f1) (Jeff Verkoeyen)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### Buttons

* [Ran `arc lint --everything --apply-patches`](https://github.com/material-components/material-components-ios/commit/18434799b306c31f61f1f858b1f3d392d7e209dc) (Jeff Verkoeyen)
* [[Button demos] Add disabled button states to demos, change storyboard bg color](https://github.com/material-components/material-components-ios/commit/36ba8b0197604f03d5c1b0adcc648618811c54f7) (Junius Gunaratne)
* [[Button] Marking setBackgroundColor __deprecated in preperation for NS_UNAVAILABLE](https://github.com/material-components/material-components-ios/commit/c99b5d0014eee336949165b473b6202eb0e8eea6) (randallli)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### FlexibleHeader

* [Add missing header imports.](https://github.com/material-components/material-components-ios/commit/8236e1aa16a40e53adfb56475f20973ec807987e) (Jeff Verkoeyen)
* [Add scroll view did scroll tests.](https://github.com/material-components/material-components-ios/commit/c70aabb96c11445c313c455ec39fc9f0d55a26fd) (Jeff Verkoeyen)
* [Added nav bar example and small fix to flexible header examples.](https://github.com/material-components/material-components-ios/commit/b0312ed1adec0b4a278236f7a161d44974671498) (Will Larche)
* [Barebones Flexible Header: New styling and content](https://github.com/material-components/material-components-ios/commit/958b94fcef5fbc57aca795b0ee4a6de8dd252eb5) (Will Larche)
* [Deprecate the contentView API.](https://github.com/material-components/material-components-ios/commit/627e238850c6f89d944e40285542a3748b8a4a3f) (Jeff Verkoeyen)
* [Document when to implement childViewControllerForStatusBarHidden.](https://github.com/material-components/material-components-ios/commit/78cdc1364d41d842123d3b6b9c30f52dcebbe920) (Jeff Verkoeyen)
* [Ensure that the header is always front-most when being a child of the trackingScrollView.](https://github.com/material-components/material-components-ios/commit/275e881333bcf1c752a6629b0d3b309e65ace9bc) (Jeff Verkoeyen)
* [Flesh out the README.md.](https://github.com/material-components/material-components-ios/commit/794cbc964c6d87c9838ad07883d4478031a4173f) (Jeff Verkoeyen)
* [Functionality to hide header](https://github.com/material-components/material-components-ios/commit/91e6468fe80a5113936a5d08b46e4d46e5d364a0) (keefertaylor)
* [Ran `arc lint --everything --apply-patches`](https://github.com/material-components/material-components-ios/commit/18434799b306c31f61f1f858b1f3d392d7e209dc) (Jeff Verkoeyen)
* [Remove unnecessary lines from the tests.](https://github.com/material-components/material-components-ios/commit/873865a8027cc38f2201aa0f5cf6e98d3667863b) (Jeff Verkoeyen)
* [Rename behavior to shiftBehavior.](https://github.com/material-components/material-components-ios/commit/d23456c3d734955cb75cf27143466153b2dd1b3c) (Jeff Verkoeyen)
* [The New Configurator (Flexible Header View Example)](https://github.com/material-components/material-components-ios/commit/d3c3389ba032a5792a74d923454268357dc562a4) (Will Larche)
* [Turning off clang format for a portion of code.](https://github.com/material-components/material-components-ios/commit/491bfb57faedf7d98634353adfca48e731548b96) (Will Larche)
* [[Catalog] Change nav to use top AppBar instead of bottom CatalogBar](https://github.com/material-components/material-components-ios/commit/692287aee468245446e059fe9401937127f88b81) (Junius Gunaratne)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### HeaderStackView

* [Fleshing out the README.md.](https://github.com/material-components/material-components-ios/commit/be002a2f9f6ca099e3b764abd9d68e8abb584991) (Jeff Verkoeyen)
* [Ran `arc lint --everything --apply-patches`](https://github.com/material-components/material-components-ios/commit/18434799b306c31f61f1f858b1f3d392d7e209dc) (Jeff Verkoeyen)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### Ink

* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### NavigationBar

* [Add overview section to the README.md.](https://github.com/material-components/material-components-ios/commit/9794b46731cde62bce33e2d54669a657e151e4d9) (Jeff Verkoeyen)
* [Added intrinsicContentSize support.](https://github.com/material-components/material-components-ios/commit/c5cf080b3e2fc5cfd40357901d39f3ea3db04beb) (Will Larche)
* [Added nav bar example and small fix to flexible header examples.](https://github.com/material-components/material-components-ios/commit/b0312ed1adec0b4a278236f7a161d44974671498) (Will Larche)
* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)

### PageControl

* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)
* [Ran `arc lint --everything --apply-patches`](https://github.com/material-components/material-components-ios/commit/18434799b306c31f61f1f858b1f3d392d7e209dc) (Jeff Verkoeyen)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)
* [[Catalog] Use blue design colors for page control demo](https://github.com/material-components/material-components-ios/commit/9c6a523430843749590610e556db9e3cfd701340) (Junius Gunaratne)

### RobotoFontLoader

* [Created Roboto Font Loader readme file.](https://github.com/material-components/material-components-ios/commit/5c78d68e0822f4cb81c190c5c33b6f1dfd30a760) (randallli)
* [Deprecating init in preperation for marking it NS_UNAVAILABLE](https://github.com/material-components/material-components-ios/commit/60ef07c1af90c6cc38e9427aecb9bddb27b2896a) (randallli)
* [[Typography] Fixed warnings in unit tests](https://github.com/material-components/material-components-ios/commit/3735825360b97415499d529fdea092bab050abe9) (randallli)

### ScrollViewDelegateMultiplexer

* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### ShadowElevations

* [Add shadow elevations demo to catalog](https://github.com/material-components/material-components-ios/commit/f4f89c2145b18df34a81a9f91944e3618c29120e) (Junius Gunaratne)
* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)

### ShadowLayer

* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)
* [Ran `arc lint --everything --apply-patches`](https://github.com/material-components/material-components-ios/commit/18434799b306c31f61f1f858b1f3d392d7e209dc) (Jeff Verkoeyen)
* [Removed vestigial duration in elevation-setting methods.](https://github.com/material-components/material-components-ios/commit/cc64a2cf6ecd54e18471c28a1ae078e6b8e06487) (Adrian Secord)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### Slider

* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)
* [Ran `arc lint --everything --apply-patches`](https://github.com/material-components/material-components-ios/commit/18434799b306c31f61f1f858b1f3d392d7e209dc) (Jeff Verkoeyen)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### SpritedAnimationView

* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### Switch

* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)
* [Ran `arc lint --everything --apply-patches`](https://github.com/material-components/material-components-ios/commit/18434799b306c31f61f1f858b1f3d392d7e209dc) (Jeff Verkoeyen)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

### Typography

* [Adjusted readme.md and custom fonts section.](https://github.com/material-components/material-components-ios/commit/8054ada89ed06227a58d7e0197e63c0cc0b13225) (randallli)
* [Changed "$ pod" strings in documentation files.](https://github.com/material-components/material-components-ios/commit/7cf9f64caeadea1b310864133a2dbcbfad297848) (Adrian Secord)
* [Fixed warnings in unit tests](https://github.com/material-components/material-components-ios/commit/3735825360b97415499d529fdea092bab050abe9) (randallli)
* [Public promotion of fontLoader getter](https://github.com/material-components/material-components-ios/commit/b278e131f978aecb54db314e398c106a4e680985) (randallli)
* [Ran `arc lint --everything --apply-patches`](https://github.com/material-components/material-components-ios/commit/18434799b306c31f61f1f858b1f3d392d7e209dc) (Jeff Verkoeyen)
* [Suppress unit test warning](https://github.com/material-components/material-components-ios/commit/02e085ed42cff940b9121b68b458749f8ff2c769) (randallli)
* [[Catalog] Add typography styles demo to catalog](https://github.com/material-components/material-components-ios/commit/420b1ef7edc7764a08d0e19607b3f8ce3a3afac9) (Junius Gunaratne)
* [[Catalog] Rename catalogHierarchy to catalogBreadcrumbs.](https://github.com/material-components/material-components-ios/commit/61a895c5b18f538df45fa4c762220d0357b3d37a) (Jeff Verkoeyen)

## 3.0.0

##### Breaking

* [FlexibleHeader] contentView is now nonnull and readonly. (Jeff Verkoeyen)
    * Swift code will need to change `contentView!` to `contentView`. This will be made apparent at build time.


##### Enhancements

* [ButtonBar] Rename buttonItems API to items. (Jeff Verkoeyen)
* [ButtonBar] Add Buttons dependency and remove Buttons dependency from AppBar. (Jeff Verkoeyen)
* [Site] Adding excerpts to component docs metadata. (Jason Striegel)
* [RobotoFontLoader] Removed #define that should not have made it public. (randallli)
* [Demos] Fix compilation errors for Xcode 7.2 (Junius Gunaratne)
* [Cleanup] Replaced [Foo new] with [[Foo alloc] init], per the style guide. (Adrian Secord)
* [checks] Add missing_readme check and check_all runner. (Jeff Verkoeyen)
* [ButtonBar] Deprecating all ButtonBar delegate-related APIs. (Jeff Verkoeyen)
* [AppBar] Don't set the bar buttons' title color. (Jeff Verkoeyen)
* [Ink] Update demo so ink is not obstructed by adjacent views (Junius Gunaratne)
* [Switch] Rename commonInit to avoid name collisions (Ian Gordon)
* [Slider] Rename commonInit to avoid name collisions (Ian Gordon)
* [Site] Including component README screenshots. (Jason Striegel)
* [Ink] Use custom ink center property in ink implementation (Junius Gunaratne)
* [AppBar] Implement the App Bar container's header view setter. (Jeff Verkoeyen)
* [Shrine] Add launch screen (Junius Gunaratne)
* [Catalog] Fix build breakage. (Jeff Verkoeyen)
* [Documentation] Initial draft of the Material Components Getting Started guide (Alastair Tse)
* [Documentation] Adding component screenshots from catalog for website (Junius Gunaratne)
* [Site] Created ROADMAP.md (Katy Kasmai)
* [AppBar] Add README section on interacting with background views. (Jeff Verkoeyen)
* [Catalog] Add exit bar for demos (Junius Gunaratne)
* [Shrine] Fix compiler errors (Junius Gunaratne)
* [AppBar|FlexibleHeader] Add section on touch forwarding. (Jeff Verkoeyen)
* [FlexibleHeader] Clarify that touch forwarding does not apply to subviews. (Jeff Verkoeyen)
* [AppBar] Call out the content view in the view hierarchy. (Jeff Verkoeyen)
* [NavigationBar] Add nullability annotations. (Jeff Verkoeyen)
* [Documentation] Fixed pod install instructions for Buttons/README.md. (Adrian Secord)
* [AppBar] Remove excess horizontal rules. (Jeff Verkoeyen)
* [AppBar|FlexibleHeader] Move UINav section from App Bar to Flexible Header. (Jeff Verkoeyen)
* [AppBar|FlexibleHeader] Move section on status bar style from App Bar to Flexible Header. (Jeff Verkoeyen)
* [NavigationBar] Document that the navigationBar's state syncs with navigationItem on observation. (Jeff Verkoeyen)
* [NavigationBar] Rename MDCUINavigationItemKVO to MDCUINavigationItemObservables. (Jeff Verkoeyen)
* [AppBar|NavigationBar] Minor typos in navigation item section title. (Jeff Verkoeyen)
* [CONTRIBUTING] Fix typo. (Jeff Verkoeyen)
* [CONTRIBUTING] Cleaning up the checklist. (Jeff Verkoeyen)
* [AppBar] No longer need to unwrap contentView in the imagery example. (Jeff Verkoeyen)
* [Animated Menu Button] Double/float correction. (Will Larche)
* [Demos] Pesto detail presentation and dismissal. (Will Larche)
* [AppBar|NavigationBar] Added section on observing UINavigationItem. (Jeff Verkoeyen)
* [AppBar] Minor grammatical rearrangements in README. (Jeff Verkoeyen)
* [FlexibleHeader] Explain what the imagery usage example section is. (Jeff Verkoeyen)
* [NavigationBar] Adding more specific documentation. (Jeff Verkoeyen)
* [Docs] Cleanup pass for Markdown style (100 chars). (Adrian Secord)
* [Sample] Pesto: Marking target 'Requires Full Screen' (Will Larche)
* [community] Change Stack Overflow tag to 'material-components-ios'. (Jeff Verkoeyen)
* [AppBar] Replace iOS 9 APIs with older APIs. (Jeff Verkoeyen)
* [AppBar] Add imagery example. (Jeff Verkoeyen)
* [Demos] Pesto: Adding AppBar to Settings (Will Larche)
* [Typography] Corrections to markdown in readme.md (Will Larche)
* [Typography ReadMe] First pass at updated content (Will Larche)
* [Site] Add option hint to build-site.sh (Yiran Mao)
* [Testing] Naming consistency for unit tests. (Jeff Verkoeyen)
* [Other] Remove old @ingroup document annotations. (Adrian Secord)
* [ThumbTrack] Add Ink as a dependency (Ian Gordon)
* [MDCButton] Documentation updates (Ian Gordon)
* [Site] Update code snippet markdown h3 to h4 and corresponding css styles (Yiran Mao)
* [Testing] Unit test target must be 8.0 in order to build Swift unit tests. (Jeff Verkoeyen)
* [Ink] Changed MDCInkView API to better reflect the modern ink behavior (breaking). (Adrian Secord)
* [Other] Fixes block comments globally. (Adrian Secord)
* [FlexibleHeader] Prefer CGFloat when calculating shadow intensity. (Jeff Verkoeyen)
* [Demos] Adding Font Opacities for all labels in Pesto (Will Larche)
* [FlexibleHeader] Always project the flexible header's frame onto the tracking scroll view. (Jeff Verkoeyen)
* [Catalog] Temporarily bump deployment target to 9.0 (Ian Gordon)
* [MDCButton] Remove Work In Progress annotation (Ian Gordon)
* [FlexibleHeader] Comment the #endif statements. (Jeff Verkoeyen)
* [Typography] Re-added deleted file for deprecated class (randallli)
* [FlexibleHeader] Revert tracking scroll view delegate assertion. (Jeff Verkoeyen)
* [Pesto] Add example of MDCInk in Pesto header (Junius Gunaratne)
* [Typography] Remove /** */ internal comments. (Jeff Verkoeyen)
* [AppBar] Templatize the back button image. (Jeff Verkoeyen)
* [Demos] Add legal copy above source files (Junius Gunaratne)
* [Pesto] Change small header logo to text (Junius Gunaratne)
* [UICollectionViewLayout] Correction for arithmetic (Will Larche)
* [Shrine] Use small text logo on scroll, add did change page event handler (Junius Gunaratne)
* [Site] Switch markdown formatting. (Jason Striegel)
* [Site] Slider markdown formatting. (Jason Striegel)
* [Site] ShadowLayer editing intro and markdown formatting. (Jason Striegel)
* [Icons] MDCIcons+BundleLoader.h must be a protected header. (Jeff Verkoeyen)
* [Demos] Pesto: Minor issues in style and safety (Will Larche)
* [Site] ShadowElevations markdown formatting. (Jason Striegel)
* [Site] Bash example consistency pass. (Jason Striegel)
* [Icons] Base source needs its own explicit target. (Jeff Verkoeyen)
* [Site] PageControl docs formatting, images, and video. (Jason Striegel)
* [Icons] Add missing header search paths in pod specs. (Jeff Verkoeyen)
* [Catalog] Update colors to blue branding color (Junius Gunaratne)
* [AppBar] Provide recommendations for status bar style. (Jeff Verkoeyen)
* [SpritedAnimationView] Remove testAnimationPerformance. (Jeff Verkoeyen)
* [AppBar] Minor typo. (Jeff Verkoeyen)

## 2.2.0

##### Deprecations

* [Typography] Marked FontResource deprecated. Use the renamed component as FontDiskLoader. (randallli)

##### Enhancements

* [AppBar Example] Addressing code style feedback from D326. (Jeff Verkoeyen)
* [AppBar] Add typical Swift usage example. (Jeff Verkoeyen)
* [AppBar] Add UINavigatonItem section. (Jeff Verkoeyen)
* [AppBar] readme updates. (Jeff Verkoeyen)
* [AppBar] Remove unnecessary code from the ObjC example. (Jeff Verkoeyen)
* [AppBar] Standardize and document the examples in preparation for upcoming examples. (Jeff Verkoeyen)
* [AppBar] Use the catalog's blue color in the examples. (Jeff Verkoeyen)
* [Button] Change ink color on buttons to improve visibility of ink (Junius Gunaratne)
* [Catalog] Miscellaneous cleanup and fixes to the Catalog. (Jeff Verkoeyen)
* [Catalog] Update catalog home screen to new light themed design (Junius Gunaratne)
* [Docs] Navigationbar initial markdown formatting. (Jason Striegel)
* [FlexibleHeader] Assert that the tracking scroll view has a delegate. (Jeff Verkoeyen)
* [FlexibleHeader] Only call sizeToFit on the flexible header view when it does not have a tracking scroll view. (Jeff Verkoeyen)
* [FlexibleHeader] Poke the header into laying out its content when the view controller has been fully registered. (Jeff Verkoeyen)
* [FontDiskLoader] Revived old class, MDCFontResource, and marked it deprecated. (randallli)
* [Icons] Add private/ directory to Icons target. (Jeff Verkoeyen)
* [Icons] Added component (Jeff Verkoeyen)
* [Icons] Bundles can't have plusses in their names. (Jeff Verkoeyen)
* [Ink] markdown formatting. (Jason Striegel)
* [Ink] Minor tweaks to ink for more consistency with other platforms (Junius Gunaratne)
* [Site] Remove alternate remotes from build-site remote determination. (Jeff Verkoeyen)
* [Site] Updates to top links and markdown formatting. (Jason Striegel)
* [Site] Using HTML markup for lists to avoid github comment issue. (Jason Striegel)
* [Typography] Moved the FontLoader and FontResource into their own components. (randallli)

## 2.1.1

##### Enhancements

###### Code
* [AppBar] Add App Bar builder API. (Jeff Verkoeyen)
* [AppBar] Fix compiler warnings about formatting NSIntegers. (Adrian Secord)
* [FlexibleHeader] MDCFlexibleHeaderViewController conforms to UITableViewDelegate. (Jeff Verkoeyen)
* [Ink] Updated the ink example to include smaller shapes. (Adrian Secord)
* [Ink] Visual adjustments to ink ripple (Junius Gunaratne)
* [NavigationBar] Add back button icon. (Jeff Verkoeyen)

###### Examples
* [Demos] Updates to header behavior and minor layout changes after UX review (Junius Gunaratne)
* [Pesto] Adding 'nonatomic' attribute to all delegates (Will Larche)
* [Pesto] Corrections for build warnings (Will Larche)
* [Pesto] making string and URL propertys 'copy' (Will Larche)
* [Pesto] Style update: @property ivars (larche)
* [Pesto] Update card zoom animation to be more Material Design like (Junius Gunaratne)

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
* [Site] Replacing lorem with description content, where possible. (Jason Striegel)
* [Site] Update component landing page's nav list (Yiran Mao)

## 2.1.0

##### Enhancements

* [AppBar] Introducing the App Bar component. (Jeff Verkoeyen)
* [Arcanist] Adds scripts/install_arc.sh, which installs or updates arc and our project-specific
  dependencies. (Adrian Secord)
* [Arcanist] Updated Arcanist config to use submodules. (Adrian Secord)
* [ButtonBar] Add ButtonBar component. (Jeff Verkoeyen)
* [ButtonBar] Add ButtonBar readme. (Jeff Verkoeyen)
* [Buttons] Add Flatbutton commonInit (Ian Gordon)
* [Buttons] Add storyboard sample (Ian Gordon)
* [Buttons] Clean up API documentation style. (Jeff Verkoeyen)
* [Catalog] Adds localizable strings to catalog. Allows changing language in scheme for debugging.
  Closes #166. (Chris Cox)
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
  convention. Issue [#130](https://github.com/material-components/material-components-ios/issues/130) filed by
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
* [MDCSlider] Fixed to [issue](https://github.com/material-components/material-components-ios/issues/128) that
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
[#xxx](github.com/material-components/material-components-ios/issues/xxx)
