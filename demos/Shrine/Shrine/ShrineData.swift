import UIKit

class ShrineData {

  internal var imageNames:NSMutableArray = NSMutableArray()
  internal var titles:NSMutableArray = NSMutableArray()
  internal var descriptions:NSMutableArray = NSMutableArray()
  internal var prices:NSMutableArray = NSMutableArray()
  internal var avatars:NSMutableArray = NSMutableArray()
  internal var shopTitles:NSMutableArray = NSMutableArray()
  static internal var baseURL:String = "https://www.gstatic.com/angular/material-adaptive/shrine/"

  init() {

  }

  internal func readJSON() {

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
