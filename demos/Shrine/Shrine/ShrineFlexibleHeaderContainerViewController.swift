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

import UIKit
import MaterialComponents.MaterialFlexibleHeader

class ShrineFlexibleHeaderContainerViewController: MDCFlexibleHeaderContainerViewController {

  init() {
    let layout = UICollectionViewFlowLayout()
    let sectionInset: CGFloat = 10.0
    layout.sectionInset = UIEdgeInsets(top: sectionInset,
                                       left: sectionInset,
                                       bottom: sectionInset,
                                       right: sectionInset)

    if #available(iOS 11.0, *) {
      layout.sectionInsetReference = .fromSafeArea
    }

    let collectionVC = ShrineCollectionViewController(collectionViewLayout: layout)
    super.init(contentViewController: collectionVC)

    collectionVC.headerViewController = self.headerViewController
    collectionVC.setupHeaderView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
