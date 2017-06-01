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

final class Product {
    
    var imagePath: String?
    let price: String
    var isFavorite: Bool = false
    
    init() {
        self.price = String(describing: arc4random() % 100)
    }
    
    func isEqual(_ object: Any) -> Bool {
        if let product = object as? Product {
            return product.price == self.price && product.imagePath == self.imagePath && product.isFavorite == self.isFavorite
        }
        
        return false
    }
    
}
