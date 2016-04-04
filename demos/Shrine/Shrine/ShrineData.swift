/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

    let filePath = NSBundle.mainBundle().pathForResource("products", ofType: "json")
    var json: NSDictionary!
    do {
      let data = NSData(contentsOfFile: filePath!)
      json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary
    } catch _ {
      print("Couldn't get JSON data")
    }

    let products = json["products"]
    if let count:Int = products!.count - 1 {
      for i in 0...count {
        let imageName:NSString = products![i]["image"] as! String
        imageNames.addObject(imageName)
        let title:NSString = products![i]["title"] as! String
        titles.addObject(title)
        let description:NSString = products![i]["description"] as! String
        descriptions.addObject(description)
        let price:NSString = products![i]["price"] as! String
        prices.addObject(price)
      }
    }
    let shops = json["shops"]
    if let shopCount:Int = shops!.count - 1 {
      for i in 0...shopCount {
        let avatar:NSString = shops![i]["avatar"] as! String
        avatars.addObject(avatar)
        let shopTitle:NSString = shops![i]["shop"] as! String
        shopTitles.addObject(shopTitle)
      }
    }

  }
}
