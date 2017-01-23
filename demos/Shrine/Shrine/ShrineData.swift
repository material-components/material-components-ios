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

class ShrineData {

  var imageNames = NSMutableArray()
  var titles = NSMutableArray()
  var descriptions = NSMutableArray()
  var prices = NSMutableArray()
  var avatars = NSMutableArray()
  var shopTitles = NSMutableArray()
  static var baseURL = "https://www.gstatic.com/angular/material-adaptive/shrine/"

  func readJSON() {

    let filePath = Bundle.main.path(forResource: "products", ofType: "json")
    var json: NSDictionary!
    do {
      let data = try? Data(contentsOf: URL(fileURLWithPath: filePath!))
      let options = JSONSerialization.ReadingOptions()
      json = try JSONSerialization.jsonObject(with: data!, options: options) as? NSDictionary
    } catch _ {
      print("Couldn't get JSON data")
    }

    let products = json["products"] as! NSArray
    for prod in products {
      let product = prod as! NSDictionary
      let imageName = product["image"] as! String
      imageNames.add(imageName)
      let title = product["title"] as! String
      titles.add(title)
      let description = product["description"] as! String
      descriptions.add(description)
      let price = product["price"] as! String
      prices.add(price)
    }

    let shops = json["shops"] as! NSArray
    for shp in shops {
      let shop = shp as! NSDictionary
      let avatar = shop["avatar"] as! String
      avatars.add(avatar)
      let shopTitle = shop["shop"] as! String
      shopTitles.add(shopTitle)
    }
  }
}
