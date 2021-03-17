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

  private let node: CBCNode

  init(collectionViewLayout ignoredLayout: UICollectionViewLayout, node: CBCNode) {
    self.node = node

    let layout = UICollectionViewFlowLayout()
    let sectionInset: CGFloat = Constants.spacing
    layout.sectionInset = UIEdgeInsets(top: sectionInset,
                                       left: sectionInset,
                                       bottom: sectionInset,
                                       right: sectionInset)
    layout.minimumInteritemSpacing = Constants.spacing
    layout.minimumLineSpacing = Constants.spacing

    super.init(collectionViewLayout: layout)

    title = "Material Components for iOS"

    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithDefaultBackground()
      appearance.titleTextAttributes[.foregroundColor] = UIColor.black
      appearance.largeTitleTextAttributes[.foregroundColor] = UIColor.clear
      navigationItem.standardAppearance = appearance

      let scrollEdgeAppearance = UINavigationBarAppearance()
      scrollEdgeAppearance.configureWithTransparentBackground()
      scrollEdgeAppearance.titleTextAttributes[.foregroundColor] = UIColor.black
      scrollEdgeAppearance.largeTitleTextAttributes[.foregroundColor] = UIColor.clear
      navigationItem.scrollEdgeAppearance = scrollEdgeAppearance

      navigationItem.largeTitleDisplayMode = .always

      let image = MDCDrawImage(CGRect(x:0,
                                      y:0,
                                      width: Constants.logoWidthHeight,
                                      height: Constants.logoWidthHeight),
                               { frame, _ in MDCCatalogDrawMDCLogoLight(frame, nil) },
                               nil)
      logo.image = image
      navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)
    }

    addChild(headerViewController)

    headerViewController.isTopLayoutGuideAdjustmentEnabled = true
    headerViewController.inferTopSafeAreaInsetFromViewController = true
    headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    headerViewController.headerView.maximumHeight = 128
    headerViewController.headerView.minimumHeight = 44

    collectionView?.register(MDCCatalogCollectionViewCell.self,
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

    headerViewController.headerView.addSubview(containerView)
    headerViewController.headerView.forwardTouchEvents(for: containerView)

    let imageView = UIImageView(image: UIImage(named: "amsterdam-kadoelen")!)
    imageView.frame = headerViewController.headerView.bounds
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    headerViewController.headerView.addSubview(imageView)

    let colorScheme = AppTheme.containerScheme.colorScheme

    let dotsImage = MDCIcons.imageFor_ic_more_horiz()?.withRenderingMode(.alwaysTemplate)

    navigationItem.rightBarButtonItem = UIBarButtonItem(image: dotsImage,
                                                        style: .plain,
                                                        target: navigationController,
                                                        action: #selector(navigationController?.presentMenu))
    navigationItem.rightBarButtonItem?.accessibilityLabel = "Menu"
    navigationItem.rightBarButtonItem?.accessibilityHint = "Opens catalog configuration options."

    // TODO: This needs to change as the header collapses.
    navigationItem.rightBarButtonItem?.tintColor = .white

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

    collectionView?.accessibilityIdentifier = "collectionView"
    if #available(iOS 11.0, *) {
      collectionView?.contentInsetAdjustmentBehavior = .always
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  override func willAnimateRotation(
    to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  override var childForStatusBarStyle: UIViewController? {
    return headerViewController
  }

  override var childForStatusBarHidden: UIViewController? {
    return headerViewController
  }

  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
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

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =
      collectionView.dequeueReusableCell(withReuseIdentifier: "MDCCatalogCollectionViewCell",
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

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
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

  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
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
}

// Without this compiler version check, the build fails on Xcode versions <11.4 with the error:
//   "Use of undeclared type 'UIPointerInteractionDelegate'"
// Ideally, we would be able to tie this to an iOS version rather than a compiler version, but such
// a solution does not seem to be available for Swift.
#if compiler(>=5.2)
@available(iOS 13.4, *)
extension MDCCatalogComponentsController: UIPointerInteractionDelegate {
  @available(iOS 13.4, *)
  func pointerInteraction(_ interaction: UIPointerInteraction,
                          styleFor region: UIPointerRegion) -> UIPointerStyle? {
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
      willDecelerate decelerate: Bool) {
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
      targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(
        withVelocity: velocity,
        targetContentOffset: targetContentOffset)
    }
  }

}
