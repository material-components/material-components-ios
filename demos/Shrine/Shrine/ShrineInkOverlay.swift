import UIKit

class ShrineInkOverlay: UIView, MDCInkTouchControllerDelegate {

  private var inkTouchController:MDCInkTouchController?

  override init(frame: CGRect) {
    super.init(frame: frame)
    let cyan = UIColor(red: 22 / 255, green: 240 / 255, blue: 240 / 255, alpha: 0.2)
    self.inkTouchController = MDCInkTouchController(view:self)!
    self.inkTouchController!.addInkView()
    self.inkTouchController?.inkView.inkColor = cyan
    self.inkTouchController!.delegate = self
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

}
