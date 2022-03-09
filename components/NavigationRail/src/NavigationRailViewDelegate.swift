import UIKit

@available(iOS 13.0, *)
@objc(MDCNavigationRailViewDelegate)
/// The NavigationRailViewDelegate protocol defines optional methods for a delegate of a NavigationRailView object.
/// The protocol provides a set of methods you implement to customize the selection behavior of a navigation rail.
/// If using a NavigationRailViewController and not a NavigationRailView directly,
/// please use the NavigationRailViewControllerDelegate instead.
public protocol NavigationRailViewDelegate {

  /// Asks the delegate whether the specified item should be made active.
  ///
  /// The navigation rail calls this method in response to the user tapping a navigation rail item.
  /// You can use this method to dynamically decide whether a given item should be made the active item.
  /// - Returns: @c true if the item should be selected or @c false if the current item should remain active.
  @objc optional func navigationRail(
    _ navigationRail: NavigationRailView,
    shouldSelect item: UITabBarItem
  ) -> Bool

  /// Tells the delegate that the user selected an item in the navigation rail.
  ///
  /// This method is called only when the selected item actually changes.
  /// In other words, it is not called when the same item is selected.
  @objc optional func navigationRail(
    _ navigationRail: NavigationRailView,
    didSelect item: UITabBarItem)

  /// Tells the delegate that the user tapped the menu button in the navigation rail.
  ///
  /// This method is called when the button's touchUpInside event is triggered.
  @objc optional func navigationRail(
    _ navigationRail: NavigationRailView,
    didTapMenuButton menuButton: UIButton)

  /// Tells the delegate that the user tapped the floating action button in the navigation rail.
  ///
  /// This method is called when the button's touchUpInside event is triggered.
  @objc optional func navigationRail(
    _ navigationRail: NavigationRailView,
    didTapFloatingActionButton floatingActionButton: UIButton)
}
