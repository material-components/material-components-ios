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
import MaterialComponents

final class ProductGridViewController : MDCCollectionViewController {
    
    var isHome = false
    var products = [Product]()
    
    @IBOutlet weak var headerContentView: HomeHeaderView?
    @IBOutlet weak var shrineLogo: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, self.tabBarController!.tabBar.bounds.size.height, 0)
        
        styler.cellStyle = .card
        styler.cellLayoutType = .grid
        styler.gridPadding = 8
        
        updateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLayout()
    }
    
    func updateLayout() {
        styler.gridColumnCount = 1
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: Target / Action
    func favoriteButtonDidTouch(_ sender: UIButton) {
        let product = self.products[sender.tag]
        product.isFavorite = !product.isFavorite
        collectionView?.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
    }
}

//MARK: Collection View delegate
extension ProductGridViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        let product = self.products[indexPath.item]
        cell.set(product: product)
        
        cell.favoriteButton?.tag = indexPath.item
        if !cell.favoriteButton!.allTargets.contains(self) {
            cell.favoriteButton?.addTarget(self, action: #selector(favoriteButtonDidTouch(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellHeightAt indexPath: IndexPath) -> CGFloat {
        let base = (collectionView.bounds.size.width - CGFloat((styler.gridColumnCount + 1) * styler.gridColumnCount))
        let adjustment = CGFloat(5.0/4.0) / CGFloat(styler.gridColumnCount)
        let height = base * adjustment
        return height
    }
}
