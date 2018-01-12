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

    let collectionView = UICollectionView()
    var dataSource = [(Int, Bool)]()

    override func viewDidLoad() {
      super.viewDidLoad()
      self.collectionView.frame = self.view.bounds
      self.view.addSubview(self.collectionView)
      self.collectionView.dataSource = self
      self.collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
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
