/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import MaterialComponents

open class MaskedTransitionTypicalUseSwiftExample: UIViewController {

  struct TargetInfo {
    let name: String
    let viewControllerType: UIViewController.Type
    let calculateFrame: ((UIPresentationController) -> CGRect)?
    let autoresizingMask: UIViewAutoresizing
  }
  var targets: [TargetInfo] = []

  var tableView: UITableView!
  override open func viewDidLoad() {
    super.viewDidLoad()

    tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.dataSource = self
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(tableView)

    let rightFab = UIButton(type: .custom)
    rightFab.frame = .init(x: view.bounds.maxX - 100, y: view.bounds.maxY - 100, width: 64, height: 64)
    rightFab.setTitle("+", for: .normal)
    rightFab.titleLabel?.font = UIFont.systemFont(ofSize: 28)
    rightFab.layer.cornerRadius = rightFab.bounds.width / 2
    rightFab.backgroundColor = .orange
    rightFab.addTarget(self, action: #selector(didTapFab), for: .touchUpInside)
    rightFab.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin]
    view.addSubview(rightFab)

    let leftFab = UIButton(type: .custom)
    leftFab.frame = .init(x: 100 - 64, y: view.bounds.maxY - 100, width: 64, height: 64)
    leftFab.setTitle("+", for: .normal)
    leftFab.titleLabel?.font = UIFont.systemFont(ofSize: 28)
    leftFab.layer.cornerRadius = leftFab.bounds.width / 2
    leftFab.backgroundColor = .blue
    leftFab.addTarget(self, action: #selector(didTapFab), for: .touchUpInside)
    leftFab.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
    view.addSubview(leftFab)

    targets.append(.init(name: "Bottom sheet", viewControllerType: ModalViewController.self, calculateFrame: { info in
      let size = CGSize(width: info.containerView!.bounds.width, height: 300)
      return CGRect(x: info.containerView!.bounds.minX,
                    y: info.containerView!.bounds.height - size.height,
                    width: size.width,
                    height: size.height)
    }, autoresizingMask: [.flexibleWidth, .flexibleTopMargin]))

    targets.append(.init(name: "Centered card", viewControllerType: ModalViewController.self, calculateFrame: { info in
      let size = CGSize(width: 200, height: 200)
      return CGRect(x: (info.containerView!.bounds.width - size.width) / 2,
                    y: (info.containerView!.bounds.height - size.height) / 2,
                    width: size.width,
                    height: size.height)
    }, autoresizingMask: [.flexibleLeftMargin, .flexibleTopMargin,
                          .flexibleRightMargin, .flexibleBottomMargin]))

    targets.append(.init(name: "Full screen", viewControllerType: ModalViewController.self, calculateFrame: nil, autoresizingMask: [.flexibleWidth, .flexibleHeight]))

    targets.append(.init(name: "Left card", viewControllerType: ModalViewController.self, calculateFrame: { info in
      return CGRect(x: leftFab.frame.minX - 16, y: leftFab.frame.minY - 200, width: 200, height: 264)
    }, autoresizingMask: [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin]))

    targets.append(.init(name: "Right card", viewControllerType: ModalViewController.self, calculateFrame: { info in
      return CGRect(x: rightFab.frame.maxX - 200, y: rightFab.frame.minY - 200, width: 200, height: 264)
    }, autoresizingMask: [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin]))

    targets.append(.init(name: "Toolbar", viewControllerType: ToolbarViewController.self, calculateFrame: { info in
      guard let containerView = info.containerView else {
        return .zero
      }
      return CGRect(x: 0, y: containerView.bounds.height - 100, width: containerView.bounds.width, height: 100)
    }, autoresizingMask: [.flexibleTopMargin, .flexibleWidth]))

    tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
  }

  func didTapFab(fab: UIView) {
    let target = targets[tableView.indexPathForSelectedRow!.row]
    let vc = target.viewControllerType.init()

    let transition = MDCMaskedTransition(sourceView: fab)
    transition.calculateFrameOfPresentedView = target.calculateFrame
    vc.view.autoresizingMask = target.autoresizingMask
    vc.transitionController.transition = transition

    showDetailViewController(vc, sender: self)
  }

}

extension MaskedTransitionTypicalUseSwiftExample: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return targets.count
  }
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = targets[indexPath.row].name
    return cell
  }
}

private class ToolbarViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let toolbar = UIToolbar(frame: view.bounds)
    toolbar.isTranslucent = false
    toolbar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    toolbar.items = [.init(barButtonSystemItem: .camera, target: self, action: #selector(didTap))]
    view.addSubview(toolbar)
  }

  func didTap() {
    dismiss(animated: true)
  }
}

private class ModalViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))

    let label = UILabel(frame: view.bounds)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In aliquam dolor eget orci condimentum, eu blandit metus dictum. Suspendisse vitae metus pellentesque, sagittis massa vel, sodales velit. Aliquam placerat nibh et posuere interdum. Etiam fermentum purus vel turpis lobortis auctor. Curabitur auctor maximus purus, ac iaculis mi. In ac hendrerit sapien, eget porttitor risus. Integer placerat cursus viverra. Proin mollis nulla vitae nisi posuere, eu rutrum mauris condimentum. Nullam in faucibus nulla, non tincidunt lectus. Maecenas mollis massa purus, in viverra elit molestie eu. Nunc volutpat magna eget mi vestibulum pharetra. Suspendisse nulla ligula, laoreet non ante quis, vehicula facilisis libero. Morbi faucibus, sapien a convallis sodales, leo quam scelerisque leo, ut tincidunt diam velit laoreet nulla. Proin at quam vel nibh varius ultrices porta id diam. Pellentesque pretium consequat neque volutpat tristique. Sed placerat a purus ut molestie. Nullam laoreet venenatis urna non pulvinar. Proin a vestibulum nulla, eu placerat est. Morbi molestie aliquam justo, ut aliquet neque tristique consectetur. In hac habitasse platea dictumst. Fusce vehicula justo in euismod elementum. Ut vel malesuada est. Aliquam mattis, ex vel viverra eleifend, mauris nibh faucibus nibh, in fringilla sem purus vitae elit. Donec sed dapibus orci, ut vulputate sapien. Integer eu magna efficitur est pellentesque tempor. Sed ac imperdiet ex. Maecenas congue quis lacus vel dictum. Phasellus dictum mi at sollicitudin euismod. Mauris laoreet, eros vitae euismod commodo, libero ligula pretium massa, in scelerisque eros dui eu metus. Fusce elementum mauris velit, eu tempor nulla congue ut. In at tellus id quam feugiat semper eget ut felis. Nulla quis varius quam. Nullam tincidunt laoreet risus, ut aliquet nisl gravida id. Nulla iaculis mauris velit, vitae feugiat nunc scelerisque ac. Vivamus eget ligula porta, pulvinar ex vitae, sollicitudin erat. Maecenas semper ornare suscipit. Ut et neque condimentum lectus pulvinar maximus in sit amet odio. Aliquam congue purus erat, eu rutrum risus placerat a."
    label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(label)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  func didTap() {
    dismiss(animated: true)
  }
}
