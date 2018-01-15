//
//  EditingCollectionViewController.swift
//  MaterialComponentsExamples
//
//  Created by Yarden Eitan on 1/12/18.
//

import UIKit

class EditingCollectionViewController: UIViewController,
                                       UICollectionViewDelegate,
                                       UICollectionViewDataSource {

    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
    var dataSource = [(Int, Bool)]()

    override func viewDidLoad() {
      super.viewDidLoad()
      self.collectionView.frame = self.view.bounds
      self.collectionView.dataSource = self
      self.collectionView.delegate = self
      self.collectionView.register(MDCCollectionViewCardCell.self, forCellWithReuseIdentifier: "Cell")
      self.view.addSubview(self.collectionView)

      for i in 0..<10 {
        dataSource.append((i, false))
      }
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    return cell
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }

  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
  }

}

extension EditingCollectionViewController {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Cards", "Editing Collection Cards (Swift)"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }

  @objc class func catalogIsDebug() -> Bool {
    return false
  }
}
