/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
 
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

import Foundation

enum ProductCategory: Int {
    case home
    case clothing
    case popsicles
}

func productsFor(category: ProductCategory) -> [Product] {
    
    let resourcePath = Bundle.main.resourcePath!
    let pngExtension = "png"
    var folderPath = String()
    var files = [String]()
    
    switch category {
    case .popsicles:
        // 16 popsicles
        for _ in 0...16 {
            if let path = Bundle.main.path(forResource: "popsicle", ofType: pngExtension) {
                files.append(path)
            }
        }
    case .clothing:
        folderPath = resourcePath + ("/Clothing/")
        if let fileNames = try? FileManager.default.contentsOfDirectory(atPath: folderPath as String) {
            for fileName in fileNames {
                files.append(folderPath + fileName)
            }
        }
    case .home:
        folderPath = resourcePath + ("/Home/")
        if let fileNames = try? FileManager.default.contentsOfDirectory(atPath: folderPath as String) {
            for fileName in fileNames {
                files.append(folderPath + fileName)
            }
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
