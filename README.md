
Material Components is a collection of standalone production-quality components.

> Material Components’ visual style is based on the [material design](http://www.google.com/design/spec/material-design/introduction.html) specification, developed by a team of iOS engineers and UX designers at Google.

- [Samples and Demos](#samples-and-demos)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [Donations](#donations)
- [License](#license)


## Samples and Demos

### Catalog

[Catalog](catalog/) is a demonstration application that showcases the Material Components.

You can use the `pod try` command from anywhere on you machine to try the components, even if you haven't checked out the repo yet:

~~~ bash
pod try MaterialComponents
~~~

In case you have already checked out the repo, run the following command:

~~~ bash
pod install --project-directory=catalog/ --no-repo-update
~~~

### Pesto

[Pesto](demos/Pesto) is a simple recipe app, incorporating a flexible header, floating action button, and collections.

### Shrine

[Shrine](demos/Shrine) is a demo shopping app, incorporating a flexible header, custom typography, and collections.

## Installation

### Getting Started with a New Project

Check out our [tutorial](howto/tutorial) for a step-by-step guide to setting up
a new project using Material Components.

### Adding Material Components to an Existing Project

[CocoaPods](https://cocoapods.org/) is the easiest way to get started. To install
CocoaPods, run the following command:

~~~ bash
$ sudo gem install cocoapods
~~~

To integrate Material Components in your existing application, first create a new Podfile:

~~~ bash
cd your-project-directory
pod init
~~~

Next, add the [Material Components for iOS pod](https://cocoapods.org/pods/MaterialComponentsIOS) to your target in your Podfile:

~~~ ruby
target "MyApp" do
  ...
  # Until Material Components for iOS is public:
  pod 'MaterialComponents', :git => 'https://github.com/material-components/material-components-ios.git'

  # After Material Components for iOS is public:
  # pod 'MaterialComponents'
end
~~~

If you are using Swift, don’t forget to uncomment the `use_frameworks!` line at the top of your Podfile.

Then, run the following command to download the [Material Components for iOS Pod](https://cocoapods.org/pods/MaterialComponentsIOS) and integrate it in your app:

~~~ bash
pod install
~~~

Now you're ready to get started in Xcode. Don't forget to open the workspace
Cocoapods created for you instead of the original project:

~~~ bash
open your-project.xcworkspace
~~~


Then run the command:

~~~ bash
pod install
open your-project.xcworkspace
~~~

Now you're ready to get started in Xcode.

## Usage

Now you’re ready to add a component (e.g. [Buttons](components/Buttons)) to your app!
Include the Material Components header for the component you're interested
in to your app (detailed below) to get all of the required classes.

Choose from Swift or Objective-C:

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

## Next Steps

- [Read the Development Guide](howto/)

- [View the Component Documentation](components/)

- [Explore our Code Samples](howto/tutorial/#sample-code)

## Credits

Material Components for iOS uses [material design icons](https://github.com/google/material-design-icons), copyright Google Inc. and licensed under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/).

Several components use [MDFTextAccessibility](https://github.com/material-foundation/material-text-accessibility-ios), copyright Google Inc. and licensed under [Apache 2.0](https://github.com/material-foundation/material-text-accessibility-ios/blob/master/LICENSE) without a NOTICE file.

Roboto Font Loader uses the [Roboto font](https://github.com/google/fonts/tree/master/apache/roboto), copyright 2011 Google Inc. and licensed under [Apache 2.0](https://github.com/google/fonts/blob/master/apache/roboto/LICENSE.txt) without a NOTICE file.

## License

Material Components for iOS is released under the Apache 2.0 license. See [LICENSE](LICENSE) for details.
