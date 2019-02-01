// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

import MDFTextAccessibility
import MaterialComponents.MaterialIcons_ic_check
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialThemes
import MaterialComponentsBeta.MaterialContainerScheme
import MaterialComponents.MaterialList
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialSlider
import MaterialComponents.MaterialSlider_ColorThemer
import MaterialComponentsBeta.MaterialButtons_Theming
import UIKit

private func schemeWithPalette(_ palette: MDCPalette) -> MDCContainerScheming {
  let containerScheme = DefaultContainerScheme()

  let scheme = MDCSemanticColorScheme()
  scheme.primaryColor = palette.tint500
  scheme.primaryColorVariant = palette.tint900
  scheme.secondaryColor = scheme.primaryColor
  if let onPrimaryColor = MDFTextAccessibility.textColor(fromChoices: [MDCPalette.grey.tint100,
                                                                       MDCPalette.grey.tint900,
                                                                       UIColor.black,
                                                                       UIColor.white],
                                                         onBackgroundColor: scheme.primaryColor,
                                                         options: .preferLighter) {
    scheme.onPrimaryColor = onPrimaryColor
  }
  if let onSecondaryColor = MDFTextAccessibility.textColor(fromChoices: [MDCPalette.grey.tint100,
                                                                         MDCPalette.grey.tint900,
                                                                         UIColor.black,
                                                                         UIColor.white],
                                                           onBackgroundColor: scheme.secondaryColor,
                                                           options: .preferLighter) {
    scheme.onSecondaryColor = onSecondaryColor
  }
  containerScheme.colorScheme = scheme

  return containerScheme
}

private struct MDCColorThemeCellConfiguration {
  let name: String
  let mainColor: UIColor
  let scheme: MDCContainerScheming

  init(name: String, mainColor: UIColor, scheme: MDCContainerScheming) {
    self.name = name
    self.mainColor = mainColor
    self.scheme = scheme
  }
}

class MDCThemePickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  let titleColor = AppTheme.globalTheme.colorScheme.onSurfaceColor.withAlphaComponent(0.5)
  let titleFont = AppTheme.globalTheme.typographyScheme.button

  private let tableView = UITableView()

  private let cellReuseIdentifier = "cell"
  private let cellHeight: CGFloat = 48 // Minimum touch target

  private let properties: [String] = [
    "primaryColor",
    "primaryColorVariant",
    "secondaryColor",
    "errorColor",
    "surfaceColor",
    "backgroundColor",
    "onPrimaryColor",
    "onSecondaryColor",
    "onSurfaceColor",
    "onBackgroundColor",
    ]


  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Material Color scheme picker"

    view.backgroundColor = AppTheme.globalTheme.colorScheme.backgroundColor
    tableView.register(SchemeCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorColor = .clear
    view.addSubview(tableView)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    positionTableView()
  }

  func positionTableView() {
    var originX = view.bounds.origin.x
    var width = view.bounds.size.width
    var height = view.bounds.size.height
    if #available(iOS 11.0, *) {
      originX += view.safeAreaInsets.left;
      width -= (view.safeAreaInsets.left + view.safeAreaInsets.right);
      height -= (view.safeAreaInsets.top + view.safeAreaInsets.bottom);
    }
    let frame = CGRect(x: originX, y: view.bounds.origin.y, width: width, height: height)
    tableView.frame = frame
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return properties.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SchemeCell =
      tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? SchemeCell ??
        SchemeCell(frame: .zero)
    cell.title = properties[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showDialog(for: indexPath.row)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }

  private func showDialog(for propertyIndex: Int) {
    print("Change \(properties[propertyIndex])")
    let colorSchemeDialog = ColorSchemeDialog(nibName: nil, bundle: nil)
    colorSchemeDialog.property = properties[propertyIndex]
    present(colorSchemeDialog, animated: true, completion: nil)
  }
}

class SchemeCell : UITableViewCell {

  public var title: String {
    willSet {
      set(title: newValue)
    }
  }

  private let label = UILabel()

  lazy var leadingConstraint = NSLayoutConstraint(item: self.label,
                                             attribute: .leading,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .leading,
                                             multiplier: 1,
                                             constant: 16)

  lazy var trailingContraint = NSLayoutConstraint(item: self.label,
                                                  attribute: .trailing,
                                                  relatedBy: .equal,
                                                  toItem: self.contentView,
                                                  attribute: .trailing,
                                                  multiplier: 1,
                                                  constant: -16)

  lazy var topContraint = NSLayoutConstraint(item: self.label,
                                             attribute: .top,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .top,
                                             multiplier: 1,
                                             constant: 0)

  lazy var bottomContraint = NSLayoutConstraint(item: self.label,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .bottom,
                                             multiplier: 1,
                                             constant: 0)


  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    title = ""
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    self.accessibilityHint = "Changes the catalog color scheme."
    self.accessibilityLabel = title
    self.contentView.addSubview(label)
    self.label.translatesAutoresizingMaskIntoConstraints = false
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    leadingConstraint.isActive = true
    trailingContraint.isActive = true
    topContraint.isActive = true
    bottomContraint.isActive = true
  }

  private func set(title newTitle: String) {
    label.text = newTitle
    self.accessibilityLabel = newTitle
  }
}

class ColorSchemeDialog : UIViewController {

  public var property: String = ""
  static let propertiesDictionary: [String: UIColor] = [
    "primaryColor": AppTheme.globalTheme.colorScheme.primaryColor,
    "primaryColorVariant": AppTheme.globalTheme.colorScheme.primaryColorVariant,
    "secondaryColor": AppTheme.globalTheme.colorScheme.secondaryColor,
    "errorColor": AppTheme.globalTheme.colorScheme.errorColor,
    "surfaceColor": AppTheme.globalTheme.colorScheme.surfaceColor,
    "backgroundColor": AppTheme.globalTheme.colorScheme.backgroundColor,
    "onPrimaryColor": AppTheme.globalTheme.colorScheme.onPrimaryColor,
    "onSecondaryColor": AppTheme.globalTheme.colorScheme.onSecondaryColor,
    "onSurfaceColor": AppTheme.globalTheme.colorScheme.onSurfaceColor,
    "onBackgroundColor": AppTheme.globalTheme.colorScheme.onBackgroundColor,
    ]

  var color: UIColor? = nil
  private let transitionController = MDCDialogTransitionController()
  fileprivate lazy var alertView: MDCDialogThemePickerView = {
    self.view as? MDCDialogThemePickerView ?? MDCDialogThemePickerView(frame: .zero)
  }()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
    super.transitioningDelegate = self.transitionController
    super.modalPresentationStyle = .custom
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    self.view = MDCDialogThemePickerView(frame: .zero)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    color = ColorSchemeDialog.propertiesDictionary[property]
    self.alertView.color = color
    self.alertView.submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    let size = alertView.sizeThatFits(self.view.bounds.size)
    self.alertView.bounds = CGRect(origin: .zero, size: size)
    self.alertView.center = view.center
    if let presentation = self.presentationController as? MDCDialogPresentationController {
      guard presentation.containerView?.subviews.count ?? 0 > 2 else { return }
      if let trackingView = presentation.containerView?.subviews[1] {
        trackingView.bounds = self.alertView.bounds
        trackingView.center = self.alertView.center
      }
    }
  }

  @objc private func submit() {
    
    self.dismiss(animated: true, completion: nil)
  }
}

fileprivate class MDCDialogThemePickerView: UIView {

  private enum Slider {
    case red, green, blue
  }

  private let redLeadingButton = MDCButton(frame: .zero)
  private let redSlider = MDCSlider(frame: .zero)
  private let redTrailingButton = MDCButton(frame: .zero)
  private let greenLeadingButton = MDCButton(frame: .zero)
  private let greenSlider = MDCSlider(frame: .zero)
  private let greenTrailingButton = MDCButton(frame: .zero)
  private let blueLeadingButton = MDCButton(frame: .zero)
  private let blueSlider = MDCSlider(frame: .zero)
  private let blueTrailingButton = MDCButton(frame: .zero)
  let submitButton = MDCButton(frame: .zero)
  let paletteView = UIView(frame: .zero)
  private let dialogMaxDimension: CGFloat = 560

  public var color: UIColor? = nil {
    didSet {
      self.paletteView.backgroundColor = color
    }

    willSet {
      if color == nil {
        guard let value = newValue else { return }
        setupValues(value)
      }
    }
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let width = min(size.width - 48, dialogMaxDimension)
    let height = min(size.height - 96, dialogMaxDimension)
    return CGSize(width: width, height: height)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup(button: redLeadingButton, with: "R")
    redLeadingButton.addTarget(self, action: #selector(decrementRed), for: .touchUpInside)
    setup(button: greenLeadingButton, with: "G")
    greenLeadingButton.addTarget(self, action: #selector(decrementGreen), for: .touchUpInside)
    setup(button: blueLeadingButton, with: "B")
    blueLeadingButton.addTarget(self, action: #selector(decrementBlue), for: .touchUpInside)
    let redValue = 127
    let blueValue = 127
    let greenValue = 127
    setup(slider: redSlider, with: redValue)
    redSlider.addTarget(self, action: #selector(updateRedSlider), for: .valueChanged)
    setup(slider: greenSlider, with: greenValue)
    greenSlider.addTarget(self, action: #selector(updateGreenSlider), for: .valueChanged)
    setup(slider: blueSlider, with: blueValue)
    blueSlider.addTarget(self, action: #selector(updateBlueSlider), for: .valueChanged)
    setup(button: redTrailingButton)
    redTrailingButton.addTarget(self, action: #selector(incrementRed), for: .touchUpInside)
    setup(button: greenTrailingButton)
    greenTrailingButton.addTarget(self, action: #selector(incrementGreen), for: .touchUpInside)
    setup(button: blueTrailingButton)
    blueTrailingButton.addTarget(self, action: #selector(incrementBlue), for: .touchUpInside)
    addSubview(paletteView)
    setupSubmitButton()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let halfHeight = frame.height / 2
    backgroundColor = AppTheme.globalTheme.colorScheme.surfaceColor
    paletteView.frame = CGRect(origin: .zero, size: CGSize(width: frame.width,
                                                           height: halfHeight))
    let verticalPadding: CGFloat = 56
    let horizontalPadding: CGFloat = 28
    redLeadingButton.center = CGPoint (x: horizontalPadding, y: halfHeight + verticalPadding * 1)
    greenLeadingButton.center = CGPoint (x: horizontalPadding, y: halfHeight + verticalPadding * 2)
    blueLeadingButton.center = CGPoint (x: horizontalPadding, y: halfHeight + verticalPadding * 3)
    redSlider.frame = CGRect(x: 56, y: halfHeight + verticalPadding * 1 - 24,
                             width: frame.width - 104, height: 48)
    greenSlider.frame = CGRect(x: 56, y: halfHeight + verticalPadding * 2 - 24,
                               width: frame.width - 104, height: 48)
    blueSlider.frame = CGRect(x: 56, y: halfHeight + verticalPadding * 3 - 24,
                              width: frame.width - 104, height: 48)
    redTrailingButton.center = CGPoint(x: frame.width - redTrailingButton.frame.width,
                                       y: halfHeight + verticalPadding * 1)
    greenTrailingButton.center = CGPoint(x: frame.width - greenTrailingButton.frame.width,
                                       y: halfHeight + verticalPadding * 2)
    blueTrailingButton.center = CGPoint(x: frame.width - blueTrailingButton.frame.width,
                                       y: halfHeight + verticalPadding * 3)
    let xPosition = frame.width - (submitButton.frame.width + 12)
    let yPosition = frame.height - (submitButton.frame.height + 12)
    submitButton.frame = CGRect(x: xPosition,
                                y: yPosition,
                                width: submitButton.frame.width,
                                height: submitButton.frame.height)
  }

  private func setup(slider: MDCSlider, with value: Int) {
    slider.maximumValue = 255
    slider.minimumValue = 0
    slider.value = CGFloat(value)
    MDCSliderColorThemer.applySemanticColorScheme(AppTheme.globalTheme.colorScheme, to: slider)
    addSubview(slider)
  }

  private func setup(button: MDCButton, with title: String = "999") {
    button.setTitle(title, for: .normal)
    button.setTitleFont(AppTheme.globalTheme.typographyScheme.button, for: .normal)
    button.applyTextTheme(withScheme: AppTheme.globalTheme.containerScheme)
    button.contentEdgeInsets = .zero
    button.sizeToFit()
    button.frame.size.height = 48
    addSubview(button)
  }

  private func setupSubmitButton() {
    submitButton.setTitle("Submit", for: .normal)
    submitButton.setTitleFont(AppTheme.globalTheme.typographyScheme.button, for: .normal)
    submitButton.applyTextTheme(withScheme: AppTheme.globalTheme.containerScheme)
    submitButton.sizeToFit()
    addSubview(submitButton)
  }

  @objc private func updateRedSlider() {
    let value = redSlider.value
    guard let color = self.color else { return }
    let components = getColorComponents(color)
    self.color = UIColor(red: value / 255, green: components.green, blue: components.blue, alpha: 1)
    redTrailingButton.setTitle("\(Int(redSlider.value))", for: .normal)
  }

  @objc private func updateGreenSlider() {
    let value = greenSlider.value
    guard let color = self.color else { return }
    let components = getColorComponents(color)
    self.color = UIColor(red: components.red, green: value / 255, blue: components.blue, alpha: 1)
    greenTrailingButton.setTitle("\(Int(greenSlider.value))", for: .normal)
  }

  @objc private func updateBlueSlider() {
    let value = blueSlider.value
    guard let color = self.color else { return }
    let components = getColorComponents(color)
    self.color = UIColor(red: components.red, green: components.green, blue: value / 255, alpha: 1)
    blueTrailingButton.setTitle("\(Int(blueSlider.value))", for: .normal)
  }

  @objc private func incrementRed() {
    redSlider.value += 1
    redTrailingButton.setTitle("\(Int(redSlider.value))", for: .normal)
    updateRedSlider()
  }

  @objc private func incrementGreen() {
    greenSlider.value += 1
    greenTrailingButton.setTitle("\(Int(greenSlider.value))", for: .normal)
    updateGreenSlider()
  }

  @objc private func incrementBlue() {
    blueSlider.value += 1
    blueTrailingButton.setTitle("\(Int(blueSlider.value))", for: .normal)
    updateBlueSlider()
  }

  @objc private func decrementRed() {
    redSlider.value -= 1
    redTrailingButton.setTitle("\(Int(redSlider.value))", for: .normal)
    updateRedSlider()
  }

  @objc private func decrementGreen() {
    greenSlider.value -= 1
    greenTrailingButton.setTitle("\(Int(greenSlider.value))", for: .normal)
    updateGreenSlider()
  }

  @objc private func decrementBlue() {
    blueSlider.value += 1
    blueTrailingButton.setTitle("\(Int(blueSlider.value))", for: .normal)
    updateBlueSlider()
  }

  private func setupValues(_ color: UIColor) {
    let colorComponents = getColorComponents(color)
    redSlider.value = colorComponents.red * 255
    greenSlider.value = colorComponents.green * 255
    blueSlider.value = colorComponents.blue * 255
    redTrailingButton.setTitle("\(Int(colorComponents.red * 255))", for: .normal)
    greenTrailingButton.setTitle("\(Int(colorComponents.green * 255))", for: .normal)
    blueTrailingButton.setTitle("\(Int(colorComponents.blue * 255))", for: .normal)
  }

  private func getColorComponents(_ color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    color.getRed(&red, green: &green, blue: &blue, alpha: nil)
    return (red: red, green: green, blue: blue)
  }
}
