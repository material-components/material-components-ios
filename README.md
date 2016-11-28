<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/material-components/material-components-ios">GitHub</a> for README documentation.{% endif %}-->

Material Components is a collection of standalone production-quality components.

Material Components’ visual style is based on the
[material design](http://www.google.com/design/spec/material-design/introduction.html)
specification, developed by a team of iOS engineers and UX designers at Google.

## Catalog

Catalog is a demonstration application that showcases the Material Components.

### If you haven't checked out the repo yet:

~~~ bash
pod try MaterialComponents
~~~

### If you have checked out the repo:

~~~ bash
pod install --project-directory=catalog/ --no-repo-update
~~~

## Quickstart

### 1. Install CocoaPods

[CocoaPods](https://cocoapods.org/) is the easiest way to get started. If you're new to CocoaPods,
check out their [getting started documentation](https://guides.cocoapods.org/using/getting-started.html).

To install CocoaPods, run the following commands:

~~~ bash
sudo gem install cocoapods
~~~


### 2. Create Podfile

Once you've created an iOS application in Xcode you can start using Material Components for iOS.

To initialize CocoaPods in your project, run the following commands:

~~~ bash
cd your-project-directory
pod init
~~~

### 3. Edit Podfile

Once you've initialized CocoaPods, add the
[Material Components for iOS Pod](https://cocoapods.org/pods/MaterialComponentsIOS)
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
open your-project.xcworkspace
~~~

Now you're ready to get started in Xcode.

### 4. Usage

Now you’re ready to add a component (e.g. Buttons) to your app!
Include the Material Components header for the component you're interested
in to your app (detailed below) to get all of the required classes.

Choose from Objective-C or Swift:

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

~~~ swift
import MaterialComponents.MaterialButtons

class MDCBuildTestViewController: UIViewController {

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

### 5. What's next?

- [Read the Development Guide](howto/)

- [View the Component Documentation](components/)

- [Explore our Code Samples](howto/tutorial/#sample-code)

## Attributions

Material Components for iOS uses
[material design icons](https://github.com/google/material-design-icons),
copyright Google Inc. and licensed under
[CC BY 4.0](http://creativecommons.org/licenses/by/4.0/).

Several components use
[MDFTextAccessibility](https://github.com/material-foundation/material-text-accessibility-ios),
copyright Google Inc. and licensed under
[Apache 2.0](https://github.com/material-foundation/material-text-accessibility-ios/blob/master/LICENSE)
without a NOTICE file.

Roboto Font Loader uses the
[Roboto font](https://github.com/google/fonts/tree/master/apache/roboto),
copyright 2011 Google Inc. and licensed under
[Apache 2.0](https://github.com/google/fonts/blob/master/apache/roboto/LICENSE.txt)
without a NOTICE file.
