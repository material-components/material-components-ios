# Material Components for iOS

Material Components for iOS (MDC-iOS) helps developers execute [Material Design](https://www.material.io). Developed by a core team of engineers and UX designers at Google, these components enable a reliable development workflow to build beautiful and functional iOS apps.

Material Components for iOS are written in Objective-C and support Swift and Interface Builder.

## Useful Links

- [How To Use MDC-iOS](howto/)
- [All Components](components/)
- [Demo Apps](demos/)
- [Contributing](contributing/)
- [MDC-iOS on Stack Overflow](https://www.stackoverflow.com/questions/tagged/material-components+ios) (external site)
- [Material.io](https://www.material.io) (external site)
- [Material Design Guidelines](https://material.google.com) (external site)
  
## Trying out Material Components

Our [catalog](catalog/) showcases Material Components. You can use the `pod try` command from anywhere on your machine to try the components, even if you haven't checked out the repo yet:

~~~ bash
pod try MaterialComponents
~~~

In case you have already checked out the repo, run the following command:

~~~ bash
pod install --project-directory=catalog/
~~~

## Installation

### Getting Started with a New Project

Check out our [tutorial](howto/tutorial) for a step-by-step guide to setting up a new project using Material Components.

### Adding Material Components to an Existing Project

[CocoaPods](https://cocoapods.org/) is the easiest way to get started (if you're new to CocoaPods,
check out their [getting started documentation](https://guides.cocoapods.org/using/getting-started.html).)

To install CocoaPods, run the following commands:

~~~ bash
sudo gem install cocoapods
~~~

To integrate Material Components in your existing application, first create a new Podfile:

~~~ bash
cd your-project-directory
pod init
~~~

Next, add the
[Material Components for iOS pod](https://cocoapods.org/pods/MaterialComponentsIOS)
to your target in your Podfile:

~~~ ruby
target "MyApp" do
  ...
  # Until Material Components for iOS is public:
  pod 'MaterialComponents', :git => 'https://github.com/material-components/material-components-ios.git'

  # After Material Components for iOS is public:
  # pod 'MaterialComponents'
end
~~~

If you are using Swift, don’t forget to uncomment the `use_frameworks!` line
at the top of your Podfile.

Then run the command:

~~~ bash
pod install
~~~

Now you're ready to get started in Xcode. Don't forget to open the workspace Cocoapods created for you instead of the original project:

~~~ bash
open your-project.xcworkspace
~~~

### Usage

The components are built upon familiar UIKit classes and can be added to a view with just a couple of lines. Simply import the Material Components header for the component you're interested in, and add it to your view.

#### Swift

~~~ swift
import MaterialComponents.MaterialButtons

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let raiseButton = MDCRaisedButton.init();
        raiseButton.setTitle("Raised Button", forState: .Normal);
        raiseButton.sizeToFit();
        raiseButton.addTarget(self, action: #selector(tapped), forControlEvents: .TouchUpInside);
        self.view.addSubview(raiseButton);
    }

    func tapped(sender: UIButton!){
        NSLog("Button was tapped!");
    }

}
~~~

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

## Attributions

Material Components for iOS uses
[Material Design icons](https://github.com/google/material-design-icons),
copyright Google Inc. and licensed under
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

Several components use
[MDFTextAccessibility](https://github.com/material-foundation/material-text-accessibility-ios),
copyright Google Inc. and licensed under
[Apache 2.0](https://github.com/material-foundation/material-text-accessibility-ios/blob/master/LICENSE)
without a NOTICE file.

MDCCatalog uses the
[Roboto font](https://github.com/google/fonts/tree/master/apache/roboto),
copyright 2011 Google Inc. and licensed under
[Apache 2.0](https://github.com/google/fonts/blob/master/apache/roboto/LICENSE.txt)
without a NOTICE file.
