---
title:  "How To Use Material Components"
layout: landing
section: howto
---

# Using Material Components

Lorem. Introduction to our howtos, guides, and samples. Need to pick the right links to go below
here.

TODO: Copy for above paragraph.

TODO: Choose links below.

- [Development Guide](http://www.google.com)
  <!--{: .icon-guide }-->

- [API Documentation](http://www.google.com)
  <!--{: .icon-api }-->

- [Code Samples](http://www.google.com)
  <!--{: .icon-sample }-->

- [Stack Overflow](http://www.google.com)
  <!--{: .icon-stackoverflow }-->
<!--{: .icon-list }-->

- - -


## Quick Start

1.  ## Install CocoaPods

    [CocoaPods](https://cocoapods.org/) is the easiest way to get started.
    If you're new to CocoaPods, check out their
    [getting started documentation](https://guides.cocoapods.org/using/getting-started.html).

    To install CocoaPods, run the following commands:

    ~~~ bash
    $ sudo gem install cocoapods
    ~~~


2.  ## Create Podfile

    Once you've created an iOS application in Xcode you can start using
    Material Components for iOS.

    To initialize CocoaPods in your project, run the following commands:

    ~~~ bash
    $ cd your-project-directory
    your-project-directory $ pod init
    ~~~

3.  ## Edit Podfile

    Once you've initialized CocoaPods, add the
    [Material Components iOS Pod](https://cocoapods.org/pods/MaterialComponentsIOS)
    to your target in your Podfile:


    ~~~ ruby
    target "MyApp" do
      ...
      pod 'MaterialComponents'
    end
    ~~~

    If you are using Swift, don’t forget to uncomment the use_frameworks! line
    at the top of your Podfile.

    Then run the command:

    ~~~ bash
    your-project-directory $ pod install
    your-project-directory $ open your-project.xcworkspace
    ~~~

    Now you're ready to get started in Xcode.

4.  ## Usage

    Now you’re ready to add a component (e.g. Buttons) to your app!
    Include the Material Components header for the component you're interested
    in to your app (detailed below) to get all of the required classes.

    Choose from Objective-C or Swift:

    <!--<div class="material-code-render" markdown="1">-->
    #### Objective-C

    ~~~ objc
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
    ~~~

    #### Swift

    ~~~swift
    import material_components_ios

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
    ~~~
    <!--</div>-->

5.  ## What's next?

    - [Read the Development Guide](http://www.google.com)
      <!--{: .icon-guide }-->

    - [View the full iOS API](http://www.google.com)
      <!--{: .icon-api }-->

    - [Explore our code samples](http://www.google.com)
      <!--{: .icon-sample }-->
    <!--{: .icon-list }-->
<!--{: .step-sequence }-->




- - -

## Detailed Guides

- [**Lorem Hello World**
  Learn how to create your first app using Material Components for iOS.
  ](/howto/lorem-hello-word/)

- [**Lorem Navigation Basics**
  A brief introduction to structuring your app and navigating between views.
  ](/howto/lorem-navigation-basics/)
<!--{: .icon-list .large-format }-->




- - -

## Sample Code

- [**Pesto**
  A simple recipe app, which incorporates a flexible header, a grid list, cards, and a detail view.
  ](https://www.google.com/)
<!--{: .icon-list .large-format }-->



