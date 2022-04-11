// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialShadow
import MaterialComponents.MaterialContainerScheme

/// Typical use-case for a view with Material Shadows at a fixed elevation.
private final class ShadowedView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.cornerRadius = 4
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) is unavailable")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    MDCConfigureShadow(
      for: self, shadow: MDCShadowsCollectionDefault().shadow(forElevation: 1),
      color: MDCShadowColor())
  }
}

/// Typical use-case for a shaped view with Material Shadows.
final class ShapedView: UIView {
  let shapeLayer = CAShapeLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(shapeLayer)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) is unavailable")
  }

  override var backgroundColor: UIColor? {
    get {
      guard let color = shapeLayer.fillColor else { return nil }
      return UIColor(cgColor: color)
    }
    set {
      shapeLayer.fillColor = newValue?.cgColor
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    guard let path = polygonPath(bounds: self.bounds, numSides: 3, numPoints: 3) else { return }
    shapeLayer.path = path

    MDCConfigureShadow(
      for: self, shadow: MDCShadowsCollectionDefault().shadow(forElevation: 1),
      color: MDCShadowColor(),
      path: path)
  }
}

/// More complex use-case for a view with a custom shape which animates.
final class AnimatedShapedView: UIView {
  let shapeLayer = CAShapeLayer()
  let firstNumSides = 3
  let lastNumSides = 12
  let animationStepDuration: CFTimeInterval = 0.6

  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(shapeLayer)
    updatePathAndAnimations()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) is unavailable")
  }

  override var backgroundColor: UIColor? {
    get {
      guard let color = shapeLayer.fillColor else { return nil }
      return UIColor(cgColor: color)
    }
    set {
      shapeLayer.fillColor = newValue?.cgColor
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    updatePathAndAnimations()
  }

  private func updatePathAndAnimations() {
    guard
      let startPath = polygonPath(
        bounds: bounds, numSides: firstNumSides, numPoints: lastNumSides)
    else { return }
    shapeLayer.path = startPath
    MDCConfigureShadow(
      for: self, shadow: MDCShadowsCollectionDefault().shadow(forElevation: 1),
      color: MDCShadowColor(),
      path: startPath)

    var polygonPaths = (firstNumSides...lastNumSides).map {
      polygonPath(bounds: bounds, numSides: $0, numPoints: lastNumSides)
    }
    polygonPaths.shuffle()
    var beginTime: CFTimeInterval = 0
    var pathAnimations: [CAAnimation] = []
    var shadowPathAnimations: [CAAnimation] = []
    for (i, polygonPath) in polygonPaths.enumerated() {
      let fromValue = i == 0 ? polygonPaths[polygonPaths.count - 1] : polygonPaths[i - 1]
      let toValue = polygonPath
      let pathAnimation = CABasicAnimation(keyPath: "path")
      pathAnimation.fromValue = fromValue
      pathAnimation.toValue = toValue
      pathAnimation.beginTime = beginTime
      pathAnimation.duration = animationStepDuration
      pathAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      pathAnimations.append(pathAnimation)
      let shadowPathAnimation = pathAnimation.copy() as! CABasicAnimation
      shadowPathAnimation.keyPath = "shadowPath"
      shadowPathAnimations.append(shadowPathAnimation)
      beginTime += animationStepDuration
    }

    let pathAnimationGroup = CAAnimationGroup()
    pathAnimationGroup.animations = pathAnimations
    pathAnimationGroup.duration = animationStepDuration * CFTimeInterval(pathAnimations.count)
    pathAnimationGroup.repeatCount = .greatestFiniteMagnitude
    shapeLayer.add(pathAnimationGroup, forKey: "path")

    let shadowPathAnimationGroup = CAAnimationGroup()
    shadowPathAnimationGroup.animations = shadowPathAnimations
    shadowPathAnimationGroup.duration =
      animationStepDuration * CFTimeInterval(pathAnimations.count)
    shadowPathAnimationGroup.repeatCount = .greatestFiniteMagnitude
    layer.add(shadowPathAnimationGroup, forKey: "shadowPath")
  }
}

/// Returns a regular polygon within `bounds` having `numSides` sides.
///
/// If `numSides` < 3 or `numPoints` < `numSides`, returns nil.
///
/// If `numPoints` > `numSides`, the polygon will invisibly repeat
/// points along the vertices to ensure it has `numPoints` points.
/// This allows smooth animations between multiple polygons with
/// differing number of sides.
func polygonPath(bounds: CGRect, numSides: Int, numPoints: Int) -> CGPath? {
  guard numSides > 2 else { return nil }
  guard numPoints >= numSides else { return nil }
  let xRadius = bounds.width / 2
  let yRadius = bounds.height / 2
  let path = UIBezierPath()
  for pointIdx in 0..<numPoints {
    // Map pointIdx to a float in the range [0, 1].
    let pointProgress = CGFloat(pointIdx) / CGFloat(numPoints - 1)
    // Choose the closest vertex of the polygon.
    let sideIdx = round(pointProgress * CGFloat(numSides - 1))
    let theta = CGFloat(2) * CGFloat.pi / CGFloat(numSides) * sideIdx
    let x = bounds.midX + xRadius * cos(theta)
    let y = bounds.midY + yRadius * sin(theta)
    let point = CGPoint(x: x, y: y)
    if pointIdx == 0 {
      path.move(to: point)
    } else if pointIdx < numPoints {
      path.addLine(to: point)
    }
  }
  path.close()
  return path.cgPath
}

@available(iOS 12.0, *)
final class ShadowTypicalUseExample: UIViewController {
  enum ExampleType: Int {
    case typical, shaped, animated
  }

  private typealias Example = (label: String, type: ExampleType)
  private let examples: [Example] = [
    ("Typical", .typical),
    ("Shaped", .shaped),
    ("Animated", .animated),
  ]

  private let containerScheme = MDCContainerScheme()

  private lazy var typicalView: UIView = {
    let result = ShadowedView()
    result.translatesAutoresizingMaskIntoConstraints = false
    result.backgroundColor = containerScheme.colorScheme.primaryColor
    return result
  }()

  private lazy var shapedView: UIView = {
    let result = ShapedView()
    result.translatesAutoresizingMaskIntoConstraints = false
    result.backgroundColor = containerScheme.colorScheme.primaryColor
    return result
  }()

  private lazy var animatedView: UIView = {
    let result = AnimatedShapedView()
    result.translatesAutoresizingMaskIntoConstraints = false
    result.backgroundColor = containerScheme.colorScheme.primaryColor
    return result
  }()

  private lazy var typeControl: UISegmentedControl = {
    let result = UISegmentedControl(items: examples.map { $0.label })
    result.backgroundColor = containerScheme.colorScheme.primaryColor
    result.translatesAutoresizingMaskIntoConstraints = false
    if #available(iOS 13, *) {
      result.selectedSegmentTintColor = containerScheme.colorScheme.surfaceColor
    }
    result.setTitleTextAttributes(
      [
        .foregroundColor: containerScheme.colorScheme.onPrimaryColor
      ],
      for: .normal)
    result.setTitleTextAttributes(
      [
        .foregroundColor: containerScheme.colorScheme.onSurfaceColor
      ],
      for: .selected)
    result.selectedSegmentIndex = 0
    return result
  }()

  private let topSpacerLayoutGuide = UILayoutGuide()
  private let contentLayoutGuide = UILayoutGuide()
  private let bottomSpacerLayoutGuide = UILayoutGuide()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    view.addSubview(typicalView)
    view.addSubview(shapedView)
    view.addSubview(animatedView)
    view.addLayoutGuide(topSpacerLayoutGuide)
    view.addLayoutGuide(contentLayoutGuide)
    view.addLayoutGuide(bottomSpacerLayoutGuide)
    view.addSubview(typeControl)
    updateExampleType()
    typeControl.addTarget(self, action: #selector(updateExampleType), for: .valueChanged)
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      // Top spacer.
      topSpacerLayoutGuide.topAnchor.constraint(
        equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1),
      topSpacerLayoutGuide.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
      topSpacerLayoutGuide.bottomAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),

      // Content.
      contentLayoutGuide.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      contentLayoutGuide.widthAnchor.constraint(equalTo: contentLayoutGuide.heightAnchor),
      contentLayoutGuide.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
      contentLayoutGuide.widthAnchor.constraint(
        lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor, constant: -40),

      typicalView.centerXAnchor.constraint(equalTo: contentLayoutGuide.centerXAnchor),
      typicalView.centerYAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
      typicalView.widthAnchor.constraint(equalTo: contentLayoutGuide.widthAnchor),
      typicalView.heightAnchor.constraint(equalTo: contentLayoutGuide.heightAnchor),

      shapedView.centerXAnchor.constraint(equalTo: contentLayoutGuide.centerXAnchor),
      shapedView.centerYAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
      shapedView.widthAnchor.constraint(equalTo: contentLayoutGuide.widthAnchor),
      shapedView.heightAnchor.constraint(equalTo: contentLayoutGuide.heightAnchor),

      animatedView.centerXAnchor.constraint(equalTo: contentLayoutGuide.centerXAnchor),
      animatedView.centerYAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
      animatedView.widthAnchor.constraint(equalTo: contentLayoutGuide.widthAnchor),
      animatedView.heightAnchor.constraint(equalTo: contentLayoutGuide.heightAnchor),

      // Bottom spacer.
      bottomSpacerLayoutGuide.topAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),

      // Ensure the top spacer and bottom spacer both have the same height (to center the content).
      bottomSpacerLayoutGuide.heightAnchor.constraint(equalTo: topSpacerLayoutGuide.heightAnchor),

      // Segmented type control.
      typeControl.topAnchor.constraint(
        equalToSystemSpacingBelow: bottomSpacerLayoutGuide.bottomAnchor,
        multiplier: 1),
      typeControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      typeControl.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor),

      safeAreaLayoutGuide.bottomAnchor.constraint(
        equalToSystemSpacingBelow: typeControl.bottomAnchor, multiplier: 1),
    ])
  }

  @objc func updateExampleType() {
    guard let exampleType = ExampleType(rawValue: typeControl.selectedSegmentIndex) else { return }
    switch exampleType {
    case .typical:
      typicalView.isHidden = false
      shapedView.isHidden = true
      animatedView.isHidden = true
    case .shaped:
      typicalView.isHidden = true
      shapedView.isHidden = false
      animatedView.isHidden = true
    case .animated:
      typicalView.isHidden = true
      shapedView.isHidden = true
      animatedView.isHidden = false
    }
  }
}

// MARK: Catalog by Convensions
@available(iOS 12.0, *)
extension ShadowTypicalUseExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Shadow", "New Shadow"],
      "primaryDemo": true,
      "presentable": false,
    ]
  }

  @objc class func minimumOSVersion() -> OperatingSystemVersion {
    return OperatingSystemVersion(majorVersion: 12, minorVersion: 0, patchVersion: 0)
  }
}
