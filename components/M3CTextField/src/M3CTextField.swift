import UIKit

/// M3CTextField is a container view that provides a pre-configured layout for a text field, its
/// accessory icons, and its associated labels.
@available(iOS 14.0, *)
public final class M3CTextField: UIView {
  /// A text field that represents the primary source of user input and interaction for
  /// this component.
  public private(set) lazy var textField: UITextField = {
    let textField = M3CInsetTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.adjustsFontForContentSizeCategory = true
    textField.clearButtonMode = .whileEditing
    textField.font = UIFont.systemFont(ofSize: 17)
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 10.0
    return textField
  }()

  /// A label with a top leading position that represents title text for a text field.
  public let titleLabel = UILabel()

  /// A label with a bottom leading position that represents supporting and error text for
  /// a text field.
  public let supportingLabel = UILabel()

  /// A label with a bottom trailing position that represents additional supporting text for a
  /// text field, such as character count.
  public let trailingLabel = UILabel()

  /// Initializes a `M3CTextField` with a supporting label, title label, and trailing label.
  public init() {
    super.init(frame: .zero)

    configureStackViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: View Configuration

@available(iOS 14.0, *)
extension M3CTextField {
  private func configureStackViews() {
    titleLabel.setContentHuggingPriority(.required, for: .vertical)
    supportingLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    trailingLabel.setContentCompressionResistancePriority(.required, for: .vertical)

    // Ensure that the trailing label shrinks to fit its content size, and the supporting label
    // stretches to fill the remaining available space.
    // If contentHuggingPriority is equal for both labels, they will distribute available
    // horizontal space equally.
    supportingLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    trailingLabel.setContentHuggingPriority(.required, for: .horizontal)

    let bottomTextViews = [
      supportingLabel,
      trailingLabel,
    ]

    let bottomLabelsHorizontalStack = UIStackView(arrangedSubviews: bottomTextViews)
    bottomLabelsHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
    bottomLabelsHorizontalStack.axis = .horizontal
    bottomLabelsHorizontalStack.alignment = .fill
    bottomLabelsHorizontalStack.distribution = .fill
    bottomLabelsHorizontalStack.spacing = 6.0

    let subviews = [
      titleLabel,
      textField,
      bottomLabelsHorizontalStack,
    ]

    let verticalStackView = UIStackView(arrangedSubviews: subviews)
    addSubview(verticalStackView)

    verticalStackView.translatesAutoresizingMaskIntoConstraints = false
    verticalStackView.alignment = .center
    verticalStackView.distribution = .fill
    verticalStackView.axis = .vertical
    verticalStackView.spacing = 6.0

    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 6),
      textField.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
      textField.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
      bottomLabelsHorizontalStack.leadingAnchor.constraint(
        equalTo: verticalStackView.leadingAnchor, constant: 6),
      verticalStackView.topAnchor.constraint(equalTo: topAnchor),
      verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44.0),
    ])
  }
}

// MARK: M3CInsetTextField

@available(iOS 14.0, *)
extension M3CTextField {
  /// A UITextField subclass created for the sole purpose of overriding its rect implementations.
  ///
  /// These overrides add padding to the text field without using a height constraint.
  ///
  /// The text field is able to grow and shrink based on its font size.
  private final class M3CInsetTextField: UITextField {
    static let horizontalPaddingValue: CGFloat = 12.0
    static let verticalPaddingValue: CGFloat = 8.0

    var padding: UIEdgeInsets {
      return UIEdgeInsets(
        top: M3CInsetTextField.verticalPaddingValue,
        left: (leftView?.bounds.size.width ?? M3CInsetTextField.horizontalPaddingValue),
        bottom: M3CInsetTextField.verticalPaddingValue,
        right: (rightView?.bounds.size.width ?? M3CInsetTextField.horizontalPaddingValue)
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
