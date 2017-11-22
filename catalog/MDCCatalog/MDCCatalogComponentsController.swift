/*
Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import CatalogByConvention
import MaterialCatalog

import MaterialComponents.MaterialFlexibleHeader
import MaterialComponents.MaterialIcons_ic_arrow_back
import MaterialComponents.MaterialInk
import MaterialComponents.MaterialLibraryInfo
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShadowLayer
import MaterialComponents.MaterialThemes
import MaterialComponents.MaterialTypography

import UIKit

class MDCCatalogComponentsController: UICollectionViewController, MDCInkTouchControllerDelegate {

  fileprivate struct Constants {
    static let headerScrollThreshold: CGFloat = 50
    static let inset: CGFloat = 16
    static let logoTitleVerticalSpacing: CGFloat = 32
    static let logoWidthHeight: CGFloat = 40
    static let spacing: CGFloat = 1
  }

  fileprivate lazy var headerViewController = MDCFlexibleHeaderViewController()

  private lazy var inkController: MDCInkTouchController = {
    let controller = MDCInkTouchController(view: self.collectionView!)
    controller.delaysInkSpread = true
    controller.delegate = self
    return controller
  }()

  private lazy var logo: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let node: CBCNode
  private lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
  }()

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

    title = "Material Components for iOS v\(MDCLibraryInfo.versionString)"

    addChildViewController(headerViewController)

    headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    headerViewController.headerView.maximumHeight = 128
    headerViewController.headerView.minimumHeight = 56

    collectionView?.register(MDCCatalogCollectionViewCell.self,
      forCellWithReuseIdentifier: "MDCCatalogCollectionViewCell")
    collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1)

    MDCIcons.ic_arrow_backUseNewStyle(true)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.colorThemeChanged),
      name: NSNotification.Name(rawValue: "ColorThemeChangeNotification"),
      object: nil)
  }

  func colorThemeChanged(notification: NSNotification) {
    let colorScheme = notification.userInfo?["colorScheme"]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.colorScheme = colorScheme as? (MDCColorScheme & NSObjectProtocol)!

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

    inkController.addInkView()

    let containerView = UIView(frame: headerViewController.headerView.bounds)
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    titleLabel.text = title!
    titleLabel.textColor = UIColor(white: 1, alpha: 1)
    titleLabel.font = UIFont.mdc_preferredFont(forMaterialTextStyle: .title)
    if #available(iOS 9.0, *) {
        titleLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: UIFontWeightRegular)
    } else {
        let attribute: [String: UIFontDescriptorSymbolicTraits] =
            [UIFontSymbolicTrait: UIFontDescriptorSymbolicTraits.traitMonoSpace]
        let descriptor: UIFontDescriptor = UIFontDescriptor(fontAttributes: attribute)
        titleLabel.font = UIFont(descriptor: descriptor, size: 14)
    }
    titleLabel.sizeToFit()
    if Constants.inset + titleLabel.frame.size.width > containerView.frame.size.width {
      titleLabel.font = MDCTypography.body2Font()
    }

    let titleInsets = UIEdgeInsets(top: 0,
                                   left: Constants.inset,
                                   bottom: Constants.inset,
                                   right: Constants.inset)
    let titleSize = titleLabel.sizeThatFits(containerView.bounds.size)

    containerView.addSubview(titleLabel)
    constrainLabel(label: titleLabel,
                   containerView: containerView,
                   insets: titleInsets,
                   height: titleSize.height)

    headerViewController.headerView.addSubview(containerView)
    headerViewController.headerView.forwardTouchEvents(for: containerView)

    headerViewController.headerView.addSubview(logo)

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let image = MDCDrawImage(CGRect(x:0,
                                    y:0,
                                    width: Constants.logoWidthHeight,
                                    height: Constants.logoWidthHeight),
                             { MDCCatalogDrawMDCLogoLight($0, $1) },
                             appDelegate.colorScheme)
    logo.image = image

    NSLayoutConstraint(item: logo,
                       attribute: .bottom,
                       relatedBy: .equal,
                       toItem: titleLabel,
                       attribute: .top,
                       multiplier: 1,
                       constant: -1 * Constants.logoTitleVerticalSpacing).isActive = true
    NSLayoutConstraint(item: logo,
                       attribute: .leading,
                       relatedBy: .equal,
                       toItem: titleLabel,
                       attribute: .leading,
                       multiplier: 1,
                       constant: 0).isActive = true

    NSLayoutConstraint(item: logo,
                       attribute: .width,
                       relatedBy: .equal,
                       toItem: logo,
                       attribute: .height,
                       multiplier: 1,
                       constant: 0).isActive = true
    NSLayoutConstraint(item: logo,
                       attribute: .width,
                       relatedBy: .equal,
                       toItem: nil,
                       attribute: .notAnAttribute,
                       multiplier: 1,
                       constant: Constants.logoWidthHeight).isActive = true

    headerViewController.headerView.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    headerViewController.headerView.trackingScrollView = collectionView

    headerViewController.headerView.setShadowLayer(MDCShadowLayer()) { (layer, intensity) in
      let shadowLayer = layer as? MDCShadowLayer
      shadowLayer!.elevation = ShadowElevation(intensity * ShadowElevation.appBar.rawValue)
    }

    view.addSubview(headerViewController.view)
    headerViewController.didMove(toParentViewController: self)

    collectionView?.accessibilityIdentifier = "collectionView"
#if swift(>=3.2)
    if #available(iOS 11.0, *) {
      collectionView?.contentInsetAdjustmentBehavior = .always
    }
#endif
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView?.collectionViewLayout.invalidateLayout()
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func willAnimateRotation(
    to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  override var childViewControllerForStatusBarStyle: UIViewController? {
    return headerViewController
  }

  override var childViewControllerForStatusBarHidden: UIViewController? {
    return headerViewController
  }

#if swift(>=3.2)
  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    // Re-constraint the title label to account for changes in safeAreaInsets's left and right.
    let titleInsets = UIEdgeInsets(top: 0,
                                   left: Constants.inset + view.safeAreaInsets.left,
                                   bottom: Constants.inset,
                                   right: Constants.inset + view.safeAreaInsets.right)
    titleLabel.superview!.removeConstraints(titleLabel.superview!.constraints)
    constrainLabel(label: titleLabel,
                   containerView: titleLabel.superview!,
                   insets: titleInsets,
                   height: titleLabel.bounds.height)
  }
#endif

  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return node.children.count
  }

  func inkViewForView(_ view: UIView) -> MDCInkView {
    let foundInkView = MDCInkView.injectedInkView(for: view)
    foundInkView.inkStyle = .unbounded
    foundInkView.inkColor = UIColor(white:0.957, alpha: 0.2)
    return foundInkView
  }

  // MARK: MDCInkTouchControllerDelegate

  func inkTouchController(_ inkTouchController: MDCInkTouchController,
                          shouldProcessInkTouchesAtTouchLocation location: CGPoint) -> Bool {
    return self.collectionView!.indexPathForItem(at: location) != nil
  }

  func inkTouchController(_ inkTouchController: MDCInkTouchController,
                          inkViewAtTouchLocation location: CGPoint) -> MDCInkView? {
    if let indexPath = self.collectionView!.indexPathForItem(at: location) {
      let cell = self.collectionView!.cellForItem(at: indexPath)
      return inkViewForView(cell!)
    }
    return MDCInkView()
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "MDCCatalogCollectionViewCell",
                                           for: indexPath)
    cell.backgroundColor = UIColor.white

    let componentName = node.children[indexPath.row].title
    if let catalogCell = cell as? MDCCatalogCollectionViewCell {
      catalogCell.populateView(componentName)
    }

    // Ensure that ink animations aren't recycled.
    MDCInkView.injectedInkView(for: view).cancelAllAnimations(animated: false)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    let dividerWidth: CGFloat = 1
    var safeInsets: CGFloat = 0
#if swift(>=3.2)
    if #available(iOS 11, *) {
      safeInsets = view.safeAreaInsets.left + view.safeAreaInsets.right
    }
#endif
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
    self.navigationController?.pushViewController(vc, animated: true)
  }

  // MARK: Private
  func constrainLabel(label: UILabel,
                      containerView: UIView,
                      insets: UIEdgeInsets,
                      height: CGFloat) {
    _ = NSLayoutConstraint(
      item: label,
      attribute: .leading,
      relatedBy: .equal,
      toItem: containerView,
      attribute: .leading,
      multiplier: 1.0,
      constant: insets.left).isActive = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: containerView,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0).isActive = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: containerView,
      attribute: .bottom,
      multiplier: 1.0,
      constant: -insets.bottom).isActive = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: height).isActive = true
  }

  func adjustLogoForScrollView(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    let inset = scrollView.contentInset.top
    let relativeOffset = inset + offset

    logo.alpha = 1 - (relativeOffset / Constants.headerScrollThreshold)
  }
}

// UIScrollViewDelegate
extension MDCCatalogComponentsController {

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidScroll()
      adjustLogoForScrollView(scrollView)
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
