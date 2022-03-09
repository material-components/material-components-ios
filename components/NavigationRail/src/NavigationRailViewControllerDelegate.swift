import UIKit

@available(iOS 13.0, *)
@objc(MDCNavigationRailViewControllerDelegate)
/// A set of methods you implement to customize the selection behavior of a navigation rail.
public protocol NavigationRailViewControllerDelegate {

  /// Asks the delegate whether the specified view controller should be made active.
  ///
  /// The navigation rail view controller calls this method in response to the user tapping a navigation rail item.
  /// You can use this method to dynamically decide whether a given item should be made the active item.
  /// - Returns: @c true if the view controller’s item should be selected or @c false if the current item should remain active.
  @objc optional func navigationRailViewController(
    _ navigationRailViewController: NavigationRailViewController,
    shouldSelect viewController: UIViewController
  ) -> Bool

  /// Tells the delegate that the user selected an item in the navigation rail.
  ///
  /// This method is called only when the selected view controller actually changes.
  /// In other words, it is not called when the same view controller is selected.
  @objc optional func navigationRailViewController(
    _ navigationRailViewController: NavigationRailViewController,
    didSelect viewController: UIViewController)

  /// Tells the delegate that the user tapped the menu button in the navigation rail.
  ///
  /// This method is called when the button's touchUpInside event is triggered.
  @objc optional func navigationRailViewController(
    _ navigationRailViewController: NavigationRailViewController,
    didTapMenuButton menuButton: UIButton)

  /// Tells the delegate that the user tapped the floating action button in the navigation rail.
  ///
  /// This method is called when the button's touchUpInside event is triggered.
  @objc optional func navigationRailViewController(
    _ navigationRailViewController: NavigationRailViewController,
    didTapFloatingActionButton floatingActionButton: UIButton)
}
