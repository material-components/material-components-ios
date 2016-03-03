import UIKit

class ShrineInkOverlay: UIView, MDCInkTouchControllerDelegate {

  private var inkTouchController:MDCInkTouchController?

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.inkTouchController = MDCInkTouchController(view:self)!
    self.inkTouchController!.addInkView()
    self.inkTouchController!.delegate = self
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

}
