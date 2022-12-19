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
import MaterialComponents.MaterialBadges

@available(iOS 13.0, *)
@objc(MDCNavigationRailItemView)
public class NavigationRailItemView: UIControl {

  weak var item: UITabBarItem?

  private let badgeSizeNormal = CGSize(width: 16, height: 16)
  private let badgeCornerRadiusNormal = 8.0
  private let iconSizeDimension = 15.0
  private let itemHeight = 65.0
  private let itemLabelBottomPadding = 4.0
  private let itemViewTitleFontSize = 12.0

  private var titleColors = [UIControl.State.RawValue: UIColor]()

  private var imageTintColors = [UIControl.State.RawValue: UIColor]()

  private var images = [UIControl.State.RawValue: UIImage]()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()

  private let containerView = UIView()

  public let badge: MDCBadgeView = MDCBadgeView()

  public var badgeText: String? {
    didSet {
      badge.isHidden = badgeText == nil
      badge.text = badgeText
    }
  }

  private var _selectionIndicatorSize = CGSize(width: 56, height: 32)
  public var selectionIndicatorSize: CGSize {
    set {
      _selectionIndicatorSize = newValue
    }
    get {
      if hideLabel {
        return CGSize(width: _selectionIndicatorSize.width, height: frame.size.height)
      }
      return _selectionIndicatorSize
    }
  }

  public override var isSelected: Bool {
    didSet {
      guard isSelected != oldValue else { return }
      let state = isSelected ? UIControl.State.selected : .normal
      imageView.image = itemImage(for: state)
      imageView.tintColor = imageTintColor(for: state)
      label.textColor = titleColor(for: state)
    }
  }

  public var hideLabel: Bool {
    didSet {
      label.isHidden = hideLabel
      activeIndicator.frame.size.height = selectionIndicatorSize.height
    }
  }

  public let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var activeIndicator = UIView()

  var labelText: String? {
    didSet {
      guard let labelText = labelText else { return }
      label.text = labelText
      largeContentTitle = labelText
    }
  }

  override init(frame: CGRect) {
    hideLabel = false
    super.init(frame: frame)

    self.translatesAutoresizingMaskIntoConstraints = false
    self.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true

    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: itemViewTitleFontSize)
    activeIndicator.isUserInteractionEnabled = false

    containerView.isUserInteractionEnabled = false
    containerView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(containerView)
    containerView.addSubview(activeIndicator)
    containerView.addSubview(imageView)
    containerView.addSubview(label)
    containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    activeIndicator.alpha = 0

    label.topAnchor.constraint(
      equalTo: activeIndicator.bottomAnchor, constant: itemLabelBottomPadding
    ).isActive = true
    label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.heightAnchor.constraint(equalToConstant: iconSizeDimension).isActive = true
    imageView.centerXAnchor.constraint(equalTo: activeIndicator.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: activeIndicator.centerYAnchor).isActive = true
    containerView.addSubview(badge)

    badge.layer.cornerRadius = badgeCornerRadiusNormal
    badge.translatesAutoresizingMaskIntoConstraints = false

    let badgeOffsetY = -badgeSizeNormal.height / 2
    let badgeOffsetX = -badgeSizeNormal.width / 2
    badge.centerXAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -badgeOffsetX)
      .isActive = true
    badge.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: badgeOffsetY)
      .isActive = true
  }

  convenience init(item: UITabBarItem) {
    self.init(frame: .zero)

    self.item = item
    largeContentImage = item.largeContentSizeImage ?? item.image
    largeContentTitle = item.title
    scalesLargeContentImage = largeContentImage != nil ? true : false
    showsLargeContentViewer = true
    isSelected = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func selectionIndicatorFrame() -> CGRect {
    let x = floor(CGRectGetMidX(bounds))
    return CGRect(
      x: x - selectionIndicatorSize.width * 0.5, y: 0,
      width: selectionIndicatorSize.width,
      height: selectionIndicatorSize.height)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    activeIndicator.frame = selectionIndicatorFrame()
    activeIndicator.layer.cornerRadius =
      min(_selectionIndicatorSize.height, _selectionIndicatorSize.width) / 2
    imageView.frame.size = CGSize(width: containerView.frame.size.width, height: iconSizeDimension)
  }

  func setItemImage(_ image: UIImage?, for state: UIControl.State) {
    images[state.rawValue] = image
    let selectedState = isSelected ? UIControl.State.selected : .normal
    if state == selectedState {
      imageView.image = itemImage(for: state)
    }
  }

  private func itemImage(for state: UIControl.State) -> UIImage? {
    images[state.rawValue]
  }

  func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
    titleColors[state.rawValue] = color
    let selectedState = isSelected ? UIControl.State.selected : .normal
    if state == selectedState {
      label.textColor = titleColor(for: state)
    }
  }

  internal func titleColor(for state: UIControl.State) -> UIColor? {
    return titleColors[state.rawValue]
  }

  func setImageTintColor(_ color: UIColor?, for state: UIControl.State) {
    imageTintColors[state.rawValue] = color
    let selectedState = isSelected ? UIControl.State.selected : .normal
    if state == selectedState {
      imageView.tintColor = imageTintColor(for: state)
    }
  }

  internal func imageTintColor(for state: UIControl.State) -> UIColor? {
    return imageTintColors[state.rawValue]
  }

  func select(isSelected: Bool, animated: Bool = false) {
    guard self.isSelected != isSelected else { return }
    self.isSelected = isSelected

    animateActiveIndicator(selected: isSelected, animated: animated)
  }

  private func animateActiveIndicator(selected: Bool, animated: Bool = true) {
    CATransaction.begin()
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0.2, 0, 0, 1))
    UIView.animate(withDuration: animated ? 0.1 : 0) {
      if selected {
        self.activeIndicator.transform = CGAffineTransformIdentity
        self.activeIndicator.alpha = 1.0
      } else {
        self.activeIndicator.transform = CGAffineTransformMakeScale(0.25, 1)
        self.activeIndicator.alpha = 0
      }
    }
    CATransaction.commit()
  }
}
