### Action Theming

Actions in MDCAlertController have emphasis which affects their theming.
High emphasis actions generate contained buttons, medium emphasis actions generate outlined buttons and low emphasis actions generate text buttons.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/dialogButtons.png" alt="An alert presented with a title, body, high-emphasis 'OK' button and low-emphasis 'Cancel' button." width="320">
</div>

Make sure the Dialog Theming extension is added to your project:

```bash
pod 'MaterialComponents/Dialogs+Theming'
```

The MDCContainerScheme defines design parameters that you can use to theme your dialogs.  The scheme is designed to be instanciated and customized once and be reused by many components.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
  // Create or reuse a Container scheme
  let scheme = MDCContainerScheme()

  // Create an Alert dialog
  let alert = MDCAlertController(title: "Button Theming",
                                 message: "Lorem ipsum dolor sit amet, sit consectetur adipiscing")

  // Add actions with emphases that will generate buttons with the desired appearance. 

  // An example of a high emphasis action (and button appearance):
  alert.addAction(MDCAlertAction(title:"All Right", emphasis: .high, handler: handler))

  // An example for a medium exmphasis:
  alert.addAction(MDCAlertAction(title:"Not Now", emphasis: .medium, handler: handler))

  // Low exmphasis:
  alert.addAction(MDCAlertAction(title:"Later", emphasis: .low, handler: handler))

  // Make sure to spply theming after all actions are added, so they are themed too!
  alert.applyTheme(withScheme: scheme)

  // present the alert
  present(alertController, animated:true, completion:nil)
```

#### Objective-C

```objc
  // Create or reuse a Container scheme
  MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];

  // Create an Alert dialog
  MDCAlertController *alert = 
      [MDCAlertController alertControllerWithTitle:@"Button Theming" 
                    message:@"Lorem ipsum dolor sit amet, sit consectetur adipiscing"];

  // Add actions with different emphasis, creating buttons with different themes.
  MDCAlertAction *primaryAction = [MDCAlertAction actionWithTitle:@"All Right"
                                                          emphasis:MDCActionEmphasisHigh
                                                           handler:handler];
  [alert addAction:primaryAction];

  MDCAlertAction *cancelAction = [MDCAlertAction actionWithTitle:@"Not Now"
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:handler];
  [alert addAction:cancelAction];

  // Make sure to call the themer after all actions are added, so they are themed too!
  [alert applyThemeWithScheme:scheme];

  // present the alert
  [self presentViewController:alert animated:YES completion:...];
```
<!--</div>-->