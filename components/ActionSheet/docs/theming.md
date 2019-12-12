### Theming

You can theme an MDCActionSheet to match the Material Design style by using a theming extension. The content below assumes you have read the article on [Theming](../../../docs/theming.md).

First, create an action sheet and import the theming extension header for Action Sheets.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialActionSheet
import MaterialComponents.MaterialActionSheet_Theming

let actionSheet = MDCActionSheetController()
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialActionSheet.h>
#import <MaterialComponents/MaterialActionSheet+Theming.h>

MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] init];
```
<!--</div>-->

You can then provide a container scheme instance to any of the MDCActionSheet theming extensions.

Then, you can theme your action sheet.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
actionSheet.applyTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
[self.actionSheet applyThemeWithScheme:self.containerScheme];
```
<!--</div>-->





