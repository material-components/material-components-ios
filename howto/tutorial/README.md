<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/google/material-components-ios">GitHub</a> for README documentation.{% endif %}-->

---


## Tutorial



1.  Create a new Xcode application:
    1.  Open Xcode. If the launch screen is present, click “Create a new Xcode project” or go to menu File -> New -> Project….
    2.  In the template window, select “iOS” as the platform and “Single View Application” as the Application type. Click “Next.”
    3.  Name your project “MDC-Tutorial” and choose your preferred language. Click “Next.”
    4.  Choose a place to save your new project that you can remember. Click “Create.”
    5.  Close your new project by going to menu File -> Close Project or holding "option+command+w". We’ll come back to the project in a minute.
1.  Setup CocoaPods:
    1.  Open the app “Terminal.”
    1.  If you do not already have CocoaPods installed on this system, run:
        ~~~ bash
        
        sudo gem install cocoapods
        ~~~
    1.  Navigate to your project's directory and create a Podfile by running:
        ~~~ bash
        
        cd [directory of your project]
        pod init
        ~~~ 
    1.  Open the new Podfile in a text editor or by running:
        ~~~ bash
        
        open -a Xcode Podfile
        ~~~
    1.  Add the Material Components pod to the Podfile:
        ~~~ ruby
        
        target 'MDC-Tutorial' 
        use_frameworks!
    
        # Pods for MDC-Tutorial
        pod 'MaterialComponents', :git => 'https://github.com/google/material-components-ios.git'
    
        end
        ~~~ 
    NOTE: If the language you’re using in this project is Objective-C, comment out ‘use_frameworks’ by adding a ‘#’ in front of it.
    1.  Save the Podfile
    1.  Back in Terminal, install your new pod and open the generated workspace:
        ~~~ bash
        
        pod install
        open MDC-Tutorial.xcworkspace
        ~~~



3.  Add a Material Collection View:
    1.  In Xcode, select "ViewController.swift" or "ViewController.h." 

    1.  Import MDC
    
        Swift:
        ~~~ swift
        Import MaterialComponents
        ~~~
        Objective-C:
        ~~~ objc
        TODO: ObjC
        ~~~
        
    1.  Change ViewController’s superclass to MDCCollectionViewController:
    
        Swift:
        ~~~ swift
        class ViewController: MDCCollectionViewController {
        ~~~
        Objective-C:
        ~~~ objc
        TODO: ObjC
        ~~~

    1.  Open Main.storyboard and delete the default view controller that came with it. Then drag a new Collection View Controller on to the storyboard, change the Custom Class of that view controller to ViewController, and set “Is Initial View Controller” to true. 
    Select the prototype cell and set its custom class to “MDCCollectionViewTextCell”, 
    then set its reuse identifier to “cell”:

    1.  In viewDidLoad, configure the collection view’s appearance:
        ~~~swift
        override func viewDidLoad() {
            super.viewDidLoad()
    
            // Configure the collection view's appearance.
            styler.cellStyle = .card
            styler.cellLayoutType = .grid
        }
        ~~~
        
    1.  Below viewDidLoad, add a mock datasource:
        ~~~ swift
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 40
        }
    
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    
          if let textCell = cell as? MDCCollectionViewTextCell {
    
          // Add some mock text to the cell.
        textCell.textLabel?.text = "#" + String(indexPath.item)
    
          }
    
          return cell
        }
        ~~~
        
    1.  Build and run your app. It should display a scrollable, touchable collection view:


4.  Add an app bar:
    1.  Add the property declaration to the top of the class:
        ~~~ swift
        let appBar = MDCAppBar()
        TODO: Image
        ~~~

    1.  Configure the app bar in viewDidLoad:
        ~~~ swift
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor.white
        appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        appBar.addSubviewsToParent()
        ~~~
        
    1.  Build and run your app. It should display a white rectangle above the collection view: But if you pull down, it doesn’t expand at all.

1.  Make the app bar flexible by forwarding scroll view delegate methods:
    1.  Implement the following methods. (In Swift you can choose to do this as a new extension.):
        ~~~swift
        extension ViewController {
    
                // MARK: UIScrollViewDelegate
    
                override func scrollViewDidScroll(_ scrollView: UIScrollView) {

                if scrollView == appBar.headerViewController.headerView.trackingScrollView {

                appBar.headerViewController.headerView.trackingScrollDidScroll()

                }

            }

            override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

                if scrollView == appBar.headerViewController.headerView.trackingScrollView {

               appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()

               }

            }

            override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

                if scrollView == appBar.headerViewController.headerView.trackingScrollView {

               let headerView = appBar.headerViewController.headerView

               headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)

                }

            }
    
            override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

                if scrollView == appBar.headerViewController.headerView.trackingScrollView {

                let headerView = appBar.headerViewController.headerView

                headerView.trackingScrollWillEndDragging(
                withVelocity: velocity, targetContentOffset: targetContentOffset)

                }

            }

        }
        ~~~

    2. Build and run your app. The app bar should now flex when the collection view is scrolled too far:



---


## **Next steps**

This tutorial gives a glimpse of what MDC can do. But there are a lot more components for you to discover.

Use our examples and catalog apps to try out other components and other ways to integrate them into apps.

### Sample Code



*   [Pesto A simple recipe app, incorporating a flexible header, floating action button, and collections.](https://github.com/google/material-components-ios/tree/master/demos/Pesto)
*   [Shrine A demo shopping app, incorporating a flexible header, custom typography, and collections.](https://github.com/google/material-components-ios/tree/master/demos/Shrine)

### For more information:



*   [Read the Component Documentation](https://github.com/google/material-components-ios/blob/develop/howto/tutorial/%7B%7B%20site.folder%20%7D%7D/components)
*   [Stack Overflow "material-components-ios"](http://stackoverflow.com/questions/tagged/material-components-ios)
