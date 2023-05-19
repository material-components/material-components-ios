import UIKit

@available(iOS 13.0, *)
extension UIControl.State: Hashable {
  static let error = UIControl.State(rawValue: 1 << 16)
}
