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

import Foundation
import UIKit

class MDCCatalogTileData: NSObject {

  // Invoke a draw function in @c frame, caching it if necessary in @c image.
  static func drawAndCache(drawFunction: (CGRect) -> Void, frame: CGRect, inout image: UIImage?) {
    let scale = UIScreen.mainScreen().scale
    var needCacheRefreshed:Bool = (image == nil)

    if (!needCacheRefreshed) {
      let pixelSize: CGSize = CGSizeMake(frame.width * scale, frame.height * scale)
      let cachedPixelSize: CGSize = CGSizeMake(image!.size.width * image!.scale,
                                               image!.size.height * image!.scale)
      needCacheRefreshed = (cachedPixelSize != pixelSize)
    }

    if (needCacheRefreshed) {
      UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
      drawFunction(CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
      image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
    }

    image?.drawInRect(frame)
  }
}
