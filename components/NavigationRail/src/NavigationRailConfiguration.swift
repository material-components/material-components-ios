import UIKit

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
