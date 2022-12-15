// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

@available(iOS 13.0, *)
@objc(MDCNavigationRailViewController)
/// The Navigation rail provides access to primary destinations in your app on iPad devices.
///
/// NavigationRailViewController is a class that manages the navigation rail that allows movement
/// between primary destination in an app.  It ties a list of view controllers to a leading edge rail
/// and will display the corresponding view controller in the content view when an
/// item in the navigation rail is selected.
public class NavigationRailViewController: UIViewController {

  struct Constants {
    static let railCellReuseIdentifier = "kRailCellReuseIdentifier"
    static let railCellSize: CGFloat = 80
  }

  /// The navigation rail controller’s delegate object.
  ///
  /// You can use the delegate object to track changes to the items in the navigation rail and to monitor the selection of items.
  /// The delegate object you provide should conform to the NavigationRailViewControllerDelegate  protocol.
  /// The default value for this property is nil.
  @objc public weak var delegate: NavigationRailViewControllerDelegate?

  /// The navigation rail view associated with this controller.
  ///
  /// To configure the items for your navigation rail interface,
  /// you should assign one or more custom view controllers to the viewControllers property.
  /// The navigation rail collects the needed tab bar items from the view controllers you specify.
  @objc public var navigationRail = NavigationRailView()

  /// An array of the root view controllers displayed by the navigation rail interface.
  ///
  /// The default value of this property is nil. When configuring a navigation rail view controller,
  /// you can use this property to specify the content for each item of the navigation rail interface.
  /// The order of the view controllers in the array corresponds to the display order in the rail.
  /// Thus, the controller at index 0 corresponds to the top-most item, the controller at index 1 the next item below, and so on.
  @objc public var viewControllers: [UIViewController] {
    get {
      children
    }
    set {
      setViewControllers(newValue, animated: true)
    }
  }

  /// The size of the selection indicator.
  ///
  /// Defaults to (56, 32)
  @objc public var selectionIndicatorSize: CGSize = CGSize(width: 56, height: 32) {
    didSet {
      guard selectionIndicatorSize != oldValue else {
        return
      }
      navigationRail.selectionIndicatorSize = selectionIndicatorSize
    }
  }

  /// The view controller associated with the currently selected item.
  @objc public var selectedViewController: UIViewController? {
    didSet {
      guard selectedViewController != oldValue,
        let selectedViewController = selectedViewController
      else {
        return
      }
      oldValue?.view.removeFromSuperview()
      contentView.addSubview(selectedViewController.view)
      configureConstraintsForSelectedViewControllerView(selectedViewController.view)
      selectedIndex = viewControllers.firstIndex(of: selectedViewController) ?? NSNotFound
    }
  }

  private var _selectedIndex: Int = NSNotFound
  /// The index of the view controller associated with the currently selected item.
  @objc public var selectedIndex: Int {
    set {
      guard newValue != _selectedIndex,
        newValue <= viewControllers.count
      else {
        return
      }
      _selectedIndex = newValue
      guard newValue != NSNotFound else {
        deselectCurrentItem()
        return
      }
      updateViews(for: _selectedIndex)
    }
    get {
      _selectedIndex
    }
  }

  /// The content view holds the selected view controller's view within it, and allocates the right dimensions for it in the window.
  private var contentView = UIView()

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubview(contentView)
    view.addSubview(navigationRail)
    configureConstraints()
    navigationRail.delegate = self
  }

  /// Sets the root view controllers of the navigation rail view controller.
  /// - Parameters:
  ///   - viewControllers: The array of custom view controllers to display in the navigation rail interface.
  ///   The order of the view controllers in this array corresponds to the display order in the navigation rail,
  ///   with the controller at index 0 representing the top-most tab, the controller at index 1 the next item below, and so on.
  ///   - animated: If true, the tab bar items for the view controllers are animated into position.
  ///    If false, changes to the tab bar items are reflected immediately.
  @objc public func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
    deselectCurrentItem()
    removeExistingViewControllers()
    addNewViewControllers(viewControllers)
    navigationRail.items = tabBarItems()
    selectedViewController = self.viewControllers.first
  }

  func tabBarItems() -> [UITabBarItem]? {
    var items = [UITabBarItem]()

    viewControllers.forEach {
      items.append($0.tabBarItem)
    }
    return items
  }

  func deselectCurrentItem() {
    _selectedIndex = NSNotFound
    navigationRail.selectedItem = nil
    selectedViewController = nil
  }

  private func updateViews(for selectedIndex: Int) {
    let selectedViewController = self.viewControllers[selectedIndex]
    self.selectedViewController = selectedViewController

    // update nav rail selected item
    self.navigationRail.selectedItem = selectedViewController.tabBarItem
  }

  private func removeExistingViewControllers() {
    viewControllers.forEach {
      $0.willMove(toParent: nil)
      $0.view.removeFromSuperview()
      $0.removeFromParent()
    }
  }

  private func addNewViewControllers(_ viewControllers: [UIViewController]?) {
    viewControllers?.forEach {
      self.addChild($0)
      $0.didMove(toParent: self)
    }
  }

  private func configureConstraintsForSelectedViewControllerView(_ selectedView: UIView) {
    selectedView.translatesAutoresizingMaskIntoConstraints = false
    var onscreenConstraints = [NSLayoutConstraint]()
    onscreenConstraints.append(
      selectedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
    onscreenConstraints.append(
      selectedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
    onscreenConstraints.append(selectedView.topAnchor.constraint(equalTo: contentView.topAnchor))
    onscreenConstraints.append(
      selectedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
    NSLayoutConstraint.activate(onscreenConstraints)
  }

  private func configureConstraints() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    navigationRail.translatesAutoresizingMaskIntoConstraints = false
    var onscreenConstraints = [NSLayoutConstraint]()
    onscreenConstraints.append(navigationRail.widthAnchor.constraint(equalToConstant: 80))
    onscreenConstraints.append(navigationRail.topAnchor.constraint(equalTo: view.topAnchor))
    onscreenConstraints.append(navigationRail.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    onscreenConstraints.append(navigationRail.leadingAnchor.constraint(equalTo: view.leadingAnchor))
    onscreenConstraints.append(
      contentView.leadingAnchor.constraint(equalTo: navigationRail.trailingAnchor))
    onscreenConstraints.append(contentView.topAnchor.constraint(equalTo: view.topAnchor))
    onscreenConstraints.append(contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    onscreenConstraints.append(contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
    NSLayoutConstraint.activate(onscreenConstraints)
  }
}

@available(iOS 13.0, *)
extension NavigationRailViewController: NavigationRailViewDelegate {
  public func navigationRail(_ navigationRail: NavigationRailView, shouldSelect item: UITabBarItem)
    -> Bool
  {
    guard let vc = viewControllers.filter({ $0.tabBarItem == item }).first else { return true }
    return self.delegate?.navigationRailViewController?(self, shouldSelect: vc) ?? true
  }

  public func navigationRail(_ navigationRail: NavigationRailView, didSelect item: UITabBarItem) {
    guard let vc = viewControllers.filter({ $0.tabBarItem == item }).first else { return }

    self.selectedViewController = vc
    self.delegate?.navigationRailViewController?(self, didSelect: vc)
  }

  public func navigationRail(
    _ navigationRail: NavigationRailView, didTapMenuButton menuButton: UIButton
  ) {
    self.delegate?.navigationRailViewController?(self, didTapMenuButton: menuButton)
  }

  public func navigationRail(
    _ navigationRail: NavigationRailView, didTapFloatingActionButton floatingActionButton: UIButton
  ) {
    self.delegate?.navigationRailViewController?(
      self, didTapFloatingActionButton: floatingActionButton)
  }
}
