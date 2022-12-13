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
  private let badgeCornerRadiusNormal: CGFloat = 8
  private let iconSizeDimension: CGFloat = 14
  private let itemSpacing: CGFloat = 4
  private let itemViewTitleFontSize: CGFloat = 12
  private let activeIndicatorSizeWithLabel: CGFloat = 32
  private let activeIndicatorSizeWithoutLabel: CGFloat = 56

  private var titleColors = [UIControl.State.RawValue: UIColor]()

  private var imageTintColors = [UIControl.State.RawValue: UIColor]()

  private var images = [UIControl.State.RawValue: UIImage]()

  public override var isSelected: Bool {
    didSet {
      guard isSelected != oldValue else { return }
      let state = isSelected ? UIControl.State.selected : .normal
      imageView.image = itemImage(for: state)
      imageView.tintColor = imageTintColor(for: state)
      label.textColor = titleColor(for: state)
    }
  }

  var hideLabel: Bool {
    didSet {
      label.isHidden = hideLabel
      activeIndicator.frame.size.height = indicatorHeight
    }
  }

  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()

  private var indicatorHeight: CGFloat {
    return hideLabel ? activeIndicatorSizeWithoutLabel : activeIndicatorSizeWithLabel
  }

  let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let badge: MDCBadgeView = MDCBadgeView()

  var badgeText: String? {
    didSet {
      badge.isHidden = badgeText == nil
      badge.text = badgeText
    }
  }

  private lazy var stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = itemSpacing
    stack.alignment = .center
    stack.distribution = .fillProportionally
    stack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stack)
    stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    stack.isUserInteractionEnabled = false
    return stack
  }()

  lazy var activeIndicator: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: indicatorHeight))
    view.layer.cornerRadius = indicatorHeight / 2
    view.center = imageView.center
    view.isUserInteractionEnabled = false
    insertSubview(view, at: 0)
    return view
  }()

  var labelText: String? {
    didSet {
      guard let labelText = labelText else { return }
      label.text = labelText
      largeContentTitle = labelText
    }
  }

  override init(frame: CGRect) {
    hideLabel = false
    super.init(frame: .zero)

    self.translatesAutoresizingMaskIntoConstraints = false
    self.heightAnchor.constraint(equalToConstant: 56).isActive = true

    imageView.heightAnchor.constraint(equalToConstant: iconSizeDimension).isActive = true

    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: itemViewTitleFontSize)

    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(label)

    stackView.addSubview(badge)
    imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    badge.layer.cornerRadius = badgeCornerRadiusNormal
    badge.translatesAutoresizingMaskIntoConstraints = false

    let badgeOffsetY = -badgeSizeNormal.height / 2
    badge.centerXAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
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

  public override func layoutSubviews() {
    super.layoutSubviews()

    guard let item = item else { return }
    labelText = item.title
    setItemImage(item.image, for: .normal)
    setItemImage(item.selectedImage, for: .selected)
    accessibilityValue = item.accessibilityValue
    accessibilityHint = item.accessibilityHint
    isAccessibilityElement = item.isAccessibilityElement
    tag = item.tag
    if let badgeColor = item.badgeColor {
      badge.backgroundColor = badgeColor
    }
    badge.text = item.badgeValue
    badge.isHidden = badge.text == nil
    badge.sizeToFit()
    accessibilityLabel = item.accessibilityLabel
    accessibilityIdentifier = item.accessibilityIdentifier
    activeIndicator.center = imageView.center
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
    if selected {
      UIView.animate(withDuration: animated ? 0.1 : 0) {
        self.activeIndicator.frame = CGRect(
          x: self.imageView.center.x - 28, y: self.imageView.center.y - self.indicatorHeight / 2,
          width: 56, height: self.indicatorHeight)
      }
    } else {
      UIView.animate(withDuration: animated ? 0.0333 : 0) {
        self.activeIndicator.frame = CGRect(
          x: self.imageView.center.x, y: self.imageView.center.y - self.indicatorHeight / 2,
          width: 0,
          height: self.indicatorHeight)
      }
    }
    CATransaction.commit()
  }
}
