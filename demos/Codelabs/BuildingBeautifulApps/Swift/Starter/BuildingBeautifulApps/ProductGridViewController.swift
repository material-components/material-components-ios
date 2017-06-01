//
//  ViewController.swift
//  BuildingBeautifulApps
//
//  Created by Joel Youngblood on 5/31/17.
//
//

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
    
    func updateLayout() {
        styler.gridColumnCount = 1
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func favoriteButtonDidTouch(_ sender: UIButton) {
        let product = self.products[sender.tag]
        product.isFavorite = !product.isFavorite
        collectionView?.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
    }

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
        return collectionView.bounds.size.width - CGFloat((styler.gridColumnCount + 1) * (styler.gridColumnCount * 5/4) / styler.gridColumnCount)
    }
    
}

