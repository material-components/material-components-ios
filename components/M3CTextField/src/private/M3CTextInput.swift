import UIKit

/// M3CTextInput is a protocol that provides a pre-configured layout for an enclosed view and its
/// associated labels.
@available(iOS 13.0, *)
public protocol M3CTextInput: UIView {
  associatedtype TextContainer: UIView

  /// A view that represents the primary source of user input and interaction for
  /// this component.
  var textContainer: TextContainer { get }

  /// A label with a top leading position that represents title text associated with
  /// `textContainer`.
  var titleLabel: UILabel { get }

  /// A label with a bottom leading position that represents supporting and error text associated
  /// with `textContainer`.
  var supportingLabel: UILabel { get }

  /// A label with a bottom trailing position that represents additional supporting text associated
  /// with `textContainer`, such as character count.
  var trailingLabel: UILabel { get }
}

// MARK: View Configuration

@available(iOS 13.0, *)
extension M3CTextInput {
  internal func configureStackViews() {
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
    bottomLabelsHorizontalStack.alignment = .fill
    bottomLabelsHorizontalStack.axis = .horizontal
    bottomLabelsHorizontalStack.distribution = .fill
    bottomLabelsHorizontalStack.spacing = 6.0

    let subviews = [
      titleLabel,
      textContainer,
      bottomLabelsHorizontalStack,
    ]

    let verticalStackView = UIStackView(arrangedSubviews: subviews)
    addSubview(verticalStackView)

    verticalStackView.translatesAutoresizingMaskIntoConstraints = false
    verticalStackView.alignment = .center
    verticalStackView.axis = .vertical
    verticalStackView.distribution = .fill
    verticalStackView.spacing = 6.0

    NSLayoutConstraint.activate([
      textContainer.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
      textContainer.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
      bottomLabelsHorizontalStack.leadingAnchor.constraint(
        equalTo: verticalStackView.leadingAnchor, constant: 6.0),
      verticalStackView.topAnchor.constraint(equalTo: topAnchor),
      verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      textContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 44.0),
      titleLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 6.0),
    ])
  }

  internal func buildLabel() -> UILabel {
    let label = UILabel()
    label.adjustsFontForContentSizeCategory = true
    return label
  }
}
