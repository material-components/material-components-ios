// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialDialogs_Theming
import MaterialComponents.MaterialList
import MaterialComponents.MaterialTypographyScheme

class CustomDialogViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  let dialogTitle: String = "Set backup account"
  var userAccounts: [String] = ["user01@gmail.com", "user02@gmail.com"];
  var containerScheme = MDCContainerScheme()
  var userCollectionView : UICollectionView!

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    containerScheme.colorScheme = MDCSemanticColorScheme()
    containerScheme.typographyScheme = MDCTypographyScheme()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    let titleLabel = UILabel()
    titleLabel.text = dialogTitle
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = containerScheme.typographyScheme.headline6
    titleLabel.numberOfLines = 0
    self.view.addSubview(titleLabel)

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = 0
    flowLayout.estimatedItemSize = CGSize(width: 250.0, height: 10.0)

    userCollectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: flowLayout)
    userCollectionView.backgroundColor = UIColor.clear
    userCollectionView.register(MDCSelfSizingStereoCell.self,
                                forCellWithReuseIdentifier: "MDCSelfSizingStereoCell")
    userCollectionView.translatesAutoresizingMaskIntoConstraints = false
    userCollectionView.delegate = self
    userCollectionView.dataSource = self
    self.view.addSubview(userCollectionView)

    let cancelButton = MDCButton()
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.applyTextTheme(withScheme: containerScheme)
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.addTarget(self, action: #selector(dismissDialog), for: .touchUpInside)
    self.view.addSubview(cancelButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: titleLabel,
                         attribute: .left,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .left,
                         multiplier: 1.0,
                         constant: 20.0),
      NSLayoutConstraint(item: titleLabel,
                         attribute: .top,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .top,
                         multiplier: 1.0,
                         constant: 25.0),
      NSLayoutConstraint(item: cancelButton,
                         attribute: .right,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .right,
                         multiplier: 1.0,
                         constant: -10.0),
      NSLayoutConstraint(item: cancelButton,
                         attribute: .bottom,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .bottom,
                         multiplier: 1.0,
                         constant: -15.0),
      NSLayoutConstraint(item: userCollectionView,
                         attribute: .left,
                         relatedBy: .equal,
                         toItem: titleLabel,
                         attribute: .left,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: userCollectionView,
                         attribute: .right,
                         relatedBy: .equal,
                         toItem: cancelButton,
                         attribute: .right,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: userCollectionView,
                         attribute: .top,
                         relatedBy: .equal,
                         toItem: titleLabel,
                         attribute: .bottom,
                         multiplier: 1.0,
                         constant: 30.0),
      NSLayoutConstraint(item: userCollectionView,
                         attribute: .bottom,
                         relatedBy: .equal,
                         toItem: cancelButton,
                         attribute: .top,
                         multiplier: 1.0,
                         constant: -30.0),

      ])
  }

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width:200.0, height:330.0);
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  @objc func dismissDialog() {
    self.dismiss(animated:true)
  }

  // MARK: Collection View Data Source

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userAccounts.count + 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MDCSelfSizingStereoCell",
                                                  for: indexPath) as! MDCSelfSizingStereoCell
    let bundle = Bundle(for: CustomDialogViewController.self)
    if (indexPath.item < 2) {
      cell.leadingImageView.image = UIImage(named: "ic_person", in: bundle, compatibleWith: nil)
      cell.titleLabel.text = userAccounts[indexPath.item]
      cell.titleLabel.font = containerScheme.typographyScheme.body2
    } else {
      cell.leadingImageView.image = UIImage(named: "add_circle", in: bundle, compatibleWith: nil)
      cell.titleLabel.text = "Add account"
      cell.titleLabel.font = containerScheme.typographyScheme.body2
    }
    return cell
  }
}

class DialogsThemedPresentationExampleViewController: UIViewController {

  private let materialButton = MDCButton()
  private let transitionController = MDCDialogTransitionController()
  var containerScheme = MDCContainerScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    materialButton.translatesAutoresizingMaskIntoConstraints = false
    materialButton.setTitle("Custom Alert With Themed Presentation", for: .normal)
    materialButton.sizeToFit()
    materialButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    materialButton.applyTextTheme(withScheme: containerScheme)
    self.view.addSubview(materialButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item:materialButton,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerX,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: materialButton,
                         attribute: .centerY,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerY,
                         multiplier: 1.0,
                         constant: 0.0)
      ])
  }

  @objc func tap(_ sender: Any) {
    let customDialogController = CustomDialogViewController()
    customDialogController.modalPresentationStyle = .custom;
    customDialogController.transitioningDelegate = self.transitionController;

    customDialogController.mdc_dialogPresentationController?.applyTheme(withScheme: containerScheme)
    present(customDialogController, animated: true, completion: nil)
  }
}

extension DialogsThemedPresentationExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Dialog Presentation Controller Theming"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}

