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

import Combine
import UIKit
import MaterialComponents.MaterialRipple

@available(iOS 13.0, *)
@objc(MDCNavigationRailItemAlignment)
/// The vertical alignment in which the rail items should be placed.
public enum NavigationRailItemAlignment: Int {
  case top = 0
  case center
  case bottom
}

@available(iOS 13.0, *)
@objc(MDCNavigationRailConfiguration)
/// A configuration that specifies the appearance and behavior of a navigation rail and its contents.
public class NavigationRailConfiguration: NSObject {

  @available(*, unavailable)
  override init() {
    fatalError()
  }

  private init(
    itemProperties: ItemProperties, isMenuButtonVisible: Bool, isFloatingActionButtonVisible: Bool,
    floatingActionButtonBackgroundColor: UIColor,
    floatingActionButtonImage: UIImage, floatingActionButtonTintColor: UIColor,
    floatingActionButtonRippleColor: UIColor, itemsAlignment: NavigationRailItemAlignment
  ) {
    self.itemProperties = itemProperties
    self.isMenuButtonVisible = isMenuButtonVisible
    self.isFloatingActionButtonVisible = isFloatingActionButtonVisible
    self.floatingActionButtonBackgroundColor = floatingActionButtonBackgroundColor
    self.floatingActionButtonImage = floatingActionButtonImage
    self.floatingActionButtonTintColor = floatingActionButtonTintColor
    self.floatingActionButtonRippleColor = floatingActionButtonRippleColor
    self.itemsAlignment = itemsAlignment
  }

  /// Properties for configuring each of the rail's items.
  @objc(MDCNavigationRailItemProperties) public class ItemProperties: NSObject {

    @available(*, unavailable)
    override init() {
      fatalError()
    }

    internal init(
      titleNumberOfLines: Int, titleFont: UIFont, titleColor: UIColor, selectedTitleColor: UIColor,
      tintColor: UIColor, selectedTintColor: UIColor, isTitleHidden: Bool, badgeColor: UIColor,
      badgeTextColor: UIColor, badgeTextFont: UIFont, activeIndicatorColor: UIColor
    ) {
      self.titleNumberOflines = titleNumberOfLines
      self.titleFont = titleFont
      self.titleColor = titleColor
      self.selectedTitleColor = selectedTitleColor
      self.tintColor = tintColor
      self.selectedTintColor = selectedTintColor
      self.isTitleHidden = isTitleHidden
      self.badgeColor = badgeColor
      self.badgeTextColor = badgeTextColor
      self.badgeTextFont = badgeTextFont
      self.activeIndicatorColor = activeIndicatorColor
    }

    /// number of lines for the rail's item's title.
    @objc public var titleNumberOflines: Int
    /// The font of the rail's item's title.
    @objc public var titleFont: UIFont
    /// The color of the rail's item's title.
    @objc public var titleColor: UIColor
    /// The color of the rail's item's title when selected.
    @objc public var selectedTitleColor: UIColor
    /// The tint color of the rail's item.
    @objc public var tintColor: UIColor
    /// The tint color of the rail's item when selected.
    @objc public var selectedTintColor: UIColor
    /// Indicates if the rail's item's title should be hidden (and only an image is visible).
    @objc public var isTitleHidden: Bool
    /// The badge color of the rail's item.
    @objc public var badgeColor: UIColor
    /// The badge text color of the rail's item.
    @objc public var badgeTextColor: UIColor
    /// The badge text font of the rail's item.
    @objc public var badgeTextFont: UIFont
    /// The color of the active indicator of the rail's item.
    @objc public var activeIndicatorColor: UIColor
  }

  /// Properties for configuring each of the rail's items.
  @objc public var itemProperties: ItemProperties
  /// Indicates if the top menu button is visible.
  @objc public var isMenuButtonVisible: Bool
  /// Indicates if the floating action button is visible.
  @objc public var isFloatingActionButtonVisible: Bool
  /// The background color of the floating action button.
  @objc public var floatingActionButtonBackgroundColor: UIColor
  /// The icon image of the floating action button.
  @objc public var floatingActionButtonImage: UIImage
  /// The tint color of the floating action button.
  @objc public var floatingActionButtonTintColor: UIColor
  /// The ripple color of the floating action button.
  @objc public var floatingActionButtonRippleColor: UIColor
  /// The navigation rail's item alignment.
  @objc public var itemsAlignment: NavigationRailItemAlignment

  /// Creates a default configuration for a navigation rail with graceful defaults.
  /// - Returns: A new rail configuration object.
  @objc public static func railConfiguration() -> NavigationRailConfiguration {
    let itemProperties = ItemProperties(
      titleNumberOfLines: 0,
      titleFont: .systemFont(ofSize: 14),
      titleColor: .label,
      selectedTitleColor: .label,
      tintColor: .label,
      selectedTintColor: .systemIndigo,
      isTitleHidden: false,
      badgeColor: .systemRed,
      badgeTextColor: .white,
      badgeTextFont: .systemFont(ofSize: 11),
      activeIndicatorColor: .cyan)
    return NavigationRailConfiguration(
      itemProperties: itemProperties,
      isMenuButtonVisible: false,
      isFloatingActionButtonVisible: false,
      floatingActionButtonBackgroundColor: .cyan,
      floatingActionButtonImage: .init(systemName: "pencil") ?? .init(),
      floatingActionButtonTintColor: .label,
      floatingActionButtonRippleColor: .black.withAlphaComponent(0.15),
      itemsAlignment: .center)
  }
}

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

@available(iOS 13.0, *)
@objc(MDCNavigationRailView)
/// The Navigation rail provides access to primary destinations in your app on iPad devices.

/// NavigationRailView is a view that encapsulates items in a rail going from top to bottom used for
/// primary navigation for iPads.
///
/// Typically, you use navigation rails  in conjunction with a NavigationRailViewController object,
/// but you can also use them as standalone controls in your app.
/// Navigation rails always appear across the leading edge of the screen and display
/// the contents of one or more UITabBarItem objects.
/// A rail's item's appearance can be customized using the NavigationRailConfiguration to suit the
/// needs of your interface. Tapping an item selects and highlights that item, and you use the
/// selection of the item to enable the corresponding mode for your app.
public class NavigationRailView: UIView {

  /// The navigation rail’s delegate object.
  ///
  /// Use the delegate to track the selection of rail items. The default value of this property is nil.
  @objc public weak var delegate: NavigationRailViewDelegate?

  /// The rail's styling configuration. Defaults to nil. When nil, graceful defaults are applied.
  @objc public var configuration: NavigationRailConfiguration? = nil {
    didSet {
      applyDefaultConfiguration(configuration: configuration)
    }
  }

  /// The items displayed by the navigation rail.
  ///
  /// This property contains an array of UITabBarItem objects, each of which corresponds
  /// to an item displayed by the navigation rail.
  /// The order of the items in this property corresponds to the order of the items onscreen.
  /// You can use this property to access the items as needed.
  @objc public var items: [UITabBarItem]? {
    didSet {
      guard items != oldValue else {
        return
      }
      for view in itemsStackView.arrangedSubviews.filter({ $0 is NavigationRailItemView }) {
        view.removeFromSuperview()
      }

      cancellables.forEach { $0.cancel() }
      items?.forEach { item in
        let itemView = NavigationRailItemView(item: item)
        itemView.hideLabel = isTextHidden
        itemView.addTarget(self, action: #selector(itemTapped(sender:)), for: .touchUpInside)
        itemsStackView.addArrangedSubview(itemView)
        publisherAndSinkWithSetNeedsLayout(for: \.title, tabBarItem: item) {
          itemView.labelText = $0
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.image, tabBarItem: item) {
          itemView.setItemImage($0, for: .normal)
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.selectedImage, tabBarItem: item) {
          itemView.setItemImage($0, for: .selected)
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.badgeColor, tabBarItem: item) {
          itemView.badge.backgroundColor = $0
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.badgeValue, tabBarItem: item) {
          itemView.badgeText = $0
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.accessibilityLabel, tabBarItem: item) {
          itemView.accessibilityLabel = $0
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.accessibilityValue, tabBarItem: item) {
          itemView.accessibilityValue = $0
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.accessibilityHint, tabBarItem: item) {
          itemView.accessibilityHint = $0
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.accessibilityIdentifier, tabBarItem: item) {
          itemView.accessibilityIdentifier = $0
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.isAccessibilityElement, tabBarItem: item) {
          itemView.isAccessibilityElement = $0
        }.store(in: &cancellables)
        publisherAndSinkWithSetNeedsLayout(for: \.tag, tabBarItem: item) {
          itemView.tag = $0
        }.store(in: &cancellables)
      }
      self.selectedItem = nil
      applyDefaultConfiguration(configuration: self.configuration)
    }
  }

  private var _selectedItem: UITabBarItem? = nil
  /// The currently selected item on the navigation rail.
  /// Use this property to get the currently selected item.
  /// If you change the value of this property, the navigation rail selects the corresponding item and
  /// updates the navigation rail’s appearance accordingly. Set the property to nil to clear the selection.
  @objc public var selectedItem: UITabBarItem? {
    set {
      selectItem(newValue)
    }
    get {
      _selectedItem
    }
  }

  private var cancellables = [AnyCancellable]()

  var isTextHidden = false {
    didSet {
      guard isTextHidden != oldValue else {
        return
      }
      itemsStackView.arrangedSubviews.forEach {
        if let itemView = $0 as? NavigationRailItemView {
          itemView.hideLabel = isTextHidden
        }
      }
    }
  }

  var isMenuButtonVisible = false {
    didSet {
      guard isMenuButtonVisible != oldValue else {
        return
      }
      menuButton.isHidden = !isMenuButtonVisible
    }
  }

  var isFloatingActionButtonVisible = false {
    didSet {
      guard isFloatingActionButtonVisible != oldValue else {
        return
      }
      fabButton.isHidden = !isFloatingActionButtonVisible
    }
  }

  var itemsAlignment: NavigationRailItemAlignment = .center {
    didSet {
      guard oldValue != itemsAlignment else {
        return
      }
      itemStackViewAlignmentConstraints.forEach { $0.isActive = false }
      itemStackViewAlignmentConstraints.removeAll()

      switch itemsAlignment {
      case .top:
        itemStackViewAlignmentConstraints.append(
          itemsStackView.topAnchor.constraint(
            equalTo: topButtonsStackView.bottomAnchor, constant: 45))
      case .center:
        itemStackViewAlignmentConstraints.append(
          itemsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
      case .bottom:
        itemStackViewAlignmentConstraints.append(
          itemsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -45))
      }
      itemStackViewAlignmentConstraints.forEach { $0.isActive = true }
    }
  }

  lazy private var menuButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "sidebar.leading"), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button.widthAnchor.constraint(equalToConstant: 44).isActive = true
    button.isHidden = true
    button.addTarget(self, action: #selector(didTapMenuButton(sender:)), for: .touchUpInside)
    topButtonsStackView.insertArrangedSubview(button, at: 0)
    return button
  }()

  private var buttonRippleTouchController: MDCRippleTouchController?
  lazy internal var fabButton: UIButton = {
    let button = UIButton()
    button.heightAnchor.constraint(equalToConstant: 56).isActive = true
    button.widthAnchor.constraint(equalToConstant: 56).isActive = true
    button.layer.cornerRadius = 16
    button.clipsToBounds = true
    button.isHidden = true
    button.addTarget(self, action: #selector(didTapFABButton(sender:)), for: .touchUpInside)
    buttonRippleTouchController = MDCRippleTouchController(view: button)
    topButtonsStackView.addArrangedSubview(button)
    return button
  }()

  lazy private var topButtonsStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 22.0
    stack.alignment = .center
    stack.distribution = .fillProportionally
    stack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stack)
    stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 38).isActive = true  // 38
    stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    return stack
  }()

  lazy internal var itemsStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 12.0
    stack.alignment = .center
    stack.distribution = .fillProportionally
    stack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stack)
    stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    itemStackViewAlignmentConstraints.append(
      stack.centerYAnchor.constraint(equalTo: self.centerYAnchor))
    itemStackViewAlignmentConstraints.forEach { $0.isActive = true }
    return stack
  }()

  private var itemStackViewAlignmentConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    itemsStackView.arrangedSubviews.forEach { $0.setNeedsLayout() }
  }

  private func applyDefaultConfiguration(configuration: NavigationRailConfiguration?) {
    let configuration = configuration ?? NavigationRailConfiguration.railConfiguration()
    isMenuButtonVisible = configuration.isMenuButtonVisible
    isFloatingActionButtonVisible = configuration.isFloatingActionButtonVisible
    fabButton.tintColor = configuration.floatingActionButtonTintColor
    fabButton.backgroundColor = configuration.floatingActionButtonBackgroundColor
    fabButton.setImage(configuration.floatingActionButtonImage, for: .normal)
    itemsAlignment = configuration.itemsAlignment

    itemsStackView.arrangedSubviews.forEach {
      if let itemView = $0 as? NavigationRailItemView {
        let itemProperties = configuration.itemProperties
        itemView.label.numberOfLines = itemProperties.titleNumberOflines
        itemView.label.font = itemProperties.titleFont
        itemView.setTitleColor(itemProperties.titleColor, for: .normal)
        itemView.setTitleColor(itemProperties.selectedTitleColor, for: .selected)
        itemView.setImageTintColor(itemProperties.tintColor, for: .normal)
        itemView.setImageTintColor(itemProperties.selectedTintColor, for: .selected)
        itemView.hideLabel = itemProperties.isTitleHidden
        itemView.badge.backgroundColor = itemProperties.badgeColor
        itemView.badge.textColor = itemProperties.badgeTextColor
        itemView.badge.font = itemProperties.badgeTextFont
        itemView.activeIndicator.backgroundColor = itemProperties.activeIndicatorColor
      }
    }
    setNeedsLayout()
  }

  private func publisherAndSinkWithSetNeedsLayout<Value>(
    for keyPath: KeyPath<UITabBarItem, Value>, tabBarItem: UITabBarItem,
    sink: @escaping (Value) -> Void
  ) -> AnyCancellable {
    tabBarItem.publisher(for: keyPath).sink { [weak self] value in
      sink(value)
      self?.setNeedsLayout()
    }
  }

  @objc private func itemTapped(sender: UIControl) {
    itemsStackView.arrangedSubviews.forEach {
      if sender == $0 {
        if let itemView = $0 as? NavigationRailItemView, let item = itemView.item {
          let shouldSelectItem = self.delegate?.navigationRail?(self, shouldSelect: item) ?? true
          if shouldSelectItem {
            selectItem(item, animated: true)
            self.delegate?.navigationRail?(self, didSelect: selectedItem!)
          }
        }
      }
    }
  }

  private func selectItem(_ item: UITabBarItem?, animated: Bool = false) {
    _selectedItem = item
    itemsStackView.arrangedSubviews.forEach {
      if let itemView = $0 as? NavigationRailItemView {
        itemView.select(isSelected: selectedItem == itemView.item, animated: animated)
      }
    }
  }

  @objc private func didTapMenuButton(sender: UIButton) {
    self.delegate?.navigationRail?(self, didTapMenuButton: sender)
  }

  @objc private func didTapFABButton(sender: UIButton) {
    self.delegate?.navigationRail?(self, didTapFloatingActionButton: sender)
  }
}
