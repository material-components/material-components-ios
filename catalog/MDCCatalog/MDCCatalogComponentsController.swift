// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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
import CatalogByConvention
import MaterialCatalog
import MaterialComponents.MaterialFlexibleHeader
import MaterialComponents.MaterialLibraryInfo
import MaterialComponents.MaterialRipple
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShadowLayer
import MaterialComponents.MaterialThemes
import MaterialComponents.MaterialTypography
import MaterialComponents.MaterialIcons_ic_arrow_back

class MDCCatalogComponentsController: UICollectionViewController,
  UICollectionViewDelegateFlowLayout, MDCRippleTouchControllerDelegate
{

  fileprivate struct Constants {
    static let headerScrollThreshold: CGFloat = 30
    static let inset: CGFloat = 16
    static let menuTopVerticalSpacing: CGFloat = 38
    static let logoWidthHeight: CGFloat = 30
    static let menuButtonWidthHeight: CGFloat = 24
    static let spacing: CGFloat = 1
  }

  fileprivate lazy var headerViewController = MDCFlexibleHeaderViewController()

  private lazy var rippleController: MDCRippleTouchController = {
    let controller = MDCRippleTouchController()
    controller.delegate = self
    controller.shouldProcessRippleWithScrollViewGestures = false
    return controller
  }()

  private lazy var logo: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private lazy var menuButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    let dotsImage = MDCIcons.imageFor_ic_more_horiz()?.withRenderingMode(.alwaysTemplate)
    button.setImage(dotsImage, for: .normal)
    button.adjustsImageWhenHighlighted = false
    button.accessibilityLabel = "Menu"
    button.accessibilityHint = "Opens catalog configuration options."
    // Without this compiler version check, the build fails on Xcode versions <11.4 with the error:
    //   "Use of undeclared type 'UIPointerInteractionDelegate'"
    // Ideally, we would be able to tie this to an iOS version rather than a compiler version, but
    // such a solution does not seem to be available for Swift.
    #if compiler(>=5.2)
      if #available(iOS 13.4, *) {
        let interaction = UIPointerInteraction(delegate: self)
        button.addInteraction(interaction)
      }
    #endif
    return button
  }()

  private let node: CBCNode
  private lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.adjustsFontSizeToFitWidth = true
    return titleLabel
  }()

  private var logoLeftPaddingConstraint: NSLayoutConstraint?
  private var menuButtonRightPaddingConstraint: NSLayoutConstraint?
  private var menuTopPaddingConstraint: NSLayoutConstraint?

  init(collectionViewLayout ignoredLayout: UICollectionViewLayout, node: CBCNode) {
    self.node = node

    let layout = UICollectionViewFlowLayout()
    let sectionInset: CGFloat = Constants.spacing
    layout.sectionInset = UIEdgeInsets(
      top: sectionInset,
      left: sectionInset,
      bottom: sectionInset,
      right: sectionInset)
    layout.minimumInteritemSpacing = Constants.spacing
    layout.minimumLineSpacing = Constants.spacing

    super.init(collectionViewLayout: layout)

    title = "Material Components for iOS"

    addChild(headerViewController)

    headerViewController.isTopLayoutGuideAdjustmentEnabled = true
    headerViewController.inferTopSafeAreaInsetFromViewController = true
    headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    headerViewController.headerView.maximumHeight = 128
    headerViewController.headerView.minimumHeight = 56

    collectionView?.register(
      MDCCatalogCollectionViewCell.self,
      forCellWithReuseIdentifier: "MDCCatalogCollectionViewCell")
    collectionView?.backgroundColor = AppTheme.containerScheme.colorScheme.backgroundColor

    MDCIcons.ic_arrow_backUseNewStyle(true)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.themeDidChange),
      name: AppTheme.didChangeGlobalThemeNotificationName,
      object: nil)
  }

  @objc func themeDidChange(notification: NSNotification) {
    let colorScheme = AppTheme.containerScheme.colorScheme
    headerViewController.headerView.backgroundColor = colorScheme.primaryColor
    setNeedsStatusBarAppearanceUpdate()

    titleLabel.textColor = colorScheme.onPrimaryColor
    menuButton.tintColor = colorScheme.onPrimaryColor
    collectionView?.collectionViewLayout.invalidateLayout()
    collectionView?.reloadData()
  }

  convenience init(node: CBCNode) {
    self.init(collectionViewLayout: UICollectionViewLayout(), node: node)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    rippleController.addRipple(to: self.collectionView!)

    let containerView = UIView(frame: headerViewController.headerView.bounds)
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    titleLabel.text = title!
    titleLabel.textColor = AppTheme.containerScheme.colorScheme.onPrimaryColor
    titleLabel.textAlignment = .center
    titleLabel.font = AppTheme.containerScheme.typographyScheme.headline6
    titleLabel.sizeToFit()

    let titleInsets = UIEdgeInsets(
      top: 0,
      left: Constants.inset,
      bottom: Constants.inset,
      right: Constants.inset)
    let titleSize = titleLabel.sizeThatFits(containerView.bounds.size)

    containerView.addSubview(titleLabel)

    headerViewController.headerView.addSubview(containerView)
    headerViewController.headerView.forwardTouchEvents(for: containerView)

    containerView.addSubview(logo)

    let colorScheme = AppTheme.containerScheme.colorScheme

    let image = MDCDrawImage(
      CGRect(
        x: 0,
        y: 0,
        width: Constants.logoWidthHeight,
        height: Constants.logoWidthHeight),
      { MDCCatalogDrawMDCLogoLight($0, $1) },
      colorScheme)
    logo.image = image

    menuButton.addTarget(
      self.navigationController,
      action: #selector(navigationController?.presentMenu),
      for: .touchUpInside)
    menuButton.tintColor = colorScheme.onPrimaryColor
    containerView.addSubview(menuButton)

    setupFlexibleHeaderContentConstraints()
    constrainLabel(
      label: titleLabel,
      containerView: containerView,
      insets: titleInsets,
      height: titleSize.height)

    headerViewController.headerView.backgroundColor = colorScheme.primaryColor

    headerViewController.headerView.trackingScrollView = collectionView

    headerViewController.headerView.setShadowLayer(MDCShadowLayer()) { (layer, intensity) in
      let shadowLayer = layer as? MDCShadowLayer
      CATransaction.begin()
      CATransaction.setDisableActions(true)
      shadowLayer!.elevation = ShadowElevation(intensity * ShadowElevation.appBar.rawValue)
      CATransaction.commit()
    }

    view.addSubview(headerViewController.view)
    headerViewController.didMove(toParent: self)

    collectionView?.accessibilityIdentifier = "componentList"
    if #available(iOS 11.0, *) {
      collectionView?.contentInsetAdjustmentBehavior = .always
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView?.collectionViewLayout.invalidateLayout()
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func willAnimateRotation(
    to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval
  ) {
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  override var childForStatusBarStyle: UIViewController? {
    return headerViewController
  }

  override var childForStatusBarHidden: UIViewController? {
    return headerViewController
  }

  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    // Re-constraint the title label to account for changes in safeAreaInsets's left and right.
    logoLeftPaddingConstraint?.constant = Constants.inset + view.safeAreaInsets.left
    menuButtonRightPaddingConstraint?.constant = -1 * (Constants.inset + view.safeAreaInsets.right)
    menuTopPaddingConstraint?.constant = Constants.inset + view.safeAreaInsets.top
  }

  func setupFlexibleHeaderContentConstraints() {

    logoLeftPaddingConstraint = NSLayoutConstraint(
      item: logo,
      attribute: .leading,
      relatedBy: .equal,
      toItem: logo.superview,
      attribute: .leading,
      multiplier: 1,
      constant: Constants.inset)
    logoLeftPaddingConstraint?.isActive = true

    menuButtonRightPaddingConstraint = NSLayoutConstraint(
      item: menuButton,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: menuButton.superview,
      attribute: .trailing,
      multiplier: 1,
      constant: -1 * Constants.inset)
    menuButtonRightPaddingConstraint?.isActive = true

    menuTopPaddingConstraint = NSLayoutConstraint(
      item: menuButton,
      attribute: .top,
      relatedBy: .equal,
      toItem: menuButton.superview,
      attribute: .top,
      multiplier: 1,
      constant: Constants.menuTopVerticalSpacing)
    menuTopPaddingConstraint?.isActive = true

    NSLayoutConstraint(
      item: logo,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: menuButton,
      attribute: .centerY,
      multiplier: 1,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: logo,
      attribute: .width,
      relatedBy: .equal,
      toItem: logo,
      attribute: .height,
      multiplier: 1,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: logo,
      attribute: .width,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1,
      constant: Constants.logoWidthHeight
    ).isActive = true

    NSLayoutConstraint(
      item: menuButton,
      attribute: .width,
      relatedBy: .equal,
      toItem: menuButton,
      attribute: .height,
      multiplier: 1,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: menuButton,
      attribute: .width,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1,
      constant: Constants.menuButtonWidthHeight
    ).isActive = true
  }

  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return node.children.count
  }

  // MARK: MDCRippleTouchControllerDelegate

  func rippleTouchController(
    _ rippleTouchController: MDCRippleTouchController,
    shouldProcessRippleTouchesAtTouchLocation location: CGPoint
  ) -> Bool {
    return self.collectionView?.indexPathForItem(at: location) != nil
  }

  func rippleTouchController(
    _ rippleTouchController: MDCRippleTouchController,
    rippleViewAtTouchLocation location: CGPoint
  ) -> MDCRippleView? {
    if let indexPath = self.collectionView?.indexPathForItem(at: location) {
      let cell = self.collectionView?.cellForItem(at: indexPath)
      return MDCRippleView.injectedRippleView(for: cell!)
    }
    return MDCRippleView()
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: "MDCCatalogCollectionViewCell",
        for: indexPath)
    cell.backgroundColor = AppTheme.containerScheme.colorScheme.backgroundColor

    let componentName = node.children[indexPath.row].title
    if let catalogCell = cell as? MDCCatalogCollectionViewCell {
      catalogCell.populateView(componentName)
    }

    // Ensure that ripple animations aren't recycled.
    MDCRippleView.injectedRippleView(for: view).cancelAllRipples(animated: false, completion: nil)

    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let dividerWidth: CGFloat = 1
    var safeInsets: CGFloat = 0
    if #available(iOS 11, *) {
      safeInsets = view.safeAreaInsets.left + view.safeAreaInsets.right
    }
    var cellWidthHeight: CGFloat

    // iPhones have 2 columns in portrait and 3 in landscape
    if UI_USER_INTERFACE_IDIOM() == .phone {
      cellWidthHeight = (view.frame.size.width - 3 * dividerWidth - safeInsets) / 2
      if view.frame.size.width > view.frame.size.height {
        cellWidthHeight = (view.frame.size.width - 4 * dividerWidth - safeInsets) / 3
      }
    } else {
      // iPads have 4 columns
      cellWidthHeight = (view.frame.size.width - 5 * dividerWidth - safeInsets) / 4
    }
    return CGSize(width: cellWidthHeight, height: cellWidthHeight)
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let node = self.node.children[indexPath.row]
    var vc: UIViewController
    if node.isExample() {
      vc = node.createExampleViewController()
    } else {
      vc = MDCNodeListViewController(node: node)
    }
    self.navigationController?.setMenuBarButton(for: vc)
    self.navigationController?.pushViewController(vc, animated: true)
  }

  // MARK: Private
  func constrainLabel(
    label: UILabel,
    containerView: UIView,
    insets: UIEdgeInsets,
    height: CGFloat
  ) {

    NSLayoutConstraint(
      item: label,
      attribute: .leading,
      relatedBy: .equal,
      toItem: logo,
      attribute: .trailing,
      multiplier: 1.0,
      constant: insets.left
    ).isActive = true

    NSLayoutConstraint(
      item: label,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: menuButton,
      attribute: .leading,
      multiplier: 1.0,
      constant: -insets.right
    ).isActive = true

    NSLayoutConstraint(
      item: label,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: containerView,
      attribute: .bottom,
      multiplier: 1.0,
      constant: -insets.bottom
    ).isActive = true

    NSLayoutConstraint(
      item: label,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: height
    ).isActive = true
  }
}

// Without this compiler version check, the build fails on Xcode versions <11.4 with the error:
//   "Use of undeclared type 'UIPointerInteractionDelegate'"
// Ideally, we would be able to tie this to an iOS version rather than a compiler version, but such
// a solution does not seem to be available for Swift.
#if compiler(>=5.2)
  @available(iOS 13.4, *)
  extension MDCCatalogComponentsController: UIPointerInteractionDelegate {
    @available(iOS 13.4, *)
    func pointerInteraction(
      _ interaction: UIPointerInteraction,
      styleFor region: UIPointerRegion
    ) -> UIPointerStyle? {
      guard let interactionView = interaction.view else {
        return nil
      }
      let targetedPreview = UITargetedPreview(view: interactionView)
      let pointerStyle = UIPointerStyle(effect: .highlight(targetedPreview))
      return pointerStyle
    }
  }
#endif

// UIScrollViewDelegate
extension MDCCatalogComponentsController {

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidScroll()
    }
  }

  override func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool
  ) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }

  override func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(
        withVelocity: velocity,
        targetContentOffset: targetContentOffset)
    }
  }

}
