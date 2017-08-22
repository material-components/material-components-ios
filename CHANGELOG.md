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

[Tab component with MDCTabBar (#1164)](https://github.com/material-components/material-components-ios/tree/develop/components/Tabs) is an implementation of the [Material tabs](https://material.io/guidelines/components/tabs.html) used to explore and switch between different views. Try tabs out! (Brian Moore with Will Larche)

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

The behavior of MDCSnackbar has been changed to better match [the spec](https://material.io/guidelines/components/snackbars-toasts.html#snackbars-toasts-specs):
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
