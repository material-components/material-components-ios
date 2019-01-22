### Typical use: alert

A Material alert presented using Material presentation and transition controllers:

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Present a modal alert
let alertController = MDCAlertController(title: titleString, message: messageString)
let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
alertController.addAction(action)

// Material theming of the alert controller (see full syntax below)
alertController.applyTheme(withScheme: scheme)

present(alertController, animated:true, completion:...)
```

#### Objective-C

```objc
// Present a modal alert
MDCAlertController *alertController =
[MDCAlertController alertControllerWithTitle:titleString
                                     message:messageString];

MDCAlertAction *alertAction =
    [MDCAlertAction actionWithTitle:@"OK"
                            handler:^(MDCAlertAction *action) {
       NSLog(@"OK");
    }];

[alertController addAction:alertAction];

// Material theming of the alert controller (see full syntax below)
[alertController applyThemeWithScheme: scheme];

[self presentViewController:alertController animated:YES completion:...];
```
<!--</div>-->