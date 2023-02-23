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

@available(iOS 13.0, *)
@objc(MDCImmersiveFeedViewController)
public class ImmersiveFeedViewController: UIViewController, UICollectionViewDelegateFlowLayout {
  private let defaultNumberOfSections = 0
  private let defaultNumberOfItemsInSection = 0
  private let buttonHorizontalPadding = 6.0
  private let buttonVerticalPadding = 10.0

  /// Provides the user with a way to specify the data source for the immersive feed view
  /// controller.
  @objc public weak var dataSource: ImmersiveFeedViewControllerDataSource? {
    didSet {
      carousel.reloadData()
      carousel.layoutIfNeeded()
    }
  }

  @objc public lazy var carousel = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ParallaxFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.isPagingEnabled = true
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()

  @objc public init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    setUpCollectionView()
  }

  private func setUpCollectionView() {
    carousel.delegate = self
    carousel.dataSource = self

    view.addSubview(carousel)

    NSLayoutConstraint.activate([
      carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      carousel.topAnchor.constraint(equalTo: view.topAnchor),
      carousel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    carousel.reloadData()
    carousel.layoutIfNeeded()
  }
}

// MARK: Public APIs
@available(iOS 13.0, *)
extension ImmersiveFeedViewController {
  /// Allows the user to register a custom cell class with an identifier.
  ///
  /// - Parameters:
  ///   - cellClass: An optional AnyClass variable that allows the user to register a custom cell
  ///     class. Can pass nil to deregister.
  ///   - identifier: The cell's reuse identifier
  public func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
    carousel.register(cellClass, forCellWithReuseIdentifier: identifier)
  }

  /// Provides the user with a UICollectionViewCell that is created based on the identifier and
  /// index path passed in.
  ///
  /// - Parameters:
  ///   - identifier: The cell's reuse identifier
  ///   - indexPath: The IndexPath of the cell.
  /// - Returns: A UICollectionViewCell.
  public func dequeueReusableCell(
    withReuseIdentifier identifier: String, for indexPath: IndexPath
  ) -> UICollectionViewCell {
    return carousel.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
  }
}

@available(iOS 13.0, *)
extension ImmersiveFeedViewController: UICollectionViewDataSource {
  public func collectionView(
    _ collectionView: UICollectionView, numberOfItemsInSection section: Int
  ) -> Int {
    return self.dataSource?.numberOfItems() ?? defaultNumberOfItemsInSection
  }

  public func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    return self.dataSource?.immersiveFeedViewController(cellForItemAt: indexPath)
      ?? UICollectionViewCell()
  }
}
