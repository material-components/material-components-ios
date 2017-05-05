---
title: "Material Components for iOS"
layout: "homepage"
path: /
---

{% contentfor benefits %}
<ul class="benefits-list">
  <li class="benefits-list-item">
    <h3>Pixel-perfect &amp; up to date</h3>
    <p>Implement <a href="https://material.io/guidelines">Material Design</a> with pixel-perfect components, maintained by Google engineers and designers</p>
  </li>
  <li class="benefits-list-item">
    <h3>Flexible development</h3>
    <p>Develop apps using components that support iOS technologies like Swift, Objective-C, and storyboards</p>
  </li>
  <li class="benefits-list-item">
    <h3>Industry standards</h3>
    <p>Take advantage of the same components used in Google’s iOS apps, which meet industry standards for internationalization and accessibility</p>
  </li>
</ul>
{% endcontentfor %}

# Getting Started

An easy way to create beautiful apps with modular and customizable UI&nbsp;components.

1.  {: .step-list-item } ### Install CocoaPods

    [CocoaPods](https://cocoapods.org/) is the easiest way to get started.
    If you're new to CocoaPods, check out their
    [getting started documentation](https://guides.cocoapods.org/using/getting-started.html).

    To install CocoaPods, run the following commands:

    ``` bash
    sudo gem install cocoapods
    ```


2.  {: .step-list-item } ### Create Podfile

    Once you've created an iOS application in Xcode you can start using
    Material Components for iOS.

    To initialize CocoaPods in your project, run the following commands:

    ``` bash
    cd your-project-directory
    pod init
    ```

3.  {: .step-list-item } ### Edit Podfile

    Once you've initialized CocoaPods, add the
    [Material Components for iOS Pod](https://cocoapods.org/pods/MaterialComponentsIOS)
    to your target in your Podfile:


    ``` ruby
    target "MyApp" do
      ...
      pod 'MaterialComponents'
    end
    ```

    If you are using Swift, don’t forget to uncomment the `use_frameworks!` line
    at the top of your Podfile.

    Then run the command:

    ``` bash
    pod install
    open your-project.xcworkspace
    ```

    Now you're ready to get started in Xcode.

4.  {: .step-list-item } ### Usage

    Now you’re ready to add a component (e.g. Buttons) to your app!
    Include the Material Components header for the component you're interested
    in to your app (detailed below) to get all of the required classes.

    Choose from Objective-C or Swift:

    <!--<div class="material-code-render" markdown="1">-->
    #### Objective-C

    ``` objc
    #import "MaterialButtons.h"

    @implementation ViewController

    - (void)viewDidLoad {
      [super viewDidLoad];

      MDCRaisedButton *raisedButton = [MDCRaisedButton new];
      [raisedButton setTitle:@"Raised Button" forState:UIControlStateNormal];
      [raisedButton sizeToFit];
      [raisedButton addTarget:self
                       action:@selector(tapped:)
             forControlEvents:UIControlEventTouchUpInside];

      [self.view addSubview:raisedButton];
    }

    - (void)tapped:(id)sender {
      NSLog(@"Button was tapped!");
    }

    @end
    ```

    #### Swift

    ``` swift
    import MaterialComponents.MaterialButtons

    class MDCBuildTestViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            let raiseButton = MDCRaisedButton.init();
            raiseButton.setTitle("Raised Button", forState: .Normal);
            raiseButton.sizeToFit();
            raiseButton.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside);
            self.view.addSubview(raiseButton);
        }

        func tapped(sender: UIButton!){
            NSLog("Button was tapped!");
        }

    }
    ```
    <!--</div>-->

5.  {: .step-list-item } ### What's next?

    <ul class="icon-list">
      <li class="icon-list-item icon-list-item--guide">
        <a href="../howto">Read the Development Guide</a>
      </li>
      <li class="icon-list-item icon-list-item--components">
        <a href="../components">View the Component Documentation</a>
      </li>
      <li class="icon-list-item icon-list-item--sample">
        <a href="../howto/tutorial/#sample-code">Explore our Code Samples</a>
      </li>
      <li class="icon-list-item icon-list-item--github">
        <a href="https://github.com/material-components/material-components-ios/">View the project on GitHub</a>
      </li>
    </ul>
{: .step-list }
