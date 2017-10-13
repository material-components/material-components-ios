/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

import UIKit

import MaterialComponents.MaterialDialogs

class MDCCatalogDebugSetting {
  init(title: String) {
    self.title = title
  }

  public var title: String
  public var setter: (Bool) -> Void = { _ in }
  public var getter: () -> Bool = { false }
}

class MDCCatalogDebugAlert: UICollectionViewController {
  fileprivate var settings = [MDCCatalogDebugSetting]()

  fileprivate let layout = UICollectionViewFlowLayout()
  fileprivate let dialogTransitionController = MDCDialogTransitionController()

  fileprivate var numberOfRows: Int {
    return settings.count + 1
  }
  fileprivate var dismissCellRow: Int {
    return settings.count
  }

  override var preferredContentSize: CGSize {
    get { return CGSize(width: 400, height: self.numberOfRows * 44) }
    set { super.preferredContentSize = newValue }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(settings: [MDCCatalogDebugSetting]) {
    self.settings = settings

    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0

    super.init(collectionViewLayout: layout)

    self.transitioningDelegate = dialogTransitionController
    self.modalPresentationStyle = .custom
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView?.backgroundColor = UIColor.white
    self.collectionView?.register(MDCCatalogDebugToggleCell.self,
                                  forCellWithReuseIdentifier: "toggle")
    self.collectionView?.register(MDCCatalogDebugDismissCell.self,
                                  forCellWithReuseIdentifier: "dismiss")
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    layout.itemSize = CGSize(width: self.view.frame.width, height: 44)
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.row == self.dismissCellRow {
      return collectionView.dequeueReusableCell(withReuseIdentifier: "dismiss", for: indexPath)
    }
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "toggle", for: indexPath)
    if let cell = cell as? MDCCatalogDebugToggleCell {
      cell.setting = settings[indexPath.row]
    }
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return self.numberOfRows
  }

  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    if indexPath.row == self.dismissCellRow {
      self.dismiss(animated: true, completion: nil)
    }
  }
}

fileprivate class MDCCatalogDebugToggleCell: UICollectionViewCell {
  private var _setting: MDCCatalogDebugSetting?
  var setting: MDCCatalogDebugSetting? {
    get {
      return _setting
    }
    set {
      _setting = newValue
      if let setting = _setting {
        label.text = setting.title
        toggleSwitch.isOn = setting.getter()
      }
    }
  }

  let label = UILabel()
  let toggleSwitch = UISwitch()

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(label)
    contentView.addSubview(toggleSwitch)

    toggleSwitch.addTarget(self, action:#selector(switchToggled(sender:)), for: .touchUpInside)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let width = self.contentView.bounds.width
    let height = self.contentView.bounds.height

    let switchSize = toggleSwitch.sizeThatFits(self.contentView.bounds.size)
    toggleSwitch.frame = CGRect(x: width - switchSize.width - 10,
                                y: (height - switchSize.height)/2.0,
                                width: switchSize.width,
                                height: switchSize.height)

    label.frame = self.contentView.bounds.insetBy(dx: 10, dy: 10)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let paddedSize = CGSize(width: size.width - 10 * 2, height: size.height - 10 * 2)
    return label.sizeThatFits(paddedSize)
  }

  @objc private func switchToggled(sender: UISwitch) {
    if let setting = _setting {
      setting.setter(sender.isOn)
    }
  }
}

fileprivate class MDCCatalogDebugDismissCell: UICollectionViewCell {
  let label = UILabel()

  override var isHighlighted: Bool {
    get {
      return super.isHighlighted
    }
    set {
      super.isHighlighted = newValue
      self.backgroundColor = nil
      if (newValue) {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
      }
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    label.text = "DISMISS"
    label.textAlignment = .center
    contentView.addSubview(label)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    label.frame = self.contentView.bounds.insetBy(dx: 10, dy: 10)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let paddedSize = CGSize(width: size.width - 10 * 2, height: size.height - 10 * 2)
    return label.sizeThatFits(paddedSize)
  }
}
