import UIKit

/// M3CTextField is a container view that provides a pre-configured layout for a text field, its
/// accessory icons, and its associated labels.
@available(iOS 13.0, *)
public final class M3CTextField: UIView, M3CTextInput {
  @objc public var isInErrorState = false {
    didSet {
      if isInErrorState != oldValue {
        applyAllColors()
      }
    }
  }

  private var controlState: UIControl.State {
    if isInErrorState {
      return .error
    } else if textContainer.isFirstResponder {
      return .selected
    } else {
      return .normal
    }
  }

  private var backgroundColors: [UIControl.State: UIColor] = [:]
  private var borderColors: [UIControl.State: UIColor] = [:]
  private var inputColors: [UIControl.State: UIColor] = [:]
  private var supportingLabelColors: [UIControl.State: UIColor] = [:]
  private var titleLabelColors: [UIControl.State: UIColor] = [:]
  private var trailingLabelColors: [UIControl.State: UIColor] = [:]
  private var tintColors: [UIControl.State: UIColor] = [:]

  @objc public lazy var textContainer: UITextField = {
    let textField = M3CInsetTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.adjustsFontForContentSizeCategory = true
    textField.font = UIFont.systemFont(ofSize: 17)
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 10.0

    // `clearButton` replaces the system default clear button.
    // Since the custom clear button must be set as `rightView`, the system button must be hidden.
    textField.clearButtonMode = .never

    // When firstResponder status changes, apply all colors associated with the resulting
    // UIControlState.
    textField.firstResponderChangeHandler = { [weak self] in
      self?.applyAllColors()
    }

    return textField
  }()

  /// Proxy property for the underlying text field's `delegate` property.
  @objc public var delegate: UITextFieldDelegate? {
    get {
      return textContainer.delegate
    }
    set {
      textContainer.delegate = newValue
    }
  }

  /// A custom clear button with a sensible default value.
  ///
  /// As of iOS 17.0, a custom clear button is required to meet accessibility requirements.
  /// A minimum contrast ratio of 3:1 is required.
  @objc public lazy var clearButton: UIButton? = buildDefaultClearButton()

  /// Proxy property for the underlying text field's `leftView` property.
  @objc public var leftView: UIView? {
    get {
      return textContainer.leftView
    }
    set {
      textContainer.leftView = newValue
    }
  }

  /// Proxy property for the underlying text field's `rightView` property.
  @objc public var rightView: UIView? {
    get {
      return textContainer.rightView
    }
    set {
      textContainer.rightView = newValue
    }
  }

  /// Proxy property for the underlying text field's `placeholder` property.
  @objc public var placeholder: String? {
    get {
      return textContainer.placeholder
    }
    set {
      textContainer.placeholder = newValue
    }
  }

  /// Proxy property for the underlying text field's `text` property.
  @objc public var text: String? {
    get {
      return textContainer.text
    }
    set {
      textContainer.text = newValue
    }
  }

  @objc public lazy var titleLabel: UILabel = buildLabel()

  @objc public lazy var supportingLabel: UILabel = buildLabel()

  @objc public lazy var trailingLabel: UILabel = buildLabel()

  /// Initializes a `M3CTextField` with a supporting label, title label, and trailing label.
  public init() {
    super.init(frame: .zero)

    textContainer.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)

    configureStackViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Sets the background color for a specific UIControlState.
  @objc(setBackgroundColor:forState:)
  public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
    backgroundColors[state] = color
  }

  /// Sets the border color for a specific UIControlState.
  @objc(setBorderColor:forState:)
  public func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
    borderColors[state] = color
  }

  /// Sets the input color for a specific UIControlState.
  @objc(setInputColor:forState:)
  public func setInputColor(_ color: UIColor?, for state: UIControl.State) {
    inputColors[state] = color
  }

  /// Sets the supporting label color for a specific UIControlState.
  @objc(setSupportingLabelColor:forState:)
  public func setSupportingLabelColor(_ color: UIColor?, for state: UIControl.State) {
    supportingLabelColors[state] = color
  }

  /// Sets the tint color for a specific UIControlState.
  @objc(setTintColor:forState:)
  public func setTintColor(_ color: UIColor?, for state: UIControl.State) {
    tintColors[state] = color
  }

  /// Sets the title label color for a specific UIControlState.
  @objc(setTitleLabelColor:forState:)
  public func setTitleLabelColor(_ color: UIColor?, for state: UIControl.State) {
    titleLabelColors[state] = color
  }

  /// Sets the trailing label color for a specific UIControlState.
  @objc(setTrailingLabelColor:forState:)
  public func setTrailingLabelColor(_ color: UIColor?, for state: UIControl.State) {
    trailingLabelColors[state] = color
  }
}

// MARK: M3CTextField Custom Clear Button

@available(iOS 13.0, *)
extension M3CTextField {
  /// Updates the appearance of the button used to clear text from the text field.
  ///
  /// Note: This method only needs to be called when `clearButton`'s appearance should differ
  /// from the provided default.
  ///
  /// - Parameters:
  ///   - symbolConfiguration: The SymbolConfiguration used to determine the button icon's size.
  ///   - tintColor: The UIColor used to determine the button icon's color. The default value
  ///   matches the system default color.
  @objc(configureClearButtonWithSymbolConfiguration:tintColor:)
  public func configureClearButton(
    symbolConfiguration: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(
      font: UIFont.systemFont(ofSize: 21, weight: .light)
    ),
    tintColor: UIColor = .systemGray3
  ) {
    let button = buildClearButton(
      symbolConfiguration: symbolConfiguration,
      tintColor: tintColor
    )
    clearButton = button
  }

  private func buildClearButton(
    symbolConfiguration: UIImage.SymbolConfiguration,
    tintColor: UIColor
  ) -> UIButton {
    let button = UIButton()
    button.adjustsImageSizeForAccessibilityContentSizeCategory = true
    button.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)

    let clearIcon = UIImage(
      systemName: "xmark.circle.fill", withConfiguration: symbolConfiguration)?
      .withTintColor(tintColor)
      .withRenderingMode(.alwaysOriginal)

    button.contentMode = .scaleAspectFit
    button.setImage(clearIcon, for: .normal)
    button.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)

    button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 9)

    return button
  }

  private func buildDefaultClearButton() -> UIButton {
    let font = UIFont.systemFont(ofSize: 21, weight: .light)
    let configuration = UIImage.SymbolConfiguration(font: font)

    return buildClearButton(
      symbolConfiguration: configuration,
      tintColor: .systemGray3
    )
  }

  @objc private func didTapClearButton(sender: UIButton) {
    textContainer.text = ""

    textContainer.sendActions(for: .editingChanged)
  }
}

// MARK: M3CTextField Color Configuration

@available(iOS 13.0, *)
extension M3CTextField {
  /// Applies colors for border, background, labels, tint, and text, based on the current state.
  @objc public func applyAllColors() {
    applyColors(for: controlState)
  }

  /// Applies border color based on the current state.
  ///
  /// This is necessary when transitioning between Light Mode and Dark Mode, because
  /// `layer.borderColor` is a CGColor.
  private func applyBorderColor() {
    textContainer.layer.borderColor = borderColor(for: controlState)?.cgColor
  }

  private func applyColors(for state: UIControl.State) {
    textContainer.backgroundColor = backgroundColor(for: state)
    textContainer.layer.borderColor = borderColor(for: state)?.cgColor
    textContainer.tintColor = tintColor(for: state)
    textContainer.textColor = inputColor(for: state)

    titleLabel.textColor = titleLabelColor(for: state)
    supportingLabel.textColor = supportingLabelColor(for: state)
    trailingLabel.textColor = trailingLabelColor(for: state)
  }

  private func borderColor(for state: UIControl.State) -> UIColor? {
    borderColors[state] ?? borderColors[.normal]
  }

  private func backgroundColor(for state: UIControl.State) -> UIColor? {
    backgroundColors[state] ?? backgroundColors[.normal]
  }

  private func inputColor(for state: UIControl.State) -> UIColor? {
    inputColors[state] ?? inputColors[.normal]
  }

  private func supportingLabelColor(for state: UIControl.State) -> UIColor? {
    supportingLabelColors[state] ?? supportingLabelColors[.normal]
  }

  private func titleLabelColor(for state: UIControl.State) -> UIColor? {
    titleLabelColors[state] ?? titleLabelColors[.normal]
  }

  private func trailingLabelColor(for state: UIControl.State) -> UIColor? {
    trailingLabelColors[state] ?? trailingLabelColors[.normal]
  }

  private func tintColor(for state: UIControl.State) -> UIColor? {
    tintColors[state] ?? tintColors[.normal]
  }
}

// MARK: - UIControl.editingChanged
@available(iOS 13.0, *)
extension M3CTextField {
  @objc private func textFieldEditingChanged(textField: UITextField) {
    // `clearButton` has lower priority than any other non-nil `rightView` value.
    // A non-nil `rightView` value should not be replaced by `clearButton`.
    // Return early if `rightView` is any value other than `clearButton`.
    // This guard also ensures that the clear button is not re-set if it is already `rightView`.
    guard rightView == nil || rightView == clearButton else {
      return
    }

    let textCount = textField.text?.count ?? 0

    if textCount > 0, let clearButton {
      rightView = clearButton
      // rightView should not be set to nil unless it is the clearButton.
    } else if textCount == 0 && rightView == clearButton {
      rightView = nil
    }
  }
}

// MARK: - UITraitEnvironment

@available(iOS 13.0, *)
extension M3CTextField {
  override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    // It is necessary to update the border's CGColor when changing between Light and Dark modes.
    if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      applyBorderColor()
    }
  }
}

// MARK: M3CInsetTextField

@available(iOS 13.0, *)
extension M3CTextField {
  /// A UITextField subclass created for the purpose of overriding its rect and
  /// firstResponder implementations.
  private final class M3CInsetTextField: UITextField {
    var firstResponderChangeHandler: (() -> Void)?

    /// These overrides are used to track `isFirstResponder`, which represents selection state.

    override func becomeFirstResponder() -> Bool {
      let didBecomeFirstResponder = super.becomeFirstResponder()

      if didBecomeFirstResponder {
        firstResponderChangeHandler?()
      }

      return didBecomeFirstResponder
    }

    override func resignFirstResponder() -> Bool {
      let didResignFirstResponder = super.resignFirstResponder()

      if didResignFirstResponder {
        firstResponderChangeHandler?()
      }

      return didResignFirstResponder
    }

    /// These overrides add padding to the text field without using a height constraint.
    ///
    /// The text field is able to grow and shrink based on its font size.

    static let horizontalPaddingValue: CGFloat = 12.0
    static let verticalPaddingValue: CGFloat = 8.0

    var padding: UIEdgeInsets {
      let isRightToLeft =
        UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
        || traitCollection.layoutDirection == .rightToLeft
      let leftPadding = isRightToLeft ? rightView?.bounds.size.width : leftView?.bounds.size.width
      let rightPadding = isRightToLeft ? leftView?.bounds.size.width : rightView?.bounds.size.width
      return UIEdgeInsets(
        top: M3CInsetTextField.verticalPaddingValue,
        left: leftPadding ?? M3CInsetTextField.horizontalPaddingValue,
        bottom: M3CInsetTextField.verticalPaddingValue,
        right: rightPadding ?? M3CInsetTextField.horizontalPaddingValue
      )
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
      let caretRect = super.caretRect(for: position)

      // Only modify caretRect if the caret height is larger than the font's line height.
      guard
        let font,
        caretRect.size.height > font.lineHeight
      else {
        return caretRect
      }

      let yOffset = (caretRect.size.height - font.lineHeight) * 0.5

      return CGRect(
        x: caretRect.origin.x,
        y: caretRect.origin.y + yOffset,
        width: caretRect.size.width,
        height: font.lineHeight
      )
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
  }
}
