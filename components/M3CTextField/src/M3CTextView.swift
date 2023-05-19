import UIKit

/// M3CTextView is a container view that provides a pre-configured layout for a text view and
/// its associated labels.
@available(iOS 13.0, *)
public final class M3CTextView: UIView, M3CTextInput {
  @objc public lazy var textContainer: UITextView = {
    let textContainer = UITextView()
    textContainer.translatesAutoresizingMaskIntoConstraints = false
    textContainer.adjustsFontForContentSizeCategory = true
    textContainer.font = UIFont.systemFont(ofSize: 17)
    textContainer.layer.borderWidth = 1.0
    textContainer.layer.cornerRadius = 10.0
    textContainer.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
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
}
