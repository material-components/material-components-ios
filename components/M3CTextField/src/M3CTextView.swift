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

  private var backgroundColors: [UIControl.State: UIColor] = [:]
  private var borderColors: [UIControl.State: UIColor] = [:]
  private var errorColors: [UIControl.State: UIColor] = [:]
  private var textColors: [UIControl.State: UIColor] = [:]
  private var tintColors: [UIControl.State: UIColor] = [:]

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
  }

  /// Sets the border color for a specific UIControlState.
  @objc(setBorderColor:forState:)
  public func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
    borderColors[state] = color
  }

  /// Sets the text color for a specific UIControlState.
  @objc(setTextColor:forState:)
  public func setTextColor(_ color: UIColor?, for state: UIControl.State) {
    textColors[state] = color
  }

  /// Sets the tint color for a specific UIControlState.
  @objc(setTintColor:forState:)
  public func setTintColor(_ color: UIColor?, for state: UIControl.State) {
    tintColors[state] = color
  }
}

// MARK: M3CTextView Color Configuration

@available(iOS 13.0, *)
extension M3CTextView {
  /// Applies colors for border, background, tint, and text, based on the current state.
  ///
  /// If `isInErrorState` is true, apply colors for .error state.
  ///
  /// If `isInErrorState` is false, and `isFirstResponder` is true, apply colors for the .selected
  /// state.
  ///
  /// If neither is true, apply colors for the .normal state.
  @objc public func applyAllColors() {
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

    let textColor = textColor(for: state)
    textContainer.textColor = textColor
    titleLabel.textColor = textColor
    supportingLabel.textColor = textColor
    trailingLabel.textColor = textColor
  }

  private func borderColor(for state: UIControl.State) -> UIColor? {
    borderColors[state] ?? borderColors[.normal]
  }

  private func backgroundColor(for state: UIControl.State) -> UIColor? {
    backgroundColors[state] ?? backgroundColors[.normal]
  }

  private func tintColor(for state: UIControl.State) -> UIColor? {
    tintColors[state] ?? tintColors[.normal]
  }

  private func textColor(for state: UIControl.State) -> UIColor? {
    textColors[state] ?? textColors[.normal]
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
