import UIKit

/// M3CTextView is a container view that provides a pre-configured layout for a text view and
/// its associated labels.
@available(iOS 13.0, *)
public final class M3CTextView: UIView, M3CTextInput {
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

  var backgroundColors: [UIControl.State: UIColor] = [:]
  var borderColors: [UIControl.State: UIColor] = [:]
  var inputColors: [UIControl.State: UIColor] = [:]
  var supportingLabelColors: [UIControl.State: UIColor] = [:]
  var titleLabelColors: [UIControl.State: UIColor] = [:]
  var trailingLabelColors: [UIControl.State: UIColor] = [:]
  var tintColors: [UIControl.State: UIColor] = [:]

  @objc public lazy var textContainer: UITextView = {
    let textContainer = M3CSelectableTextView()
    textContainer.translatesAutoresizingMaskIntoConstraints = false
    textContainer.adjustsFontForContentSizeCategory = true
    textContainer.font = UIFont.systemFont(ofSize: 17)
    textContainer.layer.borderWidth = 1.0
    textContainer.layer.cornerRadius = 10.0
    textContainer.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    // When firstResponder status changes, apply all colors associated with the resulting
    // UIControlState.
    textContainer.firstResponderChangeHandler = { [weak self] in
      self?.applyAllColors()
    }

    return textContainer
  }()

  /// Proxy property for the underlying text view's `delegate` property.
  @objc public var delegate: UITextViewDelegate? {
    get {
      return textContainer.delegate
    }
    set {
      textContainer.delegate = newValue
    }
  }

  /// Proxy property for the underlying text view's `text` property.
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

  /// Initializes a `M3CTextView` with a supporting label, title label, and trailing label.
  public init() {
    super.init(frame: .zero)

    configureStackViews()
    textContainer.setContentHuggingPriority(.defaultLow, for: .vertical)
    textContainer.setContentCompressionResistancePriority(.required, for: .vertical)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Sets the background color for a specific UIControlState.
  @objc(setBackgroundColor:forState:)
  public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
    backgroundColors[state] = color
    if state == controlState {
      applyAllColors()
    }
  }

  /// Sets the border color for a specific UIControlState.
  @objc(setBorderColor:forState:)
  public func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
    borderColors[state] = color
    if state == controlState {
      applyAllColors()
    }
  }

  /// Sets the input color for a specific UIControlState.
  @objc(setInputColor:forState:)
  public func setInputColor(_ color: UIColor?, for state: UIControl.State) {
    inputColors[state] = color
    if state == controlState {
      applyAllColors()
    }
  }

  /// Sets the supporting label color for a specific UIControlState.
  @objc(setSupportingLabelColor:forState:)
  public func setSupportingLabelColor(_ color: UIColor?, for state: UIControl.State) {
    supportingLabelColors[state] = color
    if state == controlState {
      applyAllColors()
    }
  }

  /// Sets the tint color for a specific UIControlState.
  @objc(setTintColor:forState:)
  public func setTintColor(_ color: UIColor?, for state: UIControl.State) {
    tintColors[state] = color
    if state == controlState {
      applyAllColors()
    }
  }

  /// Sets the title label color for a specific UIControlState.
  @objc(setTitleLabelColor:forState:)
  public func setTitleLabelColor(_ color: UIColor?, for state: UIControl.State) {
    titleLabelColors[state] = color
    if state == controlState {
      applyAllColors()
    }
  }

  /// Sets the trailing label color for a specific UIControlState.
  @objc(setTrailingLabelColor:forState:)
  public func setTrailingLabelColor(_ color: UIColor?, for state: UIControl.State) {
    trailingLabelColors[state] = color
    if state == controlState {
      applyAllColors()
    }
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    hideEmptyLabels()
  }
}

// MARK: M3CTextView Color Configuration

@available(iOS 13.0, *)
extension M3CTextView {
  /// Applies colors for border, background, labels, tint, and text, based on the current state.
  @objc public func applyAllColors() {
    applyColors(for: controlState)
    if isInErrorState {
      applyColors(for: .error)
    } else if textContainer.isFirstResponder {
      applyColors(for: .selected)
    } else {
      applyColors(for: .normal)
    }
  }

  /// Applies border color based on the current state.
  ///
  /// This is necessary when transitioning between Light Mode and Dark Mode, because
  /// `layer.borderColor` is a CGColor.
  private func applyBorderColor() {
    if isInErrorState {
      textContainer.layer.borderColor = borderColor(for: .error)?.cgColor
    } else if textContainer.isFirstResponder {
      textContainer.layer.borderColor = borderColor(for: .selected)?.cgColor
    } else {
      textContainer.layer.borderColor = borderColor(for: .normal)?.cgColor
    }
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

// MARK: - UITraitEnvironment

@available(iOS 13.0, *)
extension M3CTextView {
  override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    // It is necessary to update the border's CGColor when changing between Light and Dark modes.
    if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      applyBorderColor()
    }
  }
}

// MARK: M3CSelectableTextView

@available(iOS 13.0, *)
extension M3CTextView {
  /// A UITextView subclass created for the purpose of overriding its firstResponder
  /// implementations.
  private final class M3CSelectableTextView: UITextView {
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
  }
}
