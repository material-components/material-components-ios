//
//  ProductCollectionViewCell.swift
//  BuildingBeautifulApps
//
//  Created by Joel Youngblood on 5/31/17.
//
//

import UIKit
import MaterialComponents.MDCButton

final class ProductCollectionViewCell: UICollectionViewCell {
    
    var product: Product?
    @IBOutlet weak var favoriteButton: MDCButton?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var priceLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favoriteButton?.contentEdgeInsets = .zero
        var image = self.favoriteButton?.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
        self.favoriteButton?.setImage(image, for: .normal)
        image = self.favoriteButton?.image(for: .selected)?.withRenderingMode(.alwaysTemplate)
        self.favoriteButton?.setImage(image, for: .selected)
    }
    
    func set(product: Product) {
        self.product = product
        
        self.imageView?.image = UIImage(contentsOfFile: product.imagePath!)
        self.priceLabel?.text = product.price
        self.favoriteButton?.isSelected = product.isFavorite
    }
    
}
