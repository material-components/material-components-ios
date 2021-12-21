### Typical use

Create an instance of `MDCActionSheetController` and add actions to it. You can now 
present the action sheet controller.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController(title: "Action Sheet", 
                                           message: "Secondary line text")
let actionOne = MDCActionSheetAction(title: "Home", 
                                     image: UIImage(named: "Home"), 
                                     handler: { print("Home action" })
let actionTwo = MDCActionSheetAction(title: "Email", 
                                     image: UIImage(named: "Email"), 
                                     handler: { print("Email action" })
actionSheet.addAction(actionOne)
actionSheet.addAction(actionTwo)

present(actionSheet, animated: true, completion: nil)
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet =
    [MDCActionSheetController actionSheetControllerWithTitle:@"Action sheet"
                                                     message:@"Secondary line text"];
MDCActionSheetAction *homeAction = 
    [MDCActionSheetAction actionWithTitle:@"Home"
                                    image:[UIImage imageNamed:@"system_icons/home"]
                                  handler:nil];
MDCActionSheetAction *favoriteAction =
    [MDCActionSheetAction actionWithTitle:@"Favorite"
                                    image:[UIImage imageNamed:@"system_icons/favorite"]
                                  handler:nil];
[actionSheet addAction:homeAction];
[actionSheet addAction:favoriteAction];
[self presentViewController:actionSheet animated:YES completion:nil];
```
<!--</div>-->
