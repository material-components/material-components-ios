### Typical use: modal dialog
Your UIViewController presented using Material presentation and transition controllers:

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// The following is called from the presenting view controller and has the
// following variable defined to keep a reference to the transition
// controller.
strong var dialogTransitionController: MDCDialogTransitionController

// To present the dialog myDialogViewController
dialogTransitionController = MDCDialogTransitionController()
myDialogViewController.modalPresentationStyle = .custom
myDialogViewController.transitioningDelegate = dialogTransitionController

// Material theming of presentation controller (see full syntax below)
myDialogViewController.mdc_dialogPresentationController.applyTheme(withScheme: scheme)

present(myDialogViewController, animated: true, completion:...)
```

#### Objective-C

```objc
// self is the presenting view controller which has the following property
// defined to keep a reference to the transition controller.
@property(nonatomic) MDCDialogTransitionController *dialogTransitionController;

// Prepare to present the dialog myDialogViewController
self.dialogTransitionController = [[MDCDialogTransitionController alloc] init];
myDialogViewController.modalPresentationStyle = UIModalPresentationCustom;
myDialogViewController.transitioningDelegate = self.dialogTransitionController;

// Material theming of presentation controller (see full syntax below)
[myDialogViewController.mdc_dialogPresentationController applyThemeWithScheme: scheme];

[self presentViewController:myDialogViewController animated:YES completion:...];

```