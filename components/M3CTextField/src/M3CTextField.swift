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

  @objc public var leftViewMode: UITextField.ViewMode {
    get {
      return textContainer.leftViewMode
    }
    set {
      textContainer.leftViewMode = newValue
    }
  }

  @objc public var rightViewMode: UITextField.ViewMode {
    get {
      return textContainer.rightViewMode
    }
    set {
      textContainer.rightViewMode = newValue
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

  // This constant is based on the default font size for UITextField.
  private var defaultTextContainerFont = UIFont.systemFont(ofSize: 17)

  private var symbolConfiguration: UIImage.SymbolConfiguration {
    let font = UIFont.systemFont(ofSize: preferredIconPointSize())
    let configuration = UIImage.SymbolConfiguration(font: font)
    return configuration
  }

  private var backgroundColors: [UIControl.State: UIColor] = [:]
  private var borderColors: [UIControl.State: UIColor] = [:]
  private var inputColors: [UIControl.State: UIColor] = [:]
  private var supportingLabelColors: [UIControl.State: UIColor] = [:]
  private var titleLabelColors: [UIControl.State: UIColor] = [:]
  private var trailingLabelColors: [UIControl.State: UIColor] = [:]
  private var tintColors: [UIControl.State: UIColor] = [:]

  // The initial value is based on the color of the system clear button.
  @objc public var clearButtonTintColor: UIColor = .systemGray3

  @objc public lazy var textContainer: UITextField = {
    let textField = M3CInsetTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.adjustsFontForContentSizeCategory = true
    textField.font = defaultTextContainerFont
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 10.0

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

  /// A custom clear button that indirectly replaces the system clear button when set.
  ///
  /// As of iOS 17.0, a custom clear button is required to meet accessibility requirements.
  /// A minimum contrast ratio of 3:1 is required.
  /// If `clearButton` is not set, the text field will use the default clear button.
  @objc public var clearButton: UIButton?

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
  /// - Parameters:
  ///   - tintColor: The UIColor used to determine the button icon's color. The default value
  ///   matches the system default color.
  @objc(configureClearButtonWithTintColor:)
  public func configureClearButton(tintColor: UIColor) {
    // `clearButtonTintColor` is stored as a property so that the clear button can be reconfigured
    // after `preferredContentSize` changes.
    clearButtonTintColor = tintColor

    let button = buildClearButton(symbolConfiguration: symbolConfiguration, tintColor: tintColor)
    button.translatesAutoresizingMaskIntoConstraints = false
    clearButton = button
    rightView = clearButton
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

  @objc private func didTapClearButton(sender: UIButton) {
    textContainer.text = ""

    textContainer.sendActions(for: .editingChanged)
  }

  private func preferredIconPointSize() -> CGFloat {
    let lowerBound = 19.0
    let upperBound = 36.0

    // Clamp within a size range, to ensure that icons do not shrink too small or grow too large.
    return min(
      max(lowerBound, textContainer.font?.pointSize ?? defaultTextContainerFont.pointSize),
      upperBound
    )
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
    // `clearButton` should never be visible when there is no input text.
    if let clearButton, rightView == clearButton {
      let textCount = textField.text?.count ?? 0
      rightViewMode = textCount > 0 ? rightViewMode : .never
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

    if self.traitCollection.preferredContentSizeCategory
      != previousTraitCollection?.preferredContentSizeCategory
    {
      // It is necessary to rebuild the clear button when changing preferred font sizing.
      if rightView == clearButton {
        configureClearButton(tintColor: clearButtonTintColor)
      }
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

      // Directional edge insets are used to capture the current RTL/LTR context for `leftView`
      // and `rightView`, which directionally respect RTL/LTR for positioning.
      let directionalEdgeInsets = NSDirectionalEdgeInsets(
        top: M3CInsetTextField.verticalPaddingValue,
        leading: leftView?.bounds.size.width ?? M3CInsetTextField.horizontalPaddingValue,
        bottom: M3CInsetTextField.verticalPaddingValue,
        trailing: rightView?.bounds.size.width ?? M3CInsetTextField.horizontalPaddingValue
      )

      var leadingPadding =
        (leftViewMode == .never || leftView?.isHidden ?? true)
        ? M3CInsetTextField.horizontalPaddingValue : directionalEdgeInsets.leading
      var trailingPadding =
        (rightViewMode == .never || rightView?.isHidden ?? true)
        ? M3CInsetTextField.horizontalPaddingValue : directionalEdgeInsets.trailing

      // RTL/LTR must still be checked when creating the insets, since UIEdgeInsets do not
      // respect RTL/LTR context.
      return UIEdgeInsets(
        top: M3CInsetTextField.verticalPaddingValue,
        left: (isRightToLeft ? trailingPadding : leadingPadding),
        bottom: M3CInsetTextField.verticalPaddingValue,
        right: (isRightToLeft ? leadingPadding : trailingPadding)
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
