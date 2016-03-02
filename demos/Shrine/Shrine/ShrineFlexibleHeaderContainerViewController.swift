import UIKit

class ShrineFlexibleHeaderContainerViewController: MDCFlexibleHeaderContainerViewController {

  init() {
    let layout = UICollectionViewFlowLayout();
    let sectionInset:CGFloat = 10.0
    layout.sectionInset = UIEdgeInsetsMake(sectionInset, sectionInset, sectionInset, sectionInset)
    let collectionVC = ShrineCollectionViewController(collectionViewLayout: layout)
    super.init(contentViewController: collectionVC)

    collectionVC.headerViewController = self.headerViewController;
    collectionVC.setupHeaderView();
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
