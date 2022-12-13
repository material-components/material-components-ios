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
import MaterialComponents.MaterialBadges_Appearance 
import MaterialComponents.MaterialM3CButton

@available(iOS 13.0, *)
@objc(MDCNavigationRailItemAlignment)
/// The vertical alignment in which the rail items should be placed.
public enum NavigationRailItemAlignment: Int {
  case top = 0
  case center
  case bottom
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

  /// The rail's menu button. Default to have no functionality.
  public var menuButton = M3CButton()

  /// The rail's FAB button. Default to have no functionality.
  public var fabButton = M3CButton()

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

  private var lastLargeContentViewerItem: UILargeContentViewerItem? = nil

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
    // Menu button initialization.
    menuButton.setImage(UIImage(systemName: "sidebar.leading"), for: .normal)
    menuButton.isHidden = true
    menuButton.addTarget(self, action: #selector(didTapMenuButton(sender:)), for: .touchUpInside)
    topButtonsStackView.insertArrangedSubview(menuButton, at: 0)

    // FAB initialization.
    fabButton.isHidden = true
    fabButton.addTarget(self, action: #selector(didTapFABButton(sender:)), for: .touchUpInside)
    topButtonsStackView.addArrangedSubview(fabButton)

    self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addInteraction(UILargeContentViewerInteraction(delegate: self))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    itemsStackView.arrangedSubviews.forEach { $0.setNeedsLayout() }
  }

  ///  Returns the navigation rail view associated with the specific item.
  /// - Parameter item: The UITabBarItem associated to the generated item view.
  /// - Returns: The item's view.
  @objc(viewForItem:) public func view(for item: UITabBarItem) -> UIView? {
    itemsStackView.arrangedSubviews.first {
      ($0 as? NavigationRailItemView) != nil && ($0 as! NavigationRailItemView).item == item
    }
  }

  private func applyDefaultConfiguration(configuration: NavigationRailConfiguration?) {
    let configuration = configuration ?? NavigationRailConfiguration.railConfiguration()
    isMenuButtonVisible = configuration.isMenuButtonVisible
    isFloatingActionButtonVisible = configuration.isFloatingActionButtonVisible
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
        itemView.badge.appearance = itemProperties.badgeAppearance
        itemView.activeIndicator.backgroundColor = itemProperties.selectionIndicatorColor
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

#if !os(tvOS)
  @available(iOS 13.0, *)
  extension NavigationRailView: UILargeContentViewerInteractionDelegate {
    public func largeContentViewerInteraction(
      _ interaction: UILargeContentViewerInteraction, didEndOn item: UILargeContentViewerItem?,
      at point: CGPoint
    ) {
      lastLargeContentViewerItem = nil
    }

    public func largeContentViewerInteraction(
      _ interaction: UILargeContentViewerInteraction, itemAt point: CGPoint
    ) -> UILargeContentViewerItem? {

      if !self.bounds.contains(point) {
        lastLargeContentViewerItem = nil
        return nil
      }

      for subview in itemsStackView.subviews {
        let bounds = subview.convert(subview.bounds, to: self.coordinateSpace)
        if bounds.contains(point) {
          lastLargeContentViewerItem = subview
        }
      }
      return lastLargeContentViewerItem
    }
  }
#endif
