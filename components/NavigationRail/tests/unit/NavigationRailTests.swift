import XCTest

@testable import MaterialComponents.MaterialNavigationRail

class NavigationRailTests: XCTestCase {

  @available(iOS 13.0, *)
  lazy var navigationRailViewController: NavigationRailViewController! = nil

  override func setUp() {
    super.setUp()
    if #available(iOS 13, *) {
      navigationRailViewController = NavigationRailViewController()
    }
  }

  override func tearDown() {
    if #available(iOS 13, *) {
      navigationRailViewController = nil
    }
    super.tearDown()
  }

  func testSettingViewControllersThroughSetAPI() {
    if #available(iOS 13, *) {
      // Given
      let viewController1 = UIViewController()
      let tabBarItem1 = UITabBarItem(
        title: "title1", image: UIImage(systemName: "star"),
        selectedImage: UIImage(systemName: "square"))
      viewController1.tabBarItem = tabBarItem1
      let viewController2 = UIViewController()
      let tabBarItem2 = UITabBarItem(
        title: "title2", image: UIImage(systemName: "circle"),
        selectedImage: UIImage(systemName: "seal"))
      viewController2.tabBarItem = tabBarItem2

      // When
      navigationRailViewController.setViewControllers(
        [viewController1, viewController2], animated: true)

      // Then
      XCTAssertEqual(navigationRailViewController.viewControllers.count, 2)
      XCTAssertNotNil(navigationRailViewController.navigationRail.items)
      XCTAssertEqual(navigationRailViewController.navigationRail.items!.count, 2)
      XCTAssertEqual(navigationRailViewController.navigationRail.items!.first, tabBarItem1)
      XCTAssertEqual(navigationRailViewController.navigationRail.items!.last, tabBarItem2)
    }
  }

  func testSettingViewControllersThroughViewControllers() {
    if #available(iOS 13, *) {
      // Given
      let viewController1 = UIViewController()
      let tabBarItem1 = UITabBarItem(
        title: "title1", image: UIImage(systemName: "star"),
        selectedImage: UIImage(systemName: "square"))
      viewController1.tabBarItem = tabBarItem1
      let viewController2 = UIViewController()
      let tabBarItem2 = UITabBarItem(
        title: "title2", image: UIImage(systemName: "circle"),
        selectedImage: UIImage(systemName: "seal"))
      viewController2.tabBarItem = tabBarItem2

      // When
      navigationRailViewController.viewControllers = [viewController1, viewController2]

      // Then
      XCTAssertEqual(navigationRailViewController.viewControllers.count, 2)
      XCTAssertNotNil(navigationRailViewController.navigationRail.items)
      XCTAssertEqual(navigationRailViewController.navigationRail.items!.count, 2)
      XCTAssertEqual(navigationRailViewController.navigationRail.items!.first, tabBarItem1)
      XCTAssertEqual(navigationRailViewController.navigationRail.items!.last, tabBarItem2)
    }
  }

  func testSettingSelectedViewController() {
    if #available(iOS 13, *) {
      // Given
      let viewController1 = UIViewController()
      let tabBarItem1 = UITabBarItem(
        title: "title1", image: UIImage(systemName: "star"),
        selectedImage: UIImage(systemName: "square"))
      viewController1.tabBarItem = tabBarItem1
      let viewController2 = UIViewController()
      let tabBarItem2 = UITabBarItem(
        title: "title2", image: UIImage(systemName: "circle"),
        selectedImage: UIImage(systemName: "seal"))
      viewController2.tabBarItem = tabBarItem2
      navigationRailViewController.viewControllers = [viewController1, viewController2]

      // When
      navigationRailViewController.selectedViewController = viewController2

      // Then
      XCTAssertEqual(
        navigationRailViewController.selectedIndex,
        navigationRailViewController.viewControllers.firstIndex(of: viewController2))
      XCTAssertEqual(
        navigationRailViewController.navigationRail.selectedItem, viewController2.tabBarItem)
    }
  }

  func testSettingSelectedIndex() {
    if #available(iOS 13, *) {
      // Given
      let viewController1 = UIViewController()
      let tabBarItem1 = UITabBarItem(
        title: "title1", image: UIImage(systemName: "star"),
        selectedImage: UIImage(systemName: "square"))
      viewController1.tabBarItem = tabBarItem1
      let viewController2 = UIViewController()
      let tabBarItem2 = UITabBarItem(
        title: "title2", image: UIImage(systemName: "circle"),
        selectedImage: UIImage(systemName: "seal"))
      viewController2.tabBarItem = tabBarItem2
      navigationRailViewController.viewControllers = [viewController1, viewController2]

      // When
      navigationRailViewController.selectedIndex = navigationRailViewController.viewControllers
        .firstIndex(of: viewController2)!

      // Then
      XCTAssertEqual(navigationRailViewController.selectedViewController, viewController2)
      XCTAssertEqual(
        navigationRailViewController.navigationRail.selectedItem, viewController2.tabBarItem)
    }
  }

  func testSettingSelectedViewControllerToBadValue() {
    if #available(iOS 13, *) {
      // Given
      let viewController1 = UIViewController()
      let tabBarItem1 = UITabBarItem(
        title: "title1", image: UIImage(systemName: "star"),
        selectedImage: UIImage(systemName: "square"))
      viewController1.tabBarItem = tabBarItem1
      let viewController2 = UIViewController()
      let tabBarItem2 = UITabBarItem(
        title: "title2", image: UIImage(systemName: "circle"),
        selectedImage: UIImage(systemName: "seal"))
      viewController2.tabBarItem = tabBarItem2
      navigationRailViewController.viewControllers = [viewController1, viewController2]

      // When
      navigationRailViewController.selectedViewController = UIViewController()

      // Then
      XCTAssertEqual(
        navigationRailViewController.selectedIndex,
        navigationRailViewController.viewControllers.firstIndex(of: viewController1))
      XCTAssertEqual(
        navigationRailViewController.navigationRail.selectedItem, viewController1.tabBarItem)
    }
  }

  func testSettingSelectedIndexToBadValue() {
    if #available(iOS 13, *) {
      // Given
      let viewController1 = UIViewController()
      let tabBarItem1 = UITabBarItem(
        title: "title1", image: UIImage(systemName: "star"),
        selectedImage: UIImage(systemName: "square"))
      viewController1.tabBarItem = tabBarItem1
      let viewController2 = UIViewController()
      let tabBarItem2 = UITabBarItem(
        title: "title2", image: UIImage(systemName: "circle"),
        selectedImage: UIImage(systemName: "seal"))
      viewController2.tabBarItem = tabBarItem2
      navigationRailViewController.viewControllers = [viewController1, viewController2]

      // When
      navigationRailViewController.selectedIndex = 100

      // Then
      XCTAssertEqual(navigationRailViewController.selectedViewController, viewController1)
      XCTAssertEqual(
        navigationRailViewController.navigationRail.selectedItem, viewController1.tabBarItem)
    }
  }

  func testSettingNavigationRailItemsOnNavigationRailView() {
    if #available(iOS 13, *) {
      // Given
      let navigationRail = NavigationRailView()
      let items = [
        UITabBarItem(title: "Item 1", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 2", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 3", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 4", image: UIImage(systemName: "heart"), tag: 100),
      ]

      // When
      navigationRail.items = items
      navigationRail.layoutIfNeeded()

      // Then
      XCTAssertEqual(navigationRail.itemsStackView.arrangedSubviews.count, items.count)
      let firstItemView =
        navigationRail.itemsStackView.arrangedSubviews.first as? NavigationRailItemView
      XCTAssertNotNil(firstItemView)
      XCTAssertEqual(firstItemView?.labelText, items.first?.title)
      XCTAssertNil(navigationRail.selectedItem)
    }
  }

  func testSettingSelectedItemOnNavigationRailView() {
    if #available(iOS 13, *) {
      // Given
      let navigationRail = NavigationRailView()
      let items = [
        UITabBarItem(title: "Item 1", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 2", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 3", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 4", image: UIImage(systemName: "heart"), tag: 100),
      ]
      navigationRail.items = items

      // When
      navigationRail.selectedItem = items.last

      // Then
      let lastItemView =
        navigationRail.itemsStackView.arrangedSubviews.last as? NavigationRailItemView
      let firstItemView =
        navigationRail.itemsStackView.arrangedSubviews.first as? NavigationRailItemView
      XCTAssertNotNil(lastItemView)
      XCTAssertTrue(lastItemView!.isSelected)
      XCTAssertNotNil(firstItemView)
      XCTAssertFalse(firstItemView!.isSelected)
    }
  }

  func testSettingTabBarItemTitleValueUpdatesRail() {
    if #available(iOS 13, *) {
      // Given
      let navigationRail = NavigationRailView()
      let items = [
        UITabBarItem(title: "Item 1", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 2", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 3", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 4", image: UIImage(systemName: "heart"), tag: 100),
      ]
      navigationRail.items = items

      // When
      let newTitle = "Changed!"
      items.first?.title = newTitle

      // Then
      let firstItemView =
        navigationRail.itemsStackView.arrangedSubviews.first as? NavigationRailItemView
      XCTAssertEqual(firstItemView?.labelText, newTitle)
    }
  }

  func testDefaultRailValues() {
    if #available(iOS 13, *) {
      // Given
      let navigationRail = NavigationRailView()
      let items = [
        UITabBarItem(title: "Item 1", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 2", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 3", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 4", image: UIImage(systemName: "heart"), tag: 100),
      ]

      // When
      navigationRail.items = items

      // Then
      XCTAssertFalse(navigationRail.isMenuButtonVisible)
      XCTAssertFalse(navigationRail.isFloatingActionButtonVisible)
      XCTAssertEqual(navigationRail.fabButton.tintColor, .label)
      XCTAssertEqual(navigationRail.fabButton.backgroundColor, .cyan)
      XCTAssertEqual(navigationRail.fabButton.image(for: .normal), .init(systemName: "pencil"))
      XCTAssertEqual(navigationRail.itemsAlignment, .center)
      let firstItem =
        navigationRail.itemsStackView.arrangedSubviews.first as? NavigationRailItemView
      XCTAssertNotNil(firstItem)
      XCTAssertEqual(firstItem?.titleColor(for: .normal), .label)
      XCTAssertEqual(firstItem?.titleColor(for: .selected), .label)
      XCTAssertEqual(firstItem?.imageTintColor(for: .normal), .label)
      XCTAssertEqual(firstItem?.imageTintColor(for: .selected), .systemIndigo)
      XCTAssertFalse(firstItem!.hideLabel)
    }
  }

  func testDefaultRailValuesWithNilConfiguration() {
    if #available(iOS 13, *) {
      // Given
      let navigationRail = NavigationRailView()
      let items = [
        UITabBarItem(title: "Item 1", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 2", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 3", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 4", image: UIImage(systemName: "heart"), tag: 100),
      ]
      navigationRail.items = items

      // When
      navigationRail.configuration = nil

      // Then
      XCTAssertFalse(navigationRail.isMenuButtonVisible)
      XCTAssertFalse(navigationRail.isFloatingActionButtonVisible)
      XCTAssertEqual(navigationRail.fabButton.tintColor, .label)
      XCTAssertEqual(navigationRail.fabButton.backgroundColor, .cyan)
      XCTAssertEqual(navigationRail.fabButton.image(for: .normal), .init(systemName: "pencil"))
      XCTAssertEqual(navigationRail.itemsAlignment, .center)
      let firstItem =
        navigationRail.itemsStackView.arrangedSubviews.first as? NavigationRailItemView
      XCTAssertNotNil(firstItem)
      XCTAssertEqual(firstItem?.titleColor(for: .normal), .label)
      XCTAssertEqual(firstItem?.titleColor(for: .selected), .label)
      XCTAssertEqual(firstItem?.imageTintColor(for: .normal), .label)
      XCTAssertEqual(firstItem?.imageTintColor(for: .selected), .systemIndigo)
      XCTAssertFalse(firstItem!.hideLabel)
    }
  }

  func testDefaultRailConfigurationValues() {
    if #available(iOS 13, *) {
      // Given
      let navigationRail = NavigationRailView()
      let items = [
        UITabBarItem(title: "Item 1", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 2", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 3", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 4", image: UIImage(systemName: "heart"), tag: 100),
      ]
      navigationRail.items = items

      // When
      navigationRail.configuration = NavigationRailConfiguration.railConfiguration()

      // Then
      XCTAssertFalse(navigationRail.isMenuButtonVisible)
      XCTAssertFalse(navigationRail.isFloatingActionButtonVisible)
      XCTAssertEqual(navigationRail.fabButton.tintColor, .label)
      XCTAssertEqual(navigationRail.fabButton.backgroundColor, .cyan)
      XCTAssertEqual(navigationRail.fabButton.image(for: .normal), .init(systemName: "pencil"))
      XCTAssertEqual(navigationRail.itemsAlignment, .center)
      let firstItem =
        navigationRail.itemsStackView.arrangedSubviews.first as? NavigationRailItemView
      XCTAssertNotNil(firstItem)
      XCTAssertEqual(firstItem?.label.numberOfLines, 0)
      XCTAssertEqual(firstItem?.label.font, .systemFont(ofSize: 14))
      XCTAssertEqual(firstItem?.titleColor(for: .normal), .label)
      XCTAssertEqual(firstItem?.titleColor(for: .selected), .label)
      XCTAssertEqual(firstItem?.imageTintColor(for: .normal), .label)
      XCTAssertEqual(firstItem?.imageTintColor(for: .selected), .systemIndigo)
      XCTAssertFalse(firstItem!.hideLabel)
      XCTAssertEqual(firstItem?.badge.backgroundColor?.cgColor, UIColor.systemRed.cgColor)
      XCTAssertEqual(firstItem?.badge.textColor, .white)
      XCTAssertEqual(firstItem?.badge.font, .systemFont(ofSize: 11))
    }
  }

  func testSettingConfigurationValues() {
    if #available(iOS 13, *) {
      // Given
      let navigationRail = NavigationRailView()
      let items = [
        UITabBarItem(title: "Item 1", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 2", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 3", image: UIImage(systemName: "heart"), tag: 100),
        UITabBarItem(title: "Item 4", image: UIImage(systemName: "heart"), tag: 100),
      ]
      navigationRail.items = items

      // When
      let config = NavigationRailConfiguration.railConfiguration()
      config.isMenuButtonVisible = true
      config.isFloatingActionButtonVisible = true
      config.floatingActionButtonTintColor = .green
      config.floatingActionButtonBackgroundColor = .yellow
      config.floatingActionButtonImage = .init(systemName: "heart")!
      config.itemsAlignment = .bottom
      config.itemProperties.titleNumberOflines = 5
      config.itemProperties.titleFont = .systemFont(ofSize: 23)
      config.itemProperties.titleColor = .purple
      config.itemProperties.selectedTitleColor = .brown
      config.itemProperties.tintColor = .green
      config.itemProperties.selectedTintColor = .white
      config.itemProperties.isTitleHidden = true
      config.itemProperties.badgeColor = .blue
      config.itemProperties.badgeTextColor = .red
      config.itemProperties.badgeTextFont = .systemFont(ofSize: 34)
      navigationRail.configuration = config

      // Then
      XCTAssertTrue(navigationRail.isMenuButtonVisible)
      XCTAssertTrue(navigationRail.isFloatingActionButtonVisible)
      XCTAssertEqual(navigationRail.fabButton.tintColor, .green)
      XCTAssertEqual(navigationRail.fabButton.backgroundColor, .yellow)
      XCTAssertEqual(navigationRail.fabButton.image(for: .normal), .init(systemName: "heart"))
      XCTAssertEqual(navigationRail.itemsAlignment, .bottom)
      let firstItem =
        navigationRail.itemsStackView.arrangedSubviews.first as? NavigationRailItemView
      XCTAssertNotNil(firstItem)
      XCTAssertEqual(firstItem?.label.numberOfLines, 5)
      XCTAssertEqual(firstItem?.label.font, .systemFont(ofSize: 23))
      XCTAssertEqual(firstItem?.titleColor(for: .normal), .purple)
      XCTAssertEqual(firstItem?.titleColor(for: .selected), .brown)
      XCTAssertEqual(firstItem?.imageTintColor(for: .normal), .green)
      XCTAssertEqual(firstItem?.imageTintColor(for: .selected), .white)
      XCTAssertTrue(firstItem!.hideLabel)
      XCTAssertEqual(firstItem?.badge.backgroundColor, .blue)
      XCTAssertEqual(firstItem?.badge.textColor, .red)
      XCTAssertEqual(firstItem?.badge.font, .systemFont(ofSize: 34))
    }
  }
}
