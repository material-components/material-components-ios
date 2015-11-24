/*:
# Scroll view delegate multiplexer playground

This playground explores the use of a UIScrollViewDelegate multiplexer in order to react to UIScrollView events.

Requirements: **Xcode 7.1 or higher**.

We've created a framework called MaterialScrollViewDelegateMultiplexer in which we've placed the relevant code.

If the Playground can't find the framework then you need to initiate a build of the ScrollViewDelegateMultiplexerExample project. Also make sure that you're viewing the playground via Examples.xcworkspace.
*/
import MaterialScrollViewDelegateMultiplexer

//: We'll use the XCPlayground framework to show a live view in the Assistant editor. Simply click the Assistant editor icon to view the live view.
import XCPlayground

/*:
## Create a multiplexer

The multiplexer object is meant to be assigned as the delegate of a UIScrollView. The delegate property won't hold onto a reference of the multiplexer, so we need to store an instance of the multiplexer elsewhere.

For the purposes of this Playground we'll store the multiplexer in the global scope. In practice you'd store this multiplexer as a property on your UIViewController.
*/
let multiplexer = MDCScrollViewDelegateMultiplexer()

/*:
Let's create a hypothetical object that is interested in reacting to UIScrollViewDelegate events. When it receives a `scrollViewDidScroll:` event it will execute a provided block.
*/
class ScrollViewListener : NSObject {
  init(didScrollCallback: UIScrollView -> Void) { self.didScrollCallback = didScrollCallback }
  let didScrollCallback: UIScrollView -> Void
}

extension ScrollViewListener : UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    self.didScrollCallback(scrollView)
  }
}

/*:
## Register listeners

We'll create two listeners objects and add both of them to our multiplexer. When the Playground executes you'll be able to verify that each block was invoked while the scroll view scrolls.
*/
let listener1 = ScrollViewListener { scrollView in
  scrollView.contentOffset.y
//: Without the following return statement, Swift will treat the line above as an implicit return statement and we won't be able to see the Playground graph.
  return
}

let listener2 = ScrollViewListener { scrollView in
  scrollView.contentOffset.y
  return
}

//: We can now register each listener instance to the multiplexer. Our multiplexer is now ready to be assigned as the delegate of a UIScrollView.
multiplexer.addObservingDelegate(listener1)
multiplexer.addObservingDelegate(listener2)

/*:
## The view controller

We'll use the Playground live view feature to show a subclass of UIViewController we've created for this playground.
*/
class PlaygroundViewController : UIViewController {
  var scrollView: UIScrollView?
}

//: Assigning our view controller as the live view places will cause our view controller's view to show up in the Assistant editor.
XCPlaygroundPage.currentPage.liveView = PlaygroundViewController()

extension PlaygroundViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()

    let width = self.view.bounds.size.width

    scrollView = UIScrollView(frame: self.view.bounds)

//: We can now assign the multiplexer as the scroll view's delegate.
    scrollView!.delegate = multiplexer

//: The rest of this logic is straightforward UIKit view creation and manipulation.
    scrollView!.contentSize = CGSize(width: width, height: self.view.bounds.height * 100)
    self.view.addSubview(scrollView!)

    for _ in 0..<15 {
      let square = UIView(frame: CGRect(
        x: drand48() * Double(width - 30),
        y: drand48() * 1000,
        width: 30,
        height: 30)
      )
      square.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)

      scrollView!.addSubview(square)
    }
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    scrollView?.setContentOffset(CGPoint(x: 0, y: 400), animated: true)
  }
}

//: # Playground logic

extension ScrollViewListener {
  func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    XCPlaygroundPage.currentPage.finishExecution()
  }
}
