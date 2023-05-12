import UIKit

/// M3CTextField is a container view that provides a pre-configured layout for a text field, its
/// accessory icons, and its associated labels.
@available(iOS 13.0, *)
public final class M3CTextField: UIView, M3CTextInput {
  public lazy var textContainer: UITextField = {
    let textField = M3CInsetTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.adjustsFontForContentSizeCategory = true
    textField.clearButtonMode = .whileEditing
    textField.font = UIFont.systemFont(ofSize: 17)
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 10.0
    return textField
  }()

  public lazy var titleLabel: UILabel = buildLabel()

  public lazy var supportingLabel: UILabel = buildLabel()

  public lazy var trailingLabel: UILabel = buildLabel()

  /// Initializes a `M3CTextField` with a supporting label, title label, and trailing label.
  public init() {
    super.init(frame: .zero)

    configureStackViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: M3CInsetTextField

@available(iOS 13.0, *)
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
