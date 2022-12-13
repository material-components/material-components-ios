import UIKit
import MaterialComponents.MaterialBadges_Appearance 

@available(iOS 13.0, *)
@objc(MDCNavigationRailConfiguration)
/// A configuration that specifies the appearance and behavior of a navigation rail and its contents.
public class NavigationRailConfiguration: NSObject {

  @available(*, unavailable)
  override init() {
    fatalError()
  }

  private init(
    itemProperties: ItemProperties,
    isMenuButtonVisible: Bool,
    isFloatingActionButtonVisible: Bool,
    floatingActionButtonImage: UIImage,
    itemsAlignment: NavigationRailItemAlignment
  ) {
    self.itemProperties = itemProperties
    self.isMenuButtonVisible = isMenuButtonVisible
    self.isFloatingActionButtonVisible = isFloatingActionButtonVisible
    self.floatingActionButtonImage = floatingActionButtonImage
    self.itemsAlignment = itemsAlignment
  }

  /// Properties for configuring each of the rail's items.
  @objc(MDCNavigationRailItemProperties) public class ItemProperties: NSObject {

    @available(*, unavailable)
    override init() {
      fatalError()
    }

    internal init(
      titleNumberOfLines: Int,
      titleFont: UIFont,
      titleColor: UIColor,
      selectedTitleColor: UIColor,
      tintColor: UIColor,
      selectedTintColor: UIColor,
      isTitleHidden: Bool,
      badgeAppearance: MDCBadgeAppearance,
      selectionIndicatorColor: UIColor
    ) {
      self.titleNumberOflines = titleNumberOfLines
      self.titleFont = titleFont
      self.titleColor = titleColor
      self.selectedTitleColor = selectedTitleColor
      self.tintColor = tintColor
      self.selectedTintColor = selectedTintColor
      self.isTitleHidden = isTitleHidden
      self.badgeAppearance = badgeAppearance
      self.selectionIndicatorColor = selectionIndicatorColor
    }

    /// The badge appearance of the rail's item.
    @objc public var badgeAppearance: MDCBadgeAppearance
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
    /// The color of the active indicator of the rail's item.
    @objc public var selectionIndicatorColor: UIColor
  }

  /// Properties for configuring each of the rail's items.
  @objc public var itemProperties: ItemProperties
  /// Indicates if the top menu button is visible.
  @objc public var isMenuButtonVisible: Bool
  /// Indicates if the floating action button is visible.
  @objc public var isFloatingActionButtonVisible: Bool
  /// The icon image of the floating action button.
  @objc public var floatingActionButtonImage: UIImage
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
      badgeAppearance: MDCBadgeAppearance(),
      selectionIndicatorColor: .cyan)
    return NavigationRailConfiguration(
      itemProperties: itemProperties,
      isMenuButtonVisible: false,
      isFloatingActionButtonVisible: false,
      floatingActionButtonImage: .init(systemName: "pencil") ?? .init(),
      itemsAlignment: .center)
  }
}

extension NavigationRailConfiguration: NSCopying {
  public func copy(with zone: NSZone? = nil) -> Any {
    var copy = NavigationRailConfiguration.railConfiguration()
    copy.isMenuButtonVisible = isMenuButtonVisible
    copy.isFloatingActionButtonVisible = isFloatingActionButtonVisible
    copy.floatingActionButtonImage = floatingActionButtonImage
    copy.itemsAlignment = itemsAlignment
    if let copyItemProperties = itemProperties.copy() as? NavigationRailConfiguration.ItemProperties
    {
      copy.itemProperties = copyItemProperties
    }
    return copy
  }
}

extension NavigationRailConfiguration.ItemProperties: NSCopying {
  public func copy(with zone: NSZone? = nil) -> Any {
    let copy = NavigationRailConfiguration.ItemProperties(
      titleNumberOfLines: titleNumberOflines,
      titleFont: titleFont,
      titleColor: titleColor,
      selectedTitleColor: selectedTitleColor,
      tintColor: tintColor,
      selectedTintColor: selectedTintColor,
      isTitleHidden: isTitleHidden,
      badgeAppearance: badgeAppearance,
      selectionIndicatorColor: selectionIndicatorColor)
    return copy
  }
}
