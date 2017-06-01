//
//  ProductStorageHelper.swift
//  BuildingBeautifulApps
//
//  Created by Joel Youngblood on 5/31/17.
//
//

import Foundation

enum ProductCategory: Int {
    case home
    case clothing
    case popsicles
}

func productsFor(category: ProductCategory) -> [Product]? {
    guard let resourcePath: String = Bundle.main.resourcePath else { return nil }
    
    let pngExtension = "png"
    var folderPath = String()
    var files = [String]()
    
    switch category {
    case .popsicles:
        // 16 popsicles
        for _ in 0...16 {
            if let path = Bundle.main.path(forResource: "popsicle", ofType: pngExtension) {
                files.append(path)
            } else {
                print("Couldn't get paths for popsicles")
            }
        }
    case .clothing:
        folderPath = resourcePath + ("/Clothing/")
        if let fileNames = try? FileManager.default.contentsOfDirectory(atPath: folderPath as String) {
            for fileName in fileNames {
                files.append(folderPath + fileName)
            }
        } else {
            print("Couldn't get filepaths for clothing")
        }
    case .home:
        folderPath = resourcePath + ("/Home/")
        if let fileNames = try? FileManager.default.contentsOfDirectory(atPath: folderPath as String) {
            for fileName in fileNames {
                files.append(folderPath + fileName)
            }
        } else {
            print("Couldn't get filepaths for home")
        }
    }
    
    var products = [Product]()
    for path in files {
        let product = Product()
        product.imagePath = path
        products.append(product)
    }
    return products
}
