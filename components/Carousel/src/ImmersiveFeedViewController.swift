// Copyright 2023-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialM3CButton

@available(iOS 14.0, *)
@objc(MDCImmersiveFeedViewController)
public class ImmersiveFeedViewController: UIViewController, UICollectionViewDelegateFlowLayout {
  private let defaultNumberOfSections = 0
  private let defaultNumberOfItemsInSection = 0
  private let buttonHorizontalPadding = 6.0
  private let buttonVerticalPadding = 10.0

  @objc public weak var dataSource: UICollectionViewDataSource? {
    didSet {
      collectionView.reloadData()
      collectionView.layoutIfNeeded()
    }
  }

  public lazy var collectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ParallaxFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.isPagingEnabled = true
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()

  public init() {
    super.init(nibName: nil, bundle: nil)
    setUpCollectionView()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self

    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    collectionView.reloadData()
    collectionView.layoutIfNeeded()
  }
}

@available(iOS 14.0, *)
extension ImmersiveFeedViewController: UICollectionViewDataSource {
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.dataSource?.numberOfSections?(in: collectionView) ?? defaultNumberOfSections
  }

  public func collectionView(
    _ collectionView: UICollectionView, numberOfItemsInSection section: Int
  ) -> Int {
    return self.dataSource?.collectionView(collectionView, numberOfItemsInSection: section)
      ?? defaultNumberOfItemsInSection
  }

  public func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    return self.dataSource?.collectionView(collectionView, cellForItemAt: indexPath)
      ?? UICollectionViewCell()
  }
}

@available(iOS 14.0, *)
extension ImmersiveFeedViewController {
  public func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
    collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    collectionView.reloadData()
    collectionView.layoutIfNeeded()
  }
}
